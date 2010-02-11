From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] git-am: Add command line parameter `--keep-cr`
 passing it to git-mailsplit.
Date: Thu, 11 Feb 2010 15:21:32 -0800
Message-ID: <7vocjvqryb.fsf@alter.siamese.dyndns.org>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
 <1265923579-24900-4-git-send-email-stefan.hahn@s-hahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Fri Feb 12 00:21:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfiM7-0005Qm-LW
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 00:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412Ab0BKXVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 18:21:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775Ab0BKXVs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 18:21:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0134B9948E;
	Thu, 11 Feb 2010 18:21:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZhK2sHGvtPv1I16YFbKR3GjpmAA=; b=aLLpF1JGWi/mTvFgQTUxjC3
	eDy7CryTu+A0IIircfKu4tWrceLzs4Ez267RufYDIPZm4NeVmbdaQYPgDvBRAvws
	Z509NAv1lKcgBmARe/93SBU6zPyvtWW/bFLYCmV4xN/8CP/pS90vIIHGOk2d7Bas
	H9GMT4wQldrLkLP9ZhCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gbJn/puMaV8VoxsktNmuH0Skp5kleTeino/SrN/VoL7j1wYT6
	Y5yv2X4zTsfensiFwaeeHsi1O0NeCHYd17MbwhWWe9Ek9KDC2cPTnxQjX4oOSfE3
	zu6H5j7XGcn1bkE9AHwXzpUE1zooZJePoBHkhHkUDjwHASGYeA4RDZ31NQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1DCF9948D;
	Thu, 11 Feb 2010 18:21:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00E369948B; Thu, 11 Feb
 2010 18:21:33 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 333E731E-1764-11DF-A55D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139641>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

> If applying patches with the following command sequence
>
>    git format-patch --stdout ... | git am ...
>
> in repositories having files with dos and unix line endings
> git-mailsplit, which is called from git-am must be called with
> `--keep-cr` parameter since commit c2ca1d79.

Sorry, I cannot parse this.

Perhaps you meant to have a comma between "git-am" and "must be"?

> +e,keep-cr       pass --keep-cr flag to git-mailsplit for mbox format

This short form -e does not make much sense to me.  Why is it -e, and do
we even need a short form in the first place?

I'd say we should drop it.  We may want to use short-and-sweet 'e' for
something more important and common, and we would regret for letting this
option squat on it later.

Another approach _might_ be to let the user to use --rebasing directly; it
currently is documented as "internal use", but as long as we clearly
specify its semantics and give a synonym that is more sensible than the
current name, it might turn out to be a better option.  I dunno; it might
be doing more than what this new use case may want to do.

> @@ -216,10 +217,12 @@ check_patch_format () {
>  split_patches () {
>  	case "$patch_format" in
>  	mbox)
> -		case "$rebasing" in
> -		'')
> +		case "$rebasing,$keepcr" in
> +		'','')
>  			keep_cr= ;;
> -		?*)
> +		'',t)
> +			keep_cr=--keep-cr ;;
> +		?*,t)
>  			keep_cr=--keep-cr ;;

Did you mean to say:

	case "$r$k" in
        '') keep_cr= ;;
        ?*) keep_cr=--keep-cr ;;
        esac

or even:

	if test -n "$r$k"
        then
        	keep_cr=--keep-cr
	else
        	keep_cr=
	fi
