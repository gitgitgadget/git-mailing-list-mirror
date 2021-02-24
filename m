Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D712C433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3813164F0A
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 17:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhBXRNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 12:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbhBXRNI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 12:13:08 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB1EC061788
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 09:12:27 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d11so1233180qtx.9
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 09:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=URvJSM0j3r80+rZFl71HkSSAYCbRQObdSH6gsh/I3bg=;
        b=qqdgEFlzJq95AwzDlMXA5UKxyAWZ6CKmWdogsGJvhMtGnDioQFUl+81g7OeChjVcXT
         ABRqRRg8izWVxwJ3oS76/NH8IfKDWQAsFpZ9s7p0xDvUjey7pvaH/SHLHBXSNGW4PFOe
         pjkefXFk7/HQoJ+ukqkdS01B2p3NnXWweRVBZgCm/evzt2JlZOg3UDF7sxmOANW5IHTC
         qIWVB0scd5X5lT9XhNEMrIJfuaYkVxPYQjN02eKpzU+Jvv+YcPrjxINoSQk9a+pCcK2o
         6D1LTtsGBRn7C9G07BUkLhOCOfqPJp9c9VPziEIMbJ7af3MbARt+pjmFjx7KVszOkc/g
         AFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=URvJSM0j3r80+rZFl71HkSSAYCbRQObdSH6gsh/I3bg=;
        b=rSuZ8A4rhcqxFaGcbiQxgqSZww8o/L6QnH7L9D5ziGvw2dv/adzMm/4zdleO3gbth8
         VH2dXosSXZTVmpsIZNzTkTFr+cSv+geOUS27kmaKyWpUIJRv4t1oIdt/wrD7wGh2YSb9
         QMLyng01tvgVQ1fF0B1F4eBvM2b6A0sp1bn5RuM7OtTp8U7WsutsgMFxTIRKp7Dcu60z
         Kkae+VzaN0wxpkXp+soigzwcJ/aVBOZWa5546mjl3t+3+uQHTbueX1Ir5aClEqsFZny0
         GBG2KiJ5ySDdPI9ZnpZz3V5JVuKW0LfnwDx+j9yEOLlUxa9VKJyqEMzHyhzrVjQSa4Xc
         weZQ==
X-Gm-Message-State: AOAM532GcLB2vhk49OmZQi5ZzQOmDx+RjchOKzGHyAkWsZ35O/OzjKbf
        AQa8O+8td8K32p3iF9ethZ9Q7w==
X-Google-Smtp-Source: ABdhPJxaCeG9HRPuyRcsgiM/Mi3aWDofoXCuofDPxHXwKPbrfJoV06j2kjO5mDBRys5srL2CO7ZXZg==
X-Received: by 2002:ac8:45d2:: with SMTP id e18mr7498075qto.140.1614186746494;
        Wed, 24 Feb 2021 09:12:26 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id l65sm1931345qkf.113.2021.02.24.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 09:12:26 -0800 (PST)
Date:   Wed, 24 Feb 2021 12:12:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 03/17] commit-graph: use chunk-format write API
Message-ID: <YDaI9pVzW5wkK1aT@nand.local>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
 <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
 <ddebf2389880e14a332e354f7b1dbc86a3964985.1613657259.git.gitgitgadget@gmail.com>
 <20210224165242.GB3590451@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210224165242.GB3590451@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 05:52:42PM +0100, SZEDER Gábor wrote:
> On Thu, Feb 18, 2021 at 02:07:25PM +0000, Derrick Stolee via GitGitGadget wrote:
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > The commit-graph write logic is ready to make use of the chunk-format
> > write API. Each chunk write method is already in the correct prototype.
> > We only need to use the 'struct chunkfile' pointer and the correct API
> > calls.
>
> This patch series messes up the "Writing out commit graph" progress
> display, and starting at this commit I get:

I can confirm. It looks like we never dropped the 'num_chunks' variable,
which should have happened in this patch.

Here's something to apply on top which fixes the issue. Thanks for
reporting.

--- >8 ---

Subject: [PATCH] commit-graph.c: display correct number of chunks when writing

When writing a commit-graph, a progress meter is shown which indicates
the number of pieces of data to write (one per commit in each chunk).

In 47410aa837 (commit-graph: use chunk-format write API, 2021-02-18),
the number of chunks became tracked by the new chunk-format API. But a
stray local variable was left behind from when write_commit_graph_file()
used to keep track of the same.

Since this was no longer updated after 47410aa837, the progress meter
appeared broken:

    $ git commit-graph write --reachable
    Expanding reachable commits in commit graph: 837569, done.
    Writing out commit graph in 3 passes: 166% (4187845/2512707), done.

Drop the local variable and rely instead on the chunk-format API to tell
us the correct number of chunks.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 78b993c367..6aa0c488f5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1791,7 +1791,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct lock_file lk = LOCK_INIT;
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
-	int num_chunks = 3;
 	struct object_id file_hash;
 	struct chunkfile *cf;

@@ -1887,11 +1886,11 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		strbuf_addf(&progress_title,
 			    Q_("Writing out commit graph in %d pass",
 			       "Writing out commit graph in %d passes",
-			       num_chunks),
-			    num_chunks);
+			       get_num_chunks(cf)),
+			    get_num_chunks(cf));
 		ctx->progress = start_delayed_progress(
 			progress_title.buf,
-			num_chunks * ctx->commits.nr);
+			get_num_chunks(cf) * ctx->commits.nr);
 	}

 	write_chunkfile(cf, ctx);
--
2.30.0.667.g81c0cbc6fd

