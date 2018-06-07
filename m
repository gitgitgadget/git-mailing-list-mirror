Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A071F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeFGFIz (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:08:55 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:47067 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeFGFIx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:08:53 -0400
Received: by mail-oi0-f67.google.com with SMTP id h79-v6so7409764oig.13
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+tEpNDqGePZAl8Oig92GjhwxoOrBVJnsgmCxp+bpgI=;
        b=VODhYccb/yEUtR2Ie/8DfsIUpeLz30d1hXyBduDWiiV6tcuH2IXDv1suO8ZjkbkDlR
         nkq7KUqB+HWPiIlBhGImk8Agn1YEgoYNki0KrrC+9k+twBvo/t0gh59xIu21clHj0NyO
         esc2Bo4X2kOVTH3Jaoe5w2osBH0TEU17AlufhXwnUCPIt30Jq8v9kc8pY30pVWnvUFfM
         +R94E01ViXsnFGah5RnZHE4kQwgpR4mfOM3iX1Mgxc5DZaxSJA1zDjKCakWh7+K3cbSC
         4YCMyR2x1KhqbnXpNjbhgrQEviJeBh4ZfcKpHCgBTmMwRH1uYHjXwN3yjgMWs7I/61mP
         2X1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S+tEpNDqGePZAl8Oig92GjhwxoOrBVJnsgmCxp+bpgI=;
        b=VQwyllDfhCSpGFIqF77/tkMRgRbKrs/Dk4jOsbErv8ScwQAw79kik1oTo+6ni/d1rq
         4SLA/ZwidiA11XuUDxoXgcOJzc3CtNkvXeyFp1DHZ6amcZIe+dSzWFQNn03pwcVSqeAE
         YfoI1GlhfmtiRnO65n8RBdA4lGULUmHWLle6kPhMVlu3FgEFan5e9R008UBZ9IXVoJYs
         spMdKsUgPjXEh9AZrQLvn36TPzF2t4ercKJPiwdI0kpTqoZp/eT/MFWqRxrdKOUD45Y4
         4O0BfFbcMop8Zf88Ty+LD4ZKmzt8dog2Bbl3xOsrtDo8KIICxlpVmeIW8LeVfHKpY9Y5
         zStg==
X-Gm-Message-State: APt69E3lMi8Y3jLMFtSFFhSR+IFehqnZEKKX4HUL9lDMwbQvCbDkXflq
        PMF1UyCfxNWNXSOHCz7JZ4GrPg==
X-Google-Smtp-Source: ADUXVKKnJrnEzkftLEScEH+zQugefEc7m8VT7ulLXBNTNX3eRv5CXISgwVzWYCDSZdmi62kNOCTrAw==
X-Received: by 2002:aca:4bd7:: with SMTP id y206-v6mr148298oia.181.1528348132980;
        Wed, 06 Jun 2018 22:08:52 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f97-v6sm7200539otb.9.2018.06.06.22.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:08:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] Fix use of strategy options with interactive rebases
Date:   Wed,  6 Jun 2018 22:08:45 -0700
Message-Id: <20180607050845.19779-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.46.g9cee8fce43
In-Reply-To: <20180607050845.19779-1-newren@gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050845.19779-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-rebase.sh wrote stuff like
  '--ours'  '--renormalize'
to .git/rebase-merge/strategy_opts.  Note the double spaces.

git-rebase--interactive uses sequencer.c to parse that file, and
sequencer.c used split_cmdline() to get the individual strategy options.
After splitting, sequencer.c prefixed each "option" with a double dash,
so, concatenating all its options would result in:
  -- --ours -- --renormalize

So, when it ended up calling try_merge_strategy(), that in turn would run
  git merge-$strategy -- --ours -- --renormalize $merge_base -- $head $remote

instead of the expected
  git merge-$strategy --ours --renormalize $merge_base -- $head $remote

Remove the extra spaces so that split_cmdline() will work as expected.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-rebase.sh              | 2 +-
 sequencer.c                | 7 ++++++-
 t/t3418-rebase-continue.sh | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 40be59ecc4..224d5ebc29 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -316,7 +316,7 @@ do
 		do_merge=t
 		;;
 	--strategy-option=*)
-		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--${1#--strategy-option=}")"
+		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--${1#--strategy-option=}" | sed -e s/^.//)"
 		do_merge=t
 		test -z "$strategy" && strategy=recursive
 		;;
diff --git a/sequencer.c b/sequencer.c
index cca968043e..a2843e3906 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2203,6 +2203,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 {
 	int i;
+	char *strategy_opts_string;
 
 	strbuf_reset(buf);
 	if (!read_oneliner(buf, rebase_path_strategy(), 0))
@@ -2211,7 +2212,11 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
 		return;
 
-	opts->xopts_nr = split_cmdline(buf->buf, (const char ***)&opts->xopts);
+	strategy_opts_string = buf->buf;
+	if (*strategy_opts_string == ' ')
+		strategy_opts_string++;
+	opts->xopts_nr = split_cmdline(strategy_opts_string,
+				       (const char ***)&opts->xopts);
 	for (i = 0; i < opts->xopts_nr; i++) {
 		const char *arg = opts->xopts[i];
 
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 872022106f..7ca6cbc415 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -74,7 +74,7 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test -f funny.was.run
 '
 
-test_expect_failure 'rebase -i --continue handles merge strategy and options' '
+test_expect_success 'rebase -i --continue handles merge strategy and options' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F2-on-topic-branch &&
 	test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
-- 
2.18.0.rc0.46.g9cee8fce43

