Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09684C4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 13:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiLQNa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 08:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiLQNaR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 08:30:17 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67813CE27
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:30:16 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf42so7545697lfb.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ee/TEUjaymjFJ0bci2nCadzw0QTA9Rx1EdY5ofB0oc=;
        b=ow2akf4hB8QTaKSpK/kE47qERImoB9ZkO4faS/PYn3GU4caSyYx0gU93keXgGtTZfW
         Mnw5zv6NKY7AX+Nuk98YW33xwHiGEPEfuqlFyN7DA90Xsbbhuv+abW26DwBpazKm5StL
         V3m5a2mY9i5brrYnngaHAlSySFE2sD+tpC/1ERoNoVWsJhmRtIGYzLUmWW35jxMK7ZUN
         VZD6scFXdzbTbf5byr9/u4mqw2EmASPvn+l3gnp7yAiOBdNYFb12m2SjbGv7Dc5dMN7x
         1HkjTgRgDDgD+IYVNSjRCoUYnTBUX+MjMoCXAuyHFjUSQxCVEddwgrPVm2AuouOdsk5M
         Mafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ee/TEUjaymjFJ0bci2nCadzw0QTA9Rx1EdY5ofB0oc=;
        b=g9R4MJAj2qbj56gt5Ezm5Ncb4Yp2vd97pY2glKunFJNk5jMeVElgMryqTavJcu0lDz
         8/VwLM3Ibu7DfrXIym1AXkigAQKD+tUg/iWm3ukT3YtL7pgrCAht7w0wiGq+WbJjuHlM
         rmqKXv3FTqnx2gMuN7MMNtsHnpfHo/j4jXSZ+nnUAEEIGovcpHwRjsVfLxiXa9kfEbo5
         OUmMqZY374s65coQqsNnixKodaMbpg4YThTRjQiiQkbUU2hk5TRrBfPTCc/xQItJXvtm
         bRSI73onPa5xOwuj+0Y/dwOUaosnJAB09Gf2B2zLEi6LqPEf5fdlh3+aGdfAQtRZZ1wl
         UKpA==
X-Gm-Message-State: ANoB5pn4f9Jmpg9J5/P9cy6nZrX5vSlofw7UXh7BoHP9vRXs/01YotUS
        tF+4o+QEuMsohRGpSEh098w=
X-Google-Smtp-Source: AA0mqf4+M7rP5YT/tMSC4KY8+a+b3pvqjG9lTTjE+3CbMiFd1dAFcBSa4dmUL758NzqXknV2uTO7sQ==
X-Received: by 2002:a05:6512:3ba7:b0:4b5:7c02:39 with SMTP id g39-20020a0565123ba700b004b57c020039mr14730073lfv.47.1671283814719;
        Sat, 17 Dec 2022 05:30:14 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b004a100c21eaesm512420lfr.97.2022.12.17.05.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 05:30:14 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 5/5] diff-merges: improve --diff-merges documentation
Date:   Sat, 17 Dec 2022 16:29:55 +0300
Message-Id: <20221217132955.108542-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217132955.108542-1-sorganov@gmail.com>
References: <kl6lilimepli.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20221217132955.108542-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we've now added a flag to --diff-merges, and so there are now flags
and formats, document them as such.

Another improvement is that now there is no extremely long line
containg all the --diff-merges options.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 114 ++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 52 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 977f9135b0d6..a3fbdb85a8b8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -34,76 +34,86 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc|remerge|r|[no-]hide)::
+-m::
+	Show diffs for merge commits in the default format.
+	Shortcut for '--diff-merges=on,hide' unless
+	`log.diffMerges-m-imply-p` configuration is active, in which
+	case it's a shortcut for '--diff-merges=on -p'.
+
+-c::
+	Shortcut for '--diff-merges=combined -p'.
+
+--cc::
+	Shortcut for '--diff-merges=dense-combined -p'.
+
+--remerge-diff::
+	Shortcut for '--diff-merges=remerge -p'.
+
 --no-diff-merges::
