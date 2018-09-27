Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4321F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeI1EVP (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:21:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41544 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeI1EVO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:21:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id j15-v6so4220180wrt.8
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CH0fgmKPLZIXLTtoFmJOV0+tn7Gyfs29WxoJiwtLG18=;
        b=JUxbh11tzgZu9aNhf95CxD6V8zib5TTLWpg0X29UcuiMyBJA6nveSKX8jksSzCubCM
         E/z6Ba2I7aeuHLpEWrGNvIna7gl99zSGKMfHuVAWPyM6OYK7OQrtTLKLyw5Mf+lk5ISo
         6ko4JErhTlmT0nd48VTS0tOOxNCNyFxhit+hsnZqQomNIx/saLJ5Yt66TLx9axe52MNQ
         pT0BzGvNe6CvLazpaWW6IvqyY14r9QRenHeOfocu7O1GSxgt4PL7Z4GoGGH4cRZRpgfg
         37XK6ztqsgchpv/+IpCz294V18AAW7kXRVRpwHi1DeUrYmDFAq6U1pp8Z6Vf6AZJYaLh
         xeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CH0fgmKPLZIXLTtoFmJOV0+tn7Gyfs29WxoJiwtLG18=;
        b=iIV6CVjNMzHlRXv0QxT61EhRaqHxnonH3EEmmO2+sa2nYCE7ES3twQjbhnHo8TZN49
         Ty83zLSqiraqrhJ830AbAvtqwUDUimyg1uPAT01WmhXsU4F/UPUTW3PXhfyzDz75tbvy
         mm3ZryoSzeBG/cFUVIhnSdnw/hYlif5/ujzKyFLlwp8MtAIqiVASkrbIIRys/3hIfIp3
         hMD6YGLEDnU6Z5g5hhvEKNfQvUMxzAKPifdTVfybg0/jP4WmreuPVtJUBN4Mc4d0p/wv
         dDHdcGYphHjHbt8erCQA7IThFzhEWdmzvkUfiOIX/bnxxZwr1NAeBhLuqeUjUfQe+9It
         5Hew==
X-Gm-Message-State: ABuFfojlLE/dVbHP8STklyNEJjtjuXWVLvjM6jVOUL19eH5TeMV/Qi/V
        oCzh4nP3nDAzz9FWCmeV2h3vLMzx
X-Google-Smtp-Source: ACcGV637DWDEgYYjaFmdo4VZJMdcQ72sTD7Psw6d1NtABAc/iptpxbmDruuJTZnJVDywD/hCpe7qHA==
X-Received: by 2002:adf:84e6:: with SMTP id 93-v6mr10392923wrg.144.1538085648436;
        Thu, 27 Sep 2018 15:00:48 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:47 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 16/20] rebase -i: rewrite init_basic_state() in C
Date:   Thu, 27 Sep 2018 23:56:06 +0200
Message-Id: <20180927215610.32210-17-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites init_basic_state() from shell to C.  The call to
write_basic_state() in cmd_rebase__helper() is replaced by a call to the
new function.

The shell version is then stripped from git-rebase--interactive.sh.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v7.

 builtin/rebase--helper.c   | 23 ++++++++++++++++++++++-
 git-rebase--interactive.sh |  9 ---------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 63c5086e42..f8128037d3 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -5,10 +5,13 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "argv-array.h"
+#include "refs.h"
 #include "rerere.h"
 #include "alias.h"
 
+static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
 static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
+static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
 
 static int get_revision_ranges(const char *upstream, const char *onto,
 			       const char **head_hash,
@@ -44,6 +47,24 @@ static int get_revision_ranges(const char *upstream, const char *onto,
 	return 0;
 }
 
+static int init_basic_state(struct replay_opts *opts, const char *head_name,
+			    const char *onto, const char *orig_head)
+{
+	FILE *interactive;
+
+	if (!is_directory(path_state_dir()) && mkdir_in_gitdir(path_state_dir()))
+		return error_errno(_("could not create temporary %s"), path_state_dir());
+
+	delete_reflog("REBASE_HEAD");
+
+	interactive = fopen(path_interactive(), "w");
+	if (!interactive)
+		return error_errno(_("could not mark as interactive"));
+	fclose(interactive);
+
+	return write_basic_state(opts, head_name, onto, orig_head);
+}
+
 static const char * const builtin_rebase_helper_usage[] = {
 	N_("git rebase--helper [<options>]"),
 	NULL
@@ -198,7 +219,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		if (ret)
 			return ret;
 
-		return !!write_basic_state(&opts, head_name, onto, head_hash);
+		return !!init_basic_state(&opts, head_name, onto, head_hash);
 	}
 
 	usage_with_options(builtin_rebase_helper_usage, options);
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6367da66e2..761be95ed1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -51,14 +51,6 @@ initiate_action () {
 	esac
 }
 
-init_basic_state () {
-	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
-	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
-	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
-
-	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
-}
-
 git_rebase__interactive () {
 	initiate_action "$action"
 	ret=$?
@@ -67,7 +59,6 @@ git_rebase__interactive () {
 	fi
 
 	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
-	init_basic_state
 
 	git rebase--helper --init-basic-state ${upstream:+--upstream "$upstream"} \
 		${onto:+--onto "$onto"} ${head_name:+--head-name "$head_name"} \
-- 
2.19.0

