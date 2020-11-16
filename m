Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4827C6379F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7382E20729
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmINwcmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgKPQIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731696AbgKPQIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:45 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23130C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p1so19230374wrf.12
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Al/BEw1HlTzADw13DfXHg15dSSfmpzE7jxEGknssPgI=;
        b=qmINwcmG9abD2EDd1BqmuKGLGKNkNh+J6VLNJVC9kvusXwJLmT4crnKjxygKga75Wk
         xfEW+B7vY+LdqUe89kTECfN8E8Z0s2W7fSC6gqMB8zp+Fu8c9PE5CKla+5pNHobnYCkY
         PatviHc8IMjxzjPrCcOr2e+aRr+3CgCEL/QHaYsuzV08QE3OGB7ecUYPZtrhU2TnzuW9
         M9CHdfngqGzkOLXaB/PHx/M88KKs3KhGojU9f5JqflX13jpQ/dP+ncVjOxfusopC08pl
         Vzif9JnBvxwT1wMuWqj7RkD60MiY3gyD8dEiuZ0w8o6pv++nefp5Cd2U98TPY9Bjewu4
         f0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Al/BEw1HlTzADw13DfXHg15dSSfmpzE7jxEGknssPgI=;
        b=YNILqUVNss4AyG0br979PYfwfiIpLgMCeYAEVusZZT2DsXil+VXzquNNchfsiHtDdX
         PC/H0MgfFqrRggtVw8TXjPPK9qmoPVRPHqsuA05RG8FFdEg3B1g1wtJEE6zr8WNA4tNY
         SVbqnncm1mv/q99tS2oFuMO4JpnNYkw2jX1MGb/44vBBnawFGVv6J8gSPFHck3SBJI4J
         6p/LLNOPLG+uImeDaUlC7Z2X59kXQtOVz4rm2q98VzDRayaFHIoZJrVYTbtbq2uRmvEB
         2LK2Sarx+8MUynhRHzduG2m7AnU3mJpGlpJh7hmY96XQDf243KASLEvzPF7RhQBY7Tnv
         382g==
X-Gm-Message-State: AOAM531WRS1CiAiDQH0JL38jDSMBrD/sLKzfCBiXOb4uQKL+Z/G1YJkE
        V2UAkoS8s/TZGcRjvrzsxdzLmZTHhSU=
X-Google-Smtp-Source: ABdhPJzgNzyLa459Hzw/nJ/kznPo6d1een5CUGGrzaD/+GgwBqSpdOik3HusOHAy6xxivZ0yd/5Hsw==
X-Received: by 2002:adf:b186:: with SMTP id q6mr21577577wra.53.1605542922774;
        Mon, 16 Nov 2020 08:08:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x63sm21410243wmb.48.2020.11.16.08.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:42 -0800 (PST)
Message-Id: <9a4d2a33b50344e97e2bc47e5aeb0d3fcbc18a6c.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:31 +0000
Subject: [PATCH v3 10/11] add -p: prefer color.diff.context over
 color.diff.plain
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git's diff machinery allows users to override the colors to use in
diffs, even the plain-colored context lines. As of 8dbf3eb6850 (diff.h:
rename DIFF_PLAIN color slot to DIFF_CONTEXT, 2015-05-27), the preferred
name of the config setting is `color.diff.context`, although Git still
allows `color.diff.plain`.

In the context of `git add -p`, this logic is a bit hard to replicate:
`git_diff_basic_config()` reads all config values sequentially and if it
sees _any_ `color.diff.context` or `color.diff.plain`, it accepts the
new color. The Perl version of `git add -p` needs to go through `git
config --get-color`, though, which allows only one key to be specified.
The same goes for the built-in version of `git add -p`, which has to go
through `repo_config_get_value()`.

The best we can do here is to look for `.context` and if none is found,
fall back to looking for `.plain`, and if still not found, fall back to
the hard-coded default (which in this case is simply the empty string,
as context lines are typically rendered without colored).

This still leads to inconsistencies when both config names are used: the
initial diff will be colored by the diff machinery. Once edited by a
user, a hunk has to be re-colored by `git add -p`, though, which would
then use the other setting to color the context lines.

In practice, this is not _all_ that bad. The `git config` manual says
this in the `color.diff.<slot>`:

	`context` (context text - `plain` is a historical synonym)

We should therefore assume that users use either one or the other, but
not both names. Besides, it is relatively uncommon to look at a hunk
after editing it because it is immediately staged by default.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c         | 6 ++++--
 git-add--interactive.perl | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index c298a8b80f..54dfdc56f5 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -49,8 +49,10 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 
 	init_color(r, s, "diff.frag", s->fraginfo_color,
 		   diff_get_color(s->use_color, DIFF_FRAGINFO));
-	init_color(r, s, "diff.context", s->context_color,
-		diff_get_color(s->use_color, DIFF_CONTEXT));
+	init_color(r, s, "diff.context", s->context_color, "fall back");
+	if (!strcmp(s->context_color, "fall back"))
+		init_color(r, s, "diff.plain", s->context_color,
+			   diff_get_color(s->use_color, DIFF_CONTEXT));
 	init_color(r, s, "diff.old", s->file_old_color,
 		diff_get_color(s->use_color, DIFF_FILE_OLD));
 	init_color(r, s, "diff.new", s->file_new_color,
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index adbac2bc6d..bc3a1e8eff 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -30,9 +30,9 @@
 	$diff_use_color ? (
 		$repo->get_color('color.diff.frag', 'cyan'),
 	) : ();
-my ($diff_plain_color) =
+my ($diff_context_color) =
 	$diff_use_color ? (
-		$repo->get_color('color.diff.plain', ''),
+		$repo->get_color($repo->config('color.diff.context') ? 'color.diff.context' : 'color.diff.plain', ''),
 	) : ();
 my ($diff_old_color) =
 	$diff_use_color ? (
@@ -1046,7 +1046,7 @@ sub color_diff {
 		colored((/^@/  ? $fraginfo_color :
 			 /^\+/ ? $diff_new_color :
 			 /^-/  ? $diff_old_color :
-			 $diff_plain_color),
+			 $diff_context_color),
 			$_);
 	} @_;
 }
-- 
gitgitgadget

