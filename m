Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEC9C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 03:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C22620768
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 03:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSMx2eyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCSDTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:19:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41552 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDTo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 23:19:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so407162plr.8
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 20:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MkgKKY9+ugWNCFPoL7ONZPPPIRfAhP7lgDa5ShuY3QQ=;
        b=GSMx2eypfb5i8BZPQOPdNkWy9iCQYBXMemaVsMIdgVvHP5JcH/m1THMf7DVTa83yLa
         5qy5iZHrHLa6EwJ5s4F1tfHEiTBx5FbbRQ3eSAd3kT+KgD7qGEX+c1uEiSeKSSNJdkMM
         VRfFX8hRuxt9rQL6Xq80J3jX2CNlVUcdTYvi8p6e1gcyeGOCsb5vwTGLYVhKlMeA4+8/
         1DuTI2waEI8zkRc4ONepLo8L8VMiccEZCSuloP0CPkR7JrKj4jMqCCtJbJP8I/nxPnD1
         KzdCJnaLVnowkpOskedeVqpOZFzzw5YESIwR+MP32AHoq2elP7BhshBopr0icTfzFKym
         hf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MkgKKY9+ugWNCFPoL7ONZPPPIRfAhP7lgDa5ShuY3QQ=;
        b=AFr5kztTh/jjj/YKkqdzc+mcr2UJz9DTqMMPOIltl4fmo5ELXZQrNanJ0WeipT96/8
         Nt5AHlRy5ceYzOZ6jqtQUxNfTGO8uhUyoDYRsKGC8orvX4i9WiyA+szS4mYc4IMwOpm+
         AblEpdRSuGxbCF7naVY1Uh2tT3G9E4FpwKHEsm+K3FGFcf+ZjCuCRHlLEDBL0bTXHVAW
         W8NEFT8X9bPgZ8uXPvHG2zoKZuEiFci6zr6Ft3iNKY6nIazdTbdPU1XIfabyqe5kTtmQ
         x4ly/x5Vw0QhBYd6KnI16el/sfX6nt8OeaPcBlY0r3lvh2TKoxFI9sG4kuTdUuwBXVcH
         cp4w==
X-Gm-Message-State: ANhLgQ3MCa2TIJKKHGVDfRDn9D2e+67QjODVolDn9OmYUek6pDeknHFp
        EaCEMODzGcXUXvygV5ZOaniD9O/w
X-Google-Smtp-Source: ADFU+vvfyl9qJ5jscHqvJYdiNQnYQZDCj8uW65jZtQyRl/QUvFTWOhWxjLi1rpK73W+lq9mM+tQ0sA==
X-Received: by 2002:a17:90a:2:: with SMTP id 2mr1587973pja.16.1584587983387;
        Wed, 18 Mar 2020 20:19:43 -0700 (PDT)
Received: from localhost ([2402:800:6375:fbd2:7e82:2a61:6f4a:cfb4])
        by smtp.gmail.com with ESMTPSA id s12sm421804pgi.38.2020.03.18.20.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 20:19:42 -0700 (PDT)
Date:   Thu, 19 Mar 2020 10:19:40 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] configure: respect --without-curl flags
Message-ID: <20200319031940.GD29808@danh.dev>
References: <cover.1584516715.git.congdanhqx@gmail.com>
 <c1c007190683d7ab49e854a66a4832b5ace72b51.1584516715.git.congdanhqx@gmail.com>
 <CAPig+cSqu7-2eTj9S4nMn+MUmXye92idH=XYiDEewpyf4zhpJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSqu7-2eTj9S4nMn+MUmXye92idH=XYiDEewpyf4zhpJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-18 11:51:34-0400, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Mar 18, 2020 at 3:38 AM Đoàn Trần Công Danh
> <congdanhqx@gmail.com> wrote:
> > diff --git a/configure.ac b/configure.ac
> > @@ -592,6 +592,9 @@ fi
> >  # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
> >  # git-http-push are not built, and you cannot use http:// and https://
> >  # transports.
> >
> > +# Respect --without-curl
> > +if test "x$NO_CURL" != "xYesPlease"; then
> > ...
> >  if test -z "$NO_CURL"; then
> 
> I realize that GIT_PARSE_WITH() will either clear NO_CURL or set it to
> literal "YesPlease", but the comment(s) in this file describing
> NO_CURL say only to _define_ it to build without curl support. So, I'm
> wondering if it would make more sense to take a looser view about the
> value of NO_CURL. The existing check of NO_CURL doesn't bother looking
> for a specific value, but instead just tests whether it has a value or
> not. Perhaps the new check can be modeled after that one.
> 
> Also, I think you can reduce the scope of this change quite a bit by
> merely wrapping the AC_CHECK_LIB() invocation. So, either:
> 
>     ...
>     if test -z "$NO_CURL"; then
>     GIT_STASH_FLAGS($CURLDIR)
> 
>     AC_CHECK_LIB([curl], [curl_global_init],
>     [NO_CURL=],
>     [NO_CURL=YesPlease])
> 
>     GIT_UNSTASH_FLAGS($CURLDIR)
>     fi
> 
>     GIT_CONF_SUBST([NO_CURL])
>     ...
> 
> or even:
> 
>     ...
>     if test -z "$NO_CURL"; then
>     AC_CHECK_LIB([curl], [curl_global_init],
>     [NO_CURL=],
>     [NO_CURL=YesPlease])
>     fi
>     ...
> 
> Same comments applies to the other patches, as well.

I've re-checked the configure.ac code.

We've already use:

	test -z "$NO_ICONV"

I think rewrite like your suggestion would be better choice, and
it'll be consistence with the current code.

I'll send a reroll after checking what should be done with NO_OPENSSL.

-- 
Danh
