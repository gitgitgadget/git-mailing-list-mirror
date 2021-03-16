Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE11BC4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B317A65101
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhCPQSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbhCPQSN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C51C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o14so6976301wrm.11
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTEfu+yAtM4EH9C+MXnOphrNzv2WHfSFRJGRl2nPKgQ=;
        b=aE75Q52FmaMBFbBmSVJKiNUUNvVCkabWXgDzaPAZW3gNtxHZJEP7N6JB0TnLm6n/vb
         o9EEVwNFm6NgSlC456w/RJ3+mfm84kvHMlfP+gN8KABOKsvB7ffw+/cNyly56KTlLo/A
         jM2Y0GyFZ90YFIqVGTwVUhDgIXpF33gjJp7NHaLNyigc+zTNFuoNsP10IXsLw2nL7rTO
         CcJFYTdcBJ6AabUcYd2K1hN9Jt3z5V2C0ONKVmBXtYOK4TiFQWg1vD/+HcAuC9ZhmzUf
         2FdrIYi0RchYxgjJZbJ/Aoma/zviFIQErVhceHL1FLyladlOaKhlS6sm5ONTJlhrq9wP
         zeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTEfu+yAtM4EH9C+MXnOphrNzv2WHfSFRJGRl2nPKgQ=;
        b=Wztao2bbKolcIBemZvjhkiGHDHnTxnJYDpsHLZK9FWem6PC5+FICagEgrlPb3JHLaE
         y7bOpa7X+WfTThlWi1LyiTkdKfBHQdRGqRGR360TXdDMMDMdglhxFKxwwnw181G5wqp2
         a3dnNI+EkVrfknujEFnhEzFWTmIhgWlPsmiMu41/jIKIbbMg+Gqa9LesR1guPjodWOM4
         EdRrstjBr/HZ467JTvD2q04qWdNJDK2Swy5bklQn9pAOfJynnmUI9dcW3NsiEE5vBSeq
         DE55SZKR1i1AJqQgxMEO7tuOAdWtlZ7YAckXQbCfFJv5wxIUigbhCXrZ7y+rcEyFbqdn
         KYBg==
X-Gm-Message-State: AOAM530Z0JrLNzyJz3XmoZQwCp4urL4auu89wLTuBbTWGMS5bPdWgVfi
        T17ub8FZ9sol2BUfBtREpQ3z4QNrn71hsg==
X-Google-Smtp-Source: ABdhPJzVVOk6JEigOqjqLw5VonpdZItinSIx+1W14J4pior0UDPkdFcdKLBXbq9cAlqREBXrI+4Wnw==
X-Received: by 2002:adf:828e:: with SMTP id 14mr5809190wrc.123.1615911491264;
        Tue, 16 Mar 2021 09:18:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 20/22] fetch-pack: don't needlessly copy fsck_options
Date:   Tue, 16 Mar 2021 17:17:36 +0100
Message-Id: <20210316161738.30254-21-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of the .gitmodules validation added in
5476e1efde (fetch-pack: print and use dangling .gitmodules,
2021-02-22) so we're using one "fsck_options".

I found that code confusing to read. One might think that not setting
up the error_func earlier means that we're relying on the "error_func"
not being set in some code in between the two hunks being modified
here.

But we're not, all we're doing in the rest of "cmd_index_pack()" is
further setup by calling fsck_set_msg_types(), and assigning to
do_fsck_object.

So there was no reason in 5476e1efde to make a shallow copy of the
fsck_options struct before setting error_func. Let's just do this
setup at the top of the function, along with the "walk" assignment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2b2266a4b7..5ad80b85b4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1761,6 +1761,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 	fsck_options.walk = mark_link;
+	fsck_options.error_func = print_dangling_gitmodules;
 
 	reset_pack_idx_option(&opts);
 	git_config(git_index_pack_config, &opts);
@@ -1951,13 +1952,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	else
 		close(input_fd);
 
-	if (do_fsck_object) {
-		struct fsck_options fo = fsck_options;
-
-		fo.error_func = print_dangling_gitmodules;
-		if (fsck_finish(&fo))
-			die(_("fsck error in pack objects"));
-	}
+	if (do_fsck_object && fsck_finish(&fsck_options))
+		die(_("fsck error in pack objects"));
 
 	free(objects);
 	strbuf_release(&index_name_buf);
-- 
2.31.0.260.g719c683c1d

