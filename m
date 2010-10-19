From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] builtins: check for startup_info->help, print and
 exit early
Date: Tue, 19 Oct 2010 12:55:20 -0500
Message-ID: <20101019175520.GD25139@burratino>
References: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
 <1287495320-27278-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 19:59:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8GSw-0006q8-6m
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 19:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab0JSR7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 13:59:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38139 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab0JSR7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 13:59:06 -0400
Received: by pzk3 with SMTP id 3so482573pzk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BrcHKFOWKiNawEnBHzzz102dFDjMzXTbC/VcY0EFnm8=;
        b=KJTrkGOEf0f2afC3N3+2u0wwCREiCgVi2YfqYCKLs2vPlY34KmlnCJvLjfMiSmZ3a/
         mvFA+UyOkmJeTwpptUnrmEA1AwgoAYVsHjbfiDFp81vgKxIFgh9MIWmKeRemUbgBfIyB
         1kjinGxQm2eQJBLB995yGVgMenKuJ6S9RvtIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JubZrSNs4nkBq0DPJydfYQzOinKjWF+jBdK50UfxzMSDyAdg8uQJodJ7kO3S+iYo57
         SgFPHzW91luvdzLJ5/XGjzyGUaNMyIKzytYuevbQTqkuvR/BXJmLOva5ARtdu53fPIt3
         JI6oAgaj3LUQRLHAfsbw7fbRSw4SsLh/+CMmQ=
Received: by 10.224.125.134 with SMTP id y6mr1293467qar.52.1287511140176;
        Tue, 19 Oct 2010 10:59:00 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id s28sm10551505qcp.45.2010.10.19.10.58.58
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 10:58:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287495320-27278-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159345>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -667,6 +667,9 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
>  		OPT_END(),
>  	};
> =20
> +	if (startup_info->help)
> +		usage_with_options(builtin_branch_usage, options);
> +
>  	git_config(git_branch_config, NULL);
> =20
>  	if (branch_use_color =3D=3D -1)

One has to work hard to trigger this one.

	git init foo
	cd foo
	>.git/refs/heads/master
	git branch -h

Produces:

	fatal: Failed to resolve HEAD as a valid ref.

> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -241,6 +241,9 @@ int cmd_checkout_index(int argc, const char **arg=
v, const char *prefix)
>  		OPT_END()
>  	};
> =20
> +	if (startup_info->help)
> +		usage_with_options(builtin_checkout_index_usage, builtin_checkout_=
index_options);
> +
>  	git_config(git_default_config, NULL);
>  	state.base_dir =3D "";
>  	prefix_length =3D prefix ? strlen(prefix) : 0;

	git init foo
	cd foo
	>.git/index
	git checkout-index -h

Produces:

	fatal: index file smaller than expected

> --- a/builtin/commit.c
> +++ b/builtin/commit.c

I'm stopping here.  But maybe some test cases like this would make the
series clearer.

Hope that helps,
Jonathan
