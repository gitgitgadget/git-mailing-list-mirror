Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7EB211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeK3JGV (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39883 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeK3JGU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so3148401ljh.6
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swEujO+bWGRgXPaV7At87EMv7JoqqIaa1/DPNHHQFpY=;
        b=A55VHp5e3OZsAGd6RMSq02lcgMtAb3k5pZDC+Y0D78yt0nds/gRAt9NHMt/6ApNfgI
         dcdgD5K28xpFlknXrieTOSzfLNW2DhAK6cR28MS5q5LRJhigO/luFZSK7Ewd98A94wVJ
         mJkKN8LqqvXt3CXi0BYl8ZePbfcj8nKM4AQuNHX0PuXBCjzRWQ7DPHnPzuB2Wyjr0S/U
         EBfu5FIH46tTBuWYfDBUy867GnBsli+jQEwn+jjyWQ1qnSXqiNPw4Rurhg2oPlrPUkeL
         WJRzXUxYkx4N5J9hiMs0gV/AeYp70YTLKtHF1p1d2aiMDwhHxRiKrt00+9YS5n5O2ICM
         yh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swEujO+bWGRgXPaV7At87EMv7JoqqIaa1/DPNHHQFpY=;
        b=B+Ly8uas+dHF/6bLOFeFvRUh6bNbZL/EGAUVrHAeVYrxWzSdumb1yXStQYYbeEL3tJ
         a4bgp0NqalVRsW+Y+56YqY/8DIp6yZ4S7mSN8hqtOSi66XsSQ+QYPxNRh5bkg7ZPO0v3
         2HgBq1KYZOLF6yIfxjkO+5zYQefEo1ye86f3isMWD/1lv0dK0UOg41tlSUqHWo2j8fWw
         rDgOAaihdxM8Ujl3j7eBVFhyu5QV2uVW36Y/9sYrtJz4ASTD5blplIoWPka7OuDKHT//
         emHX+JOjtoMyCKfb/BFz8by/SGfi8i9FbAQxsopPcmUMb5MFBY4f2q0Ce0VJVojxrxHn
         Zmdw==
X-Gm-Message-State: AA+aEWanDdIGNERgakswbi2ZGQ/XbHtyjDokVWXHHKrojO1fnwtEP59l
        w15vJBBt7+vSgB+n0OIcWUs=
X-Google-Smtp-Source: AFSGD/XRmukAu7+oIpFf5ZLZTCwBA7VFNpstSsKl/ZC3qkX0LsLFMT/IPV+3C+TxJ6Gw3+Hv1nUdLw==
X-Received: by 2002:a2e:88cf:: with SMTP id a15-v6mr2177150ljk.76.1543528764991;
        Thu, 29 Nov 2018 13:59:24 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:24 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 11/14] switch-branch: only allow explicit detached HEAD
Date:   Thu, 29 Nov 2018 22:58:46 +0100
Message-Id: <20181129215850.7278-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout <commit>" will checkout the commit in question and
detach HEAD from the current branch. It is naturally a right thing to
do once you get git references. But detached HEAD is a scary concept
to new users because we show a lot of warnings and stuff, and it could
be hard to get out of (until you know better).

To keep switch-branch a bit more friendly to new users, we only allow
entering detached HEAD mode when --detach is given. "git
switch-branch" must take a branch (unless you create a new branch,
then of course switch-branch can take any commit-ish)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c7ae068d2c..fbfebba2d9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -49,6 +49,7 @@ struct checkout_opts {
 	int merge;
 	int force;
 	int force_detach;
+	int implicit_detach;
 	int writeout_stage;
 	int overwrite_ignore;
 	int ignore_skipworktree;
@@ -1241,6 +1242,13 @@ static int checkout_branch(struct checkout_opts *opts,
 	    !opts->force_detach)
 		die(_("nothing to do"));
 
+	if (!opts->implicit_detach &&
+	    !opts->new_branch &&
+	    !opts->new_branch_force &&
+	    new_branch_info->name &&
+	    !new_branch_info->path)
+		die(_("a branch is expected, got %s"), new_branch_info->name);
+
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
@@ -1485,6 +1493,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_not_ok = 0;
 	opts.accept_pathspec = 1;
+	opts.implicit_detach = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1513,6 +1522,7 @@ int cmd_switch_branch(int argc, const char **argv, const char *prefix)
 	opts.dwim_new_local_branch = 1;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_not_ok = 1;
+	opts.implicit_detach = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.20.0.rc1.380.g3eb999425c.dirty

