Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836AEC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5410C61249
	for <git@archiver.kernel.org>; Tue, 25 May 2021 15:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhEYPLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 11:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhEYPLF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 11:11:05 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B13BC061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 08:09:32 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id u33so16145339qvf.9
        for <git@vger.kernel.org>; Tue, 25 May 2021 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mSKi4NqwUTktO89Xp5V+XHmeax0YfI85kDI5miYqFiI=;
        b=1eaUrA0N+aZAQUueRE0NNkjwS595qgEc9NyccbOFAaoiGf1iEAFwZumkQVpd8ybRU3
         ev8fO0Tu4phY0K43k0Sil12Nb9bGfGGe8eyYRccZ/5tIxwTESiO082ja11SwU7zsAlQO
         51Gb5A8vEjyHIgWRYOfrYA/WE2FxBNpyJ074iBYlY6HGL3ETeeW8SS8PMJ34rZZDqINU
         dmVGTPL5iJr1c1Gvtec7aSxD4P2JN/Kz9OQKDmEfyHC33+nco4a0n3PHakNy1apdxho9
         X3vowpgB6s0a7JMHeb7zTzC1UazTdKc/M34N+/XYO4pkfxw6QiiPU+xVA0kZWWNrtX8F
         TcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mSKi4NqwUTktO89Xp5V+XHmeax0YfI85kDI5miYqFiI=;
        b=GI/X/YGfqX5zfvS7U166yUdovYHh4i4XWL/1f3BSJ8xMAAQ7hPx9AQvdMeerudaLgV
         MUPqsNh7cYZ4ly0dTXrgJmparRDp0ziWCtjPVc+RnAQ8lpaos2aj9l0F5JvUS/w/PLcH
         3DkD2E84VSLlqnxxvzgCtAcNb2TW61LKJ9PDTHO/5BN0jG8zfLcVKg/RYeiw21cu83bk
         8b8cliecRxXvBHQTAb6p8zWio+Gl6Uf/f1Jv0zccrb+x8kYzCcwLGY6vbfPRMtAhGdDq
         Q3v7wQvcFQZS59LM7XCLIbVaCGciLJ0yu8SbSRuI0VgCBeXt4k7ct+a7cEbIn2EY0tBA
         004Q==
X-Gm-Message-State: AOAM533uEc2tf2taPMdjEWLo9R45rNNz2dQQLMe4/FIDU1Qo2TqCuRp8
        cQ/kDbkiNsXWylAkex1SXNOW3bsD9KFkt/Bc
X-Google-Smtp-Source: ABdhPJw1lm6FEYmqlkx5+UJTiUhMU3tnz2AUBPIWQVOtQ1QQLSX2Vw9y3iGVfQ6cRFI/3N03ES1aXQ==
X-Received: by 2002:ad4:4b61:: with SMTP id m1mr35659362qvx.37.1621955371228;
        Tue, 25 May 2021 08:09:31 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1c2e:9388:c87:38ef])
        by smtp.gmail.com with ESMTPSA id o10sm13470069qki.72.2021.05.25.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 08:09:30 -0700 (PDT)
Date:   Tue, 25 May 2021 11:09:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Taylor Blau' <me@ttaylorr.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        =?utf-8?Q?'Jean-No=C3=ABl?= AVILA' <jn.avila@free.fr>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc1 - Defect in t0301.3, t1092.6, t5300
Message-ID: <YK0TKVZidW/G8XBr@nand.local>
References: <036b01d750ed$642b75c0$2c826140$@nexbridge.com>
 <YKwsSgtfhaGq5z8k@nand.local>
 <037d01d75168$5a5aaea0$0f100be0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <037d01d75168$5a5aaea0$0f100be0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 25, 2021 at 09:17:40AM -0400, Randall S. Becker wrote:
> On May 24, 2021 6:44 PM, Taylor Blau wrote:
> >To: Randall S. Becker <rsbecker@nexbridge.com>
> >Cc: 'Junio C Hamano' <gitster@pobox.com>; 'Jean-Noël AVILA' <jn.avila@free.fr>; git@vger.kernel.org
> >Subject: Re: [ANNOUNCE] Git v2.32.0-rc1 - Defect in t0301.3, t1092.6, t5300
> >
> >On Mon, May 24, 2021 at 06:37:29PM -0400, Randall S. Becker wrote:
> >> On running the test suite on NonStop, t1092 fails in subtest 6 - but
> >> not when run with --verbose and -x, so I can't supply a log. This may
> >> be timing related. I wanted to report this in case anyone had any
> >> insight on whether there are any possible transient vulnerabilities.
> >
> >The failure in t1092 sounds should be addressed by
> >
> >  https://lore.kernel.org/git/pull.960.git.1621886108515.gitgitgadget@gmail.com/
> >
> >> t0301.3 often has transient failures - which has been experienced for
> >> a while. Most importantly, t5300 continues to fail completely on the
> >> x86 platform, but not ia64, which I previously reported.
> >
> >Not sure about these, though.
>
> Thanks will wait for the roll on that one. We had one loggable transient failure in t1096.15:
>
> expecting success of 1092.15 'merge with outside renames':
>         init_repos &&
>
>         for type in out-to-out out-to-in in-to-out
>         do
>                 test_all_match git reset --hard &&
>                 test_all_match git checkout -f -b merge-$type update-deep &&
>                 test_all_match git merge -m "$type" rename-$type &&
>                 test_all_match git rev-parse HEAD^{tree} || return 1
>         done
>
> + init_repos
> Updating files: 100% (14/14), done.
> HEAD is now at 5d0e8a6 initial commit
> Updating files: 100% (14/14), done.
> HEAD is now at 5d0e8a6 initial commit
> Updating files: 100% (14/14), done.
> HEAD is now at 5d0e8a6 initial commit
> Updating files: 100% (10/10), done.
> Updating files: 100% (7/7), done.
> Updating files: 100% (10/10), done.
> Updating files: 100% (7/7), done.
> + test_all_match git reset --hard
> + test_all_match git checkout -f -b merge-out-to-out update-deep
> + test_all_match git merge -m out-to-out rename-out-to-out
> --- full-checkout-err   2021-05-24 22:49:44 +0000
> +++ sparse-checkout-err 2021-05-24 22:49:50 +0000
> @@ -1 +0,0 @@
> Updating files: 100% (5/5), done.
> + return 1
> error: last command exited with $?=1

I'm having trouble reading this: is 'return 1' part of the output
written to sparse-checkout-err?

In either case, the "updating files" progress meter is coming from
unpack-trees.c:get_progress(). Looking a little further:

  - get_progress() is called by check_updates(), which is called by
    unpack_trees() and update_sparsity()

  - update_sparsity() is called by the sparse-checkout builtin, which
    sets 'o.verbose_update = isatty(2)', so that caller is good.

  - 'git merge' is the last command invoked by t1092.15, and it calls
    unpack_trees() from 'builtin/merge.c:read_tree_trivial()', and sets
    'opts.verbose_update = 1'.

Stolee's patch to set GIT_PROGRESS_DELAY=-1 will obviously take care of
this, but we should probably apply something like this on top (and maybe
look further at other callers of unpack_trees() to make sure they set
opts.verbose_update correctly; I stopped after I found the problem
here).

--- >8 ---

diff --git a/builtin/merge.c b/builtin/merge.c
index eddb8ae70d..5f926d3edc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -677,7 +677,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	opts.update = 1;
-	opts.verbose_update = 1;
+	opts.verbose_update = isatty(2);
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
 	trees[nr_trees] = parse_tree_indirect(common);
