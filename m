Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A43EC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiGUQPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiGUQPC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:15:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C758AB06
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:14:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so1087262wmm.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vm3YP1KeoHropkb/SkT28z+ueMp6Lg3iPedit4zoEic=;
        b=RKnDcO86Rvh48szkY3vGyw5/NmtnfA4bHtPrJ/bDrTZG8z4DMPvH77YkMVrLd7ZBXL
         HB+gJzxKKKJPQZm3gLhyqkqHcxZWURAE5qQ1XZYj+YuekjPYqROaojxQBCTjMD+Cawf2
         Kqgo9qw9rtx4IAnwPpUpgWJ1Y0ENR4MeYNtxGdn+nVT9i1BQbtA07kxIaaJwya0FdfwD
         ioBT078jaDreSi8NLfmr4fdq5CTqU1ONJfjEvJ8JjavhYXFXwWk0EilHQBjxKdjU2jtt
         73+Awp8PDh15MpNkzmEu+A61mFDlPBuUghXrJIpcidbTtP7hm8GmdJAFIcU0iT/HfH1M
         cuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vm3YP1KeoHropkb/SkT28z+ueMp6Lg3iPedit4zoEic=;
        b=J8Yq6CmOiC3JQS2NdJ6OKq8y7CiOUvbaCOZuQfje9SWbQVGnIveWNxDtf4F7EIYQQV
         vNtYtHtM2k5XfkJcbxYze4HXPXDFz6uEdjSfqkCGJ/bs22v533oQFafIzH3vm5J5oVV/
         UTxogFIayIqOHze9M/mPMkKfMvM9xT0DTWBYI4/I0Afay44hgKZ1GDRI6IbQKjjhjChE
         Y2+IqOGAKD4UZdLTbeqbjFD1Q6MAG/vsqWNIo556r/kMU/Oj+ryZiSrocZbIu9q990Qr
         EV23ySoRwOgSECkhIRaCYroLVN/LrXzSObEmBNjkJEv6N8M8iTac2l2VW+lwrXNJr8fJ
         D/7A==
X-Gm-Message-State: AJIora/hsizwTS5/j8HQLlKprok95aNoxfVDf1DkIxMJUVnRU9Li4r5r
        wluZQTeQGQACmy7rsSj7raBhU7h++60hGQ==
X-Google-Smtp-Source: AGRyM1sLuZBorPZ4wTqvv780Lypf/8F/cpSayS6ZeZ7k1z0O+kIq6mE1zQYwENylW9G+x3rb0znAUQ==
X-Received: by 2002:a05:600c:4ece:b0:3a3:1ce4:1e05 with SMTP id g14-20020a05600c4ece00b003a31ce41e05mr8871277wmq.25.1658420056934;
        Thu, 21 Jul 2022 09:14:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003a2f2bb72d5sm8498608wmq.45.2022.07.21.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:14:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/9] git help doc: use "<doc>" instead of "<guide>"
Date:   Thu, 21 Jul 2022 18:13:51 +0200
Message-Id: <patch-v5-2.9-2ec00f81552-20220721T160721Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the use of "<guide>" originally introduced (as "GUIDE") in
a133737b809 (doc: include --guide option description for "git help",
2013-04-02) with the more generic "<doc>". The "<doc>" placeholder is
more generic, and one we'll be able to use as we introduce new
documentation categories.

Let's also add "<doc>" to the "git help -h" output, when it was made
to use parse_option() in in 41eb33bd0cb (help: use parseopt,
2008-02-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt | 8 ++++----
 builtin/help.c             | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 239c68db457..bead763fd29 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -9,14 +9,14 @@ SYNOPSIS
 --------
 [verse]
 'git help' [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]
-'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
+'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
 
 DESCRIPTION
 -----------
 
-With no options and no '<command>' or '<guide>' given, the synopsis of the 'git'
+With no options and no '<command>' or '<doc>' given, the synopsis of the 'git'
 command and a list of the most commonly used Git commands are printed
 on the standard output.
 
@@ -26,8 +26,8 @@ printed on the standard output.
 If the option `--guides` or `-g` is given, a list of the
 Git concept guides is also printed on the standard output.
 
-If a command, or a guide, is given, a manual page for that command or
-guide is brought up. The 'man' program is used by default for this
+If a command or other documentation is given, the relevant manual page
+will be brought up. The 'man' program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
diff --git a/builtin/help.c b/builtin/help.c
index 222f994f863..dec82d1be27 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -81,7 +81,7 @@ static struct option builtin_help_options[] = {
 
 static const char * const builtin_help_usage[] = {
 	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
-	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
+	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
 	"git help [-g|--guides]",
 	"git help [-c|--config]",
 	NULL
-- 
2.37.1.1095.g64a1e8362fd

