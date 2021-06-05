Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED86C4743C
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12211613D8
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFEBQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:16:47 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42503 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhFEBQq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 21:16:46 -0400
Received: by mail-oi1-f182.google.com with SMTP id v142so11132642oie.9
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 18:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QYpPwPqpdCAw7sD+MuRl0sr1uDM5ZdriWJTi3u0snBg=;
        b=VGwM/Re4cjhWlNTw+hZonNXsQLcMBH4WW6WgB1r0+oBWrkUu8MLYz8lI8iuN75kCD3
         tqoI28Zh5pqOo8jX6umhUGznVsg4gMEL/q1e33G5fjPofxQgj7lX41zIrKREkJPe9heW
         f4W+4a2TpbBqfy1MGb6UuCiUJy8Qc5FqDCVPAYUsEhFckxLGPP6DAjPhtcxbjEVfc1gD
         iGMSERO8xnZ4eHYTEdCn6LjZjuI3GJJLaWhKHBpep8GPg/iStnB1h0o1sKphdfCdfftP
         1TEG4t2yL64fCt/7SUJG4f8SZ+ygVe3v5J/akiUKEtEq5FCdREiB2SWDDb7ek6oNyR+j
         SlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QYpPwPqpdCAw7sD+MuRl0sr1uDM5ZdriWJTi3u0snBg=;
        b=Whz3qGWU2tOoY/0p1+Jz0gAZFjSIVFi1nlLjYdlBJDtb8i3+XRiE89ALchPHgOvD5o
         jZboHDJcXzHtnkwKwYHaoeRRH9EjC8kwiY1xU5wdj3LhRngiqmcNb/YugLsCsWfF0isu
         YnLDKzZfJG3JzJxuEy/oUDzhDJDCRRRovmPNnePHIQ6pzn90+eG3kYFoYBkd7tP2qGrO
         KTvH8lfEuHcL1bTHVrSE+zXu/QYqKPb5enOuVAqWUJyd1z/gmxj/T1Ou/6XLH5sT6pYC
         WbBAbmRK4opAwZDzBBm46xZ7OAmVbQ3SwN11h4MZCy2tIE2BPixomzO95DZ+tbupFkFi
         CxPA==
X-Gm-Message-State: AOAM533poUc5Z8YfHXR73yVUcaRFRmnzIPqSX5HiEuQXOUGusEg59qoP
        K8thTCDF1JJ2fVWrWEipOMjvJf6T7xjwFQ==
X-Google-Smtp-Source: ABdhPJzRSgTrBV545jeJSmhO3NrR/rVndewuCHcL/Lz0VSZIsuuViC7zC2nJiLBeNODdkq2qDCBK0A==
X-Received: by 2002:a05:6808:2d3:: with SMTP id a19mr12923984oid.133.1622855629425;
        Fri, 04 Jun 2021 18:13:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r19sm772672ooj.5.2021.06.04.18.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:13:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] branch: make -v useful
Date:   Fri,  4 Jun 2021 20:13:39 -0500
Message-Id: <20210605011339.2202-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently `git branch -v` shows something like "[ahead 10]", but ahead
of what?

We git experts know ahead of what, but not what that what is set to. Just
like "[@{upstream}: ahead 10]" would not be particularly useful to
anyone that doesn't know, or remembers, what @{upstream} is set to.

On the other hand "[master: ahead 10]" is perfectly clear to anyone.

This confusion only gets worse when you see "[ahead 10, behind 100]". Is
it master? Is it next? Is it
john/experimental-feature-i-based-my-branch-on?

Inevitably most users will need to know what @{upstream} is.

So let's make `git branch -v` output what is most useful:

  [master]

Before:

  * fc/branch/sane-colors b2489a3735 [ahead 1] branch: make -v useful

After:

  * fc/branch/sane-colors b2489a3735 [master] branch: make -v useful

An additional benefit is that `git branch -v` is slightly faster: 30ms
vs. 60ms on my system.

`git branch -vv` is unaffected.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This is a reboot of my old patch series [1].

Every time I use git without this feature I miss it.

[1] https://lore.kernel.org/git/1398027514-19399-1-git-send-email-felipe.contreras@gmail.com/

 builtin/branch.c           |  9 ++++-----
 t/t3201-branch-contains.sh |  2 +-
 t/t6040-tracking-info.sh   | 12 ++++++------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752..7c0d3f7e4e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -375,16 +375,15 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		strbuf_addstr(&local, branch_get_color(BRANCH_COLOR_RESET));
 		strbuf_addf(&local, " %s ", obname.buf);
 
+		strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
+			    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
 		if (filter->verbose > 1)
-		{
-			strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
-				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
 				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
 				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
-		}
 		else
-			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
+			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)%%(contents:subject)",
+				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
 
 		strbuf_addf(&remote, "%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s"
 			    "%%(if)%%(symref)%%(then) -> %%(symref:short)"
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 349a810cee..53e2d65e67 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -261,7 +261,7 @@ test_expect_success 'branch --merged with --verbose' '
 	git branch --verbose --merged topic >actual &&
 	cat >expect <<-EOF &&
 	  main  $(git rev-parse --short main) second on main
-	* topic $(git rev-parse --short topic ) [ahead 1] foo
+	* topic $(git rev-parse --short topic ) [main] foo
 	  zzz   $(git rev-parse --short zzz   ) second on main
 	EOF
 	test_cmp expect actual
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index a313849406..30f80ad61b 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -43,12 +43,12 @@ test_expect_success setup '
 
 t6040_script='s/^..\(b.\) *[0-9a-f]* \(.*\)$/\1 \2/p'
 cat >expect <<\EOF
-b1 [ahead 1, behind 1] d
-b2 [ahead 1, behind 1] d
-b3 [behind 1] b
-b4 [ahead 2] f
-b5 [gone] g
-b6 c
+b1 [origin/main] d
+b2 [origin/main] d
+b3 [origin/main] b
+b4 [origin/main] f
+b5 [brokenbase] g
+b6 [origin/main] c
 EOF
 
 test_expect_success 'branch -v' '
-- 
2.32.0.rc2

