Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFE6C2D0DA
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52DE208C4
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+aAoVr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfL0VLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:11:49 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:38313 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfL0VLt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 16:11:49 -0500
Received: by mail-wr1-f41.google.com with SMTP id y17so27258159wrh.5
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 13:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=d9MXcAe1kDBQdoDGz8JvAeKlNJ0JXXCMKzfFP6hU9DM=;
        b=J+aAoVr2i7UjKgn/V2DgJs1yB9ppjKhKxv4WK54vsacclsChdxwInpMSciyxwaliBr
         IOq4DGG853ZenrDjh/Vuzet/8Up6IU4Ol2trrc19HBOsDpvGc2QH+e4skwCzUQ1fN0/R
         GsU5D5D1UrBrVs7BpzGfI/148IcyZq+06lynL/reC6HdD5VHUWWbTetxXqdGebhdnRsr
         wZSBorMFa080IAi6DbKGUC3JpWUrsOnI/pmNKTafkSkoIM1OR2ySwhA6b871KsBeodQ2
         QEuN6tvfjeqjBOPKipte9bsbDO78mQzqodMVPbdfw+pE3FdxfgO6MMm5Uc3ypQxA7/oS
         ewSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language;
        bh=d9MXcAe1kDBQdoDGz8JvAeKlNJ0JXXCMKzfFP6hU9DM=;
        b=lt32V21StsXg1GdsPCa4O44NZepfASb1dop1pTEQA/hchYVf09z6ljP6zAIarAfo18
         gLUmGFE2GHxZ+kyW6gajqWoxkFV7V34bwtZQBAv1dRhWjK+4uG/0IOmmcAbEz/ND3iWT
         Wdwk7qa/MYyXAbF0ARNLsyO1uX8vOkmntrmzyVu7FaNYHwi/p8Z6OtAv0Ia8ovACu1ns
         fn6KiEOw3A5OL8INBDnA3q6VJs2+UGi62/SUJFS+8nPzJUuGnSEZGWRrqcdiP45qaeR0
         SU6WqyYXDtrIzM/dcDB1l5RMjlCZRi2uFtHr9rd5+vkjdmg64qJWnvCILQRuP8ypLOMo
         HrTw==
X-Gm-Message-State: APjAAAUtyqgPWI6KFE42u8cNdBVM37xC9ByVdS7J10lRtfO68UlLSJEr
        6lWwp/jVZwU55KylKe606GQxAAj6
X-Google-Smtp-Source: APXvYqxIkDdMKo8XiNua1erq/x0n3xBudShlmuXYacLJWCSwF6p1N3W8DodDfit7et941hwz8YydIw==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr50697106wrm.151.1577481106140;
        Fri, 27 Dec 2019 13:11:46 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-10-13.w86-222.abo.wanadoo.fr. [86.222.153.13])
        by smtp.gmail.com with ESMTPSA id x18sm35810270wrr.75.2019.12.27.13.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 13:11:44 -0800 (PST)
Subject: Re: Comparing rebase --am with --interactive via p3400
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
References: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <a00e1689-ec7c-4039-a2e9-f72d452ae4ff@gmail.com>
Date:   Fri, 27 Dec 2019 22:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet>
Content-Type: multipart/mixed;
 boundary="------------68DED71EF04608CA38814E7C"
Content-Language: fr-FR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------68DED71EF04608CA38814E7C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Johannes & Elijah,

Le 01/02/2019 à 07:04, Johannes Schindelin a écrit :
> Hi Elijah,
> 
> as discussed at the Contributors' Summit, I ran p3400 as-is (i.e. with the
> --am backend) and then with --keep-empty to force the interactive backend
> to be used. Here are the best of 10, on my relatively powerful Windows 10
> laptop, with current `master`.
> 
> With regular rebase --am:
> 
> 3400.2: rebase on top of a lot of unrelated changes             5.32(0.06+0.15)
> 3400.4: rebase a lot of unrelated changes without split-index   33.08(0.04+0.18)
> 3400.6: rebase a lot of unrelated changes with split-index      30.29(0.03+0.18)
> 
> with --keep-empty to force the interactive backend:
> 
> 3400.2: rebase on top of a lot of unrelated changes             3.92(0.03+0.18)
> 3400.4: rebase a lot of unrelated changes without split-index   33.92(0.03+0.22)
> 3400.6: rebase a lot of unrelated changes with split-index      38.82(0.03+0.16)
> 
> I then changed it to -m to test the current scripted version, trying to
> let it run overnight, but my laptop eventually went to sleep and the tests
> were not even done. I'll let them continue and report back.
> 
> My conclusion after seeing these numbers is: the interactive rebase is
> really close to the performance of the --am backend. So to me, it makes a
> total lot of sense to switch --merge over to it, and to make --merge the
> default. We still should investigate why the split-index performance is so
> significantly worse, though.
> 
> Ciao,
> Dscho
> 

