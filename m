Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1B5202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933738AbdJQHIM (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:08:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:44247 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933725AbdJQHIL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:08:11 -0400
Received: by mail-it0-f66.google.com with SMTP id n195so4895577itg.1
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 00:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tUJmiXeeCkgukja3JgsB/W9Yadg/VYSxT1MAf/F1CIA=;
        b=ZASevAbRA9pmTznlL0kHtwmdenQgjrOq/JA9nNHpLhfdBqGw4vdKxM3pJPoqkGQd4G
         v15NXWPi1+RXouNhYC895ZIwVZWMtpoI2bXAKOGVsTFmiBU7tSY3rKByWmhVSKzOW0zU
         vuJd12E/qtLOsEPA9Vfy4YiTuEjh+Zj/ZD9ep5lSNbg23259vm6pQC2pbF4Djn27lMgI
         +ZM481Rj0H7WQkQkv/biNvwPo3qu30i/2AqpxNaVOPfw/agCJHN7ecE7qJH+Q4aWm5oj
         hoqX6oo8UNipaSWeagKs7d1atcEBH9E1ODTwIpqBvgcAHPwEsSst1cxlANkEEuTvns55
         gcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tUJmiXeeCkgukja3JgsB/W9Yadg/VYSxT1MAf/F1CIA=;
        b=AQMOSPwzqAxETz3xS78nfmOnQmZBR1TshEt/MMcia1rA35FjLiUtXr8nzjrYo34eyc
         e2U0XJxDrNMobgSz5np2QfP3eGHrR6HkQavyfsGQUQAV6nXIu1wqVNmG5MjLkGg/ubfP
         nWU7dDdlWK3yb3JxgJc+n4LiZfy7BKe3j2hmu32gyF5H9mePfYbmhtYP823uzTop8m6G
         ucTmmVxaNJxRcHIOQN6ZdhBvisG89mlOkhNKSoZ5IpRAeFKytP7Eed/aJ0B6X0tmYflJ
         DQbTG6B9WhPDRmCNb6oQUrdW89vClrCafjJy3SV+eN5PQFj+RZLsjNOwfAPgsckhq7wA
         jUtQ==
X-Gm-Message-State: AMCzsaUlwDTJgcezmHMuttUm26n8x3iOBBZ+TkVvKUS2XqeO2Ij8LNRl
        u5lZqmm5sHroIsFsMx+tBVM=
X-Google-Smtp-Source: ABhQp+RpvE24wlwgu1/MenARAmTLeDeIgnb3hnNdSpE9g4+OY45wo939LUvH6lA1hpBd3u4bSRqB+A==
X-Received: by 10.36.43.193 with SMTP id h184mr4144825ita.15.1508224090613;
        Tue, 17 Oct 2017 00:08:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g196sm4961024ita.4.2017.10.17.00.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 00:08:10 -0700 (PDT)
Date:   Tue, 17 Oct 2017 00:08:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 1/3] check-ref-format --branch: do not expand @{...} outside
 repository
Message-ID: <20171017070808.plddffhzdobyekmo@aiede.mtv.corp.google.com>
References: <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
 <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
 <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
 <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
 <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
 <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
 <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Running "git check-ref-format --branch @{-1}" from outside any
repository produces

	$ git check-ref-format --branch @{-1}
	BUG: environment.c:182: git environment hasn't been setup

This is because the expansion of @{-1} must come from the HEAD reflog,
which involves opening the repository.  @{u} and @{push} (which are
more unusual because they typically would not expand to a local
branch) trigger the same assertion.

This has been broken since day one.  Before v2.13.0-rc0~48^2
(setup_git_env: avoid blind fall-back to ".git", 2016-10-02), the
breakage was more subtle: Git would read reflogs from ".git" within
the current directory even if it was not a valid repository.  Usually
that is harmless because Git is not being run from the root directory
of an invalid repository, but in edge cases such accesses can be
confusing or harmful.  Since v2.13.0, the problem is easier to
diagnose because Git aborts with a BUG message.

Erroring out is the right behavior: when asked to interpret a branch
name like "@{-1}", there is no reasonable answer in this context.
But we should print a message saying so instead of an assertion failure.

We do not forbid "check-ref-format --branch" from outside a repository
altogether because it is ok for a script to pre-process branch
arguments without @{...} in such a context.  For example, with
pre-2.13 Git, a script that does

	branch='master'; # default value
	parse_options
	branch=$(git check-ref-format --branch "$branch")

to normalize an optional branch name provided by the user would work
both inside a repository (where the user could provide '@{-1}') and
outside (where '@{-1}' should not be accepted).

So disable the "expand @{...}" half of the feature when run outside a
repository, but keep the check of the syntax of a proposed branch
name. This way, when run from outside a repository, "git
check-ref-format --branch @{-1}" will gracefully fail:

	$ git check-ref-format --branch @{-1}
	fatal: '@{-1}' is not a valid branch name

and "git check-ref-format --branch master" will succeed as before:

	$ git check-ref-format --branch master
	master

restoring the usual pre-2.13 behavior.

[jn: split out from a larger patch; moved conditional to
 strbuf_check_branch_ref instead of its caller; fleshed out commit
 message; some style tweaks in tests]

Reported-by: Marko Kungla <marko.kungla@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_name.c                 |  5 ++++-
 t/t1402-check-ref-format.sh | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index c7c5ab376c..603e667faa 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1331,7 +1331,10 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 {
-	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
+	if (startup_info->have_repository)
+		strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
+	else
+		strbuf_addstr(sb, name);
 	if (name[0] == '-')
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 0790edf60d..98e4a8613b 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -144,6 +144,11 @@ test_expect_success "check-ref-format --branch @{-1}" '
 	refname2=$(git check-ref-format --branch @{-2}) &&
 	test "$refname2" = master'
 
+test_expect_success 'check-ref-format --branch -naster' '
+	test_must_fail git check-ref-format --branch -naster >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'check-ref-format --branch from subdir' '
 	mkdir subdir &&
 
@@ -161,6 +166,17 @@ test_expect_success 'check-ref-format --branch from subdir' '
 	test "$refname" = "$sha1"
 '
 
+test_expect_success 'check-ref-format --branch @{-1} from non-repo' '
+	nongit test_must_fail git check-ref-format --branch @{-1} >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'check-ref-format --branch master from non-repo' '
+	echo master >expect &&
+	nongit git check-ref-format --branch master >actual &&
+	test_cmp expect actual
+'
+
 valid_ref_normalized() {
 	prereq=
 	case $1 in
-- 
2.15.0.rc1.287.g2b38de12cc

