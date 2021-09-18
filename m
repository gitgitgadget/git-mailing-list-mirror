Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8978BC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 04:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A1FD61244
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 04:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhIREcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 00:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhIREcP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 00:32:15 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EAEC061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 21:30:52 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id m11so14764942ioo.6
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 21:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RZv6WZ5vzuXwlLFIDZ+o3h69vnLd304T7FdKxP2p5b4=;
        b=49rJl2ya1A9x/Btj90p9hzngELqv9N4a4UlTQs6K5xs7n2MBWtJqzr3kreHxcuAS3+
         3+8vblZouIZSHyf7A+XD/TPpt4+tWfgpz9KJF61GhalP73gSdzAJKsIrUv47hL931CWG
         6/ByWb4MKlylDeCrYZV0BsVvFWrS34/1NL5mN7XKIA/MoWWMc5MN4LkvsTZ7ADlhts9R
         zv/CHPN8BRBXp5TQDGWvPBhqdwa/MdSQw8szUBmymFryVkg68ruH08UP/rPqly2sIa+z
         BmP3ILx9/E5FFGAV6FMrZaoSDD0hw5ISzerRQKD7bcNaABLtbrQF7cCOH+1r2jvdlq2N
         hk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RZv6WZ5vzuXwlLFIDZ+o3h69vnLd304T7FdKxP2p5b4=;
        b=GL/PnhfoV5B1MZevOor2q0/UrBlYD+6LY/Ti0G12tCBPFTulRmq4ePFrhyfl9aPB5t
         8bQcp8I3rr7Ye3u+YLJeoZALCi1Z0VShctHa7/ZkWWmhUK0b7d1hC2sgYeQbTAWGNkk+
         +QIRag8fGEcPK2np4SyjqXS+7ePaCi/kMSL+plGCzETtJ1G1PiaqqqxwuP0uaDg1b0IV
         vChuKiWRUmEd9Y6JvpZWxoaSvpvjJr+OxB+jSnzZ8gqe331lEKVazViozWOJ9IuMfaPQ
         JD+NH+UVmrwKK3hS0q0b79cEGmJZhQ1SozzMHElFFqHr4JuW2mTc9YeGksNqxeAeT14+
         IhXg==
X-Gm-Message-State: AOAM532cDGkSEh5OO18Nag+R2HRdYih2XILLQsTv6YFXZpAbZS685rPS
        sx6ecTXXUgCY/98OaUX+5NB75Q==
X-Google-Smtp-Source: ABdhPJzCi4eG0Qjjkc+S8B+ok0PHTFtPj0DK9pfSb9W3lkLATpZOa9tmbVJIMNj9leMBVDJ3gSazFg==
X-Received: by 2002:a5d:9693:: with SMTP id m19mr11274356ion.181.1631939451697;
        Fri, 17 Sep 2021 21:30:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g23sm4621101ioc.8.2021.09.17.21.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 21:30:50 -0700 (PDT)
Date:   Sat, 18 Sep 2021 00:30:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com
Subject: Re: [PATCH 3/5] commit-graph: use parse_options_concat()
Message-ID: <YUVreesWdRmBYl1C@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-4-avarab@gmail.com>
 <YCrCt8sEFJSPE+28@nand.local>
 <87czx1awwg.fsf@evledraar.gmail.com>
 <20210917211337.GC2118053@szeder.dev>
 <YUUQzswYL5x74Tps@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUUQzswYL5x74Tps@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 06:03:58PM -0400, Jeff King wrote:
> > I'm inclined to think that '--progress' should rather be removed from
> > the common 'git commit-graph' options; luckily it's not too late,
> > because it hasn't been released yet.
>
> I wasn't following this series closely, but having seen your fix below,
> I'm inclined to agree with you. Just because we _can_ allow options
> before or after sub-commands does not necessarily make it a good idea.
>
I agree. Suppose we had a "git commit-graph remove" sub-command that
removed the commit-graph file (ignoring that there are probably better
hypothetical examples than this ;)). It's not obvious what --progress
means in the context of that mode.

Here's a patch that does what you and Gábor are suggesting as an
alternative. Unfortunately, we can't do the same for the
multi-pack-index command, since the analogous change there is 60ca94769c
(builtin/multi-pack-index.c: split sub-commands, 2021-03-30), which was
released in 2.32.

Anyway, as promised:

--- 8< ---

Subject: [PATCH] builtin/commit-graph.c: don't accept common --[no-]progress

In 84e4484f12 (commit-graph: use parse_options_concat(), 2021-08-23) we
unified common options of commit-graph's subcommands into a single
"common_opts" array.

But 84e4484f12 introduced a behavior change which is to accept the
"--[no-]progress" option before any sub-commands, e.g.,

    git commit-graph --progress write ...

Prior to that commit, the above would error out with "unknown option".

There are two issues with this behavior change. First is that the
top-level --[no-]progress is not always respected. This is because
isatty(2) is performed in the sub-commands, which unconditionally
overwrites any --[no-]progress that was given at the top-level.

But the second issue is that the existing sub-commands of commit-graph
only happen to both have a sensible interpretation of what `--progress`
or `--no-progress` means. If we ever added a sub-command which didn't
have a notion of progress, we would be forced to ignore the top-level
`--[no-]progress` altogether.

Since we haven't released a version of Git that supports --[no-]progress
as a top-level option for `git commit-graph`, let's remove it.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 21fc6e934b..067587a0fd 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -50,8 +50,6 @@ static struct option common_opts[] = {
 	OPT_STRING(0, "object-dir", &opts.obj_dir,
 		   N_("dir"),
 		   N_("the object directory to store the graph")),
-	OPT_BOOL(0, "progress", &opts.progress,
-		 N_("force progress reporting")),
 	OPT_END()
 };

@@ -95,6 +93,8 @@ static int graph_verify(int argc, const char **argv)
 	static struct option builtin_commit_graph_verify_options[] = {
 		OPT_BOOL(0, "shallow", &opts.shallow,
 			 N_("if the commit-graph is split, only verify the tip file")),
+		OPT_BOOL(0, "progress", &opts.progress,
+			 N_("force progress reporting")),
 		OPT_END(),
 	};
 	struct option *options = add_common_options(builtin_commit_graph_verify_options);
@@ -246,6 +246,8 @@ static int graph_write(int argc, const char **argv)
 		OPT_CALLBACK_F(0, "max-new-filters", &write_opts.max_new_filters,
 			NULL, N_("maximum number of changed-path Bloom filters to compute"),
 			0, write_option_max_new_filters),
+		OPT_BOOL(0, "progress", &opts.progress,
+			 N_("force progress reporting")),
 		OPT_END(),
 	};
 	struct option *options = add_common_options(builtin_commit_graph_write_options);
--
2.33.0.96.g73915697e6

