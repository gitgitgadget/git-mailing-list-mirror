Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F43C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353276AbiETXSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354041AbiETXRy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:17:54 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69DB1A4907
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:51 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id k2so8899982qtp.1
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eGZdPFnS0lM71M7JI9AHcwK6IUXvVZUam/Aut+ZfQZg=;
        b=yui52nYCeASRK55n8/Y+ShUU406zEwNBpkbkAFlWJV8hQlcLlEmqpmJtgilMLzB2Nd
         hBaU1Q1/3T6GFbawHLUJdN6aL1jaFoZ29OXU6sWEIwJCz+hNOPNHvFSuiN0p90j/vklP
         E/gVHObihkY+hfV63Yxhgz/rN3eUZzyBrDz7Ez4+K8V4HsWMF3JZSGB5KADNiCnq/aCy
         9wJ7voXFyiE0rHv+pUJkB+oy07XpwOr3fgIbd9reGTRL7Qi+VGAa0/sapv2TxIuSavV9
         GyhIEI1Rpl+xlDNRxh3VTvFXu5MkE5nkNph6iBID565TgxENMLW4xeVz6ElSHU07A1oh
         PijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eGZdPFnS0lM71M7JI9AHcwK6IUXvVZUam/Aut+ZfQZg=;
        b=yBu7JQdyI7Ial5FEm6BeS6MkMRNfiCPqyT6hp6BfRB6Xn3sDUvo+tTSi8OQ0DyMrOq
         NSj+4ED36H+V86neNR52UEicsbs1+GCO5T5yJ3rZxz+AqKQfij7y827p144S+nLuFyOJ
         cP9zJ3YnnXg0qmWMXifgUTXVoxwb9JPvAT9SLFLJFZ5fn+ElZ+cNTwkAtmnB9lcgAr3x
         IJ/K9d2WZQPMupQI3vQCMTI7kTTGVUKaEv3V4XxFcs+sp0Ee3UkGwqRpPJhTsWmVuIQf
         fssloN//3homuEzK98LFDMhy7elXAtHyzXHXLoPTl5FObtIh0C6l35enKyRenjJYkMaI
         Uk3g==
X-Gm-Message-State: AOAM532ufeh+I0Ft8ZX4E4fEfMShjH/mixKCoHtkU8ZxgzfL+DCpq9+e
        wR7YrRbwmsc1o6tM9m6L2NvdvU9Ew+6dJy1z
X-Google-Smtp-Source: ABdhPJz/ARuA1qXIdjoTTWVxcyLYPtVohzPs68ObtZZwiQi61rqFz+CVvXymmSNtUikaU9562AfquQ==
X-Received: by 2002:a05:622a:493:b0:2f3:e77b:640b with SMTP id p19-20020a05622a049300b002f3e77b640bmr9455784qtx.236.1653088670699;
        Fri, 20 May 2022 16:17:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cm26-20020a05622a251a00b002f39b99f6a6sm459072qtb.64.2022.05.20.16.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:17:50 -0700 (PDT)
Date:   Fri, 20 May 2022 19:17:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v5 07/17] builtin/pack-objects.c: return from
 create_object_entry()
Message-ID: <edb6fcd5ec72159f2b1fdef41077a841a89cd6a4.1653088640.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653088640.git.me@ttaylorr.com>
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

