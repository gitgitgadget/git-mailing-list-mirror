Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FEDC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 18:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF81F613CA
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 18:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhD0Sum (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 14:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhD0Sul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 14:50:41 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD6C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 11:49:57 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u16so43348761oiu.7
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 11:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1AzowvbwkkGxMNTskgMf1x871ey4X6yrwdI7BxsooP4=;
        b=WarqNrxPV7GwwTUXrPyqSYI6r5KkTIJ2FjppOjWC+7ilUj7s43aRwUICIO4GdHL3lR
         Gwcnw5W8Eq3z3FLhxVVmkEAcNTl6s94bXLvZlA8Qh3sJbqysHgDZN3FCrBW1cOE5VF7j
         0gsAgXhtqGpi6DZbZQPCOW8iKtu+hCA/2ivoTXE4n2J6ifN2r4O2Dz5CebdFf65HkY0c
         9zBBUWGCRfDBrUQ1CK4+pXpceWD0XaVt4jFqqTGLdX2LJHgMOrp6XheMiCbEaKFKWggq
         Tbze1KW8r2hJM92HkZ0FZCwRlpAP1auLP5QW+3gxrM64ogHZ7sE53ANZdLcfottoB9Eb
         C0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1AzowvbwkkGxMNTskgMf1x871ey4X6yrwdI7BxsooP4=;
        b=cAhutqc8oA41WV+sCJ+V3Uz7+Z3Hb/d5ahad9CT8MmMZyEIOh8bwNe2zqQN2GLPpo6
         iYByZHjf/gUJ1/myaur6ca4sxGMUKU0cMuHP+9HyoT7GOrdNri/gMHcTy671JtJMWNzD
         oL+SrNCjweCEcbSqKtoB3eZuWSoaSr8VMJuk6VuOWp2p0OuFO2rtHt7pwQ4gty7VyFCN
         47xJ/8/hB7Xm741zNaG6CKnGd4giU3H9aXBASXiMPALz+dAXNbcBVlcQ2d/jOoqE//5C
         lAxM1urI0r2f5QjbsXklLhnceexo50UCNniniQSUlCwsMnrAbVYCNp2192St6Tc+LnQX
         bcXQ==
X-Gm-Message-State: AOAM531LaNhirRHKUZECHEiFz+4QQo0PrkHmF5EWYZwwNIKzVT5aDTYK
        yxEikbKfuggUnnt9FSl9f6M=
X-Google-Smtp-Source: ABdhPJzxE37pn9CuNakjf9AOglo0uXZs/OYhvC5rIh9RgArzTd/P+5qIa5/ExlxDNdrEQMxzP4Rugg==
X-Received: by 2002:aca:2208:: with SMTP id b8mr11697036oic.49.1619549396674;
        Tue, 27 Apr 2021 11:49:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3839:9ece:547d:49e5? ([2600:1700:e72:80a0:3839:9ece:547d:49e5])
        by smtp.gmail.com with ESMTPSA id p11sm141193oti.53.2021.04.27.11.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 11:49:56 -0700 (PDT)
Subject: FS Monitor Windows Performance (was [PATCH 00/23] [RFC] Builtin
 FSMonitor Feature)
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <af7a671c-fa32-6d9a-7d75-65582fdbcf24@gmail.com>
Date:   Tue, 27 Apr 2021 14:49:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> This patch series adds a builtin FSMonitor daemon to Git.
> 
> This daemon uses platform-specific filesystem notifications to keep track of
> changes to a working directory. It also listens over the "Simple IPC"
> facility for client requests and responds with a list of files/directories
> that have been recently modified.
...
> This RFC version includes support for Windows and MacOS file system events.
> A Linux version will be submitted in a later patch series.

I finished a full read-through of the series, and pointed out what I
could. I'm not an expert on filesystems or these platform-specific
APIs, so I could only do a surface-level check that those integrations
are correct. They certainly appear to be, and the real proof is in the
tests and its performance.

I mentioned that I am concerned about the need for delays in the test
suite, since the feature itself should be robust to scripts and tools
interacting with Git shortly after modifying the filesystem. I hope we
can isolate the need for such delays.

As for performance, I wanted to check the timings for how this improves
the case for large repositories. I believe it should be clear that this
makes things easier when there is a large set of filesystem events,
causing Git to need to walk more of the workdir in a command like 'git
status'. So, I wanted to focus on zero or one changes, and see how
that affects performance.

This message focuses only on the Windows case. I will provide my macOS
performance numbers in a separate message.

I've been using two cases, one that tests 'git status' when there are no
changes to the filesystem, and another where a file is modified and then
deleted (with 'git status' run between each case).

hyperfine \
	-n "none (clean)" "$GIT -c core.useBuiltinFSMonitor=false status" \
	-n "builtin (clean)" "$GIT -c core.useBuiltinFSMonitor=true status" \
	--warmup=5

hyperfine \
	-n "none (dirty)" "echo >>$FILE && $GIT -c core.useBuiltinFSMonitor=false status && rm $FILE && $GIT -c core.useBuiltinFSMonitor=false status" \
	-n "builtin (dirty)" "echo >>$FILE && $GIT -c core.useBuiltinFSMonitor=true status && rm $FILE && $GIT -c core.useBuiltinFSMonitor=true status" \
	--warmup=5

Note that we are running 'git status' twice in the dirty case, which
will make it appear like things are more than twice as slow as the
clean case.

I then got some disappointing results on my first run:

sparse-index disabled, untracked cache disabled
-----------------------------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):      1.870 s ±  0.029 s    [User: 6.1 ms, System: 13.9 ms]
  Range (min … max):    1.814 s …  1.903 s    10 runs

