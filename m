Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D54C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 13:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhLQNae (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 08:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhLQNac (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 08:30:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421CC06173E
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:31 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j18so4110655wrd.2
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 05:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYxdAnePyvzN1gZSK37HFkGaUzmGA9uEkRJR/8ax64M=;
        b=Cac/frm3fhAQUlmGLh+gTTSy39h8JsUzuVAYftF1o8v3zPP+nwajjnaQ/7GgEdiFac
         1oECdIyKGVg/sOSomMC3cC7c0Mu+hR2avwPiqPCyH4w3QBV9KEcn9eWceUVzHKVWeSSY
         o/QUbz2x34Y3i/4Tskz6WF1fGz+UDcrQ6FDnBgO7zcONlgatAV8OJUc7d7KOUuDegNUS
         xTqYse3IsWfn4KWqUe48ayPleUxTFqx96TOVzhHVkqjOaKj3eYHGrJJENlkOzHLWwSFd
         n7DJt5b9xCmLCA9U1rs+nYMPNFHxop/LKHjfMPZm2mJio6iD951m7y+hkgbjF8dJk1Nk
         aJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYxdAnePyvzN1gZSK37HFkGaUzmGA9uEkRJR/8ax64M=;
        b=Lgt8SazoEhZnzkYOaO6aWfklzomuwgLGMISLYi9T1P85BFJ/lXkLTgOIJ9xI6qElme
         v/kAKjeVm1BDZt0tCeq9V5Gp1uhkoigJMAoaHQJbjnoMbnD/VMbg1IQ94BLIALOKcM5x
         B+ngU1BMUkZFgorHhJnp8PtDRUq3u97Rj4sYMopnHfDHgWO/+3ZUE0xmuFsNvpURoqKb
         6J8sOnOzvbStLpIBumODunTqYnfeBlgf3hCN2jqd3ZnIY+3FnbHdFjAOchaPuSGclkGG
         Uuvdte/4iQ5altXL/lsZnNkOXzWPGKrHz/qKcwMTSj8SKFCs8ZO4TaGUFDFlr2cnjOM5
         hcIg==
X-Gm-Message-State: AOAM532OoXUUGb8Y612/ozonpZ2yks740inP7k1vdPei7UzSOd6nvck7
        dug39eyLy89qYbthOqlf6lHuLOv6e3HMEQ==
X-Google-Smtp-Source: ABdhPJytmxpsM89Wm6VnoxsEYZciNKOyq0U91ijX1Fc12N3kLh+Xpd2Qg7sXcou3s2uCo5BxnxG+PA==
X-Received: by 2002:adf:f049:: with SMTP id t9mr2580453wro.399.1639747830055;
        Fri, 17 Dec 2021 05:30:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm11953993wmb.38.2021.12.17.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 05:30:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 4/7] ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
Date:   Fri, 17 Dec 2021 14:30:20 +0100
Message-Id: <RFC-patch-4.7-721f56ecdac-20211217T131635Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
References: <cover.1639721750.git.dyroneteng@gmail.com> <RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "struct strbuf"'s "len" member is a "size_t", not an "int", so
let's change our corresponding types accordingly. This also changes
the "len" and "speclen" variables, which are likewise used to store
the return value of strlen(), which returns "size_t", not "int".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3f0225b097f..eecc7482d54 100644
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
2.34.1.1119.g7a3fc8778ee

