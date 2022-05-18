Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47F7C4332F
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiERXLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiERXLN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:11:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7DC13E9D
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:11 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z18so4019807iob.5
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eGZdPFnS0lM71M7JI9AHcwK6IUXvVZUam/Aut+ZfQZg=;
        b=guGaX8fc2VRmAmNIkbjxHzly4+M9Mqh734qJ9R+t1oyByfkElFdKZ/vIRgMGSN0b7U
         qa7QrFgYENXFjwdBLTk7MhG9XVvwUvhJbfX8ETumtOQCEbRoWfTToJfeBCccDwnsUtnK
         h8A0T81HhEj/AjqD/9ExmM8uZvsxMRo66IWH/ov4rfjN7hDhOLJYKkaHTclwQNLs8UcA
         RjBO5nJ99kFsYuaj4mgxd0KZNOMjxAec4ajjUBDKE3Rdrxa6k1y+vHSn9p3aR9KaFpIS
         5ajajjPEzeoB2w9BLApvwXlsetAFFiweCbRh1a3KyoQjuwbgvs92m+ERqzTd+m7/0Xtj
         gzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eGZdPFnS0lM71M7JI9AHcwK6IUXvVZUam/Aut+ZfQZg=;
        b=Do8Clg57z7RU/prD1aYSmdSDc8oC/MqXLtF7dHzzHKcEzuNObIcjJhg+03f6KO4r4z
         vnUAv/sj63NvavzJiWM7DVdSnSqDjbhtmxck6Wzoo1oZukJ7U1ei3GPneXi1tQvOv0Yl
         D0zAr6l1GvaCboKwmw1hXbiXxPF9xmkWMIm7dFnzxrH5neSchW/qMT3j0aUmytRMxTnH
         A4F0/BpRr/ICsqKBEbpUED4LqzY0gsamDdCpbrWYmXggifmdQ3gN06WNtcOW/hsuclB3
         ZuAw39ACDcy7zKH03k9+9jg3LmwFzzPynkBmrKlxJUTY4rm/OjKBtlCAYpZZfXtAU9Ic
         CLlg==
X-Gm-Message-State: AOAM530HFRy9tYCHIGwOmp8nmUxwKuheKoP/e/YpuZeb+YgyekL2e1TI
        XLZKtZ5ujwv/+446mno5BJsPP4zkeM62ULy8
X-Google-Smtp-Source: ABdhPJwgkqTDENK/n8AWpZyWHagjjN+YsGs6csGDsrBCXuN/eq2LFqwXjRVMNWsrXgyrRzwnf9qnfg==
X-Received: by 2002:a05:6638:2515:b0:32e:5dac:dc65 with SMTP id v21-20020a056638251500b0032e5dacdc65mr1105737jat.78.1652915470516;
        Wed, 18 May 2022 16:11:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a10-20020a92d34a000000b002cde6e352c6sm877983ilh.16.2022.05.18.16.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:11:10 -0700 (PDT)
Date:   Wed, 18 May 2022 19:11:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 07/17] builtin/pack-objects.c: return from
 create_object_entry()
Message-ID: <b8a38fe2e48cf0ccc3b40b97f396b26245d183cb.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new caller in the next commit will want to immediately modify the
object_entry structure created by create_object_entry(). Instead of
forcing that caller to wastefully look-up the entry we just created,
return it from create_object_entry() instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6ac927047c..c6d16872ee 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1516,13 +1516,13 @@ static int want_object_in_pack(const struct object_id *oid,
 	return 1;
 }
 
-static void create_object_entry(const struct object_id *oid,
-				enum object_type type,
-				uint32_t hash,
-				int exclude,
-				int no_try_delta,
-				struct packed_git *found_pack,
-				off_t found_offset)
+static struct object_entry *create_object_entry(const struct object_id *oid,
+						enum object_type type,
+						uint32_t hash,
+						int exclude,
+						int no_try_delta,
+						struct packed_git *found_pack,
+						off_t found_offset)
 {
 	struct object_entry *entry;
 
@@ -1539,6 +1539,8 @@ static void create_object_entry(const struct object_id *oid,
 	}
 
 	entry->no_try_delta = no_try_delta;
+
+	return entry;
 }
 
 static const char no_closure_warning[] = N_(
-- 
2.36.1.94.gb0d54bedca

