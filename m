Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E5DC433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 00:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A4820674
	for <git@archiver.kernel.org>; Tue, 19 May 2020 00:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfA+hEaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgESA4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgESA4s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 20:56:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B565C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 17:56:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n15so610874pjt.4
        for <git@vger.kernel.org>; Mon, 18 May 2020 17:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yGGwLroQxg65EoqkVB9D9ZB/CSvNyiL3h/BXOFxLmak=;
        b=tfA+hEaTqMtWRsNuXrfrPo40pUGjokMu52ZZkVFEDtVDqetFBcL772Ycbc5WYVr6h1
         WAEafHHQI37wHET/ThmtB5sM4VWDdC7CmZZHK1voqhOOSaWpGvUe/pTUdkkeTrMqQvE3
         Ejg4mM205c0D6okJtB+xQP3Pi2y+0xUHOKKU9+w3aPN5ecouFoC3nXSFrRWsxIvx5XoA
         teWyuZPfnpSrEdBnCphEZkkdKUL5Q92mVFkR38mWRV3NIw806DkHS3l10sPZLzW/YHI0
         BoJWIcKAz6zbnceDhdn9hAhYPM9yriFXX/iWOyIu19yfkh/3GVATJd2oPwz94KIG36P9
         H+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yGGwLroQxg65EoqkVB9D9ZB/CSvNyiL3h/BXOFxLmak=;
        b=LvVRYV8dtuYAlTnTWx2UfNtteyh5/9a7hD2EZkSf2fp3PH5WsvgnTHIviEJKayU4//
         9qr0hJiCIRlH5uysbZudmREY26ZCgz8uUb5PF1TLxbMvKZBDwGnmSvAX1e6S4iN4xcY0
         N8ZxzDkdcqW1aq9Xmx3XZxZI86nM3I/dL1U819FCAc7oCV8tVRU/iFzPWi/sT8McO2t5
         tQpJSd+6RFTkKVKrZKYCQkE2FNCbj3gRJlj2iTHwsFRWHqJD2442QwEtc1oHOyq5L+JZ
         IZ+r4eTShV65D1rWl0Z+RarfuwLeM8/titUv718vpyNcyHYqlK6qBx33zDQKO0HVcaiK
         0I7Q==
X-Gm-Message-State: AOAM5317PqfEbp99IQyDhZrtXTg5pdnGgofRQ+NrPdpCXBuPpvofXPso
        pRetQQ7XGvKZLCic6f5w7Q91aum4
X-Google-Smtp-Source: ABdhPJyHKJEBtMOvVormFvyFb7bISexyKv0RfKJalbRkpc/lfLPNwZG4yha/c1iZwDS0JgeUmuzavQ==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23mr18633400plr.89.1589849807991;
        Mon, 18 May 2020 17:56:47 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id mn19sm585440pjb.8.2020.05.18.17.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 17:56:47 -0700 (PDT)
Date:   Tue, 19 May 2020 07:56:45 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Darren Tucker <dtucker@dtucker.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t5703: replace "grep -a" usage by perl
Message-ID: <20200519005645.GD1999@danh.dev>
References: <20200518100356.29292-1-dtucker@dtucker.net>
 <20200518141311.GC1980@danh.dev>
 <CALDDTe13_utn7E+QF1AgndX_6nPph=Gr1hesLwfV8e9LwgUPOQ@mail.gmail.com>
 <20200518153025.GD1980@danh.dev>
 <CALDDTe0BvyXYz39n0EqGnJgdfHMziwW7V5xQO_H=+OKm20jfFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALDDTe0BvyXYz39n0EqGnJgdfHMziwW7V5xQO_H=+OKm20jfFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-19 09:22:01+1000, Darren Tucker <dtucker@dtucker.net> wrote:
> On Tue, 19 May 2020 at 01:30, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> [...]
> > > printf: \3: invalid escape
> >
> > Look like HP-UX's printf doesn't understand octal escape.
> 
> The HP-UX one is actually OK with that.  The error is from an old gnu
> coreutils (2.0), and it's complaining because there no leading zero,
> which POSIX says octal escapes have:
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/printf.html

I think it's better to use HP-UX native tools for the test.
Can you check with this patch applied on top of your tree.
-------------8<------------
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Tue, 19 May 2020 07:50:46 +0700
Subject: [PATCH] t5703: replace "grep -a" usage by perl
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On some platforms likes HP-UX, grep(1) doesn't understand "-a".

Let's switch to perl.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Notes:
    We can also copy-and-paste code from t4019,
    to avoid introduce perl to this test.

 t/t5703-upload-pack-ref-in-want.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index a34460f7d8..92ad5eeec0 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -49,15 +49,18 @@ test_expect_success 'setup repository' '
 
 test_expect_success 'config controls ref-in-want advertisement' '
 	test-tool serve-v2 --advertise-capabilities >out &&
-	! grep -a ref-in-want out &&
+	perl -ne "/ref-in-want/ and print" out >out.filter &&
+	test_must_be_empty out.filter &&
 
 	git config uploadpack.allowRefInWant false &&
 	test-tool serve-v2 --advertise-capabilities >out &&
-	! grep -a ref-in-want out &&
+	perl -ne "/ref-in-want/ and print" out >out.filter &&
+	test_must_be_empty out.filter &&
 
 	git config uploadpack.allowRefInWant true &&
 	test-tool serve-v2 --advertise-capabilities >out &&
-	grep -a ref-in-want out
+	perl -ne "/ref-in-want/ and print" out >out.filter &&
+	test_file_not_empty out.filter
 '
 
 test_expect_success 'invalid want-ref line' '
-- 
2.27.0.rc0.4.gf5e7b24084


-- 
Danh
