From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] symbolic-ref: check format of given reference
Date: Sun, 17 Jun 2012 13:55:54 -0700
Message-ID: <7vaa017j51.fsf@alter.siamese.dyndns.org>
References: <4FDE3D7D.4090502@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 22:56:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgMVt-0006zw-Pt
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 22:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab2FQUz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 16:55:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152Ab2FQUz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 16:55:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8DF88B89;
	Sun, 17 Jun 2012 16:55:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JDFCvkwdMdVcguQ7LPP6cEN8syY=; b=T9FkzG
	k4+6WiRsNx22kxu9soaD64fwNadgkIpGpif8hswPidRIbTgJuWA21h5iZmencb47
	ugazkX4eE6hCCgaIWIzXMRoAlVvDENAuVMoQ785IHCZrRyozOvP06qC0SPinFrr9
	63kGrgr9lczWQLv193O1NOfb/PgJgxfRLas14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xE0lPS8IWtewtGggDIdltiBGtwpiSeYw
	IVaXdqd4Tv+yel+mCgSF5RjKio8cxtY73yGJ2ravRz6JAl6XiGgKc2ieMU8sV/wZ
	TWZzi4uluDmUl9O7hXv/5YzU6COrTkzbf+I7LjZ7bGG72PRYzya9yKQ6K34VZ3V8
	0LExqvy6WQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF6018B88;
	Sun, 17 Jun 2012 16:55:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FB228B87; Sun, 17 Jun 2012
 16:55:56 -0400 (EDT)
In-Reply-To: <4FDE3D7D.4090502@elegosoft.com> (Michael Schubert's message of
 "Sun, 17 Jun 2012 22:26:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D584B2CA-B8BE-11E1-88DA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200130>

Michael Schubert <mschub@elegosoft.com> writes:

> This was discussed earlier this year:
>
> http://thread.gmane.org/gmane.comp.version-control.git/189715
>
> What about pointing at non-existing references? Should this
> still be allowed?

How else would you reimplement "checkout --orphan" in your own
Porcelain using symbolic-ref?

>
> Additionally, I had to reindent two lines to make git-am happy
> (indent with spaces).

I doubt that it is needed; the '-' lines show runs of HT followed by
fewer than 8 SP, which should not trigger "indent with spaces".

>  builtin/symbolic-ref.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index 801d62e..22362e0 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -43,16 +43,18 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_default_config, NULL);
>  	argc = parse_options(argc, argv, prefix, options,
> -			     git_symbolic_ref_usage, 0);
> -	if (msg &&!*msg)
> +				git_symbolic_ref_usage, 0);
> +	if (msg && !*msg)
>  		die("Refusing to perform update with empty message");
>  	switch (argc) {
>  	case 1:
>  		check_symref(argv[0], quiet);
>  		break;
>  	case 2:
> +		if (check_refname_format(argv[1], 0))
> +			die("No valid reference format: '%s'", argv[1]);
>  		if (!strcmp(argv[0], "HEAD") &&
> -		    prefixcmp(argv[1], "refs/"))
> +			prefixcmp(argv[1], "refs/"))
>  			die("Refusing to point HEAD outside of refs/");
>  		create_symref(argv[0], argv[1], msg);
>  		break;
