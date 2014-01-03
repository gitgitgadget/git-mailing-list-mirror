From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] completion: fix remote.pushdefault
Date: Fri, 03 Jan 2014 13:21:07 -0800
Message-ID: <xmqqy52wlq2k.fsf@gitster.dls.corp.google.com>
References: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
	<1388779022-14536-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 22:22:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzCBw-0003Co-Gf
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 22:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbaACVVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 16:21:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbaACVVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 16:21:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 821E45FE5E;
	Fri,  3 Jan 2014 16:21:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5izf1VQRUFtM9sCaHwOX8qLXfXs=; b=G4QeB9
	4iYXejWFiuO/AwPYIywQiLScBk0FC6T5LVDWTWm/xmPDYBfSTXcOFgOP07ozdB1W
	F9NKVXAY/R3Wm0z7l/smSabFGXy55+Oj+NzkYQqZ8MzuyN/JoT2sxl6UH0l/USAy
	gidMiH3EAh+TKz5YH6gnUq6WFKyKkPo3IEh8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hxM8UgeD/OKRioWZ9HuHt2NkLR4PUUP9
	YUVZLtsWWcT4jB2jzJ0VEUY1YavB3BM5pOOlPHMUmJNar8cgxzzCXywaeOWC/B1b
	PnGEVloESImQhx6pnEclGFmMCC8ytsFgX32eSIl3yG8fxkeoQmuyviFGuFnzzzWc
	+ozPd11Gyyc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 490235FE5D;
	Fri,  3 Jan 2014 16:21:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 162715FE4C;
	Fri,  3 Jan 2014 16:21:18 -0500 (EST)
In-Reply-To: <1388779022-14536-5-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 4 Jan 2014 01:27:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FC8CADE4-74BC-11E3-8243-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239939>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> When attempting to complete
>
>   $ git config remote.push<TAB>
>
> 'pushdefault' doesn't come up. This is because "$cur" is matched with
> "remote.*" and a list of remotes are completed. Add 'pushdefault' to the
> list of remotes using __gitcomp_nl_append ().

"Add ... to the list of remotes" (same for "list of branches" in
3/4) sounds somewhat funny, doesn't it?  How about

	Add remote.pushdefault as a candidate for completion, too.

or something like that instead?

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 75c7302..345ceff 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1883,6 +1883,7 @@ _git_config ()
>  	remote.*)
>  		local pfx="${cur%.*}." cur_="${cur#*.}"
>  		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
> +		__gitcomp_nl_append "pushdefault" "$pfx" "$cur_"
>  		return
>  		;;
>  	url.*.*)
