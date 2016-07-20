Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3779A2034E
	for <e@80x24.org>; Wed, 20 Jul 2016 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbcGTRZM (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 13:25:12 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35857 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbcGTRY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 13:24:59 -0400
Received: by mail-lf0-f66.google.com with SMTP id 33so4000620lfw.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 10:24:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZZw54s8Q5vP6p9INO6PbqSsUhVs1WeMHLwylbOL3n8=;
        b=mD0NkgRsjW5IrdeduThpGwPG5KfNBVrtXf+iUOtC8yi2j6J3dhp7igZVYBRjf0PvV+
         Q2OTKcPfxkapmYmjkb/K4tSSvHlRFGNjbvHpfSJ1bWuaI01Ui5naBbB8sL2Gz6ZQhJXC
         ztEs8Mm4MCSmBYeiu4wE1qjd5xB5CFePaPP79So4Un6RSDW7LXgjcQelQ/U3BKEPpeGX
         U48WNaA2y+bImBXLYJJS6EupAeswt3R2YKCud7SOiMWJdBvgvgaVff/4s+A5TMB7gTFW
         /zjCf2DuU6IdGW/VLz+mb3GDHAm9+LY6OQgW/EUxVmONG3NdFmwP0WKRpxgfqEcsLRKu
         GvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZZw54s8Q5vP6p9INO6PbqSsUhVs1WeMHLwylbOL3n8=;
        b=NF5eyUQKsjj64iNsHP2UcxcSfYX4Bi/w7lWFJ/S63i6aV6NY9VIhDTCSlPZsMWWTda
         nn6rLcT2xvONYLVci0cr/6Wx+pOHbELdlMKPEFvOK81m6tLwy/wr0CoHEMp0dTDZCigF
         vO0RSfECag32nqJ1yrNIJhG2iSkEX6qUmfYnAppSMPvpijb88s3QvPMPdGnrqE/g90pw
         f2VbLRuHly7luJkE/25/8X1WtoARvB8/xRVk3NIk/w/KU31LYmixliGaAHghWGG7m6pf
         jd6W4opEgR8sOEkKxG5O0YUzj0zE8ZaOxt32YLwB01Yr1/1UvJsdBH3P3wguQwuIVLBd
         UIlw==
X-Gm-Message-State: ALyK8tIe+wKdifkS4zYahWgqCuHEC+1haJglFAqRAT+vC8SFPhUn+nIpyKQbds6NqBEIWg==
X-Received: by 10.25.201.203 with SMTP id z194mr19831690lff.192.1469035497130;
        Wed, 20 Jul 2016 10:24:57 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g74sm777884ljg.24.2016.07.20.10.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 10:24:56 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	max@max630.net, Junio C Hamano <gitster@pobox.com>,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	larsxschneider@gmail.com, sbeller@google.com, mhagger@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 3/4] submodule: support running in multiple worktree setup
Date:	Wed, 20 Jul 2016 19:24:18 +0200
Message-Id: <20160720172419.25473-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160720172419.25473-1-pclouds@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt | 8 ++++++++
 git-submodule.sh               | 8 ++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 41350db..2a5661d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -142,6 +142,14 @@ to share to all working directories:
    you are sure you always use sparse checkout for all working
    directories.
 
+ - `submodule.*` in current state should not be shared because the
+   information is tied to a particular version of .gitmodules in a
+   working directory.
+
+ - `remote.*` added by submodules may be per working directory as
+   well, unless you are sure remotes from all possible submodules in
+   history are consistent.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
diff --git a/git-submodule.sh b/git-submodule.sh
index 4ec7546..7b576f5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -261,7 +261,7 @@ or you are unsure what this means choose another name with the '--name' option."
 			esac
 		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
 	fi
-	git config submodule."$sm_name".url "$realrepo"
+	git config --worktree submodule."$sm_name".url "$realrepo"
 
 	git add $force "$sm_path" ||
 	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
@@ -461,7 +461,7 @@ Submodule work tree '\$displaypath' contains a .git directory
 			# Remove the whole section so we have a clean state when
 			# the user later decides to init this submodule again
 			url=$(git config submodule."$name".url)
-			git config --remove-section submodule."$name" 2>/dev/null &&
+			git config --worktree --remove-section submodule."$name" 2>/dev/null &&
 			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
 		fi
 	done
@@ -1106,7 +1106,7 @@ cmd_sync()
 		then
 			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
-			git config submodule."$name".url "$super_config_url"
+			git config --worktree submodule."$name".url "$super_config_url"
 
 			if test -e "$sm_path"/.git
 			then
@@ -1114,7 +1114,7 @@ cmd_sync()
 				sanitize_submodule_env
 				cd "$sm_path"
 				remote=$(get_default_remote)
-				git config remote."$remote".url "$sub_origin_url"
+				git config --worktree remote."$remote".url "$sub_origin_url"
 
 				if test -n "$recursive"
 				then
-- 
2.9.1.566.gbd532d4

