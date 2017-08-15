Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860A01F667
	for <e@80x24.org>; Tue, 15 Aug 2017 11:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbdHOLtl (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 07:49:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36270 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbdHOLth (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 07:49:37 -0400
Received: by mail-lf0-f65.google.com with SMTP id t128so462263lff.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KUkjixQICkxAvZIO/ZY5DMoI8aNK2vFlS8vFeapggtw=;
        b=gwP0XuBA4YGHIpZSg2KXXyEpRilOHKFmSl5+62MxfeohZGPfyKy2X/IRjp2yV6xE71
         d0FD9tcsLpySfpqt0DDNhIH5/LlgkdX0pJEOt2tuKaFINNmMwD69v5fz4qKsl3HPCiUl
         3b3RYIcXikUofjQYgX/RdkL6sxmFUqdktcYxVxUDOO2Re+m1F9aCuJ0SQVyVCfoLCKE3
         UlS7QbviXXq2qXKVX2IMkdWwhXXFTLEgifBeH1FVEmJehcBg4fpqXD2r2Dq8L68S7oJg
         kKQJqzOhU1R0YWu/gSddsg8RqbxrB70h2oFnNLnfqefMnWPrAxTlO52xWaSNjv2Uczy7
         pJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=KUkjixQICkxAvZIO/ZY5DMoI8aNK2vFlS8vFeapggtw=;
        b=cWD7FDrvly8O/Su6qd2JiCU83vHDQ5/EqfqmLBo0y44s3NGdDA/zd215kIXU5hwesV
         hqPcs9eEH/XrcNLBk9idydCYBO4GMxpAGYMwJRhGM+CEem5zWZ9zLhSJzfjLbkWXRldV
         3DYsPttzckxJhsTLdSbsDg224fzwkyTAkU4fKm74XAcBoccpID7j/rhKdrOGsngB22I/
         CMPFAziS/pp9L2dEUlosd6ONGLjA97vKn6QxdEyf6sLUrvIClpDU9Bv/S41fdCdPfhaI
         K3oagXRPAfIc/qUxzIM7/mVWISoa2RRCt1P5aiXEIhhFhqpt4RjpLnpP/A3sqQBHZoUj
         9riA==
X-Gm-Message-State: AHYfb5jVtS5BEMP/6DTSW/ZGAkcP7JxI+HXCCOpeNGnaVJkorU5l7N1q
        1oVccIJbKyuw444J+gY=
X-Received: by 10.25.18.81 with SMTP id h78mr9650343lfi.142.1502797776331;
        Tue, 15 Aug 2017 04:49:36 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-225-26.play-internet.pl. [94.254.225.26])
        by smtp.gmail.com with ESMTPSA id z25sm1575317lja.1.2017.08.15.04.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 04:49:35 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH 4/5] commit: implement free_commit_graft
Date:   Tue, 15 Aug 2017 13:49:05 +0200
Message-Id: <945cc94bedab645885f9025cee51efd8205a69a4.1502796628.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 commit.c | 11 ++++++++---
 commit.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 499fb14..6a145f1 100644
--- a/commit.c
+++ b/commit.c
@@ -109,15 +109,20 @@ static int commit_graft_pos(const unsigned char *sha1)
 			commit_graft_sha1_access);
 }
 
+void free_commit_graft(struct commit_graft *graft)
+{
+	free(graft);
+}
+
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
 	int pos = commit_graft_pos(graft->oid.hash);
 
 	if (0 <= pos) {
 		if (ignore_dups)
-			free(graft);
+			free_commit_graft(graft);
 		else {
-			free(commit_graft[pos]);
+			free_commit_graft(commit_graft[pos]);
 			commit_graft[pos] = graft;
 		}
 		return 1;
@@ -163,7 +168,7 @@ struct commit_graft *read_graft_line(struct strbuf *line)
 
 bad_graft_data:
 	error("bad graft data: %s", buf);
-	free(graft);
+	free_commit_graft(graft);
 	return NULL;
 }
 
diff --git a/commit.h b/commit.h
index baecc0a..c1b319f 100644
--- a/commit.h
+++ b/commit.h
@@ -247,6 +247,7 @@ struct commit_graft {
 };
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
+void free_commit_graft(struct commit_graft *);
 struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct commit_graft *, int);
 struct commit_graft *lookup_commit_graft(const struct object_id *oid);
-- 
2.9.5

