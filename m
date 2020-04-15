Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19E9C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3262078A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 14:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORClhRao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394007AbgDOO3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393999AbgDOO2q (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 10:28:46 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C087C061A0E
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 07:28:46 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c7so5120781edl.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dG3NkKChRsTApDpikUSdiqFvX3FGhTiGGuLhBA15Ab8=;
        b=ORClhRaoB0jUcWbiL8LrGV+hQ1iujSCpm/eZZ4JCrmPj4aVl8ELhV2tVJkDFiqv93n
         PsjKXYfG49TDYyNwSVjDPn4YhGzWslnR+xN8iHbMMh9eVX3F5TlgokuH8Ob8ge9Osjc8
         TgrK0Dd0rigRcyQ/mkfCKDdF5OBZutjO7YDp7DEqIdUZyKzghPhbeSg9C9DvfR+S4uwO
         Ce2lcoHO2Z69fM+c3BjEQuAAXGOT4BoGv4yIlnADgqDTfjNHvi6gqLNplGALyXAwkns9
         QPubqwfBT0BQJVeP2uxIKoITq/dluAW1qSORO3cB5RHM+kDgal04BRiRSdH6NrdNqDFh
         ykuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dG3NkKChRsTApDpikUSdiqFvX3FGhTiGGuLhBA15Ab8=;
        b=UW+YKQFJccJuGHNtYJIS1Mpm9usyYBa+4tK2MaXAT5FXdUAf8DiM/OmrbcnyFqM2jh
         rtX3fk8LxL5U1+dCZH/1JeAlTAxYwyq/5xE8FNMpZiETIohNgm5cJCzU/NtDEnjX0WvB
         BuWv3HvfwgXI0WIkQbLeSVoOddIOFKjB4FrfimjHr308u25R+LVdueW0n6o2STOpFJjR
         AZ91NW6PD2JIKDr2g7LaPZPSCwY4UpzHYsNscvtMZ0W3olS25A8VXqk5ZZLCVzQV3lC1
         y3SHKLvJkQN2Jq9OvYcoF+DFgLXp62Wpg3sgKCeePOQvyQLecJ6nyJ3EGpdL6jjbXiLj
         7hTw==
X-Gm-Message-State: AGi0PuYtjS6GLeB39d+oR7xS1iHvA46XcTtMcvFeOio5pWrCb9y7YaEp
        ZrQR8njRADn/Hjbno6OTiis58R2p
X-Google-Smtp-Source: APiQypLhyZIVZrFCKZBMFwdIjTWFDnPTSSj8lDROokCYuEkF+CJk6zTSjWAe/a8GF5J7mmB0n6gH5w==
X-Received: by 2002:a17:906:af99:: with SMTP id mj25mr5166870ejb.151.1586960924628;
        Wed, 15 Apr 2020 07:28:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13sm2620117ejb.10.2020.04.15.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:28:44 -0700 (PDT)
Message-Id: <2375e34100e571f9c3ce658d28aba6648fba18a6.1586960921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
From:   "Vasil Dimov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Apr 2020 14:28:40 +0000
Subject: [PATCH 1/2] range-diff: fix a crash in parsing git-log output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vasil Dimov <vd@freebsd.org>, Vasil Dimov <vd@FreeBSD.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vasil Dimov <vd@FreeBSD.org>

`git range-diff` calls `git log` internally and tries to parse its
output. But `git log` output can be customized by the user in their
git config and for certain configurations either an error will be
returned by `git range-diff` or it will crash.

To fix this explicitly set the output format of the internally
executed `git log` with `--pretty=medium`. Because that cancels
`--notes`, add explicitly `--notes` at the end.

Also, make sure we never crash in the same way - trying to dereference
`util` which was never created and has remained NULL. It would happen
if the first line of `git log` output does not begin with 'commit '.

Alternative considered but discarded - somehow disable all git configs
and behave as if no config is present in the internally executed
`git log`, but that does not seem to be possible. GIT_CONFIG_NOSYSTEM
is the closest to it, but even with that we would still read
`.git/config`.

Signed-off-by: Vasil Dimov <vd@FreeBSD.org>
---
 range-diff.c          | 13 +++++++++++++
 t/t3206-range-diff.sh | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/range-diff.c b/range-diff.c
index f745567cf67..5cc920be391 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -63,6 +63,8 @@ static int read_patches(const char *range, struct string_list *list,
 			"--output-indicator-old=<",
 			"--output-indicator-context=#",
 			"--no-abbrev-commit",
+			"--pretty=medium",
+			"--notes",
 			NULL);
 	if (other_arg)
 		argv_array_pushv(&cp.args, other_arg->argv);
@@ -106,6 +108,17 @@ static int read_patches(const char *range, struct string_list *list,
 			continue;
 		}
 
+		if (!util) {
+			error(_("could not parse first line of `log` output: "
+				"did not start with 'commit ': '%s'"),
+			      line);
+			string_list_clear(list, 1);
+			strbuf_release(&buf);
+			strbuf_release(&contents);
+			finish_command(&cp);
+			return -1;
+		}
+
 		if (starts_with(line, "diff --git")) {
 			struct patch patch = { 0 };
 			struct strbuf root = STRBUF_INIT;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index bd808f87ed5..e024cff65cb 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -513,6 +513,16 @@ test_expect_success 'range-diff overrides diff.noprefix internally' '
 	git -c diff.noprefix=true range-diff HEAD^...
 '
 
+test_expect_success 'basic with modified format.pretty with suffix' '
+	git -c format.pretty="format:commit %H%d%n" range-diff \
+		master..topic master..unmodified
+'
+
+test_expect_success 'basic with modified format.pretty without "commit "' '
+	git -c format.pretty="format:%H%n" range-diff \
+		master..topic master..unmodified
+'
+
 test_expect_success 'range-diff compares notes by default' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-- 
gitgitgadget

