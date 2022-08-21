Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5C2C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiHUOCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiHUOBx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B4523179
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r16so10294371wrm.6
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=J+xExqhEixb2KW+eJp2hsrdB3+hxtmC7wEwGHi5sDuk=;
        b=FpycKu7KVOBKtPdAo9SBDEhcOpB7rLSsOvf5N8eIyuTrWtZRaD/Gd/ChYbIuT40dSB
         TUfJtd68lxniu2wtrFyxJwFgkfrGwfed6q5HB+E1xlljJZyQnUw/b1ymho+z7g/gBcUs
         MykHQv6pVJHEzg3rvWpoIiiu+glUMNgNLqXgvluAoRkQFlZslIqKORace+eKlH0xo6jK
         fK/d1+UNq2fzTYnN4ZyeezVAJVij0TX84QevKl9nPWhRSw4CLTdqpByoWHd8s6he2wM0
         qDsAl88zW6kTDrQ86h/OwBtDjmT6/5NQvn1TXkbwfZybqOICkm6WrgosZawrDAEp1k6A
         AtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=J+xExqhEixb2KW+eJp2hsrdB3+hxtmC7wEwGHi5sDuk=;
        b=ycgQ1ot5Xg5+sqOUp4YQBLpOGQ9wbanhH9m+7FS9DjKI3CJItBoSBq+6b32cPhdYvQ
         TlKO762nRu7eEsWa/qqjFX9EK+wrVpOAANnTsS8ITFhPvoaSJms8nv+D/GtMWBXHD8fi
         ieYA2tU6bgP4WOUWY/LehvjdoCBkZKqOMNRrcJV83R19gwsuJmgBXUoUlYENgASqVRsJ
         azp30BehPLNOTFFt0NV6lyzPlzJ4A4bxcUgeCSJnlsoImAvvJWcwsPX1vZUbMbeqAEQa
         CGhhrdryhIAcY7OWsu6JR0czrw01RqjU1JTmIY957YFKuQtKaiyK3n3Ri7XQcYvF7DdD
         2CCg==
X-Gm-Message-State: ACgBeo1ROxlyoqsd+SxLQ8cqPmdzpNCcT4vYH3XqygblAUNZY23PX7wY
        GS1G7fXS9WBUSI8ch3QLcUZZPtKsxwTq9O2+
X-Google-Smtp-Source: AA6agR4uq780ANSQJfdpW92FW+Bg/MkxDJd5uxBUVuRO2Ey0ee4J5Y5kQWsFjgnK9sKkLf0s++ULdQ==
X-Received: by 2002:a5d:4391:0:b0:225:2dd3:13c0 with SMTP id i17-20020a5d4391000000b002252dd313c0mr8270529wrq.102.1661090473192;
        Sun, 21 Aug 2022 07:01:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 10/17] submodule--helper: fix a memory leak in get_default_remote_submodule()
Date:   Sun, 21 Aug 2022 15:59:34 +0200
Message-Id: <patch-v6-10.17-84f162f320b-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in the get_default_remote_submodule() function added
in a77c3fcb5ec (submodule--helper: get remote names from any
repository, 2022-03-04), we need to repo_clear() the submodule we
initialize.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b029e109b47..3f123f014f9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -65,12 +65,16 @@ static int repo_get_default_remote(struct repository *repo, char **default_remot
 static int get_default_remote_submodule(const char *module_path, char **default_remote)
 {
 	struct repository subrepo;
+	int ret;
 
 	if (repo_submodule_init(&subrepo, the_repository, module_path,
 				null_oid()) < 0)
 		return die_message(_("could not get a repository handle for submodule '%s'"),
 				   module_path);
-	return repo_get_default_remote(&subrepo, default_remote);
+	ret = repo_get_default_remote(&subrepo, default_remote);
+	repo_clear(&subrepo);
+
+	return ret;
 }
 
 static char *get_default_remote(void)
-- 
2.37.2.1279.g64dec4e13cf

