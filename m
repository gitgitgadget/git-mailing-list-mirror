Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D29C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 15:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiLAPzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 10:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiLAPzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 10:55:18 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0B4B0DF9
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 07:55:16 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jl24so2027282plb.8
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 07:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H2Yl8jtUp+7mZeVorWsrJDU24wXvUg3wWFuD2I0KwI=;
        b=RDmN3nDsr6QjuIQmjK7iff59z0cleWXHbpyGaoLeUzaHPW2XsjOUIPxFgDcEiYEPYC
         fLdR2bQefPBg0YuWLwBQvS02uGSojl9GwYC7ePqoaMnamFa03xSJz54xY3vdcGZVM16f
         nTZ21YAI3rDJfHMxyX6z5UJDEOQd753j4fvQytOClqXANsbg4sIDOTJAQSYFhQZwPbAE
         rBv2KMdQzbv6b89QfJ3kanoIlr1LkBjsHyfgb1uYwLqZxieo11H0+o9BdC1PTDeV4H7N
         IgdmFxPc2fHbRBe5FJeBhNcezD72riiS5wl/LHbEtZ+yzNRQe1cwLYNPtzTIzlYwb1MS
         pzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H2Yl8jtUp+7mZeVorWsrJDU24wXvUg3wWFuD2I0KwI=;
        b=kMXgT6IRHQQPhQ1aH66I1BPAwj0LBn4HfM2iB30ljPQ6U7GBlwC52rg/qOOMAzmbya
         eYk4j1CnikvK+ePxpK72yMjWVX6uCAt1MS8MivDgOw53jVgO+bzIjSa92IhAdvk60Alx
         Du++rExlZt3VWpUTbUj4d3rDon217zRsdovFAxetwZf7KXEEwdXtc0BmV9ZXmE4y6u52
         B3h1MTxH67CBMUScJZSDM4pQDpUkDa7dkdMMy4wik5e/5nrl07jigNLUtq64Q1W9+x1k
         KUp+g/UyyntaxRkbOSOuUua7gf9rjAwGcPrpRNjRaD+qlffPntD1Q1pAKDRIfTyhMoWR
         ifpA==
X-Gm-Message-State: ANoB5plsd4CLlpWWiFRPvQhqaszzZIrSM1ok5xYXTBJqmz/oktcNfSvW
        4tEgokqqs75zniR7ivjKKIVAV+lRsErLtw==
X-Google-Smtp-Source: AA0mqf72cpWbx2q6n+UBXkuf545GhOiGjMyAf98qeWxT7pgnQDE5yZ1k4OakPfoo9KhjpOeyitfFKA==
X-Received: by 2002:a17:90a:cf02:b0:219:63d9:5167 with SMTP id h2-20020a17090acf0200b0021963d95167mr9580398pju.204.1669910115600;
        Thu, 01 Dec 2022 07:55:15 -0800 (PST)
Received: from HB2.. ([2401:4900:36ac:5594:1695:30e6:556:ccb7])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056c349f5c70sm3405290pfr.79.2022.12.01.07.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 07:55:15 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v6 0/2] Add mailmap mechanism in cat-file options
Date:   Thu,  1 Dec 2022 21:25:02 +0530
Message-Id: <20221201155504.320461-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.6.g86692db720
In-Reply-To: <20220916205946.178925-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a ton Christian, Ævar and Junio for review :) I have made the
suggested changes in this patch series.

= Description

At present, `git-cat-file` command with `--batch-check` and `-s` options
does not complain when `--use-mailmap` option is given. The latter
option is just ignored. Instead, for commit/tag objects, the command
should compute the size of the object after replacing the idents and
report it. So, this patch series makes `-s` and `--batch-check` options
of `git-cat-file` honor mailmap when used with `--use-mailmap` option.

In this patch series we didn't want to change that '%(objectsize)'
always shows the size of the original object even when `--use-mailmap`
is set because first we have the long term plan to unify how the formats
for `git cat-file` and other commands works. And second existing formats
like the "pretty formats" used by `git log` have different options for
fields respecting mailmap or not respecting it (%an is for author name
while %aN for author name respecting mailmap).

I would like to thank my mentors, Christian Couder and John Cai, for all
of their help!
Looking forward to the reviews!

= Patch Organization

- The first patch makes `-s` option to return updated size of the
  <commit/tag> object, when combined with `--use-mailmap` option, after
  replacing the idents using the mailmap mechanism.
- The second patch makes `--batch-check` option to return updated size of
  the <commit/tag> object, when combined with `--use-mailmap` option,
  after replacing the idents using the mailmap mechanism.

= Changes in v5

- The patch series which improves the documentation for `-s`, `--batch`,
  `--batch-check` and `--batch-command` is again part of this patch
  series with patch 3/3 squashed into patches 1/3 and 2/3 as suggested
  by Junio, Taylor and Christian. The doc patch series was perviously
  sent independently for improving the documentation of git cat-file
  options:
  https://lore.kernel.org/git/20221029092513.73982-1-siddharthasthana31@gmail.com/

