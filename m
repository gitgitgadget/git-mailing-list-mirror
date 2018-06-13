Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2C81F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936055AbeFMXGy (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:54 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:37507 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936032AbeFMXGq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:46 -0400
Received: by mail-vk0-f73.google.com with SMTP id j123-v6so1639161vkc.4
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=sLuM6t9rv28OE7cIdfEWFwKC4grxuQqVusHNY7k1Ihg=;
        b=aZkjjdxmSigG9gV+hUcDLxCOd2QizqfMfwUf5kwr/Y/OZaCnOZjgh/1k3gO6poQY6c
         GArfT98hZSXFPioVufolc46N2P21XLPfIJt5MEvkRlKfRrT0FGs/4SyWYh624bBW5lV/
         ixxuAIpx02BJzcAiwJtrx4mhuJAjlPNSRhZy7qmQxto875ogceDXnEN3NFeUz5nVEHLS
         VbSjVwcr97QShwAY2HjvWjLc4G+z8CM8P1jC77/npVEer+Go4NH9ApILK38nqO+slB2+
         m5Ovk5AHTPm5Aq1uhh+fe2rZ828vqru2svjze/OcC5eoKZCYPuZXm4skyoLqZL77xJmE
         NbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=sLuM6t9rv28OE7cIdfEWFwKC4grxuQqVusHNY7k1Ihg=;
        b=A2cjVZ6XsKvCZaqqIeuMYwhHBoHbdsh1ngL0pa3A+6pLSJbuEDdq6PW9k0VKrphpxd
         zx/+wORRQlWgiN87qekvvA75D7K8H5nDxSW4JnzcTRbk3jelI62ejsDHRgZj1iSfdjaH
         bu2EpTLUHQYukdJf+xOYuieOs/u/0NhmkAGxeE+ZEOR/OhPKDUaUeZzfVmDufgQq2ltm
         HTw5j6fRocJ2luZ7gqMosony+xmRuxbcqwyux2nU6TlWFr2Zb7N4pc+SH4jpFefSbqil
         jalbB+pnagh+z/U6rZqr8isPgrEC9T4ZE+W3jQc9keTniFlemqJuljyhO8DsdKpHzBJ1
         VVDw==
X-Gm-Message-State: APt69E27QFI2fGaTqm314jGGNc2imeso4SHsHMsnyZwEJVFZyVo4By53
        Q9eg1Gt0M17CXjtUmuke2c7f16tDjxj8jxoVZVaEh8hzFe3Bf/oBS4U1vfBbExxEI5RIW71B0Fv
        wSRPV+YY9Iwyg1y+MzkVs++ghgTWnVfJNTKZLEYsAlbL2NTnHH7Hw1+DQfInt
X-Google-Smtp-Source: ADUXVKKWOZQ3NpelhudCmWU75cuUh+n7AoxmnNBEoNkatZPie1g7DZhGbjPa6SVjdolHQHRi3cm0ZSZkgCVf
MIME-Version: 1.0
X-Received: by 2002:ab0:5c4e:: with SMTP id a14-v6mr84770uag.68.1528931205410;
 Wed, 13 Jun 2018 16:06:45 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:21 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-31-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 30/31] commit.c: allow lookup_commit_reference_gently to
 handle arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 8 ++++----
 commit.h | 4 +---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 7ee55f6b8f0..009e1d33e08 100644
--- a/commit.c
+++ b/commit.c
@@ -23,16 +23,16 @@ int save_commit_buffer = 1;
 
 const char *commit_type = "commit";
 
-struct commit *lookup_commit_reference_gently_the_repository(
+struct commit *lookup_commit_reference_gently(struct repository *r,
 		const struct object_id *oid, int quiet)
 {
-	struct object *obj = deref_tag(the_repository,
-				       parse_object(the_repository, oid),
+	struct object *obj = deref_tag(r,
+				       parse_object(r, oid),
 				       NULL, 0);
 
 	if (!obj)
 		return NULL;
-	return object_as_type(the_repository, obj, OBJ_COMMIT, quiet);
+	return object_as_type(r, obj, OBJ_COMMIT, quiet);
 }
 
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid)
diff --git a/commit.h b/commit.h
index c7bb01ffe4b..717403d6431 100644
--- a/commit.h
+++ b/commit.h
@@ -57,9 +57,7 @@ struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
 #define lookup_commit_reference(r, o) \
 		lookup_commit_reference_##r(o)
 struct commit *lookup_commit_reference_the_repository(const struct object_id *oid);
-#define lookup_commit_reference_gently(r, o, q) \
-		lookup_commit_reference_gently_##r(o, q)
-struct commit *lookup_commit_reference_gently_the_repository(
+struct commit *lookup_commit_reference_gently(struct repository *r,
 					      const struct object_id *oid,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
-- 
2.18.0.rc1.244.gcf134e6275-goog

