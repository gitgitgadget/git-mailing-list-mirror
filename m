Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417A3208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbeHHR6k (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:58:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34445 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbeHHR6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:58:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so1484849eds.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tqGXNigRm7oRyH4MhpkVQuId1m+XD/BzUXcb5G2A9Rk=;
        b=WKNl0wRrrn1sg7ynlbo7q8KwRVwiVTowHXyDTx7+QrubrPdXc1Z9PvbBSFh2rOuaol
         WcVO9DmOsHbEQ8LOFA7acCNSp0Dn019I8LdLUniQI3wuCvJJoXBbIIfsXfDoFTq4v3XV
         bgVd2rwgVdpWtpscZirRo+PzlQotJeh6wnL2FcttBm6yS65zJKF99HXbM131SEhXSuJj
         u3Vk4KAbWzNW+rTz/BqnS9KZs+52MAF7yOk0b69BFKQnSYOyYjZR/idlhi4rQ7WCeY+V
         /kosaFT+cda6iCE0DEeQdvFvvhiPhZpoLy6SZq74FvC9MKCJAjNiZzMTGY3doPEdOpHs
         ttzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tqGXNigRm7oRyH4MhpkVQuId1m+XD/BzUXcb5G2A9Rk=;
        b=adO3+FxbwwuYv1KMjyrLBMcjgU02fVW58j45Jcd/qMPkOQXO2PHubf5iQgQbT0X4XC
         OrBJsE7Brath/f+ElbqUMv6v7n4ssIxb4HiIcssjazkklp6QhwToSJzUPYNbR2yLdA0q
         Jx6AfodZtCzIQymct94f0LlaWY6bCsVIvnfJ6BHO9vR6NhE5QrFtQKZf3g9+uGVnYNYu
         FzhZKSMaoqOi3DMSxSMl3ruNEYJj6idtBPYZa3wZ+SQQb0Ciadk85/prjzpG5JuqTsW8
         yUYyUyROpzb3rJAO5sXFoMWDSlFdTjnY31iNAFOjDc/qEG8HxiHOFb4r4ZSDmbQoA7/w
         OZDg==
X-Gm-Message-State: AOUpUlFo67ytQZBJVRZFYaJvtBg8sQ1Yo7i1gJtPIMmFLSw9XlUA7nSp
        diVvD3oAtYv1YSQyv9aDa0xfM1OY
X-Google-Smtp-Source: AA+uWPwYHM+NaWlCr0xKC+JRimSl6YDdiwmEQHlRzAMieQD+dYnAmuzqgbqpmAo7nEe8sYQ38ztCFw==
X-Received: by 2002:a50:8607:: with SMTP id o7-v6mr3863966edo.243.1533742706929;
        Wed, 08 Aug 2018 08:38:26 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1904876edo.39.2018.08.08.08.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:38:26 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 3/6] builtin rebase: fast-forward to onto if it is a proper descendant
Date:   Wed,  8 Aug 2018 21:21:32 +0545
Message-Id: <20180808153635.19944-4-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153635.19944-1-predatoramigo@gmail.com>
References: <20180808153635.19944-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trying to rebase onto a direct descendant of HEAD, we can
take a shortcut and fast-forward instead. This commit makes it so.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c51b9d288a..1bb64e7cd7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1367,6 +1367,24 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
+	/*
+	 * If the onto is a proper descendant of the tip of the branch, then
+	 * we just fast-forwarded.
+	 */
+	strbuf_reset(&msg);
+	if (!oidcmp(&merge_base, &options.orig_head)) {
+		printf(_("Fast-forwarded %s to %s. \n"),
+			branch_name, options.onto_name);
+		strbuf_addf(&msg, "rebase finished: %s onto %s",
+			options.head_name ? options.head_name : "detached HEAD",
+			oid_to_hex(&options.onto->object.oid));
+		reset_head(NULL, "Fast-forwarded", options.head_name, 0,
+			   "HEAD", msg.buf);
+		strbuf_release(&msg);
+		ret = !!finish_rebase(&options);
+		goto cleanup;
+	}
+
 	strbuf_addf(&revisions, "%s..%s",
 		    options.root ? oid_to_hex(&options.onto->object.oid) :
 		    (options.restrict_revision ?
-- 
2.18.0