- Improve the tests according to run under SHA-256 mode.

= Changes in v6

- Improve the tests so it doesn't break under macOS.

Siddharth Asthana (2):
  cat-file: add mailmap support to -s option
  cat-file: add mailmap support to --batch-check option

 Documentation/git-cat-file.txt | 53 +++++++++++++++++++--------
 builtin/cat-file.c             | 27 ++++++++++++++
 t/t4203-mailmap.sh             | 65 ++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 14 deletions(-)

Range-diff against v5:
1:  0db3583535 ! 1:  15366d872e cat-file: add mailmap support to -s option
    @@ t/t4203-mailmap.sh: test_expect_success '--mailmap enables mailmap in cat-file f
     +	cat >.mailmap <<-\EOF &&
     +	C O Mitter <committer@example.com> Orig <orig@example.com>
     +	EOF
    -+	git cat-file commit HEAD | wc -c >expect &&
    -+	git cat-file --use-mailmap commit HEAD | wc -c >>expect &&
    ++	git cat-file commit HEAD >commit.out &&
    ++	echo $(wc -c <commit.out) >expect &&
    ++	git cat-file --use-mailmap commit HEAD >commit.out &&
    ++	echo $(wc -c <commit.out) >>expect &&
     +	git cat-file -s HEAD >actual &&
     +	git cat-file --use-mailmap -s HEAD >>actual &&
     +	test_cmp expect actual
    @@ t/t4203-mailmap.sh: test_expect_success '--mailmap enables mailmap in cat-file f
     +	Orig <orig@example.com> C O Mitter <committer@example.com>
     +	EOF
     +	git tag -a -m "annotated tag" v3 &&
    -+	git cat-file tag v3 | wc -c >expect &&
    -+	git cat-file --use-mailmap tag v3 | wc -c >>expect &&
    ++	git cat-file tag v3 >tag.out &&
    ++	echo $(wc -c <tag.out) >expect &&
    ++	git cat-file --use-mailmap tag v3 >tag.out &&
    ++	echo $(wc -c <tag.out) >>expect &&
     +	git cat-file -s v3 >actual &&
     +	git cat-file --use-mailmap -s v3 >>actual &&
     +	test_cmp expect actual
2:  b8205ede7d ! 2:  86692db720 cat-file: add mailmap support to --batch-check option
    @@ t/t4203-mailmap.sh: test_expect_success 'git cat-file -s returns correct size wi
     +	cat >.mailmap <<-\EOF &&
     +	C O Mitter <committer@example.com> Orig <orig@example.com>
     +	EOF
    -+	commit_size=`git cat-file commit HEAD | wc -c` &&
    -+	commit_sha=`git log --pretty=format:'%H' -n 1` &&
    -+	echo "$commit_sha commit $commit_size" >expect &&
    -+	commit_size=`git cat-file --use-mailmap commit HEAD | wc -c` &&
    -+	echo "$commit_sha commit $commit_size" >>expect &&
    ++	git cat-file commit HEAD >commit.out &&
    ++	commit_size=$(wc -c <commit.out) &&
    ++	commit_sha=$(git rev-parse HEAD) &&
    ++	echo $commit_sha commit $commit_size >expect &&
    ++	git cat-file --use-mailmap commit HEAD >commit.out &&
    ++	commit_size=$(wc -c <commit.out) &&
    ++	echo $commit_sha commit $commit_size >>expect &&
     +	echo "HEAD" >in &&
     +	git cat-file --batch-check <in >actual &&
     +	git cat-file --use-mailmap --batch-check <in >>actual &&
    @@ t/t4203-mailmap.sh: test_expect_success 'git cat-file -s returns correct size wi
     +	cat >.mailmap <<-\EOF &&
     +	C O Mitter <committer@example.com> Orig <orig@example.com>
     +	EOF
    -+	commit_size=`git cat-file commit HEAD | wc -c` &&
    -+	commit_sha=`git log --pretty=format:'%H' -n 1` &&
    -+	echo "$commit_sha commit $commit_size" >expect &&
    -+	commit_size=`git cat-file --use-mailmap commit HEAD | wc -c` &&
    -+	echo "$commit_sha commit $commit_size" >>expect &&
    ++	git cat-file commit HEAD >commit.out &&
    ++	commit_size=$(wc -c <commit.out) &&
    ++	commit_sha=$(git rev-parse HEAD) &&
    ++	echo $commit_sha commit $commit_size >expect &&
    ++	git cat-file --use-mailmap commit HEAD >commit.out &&
    ++	commit_size=$(wc -c <commit.out) &&
    ++	echo $commit_sha commit $commit_size >>expect &&
     +	echo "info HEAD" >in &&
     +	git cat-file --batch-command <in >actual &&
     +	git cat-file --use-mailmap --batch-command <in >>actual &&
-- 
2.39.0.rc1.6.g86692db720

