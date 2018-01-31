Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE671F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeAaLIF (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:05 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38996 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbeAaLHn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:43 -0500
Received: by mail-pf0-f193.google.com with SMTP id e11so12238430pff.6
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSPlVOcM1myV/FmJfCtX8UGm5CwFXnAKmk3Ykfz8qVI=;
        b=XFpS3z1V4jWylfiNK9ixHYs+a4eJuox+MOf5m1kgPhmmeeDNl3CV8NzrtydWylS1B6
         +UJJFXvIeSSVDYOuh2sIOy6Lsp8BJlAo4h53nQXBH5kYapvhT+vEottljTtuUtL6ccvv
         v+8jRm1f11vJKZXf5Bex/FuLfmnbqrX03bbvalY07SHRO0kFRsPVlaRh4qQ3y2ddjhfG
         ONbGV4AvZS61nlKkgwixqBNjJ1YWezKfP4r7pX6gMZYq8hQdlO0AmaEEZzxEc/rtOCaX
         /NIhSDMwExZf3fh8j2Hdj/5WmY1vB7YrDswUsYaJFsHIuA5Xyg2A5zqiof94Hgu0XxuE
         ArPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSPlVOcM1myV/FmJfCtX8UGm5CwFXnAKmk3Ykfz8qVI=;
        b=QTKCgp59OOpU/KmJIeXo2GA9y+lyu+tL4nfXNOOqVQMlvz5CadG50uLiJo6ySDUS5q
         maK6MXLexphfh528vvanqEJd071TB0hkHvZKcMaajUJ+/n84jTV99k6l0SILUL6C6xqU
         J7mzLEB3q02wyREwuMY22yQIvqAo2xdhGUFrWrgatpHAPaLLs1Akmpi8Icg6di4gHXVQ
         XESWARgNR0Y3SlTU5tfU2XUDxTdv236Rd/XWcseVdCyNFpCiTFe4uZdFr6+qCvmi67Qz
         0caV+sU2S61YQGojdUo79YRLU3LPlx7O/1PZTnEYNGlnHF1YCqV487Pi5DoJ78Y5roBR
         pDPw==
X-Gm-Message-State: AKwxytcF4Nm4R0OzmSBFOaCVLZuGTBkiu24tftqYFsTjE3/d1mqjwMWh
        M3mppIRPCjICxXtLu3fJyJkGqw==
X-Google-Smtp-Source: AH8x226gwJgT4COUCkCQ32pwhu57+oHviZtW60intQAiuLCdgc922L66LrsNxsSeKHjzPDxtgrQ19A==
X-Received: by 10.101.80.202 with SMTP id s10mr25843501pgp.226.1517396863167;
        Wed, 31 Jan 2018 03:07:43 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id o9sm40030404pfk.80.2018.01.31.03.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 23/41] completion: use __gitcomp_builtin in _git_ls_files
Date:   Wed, 31 Jan 2018 18:05:29 +0700
Message-Id: <20180131110547.20577-24-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--debug
--empty-directory
--eol
--recurse-submodules
--resolve-undo

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3e0973a562..e65e71760f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1602,13 +1602,7 @@ _git_ls_files ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--cached --deleted --modified --others --ignored
-			--stage --directory --no-empty-directory --unmerged
-			--killed --exclude= --exclude-from=
-			--exclude-per-directory= --exclude-standard
-			--error-unmatch --with-tree= --full-name
-			--abbrev --ignored --exclude-per-directory
-			"
+		__gitcomp_builtin ls-files "--no-empty-directory"
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

