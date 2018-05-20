Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB361F42D
	for <e@80x24.org>; Sun, 20 May 2018 10:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeETKni (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 06:43:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54767 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeETKnh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 06:43:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id f6-v6so20706689wmc.4
        for <git@vger.kernel.org>; Sun, 20 May 2018 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AlETB4g/aYLUm2Yg+pJB18+9M5rwye7NVtaB3VTaqs=;
        b=l83Uhs+GfQH/nXm6+foVIk7LsEcj3dOHUkq5Jkp39VL4Jj3GKd6wInn979oRxD/VDy
         OyWilIFHKUILf2k1WGu9EiM3yVJ5XPoCcGfT9+l/C5IDMWx0kUWsyj+m919zsjzWnls/
         n+CLzfTbJTjiygbOU++TMUrC179X5HaZmYV3qTrVPyrYo/8at0M7/+Rmb7gISc8YdhLH
         XmBS1noQXzrEo6M47s5deQYOtvLv0hNbtP7YwbCg+2e+uXomWCAKQMsPy89FzkMCI1Zf
         W83L8Ylro3YKN0rdHRlytN4lPBebyhvFbkTC96YdfmaR6OOn0lEFhi+mKxOHjH0Qp0cB
         Wh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AlETB4g/aYLUm2Yg+pJB18+9M5rwye7NVtaB3VTaqs=;
        b=uJYzGjV7eqxpb1NHmq4Oklo1DcNeuSbZTrZORM2qU/DCo97iRLTafYKNvJrooRJXtX
         ceyATFFy+aGub24oPS+992itGwUxI6NK90VPprDAM/k2ptAd5/93E7BOOz+p6qFrl4sy
         YCp6+Yz1AP9cMVy7gtEGIf9xl8PUVenSiofXZMBOdM0VWHx1jfrutmoVXMoJnFqqIWGK
         hX8IM07A9y24eUozIRo7MFHtNdbiJWDDOzty8CNEqx84tpMjwoDcOMnvGv669sSar2sF
         7GTLJnwlvxKytEGJhCPLIO+tSTp/45uBmUIafC8vdh2qQq7h9vcsSHOtRvWujTLvnTVT
         AgeQ==
X-Gm-Message-State: ALKqPwdqhDj3uCnVvD7zCgI/Jt5dUtosPGwXTSmfCvvdZr38NWzUfUuc
        /x5sEyPR7A4FzHnKA7SnIuTTm5c+4yk=
X-Google-Smtp-Source: AB8JxZrwRuYLCfoSMtcAsRR7qzIgld3gf+5Ef8F/oYS47z5PGYI4oFhAW01P3aBqVOcmpF/PNKNtrA==
X-Received: by 2002:a1c:bf52:: with SMTP id p79-v6mr8148195wmf.43.1526813016109;
        Sun, 20 May 2018 03:43:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id c21-v6sm13595974wre.81.2018.05.20.03.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 03:43:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/3] config: free resources of `struct config_store_data`
Date:   Sun, 20 May 2018 12:42:33 +0200
Message-Id: <ecae89b852bb98bab1cc90517bfcabfbe6eeafe8.1526812503.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526812503.git.martin.agren@gmail.com>
References: <CAPig+cT1eejizU26mPE+tN+eZR4Wg0jw1DbmShgqRu69EYQutQ@mail.gmail.com> <cover.1526812503.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit fee8572c6d (config: avoid using the global variable `store`,
2018-04-09) dropped the staticness of a certain struct, instead letting
the users create an instance on the stack and pass around a pointer.

We do not free all the memory that the struct tracks. When the struct
was static, the memory would always be reachable. Now that we keep the
struct on the stack, though, as soon as we return, it goes out of scope
and we leak the memory it points to. In particular, we leak the memory
pointed to by the `parsed` and `seen` fields.

Introduce and use a helper function `config_store_data_clear()` to plug
these leaks. The memory tracked here is config parser events. Once the
users (`git_config_set_multivar_in_file_gently()` and
`git_config_copy_or_rename_section_in_file()` at the moment) are done,
no-one should be holding on to a pointer into this memory.

There are two more members of the struct that are candidates for freeing
in this new function (`key` and `value_regex`). Those are actually
already being taken care of. The next couple of patches will move their
freeing into the function we are adding here.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 config.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config.c b/config.c
index 6f8f1d8c11..b3282f7193 100644
--- a/config.c
+++ b/config.c
@@ -2333,6 +2333,13 @@ struct config_store_data {
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 };
 
+static void config_store_data_clear(struct config_store_data *store)
+{
+	free(store->parsed);
+	free(store->seen);
+	memset(store, 0, sizeof(*store));
+}
+
 static int matches(const char *key, const char *value,
 		   const struct config_store_data *store)
 {
@@ -2887,6 +2894,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		munmap(contents, contents_sz);
 	if (in_fd >= 0)
 		close(in_fd);
+	config_store_data_clear(&store);
 	return ret;
 
 write_err_out:
@@ -3127,6 +3135,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	rollback_lock_file(&lock);
 out_no_rollback:
 	free(filename_buf);
+	config_store_data_clear(&store);
 	return ret;
 }
 
-- 
2.17.0.840.g5d83f92caf

