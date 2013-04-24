From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: fix quoting in relative_path()
Date: Wed, 24 Apr 2013 09:21:38 -0700
Message-ID: <7vehdzgar1.fsf@alter.siamese.dyndns.org>
References: <cover.1365539059.git.john@keeping.me.uk>
	<cover.1366314439.git.john@keeping.me.uk>
	<cover.1366314439.git.john@keeping.me.uk>
	<6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
	<7vfvyn4g46.fsf@alter.siamese.dyndns.org>
	<20130419074632.GC2278@serenity.lan>
	<7vmwsu31vh.fsf@alter.siamese.dyndns.org> <517199AB.50109@kdbg.org>
	<7vehe6z10t.fsf@alter.siamese.dyndns.org>
	<20130424081536.GT2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:21:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2S2-0004sG-MO
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab3DXQVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:21:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755689Ab3DXQVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:21:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DFDA171C7;
	Wed, 24 Apr 2013 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TEPVNURaWDyFsI8Ir4v/BPLvDTA=; b=huJvgc
	d5TadEx68uq/CmhJRntjfr/CrNCs1roRe9JMU7YVu4UXsHJM5ZKrkJy78BQNRQST
	afxYEEmN8eluE8N2gG0d/VONSV0AktlQ+Ni6dX399pEuGRCq97hhemHQ8XtsdFi0
	bnjDtQJJ9A7BwEE8W62jhGxdUOFjIeNGSjUU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vhIu6ftNg3OCxuTU1JhOnAsKa+IFIr5o
	XKjihxpkSVCfupAB+4NhPPsTup53KNE0rls4AKja2+oy0V9CD2iibcnp23JcL1W+
	TpFzSpvYL5F/7eEUNLA1FAZgEiArfHUyoDcS7rqAmFCrrhiP3C2EFBOXcMnX2961
	wSlHYDPIz78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3225B171C3;
	Wed, 24 Apr 2013 16:21:40 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FCE1171BE;
	Wed, 24 Apr 2013 16:21:39 +0000 (UTC)
In-Reply-To: <20130424081536.GT2278@serenity.lan> (John Keeping's message of
	"Wed, 24 Apr 2013 09:15:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B051FEE-ACFB-11E2-B61E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222258>

John Keeping <john@keeping.me.uk> writes:

>> > Why not just replace the six-liner by this one-liner:
>> >
>> > 		target=${target#"$curdir"/}
>> 
>> Simple enough ;-)
>
> This seems to have arrived on next without this fix, so here's a patch
> on top.
>
>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 0eee703..db9f260 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -127,7 +127,7 @@ relative_path ()
>  	do
>  		case "$target" in
>  		"$curdir/"*)
> -			target=${target#$curdir/}
> +			target=${target#"$curdir"/}
>  			break
>  			;;
>  		esac

J6t meant a patch to remove the entire case...esac and replace it
with a single liner (target=${target#"$curdir"/}).
