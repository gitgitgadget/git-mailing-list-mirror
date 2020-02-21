Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C94C35669
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 20:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B092064C
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 20:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vT/AoMSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBUUP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:15:57 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52507 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBUUP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 15:15:56 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep11so1246012pjb.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McMXfzrgyuI+S0Bfx9Yh73wO0DKlsjDZNX70CHd2hTg=;
        b=vT/AoMSwRlwsrrdAGhyza948TaOWLJfhM2kodyW4iO+mmj5TC/mNaUQ85GQJS+qNok
         N8mlRd3NLfmv3c+UMG2UEyhrodRCSnxQsltklPLNELc3Utq5SDN25gjadUXNn7c66XiF
         9mmaf6+9uQMnW2i/mUJ2U1Iojofz828UUVNWmU4r8nP7r7KIKQEc3fcGv5mj760+D0Es
         kSbMVuBgvblpgiQpV9u3fRv4HM0EsAioU3xeIBvflGgJZXyEKjeKM2Z8PA7AQFJK837A
         dLmU81bRAoChY++W6DRlR0E/Uj2zAZvhKnze1pJGP+IevHfVJEY7Myp1cP7uFz4In8j7
         UDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=McMXfzrgyuI+S0Bfx9Yh73wO0DKlsjDZNX70CHd2hTg=;
        b=Z4TFORTNw6XNLzlAy+Ywj4TxoFjk8y/sY1LnF81K+0bVm1Y+2u/tB/FfYuUp4KqRyj
         efzA/oybs7PuZSvHD3HAVHF2u+i3MTQenJm+1lCwCbXOz1p63ewjO9DIxJedFLQDh6ox
         0hCXD+DeY8guNuTO2kTXaroE82Ki3fmMuphbWDPoaJy25eVM8zBbrZznDYwDBRBVs0jw
         TMdXKZJ0VPsgkI0u5Y+hLHNPOZv7oEK0NbFMk/iDrl6ue6bo2ExMmpBu2oQmu17peerU
         fKhHDNsJrXgdpi8zJU+iPakfxjXmzB/s5HEV1q58fEdpRjwniEylNLKo2UYagZ27c053
         IdkA==
X-Gm-Message-State: APjAAAX5VQ5r4EP9MXlnBR4QWwjvkSQD8y7RydazAhzt6ZlXEIsfgsGd
        NpkyV203z/puSLSR3RjQAdY=
X-Google-Smtp-Source: APXvYqxCGdhP+169vkF4nXc3ddZSIJ72gpZvRjt2pVEEELPOCAmKYD7+AuNtf6tZfPF4BGDKUFsVvw==
X-Received: by 2002:a17:902:6b4b:: with SMTP id g11mr37372770plt.26.1582316154620;
        Fri, 21 Feb 2020 12:15:54 -0800 (PST)
Received: from localhost.localdomain ([73.109.61.121])
        by smtp.gmail.com with ESMTPSA id k4sm3677610pfg.40.2020.02.21.12.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 12:15:54 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        matheus.bernardino@usp.br, Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH v2] completion: add diff --color-moved[-ws]
Date:   Fri, 21 Feb 2020 12:15:45 -0800
Message-Id: <20200221201545.1244861-1-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220214647.451064-1-kolyshkin@gmail.com>
References: <20200220214647.451064-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These options are available since git v2.15, but somehow
eluded from the completion script.

Note that while --color-moved-ws= accepts comma-separated
list of values, there is no (easy?) way to make it work
with completion (see e.g. [1]).

[1]: https://github.com/scop/bash-completion/issues/240

[v2: added missing ignore-space-change]

Acked-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 contrib/completion/git-completion.bash | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1aac5a56c0..348f0c0c57 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1487,9 +1487,16 @@ __git_diff_algorithms="myers minimal patience histogram"
 
 __git_diff_submodule_formats="diff log short"
 
+__git_color_moved_opts="no default plain blocks zebra dimmed-zebra"
+
+__git_color_moved_ws_opts="no ignore-space-at-eol ignore-space-change
+			ignore-all-space allow-indentation-change"
+
 __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
 			--no-color --color-words --no-renames --check
+			--color-moved --color-moved= --no-color-moved
+			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
@@ -1520,6 +1527,14 @@ _git_diff ()
 		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
 		return
 		;;
+	--color-moved=*)
+		__gitcomp "$__git_color_moved_opts" "" "${cur##--color-moved=}"
+		return
+		;;
+	--color-moved-ws=*)
+		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
+		return
+		;;
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs --no-index
-- 
2.24.1

