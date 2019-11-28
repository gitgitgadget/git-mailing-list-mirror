Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669E5C43215
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AC620880
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="sdDqedvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfK1B3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:29:09 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:45404 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfK1B3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 20:29:08 -0500
Received: by mail-pf1-f169.google.com with SMTP id z4so12220357pfn.12
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 17:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKgd+Wrn2mBmHzMOu7SxJDqZ5BRQ0ZuG9S4gVMmmr58=;
        b=sdDqedvvTaxKPXgCIKu9hXXEkCgulzUrq4SlNUhiYSQimyPxm/Ct1+oJymWySFv4CE
         +f+6y0cc23h3898qFmvFPB8ZJ8PTxinL++6ciPjuCAU7DGSjbzNP0MqMdB9ER6O4/Jem
         c+X75pHeS0vTflm6k+9BE0QSjPwbsqS8Q14Mb/mKQ12dLz4u1h/nnjqZ7rhYVBnhe1w5
         oz7H/vUkU0L7oqRhhIwsJ9oxx3RX8bM2L00EY+F8BDGEzZvSq4zb3gpmZpwpWo9+U1Ot
         qB7ULDjKwI87Q2Y6nknnDhyMcWMZkjgMZOTbbaVBL8FKNPnnU6LyyOgvbUhR/lpLNQF8
         7GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKgd+Wrn2mBmHzMOu7SxJDqZ5BRQ0ZuG9S4gVMmmr58=;
        b=QVwKpz396PBMOe3IvzEzy/IEAPchMPT8p5N/PIu9FExN0D38j/BtAf2SBE3Pm9EVc2
         If+lHUTwnvOsowgM3stYpqMFOujue2okSZNvAhMM9I13LWZA/w1ZW34xPkKuDPOxtQ96
         Rvuj4gVCb2w98clcgkGcjtSd/N9ZQNZSNXoC0MZDvxRCcLFVOfCMWlv2F6RRTeI9cb/d
         flcxdb+iFyWufN98YM/GkCAhgkrQUv66b7dYGk6HqXaS+1eDNIdacb6k6JdKkTrupNyJ
         AGHyXrVLtzgZyX7J4BjbML9heU+EPBwQyH7rRa5hm3lWo08CGs4wmpsZAjtE8o3JQbGZ
         sZPQ==
X-Gm-Message-State: APjAAAUDgsmWZr1hegPfV2e6GboHwZwQyBOFw7euHwprHnGX6HNdGpXb
        RGhrYFTgbkM5CyGcdzDLAhfbIa5Ta6m3kg==
X-Google-Smtp-Source: APXvYqwAuivzgARALXRwusdNDhXLB7bVOVq8awGbaNzvjJzFxQisvcKMehbqcvF8DWWhH8Znvrv3OA==
X-Received: by 2002:a63:ec4f:: with SMTP id r15mr8233597pgj.17.1574904546242;
        Wed, 27 Nov 2019 17:29:06 -0800 (PST)
Received: from SBL-PC-YZHAO.skyboxlabs.local ([184.67.13.114])
        by smtp.gmail.com with ESMTPSA id w15sm17507215pfn.13.2019.11.27.17.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 17:29:05 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [RFC PATCH 1/4] git-p4: decode response from p4 to str for python3
Date:   Wed, 27 Nov 2019 17:28:04 -0800
Message-Id: <20191128012807.3103-2-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
References: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The marshalled dict in the response given on STDOUT by p4 uses `str` for
keys and string values. When run using python3, these values are
deserialized as `bytes`, leading to a whole host of problems as the rest
of the code assumes `str` is used throughout.

An exception is made for the `data` field as it may contain arbitrary
binary data that is not text, as well as `depotFile` which may contain
text encoded with something other than ASCII or UTF-8.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..ead9d816e1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -36,6 +36,7 @@
     unicode = str
     bytes = bytes
     basestring = (str,bytes)
+    use_encoded_streams = True
 else:
     # 'unicode' exists, must be Python 2
     str = str
@@ -643,6 +644,15 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     try:
         while True:
             entry = marshal.load(p4.stdout)
+            if use_encoded_streams:
+                # Decode unmarshalled dict to use str keys and values, except for:
+                #   - `data` which may contain arbitrary binary data
+                #   - `depotFile` which may contain non-UTF8 encoded text
+                decoded_entry = {}
+                for key, value in entry.items():
+                    key = key.decode()
+                    decoded_entry[key] = value.decode() if not (key in ['data', 'depotFile'] or isinstance(value, str)) else value
+                entry = decoded_entry
             if skip_info:
                 if 'code' in entry and entry['code'] == 'info':
                     continue
-- 
2.24.0.windows.2

