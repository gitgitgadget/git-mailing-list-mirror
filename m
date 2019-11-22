Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB62DC432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 22:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8048A2070E
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 22:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJpB1lgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKVW7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:59:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34118 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfKVW7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 17:59:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id j18so11283701wmk.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 14:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SAslGvbDPSE9Ws8ztHkjN3eLatbrNQ6cJoOL3eU9s+E=;
        b=RJpB1lggY0+b07mAH4K6S7+4K2S4gk5YZZa274OnGf0hPziLmBFeCKZUmLf280VrDZ
         L53f88Wd27pJJtv3Yne05gzDIxMYCP+YT+jK0U/WYgUnSUZN9fynJAkyJD1QTXLALtVQ
         R0f/LKgbeEfOzJ51Sq2KB2h13VOnfb4zRI9/f/xGcCedgSC+QAIAwqjpdls2/45/CL0j
         /e8j9TtISWup9+4BlsQH96syDi3PcGg/al/mLrhRawzeF6Bfk8k8YQnFiayKwMSG72pQ
         mtfkdqtfpPT0GfZlfB6pkodd8unN2WdwfdyajWKAFR+1WoHD1I1LdJ66RBNo9p0FW2fS
         LNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SAslGvbDPSE9Ws8ztHkjN3eLatbrNQ6cJoOL3eU9s+E=;
        b=JU+HIcDPjc4RjyUvhmK/U0nkFeTJzdzeiY+OPBXs7RDB9j+F6q5drWJ1Iz+NVEllF5
         4xVtk/MuJ/u9dUTuoPzaKqJa8LuqhLRL7yySQw4lPyVtEzwEapglI2i4N1LW0mDtUqzf
         YfKya9Qz8vVYtYngzSOfLx55GLG4duqxgqmH8l9chD/szqYPvdWpBW7Ii5nII6h59nlj
         mvMIsZQoOsGgd4yaVyg++7c1FwcZPjdb2mM6VSHbV0ypSlzHoAV6uQ55uQjCufO/IRfT
         i7TbYSdrZ06aEGpWvd6zUKA69TbZCAf6NdUPciSmUFcssK0kR0zf6PnEIIYzkic67woO
         cG1Q==
X-Gm-Message-State: APjAAAXk9s0owwq2i3j61tDbtW4kJEk6Q4mKmeNK/+U9EfsNMsGfdWMZ
        3Inf43ik7OyoqYdN/UKAUNiCsa83
X-Google-Smtp-Source: APXvYqzjxrJigxvoOI7sOAqyx6SzdtDAVCynbuy24VcbOrIKq940MA/O/tsPr/MlPl3M3L5e1u2mpQ==
X-Received: by 2002:a1c:6854:: with SMTP id d81mr19434571wmc.75.1574463571083;
        Fri, 22 Nov 2019 14:59:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm9378051wrt.39.2019.11.22.14.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 14:59:30 -0800 (PST)
Message-Id: <c123d93ae7361b53b9d1d76124aefcb09740f0eb.1574463569.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.295.git.1574463569.gitgitgadget@gmail.com>
References: <pull.295.git.1574463569.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 22:59:29 +0000
Subject: [PATCH 1/1] git svn: stop using `rebase --preserve-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We deprecated `--preserve-merges` in favor of `--rebase-merges`; Let's
reflect that in `git svn`.

Note: Even when the user asks for `--preserve-merges`, we now silently
pass `--rebase-merges` to `git rebase` instead. Technically, this is a
change of behavior. But practically, `git svn` only ever asks for a
non-interactive rebase, and `--preserve-merges` and `--rebase-merges`
are on par with regard to that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-svn.txt | 3 ++-
 git-svn.perl              | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 53774f5b64..6624a14fbd 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -677,7 +677,8 @@ config key: svn.authorsProg
 -s<strategy>::
 --strategy=<strategy>::
 -p::
---preserve-merges::
+--rebase-merges::
+--preserve-merges (DEPRECATED)::
 	These are only used with the 'dcommit' and 'rebase' commands.
 +
 Passed directly to 'git rebase' when using 'dcommit' if a
diff --git a/git-svn.perl b/git-svn.perl
index 050f2a36f4..4aa208ff5f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -110,7 +110,7 @@ sub _req_svn {
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_before, $_after,
-	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_parents, $_local,
+	$_merge, $_strategy, $_rebase_merges, $_dry_run, $_parents, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_commit_url, $_tag, $_merge_info, $_interactive, $_set_svn_props);
 
@@ -270,7 +270,8 @@ sub _req_svn {
 			  'local|l' => \$_local,
 			  'fetch-all|all' => \$_fetch_all,
 			  'dry-run|n' => \$_dry_run,
-			  'preserve-merges|p' => \$_preserve_merges,
+			  'rebase-merges|p' => \$_rebase_merges,
+			  'preserve-merges|p' => \$_rebase_merges,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
 	                   'Commit a diff between two trees',
@@ -1054,7 +1055,7 @@ sub cmd_dcommit {
 					  'If you are attempting to commit ',
 					  "merges, try running:\n\t",
 					  'git rebase --interactive',
-					  '--preserve-merges ',
+					  '--rebase-merges ',
 					  $gs->refname,
 					  "\nBefore dcommitting";
 				}
@@ -1717,7 +1718,7 @@ sub rebase_cmd {
 	push @cmd, '-v' if $_verbose;
 	push @cmd, qw/--merge/ if $_merge;
 	push @cmd, "--strategy=$_strategy" if $_strategy;
-	push @cmd, "--preserve-merges" if $_preserve_merges;
+	push @cmd, "--rebase-merges" if $_rebase_merges;
 	@cmd;
 }
 
-- 
gitgitgadget
