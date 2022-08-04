Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A09C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiHDQ3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiHDQ26 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:28:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C11167145
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:28:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q30so279239wra.11
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IwncVoVjz1JUEDmFPKiYzPwvEOmRiF4v6+W7zuudTCM=;
        b=ADq6HwSYIaw81yUeQLpwtZxECo9aoaAOLbfNG8LObzWisclgEyzq1lOK9NYb2EGZjg
         K/c2h4dqa219uXrlV9WKSiZPhHwoKavdZbdmE6Dxi9nEft7GFHBg1lejzs80TOyNdbym
         YwCW7DZOLo3XPIfbX8cCKef9c4JVQh1xQi26PhvNb7yXf6cQJErk38kql6/hO1kEBTHy
         ZESOYmpEfTpz73/1yuFSuA1FlHPGrLcOmN87UQNm3+25Sbm9PSivUB4eua5hE6TJ4/vs
         nyt8S1nzphzMCjjaORhSK0JwIPZGYBLpk2O+YyJENtOChTXKOsPJoeZPQ/XWP/tDUCl0
         RDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IwncVoVjz1JUEDmFPKiYzPwvEOmRiF4v6+W7zuudTCM=;
        b=IkHu3S10MBeP1vr560fpxYj8gm+L+fSTCK4O16jnDRIczFuRHiJSl+uCQRKon9IA+Z
         JbdnscXg0Ga4JvVo0xDwRJJPdCNSJbl6oygJQAvZbxk7MFRiqmjECKaYNgYBp23zb74o
         pTk9z8KYOwIVZgnBIZbj+ppsJ4lSN2uidK4NjR6ROWFHX5csIz2WJdRXD1PyosqHkvIA
         ZrfjhjQjEgkknkuExscL/N1oQTQ5ayzdsFnT8BWTRiDOWwhHEGP9AM4EB7bHhHJKVX6M
         jltMSY3D98paj5gK9d7w5NlG+G/z1svBvVZojoQekZwesYZPurAotjFfYvMOW/FyR+Xk
         df+A==
X-Gm-Message-State: ACgBeo326U4ryezS2QIl2kSl0RBk4LrHqzCzEl0HWetqNNbK/8azr6tz
        wBTItMCQKqxTC0Rx3nNoZigAvAAV1Gc=
X-Google-Smtp-Source: AA6agR6IWgZxaTFtTEbre0l/9gC7z7g9HLsr0tDGgbX21+Q1uUK5WCrPOxGlxOJg+KgbXR5WhwteAg==
X-Received: by 2002:a05:6000:235:b0:220:3a22:fe38 with SMTP id l21-20020a056000023500b002203a22fe38mr1966825wrz.419.1659630535710;
        Thu, 04 Aug 2022 09:28:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm1868063wme.27.2022.08.04.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:28:54 -0700 (PDT)
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
Subject: [PATCH v8 03/12] git help doc: use "<doc>" instead of "<guide>"
Date:   Thu,  4 Aug 2022 18:28:32 +0200
Message-Id: <patch-v8-03.12-6c3c072de6f-20220804T162138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.g61622908797
In-Reply-To: <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com> <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
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
2.37.1.1233.g61622908797

