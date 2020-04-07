Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D385C2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 02:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D6A206F5
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 02:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI+CheEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgDGCme (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 22:42:34 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51869 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgDGCme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 22:42:34 -0400
Received: by mail-pj1-f65.google.com with SMTP id n4so123538pjp.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 19:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CYCvPrpZadzGquPNgJHKksV0STzgsbYIYsHvCXVZSdw=;
        b=OI+CheEBHcXemC88M5gsJUxhFl60UB9Cy8jQlfbUuL4/eUhROk9h32BNKLBqVJnqVx
         6WRbEdUPtRlNwjJuzNRpR1aylDCZvbfBuDeXw5TF2CSg61eqdowssv2KxrBCovZWha7C
         OrdBXMINGDVSYwZ2plxQJIeAA+cQGeoczTzWrJcAz1YLCdUAWMG6LlgtGQdJhzm+Q0aL
         /QWAZOb1j99I46FaJ70WCuFTSt8wa0lygO+VwQ+Wuw7FTfBCegKUkEf/b+T08DVh75IP
         AhO+mwjNuX3hQLGSWiZK2ITmHeD6OVVB5sHoUhj66TNfq8E7Y6yC/0R3TyntD+b9TDtU
         /qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CYCvPrpZadzGquPNgJHKksV0STzgsbYIYsHvCXVZSdw=;
        b=XBK7lXpV/vgi6RMpKWu3CGTJfHA06zRhI5IAZDZACvqseUbMNI/he0TeXB3JZCw1pV
         ksqcOaQDjwUrB6opbWdMBMnCVTeJDOr2KHlYUZiFnqeZpuqVfCXajQS4QXbwPQe1ekBX
         j5MBMGOkeETbrb55kfzW9vGeAnfeGCP2LGEfup9lqx3qJrI35tQAlZMX8Ds5Izi/pGms
         zeXRY6SDzaTRWFQC8CmLYbKyH8JQZpKebWjlOKmICbTRQNuczxSV4znzza/qxcGWGeun
         0LSFq1mceob3IEmrotwDSRbGqc99JdEHRpjEjY35JkZ3KD0Tic5d+3ahiG8PakZHx6EG
         cBwA==
X-Gm-Message-State: AGi0PuZcEXRMkPyAcwfbcZSg9Aud9lJ3zO2D5dwjhVDDnWsXQ/Qxmu0r
        XtxZjxMKKvJcDVWgEgPtqZg=
X-Google-Smtp-Source: APiQypKQlFVrBHszbmLUB8mHRSw0aTsuR08Cp1x6Jk6SIMu8NObLWxV5LTet5iNTvhBOSFft5+jpoA==
X-Received: by 2002:a17:90b:4906:: with SMTP id kr6mr15932pjb.13.1586227353495;
        Mon, 06 Apr 2020 19:42:33 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s76sm11857179pgc.64.2020.04.06.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 19:42:32 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:42:30 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Minh Nguyen <mxn@1ec5.org>
Cc:     git@vger.kernel.org, Tran Ngoc Quan <vnwildman@gmail.com>
Subject: Re: [PATCH] fix inconsistent use of checkout and switch
Message-ID: <20200407024230.GA8197@danh.dev>
References: <fe3b560b-be22-b1c0-394f-6bd9a5fef152@1ec5.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe3b560b-be22-b1c0-394f-6bd9a5fef152@1ec5.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
On 2020-04-06 18:49:37-0700, Minh Nguyen <mxn@1ec5.org> wrote:

Update to Vietnamese Translation should be sent to Quan (Cc-ed)

Thanks.

 po/vi.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/vi.po b/po/vi.po
index 5459484048..5af3c3ebb7 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -805,7 +805,7 @@ msgstr ""
 "bạn có thể làm thế (ngay bây giờ hay sau này) bằng cách dùng tùy chọn\n"
 "dòng lệnh -b. Ví dụ:\n"
 "\n"
-"  git checkout -c <tên-nhánh-mới>\n"
+"  git switch -c <tên-nhánh-mới>\n"
 "\n"
 "Hoàn lại thao tác này bằng:\n"
 "\n"
@@ -11661,7 +11661,7 @@ msgstr "tạo/đặt_lại và chuyển đến một nhánh"

 #: builtin/checkout.c:1779
 msgid "second guess 'git switch <no-such-branch>'"
-msgstr "gợi ý thứ hai \"git checkout <không-nhánh-nào-như-vậy>\""
+msgstr "gợi ý thứ hai \"git switch <không-nhánh-nào-như-vậy>\""

 #: builtin/checkout.c:1781
 msgid "throw away local modifications"
-- 
2.23.0
