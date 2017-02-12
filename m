Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EEF71FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 18:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbdBLSlj (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 13:41:39 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33496 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbdBLSlh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 13:41:37 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so5817298pfg.0
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 10:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JWeHXMhetDxqx5MgWCnDOFz1nxftfBpBgaxk7htve/c=;
        b=lyemetUSqIxuNjA+b2orQ03FkmDt0W0AHYafzn9kVhm7v5nMt3tDdOaLZ7z5sjF8tR
         V2W0Z3C9BlVGpSoZcSfsbsW81E/lvsSzcQDOrLpBkPe9rdyfZuLlvepRFlSFVE+aV3E9
         43ip76gwEWV/x92qG3IeJL7ThlJzOSy4NNs6cv1MsOGUtii15nIoc4YD6fiahlz3WYz+
         uQ40xVXR28sJKLW/fflio0PaDvIV1WFBXQWVPV74HE5HQSa6Wqzt0sVMRSwyCltDiLvl
         uBYnu+W31lhReHNZbZTzA6X/h/6XBlni2OsNUSS2BrURfKW9z9CjcQRcaDVQ5Hd7stjq
         OI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JWeHXMhetDxqx5MgWCnDOFz1nxftfBpBgaxk7htve/c=;
        b=Z7uflfStMi+ULPYk2rMqIUGP+lxa/nJDD9bQ8JmKuYb4Dd2MYHRyApREMEr8pPuH0F
         A+kgfwt/s8ig/yYMgD9VZCSkb+snTjULiq9+2JyMqe/yRUXjZko58XHuyiabvjA0xYBX
         TvmOSpaNMaRhtOh98+7/fqIDXad0OOuI0vG2ikytqhy/hp/tkqMJR05xN1XVSRI3oc+Y
         7TU2a3kFk6NGmmrKRDTTsUrUO6YErPa3COmPVLVw7jE1M7QDMNDi1vJmtENpRlJIif0O
         hf8i831gFRZcXzDBGjlImx+DQ5hASMww45Z5wozi/30fpmfLAvk0vKs/n6Cq/44ukRDq
         4qqw==
X-Gm-Message-State: AMke39ko9OEUQVBCfDiP+miyDqOyzzIcdF/mHLoVlmZhkQ5jVkWonGQpuR81Zs+T64K91Q==
X-Received: by 10.99.125.17 with SMTP id y17mr22514594pgc.27.1486924896497;
        Sun, 12 Feb 2017 10:41:36 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:644a:2999:a3b7:74ee])
        by smtp.gmail.com with ESMTPSA id g70sm16255877pfb.50.2017.02.12.10.41.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Feb 2017 10:41:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 2/3] setup_revisions(): swap if/else bodies to make the next step more readable
Date:   Sun, 12 Feb 2017 10:41:31 -0800
Message-Id: <20170212184132.12375-3-gitster@pobox.com>
X-Mailer: git-send-email 2.12.0-rc1-212-ga9adfb24fa
In-Reply-To: <20170212184132.12375-1-gitster@pobox.com>
References: <xmqqa89sguu4.fsf@gitster.mtv.corp.google.com>
 <20170212184132.12375-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Swap the condition and bodies of an "if (A) do_A else do_B" in
setup_revisions() to "if (!A) do_B else do A", to make the change in
the the next step easier to read.  

No behaviour change is intended in this step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 4f46b8ba81..eccf1ab695 100644
--- a/revision.c
+++ b/revision.c
@@ -2237,8 +2237,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			continue;
 		}
 
-
-		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
+		if (!handle_revision_arg(arg, revs, flags, revarg_opt)) {
+			got_rev_arg = 1;
+		} else {
 			int j;
 			if (seen_dashdash || *arg == '^')
 				die("bad revision '%s'", arg);
@@ -2255,8 +2256,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			append_prune_data(&prune_data, argv + i);
 			break;
 		}
-		else
-			got_rev_arg = 1;
 	}
 
 	if (prune_data.nr) {
-- 
2.12.0-rc1-212-ga9adfb24fa

