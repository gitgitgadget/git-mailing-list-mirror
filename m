Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCAC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE18613C3
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbhGNR1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhGNR06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:26:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988ABC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:24:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l4-20020a05600c4f04b0290220f8455631so1938593wmq.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsjH7uH10VvgHyq1XZ15BNWgWFXLQi7LOGIAHd8ON1k=;
        b=MgNQ/4ezUdJhNuA2P2uPZqHdIVYp5lfh/QHMsgMP9fVUE2Nc2y7LoDDDQlEEMdf/64
         to1P/aLvpJMOJID4K+eZ2bjuyJM75PuSEtKQVxlRp+Kpd13UwZ+8bYGIH3S7HU/Hs8fP
         iMLbemh60nGUM9VDw02jWPHOPv4CTeEidCrHObDu2bLJAdgikdNw7ftYKFCJnevEDIGQ
         06wN6snqyXZ5+20HbByEfFC0ZGyGoU+aDj0e0LUTVtv93/JmO8FrM1c+yOAf6sYs95Hh
         PL4FlnYVRSwscTju2xfd98G1i+GjflCdC8fytLOBHl6a214ZUbxnE9eF1usBaGQEWGz2
         O7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsjH7uH10VvgHyq1XZ15BNWgWFXLQi7LOGIAHd8ON1k=;
        b=TJY9mYyis3dhVCrHhVf2ujv13N7PXbofKcSW5dFlvdq90XZUaCc3DdT+IaQ/7ZhoZQ
         YyU3HHYVomhRFDv7mNOmBq9pqtcDxn2+C4BygMNazenhGqjAnzuksT8D1qwefNYYOLVg
         FWhfrn084DMTjgfgRynwidkfp4Q9Q184SPC+TqwOc6gRqIV62LTPK0gL3SpMKwHVDj/p
         uDvExq6ycCiIJ5/voxV9RIgbqVnBXa9vz1Vd10NicX9pGodcXZbGvJhK7Daggw0Z9V3y
         VnMQQShaVJSilyacObk+Sge4J42W1bo/FHorOy4JqnrC+KhbaXv7T+9+DPNSSlVsPk5E
         tHpw==
X-Gm-Message-State: AOAM530e9sLWsfsc6xN9HSXqNB6W3R1iNRajJbUDKpL8tjfPuC8zdIdT
        xrjj0RWYxF+d+VVA1BL94Ik7jt1ipqKyLme6
X-Google-Smtp-Source: ABdhPJwFVNpaugd+GHKTkJxwBbL2SAvstwaA9iLwZOZibTBjAJclhx9ZnPRmjrRFMO8uuEd6qoETwg==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr12472153wmi.29.1626283443956;
        Wed, 14 Jul 2021 10:24:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f5sm3823795wrg.67.2021.07.14.10.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:24:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] SANITIZE tests: fix leak in mailmap.c
Date:   Wed, 14 Jul 2021 19:23:54 +0200
Message-Id: <patch-4.4-ad8680f529-20210714T172251Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.853.g5a570c9bf9
In-Reply-To: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com> <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get closer to being able to run t4203-mailmap.sh by fixing a couple of
memory leak in mailmap.c.

In the free_mailmap_entry() code added in 0925ce4d49 (Add map_user()
and clear_mailmap() to mailmap, 2009-02-08) the intent was clearly to
clear the "me" structure, but while we freed parts of the
mailmap_entry structure, we didn't free the structure itself. The same
goes for the "mailmap_info" structure.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 mailmap.c          | 2 ++
 t/t4203-mailmap.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/mailmap.c b/mailmap.c
index d1f7c0d272..e1c8736093 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -36,6 +36,7 @@ static void free_mailmap_info(void *p, const char *s)
 		 s, debug_str(mi->name), debug_str(mi->email));
 	free(mi->name);
 	free(mi->email);
+	free(mi);
 }
 
 static void free_mailmap_entry(void *p, const char *s)
@@ -51,6 +52,7 @@ static void free_mailmap_entry(void *p, const char *s)
 
 	me->namemap.strdup_strings = 1;
 	string_list_clear_func(&me->namemap, free_mailmap_info);
+	free(me);
 }
 
 /*
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 0b2d21ec55..c7de4299cf 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -79,6 +79,12 @@ test_expect_success 'check-mailmap bogus contact --stdin' '
 	test_must_fail git check-mailmap --stdin bogus </dev/null
 '
 
+if test_have_prereq SANITIZE_LEAK
+then
+	skip_all='skipping the rest of mailmap tests under SANITIZE_LEAK'
+	test_done
+fi
+
 test_expect_success 'No mailmap' '
 	cat >expect <<-EOF &&
 	$GIT_AUTHOR_NAME (1):
-- 
2.32.0.853.g5a570c9bf9

