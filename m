Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163BC20229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756192AbcJWJ1P (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32813 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754677AbcJWJ1N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id d128so5248708wmf.0
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=261ZBguh24romvp+dxjDon846HAaBclf8+KZYc4UrGY=;
        b=FgkgQ94gIrmGinhy2rtPzhPd/Z4C1lolrxeC9b7MwPfvmGy+Qb2IIx0bYBcqeyG/A1
         eYxGpStwUxLcngGpXrw0ZNcNMUdaC9w7QCaUsRq+aQJwRuguIVWD234aYCY9vIOt2wE4
         bUys/qc0MgDUO4FRDRoMHbRdMNALDNBq40VJND7KoMlCc7r3aVun54ks7O0y8OhhHxB6
         Wgb9NLal3IV2a6nEAJbjwLEDwSJg7VzRMXLrQ4GX5RFDtvNTSH8KUZb9v1/TcOaM9zkd
         cbv0xyR3bsNkWKHq+BCL4Y90SqU0u1YvGnunaHcCDDVTJ5ZouHyC98tlPLe7Pm3Nv2qW
         cmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=261ZBguh24romvp+dxjDon846HAaBclf8+KZYc4UrGY=;
        b=NibYWwb/RS0RsRKZo1jo6mlAO3Ucj20FAxqsuXmWs34eW09mxf71ASpfWVNU/0jBpK
         3Q/evITgW06mr4pXlr8smyCVKRUAaIhARUo8fVoU1UdG1mfU6szvQ95mLuFUAEWBzmhU
         kId9w59MSyvxqd9zzmuHGe2QkJmLYfNEaUqSls1Pe6EwJ0TWZKnwuPl3DTcNlxTDBvl3
         YM8O2s40Mr3bIz51qi4muGQR/QGdH7CQfFjVTH5i4s90652EtJB/pdT2e4FzAe7WSfMK
         WJARRF6POyOHg00tFRotejPxtRwehialLsSardjnKI3tvzAWdGpEzowTv2uXk4a2PgJp
         crMA==
X-Gm-Message-State: AA6/9Rn3d5CN+jK6mP2M+TDCLxSsDnWzSDMsIv70Ou2dswNhJLY4tb0XXA40WyGMD6vtXg==
X-Received: by 10.28.150.20 with SMTP id y20mr16803319wmd.67.1477214832182;
        Sun, 23 Oct 2016 02:27:12 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:11 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 02/19] config: add git_config_get_split_index()
Date:   Sun, 23 Oct 2016 11:26:31 +0200
Message-Id: <20161023092648.12086-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new function will be used in a following commit to know
if we want to use the split index feature or not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h  |  1 +
 config.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/cache.h b/cache.h
index 05ecb88..394da60 100644
--- a/cache.h
+++ b/cache.h
@@ -1809,6 +1809,7 @@ extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern int git_config_get_untracked_cache(void);
+extern int git_config_get_split_index(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
diff --git a/config.c b/config.c
index 83fdecb..036e29b 100644
--- a/config.c
+++ b/config.c
@@ -1709,6 +1709,16 @@ int git_config_get_untracked_cache(void)
 	return -1; /* default value */
 }
 
+int git_config_get_split_index(void)
+{
+	int val = -1;
+
+	if (!git_config_get_maybe_bool("core.splitindex", &val))
+		return val;
+
+	return -1; /* default value */
+}
+
 NORETURN
 void git_die_config_linenr(const char *key, const char *filename, int linenr)
 {
-- 
2.10.1.462.g7e1e03a

