Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E74C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1A2611C8
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbhIQVPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhIQVPD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 17:15:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE36C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:13:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v22so30440373edd.11
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=janQGstGFSvOONtdjmWVo6Mw/r5lS8m4jcPI9bjSzoo=;
        b=ElRbJ6+ICjWb1Rgb1L4LYzy8h+Y3UfjyLbFUE0+g7WTYTAWBivMGmajgxFYg9Hk3zY
         KOATpkliGZjbHKi3HlSBEcPnTI2alhT4JbgEplktb9/Fj4lnZD6CqAZXwwnummGWe4jU
         S/s9mVvPn0Ytoi7yfvZ7GoYDUI/m44JTajCYu9FlCCVpQWxPfQQHn2io8IEBWN5PRnWk
         1ktz3KoOFmEG5xBLuWikPxUMgguTR6JKnELAM0VmscXZqj4CqN0NsvOC2wPzpUKzNShH
         SjfOlR8aCCxsaPWshvjkpf0IvDsqsdxz5bxVMkzDow2g7gava5DJkzZajTJ1R6Zgz2W7
         6xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=janQGstGFSvOONtdjmWVo6Mw/r5lS8m4jcPI9bjSzoo=;
        b=XbmlMJ0dQD9Iwo+QjkbAFU3Xw3+TeW1x0vArJrnX44orbU4fNk3jAbQYsZsPgwUGAu
         f5JI6qLBY+wlnTAq/WzaV8FX726Mxmr5NPHGQky4op02VibvA0HSmBq6Aly7HcFEXZ+x
         J8dHjOezHcZ6B2sh5gifNq7Wuvqt41eNQsQPgmwV0EYrVLQOwfApQ308g9M14B9f08h7
         aJh04N6owaDHgIU0lItWQJ76c8s8Q2pfzkVbWN2nqLRE5plTzmdm5LvRJKy9q1UbYpAB
         zVvz6MN7MpZRA0VykeyA8vOsDcH1i22LBDfGAm5GogY0Acc4OciNWdTqTo/hGv+jUWxQ
         D7OQ==
X-Gm-Message-State: AOAM530xnZwlzSKjPKrCYjqQ54KA2nwR7YsdJ6j4KrZeEFYXsd3yRqSo
        1Rw99hT2yNmqujnzbM/DIBw=
X-Google-Smtp-Source: ABdhPJzIehPg4mUUiMHA+iO2o78CrMkrKgOEkA6fd81f0KNr9+NSY6lo8DL9XUagU4iEiS8yYrJ7NQ==
X-Received: by 2002:a50:eb4a:: with SMTP id z10mr14728041edp.142.1631913219656;
        Fri, 17 Sep 2021 14:13:39 -0700 (PDT)
Received: from szeder.dev (94-21-37-152.pool.digikabel.hu. [94.21.37.152])
        by smtp.gmail.com with ESMTPSA id o22sm3213056edi.89.2021.09.17.14.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:13:39 -0700 (PDT)
Date:   Fri, 17 Sep 2021 23:13:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 3/5] commit-graph: use parse_options_concat()
Message-ID: <20210917211337.GC2118053@szeder.dev>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-4-avarab@gmail.com>
 <YCrCt8sEFJSPE+28@nand.local>
 <87czx1awwg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czx1awwg.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 09:39:11PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Feb 15 2021, Taylor Blau wrote:
> 
> > On Mon, Feb 15, 2021 at 07:41:16PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> Make use of the parse_options_concat() so we don't need to copy/paste
> >> common options like --object-dir. This is inspired by a similar change
> >> to "checkout" in 2087182272
> >> (checkout: split options[] array in three pieces, 2019-03-29).
> >>
> >> A minor behavior change here is that now we're going to list both
> >> --object-dir and --progress first, before we'd list --progress along
> >> with other options.

The final version of this patch that was picked up is at 

  https://public-inbox.org/git/patch-v4-3.7-32cc0d1c7bc-20210823T122854Z-avarab@gmail.com/

I reply to this old version because of the following pieces of the
discussion:

> > "Behavior change" referring only to the output of `git commit-graph -h`,
> > no?
> >
> > Looking at the code (and understanding this whole situation a little bit
> > better), I'd think that this wouldn't cause us to parse anything
> > differently before or after this change, right?
> 
> Indeed, I just mean the "-h" or "--invalid-opt" output changed in the
> order we show the options in.

[...]

> but I wanted to just focus on
> refactoring existing behavior & get rid of the copy/pasted options

No, there is more behavior change: since 84e4484f12 (commit-graph: use
parse_options_concat(), 2021-08-23) the 'git commit-graph' command
does accept the '--[no-]progress' options as well, but before that
only its subcommands did, and 'git commit-graph --progress ...'
errored out with "unknown option".

Worse, sometimes 'git commit-graph --progress ...' doesn't work as
it's supposed to.  The patch below descibes the problem and fixes it,
but on second thought I don't think that it is the right approach.

In general, even when all subcommands of a git command understand a
particular --option, that does not mean that it's a good idea to teach
that option to that git command.  E.g. what if we later add another
subcommand for which that --option doesn't make any sense?  And from
the quoted discussion above it seems that teaching 'git commit-graph'
the '--progress' option was not intentional at all.

I'm inclined to think that '--progress' should rather be removed from
the common 'git commit-graph' options; luckily it's not too late,
because it hasn't been released yet.


  ---  >8  ---

Subject: [PATCH] commit-graph: fix 'git commit-graph --[no-]progress ...'

Until recenly 'git commit-graph' didn't have a '--progress' option,
only its subcommands did, but this changed with 84e4484f12
(commit-graph: use parse_options_concat(), 2021-08-23), and now the
'git commit-graph' command accepts the '--[no-]progress' options as
well.  Alas, they don't always works as they are supposed to, because
the isatty(2) check is only performed in the subcommands, i.e. after
the "main" 'git commit-graph' command has parsed its options, and it
unconditionally overwrites whatever '--[no-]progress' option might
have been given:

  $ GIT_PROGRESS_DELAY=0 git commit-graph --no-progress write --reachable
  Collecting referenced commits: 1617, done.
  Loading known commits in commit graph: 100% (1617/1617), done.
  [...]
  $ GIT_PROGRESS_DELAY=0 git commit-graph --progress write 2>out
  $ wc -c out
  0 out

Move the isatty(2) check to cmd_commit_graph(), before it calls
parse_options(), so 'git commit-graph --[no-]progress' will be able to
override it as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/commit-graph.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 21fc6e934b..3a873ceaf6 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -101,7 +101,6 @@ static int graph_verify(int argc, const char **argv)
 
 	trace2_cmd_mode("verify");
 
-	opts.progress = isatty(2);
 	argc = parse_options(argc, argv, NULL,
 			     options,
 			     builtin_commit_graph_verify_usage, 0);
@@ -250,7 +249,6 @@ static int graph_write(int argc, const char **argv)
 	};
 	struct option *options = add_common_options(builtin_commit_graph_write_options);
 
-	opts.progress = isatty(2);
 	opts.enable_changed_paths = -1;
 	write_opts.size_multiple = 2;
 	write_opts.max_commits = 0;
@@ -331,6 +329,7 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 	struct option *builtin_commit_graph_options = common_opts;
 
 	git_config(git_default_config, NULL);
+	opts.progress = isatty(2);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_commit_graph_options,
 			     builtin_commit_graph_usage,
-- 
2.33.0.517.ga8dcee0d0a

  ---  8<  ---

