Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282D5C43219
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376894AbiBHNOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350228AbiBHMO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:14:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55C0C03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:14:56 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b3so43643pfg.7
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DsQ4/8Eeg48radubstj3W86Jg99jiR+oV9E1n8D4GNQ=;
        b=qPyw+p+swd+URgM+jIgRT/RDG8y99L9t5ZaOrwo5Q7NSX31DLag2FTi5Vpc7CXx0EO
         d6GJz93ZWeMOllUoASLAN2NzyskHlTr+JtHGgnYPKpay55Hz0do4HUy1plwqvYRzO1b0
         4q1HRg3RYz0MtxvvGxnU24Vfkp3VEb3FFpPtAxmQNICI8dKYoMTth6X3hZm/CQyT3fgw
         2VTgRBPpNQf+1mODbaMDOTbP2EdZniemteyLffTzekV8tCSNAf9lphIjOcSRyL+RQcIc
         ML7NYShaTJgPOtojGL0CVxC5oQY9WN/L9nPgnTn3HVw//Dh59prlh8pcyd+XaEx/SB3Q
         kelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DsQ4/8Eeg48radubstj3W86Jg99jiR+oV9E1n8D4GNQ=;
        b=HY09Uz4iAp5XOF1cKHJRxqvUkrJXYaLXBnOvpHQLveQDeAE/oMQyYOYMnpdhdPvTWE
         vMePWzVfUrry+iM0mlTXletmsXrlkHpxUX21JV4b0DuE+kDYTzJ2nqTq/bpi6+q3CmXZ
         OFvMJmw2MyuY+gB3LXrKjD5ZEONm7c8CIEp39csHU3rvMFvpWPUjmcXu+5hOsp5MM7RZ
         020bFqHCv+5f2LEUBldkXNidOiUgAOM4dRfpqQ8o3rc46/bbRgdU1BudpkWIOcKeqxyQ
         IYbmxT7VFrfFcIEaoAT56RQ5uCgW9ZLLePd1t0juEC6XZmXqRWwZooaan9FvkAahOTlW
         fcfw==
X-Gm-Message-State: AOAM532uCQOdU3TQx28VHhf9MFRH65YHj22cekLo71A4DvKm7eMRQn5L
        pkur1AkHKBC3+WfwAUkclU8=
X-Google-Smtp-Source: ABdhPJyvYEaiFvMa30DsJkDeRyCvrpgPSfriaU6oJJf5Mu7lThAlj2xWNI1UgI2KAqsyRAHH76aVAA==
X-Received: by 2002:a05:6a00:8c5:: with SMTP id s5mr4140612pfu.18.1644322496229;
        Tue, 08 Feb 2022 04:14:56 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.14.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:14:55 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 04/13] ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
Date:   Tue,  8 Feb 2022 20:14:29 +0800
Message-Id: <2637464fd8f6b8bae6c681f20c10c9fc76dc6d6c.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The "struct strbuf"'s "len" member is a "size_t", not an "int", so
let's change our corresponding types accordingly. This also changes
the "len" and "speclen" variables, which are likewise used to store
the return value of strlen(), which returns "size_t", not "int".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3f0225b097..eecc7482d5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,7 +31,7 @@ static const  char * const ls_tree_usage[] = {
 	NULL
 };
 
-static int show_recursive(const char *base, int baselen, const char *pathname)
+static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
 
@@ -43,7 +43,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 
 	for (i = 0; i < pathspec.nr; i++) {
 		const char *spec = pathspec.items[i].match;
-		int len, speclen;
+		size_t len, speclen;
 
 		if (strncmp(base, spec, baselen))
 			continue;
@@ -65,7 +65,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
 	int retval = 0;
-	int baselen;
+	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
 	if (S_ISGITLINK(mode)) {
-- 
2.34.1.403.gb35f2687cf.dirty

