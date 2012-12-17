From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion.bash: update obsolete code.
Date: Sun, 16 Dec 2012 20:54:52 -0800
Message-ID: <7vtxrlnuqr.fsf@alter.siamese.dyndns.org>
References: <1355694602-8771-1-git-send-email-manlio.perillo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 05:55:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkSjS-0000Ud-3N
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 05:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab2LQEy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 23:54:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab2LQEyz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 23:54:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF22A7C3;
	Sun, 16 Dec 2012 23:54:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bk96s9VxyvTsrIEmeAEZzEcpBmo=; b=bPd3D1
	ccr4svEDWem4RM0ozC1GR1mROIQ8+DRgHASVruhRam0+WwtlxW1ixQaY6kE9rK/9
	4F23EFtyewBE6M/v3uZLrB1ce5yf+r85EZYSj9pxxmwhUgmzpa0fDshtIzSyB1Qv
	yUDu65+pSpvOv6yVrjGlxfCKnkbE03VbHVvQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HRmzH9z+7tSvq5ajTVQXyrc3H/FEt+VY
	9IXOPp5FT/ioW3RcsW1E6I05KlOFdGhZc0OEL8QOsk+dhIrVyVStBwlEFlYQ9QTh
	rRtbKpTpq5Xe0PUBOJgV07Bq/drgdNA88GoHEA+qOSb/9/kQ+VnjTXxtID87rATE
	ZDaiC1SfeQo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45210A7C0;
	Sun, 16 Dec 2012 23:54:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89328A7BF; Sun, 16 Dec 2012
 23:54:54 -0500 (EST)
In-Reply-To: <1355694602-8771-1-git-send-email-manlio.perillo@gmail.com>
 (Manlio Perillo's message of "Sun, 16 Dec 2012 22:50:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6058512-4805-11E2-9009-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211629>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> The git-completion.bash script was using the git ls-tree command
> without the --name-only option, with a sed filter to parse path names;
> use the --name-only option, instead.
>
> Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
> ---

Did you miss the different handling between blobs and trees the
latter gets trailing slash in the completion)?

>  contrib/completion/git-completion.bash | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0b77eb1..85d9051 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -397,20 +397,7 @@ __git_complete_revlist_file ()
>  		*)   pfx="$ref:$pfx" ;;
>  		esac
>  
> -		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
> -				| sed '/^100... blob /{
> -				           s,^.*	,,
> -				           s,$, ,
> -				       }
> -				       /^120000 blob /{
> -				           s,^.*	,,
> -				           s,$, ,
> -				       }
> -				       /^040000 tree /{
> -				           s,^.*	,,
> -				           s,$,/,
> -				       }
> -				       s/^.*	//')" \
> +		__gitcomp_nl "$(git --git-dir="$(__gitdir)" ls-tree --name-only "$ls")" \
>  			"$pfx" "$cur_" ""
>  		;;
>  	*...*)
