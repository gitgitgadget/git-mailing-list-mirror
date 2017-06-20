Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44881FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 03:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbdFTDC4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 23:02:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35066 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdFTDCz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 23:02:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so20466495pfs.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 20:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ulkWGbPfURWg00kBkqhzQR9dBu2sJnG6zto9x/Z1P0c=;
        b=DkZ1/fjFM/ynbU89aNtPpcGRDdHtZQC7KJYunmnn2qK+bP2MHXMOvIT6eB/PLGravU
         wmfpvlYEV2rcYDwoybETW1bvCzLK3N/w+qWK8ipM1YNZJlvJYCEC0ah1BVPvQhHSmEQg
         qcg7/Bqwe3ttPIXB9hQ7U/MlAa2Hzu+KlEy0F7efP967aDh4HkRMwOCLvJxi1SytDqFA
         T3kdUX2BZtvWOA2yP1PXs72mBL5bSExw+T3GYSrheuzIV4OpBYY6DIa70D6wKwXsUP3m
         j6PXIU1ndMJz5tBiwzraxFopuwvs04WA6wMSS/oJqWDf7E6zyb+mw6orIPepIJgonleb
         bH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ulkWGbPfURWg00kBkqhzQR9dBu2sJnG6zto9x/Z1P0c=;
        b=uNJ32H4BA3WQNV7ji03OZNoAYOwsnumPPMgWmNIckVH+HcbxfJplTJ52k6kdOSxYal
         3OihEj5vMOE6C6d0fcWnB7HISL5IONBk8QVjuiRxMeZaD6kazv5ixB4psxiiT3aEnBiT
         AvNNZLLBJB9cy5o/u7wtrkH6qNQ1oibXWceAimWLs+E7GdX22MQlMFFc0tU17s5xXOdM
         xI/5Yrdv7M2Cx71jIcNG4vnLJO5ZXUqspo+n1plQdxMR7EYj1r+Wd+Nc4gPh5DcmYp9x
         NhINydVxbHrxZWE9cG4Djf3MvonzNoafsA6e7Gq9IQADVgXAYFtIdsVgRuke0ZuKzlxH
         K3xw==
X-Gm-Message-State: AKS2vOxkzmAD4yt46DzR/VyVTanZbRxvngL5cGryzusV+2CSCbTfbAgU
        ok10d4hc8jKIBA==
X-Received: by 10.84.236.71 with SMTP id h7mr32185801pln.88.1497927774877;
        Mon, 19 Jun 2017 20:02:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7088:3652:1086:ad92:af48:f1cf])
        by smtp.gmail.com with ESMTPSA id 186sm22585415pfv.15.2017.06.19.20.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 20:02:54 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     peff@peff.net, git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH 1/3] Contextually notify user about an initial commit
Date:   Tue, 20 Jun 2017 08:32:18 +0530
Message-Id: <20170620030220.7323-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqshiwt1w6.fsf@gitster.mtv.corp.google.com>
References: <xmqqshiwt1w6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git status" indicated "Initial commit" when HEAD points at
an unborn branch.  This message is shared with the commit
log template "git commit" prepares for the user when
creating a commit (i.e. "You are about to create the initial
commit"), and is OK as long as the reader is aware of the
nature of the message (i.e. it guides the user working
toward the next commit), but was confusing to new users,
especially the ones who do "git commit -m message" without
having a chance to pay attention to the commit log template.

The "Initial commit" indication wasn't an issue in the commit
template. Taking that into consideration, a good solution would
be to contextually use different messages to indicate the user
that there were no commits in this branch.

A few alternatives considered were,

* Waiting for initial commit
* Your current branch does not have any commits
* Current branch waiting for initial commit

The most succint one, "No commits yet", among the alternatives
was chosen.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/commit.c | 1 +
 wt-status.c      | 5 ++++-
 wt-status.h      | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1d805f5da..0f36d2ac3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1648,6 +1648,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
 	status_init_config(&s, git_commit_config);
+	s.commit_template = 1;
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
diff --git a/wt-status.c b/wt-status.c
index 037548496..e6a9ee34f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1576,7 +1576,10 @@ static void wt_longstatus_print(struct wt_status *s)
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
+		status_printf_ln(s, color(WT_STATUS_HEADER, s),
+				 s->commit_template
+				 ? _("Initial commit")
+				 : _("No commits yet"));
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
 
diff --git a/wt-status.h b/wt-status.h
index 6018c627b..782b2997f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -76,6 +76,7 @@ struct wt_status {
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
 	unsigned colopts;
 	int null_termination;
+	int commit_template;
 	int show_branch;
 	int hints;
 
-- 
2.11.0