Benchmark #2: builtin (clean)
  Time (mean ± σ):      1.961 s ±  0.102 s    [User: 3.6 ms, System: 12.4 ms]
  Range (min … max):    1.832 s …  2.172 s    10 runs

Summary
  'none (clean)' ran
    1.05 ± 0.06 times faster than 'builtin (clean)'
Benchmark #1: none (dirty)
  Time (mean ± σ):      3.738 s ±  0.044 s    [User: 5.3 ms, System: 17.0 ms]
  Range (min … max):    3.663 s …  3.832 s    10 runs

Benchmark #2: builtin (dirty)
  Time (mean ± σ):      5.987 s ±  0.062 s    [User: 2.8 ms, System: 17.3 ms]
  Range (min … max):    5.895 s …  6.090 s    10 runs

Summary
  'none (dirty)' ran
    1.60 ± 0.03 times faster than 'builtin (dirty)'

This all depends on the index being very large. I'm testing using a repo
with 2 million files at HEAD, but only 4% actually checked out on disk.
This exaggerates the cost of the index rewrite. The FS Monitor feature
forces 'git status' to rewrite the index because it updates the token in
the extension. I wish I had a better understanding of why the index is
not updated in the default case.

Interestingly, the untracked cache extension makes a big difference here.
The performance of the overall behavior is much faster if the untracked
cache exists (when paired with the builtin FS Monitor; it doesn't make a
significant difference when FS Monitor is disabled).

sparse-index disabled, untracked cache enabled
----------------------------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):      1.803 s ±  0.037 s    [User: 1.3 ms, System: 19.5 ms]
  Range (min … max):    1.748 s …  1.878 s    10 runs

Benchmark #2: builtin (clean)
  Time (mean ± σ):      1.071 s ±  0.035 s    [User: 1.3 ms, System: 14.0 ms]
  Range (min … max):    1.019 s …  1.138 s    10 runs

Summary
  'builtin (clean)' ran
    1.68 ± 0.07 times faster than 'none (clean)'

Benchmark #1: none (dirty)
  Time (mean ± σ):      3.648 s ±  0.079 s    [User: 3.9 ms, System: 20.5 ms]
  Range (min … max):    3.533 s …  3.761 s    10 runs

Benchmark #2: builtin (dirty)
  Time (mean ± σ):      4.268 s ±  0.095 s    [User: 2.6 ms, System: 20.8 ms]
  Range (min … max):    4.115 s …  4.403 s    10 runs

Summary
  'none (dirty)' ran
    1.17 ± 0.04 times faster than 'builtin (dirty)'

However, when I enable the sparse-index and the code where 'git status'
works with it, then I get the results we hope for with the FS Monitor
feature:

sparse-index enabled, untracked cache enabled
---------------------------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):     568.3 ms ±  21.7 ms    [User: 5.0 ms, System: 10.4 ms]
  Range (min … max):   541.6 ms … 598.3 ms    10 runs

Benchmark #2: builtin (clean)
  Time (mean ± σ):     214.8 ms ±  24.9 ms    [User: 1.0 ms, System: 16.0 ms]
  Range (min … max):   175.9 ms … 249.4 ms    12 runs

Summary
  'builtin (clean)' ran
    2.65 ± 0.32 times faster than 'none (clean)'

Benchmark #1: none (dirty)
  Time (mean ± σ):     979.1 ms ±  30.2 ms    [User: 2.4 ms, System: 18.7 ms]
  Range (min … max):   951.8 ms … 1051.1 ms    10 runs

Benchmark #2: builtin (dirty)
  Time (mean ± σ):     529.2 ms ±  43.1 ms    [User: 8.0 ms, System: 12.4 ms]
  Range (min … max):   461.2 ms … 590.6 ms    10 runs

