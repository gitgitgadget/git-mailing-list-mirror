From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] require_work_tree broken with NONGIT_OK
Date: Sun, 14 Feb 2010 22:38:30 -0800
Message-ID: <7vzl3bj95l.fsf@alter.siamese.dyndns.org>
References: <4B78C4D3.90407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 07:38:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgubT-0002jV-QZ
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 07:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab0BOGii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 01:38:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab0BOGih (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 01:38:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8053D9AC2A;
	Mon, 15 Feb 2010 01:38:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mPNb8CapO48l0A7pFjnVFSjCcsI=; b=rHBR6k
	jExIjPjdY/I2Ap58tSzYTr2SfbyMOa71SLctW5FDtpVxo4eTm/iCRgNJ9BJrfmoJ
	L/cLtqu0tJNBHyewwR8ilVW40uTCjzGviTT8KYVfL2GQg8IM4e9bz2hYBZnIdW+E
	1ns00RLUvfvDbzWY63QWYxI7zPw8QTRIIPG0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oZrem1HTtLl3reXTAeaW+UkQLgOuzMPY
	yAyBGaPoZOhOC569f/kJYxFMr3p+HV/yrqv+TKhxv3YR9pqc0GeiiGXoWM107Ai2
	8frla7jGQAzG5l86d+tSSxeany7v3l3qcDP/De2VV0cqxP2AsxOnxWJIztX2Nw6M
	kVdWRH07uiI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5878B9AC28;
	Mon, 15 Feb 2010 01:38:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A9229AC27; Mon, 15 Feb
 2010 01:38:32 -0500 (EST)
In-Reply-To: <4B78C4D3.90407@gmail.com> (Gabriel Filion's message of "Sun\,
 14 Feb 2010 22\:51\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BDED182C-19FC-11DF-8FB9-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139988>

Gabriel Filion <lelutin@gmail.com> writes:

> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index d56426d..8de2f03 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -128,7 +128,7 @@ cd_to_toplevel () {
>  }
>   require_work_tree () {
> -	test $(git rev-parse --is-inside-work-tree) = true ||

This needs to have dq around it, as "Not a git repository" case we fatal
out without any output, like this:

	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||


> +	test git rev-parse --is-inside-work-tree >/dev/null 2>&1 ||

I don't think this would ever work with "test" at the beginning.

>  	die "fatal: $0 cannot be used without a working tree."
