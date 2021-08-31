Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEB2C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5429F60ED4
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbhHaUwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbhHaUwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:52:50 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC28C0613D9
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:51:54 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n24so750807ion.10
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XHkP4oKdVEyWsc6Sk+cCaLnOaDuXSmZ/L+SbW56QNaw=;
        b=MXGCB9/8DI0QVZEJD/agiUPFX6Np9kGcaND+kI+xN3pfvV4Zsck6ygnk4HgajJsP95
         wYxM+jun/ZgvI+2evDHuy4D0ca4UMrDf390peYlOIn5/8VZHNMEml/nR3ROTIjHFe+rk
         pqqwDizO5EPRX63H9TpP1l+hsB4WheR6P38Fyk2n4Q3cu4gBVHH1rf8+O6UYtQszMQRa
         3V8xNKPmEgdhbEGLlMeCgy0AXdVQhzT2VyZLogHrv2UPWajiSakxas5w2vjgJassSRG6
         kVMxgTZvbv/5erAt1TDIwTILE0r67mqlPYjwYcwRYFoRxHvtvUshm/JWFBoiHt7w9pe3
         z+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XHkP4oKdVEyWsc6Sk+cCaLnOaDuXSmZ/L+SbW56QNaw=;
        b=m8fMBVEmBOefDCRMY5qKzxRSM03vxhCcphCAwoaWErF5omjbPIFuqO5EWq15r7+2Qe
         Rc9zd0vpe0/YCwbFgiXAmzoQICX2NvFzTAsLNxDMrVppsI/1jbbxc1S12qxiEeQHK+pf
         dn4+2TRblEwnI42kYlXdsUZsVOEENRwneUZJ7KMIckKbmCWR/0hPFpHkjZS4dGf8nmGX
         r87kYG8Z8IepUvkdAvNUSpHu8F7EIEwYdWLEd6McVbjLs9sEGB4VSe9LHAufbvLrJknA
         ea7fXGJNbvQ9bCH1/ST+3sj1DN6Ylf8F0pqj3yRxZ+tc0iuXxxLMv0Fafva2sfnQSTcP
         K+uA==
X-Gm-Message-State: AOAM530BG4KDmMmRVTvEIJB2B7y9rysT54ZN5bg6gl10knAG6+Jxuxqq
        X22LnVPz7n5EKZpo862Rto2HZ04eyfYuh7Cq
X-Google-Smtp-Source: ABdhPJzY4ygIc0NqyoEWZUFoYIeV7ch39oCgz0qgT+JZqgrXkYhq6gecmktR2SQmCLhqvOxeMh316A==
X-Received: by 2002:a02:9082:: with SMTP id x2mr4608609jaf.44.1630443113975;
        Tue, 31 Aug 2021 13:51:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o2sm10964277ilg.47.2021.08.31.13.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:51:53 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:51:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 05/27] midx: disallow running outside of a repository
Message-ID: <5f24be8985fe0f20b3ea3001dca6c72b6fac17e1.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index command supports working with arbitrary object
directories via the `--object-dir` flag. Though this has historically
worked in arbitrary repositories (including when the command itself was
run outside of a Git repository), this has been somewhat of an accident.

For example, running:

    git multi-pack-index write --object-dir=/path/to/repo/objects

outside of a Git repository causes a BUG(). This is because the
top-level `cmd_multi_pack_index()` function stops parsing when it sees
"write", and then fills in the default object directory (the result of
calling `get_object_directory()`) before handing off to
`cmd_multi_pack_index_write()`. But there is no repository to
initialize, and so calling `get_object_directory()` results in a BUG()
(indicating that the current repository is not initialized).

Another case where this doesn't quite work as expected is when operating
in a SHA-256 repository. To see the failure, try this in your shell:

    git init --object-format=sha256 repo
    git -C repo commit --allow-empty base
    git -C repo repack -d

    git multi-pack-index --object-dir=$(pwd)/repo/.git/objects write

and observe that we cannot open the `.idx` file in "repo", because the
outermost process assumes that any repository that it works in also uses
the default value of `the_hash_algo` (at the time of writing, SHA-1).

There may be compelling reasons for trying to work around these bugs,
but working in arbitrary `--object-dir`'s is non-standard enough (and
likewise, these bugs prevalent enough) that I don't think any workflows
would be broken by abandoning this behavior.

Accordingly, restrict the `multi-pack-index` builtin to only work when
inside of a Git repository (i.e., its main utility becomes selecting
which alternate to operate in), which avoids both of the bugs above.

(Note that you can still trigger a bug when writing a MIDX in an
alternate which does not use the same object format as the repository
which it is an alternate of, but that is an unrelated bug to this one).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 git.c                       | 2 +-
 t/t5319-multi-pack-index.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 18bed9a996..60c2784be4 100644
--- a/git.c
+++ b/git.c
@@ -561,7 +561,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
 	{ "mktree", cmd_mktree, RUN_SETUP },
-	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP_GENTLY },
+	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 3d4d9f10c3..9034e94c0a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -842,4 +842,9 @@ test_expect_success 'usage shown without sub-command' '
 	! test_i18ngrep "unrecognized subcommand" err
 '
 
+test_expect_success 'complains when run outside of a repository' '
+	nongit test_must_fail git multi-pack-index write 2>err &&
+	grep "not a git repository" err
+'
+
 test_done
-- 
2.33.0.96.g73915697e6