Summary
  'builtin (dirty)' ran
    1.85 ± 0.16 times faster than 'none (dirty)'

However, if I disable the untracked cache, we are back to where we
started:

sparse-index enabled, untracked cache disabled
----------------------------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):     542.3 ms ±  28.5 ms    [User: 4.0 ms, System: 17.2 ms]
  Range (min … max):   501.8 ms … 594.4 ms    10 runs

Benchmark #2: builtin (clean)
  Time (mean ± σ):      1.126 s ±  0.034 s    [User: 5.2 ms, System: 7.6 ms]
  Range (min … max):    1.074 s …  1.163 s    10 runs

Summary
  'none (clean)' ran
    2.08 ± 0.13 times faster than 'builtin (clean)'

Benchmark #1: none (dirty)
  Time (mean ± σ):      1.128 s ±  0.032 s    [User: 6.9 ms, System: 5.0 ms]
  Range (min … max):    1.078 s …  1.202 s    10 runs

Benchmark #2: builtin (dirty)
  Time (mean ± σ):      2.334 s ±  0.072 s    [User: 2.9 ms, System: 21.7 ms]
  Range (min … max):    2.220 s …  2.444 s    10 runs

Summary
  'none (dirty)' ran
    2.07 ± 0.09 times faster than 'builtin (dirty)'

When I use a much smaller repository (git.git) without sparse-checkout,
I see that this extra cost is not there, but the untracked cache still
helps FS Monitor more than the standard case:

untracked cache disabled
-------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):     118.0 ms ±   8.4 ms    [User: 2.3 ms, System: 4.8 ms]
  Range (min … max):   102.6 ms … 133.7 ms    22 runs

Benchmark #2: builtin (clean)
  Time (mean ± σ):      72.2 ms ±   9.5 ms    [User: 3.0 ms, System: 7.8 ms]
  Range (min … max):    53.5 ms …  96.0 ms    33 runs

Summary
  'builtin (clean)' ran
    1.63 ± 0.25 times faster than 'none (clean)'

Benchmark #1: none (dirty)
  Time (mean ± σ):     270.3 ms ±  17.6 ms    [User: 1.3 ms, System: 13.6 ms]
  Range (min … max):   248.7 ms … 306.8 ms    10 runs

Benchmark #2: builtin (dirty)
  Time (mean ± σ):     165.5 ms ±  10.4 ms    [User: 3.3 ms, System: 11.5 ms]
  Range (min … max):   146.0 ms … 183.7 ms    16 runs

Summary
  'builtin (dirty)' ran
    1.63 ± 0.15 times faster than 'none (dirty)'


untracked cache enabled
-------------------------

Benchmark #1: none (clean)
  Time (mean ± σ):     129.3 ms ±  10.9 ms    [User: 2.2 ms, System: 6.9 ms]
  Range (min … max):   108.2 ms … 146.0 ms    19 runs

Benchmark #2: builtin (clean)
  Time (mean ± σ):      51.6 ms ±  10.5 ms    [User: 5.3 ms, System: 10.4 ms]
  Range (min … max):    34.9 ms …  99.1 ms    48 runs

Summary
  'builtin (clean)' ran
    2.51 ± 0.55 times faster than 'none (clean)'

Benchmark #1: none (dirty)
  Time (mean ± σ):     214.5 ms ±   7.5 ms    [User: 7.7 ms, System: 3.4 ms]
  Range (min … max):   207.1 ms … 234.5 ms    12 runs

Benchmark #2: builtin (dirty)
  Time (mean ± σ):     131.8 ms ±  13.1 ms    [User: 2.9 ms, System: 9.8 ms]
  Range (min … max):   110.8 ms … 159.7 ms    22 runs

Summary
  'builtin (dirty)' ran
    1.63 ± 0.17 times faster than 'none (dirty)'

I think it would be valuable to discover why using the builtin FS Monitor
without the untracked cache causes such performance problems (on Windows).
That might be reason enough to enable the untracked cache feature when the
FS Monitor feature is enabled, as in the following diff:

--- >8 ---

diff --git a/repo-settings.c b/repo-settings.c
index 93aab92ff16..1f25609f019 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -58,9 +58,13 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.core_multi_pack_index = value;
 	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
 
-	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) && value)
+	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) && value) {
 		r->settings.use_builtin_fsmonitor = 1;
 
+		/* Use untracked cache if FS Monitor is enabled. */
+		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
+	}
+
 	if (!repo_config_get_bool(r, "feature.manyfiles", &value) && value) {
 		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
 		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);

--- >8 ---

Thanks,
-Stolee
