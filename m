Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA7C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiFBMZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiFBMZr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:25:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2AB13274F
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:25:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q7so6260606wrg.5
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhyCczOzNCyndWdhBfvIb3qUffK7mzN60WVMVJTld0k=;
        b=dHOgnsbWr1M8AHf/LgEhdAXG9Veu/HGVJBgYe/E+3G/N7cwV4EvLeS37LLjlhnrvGm
         x+aH7bExBIU92iOFAwblWx4f4DV7uvrzxRb7p678+gUXvAU+VETIXOzTPCArvmzsfNON
         w0o3onztUgVHl1xUD9uVixXrAJowCLJFZV8eoz6sAl8Dgq4BxJwKa9YVzqvFp+Yq+Mtx
         ILfI93fwjuHVIFihHhhv1IX+HrDoOKxwrqFgIfr1Pmp4F6NWEy6TFJn4NNcDuVU6FUv+
         snyCQ97VuYG0ZeMjasYhR+93UJ0fWbbDT+Fg0mi0PFGdHeMG5BOlSqPafJ+9miLECoTm
         xWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhyCczOzNCyndWdhBfvIb3qUffK7mzN60WVMVJTld0k=;
        b=4nZYwbdJsPiaOMWtu0EaYi+SDf1DBlYn2SOyToIX//pborXl/NCeb7ca6AY5Qs4m1C
         aJLZ9IBX84ZIktOz2DoLr0UxaFBNRb9g61Uff9yGEHKNy70mP6z8sqCvey+wfu+OH9/i
         KivdLEYuKRGExiZU7HrV+EoVmOQSG78qIUtKs3v8M6J/RfipevO2Hx4cJcrmgURAIzrz
         J51k36OoXcTWPg9cccfxlbv+o8zhylUM5PD0DqJawqtPPQtP5R8r2Kr/x0sb6aTNYYeV
         S8JX3X9aGo1nyW8QFXgcITL6ssErlIY2i0p6uFjUFtkKevDt6UgyVwpeClIEPa5muw0o
         SHyg==
X-Gm-Message-State: AOAM531RFJvqkC5Y4VVZaEJoqraXSvoeiETw5CvTVFKqw+zVexnCicuq
        4eV1eis3+Vhh/TzTlkwvHtsQFqa+IigMsg==
X-Google-Smtp-Source: ABdhPJxje6Z2g5DfV6b+3FEwnmXQNxKCryKickeelrYJ7r5/uVIOl8O8+9HZNNPVcsuLFl0zj39XPg==
X-Received: by 2002:a5d:598e:0:b0:20f:c2fd:de44 with SMTP id n14-20020a5d598e000000b0020fc2fdde44mr3507779wri.178.1654172745831;
        Thu, 02 Jun 2022 05:25:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm4305100wrt.7.2022.06.02.05.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:25:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/6] receive-pack: use bug() and BUG_if_bug()
Date:   Thu,  2 Jun 2022 14:25:36 +0200
Message-Id: <patch-v3-5.6-05fb94aee6e-20220602T122106Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend code added in a6a84319686 (receive-pack.c: shorten the
execute_commands loop over all commands, 2015-01-07) and amended to
hard die in b6a4788586d (receive-pack.c: die instead of error in case
of possible future bug, 2015-01-07) to use the new bug() function
instead.

Let's also rename the warn_if_*() function that code is in to
BUG_if_*(), its name became outdated in b6a4788586d.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index daa153d0446..4a62327dee9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1810,21 +1810,17 @@ static int should_process_cmd(struct command *cmd)
 	return !cmd->error_string && !cmd->skip_update;
 }
 
-static void warn_if_skipped_connectivity_check(struct command *commands,
+static void BUG_if_skipped_connectivity_check(struct command *commands,
 					       struct shallow_info *si)
 {
 	struct command *cmd;
-	int checked_connectivity = 1;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
-			error("BUG: connectivity check has not been run on ref %s",
-			      cmd->ref_name);
-			checked_connectivity = 0;
-		}
+		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index])
+			bug("connectivity check has not been run on ref %s",
+			    cmd->ref_name);
 	}
-	if (!checked_connectivity)
-		BUG("connectivity check skipped???");
+	BUG_if_bug("connectivity check skipped???");
 }
 
 static void execute_commands_non_atomic(struct command *commands,
@@ -2005,7 +2001,7 @@ static void execute_commands(struct command *commands,
 		execute_commands_non_atomic(commands, si);
 
 	if (shallow_update)
-		warn_if_skipped_connectivity_check(commands, si);
+		BUG_if_skipped_connectivity_check(commands, si);
 }
 
 static struct command **queue_command(struct command **tail,
-- 
2.36.1.1103.gb3ecdfb3e6a

