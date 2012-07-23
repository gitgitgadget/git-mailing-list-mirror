From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Make sure to use Araxis' "compare" and not e.g.
 ImageMagick's
Date: Mon, 23 Jul 2012 09:50:27 -0700
Message-ID: <7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFB19.6010905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 18:50:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StLq8-00018Q-AT
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 18:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442Ab2GWQua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 12:50:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754438Ab2GWQua (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 12:50:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95AD968BC;
	Mon, 23 Jul 2012 12:50:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=erQy+JggvsPM6a2v3nJuIxaWLrg=; b=dsc5tp
	7xWqdFOB/W3nnfnGSVTauNEULK4rhtcO7z0t2h+2E4c1dHEk1kZdEQUgxpgpQlei
	WvsNlCbcQPbAG0Sk6VxvaTp1LBTsTvluI4VvA/Cn7Tjw9XNKmSf1gV2fHLHP62GH
	TU2TMuWwdMSFowoTxwiLhv6/WoBV4Mf8NKvrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rP76S3dS7VhZrgHoIbp8aOW2PZSMGPFW
	rXlbfGuYK0k9zmISXd4mvAqN9QQH8XIarV5HZ3ZgWilJQ4CeaX9K759jtyfsFFW/
	jogbUvSCIDw6j+/eTMIluOdidHXm0e3x5V9+0wHyL2P1MEJvYKTejGeRVCxbT4YH
	MkI/oDXQIDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83B8F68BB;
	Mon, 23 Jul 2012 12:50:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB1E068B9; Mon, 23 Jul 2012
 12:50:28 -0400 (EDT)
In-Reply-To: <500CFB19.6010905@gmail.com> (Sebastian Schuberth's message of
 "Mon, 23 Jul 2012 09:19:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8231FFC6-D4E6-11E1-BEA9-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201941>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  mergetools/araxis | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/mergetools/araxis b/mergetools/araxis
> index 64f97c5..aeba1b9 100644
> --- a/mergetools/araxis
> +++ b/mergetools/araxis
> @@ -16,5 +16,11 @@ merge_cmd () {
>  }
>  
>  translate_merge_tool_path() {
> -	echo compare
> +	# Make sure to use Araxis' "compare" and not e.g. ImageMagick's.
> +	if ls "$(dirname "$(which compare)")"/Araxis* >/dev/null 2>&1

Use of "which" in scripts that are meant to be portable is a no-no.
Some platforms would say "compare is /usr/local/bin/compare" instead
of saying "/usr/local/bin/compare".

> +	then
> +		echo compare
> +	else
> +		echo "$1"
> +	fi
>  }
