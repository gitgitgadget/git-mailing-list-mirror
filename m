Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D21C6FD19
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 21:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCLVHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 17:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCLVHT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 17:07:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE7E302B1
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:07:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id ja10so1211722plb.5
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678655237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIWPvLpHGH/Rmqjgets+nupO5229joVEE60or2Njs5Y=;
        b=qrs8/Ijm3P9eFGjirtYt/jg1MSFbWXGi55zbiODrMCOBKWkn1eEyLKmn0QbTezIQBd
         +YUcxRvT6QNGbClIbMG3edTn4UY1pQebPXLkEYXHKKXB/h82S5QcTKPmlU2kNy/fP6Nr
         CDIOM4c06O6UGXb16sbIKUK5/E7dfONZ4K30d+2UupslWbfQhc98yt7xH73E7vgO/lHQ
         6yjcURgSjvmKM7VNbu/lnj6Tzfxq89F0HRobxnoLyW0JjUwXzQ2Aco1PAUibWYQy+6p9
         yLV9PYvxkn3peeZzZ6vhOemA22q7HJKBU9G71j2tl2VsI5na8mke/ifiv7BD9b1oKplG
         bDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678655237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIWPvLpHGH/Rmqjgets+nupO5229joVEE60or2Njs5Y=;
        b=XY5cdLBpV/oM9E8WOfoT5cC58T/VIL9DRnlsDJN07YZT0V6ssVTZbHkYEMcYfM1777
         2WtcWuyiJNZGaKxeq1wqlN3MbAEsk1lNfGeLF0Wb2mp95QG06Jm4H99ZQQ3gMDGk2IQ3
         pLWYpzaOIHmnPxZ3Nhp82L8bwF5eZnlWHSdn1Wc4v7aTAd+RMXwhjX5531ZAj3I/JQyo
         DM3i4KPdMLklUh1Xjo/bvL/0ZWXLb+XVzrhGwzwdKAqipv7jwjuQYve3V9yf6vc630Tm
         QLPOTfpRc4RBIYFRg8gtIyjlWsUVjEEkn4kBOD0Y7W+e6b+1vIZDAbtj0sm2ctY7p9Py
         CxEA==
X-Gm-Message-State: AO0yUKUWGQskiLuZlcfCOG2fXX1y912HndG5Wbj3HlLdVu4+K1tPZcWc
        4YnqJtwYgyj5Jh9kSNQxI4UUEiCi9rKioQ==
X-Google-Smtp-Source: AK7set+eP5nysyoSTBFHCVdRHAsbZu++3XtCyH5O0KENCpyX+D+1zEH0rEsTEN9q3z75dSqeiqOjqQ==
X-Received: by 2002:a17:902:6941:b0:19e:664d:8a28 with SMTP id k1-20020a170902694100b0019e664d8a28mr27710136plt.15.1678655236850;
        Sun, 12 Mar 2023 14:07:16 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b0019f2a7f4d16sm2653043plg.39.2023.03.12.14.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:07:16 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com, jonathantanmy@google.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v7 0/3] rebase: document, clean up, and introduce a config option for --rebase-merges
Date:   Sun, 12 Mar 2023 15:04:53 -0600
Message-Id: <20230312210456.92364-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305050709.68736-1-alexhenrie24@gmail.com>
References: <20230305050709.68736-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces a rebase.rebaseMerges config option to
accommodate users who would like --rebase-merges to be on by default and
to facilitate turning on --rebase-merges by default without
configuration in a future version of Git. It also cleans up and
documents the behavior of the --rebase-merges command line option to
avoid confusion about how the config option and the command line option
interact.

Changes from v6:
- Don't say that the default rebase-merges mode will likely change to
  rebase-cousins (although it might change to something else)
- In git-config.txt, say that rebase.rebaseMerges=true is equivalent
  to --rebase-merges=no-rebase-cousins
- Add a link from the revised paragraph in git-rebase.txt to the
  corresponding new section in git-config.txt
- Clear rebase_cousins if rebase.rebaseMerges is set to true after
  having been set to rebase-cousins or no-rebase-cousins
- Actually remove the test for --rebase-merges=""
- Remove the test for --rebase-merges=no-rebase-cousins overriding
  rebase.rebaseMerges=rebase-cousins

Suggestions on v6 not incorporated in v7:
- Make --rebase-merges without an argument clobber the mode specified in
  rebase.rebaseMerges
- In the tests, pass --force and check the graph itself or the reflog
  instead of checking that the graph has not changed by checking that
  the commit hash has not changed
- Add --rebase-merges=on as a synonym of
  --rebase-merges=no-rebase-cousins and --rebase-merges=off as a synonym
  of --no-rebase-merges
- Rewrite the documentation for rebase-cousins to more clearly explain
  the difference between rebase-cousins and no-rebase-cousins

Thanks to Phillip, Junio, Glen, and Sergey for your feedback on v6.

