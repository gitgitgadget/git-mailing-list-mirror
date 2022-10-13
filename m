Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFED5C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJMPlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJMPkf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78805A158
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u10so3477148wrq.2
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiqSWjTCDmqq1aqGUKz1fZfhzN1dQfEOlZkxt9BA9lY=;
        b=fbL0AeJs21Ylzgh+l9nafnb4d5s6AdVvXtvTstDRSnaqkAs+QN8+zlridF/AThP4WA
         GGsPQZ+CfIQmveJNJkFcdHaWk6kO9g+8J8C1U59hbsUICPkMlTM19TdB+cga32bwJwP3
         5091T0z7D9rgDwjYQ9oKeS97J/FplZXRzVbUleu3cKJ9j6EQLMv2fdi1znSw5lEidLL6
         Gf8H2qKDT+9PFOBZeoGCydZTWgQYh+hkcXs5TAxkoXuCH+J77lFmrN1zkubq1uj4JZBi
         fi5WwS/+/sSIQqpkRb4gCq9Qenro4qjCVpiIVPK90LQBZuG2jJj/QYJUxQW79FSCgZtI
         rOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiqSWjTCDmqq1aqGUKz1fZfhzN1dQfEOlZkxt9BA9lY=;
        b=McRthpSr3dUQ+GvEssIGCjvklI4OgoJ76QAkA+LQ2pZdcFz2adYWvmVwiZNTwzf4mr
         Cj5idxEaIGgeuA8kIOZ+UfZO9SV+r70TmKcVVIM8H1j9+YH8FyApQdHGbXLEeJ6yg1Q1
         A+V+XNpOjFTNyeXq6Ml3dFVhCkqkGDmArnJDv7OKckCIHVLfHfncJ/HRrQn8WwGiBsqQ
         6MCXAoRKuNltOzYUc1+z3jvDrrt3IadEPgos2hzlqL+ej+uR9SHAPQP3IpTj1GHkde6P
         ufGYS+1Mcfhe4mrKycb72aXmdDpjPAFkUyda08iRzIRD1hHTdOeF7BMeOaBrVOVwcLac
         OWwA==
X-Gm-Message-State: ACrzQf3gK3m8N7DUa/ibrxafQW5PSSNzIGbu994ZZAxQWJj++6Y74Jkp
        0GhJY4L3aM4XI/m9Xj+o1triRE5wUt89yA==
X-Google-Smtp-Source: AMsMyM47wtr5+sC2p1xipZg3HdWC/ODP6tDa9n8FHwaPiCEI+rE/pqNz+ouk0CrEF7qmymbcw+9+oA==
X-Received: by 2002:a05:6000:90b:b0:22c:beec:5b26 with SMTP id bz11-20020a056000090b00b0022cbeec5b26mr404616wrb.490.1665675597834;
        Thu, 13 Oct 2022 08:39:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 22/34] doc txt & -h consistency: make "bundle" consistent
Date:   Thu, 13 Oct 2022 17:39:16 +0200
Message-Id: <patch-v5-22.34-c616f2e9129-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the -h output to match that of the *.txt output, the differences
were fairly small. In the case of "[<options>]" we only have a few of
them, so let's exhaustively list them as in the *.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 1b08700bf9e..544c78a5f3a 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,13 +12,14 @@
  */
 
 #define BUILTIN_BUNDLE_CREATE_USAGE \
-	N_("git bundle create [<options>] <file> <git-rev-list args>")
+	N_("git bundle create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]\n" \
+	   "                  [--version=<version>] <file> <git-rev-list-args>")
 #define BUILTIN_BUNDLE_VERIFY_USAGE \
-	N_("git bundle verify [<options>] <file>")
+	N_("git bundle verify [-q | --quiet] <file>")
 #define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
 	N_("git bundle list-heads <file> [<refname>...]")
 #define BUILTIN_BUNDLE_UNBUNDLE_USAGE \
-	N_("git bundle unbundle <file> [<refname>...]")
+	N_("git bundle unbundle [--progress] <file> [<refname>...]")
 
 static char const * const builtin_bundle_usage[] = {
 	BUILTIN_BUNDLE_CREATE_USAGE,
-- 
2.38.0.1085.gb7e61c3016c

