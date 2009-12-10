From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool--lib: add diffmerge as a pre-configured
 mergetool option
Date: Wed, 09 Dec 2009 16:08:55 -0800
Message-ID: <7vaaxrn10o.fsf@alter.siamese.dyndns.org>
References: <1260302477-49412-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 01:09:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIWam-00050b-Qe
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 01:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758895AbZLJAI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 19:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758870AbZLJAI7
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 19:08:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758864AbZLJAI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 19:08:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C525B86881;
	Wed,  9 Dec 2009 19:09:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S//C9U83EsFa3QSQQui9+pL90sc=; b=UY6+ZW
	Ao8sDazE/MRa/oQrXKk4Jy5BlYVfInxiGQw8Tdnl/6hdHQUeEJhr2FtEL3KiRKzC
	Jh4oM/PQcAhgzKx2KtVEMJm4egwuWxQXzvM3g5A2SW39RoxeM5jtjcm54+uSqk4L
	B6q2zKbDxYCKPa9/2V6qv3vO0OvoGeGvtpN/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UZgo3duBw0Y7DVNRxiL/HN1Xd19DqzuO
	X4DMDkAPr1j4jW9yWiLS7il+QVWCxsryuD3tqojJ400itvnAsNmFu2cypXDHAwAG
	332Os5KUuU4+UTsriCcb6VFUNLpyZiZlW7HTisHUX3hI+5W9wiPeE4mV8wOpc4Av
	dCMWbMSAG6o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FE088687E;
	Wed,  9 Dec 2009 19:09:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB34B86873; Wed,  9 Dec
 2009 19:08:56 -0500 (EST)
In-Reply-To: <1260302477-49412-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Tue\,  8 Dec 2009 12\:01\:17 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 386533BC-E520-11DE-8A2D-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135006>

Jay Soffian <jaysoffian@gmail.com> writes:

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 5b62785..5b29fef 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -46,7 +46,8 @@ check_unchanged () {
>  valid_tool () {
>  	case "$1" in
>  	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
> -	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis | p4merge)
> +	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis | p4merge | \
> +	diffmerge)
>  		;; # happy
>  	tortoisemerge)
>  		if ! merge_mode; then

As we are in pre-release feature freeze, it doesn't matter very much if I
take this patch now, so I'll let it sit in the list archive for now.

But I have to wonder about the maintainability of this file, if we have to
add every time somebody finds yet another diff/merge backends that could
be used, even a closed-source one.

There are only a handful of entry points that mergetool--lib defines, and
by overriding what should happen when these entry points are called, an end
user should be able to tell mergetool/difftool to use a new backend.

Perhaps it is a better approach to first eject bulk of code for the
backends we currently support under these case statements into separate
files, one per backend, move them to mergetool/ subdirectory in the source
tree, install them as "$(share)/git-core/mergetool/$toolname", and at
runtime source them?  That way, a patch to add a new backend can be as
simple as adding a new file in mergetool/ and doing nothing else.  Also an
end user can privately add support to a new backend much more easily.

Anybody want to try that approach?