Alex Henrie (3):
  rebase: add documentation and test for --no-rebase-merges
  rebase: deprecate --rebase-merges=""
  rebase: add a config option for --rebase-merges

 Documentation/config/rebase.txt        | 11 ++++
 Documentation/git-rebase.txt           | 20 ++++---
 builtin/rebase.c                       | 76 +++++++++++++++++++-------
 t/t3422-rebase-incompatible-options.sh | 17 ++++++
 t/t3430-rebase-merges.sh               | 58 ++++++++++++++++++++
 5 files changed, 156 insertions(+), 26 deletions(-)

Range-diff against v6:
1:  bf08c03ba7 = 1:  3aee0c2277 rebase: add documentation and test for --no-rebase-merges
2:  26f98b8400 = 2:  e57843d8b5 rebase: deprecate --rebase-merges=""
3:  402365256c ! 3:  b0c1a4dcb2 rebase: add a config option for --rebase-merges
    @@ Commit message
         .gitconfig.
     
         In the future, the default rebase-merges mode may change from
    -    no-rebase-cousins to rebase-cousins. Support setting rebase.rebaseMerges
    -    to the nonspecific value "true" for users who do not need or want to
    -    care about the default changing in the future. Similarly, for users who
    -    have --rebase-merges in an alias and want to get the future behavior
    -    now, use the specific rebase-merges mode from the config if a specific
    -    mode is not given on the command line.
    +    no-rebase-cousins to some other mode that doesn't exist yet. Support
    +    setting rebase.rebaseMerges to the nonspecific value "true" for users
    +    who do not need or want to care about the default changing in the
    +    future. Similarly, for users who have --rebase-merges in an alias and
    +    want to get the future behavior now, use the specific rebase-merges mode
    +    from the config if a specific mode is not given on the command line.
     
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
    @@ Documentation/config/rebase.txt: rebase.rescheduleFailedExec::
     +rebase.rebaseMerges::
     +	Whether and how to set the `--rebase-merges` option by default. Can
     +	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
    -+	true is equivalent to `--rebase-merges` without an argument, setting to
    -+	`rebase-cousins` or `no-rebase-cousins` is equivalent to
    -+	`--rebase-merges` with that value as its argument, and setting to false
    -+	is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
    ++	true or to `no-rebase-cousins` is equivalent to
    ++	`--rebase-merges=no-rebase-cousins`, setting to `rebase-cousins` is
    ++	equivalent to `--rebase-merges=rebase-cousins`, and setting to false is
    ++	equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
     +	command line without an argument overrides a `rebase.rebaseMerges=false`
     +	configuration, but the absence of a specific rebase-merges mode on the
     +	command line does not counteract a specific mode set in the configuration.
    @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
     -such commits are instead rebased onto `<upstream>` (or `<onto>`, if
     -specified).
     +`no-rebase-cousins`. If the mode is not specified on the command line or in
    -+the `rebase.rebaseMerges` config option, it defaults to `no-rebase-cousins`.
    -+In `no-rebase-cousins` mode, commits which do not have `<upstream>` as direct
    ++the `rebase.rebaseMerges` config option (see linkgit:git-config[1] or
    ++"CONFIGURATION" below), it defaults to `no-rebase-cousins`. In
    ++`no-rebase-cousins` mode, commits which do not have `<upstream>` as direct
     +ancestor will keep their original branch point, i.e. commits that would be
     +excluded by linkgit:git-log[1]'s `--ancestry-path` option will keep their
     +original ancestry by default. In `rebase-cousins` mode, such commits are
    @@ builtin/rebase.c: static int rebase_config(const char *var, const char *value, v
     +		if (opts->config_rebase_merges < 0) {
     +			opts->config_rebase_merges = 1;
     +			parse_rebase_merges_value(opts, value);
    -+		}
    ++		} else
    ++			opts->rebase_cousins = 0;
     +		return 0;
     +	}
     +
    @@ t/t3430-rebase-merges.sh: test_expect_success 'do not rebase cousins unless aske
      	EOF
      '
      
    -+test_expect_success '--rebase-merges="" is deprecated' '
    -+	git rebase --rebase-merges="" HEAD^ 2>actual &&
    -+	grep deprecated actual
    -+'
    -+
     +test_expect_success 'rebase.rebaseMerges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
     +	test_config rebase.rebaseMerges rebase-cousins &&
     +	git checkout -b config-rebase-cousins main &&
    @@ t/t3430-rebase-merges.sh: test_expect_success 'do not rebase cousins unless aske
     +	EOF
     +'
     +
    -+test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.rebaseMerges=rebase-cousins' '
    -+	test_config rebase.rebaseMerges rebase-cousins &&
    -+	git checkout -b override-config-rebase-cousins main &&
    -+	git rebase --rebase-merges=no-rebase-cousins HEAD^ &&
    -+	test_cmp_graph HEAD^.. <<-\EOF
    -+	*   Merge the topic branch '\''onebranch'\''
    -+	|\
    -+	| * D
    -+	| * G
    -+	o | H
    -+	|/
    -+	o A
    -+	EOF
    -+'
    -+
     +test_expect_success '--rebase-merges overrides rebase.rebaseMerges=false' '
     +	test_config rebase.rebaseMerges false &&
     +	git checkout -b override-config-merges-false E &&
-- 
2.39.2

