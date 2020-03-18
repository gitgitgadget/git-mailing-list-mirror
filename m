Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061EFC5ACD6
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 11:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C688A2076D
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 11:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7T7btIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCRLen (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:34:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36124 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCRLem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 07:34:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id g2so8558887plo.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NE9yiuRwUyZh9ChWOTcIQjoH7+ZQU14PSOCUzFU0L3s=;
        b=c7T7btIPgaCb06SUtJBz0g0C937KAmNXv0loGiUM8B1xC+D3n8pjAgG3ELN8GCnswg
         cHlwwmkA8CsJi0TnxaHMNwEp0f02Csz2tSP7eOKWASE4OMx0HXl78qb2wS5eJjRxgcr4
         O8qylq7Snl1Tcmc9/t8/kAU+5ZahChKJVnxYnQLlnO2oh7Z7EDY0eE8G7Q9td835/pXN
         QTE+20//HC2ILgB986G6xyf4arr5a1Nhd/qt/14v6JZ0tYMIJCpTzOx3aO6tyOuSdU8w
         +5ypDch7R3NESPfn8LgEScADzaMmCA/2XbwcMO4etn5qtIhJpCcnikawRWJOt6clA9br
         FQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NE9yiuRwUyZh9ChWOTcIQjoH7+ZQU14PSOCUzFU0L3s=;
        b=VHhg4r3u0xIl8vVKzNArYAjjcUtCAOO2uR4vpkL9llp1T6u7kIeHFyRvOyyp0sbH4z
         EGy2WsCaMXtxWExz0o7NzvDipsNBOCLnwmmnt9efbvC0isB+FwNZF8PRbN4xeek4cS8b
         4dIwt4AzhQvrihFAgghOVczQEw7XMb8iAxGn6hc8dncwCaHmThvhXzY5w8wcoYBcRWXR
         gKeZcBykdqR3DHahEUSGAjjNqvgjdfT6bHhhFLPMWUQZYnQ3YsRlptgys+KC6QTlPi0P
         xsTnjBMDf2bq+He9OTFqzNS4kuhCC77ySTS4Twxkcr5ik5QulVlz7H4OuHYqeD8Nvqiq
         72qg==
X-Gm-Message-State: ANhLgQ2OM0kbUU0x3ww0lSLzXEPHHZnRLbLVIypYmjixx0oitFP8dlnw
        CI4/F+6NT/cf+4ssgUDa6322k7UD
X-Google-Smtp-Source: ADFU+vtBYLgm0A40oVoJb6BWxzx6xoFqD4jtih140+xM/vbWGRuB/lp9DseMLQ47O16RnnwjtM5jnA==
X-Received: by 2002:a17:902:8bc8:: with SMTP id r8mr3368816plo.48.1584531281693;
        Wed, 18 Mar 2020 04:34:41 -0700 (PDT)
Received: from localhost ([2402:800:6375:fbd2:7e82:2a61:6f4a:cfb4])
        by smtp.gmail.com with ESMTPSA id s24sm5722164pgk.14.2020.03.18.04.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 04:34:41 -0700 (PDT)
Date:   Wed, 18 Mar 2020 18:34:39 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] configure: respect --without-openssl
Message-ID: <20200318113439.GA29808@danh.dev>
References: <cover.1584516715.git.congdanhqx@gmail.com>
 <c08bf880c77b7c43256a275e1102308a829d0ee8.1584516715.git.congdanhqx@gmail.com>
 <20200318112213.GB366567@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200318112213.GB366567@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-18 11:22:13+0000, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> On 2020-03-18 at 07:38:02, Đoàn Trần Công Danh wrote:
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >  configure.ac | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index 7468eb6bc8..20a11e1f32 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -544,9 +544,15 @@ GIT_STASH_FLAGS($OPENSSLDIR)
> >  
> >  AC_CHECK_LIB([crypto], [SHA1_Init],
> >  [NEEDS_SSL_WITH_CRYPTO=],
> > -[AC_CHECK_LIB([ssl], [SHA1_Init],
> > - [NEEDS_SSL_WITH_CRYPTO=YesPlease NO_OPENSSL=],
> > - [NEEDS_SSL_WITH_CRYPTO=          NO_OPENSSL=YesPlease])])
> > +[
> > +if "x$NO_OPENSSL" = xYesPlease; then
> > +	AC_MSG_ERROR([Disabled OpenSSL is required for SHA1])
> 
> I don't see this in the original.  Wouldn't we want to fall back to the
> default in this case, which would be SHA1DC?

This block of code will be run into in macOS only.

Really, I wasn't sure what should be done in this case (I mentioned in
the cover letter).

Should we set:

	NEEDS_SSL_WITH_CRYPTO=
	NO_OPENSSL=YesPlease

in this case instead?

-- 
Danh
