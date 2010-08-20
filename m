From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] grep -A/-B/-Cinfinity to get full context
Date: Fri, 20 Aug 2010 19:02:09 +0530
Message-ID: <20100820133206.GD9448@kytes>
References: <201008180854.18474.ComputerDruid@gmail.com>
 <m362z6pact.fsf@localhost.localdomain>
 <AANLkTinQZxpLdFiCFH3kDTFVQ-ZLjJ1PEdmmsJSb=0YD@mail.gmail.com>
 <201008201122.09392.jnareb@gmail.com>
 <20100820115527.GR10407@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>,
	computerdruid <computerdruid@gmail.com>, joey <joey@kitenet.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 15:34:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRjZ-0007H5-Ca
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab0HTNeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 09:34:04 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48993 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab0HTNeC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:34:02 -0400
Received: by pwi7 with SMTP id 7so1018347pwi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KeHihzPzplF9h7CkUVo/SqATxwf2hv7SXxzMYOUoUjM=;
        b=IKBldzRjfSBW5P/jdKeFOU/0PfKs0IyWZaJyln0N610JhHxNKzoIbSzz8xbuici10B
         psQt67QqcObNp0VbuQlPOh4Q/ClVrEIPH+HVXFuwnC/mXx4Mp0sB94gKO9WUeul9luX9
         jIgPXf7X9/9VY+d23jjbrLA8NXHgJ2svEZ6y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BIPpEtZivhZZOxQ8DPQsYgCsd5//P48KehVUZgeVppA2JK2+t54IicsDRXkTnhpzJH
         E4BVINa1YEWOaJyBWMVVnK4REBQ/3Vvsaow4IuW1YDtTpNYjrAG9NyeoaHjPiHRX5cMQ
         GEDE8v2qfwY4ufzOP+uE1INbQAjm/1szXjKZc=
Received: by 10.142.154.11 with SMTP id b11mr1101866wfe.168.1282311242181;
        Fri, 20 Aug 2010 06:34:02 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id v38sm3260635wfh.0.2010.08.20.06.33.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 06:34:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820115527.GR10407@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154034>

Hi Jonathan,

Jonathan Nieder writes:
> Just a proof of concept.
>=20
> Cc: Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Elegant. OPT_INTEGER for integers without the ability to represent
infinity, and OPT_INT_INF for integers with definite representation
for infinity.

> diff --git a/Documentation/technical/api-parse-options.txt b/Document=
ation/technical/api-parse-options.txt
> index 312e3b2..f152a3f 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -160,6 +160,12 @@ There are some macros to easily define options:
>  	Introduce an option with integer argument.
>  	The integer is put into `int_var`.
> =20
> +`OPT_INT_INF(short, long, &int_var, inf_val, description)`::
> +	Introduce an option with integer argument.
> +	The integer is put into `int_var`.  If the special value
> +	"inf" (or "infinity") is used as an argument, then `inf_val`
> +	is put into `int_var`.

Nice. You're making the caller pass the `inf_val` argument - this way,
each caller can figure out some integer that's outside its sane range
and use that to represent infinity.

> -		OPT_INTEGER('B', NULL, &opt.pre_context,
> +		OPT_INT_INF('B', NULL, &opt.pre_context, -1,
>  			"show <n> context lines before matches"),
> -		OPT_INTEGER('A', NULL, &opt.post_context,
> +		OPT_INT_INF('A', NULL, &opt.post_context, -1,
>  			"show <n> context lines after matches"),
>  		OPT_NUMBER_CALLBACK(&opt, "shortcut for -C NUM",
>  			context_callback),

=46or many cases, -1 is probably a good value to choose.

> diff --git a/parse-options.h b/parse-options.h
> index 7435cdb..6ae041a 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -126,6 +126,9 @@ struct option {
>  #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v),=
 (a), (h) }
>  #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v)=
, NULL, \
>  				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
> +#define OPT_INT_INF(s, l, v, i, h) \
> +	{ OPTION_CALLBACK, (s), (l), (v), "n", (h), 0, \
> +	  parse_opt_infinity_cb, (intptr_t)(i) }

Okay, you've used the same character "n" for OPT_INTEGER and OPT_INT_IN=
=46.

Thanks for the pleasant reading.

-- Ram
