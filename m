Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CDBB202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 18:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbdKTSYy (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 13:24:54 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42672 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdKTSYx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 13:24:53 -0500
Received: by mail-wr0-f193.google.com with SMTP id o14so8949575wrf.9
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QSmg0/mDpVql/UAyToLBYtiuBXoA9F6dhHIea5Ho6IY=;
        b=vv3drLlBTA9x+oToWOKGDBKn9wpi9Gp7OiDog35iKOZ8AWBfNlxSFCkiOlycHfxkXj
         voGS3aHSWyhoKtf0KzjGiF6YMmZtmGL0IemLe6kSk7bCL9otXlu66A1NxDrn6LzaoDoK
         KifLNqfaNTVOb7AhdYoceA0impPknsoIfCrPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QSmg0/mDpVql/UAyToLBYtiuBXoA9F6dhHIea5Ho6IY=;
        b=ETJLwD+CvASxx4WoLpR3PvAId0D4FILPS1ziZvpZv6uxcS9oje4cypaURD7HlFXxXw
         SvFuFR+onJN5LAA3yags1HrzmkOYq0PJreDn7Tsd5zMl9jnkkl/twJjqMvTXsRSrsAT7
         N9wsfuV6ZEWlSwU0Pkhkq+b5xxss+qtIkm5T+aSck4RU5Io5nNC+sf6S/3rFZzSi+NKy
         nw0TY9ge2HTwtqJWcFD7tqeVu+MFreFio9+FtJSX4SZIdzPnKOd4b5ACuGaHrZQfqVtD
         4hr0geklEV7gewO+06i0i+Qn/MC4E7ExYfFWdEWx7WA+O6Sn98eKE5dmRAzUrZ9cIfOJ
         /nbA==
X-Gm-Message-State: AJaThX7/9z/x4HHwnbvxRIqiGJYZiLmhNSdNz4jv4pu+fGI5p6xRIuuM
        5JYsu+NKSX9LRjXQ21uRFMIxx9BnE8E=
X-Google-Smtp-Source: AGs4zMazqinTAUN1JHBo/YeSNWBs0tDe5LfbM1LrL0CQ91TVjf3bCo9CD5ItoS9SAa4QLnq+/Eb6mg==
X-Received: by 10.223.197.141 with SMTP id m13mr12853366wrg.203.1511202291733;
        Mon, 20 Nov 2017 10:24:51 -0800 (PST)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:a407:552d:75e4:4516])
        by smtp.gmail.com with ESMTPSA id 138sm13691999wmf.21.2017.11.20.10.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 10:24:51 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [RFC PATCH v2 2/2] bisect: add "edit" command
Date:   Mon, 20 Nov 2017 18:24:39 +0000
Message-Id: <6cef29705cb22fa23847e255acd7e7623dc9d805.1511200589.git.adam@dinwoodie.org>
X-Mailer: git-send-email 2.15.0.281.g87c0a7615
In-Reply-To: <cover.1511200589.git.adam@dinwoodie.org>
References: <cover.1511200589.git.adam@dinwoodie.org>
In-Reply-To: <cover.1511200589.git.adam@dinwoodie.org>
References: <20171108135931.166880-1-adam@dinwoodie.org> <cover.1511200589.git.adam@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an "edit" command to git bisect, which will save the current
bisection log to a file, open an editor to allow the user to replay the
bisection log, then replay the edited log file.

This can already be done as separate steps, and doing so is described in
the bisect documentation; this commit merely reduces those separate
steps to a single step.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 builtin/bisect--helper.c |  3 ++-
 git-bisect.sh            | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4b5fadcbe..980e3e09b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -46,7 +46,8 @@ static int check_term_format(const char *term, const char *orig_term)
 		return error(_("'%s' is not a valid term"), term);
 
 	if (one_of(term, "help", "start", "skip", "next", "reset",
-			"visualize", "view", "replay", "log", "run", "terms", NULL))
+			"visualize", "view", "replay", "log", "edit", "run",
+			"terms", NULL))
 		return error(_("can't use the builtin command '%s' as a term"), term);
 
 	/*
diff --git a/git-bisect.sh b/git-bisect.sh
index 895d7976a..bcc02a3f2 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -26,6 +26,8 @@ git bisect replay <logfile>
 	replay bisection log.
 git bisect log
 	show bisect log.
+git bisect edit
+	edit and replay bisect log.
 git bisect run <cmd>...
 	use <cmd>... to automatically bisect.
 
@@ -454,6 +456,20 @@ bisect_replay_file() {
 	done <"$file"
 }
 
+bisect_edit () {
+	test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.")"
+	cp "$GIT_DIR/BISECT_LOG" "$GIT_DIR/BISECT_LOG_EDIT"
+	git_editor "$GIT_DIR/BISECT_LOG_EDIT" ||
+		die "$(gettext "Could not execute editor")"
+	test -n "$(git stripspace --strip-comments <"$GIT_DIR/BISECT_LOG_EDIT")" ||
+		die "$(gettext "Nothing to do")"
+	git bisect--helper --bisect-clean-state ||
+		die "$(gettext "Unable to clean repository")"
+	bisect_replay_file "$GIT_DIR/BISECT_LOG_EDIT"
+	rm -f "$GIT_DIR/BISECT_LOG_EDIT"
+	bisect_auto_next
+}
+
 bisect_run () {
 	bisect_next_check fail
 
@@ -625,6 +641,8 @@ case "$#" in
 		bisect_replay "$@" ;;
 	log)
 		bisect_log ;;
+	edit)
+		bisect_edit ;;
 	run)
 		bisect_run "$@" ;;
 	terms)
-- 
2.15.0.281.g87c0a7615