-	Specify diff format to be used for merge commits. Default is
+	Synonym for '--diff-merges=off'.
+
+--diff-merges=(<format>|<flag>)[,(<format>|<flag>),...]::
+	Specify diff format and flags to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
-	`first-parent` is the default. Comma-separated list of
-	supported values is accepted as well.
+	`first-parent` is the default.
 +
---diff-merges=(off|none):::
---no-diff-merges:::
+The last format specified has precedence, whereas flags are
+cumulative. Comma-separated list is handy to provide flag(s) along
+with format, e.g.: `--diff-merges=first-parent,hide` is handy form of
+`--diff-merges=first-parent --diff-merges=hide`.
++
+The following formats are supported:
++
+--
+off, none::
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
 +
---diff-merges=on:::
---diff-merges=m:::
--m:::
-	These options make diff output for merge commits to be shown in
-	the default format. The default format could be changed using
+on, m::
+	Make diff output for merge commits to be shown in the default
+	format. The default format could be changed using
 	`log.diffMerges` configuration parameter, which default value
 	is `separate`.
 +
-	`-m` is a shortcut for '--diff-merges=on,hide'.
-	In addition it implies `-p` when `log.diffMerges-m-imply-p` is
-	active.
+first-parent, 1::
+	Show full diff with respect to first parent. This is the same
+	format as `--patch` produces for non-merge commits.
 +
---diff-merges=first-parent:::
---diff-merges=1:::
-	This option makes merge commits show the full diff with
-	respect to the first parent only.
+separate::
+	Show full diff with respect to each of parents.
+	Separate log entry and diff is generated for each parent.
 +
---diff-merges=separate:::
-	This makes merge commits show the full diff with respect to
-	each of the parents. Separate log entry and diff is generated
-	for each parent.
-+
---diff-merges=remerge:::
---diff-merges=r:::
---remerge-diff:::
-	With this option, two-parent merge commits are remerged to
-	create a temporary tree object -- potentially containing files
-	with conflict markers and such.  A diff is then shown between
-	that temporary tree and the actual merge commit.
+remerge, r::
+	Remerge two-parent merge commits to create a temporary tree
+	object--potentially containing files with conflict markers
+	and such.  A diff is then shown between that temporary tree
+	and the actual merge commit.
 +
 The output emitted when this option is used is subject to change, and
 so is its interaction with other options (unless explicitly
 documented).
 +
---diff-merges=combined:::
---diff-merges=c:::
--c:::
-	With this option, diff output for a merge commit shows the
-	differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a
-	parent and the result one at a time. Furthermore, it lists
-	only files which were modified from all parents. `-c` implies
-	`-p`.
+combined, c::
+	Show differences from each of the parents to the merge
+	result simultaneously instead of showing pairwise diff between
+	a parent and the result one at a time. Furthermore, it lists
+	only files which were modified from all parents.
 +
---diff-merges=dense-combined:::
---diff-merges=cc:::
---cc:::
-	With this option the output produced by
-	`--diff-merges=combined` is further compressed by omitting
-	uninteresting hunks whose contents in the parents have only
-	two variants and the merge result picks one of them without
-	modification.  `--cc` implies `-p`.
+dense-combined, cc::
+	Further compress output produced by `--diff-merges=combined`
+	by omitting uninteresting hunks whose contents in the parents
+	have only two variants and the merge result picks one of them
+	without modification.
+--
 +
---diff-merges=hide:::
---diff-merges=no-hide:::
-	Hide (do not hide) the diff for merge commits unless `-p` options is given
-	as well. The default `no-hide` could be changed using `log.diffMerges`
-	configuration parameter.
+The following flags are supported:
++
+--
+[no-]hide::
+	Hide diff for merge commits unless `-p` options is given as
+	well. The default `no-hide` could be changed using
+	`log.diffMerges` configuration parameter.
+--
 
 --combined-all-paths::
 	This flag causes combined diffs (used for merge commits) to
-- 
2.25.1

