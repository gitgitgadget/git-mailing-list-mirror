Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE465C43462
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB1B6113C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhDTNhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhDTNhl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:37:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307E5C06138C
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g9so21620286wrx.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVl/fdAFBcu4FcDCdYwcbecDDXXYxS1/l1HIZQHJDr4=;
        b=hlYSf22CqcvneNQnLvSrJRwnzjyb6IHnIrdqrqRWB94dTUwOOZ99yuSkQTjgN0yYDd
         zWWZy8/Fq9CBQxrTA6tbC6W9HNaEjO9BWgPfGzawqIE0g9qzMulDy+ZG6Wcau9qxiBOL
         iDRMD0CNT2UrjC4P6QJZkAVBx2EuphUQOEIVC4wh+dDrl+5Amt4YIm9YfJ5DJ34Ezocq
         7MQqRoRX6/0EXJXihWGrOZblnyELyvRmEc6gCVcp9cBY9nJiVSs2Km4nf+8MOPGBEuaJ
         RP2yyZfXF4/+brqkiVfbcszU0W7F1P+UQSGu317dC11XdezQnTHZJMVHpcKcBXT4KVsb
         2Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVl/fdAFBcu4FcDCdYwcbecDDXXYxS1/l1HIZQHJDr4=;
        b=fPTlUH+7Axp2EICaY5eQhKSpvOC+BsETsTnZ2clLo2+t4529F6I6MsaQyC+b2RPdjo
         o3YqR7+MoIA66mkDx8/7Z9NYhQ3PD544BbAoiT0GoBUSDjtzqikOtQAYTvz3/dJOiW1S
         rcFdEf+C/aGC5yFncY/aYI+U7q4bDG9zMCtE3KN6C8X2B/Zq5IQoAjTXhdkq7WbyCq+p
         vfFUnMti2pxNmwIV2ACAwz1phNg/jyCp9jC+srJYKUXHKcQsb5NeaLlphdLNeqV28WGw
         miNmSR2mgijWntNOGshxP8F+iGEWNpodG6PkBGYZCOeEaL9FSH001j7jbRZ7H4N4Qv/h
         5+AA==
X-Gm-Message-State: AOAM530cedgN2JWukbNjLcx4s2R//Av6khsfZ/Uo5uHceoo+2TGzFa9K
        C7EQGM0HIdmqpeWlKEjuuBCMhUwnIN7wsA==
X-Google-Smtp-Source: ABdhPJxmJIX8u03S/HEphTU5rfVAk9QCMxiLXsVd6XuyHIj0MHWcPPZgeHDvhJ2DEjyfd08CW5XMPg==
X-Received: by 2002:adf:f948:: with SMTP id q8mr20917619wrr.296.1618925828663;
        Tue, 20 Apr 2021 06:37:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm17705518wrr.3.2021.04.20.06.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:37:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] commit.c: don't use deref_tag() -> object_as_type()
Date:   Tue, 20 Apr 2021 15:36:58 +0200
Message-Id: <patch-6.8-f337a5442d-20210420T133218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
References: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com> <cover-0.8-0000000000-20210420T133218Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a use of the object_as_type() function introduced in
8ff226a9d5e (add object_as_type helper for casting objects,
2014-07-13) to instead assume that we're not dealing with OBJ_NONE (or
OBJ_BAD) from deref_tag().

This makes this code easier to read, as the reader isn't wondering why
the function would need to deal with that. We're simply doing a check
of OBJ_{COMMIT,TREE,BLOB,TAG} here, not the bare-bones initialization
object_as_type() might be called on to do.

Even though we can read deref_tag() and see that it won't return
OBJ_NONE and friends, let's add a BUG() assertion here to help future
maintenance.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 3d7f1fba0c..c3bc6cbec4 100644
--- a/commit.c
+++ b/commit.c
@@ -31,13 +31,22 @@ const char *commit_type = "commit";
 struct commit *lookup_commit_reference_gently(struct repository *r,
 		const struct object_id *oid, int quiet)
 {
-	struct object *obj = deref_tag(r,
-				       parse_object(r, oid),
-				       NULL, 0);
+	struct object *tmp = parse_object(r, oid);
+	struct object *obj = deref_tag(r, tmp, NULL, 0);
 
 	if (!obj)
 		return NULL;
-	return object_as_type(obj, OBJ_COMMIT, quiet);
+
+	if (obj->type <= 0)
+		BUG("should have initialized obj->type = OBJ_{COMMIT,TREE,BLOB,TAG} from deref_tag()");
+	if (obj->type != OBJ_COMMIT) {
+		if (!quiet) {
+			enum object_type have = obj->type;
+			oid_is_type_or_error(oid, OBJ_COMMIT, &have);
+		}
+		return NULL;
+	}
+	return (struct commit *)obj;
 }
 
 struct commit *lookup_commit_reference(struct repository *r, const struct object_id *oid)
-- 
2.31.1.723.ga5d7868e4a

