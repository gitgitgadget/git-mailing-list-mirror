Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB1CECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 12:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiH2MNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiH2MNH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 08:13:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3230D3DBE9
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 04:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661774199;
        bh=jW1jpFUJvfXVBXtwHZ9Sgycsn9BY1kO2lcT+OpDfGlk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DTa8C6Z0cdGTPx2aFjOC/jB3DoF23m2/Da03x10/cphlMO9LxNBDVwIUaQ8+bLdnu
         CqsAFZyrm0KPa52sOD2TCWjegiXoVOplExXFBlWUxALh5uwE/xlaTLL1vzD9tzbTha
         EIlLdWYbYJ/pG3PiBeKWPB3aKVHFGOkXvMRtImgE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QWA-1oX2r63byC-004PXf; Mon, 29
 Aug 2022 13:32:28 +0200
Date:   Mon, 29 Aug 2022 13:32:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] pretty: separate out the logic to decide the use of
 in-body from
In-Reply-To: <20220826213203.3258022-2-gitster@pobox.com>
Message-ID: <08p469q7-2os4-p391-9nr4-10q7o9s4414s@tzk.qr>
References: <20220826213203.3258022-1-gitster@pobox.com> <20220826213203.3258022-2-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y1x7ZXu+XqZZ4EsSR0TNk7I+HfWDIQpvQ5F8NZrNDK5aF9VoEPX
 MtjzOJ2kjMpQQVjy6JLNVHu/AXl4WKwGPgfCA2vOQIoSKywWuChiG7C9TwA4sPiwBW2X2Ul
 jysrDbbLXAGCmBD/xeEQwbvgu2F2NNa1AeNc+yOJ0yptTVKLmRFdghsc8wJRgrcdGli1lBN
 U95bZXs4yXIhBP5O54Dmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xmTHzaY5CVM=:scOX0GKpTf3UFkc+t939ak
 yhEfzPfuLqc2aME1uXVZoornbXNCtSq2ClLhdA9E0/FEc6mJg/ArTZ05cinj35dHgTMgUU7JX
 91aPVKbO5IuQilQCkoo7tCq/S7pBN7v+E5DgxwWdZiuf41bxQgpLW3RrTSUF8VqPgZ4dG0pwf
 ARcjP3jdyG5zdJMH6a15zj3jtpW5Fxk0rCYmJAWysTxReMkfy5bWu4MWEGLqs6C3+/YO2I4c9
 O7+N4zwfP6BdPBlEOs8jcUGMyOgotQvtFYMFzUJV9HjpxdsF/sjl2+o5O2OQ8NtwF50sFlBv2
 fxTV29VdduVAOUs0IvdSiqim+HV16Jf/iUH41Fp7Can2mYNygn5D7G0N3Lse7KQGN4pWP9ZJe
 WzztBYc6Ezoq8QOxI9egFemBKt/BzBL0EsK+PriR6uzau0alMnneUSEArEDXusm2M8bA3V2am
 66JDmky7sFhSbQPdP/OUCqAIQ4yizZpMnZws/VbrarjZFa3E1YqQT7uTp/x33IFqL+jt09DS1
 DCruPEkV6XPUZBOa0MJGQuXJT/GCE7uyXV3F1R9OV3rQ5AtJbq1mIHNyUqSP95AJQr4sO7f0F
 YRU1WFTfKdRIpyFavkvTRCjH659PK75vHic9DYiVOtPAqBs/EXMVmFjMm3OAGDqbICSzYqLKi
 uXTdEIqzj0MMohTithvUCy1OqWBbCMYh59h/b+sKfI5LdK7kREF2zGNVXSpcg7lHsBjhmhgn+
 i8tgv3aU+5ckefB0GZkJUmZVic0aBhwytGjcG3B2qCIIxLdnflav24ps93b7j3ilmBs+nS4Li
 u9ZW4UN91ycuoym6LE0nEVyV0+CH/uqiGKPuYjwfqyUbc2qFvDSe+wFNca+oCACRLYm0dzjqT
 iiTuBLk+yj5HgKpHiVKDdJTxA1xKg9VAyvi5LQONT/C0fbXYQVaWJGaH1GuFEGXHMc43iQFzK
 K8Q0Prm8c0NGE1Mx3pl/gishpsMLMBr3j3/dY/6vmPGtG7xeJmIQpXZE31Fgy+EwySrbtafgo
 hQ7UOdiX5zxreJTsGx5KTARVNQVV7xOd97jzudW75uPUfcrAj+lknGZL/cQJoDNUWadIVgiNw
 /tvY4VJrXOrhvSve4qsbvX5lbTzw01DDUsoBjXgdKn+5vPxtlugDVnvlw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 26 Aug 2022, Junio C Hamano wrote:

> When pretty-printing the log message for a given commit in e-mail
> format (e.g. "git format-patch"), we add in-body "From:" header when
> the author identity of the commit is different from the identity of
> the person who is "sending" the mail.

The quotes around "sending" made me stumble over this a bit. Maybe replace
it by saying "the person running the command"?

> Split out the logic into a helper function.  Because the "from_ident
> must be set" condition is there not because it is used in the
> ident_cmp() next, but because the codepath that is entered when this
> logic says "Yes, you should use in-body from" requires values there
> in from_ident member, so separate it out into an if() statement on
> its own to clarify it.

Even after reading this three times, I had trouble understanding it. I
then consulted the diff and started to grasp what you mean. I have no
good idea how to improve the wording, but maybe you can give it another
go? Or simply state that the condition was untangled a bit.

The diff looks good.

Ciao,
Dscho

P.S.: I do not know how strongly you feel these days about lines longer
than 80 columns, but personally I do not care about this rule, so I am
more than just fine with adding such a line here.

> diff --git a/pretty.c b/pretty.c
> index 6d819103fb..51e3fa5736 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -477,6 +477,15 @@ static void append_line_with_color(struct strbuf *s=
b, struct grep_opt *opt,
>  	}
>  }
>
> +static int use_inbody_from(const struct pretty_print_context *pp, const=
 struct ident_split *ident)
> +{
> +	if (!pp->from_ident)
> +		return 0;
> +	if (ident_cmp(pp->from_ident, ident))
> +		return 1;
> +	return 0;
> +}
> +
>  void pp_user_info(struct pretty_print_context *pp,
>  		  const char *what, struct strbuf *sb,
>  		  const char *line, const char *encoding)
> @@ -503,7 +512,7 @@ void pp_user_info(struct pretty_print_context *pp,
>  		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
>
>  	if (cmit_fmt_is_mail(pp->fmt)) {
> -		if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
> +		if (use_inbody_from(pp, &ident)) {
>  			struct strbuf buf =3D STRBUF_INIT;
>
>  			strbuf_addstr(&buf, "From: ");
> --
> 2.37.2-587-g47adba97a9
>
>
