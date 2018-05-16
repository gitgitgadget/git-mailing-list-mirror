Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1671F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeEPW7s (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:48 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:40336 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeEPW7p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:45 -0400
Received: by mail-qk0-f202.google.com with SMTP id q185-v6so2309322qke.7
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=QK9b45t5xm7KCkPeHV3qaGT2BIgPkplVTgDj0g6olIM=;
        b=IDCjDGUf/aCRS1EpDqZPtPRftyozxlNcW2bKWM9Q1xuxeoSIBDLfzlEC1kgmxW7vJL
         /Uu/s/YacfydkJFyPB9sFXJ2L4RTanJ9yG0V4r7iNDuIC2HQmLyK+DJ7OG0MWNox/V89
         T4mD9hU7Mp/mEpwfV864oKHw3/knihFu2h8WxsuPbTZZ5olTffV9ExOIQiKG9Qnyj3qV
         95E+El1Au0ZtcY2UKTygEYGMdJd+wpm61AW+ZkMbSD5lp/Y3ozos8iMzRks/FTIxZaX4
         ggGdozlpMPb/ohp4jtzKHqPgEluIy8p0tqXvY9M1N0SR1HOSeVa1GCeZRea8BOQA+pfH
         Fxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=QK9b45t5xm7KCkPeHV3qaGT2BIgPkplVTgDj0g6olIM=;
        b=Sd8dbZWFxc8apcJfDrzWhfNZeG9SjglIfsjRb/E5UcOQk59dGHko82APfPiinzHEM9
         tVRfCMYN24J1NVy1WGGu0JbARscml4PuVK8/JZQk/iZ7EyBuA3uo7rs9ChcVuAo9RZDc
         TwNmcMPdq9op6Izb24kd6dabNMUxz5x22zBAsnQeJAByPYzKPnlBhyE9FhokFngSoI4D
         Uxq/Bd9TyNKDVrtsUhQUeCoEDldfKGnvoHnEegrWeYD+3OAEI10evFmuRXw4YxXVeA2D
         OhfltcXGigfxSDPBTzwB6YvfaOXR6A2KpxUx+WLQ0kXUhvCXjZWYUpr7XYQV1M6OEGfR
         VxcQ==
X-Gm-Message-State: ALKqPwel9rZX2x4T+U/Q2kSzfLq2U139XsZFQDX1YIRorB8hOJoyjmPF
        5QWM04gPuzaDy50XHMykB2iAjSZFipzA3HDoKr8toz6i2NMJ2RRizhZVidAdT5jcYBQmkhUEDJU
        0bhZOD6G5uVrh2yljLUugBu84JkBUaN9Lp9dAwWMN1SRM8ZmuoUYrOEmgAg==
X-Google-Smtp-Source: AB8JxZqOfCUmZaEw6ntPAR4BtqXievU0M6OJuDKLtls1ILPvn+3ukMc9zLXQLbWz/jY2nXcvVJe58w+ItKM=
MIME-Version: 1.0
X-Received: by 2002:a0c:d8ee:: with SMTP id w43-v6mr2914348qvj.14.1526511584466;
 Wed, 16 May 2018 15:59:44 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:15 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-29-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 28/36] push: check for errors earlier
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the error checking for using the "--mirror", "--all", and "--tags"
options earlier and explicitly check for the presence of the flags
instead of checking for a side-effect of the flag.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/push.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6b7e45890..df5df6c0d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -417,23 +417,6 @@ static int do_push(const char *repo, int flags,
 	if (push_options->nr)
 		flags |= TRANSPORT_PUSH_OPTIONS;
 
-	if ((flags & TRANSPORT_PUSH_ALL) && refspec) {
-		if (!strcmp(*refspec, "refs/tags/*"))
-			return error(_("--all and --tags are incompatible"));
-		return error(_("--all can't be combined with refspecs"));
-	}
-
-	if ((flags & TRANSPORT_PUSH_MIRROR) && refspec) {
-		if (!strcmp(*refspec, "refs/tags/*"))
-			return error(_("--mirror and --tags are incompatible"));
-		return error(_("--mirror can't be combined with refspecs"));
-	}
-
-	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) ==
-				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
-		return error(_("--all and --mirror are incompatible"));
-	}
-
 	if (!refspec && !(flags & TRANSPORT_PUSH_ALL)) {
 		if (remote->push.raw_nr) {
 			refspec = remote->push.raw;
@@ -625,6 +608,20 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		die(_("--delete is incompatible with --all, --mirror and --tags"));
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
+	if (flags & TRANSPORT_PUSH_ALL) {
+		if (tags)
+			die(_("--all and --tags are incompatible"));
+		if (argc >= 2)
+			die(_("--all can't be combined with refspecs"));
+	}
+	if (flags & TRANSPORT_PUSH_MIRROR) {
+		if (tags)
+			die(_("--mirror and --tags are incompatible"));
+		if (argc >= 2)
+			die(_("--mirror can't be combined with refspecs"));
+	}
+	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))
+		die(_("--all and --mirror are incompatible"));
 
 	if (recurse_submodules == RECURSE_SUBMODULES_CHECK)
 		flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
-- 
2.17.0.441.gb46fe60e1d-goog

