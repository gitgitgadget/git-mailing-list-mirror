Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ABAC2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B18A20706
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnQC0QZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfLXRup (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 12:50:45 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:34313 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLXRup (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 12:50:45 -0500
Received: by mail-qk1-f180.google.com with SMTP id j9so16886772qkk.1
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 09:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3nU8Hy0HtGqxZCUMW1yjg8e6uJ4kJv6BOpZ7XHvPStM=;
        b=GnQC0QZCrZ2ZsblLPTk9oZ7NrMvKwKnm20erf0VIXsTlQMGBjHAPG6TqQcWKmE2i/Z
         nQpoITCTdEuxc2QBaw/TTATnU/DSV+OazlONy43j30ka701coDIce1XnxV9QeerohtS8
         LKxHjjxf2OciSBdybG8i3++lxsZd88lQ5tXJM5b2Tr8Sqb+Y1QbhS0hoNT/PhEX461c1
         O1CuolwFfqDjBhuXrl0siAmUrE75wJes5XzaVZrZ1Ko89gcX3cwazskyuv6b3sww37xw
         mUBrkBKATcPZI5MK9d+ljo2UqjBEA3Zl7qn6gkk2oe2mx3l9uBigszWxMNaK0E2cEW+K
         ZsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3nU8Hy0HtGqxZCUMW1yjg8e6uJ4kJv6BOpZ7XHvPStM=;
        b=iCno1RasNqF3KldWkI00alLRFsERdKft/pXW2sgEfn5QI77lWmfMhVIZj5qOWeJHEd
         Ztpv+i9DW63H5YxXbqt8cuXOEufNDXRJYlAKc9tNT379nvgMGR9t/taaBlsLlnk6xHVw
         MSH62qQrRV96ogSOUO3Hdw6GwXm9BKuk6gt/57hjBmujLtw00F+mM69VmDXiyoO0y2kW
         OmBRq8ay46g1ehAExkCs/rH7YosrhvUbLqwX5k0vpML2WhVfe3+oKgw+WB7YQGDJj/K5
         Vyb+kTSXOKemawxIomvdRP1Vz7onJRfQ6mAU0fpTYqX95oUzdeju5WIQwGXEa9GYVia8
         nFgw==
X-Gm-Message-State: APjAAAVMj/dGC2HnABigl3mnfQ65Q05Ou8VtMKXrK7cAT25OUWnOLKXZ
        9jHAmNM40Qr/CnlYOIwB9ejbkUtATz/Rjt4WRN2lIXaq
X-Google-Smtp-Source: APXvYqxgP+g3StrL8YCt9V2vCLojEzr1QkQ38RCeiYTa0t9CEauGZqax+2KdWNC+61ozn5kVFE4r8JLVLY5TTJv8iHM=
X-Received: by 2002:a05:620a:147c:: with SMTP id j28mr28878555qkl.13.1577209843908;
 Tue, 24 Dec 2019 09:50:43 -0800 (PST)
MIME-Version: 1.0
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Wed, 25 Dec 2019 01:50:29 +0800
Message-ID: <CA+PpKPm0_zXr978Mw8h7owHBChx-uqVCdjrtuh45uOS-A_0qrA@mail.gmail.com>
Subject: [BUG] `git diff` treats an unchanged line as modified
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are two files `old` and `new`.

The content of `old` file:

```



kasan_poison_slab(page);//

shuffle = shuffle_freelist(s, page);//

if (!shuffle) {
for_each_object_idx(p, idx, s, start, page->objects) {
setup_object(s, page, p);
if (likely(idx < page->objects))
```

The content of `new` file:

```



kasan_poison_slab(page);

shuffle = shuffle_freelist(s, page);
```

When using git to compare these two files, the result is:

```
diff --git a/old b/new
index 474ab07..d432a67 100644
--- a/old
+++ b/new
@@ -1,11 +1,6 @@



-       kasan_poison_slab(page);//
-
-       shuffle = shuffle_freelist(s, page);//
-
-       if (!shuffle) {
-               for_each_object_idx(p, idx, s, start, page->objects) {
-                       setup_object(s, page, p);
-                       if (likely(idx < page->objects))
+       kasan_poison_slab(page);
+
+       shuffle = shuffle_freelist(s, page);
```

However, the Linux diff command gives the following result:

```
--- old 2019-12-25 00:56:40.000000000 +0800
+++ new 2019-12-25 01:12:48.000000000 +0800
@@ -1,11 +1,6 @@



- kasan_poison_slab(page);//
+ kasan_poison_slab(page);

- shuffle = shuffle_freelist(s, page);//
-
- if (!shuffle) {
- for_each_object_idx(p, idx, s, start, page->objects) {
- setup_object(s, page, p);
- if (likely(idx < page->objects))
+ shuffle = shuffle_freelist(s, page);
```

I think the latter is correct because the fifth line is not changed
and it's still a line which only contains a whitespace.

Steps to Reproduce:

curl -L https://git.io/JeFNy | base64 -d > file.tgz
tar -xf file.tgz
git diff --no-index old new
