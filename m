From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] require_work_tree broken with NONGIT_OK
Date: Mon, 15 Feb 2010 22:46:46 -0800
Message-ID: <7vhbphd6eh.fsf@alter.siamese.dyndns.org>
References: <4B796BF8.7000408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:47:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhHD2-0002kl-Op
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 07:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab0BPGq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 01:46:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab0BPGqz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 01:46:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 589DC9A152;
	Tue, 16 Feb 2010 01:46:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SnbKyKeezRZzOHdC578CcDu324w=; b=UikCq1
	PfndzNxGNkULngcWUNGpzxDkPNNevK/wZRlHR6X0vv6jhF81iM/W3pxfmw8UvqOD
	AXQ4ILK+46Y7FfG0QcHPwYUxeMlKifNurkNcx0cBULNQSWIn4BtVXWYbI+vPvTTT
	gQ55RDrUR6N/xt50talKDb5RT+nBsk/jB/vcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wj3/QMFNxSqNxZHYqMGoaAbzTMZZLDTw
	OI05N0M/K2w70gqngCoZi8aT/q6cAmjz2jUjJDbrSeojpbZTTz1lzyvw6fKsgiVp
	F+iDhTamTizTmgQ9AdLFct0m+hamnI5OPRDBRUZGfO/bwlPMnivFZp3JEz3JqWi2
	Z8q8Es6pf3E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 322109A14F;
	Tue, 16 Feb 2010 01:46:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D9359A14E; Tue, 16 Feb
 2010 01:46:48 -0500 (EST)
In-Reply-To: <4B796BF8.7000408@gmail.com> (Gabriel Filion's message of "Mon\,
 15 Feb 2010 10\:44\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 107AFA8A-1AC7-11DF-ADD5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140074>

Gabriel Filion <lelutin@gmail.com> writes:

> Sourcing git-sh-setup: After having set NONGIT_OK, when calling the
> function require_work_tree while outside of a git repository shows a
> syntax error.
> This is caused by the call to git rev-parse --is-inside-work-tree
> printing nothing when it is called outside of a git repository.
>
> Quoting the call removes the syntax error and sending stderr to
> /dev/null removes duplicate error messages.
> ---

Sign-off?

>
> This is a fixup rollout after discussion on the patch:
>  - Commit message better identifies the cause of the problem
>  - the test was not working in v1. fixed this up
>
>  git-sh-setup.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index d56426d..5e22440 100755
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -128,7 +128,7 @@ cd_to_toplevel () {
>  }
>   require_work_tree () {
> -	test $(git rev-parse --is-inside-work-tree) = true ||
> +	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
>  	die "fatal: $0 cannot be used without a working tree."
>  }
>  -- 1.6.6
