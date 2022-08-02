Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E5DC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiHBM6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbiHBM6E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:58:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7992712D22
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:58:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so17795083wrh.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1WRQvpEnWfF3xHTI/Qhxe6+hvIeHJ+v7wmsDy8cTII0=;
        b=FtoQc4IXRnDVvdwDlNF/ABvQY6GHrEs+LshJwzIMD3TnYGHm+iikozku9opBNxFr5j
         iAZf6xe5WCaFIeYQ9Yhcz0k0U1Hc2Hm2yazIocqkqtKCwYYzHpZVlaeqmgELPTbwekBO
         hVkBSGsKTlRe17ctuWCgoa0IObWThAxrRTinx50v9gn6kPQ0d2VQZaut08i0zeQB5Hsl
         Aqe2o8rIob+jeUIEfWku2w/azUTHNXASnzgL5dr1mAcynBWfoioxDBzvPozLDJ7R8MDT
         NOMzGiLUIW7x5zai7LzUrjfXBTapy6JVzp7gdjhSZn6X4ikCtiTASkHmHRVNCJr6rGgl
         hUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1WRQvpEnWfF3xHTI/Qhxe6+hvIeHJ+v7wmsDy8cTII0=;
        b=P+gtLJU4Ia7gpvhBMt8pJyjCgHgxcfwmdDJth8MsvVym2dydiAgyqznjvjwV4TuDGw
         lquRi8B9g7/SYqhevoHujqVwi6v1jH31P9YYJzVoyxY5vER/D7ss2IZGVwzrf0A1hFgd
         9MLcFXMJ5HNjQK6qAxGXhZivQ0dTuDuyEg6DR4JtdHQcy8SgxAyCXWcfy+xyu/9mEV6I
         i+1pZOrB/jzIQp1CokvOyHN2F0uJQNTZi97OZ2mrFDSVV1F//BZp6YUndSKDGgw9wTax
         SCBBJHAnT09gP7m3jsczv7Y1colSltGvbq+EXjLLgKTYRDbznIrJLzc1ul4513OZcnty
         sNzA==
X-Gm-Message-State: ACgBeo28z9Yot5Bl5td59DQbme+g+FjoTRkGtQ3MzKV9ur/P3xQMtlK5
        TJLnUkXtWqZH1+bR+NwyR6OsylPCJ2dQrw==
X-Google-Smtp-Source: AA6agR7bL/O7WzQXcw3qoWQqUfxrHUsoajtHXNN6++O8i3H6iitw2NnYh2IkxCkarpJIoIayDY2Wrw==
X-Received: by 2002:a5d:6d0f:0:b0:220:76a3:b31d with SMTP id e15-20020a5d6d0f000000b0022076a3b31dmr984384wrq.581.1659445081724;
        Tue, 02 Aug 2022 05:58:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm15056145wrn.109.2022.08.02.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:58:01 -0700 (PDT)
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
Subject: [PATCH v7 03/10] git help doc: use "<doc>" instead of "<guide>"
Date:   Tue,  2 Aug 2022 14:56:52 +0200
Message-Id: <patch-v7-03.10-2d6c00a51fa-20220802T125258Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1232.gc0cde427aa7
In-Reply-To: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
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
2.37.1.1232.gc0cde427aa7

