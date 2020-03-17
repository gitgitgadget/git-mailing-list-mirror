Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5234C2BB1D
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DEF20735
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="wl9t6qh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCQS6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:58:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42459 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCQS6w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 14:58:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id e11so34370338qkg.9
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+4Ieo4B8oWWhC7v2B/TeeRwInW87K1DN8UK7mhz8Fk=;
        b=wl9t6qh3PUrpcPKzpP7H283UYeseJ48q4XIvSAlHs74nJ3j7GDA76HWDmxf9rwQEYc
         uZ8b6HTPcD/S3sWefUXQ4QAowQjJDAKoS/EuZOHPINJatpV95tJzG/4mRNu3cSHccb2c
         a4ZYHOXEasC9qVsMOnm4+iOINghpBUlSJ/eLHWJ3d/RVd5nyVlHmV/5WJbNymom3e6LV
         RmTnKGpPkUlAz+CBkCBz+KTCHk2cRgLwajHtVvqc4dQuXotwBLxsbLrhEqPLdFuHsdAS
         R1bNuMXCpuHQmxD+V8lGpZMm24r+25yLeH6K7B7A2ft+gFAoimNyt/+Xz4GzKVf+yUGW
         59eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+4Ieo4B8oWWhC7v2B/TeeRwInW87K1DN8UK7mhz8Fk=;
        b=hN1pIpVQxSX68B+5KR64u3t46cuKEHm2InJvCzeFLiyPbGxRJE4SFXHK1Z92q6l629
         /Zy7hdyx9v3lkXwOod/ehdXIUjjWOWMvwSQDWGNBA/23i9oOpFh5zhr9TxQIr47+4HVi
         Xq0aVCGRmPZc6reAvyqycPWOpDYWicWIPbbxq2ISswj5xcwdg2VNxMHTXE/Lfi7OeqED
         OozYeIa3KpMq2mEyPBfdP4SlTbeHXvjwf1JuSVNuZVB098dVHTQYeNbKNfqbftwZJI6G
         tuK7tjMR3jfTEXz3BqdHniwLHJAEGDb//xRpHhtPr/cEEAMw00A558D2j183ukIM2/78
         rf8w==
X-Gm-Message-State: ANhLgQ3aOSqL+kyenq3BYmvvPDri3DtnrFsovCrArLcx0PQKWLJIeBXy
        MNC1BhL+ckPayLUEE2S2KWU5y3tYz9s=
X-Google-Smtp-Source: ADFU+vupYFG88SCWtJut5fm/3oBhwgQRRF2B5wTF4FmaHOHoCB+3qm2YLfcQs0z+7tjTmIJlKft2zg==
X-Received: by 2002:ae9:e51a:: with SMTP id w26mr332176qkf.312.1584471530901;
        Tue, 17 Mar 2020 11:58:50 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::2])
        by smtp.gmail.com with ESMTPSA id n190sm2414707qkb.93.2020.03.17.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 11:58:50 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, dreamer.tan@gmail.com, peff@peff.net
Subject: [PATCH v2 3/3] dir: update outdated comments about untracked cache
Date:   Tue, 17 Mar 2020 15:57:45 -0300
Message-Id: <544d625c471fd5d2d0e139dd0d48cf85d87f0cf8.1584471137.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584471137.git.matheus.bernardino@usp.br>
References: <cover.1584471137.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In dir.h we have a comment mentioning "exclude_sha1[],
info_exclude_sha1[] and excludes_file_sha1[]", but none of those names
appears in code anymore. The first appearance of "info_exclude_sha1" and
"excludes_file_sha1" in code happened in 83c094a ("untracked cache: save
to an index extension", 2015-03-08). In this patch, the two names were
added as fields of "struct ondisk_untracked_cache". Both fields were
later removed, in 3899b88 ("dir: make untracked cache extension hash
size independent", 2019-02-19). However, before their removal, we can
see in dir.c:read_untracked_extension() that their data would be copied
to the "struct untracked_cache". More specifically, to the now named
"info_exclude_validity" and "excludes_file_validity" fields of the said
struct. So it should be safe to say that what the comment referred to as
"info_exclude_sha1[] and excludes_file_sha1[]", back then, could be
updated to "info_exclude_validity.oid and excludes_file_validity.oid"
nowadays.

As for "exclude_sha1[]", its update is easier: it used to be a field of
"struct untracked_cache_dir" that was renamed in 70c369c ("dir: convert
struct untracked_cache_dir to object_id", 2018-05-02). This outdated
field name is also mentioned in one more place: a dir.c comment about
"struct write_data". So let's also update it there.

Suggested-by: Patryk Obara <dreamer.tan@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir.c | 3 ++-
 dir.h | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 92226b1af2..3ad2d61278 100644
--- a/dir.c
+++ b/dir.c
@@ -2961,7 +2961,8 @@ struct write_data {
 	int index;	   /* number of written untracked_cache_dir */
 	struct ewah_bitmap *check_only; /* from untracked_cache_dir */
 	struct ewah_bitmap *valid;	/* from untracked_cache_dir */
-	struct ewah_bitmap *sha1_valid; /* set if exclude_sha1 is not null */
+	/* set if untracked_cache_dir.exclude_oid is not null */
+	struct ewah_bitmap *sha1_valid;
 	struct strbuf out;
 	struct strbuf sb_stat;
 	struct strbuf sb_sha1;
diff --git a/dir.h b/dir.h
index 6c3aaeba71..549e04b068 100644
--- a/dir.h
+++ b/dir.h
@@ -166,9 +166,10 @@ struct oid_stat {
  *  Whenever a file (or a submodule) is added or removed from a
  *  directory, we invalidate that directory.
  *
- *  The remaining inputs are easy, their SHA-1 could be used to verify
- *  their contents (exclude_sha1[], info_exclude_sha1[] and
- *  excludes_file_sha1[])
+ *  The remaining inputs are easy, their OID could be used to verify
+ *  their contents (untracked_cache_dir.exclude_oid,
+ *  untracked_cache.info_exclude_validity.oid and
+ *  untracked_cache.excludes_file_validity.oid)
  */
 struct untracked_cache_dir {
 	struct untracked_cache_dir **dirs;
-- 
2.25.1

