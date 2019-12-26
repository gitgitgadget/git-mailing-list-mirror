Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E0C2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E7720740
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeXKwDVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfLZOfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 09:35:33 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:51835 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLZOfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 09:35:32 -0500
Received: by mail-pj1-f53.google.com with SMTP id j11so3411231pjs.1
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 06:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Os4QS9B19f5A6SAKXxK/mB3WF4jMHeoza8Fl/16B4ms=;
        b=OeXKwDVPqslcU8EYVFH88rJ+eF8envuykVk2aH8781MVMc3SVx7CiBGnXooJsoE3Fi
         FnbBX4rCcgOg2N/2q6Ykjd2E44nF/w06QqawPoArojwnIoyIeFb005Q32hxETowTmcKk
         Ab/IarPOhtjwugVqm2PhDHshA00TBHYMG2V70zLDkQ81VXzdVH+YS2BITZmfwlZv61FA
         hnKS0Yjzxi6ZHCj4sMgcbpqMG9ITOpH1Ox/UA+BotU3IAXOfIqzoJFtvp7R7NOCiKQPR
         WptEHBXXMWjxBZzCLKtcFH4ddN50RfyD3d8xjvdh4mTAqcGR3y1ie8mdswzfbyOD43og
         hGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Os4QS9B19f5A6SAKXxK/mB3WF4jMHeoza8Fl/16B4ms=;
        b=ilUQ/NyuoMemMCb0f/8vakhJCaD4LSZG9wtSd9jHIwiw4iXPevVHg+TnTIqp5xL34B
         HeMUiBvvhsuXg14Pq3Y5+R3r2mbqaGeFmDu1anPw9H8QbC0AIon07wM1zbt25H22ksBd
         R2dXxgZnvvscNLcYRHKJcL64waKtxcGBQalhaSVn0lExl8zus83krXWpBH16Nep7c1mF
         fk0K0lIw7SeQZDf/feO+XdLykpdqPD4cm1PLC4l3D1RcQSVDd1eCLwKZv/pG+dZ9hY+R
         tYK0cgEIIoyI1xUDoEq5W2lWXcCeLhDp7rrE6CW32XRbg0ktwjpdclYtL9Vj0u6rV0Hf
         9rsA==
X-Gm-Message-State: APjAAAWWediI77YXZWG3DDRXXo5aE4Y6rSBQvjHXo/d/KqP6Xp9BcgQW
        pcuPREC0JeMbsCyk1i40Mwk=
X-Google-Smtp-Source: APXvYqz2ZRoQrkH8ZIOF1nxDcriMb2SbQjL/E6Gn/JCafLwG9LDzBJyJdTGqDT3SXOlGe4XWeyXXGw==
X-Received: by 2002:a17:90a:b002:: with SMTP id x2mr19368973pjq.38.1577370932039;
        Thu, 26 Dec 2019 06:35:32 -0800 (PST)
Received: from localhost ([2402:800:6374:a714:860b:62b8:d6c5:f06c])
        by smtp.gmail.com with ESMTPSA id a15sm38173405pfh.169.2019.12.26.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 06:35:31 -0800 (PST)
Date:   Thu, 26 Dec 2019 21:35:27 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0-rc0
Message-ID: <20191226143527.GA24268@danh.dev>
References: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 2019-12-25 13:44:54-0800, Junio C Hamano <gitster@pobox.com> wrote:
> New contributors whose contributions weren't in v2.24.0 are as follows.
> Welcome to the Git development community!
> 
>   Colin Stolley, Doan Tran Cong Danh, Dominic Jäger, Erik Chen,
>   Hariom Verma, Heba Waly, James Coglan, James Shubin, Josh
>   Holland, Łukasz Niemier, Manish Goregaokar, Matthew Rogers,
>   Mihail Atanassov, Miriam Rubio, Nathan Stocks, Naveen Nathan,
>   Nika Layzell, Philippe Blain, Prarit Bhargava, r.burenkov,
>   Ruud van Asseldonk, ryenus, Slavica Đukić, and Utsav Shah.
> 

My name should be moved down to next paragraph,
since I was lazy to type my name with all accents.

---------8<-------------
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 14fa041043..b42967e66f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -60,6 +60,7 @@ David Turner <novalis@novalis.org> <dturner@twopensource.com>
 David Turner <novalis@novalis.org> <dturner@twosigma.com>
 Derrick Stolee <dstolee@microsoft.com> <stolee@gmail.com>
 Deskin Miller <deskinm@umich.edu>
+Đoàn Trần Công Danh <congdanhqx@gmail.com> Doan Tran Cong Danh 
 Dirk Süsserott <newsletter@dirk.my1.cc>
 Eric Blake <eblake@redhat.com> <ebb9@byu.net>
 Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>
--------------8<------------------

> Returning contributors who helped this release are as follows.
> Thanks for your continued support.
> 
>   Alban Gruin, Alexandr Miloslavskiy, Andreas Schwab, Andrei Rybak,
>   brian m. carlson, Daniel Ferreira, Denton Liu, Derrick Stolee,
>   Dimitriy Ryazantcev, Ed Maste, Elia Pinto, Elijah Newren, Emily
>   Shaffer, Garima Singh, Hans Jerry Illikainen, Jean-Noël Avila,
>   Jeff Hostetler, Jeff King, Johannes Schindelin, Jonathan Nieder,
>   Jonathan Tan, Junio C Hamano, Kevin Willford, Martin Ågren,
>   Mike Hommey, Philip Oakley, Phillip Wood, Pratyush Yadav,
>   Ralf Thielow, René Scharfe, Robin H. Johnson, Rohit Ashiwal,
>   SZEDER Gábor, Tanushree Tumane, Thomas Gummerer, Todd Zullinger,
>   and William Baker.

-- 
Danh
