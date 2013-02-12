From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: support 'git config --local'
Date: Tue, 12 Feb 2013 09:34:39 -0800
Message-ID: <7vzjz9h1w0.fsf@alter.siamese.dyndns.org>
References: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
 <1360671642-10272-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dasa Paddock <dpaddock@esri.com>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:35:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Jl5-0007LE-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 18:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933552Ab3BLRen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 12:34:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57427 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933329Ab3BLRem (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 12:34:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F067B0C0;
	Tue, 12 Feb 2013 12:34:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZU+RA8wEW+5zYd1biwa/BU8aIg0=; b=XP9Ciz
	XKvRDIQXaP0MIJEcgEx8OPscpDpzfEq/IflP0py7Sf8OtjaF8naSbTNmQbHDhzP0
	VfVpXhnZniA78xT0CFHazHgENm8qtCFd6XB6b3pDsQ78BjbzeSyJkJOufmaCsYrp
	g38hequjdmmXDu+Va3SRfKHKiewKtZ92R+tWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OfhWvxrY43C9MHull79P83yuj/F0lTAm
	SH0DGiQVTRwiValkbe+U3xo1sWXjIxVB95xUHpp1Lt1EwomPRuKXHvOBTUG8Yy1k
	Coi2LxYhCSFayZ8TEzPt0OY/tg8/DK2kUS0MdzHey0on52Y4nAjzudvfbs/7zhE2
	vz62nd2BxUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF33AB0BF;
	Tue, 12 Feb 2013 12:34:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B217B0BA; Tue, 12 Feb 2013
 12:34:41 -0500 (EST)
In-Reply-To: <1360671642-10272-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Tue, 12 Feb 2013 13:20:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B51B6CA-753A-11E2-83E0-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216165>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This needs to be done in two places: __git_config_get_set_variables to
> allow clever completion of "git config --local --get foo<tab>", and
> _git_config to allow "git config --loc<tab>" to complete to --local.
>
> While we're there, change the order of options in the code to match
> git-config.txt.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>> I think this line should include --local:
>> 
>> https://github.com/git/git/blob/next/contrib/completion/git-completion.bash#L1782
>>     "--global|--system|--file=*)"
>> 
>> This would help for:
>>     git config -l --local
>
> Yes, but not only ;-)

I see the second hunk is new.  Comments?

How would this interract with the writing side of "git config"?
"git config --local foo.bar value" and "git config foo.bar value"
are the same, no?

Is it "yes they are the same but it does not hurt?"

>  contrib/completion/git-completion.bash | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 5770b6f..2e1ad67 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1570,7 +1570,7 @@ __git_config_get_set_variables ()
>  	while [ $c -gt 1 ]; do
>  		word="${words[c]}"
>  		case "$word" in
> -		--global|--system|--file=*)
> +		--system|--global|--local|--file=*)
>  			config_file="$word"
>  			break
>  			;;
> @@ -1676,7 +1676,7 @@ _git_config ()
>  	case "$cur" in
>  	--*)
>  		__gitcomp "
> -			--global --system --file=
> +			--system --global --local --file=
>  			--list --replace-all
>  			--get --get-all --get-regexp
>  			--add --unset --unset-all