I investigated a bit on this.  From a quick glance at a callgrind trace,
I can see that ce_write_entry() is called 20 601[1] times with `git am',
but 739 802 times with the sequencer when the split-index is enabled.

For reference, here are the timings, measured on my Linux machine, on a
tmpfs, with git.git as the repo:

`rebase --am':
> 3400.2: rebase on top of a lot of unrelated changes             0.29(0.24+0.03)
> 3400.4: rebase a lot of unrelated changes without split-index   6.77(6.51+0.22)
> 3400.6: rebase a lot of unrelated changes with split-index      4.43(4.29+0.13)
`rebase --quiet':
> 3400.2: rebase on top of a lot of unrelated changes             0.24(0.21+0.02)
> 3400.4: rebase a lot of unrelated changes without split-index   5.60(5.32+0.27)
> 3400.6: rebase a lot of unrelated changes with split-index      5.67(5.40+0.26)

This comes from two things:

1. There is not enough shared entries in the index with the sequencer.

do_write_index() is called only by do_write_locked_index() with `--am',
but is also called by write_shared_index() with the sequencer once for
every other commit.  As the latter is only called by
write_locked_index(), which means that too_many_not_shared_entries()
returns true for the sequencer, but never for `--am'.

Removing the call to discard_index() in do_pick_commit() (as in the
first attached patch) solve this particular issue, but this would
require a more thorough analysis to see if it is actually safe to do.

After this, ce_write() is still called much more by the sequencer.

Here are the results of `rebase --quiet' without discarding the index:

> 3400.2: rebase on top of a lot of unrelated changes             0.23(0.19+0.04)
> 3400.4: rebase a lot of unrelated changes without split-index   5.14(4.95+0.18)
> 3400.6: rebase a lot of unrelated changes with split-index      5.02(4.87+0.15)
The performance of the rebase is better in the two cases.


2. The base index is dropped by unpack_trees_start() and unpack_trees().

Now, write_shared_index() is no longer called and write_locked_index()
is less expensive than before according to callgrind.  But
ce_write_entry() is still called 749 302 times (which is even more than
before.)

The only place where ce_write_entry() is called is in a loop in
do_write_index().  The number of iterations is dictated by the size of
the cache, and there is a trace2 probe dumping this value.

For `--am', the value goes like this: 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4,
4, 4, 5, 5, 5, 5, … up until 101.

For the sequencer, it goes like this: 1, 1, 3697, 3697, 3698, 3698,
3699, 3699, … up until 3796.

The size of the cache is set in prepare_to_write_split_index().  It
grows if a cache entry has no index (most of them should have one by
now), or if the split index has no base index (with `--am', the split
index always has a base.)  This comes from unpack_trees_start() -- it
creates a new index, and unpack_trees() does not carry the base index,
hence the size of the cache.

The second attached patch (which is broken for the non-interactive
rebase case) demonstrates what we could expect for the split-index case
if we fix this:

> 3400.2: rebase on top of a lot of unrelated changes             0.24(0.21+0.03)
> 3400.4: rebase a lot of unrelated changes without split-index   5.81(5.62+0.17)
> 3400.6: rebase a lot of unrelated changes with split-index      4.76(4.54+0.20)
So, for everything related to the index, I think that’s it.

[1] Numbers may vary, but they should remain in the same order of magnitude.

Cheers,
Alban


--------------68DED71EF04608CA38814E7C
Content-Type: text/x-patch;
 name="sequencer-rebase-si.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sequencer-rebase-si.patch"

diff --git a/sequencer.c b/sequencer.c
index 1bee26ebd5..2831abd0fa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1863,7 +1863,6 @@ static int do_pick_commit(struct repository *r,
 				       NULL, 0))
 			return error_dirty_index(r, opts);
 	}
-	discard_index(r->index);
 
 	if (!commit->parents)
 		parent = NULL;

--------------68DED71EF04608CA38814E7C
Content-Type: text/x-patch;
 name="merge-recursive-rebase-si.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="merge-recursive-rebase-si.patch"

diff --git a/merge-recursive.c b/merge-recursive.c
index 11869ad81c..47f67079f3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -421,7 +421,7 @@ static int unpack_trees_start(struct merge_options *opt,
 {
 	int rc;
 	struct tree_desc t[3];
-	struct index_state tmp_index = { NULL };
+	/* struct index_state tmp_index = { NULL }; */
 
 	memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts));
 	if (opt->priv->call_depth)
@@ -432,7 +432,7 @@ static int unpack_trees_start(struct merge_options *opt,
 	opt->priv->unpack_opts.head_idx = 2;
 	opt->priv->unpack_opts.fn = threeway_merge;
 	opt->priv->unpack_opts.src_index = opt->repo->index;
-	opt->priv->unpack_opts.dst_index = &tmp_index;
+	opt->priv->unpack_opts.dst_index = opt->repo->index;
 	opt->priv->unpack_opts.aggressive = !merge_detect_rename(opt);
 	setup_unpack_trees_porcelain(&opt->priv->unpack_opts, "merge");
 
@@ -449,8 +449,8 @@ static int unpack_trees_start(struct merge_options *opt,
 	 * saved copy.  (verify_uptodate() checks src_index, and the original
 	 * index is the one that had the necessary modification timestamps.)
 	 */
-	opt->priv->orig_index = *opt->repo->index;
-	*opt->repo->index = tmp_index;
+	/* opt->priv->orig_index = *opt->repo->index; */
+	/* *opt->repo->index = tmp_index; */
 	opt->priv->unpack_opts.src_index = &opt->priv->orig_index;
 
 	return rc;

--------------68DED71EF04608CA38814E7C--
