Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41624E82CCE
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjI0T4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjI0T4H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:56:07 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2183122
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79f915e5b47so408194839f.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844559; x=1696449359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=102JTjdfwbYfwPCzdbqBjbe8OTap1CK+j6bzjqwhh/M=;
        b=T1Epyc6p6hmnquE+/adzvOAyK/jSU40VyLum4jKIvY9Ot+jCRXYbwAvw+VF9LYlm2O
         OVpVwBQobtzv5eDRUuKujWL/3oybd32hET1IloIB1icE7WkfvWGa7D6dg4Vh4tWpwoQj
         FGbdLkjUJ6mkZ6KB+S48MNu0KmJbClLytfcUQ+NgqEL+Wnl6Iwdw45vSgdQRPHq0q6K3
         32OuWWZlwOF2oCqUAjqTR7LCfg3awez1RtnxBDVqI1ad6F/lwFTnc4xLjIvj1YabWSKc
         VHuQegHNcYOiONPhVXR7L5WzPMdp3Xw7/fVXKrDXDShhVOpL6Ymv8ckWaDjARDW3Su0h
         ZvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844559; x=1696449359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=102JTjdfwbYfwPCzdbqBjbe8OTap1CK+j6bzjqwhh/M=;
        b=uqAX8SI19ScjFzTFvjUGDzn09PW7ypat8xKdKA6rLB0jCTFaZ9P+G9+I4rJhHh5mKJ
         VsDJHw7CVsUYx4tN8eoU4luUCl99hgrZZFV3u8zxHGmoPRT+6sV1DTHblj0Cbd00B7+b
         oGgziOEPuvbgqKgoOlLO0XZmPgR8VtNOAXGaH4WQSuJpXxldD3SezokdBmoEscx/8lUU
         fPYUqippFg5yoPvAg7sZhfYzT6wBd0kMGyDy++nXiiaWIBTQmU6gmpuHLjvEcjtgrcpf
         D0F5LqTWqIpwFYTNZlw1CTcZ8mLvk5vLAKz47b9zrGVyCvw2XfOFCqOA6mQ1lT3j1xUD
         CwlQ==
X-Gm-Message-State: AOJu0YxtMrMwjf/QwK+WZPt1d6YJoy+qfvdr5TvD88ksHAW/J9hXTGB7
        ClrjX+YInji8/DCZD8myPUo=
X-Google-Smtp-Source: AGHT+IHGYYTDdsyZPdeRXcKyZLhXhTuyROgrFBCazNTvjJ0BwJQ+R/zVX5v/ceAFWj1AVwC/xWnnSg==
X-Received: by 2002:a5e:a503:0:b0:791:60c:4b60 with SMTP id 3-20020a5ea503000000b00791060c4b60mr2766204iog.15.1695844559105;
        Wed, 27 Sep 2023 12:55:59 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:58 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 11/30] commit: Export add_header_signature to support handling signatures on tags
Date:   Wed, 27 Sep 2023 14:55:18 -0500
Message-Id: <20230927195537.1682-11-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Rename add_commit_signature as add_header_signature, and expose it so
that it can be used for converting tags from one object format to
another.

Inspired-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 commit.c | 6 +++---
 commit.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index a6dac9a1957b..e75270171bc3 100644
--- a/commit.c
+++ b/commit.c
@@ -1101,7 +1101,7 @@ static const char *gpg_sig_headers[] = {
 	"gpgsig-sha256",
 };
 
-static int add_commit_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo)
+int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo)
 {
 	int inspos, copypos;
 	const char *eoh;
@@ -1769,9 +1769,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		for (i = 0; i < ARRAY_SIZE(bufs); i++) {
 			if (!bufs[i].algo)
 				continue;
-			add_commit_signature(&buffer, bufs[i].sig, bufs[i].algo);
+			add_header_signature(&buffer, bufs[i].sig, bufs[i].algo);
 			if (r->compat_hash_algo)
-				add_commit_signature(&compat_buffer, bufs[i].sig, bufs[i].algo);
+				add_header_signature(&compat_buffer, bufs[i].sig, bufs[i].algo);
 		}
 	}
 
diff --git a/commit.h b/commit.h
index 28928833c544..03edcec0129f 100644
--- a/commit.h
+++ b/commit.h
@@ -370,5 +370,6 @@ int parse_buffer_signed_by_header(const char *buffer,
 				  struct strbuf *payload,
 				  struct strbuf *signature,
 				  const struct git_hash_algo *algop);
+int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct git_hash_algo *algo);
 
 #endif /* COMMIT_H */
-- 
2.41.0

