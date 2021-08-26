Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA70C4320A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D0A6108D
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbhHZMXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242480AbhHZMXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 08:23:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32062C0613C1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d26so4850564wrc.0
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHOBeQEvamX771/RIDkaT2tF3R1V3GZJ5EAP6iBeI4s=;
        b=NxGhNf4D+ba/B6fhrlPGh6iQAva7L1cGQVWgOQuqNhksbrdrAJirjPW8xQbS4AFV7H
         vLgr8YB5LQUfd83YVyImc9pkPmLINrPbA59qISubMKsux3WZkcgeYdwJ1A0HA2+HSaQQ
         eZKeimReFcE1voeOpCxFu7ehXfV4xqhU78U542N0i92IRyVQzUzh4Om++W4Di3dWOYm0
         8caPmcuE8NQqz+xEclPlrV0Zdml392r0mhT7kTesjOFGb3IZrzz9PRrGB5QPJl8K+yq4
         eCJhHliXWvGaogfvQPH0v5uxWzcYRb5+q+9+DnPAiY2VsJsqfbINfb3PKj7pVjnV97p5
         gzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHOBeQEvamX771/RIDkaT2tF3R1V3GZJ5EAP6iBeI4s=;
        b=T1hPJgQkmwgPWeZvNbcoKJo+FnbGC3LhwIrN5dVcf5DoGXN92UlKrz3uAmeDdDkqwV
         ZgvcA6skKW3LMEzn8eFq685P50SNJZj003rC68sNsJkN9A7mdlGa59QOe+5StYqDpuNZ
         jFMcF/MgbLwW4bcYuJ+LScDaHbfzZn1MFwzoJ0plv9PLiRMS6CibLIuHBSe/hA2nexYS
         ibwHMPutc0T5Kxmyw3F9veESUvayN7vWtLHN/H9tDnCtEEfZcCe3qsCNTZ66Alg9e0PG
         k+YsvyBlKYGkLQm8B5q/lnzgm33+RAa//1GaD1AWg/Ea14wRWBZqE+YzBpwp994GCcEn
         a3/w==
X-Gm-Message-State: AOAM532v8bsgG1dgOtgtNEIXpAXo2BrQOa/D02dmzFqQTrePqWOhe2lU
        uU2fXskiSph0ANjqoFbDo/HovYqPmt2fgg==
X-Google-Smtp-Source: ABdhPJwsKBVEH6ZSa8IVBmYoOKqsap7Bu6+oyfoFUwmdKm4Xx6YXR9CRxOgNcqHVv4FZQRQYcLBRIg==
X-Received: by 2002:a5d:64ce:: with SMTP id f14mr3632633wri.17.1629980547148;
        Thu, 26 Aug 2021 05:22:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z17sm2969885wrr.66.2021.08.26.05.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:22:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] tr2: plug memory leaks + logic errors + Win32 & Linux feature parity
Date:   Thu, 26 Aug 2021 14:22:18 +0200
Message-Id: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An early re-roll due to some very good & early review by Taylor Blau,
this also fixes the grammar/typo pointed out by Eric Sunshine. Thanks
both:

This should address all the comments Taylor brought up, and hopefully
a bit more. The only thing I left outstanding was the inclusion of the
"while we're at it" enum refactoring in 5/6. It's not necessary for
the end-state here, but I think since we're already reviewing most of
this file it makes sense to change it while we're at it to
future-proof the code vis-as-vis getting stricted checks from the
compiler.

Ævar Arnfjörð Bjarmason (6):
  tr2: remove NEEDSWORK comment for "non-procfs" implementations
  tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
  tr2: stop leaking "thread_name" memory
  tr2: fix memory leak & logic error in 2f732bf15e6
  tr2: do compiler enum check in trace2_collect_process_info()
  tr2: log N parent process names on Linux

 compat/linux/procinfo.c | 169 ++++++++++++++++++++++++++++++++++------
 trace2/tr2_tls.c        |   1 +
 2 files changed, 146 insertions(+), 24 deletions(-)

Range-diff against v1:
1:  8c649ce3b49 = 1:  8c649ce3b49 tr2: remove NEEDSWORK comment for "non-procfs" implementations
2:  0150e3402a7 = 2:  0150e3402a7 tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
3:  1fa1bbb6743 ! 3:  1d835d6767e tr2: stop leaking "thread_name" memory
    @@ Commit message
         Fix a memory leak introduced in ee4512ed481 (trace2: create new
         combined trace facility, 2019-02-22), we were doing a free() of other
         memory allocated in tr2tls_create_self(), but not the "thread_name"
    -    "strbuf strbuf".
    +    "struct strbuf".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
4:  73e7d4eb6ac ! 4:  1aa0dbc394e tr2: fix memory leak & logic error in 2f732bf15e6
    @@ Commit message
         It was also using the strvec_push() API the wrong way. That API always
         does an xstrdup(), so by detaching the strbuf here we'd leak
         memory. Let's instead pass in our pointer for strvec_push() to
    -    xstrdup(), and then free our own strbuf.
    +    xstrdup(), and then free our own strbuf. I do have some WIP changes to
    +    make strvec_push_nodup() non-static, which makes this and some other
    +    callsites nicer, but let's just follow the prevailing pattern of using
    +    strvec_push() for now.
     
    -    Furthermore we need to free that "procfs_path" strbuf whether or not
    +    We'll also need to free that "procfs_path" strbuf whether or not
         strbuf_read_file() succeeds, which was another source of memory leaks
         in 2f732bf15e6, i.e. we'd leak that memory as well if we weren't on a
         system where we could read the file from procfs.
     
    +    Let's move all the freeing of the memory to the end of the
    +    function. If we're still at STRBUF_INIT with "name" due to not haven
    +    taken the branch where the strbuf_read_file() succeeds freeing it is
    +    redundant, so we could move it into the body of the "if", but just
    +    handling freeing the same way for all branches of the function makes
    +    it more readable.
    +
         In combination with the preceding commit this makes all of
         t[0-9]*trace2*.sh pass under SANITIZE=leak on Linux.
     
    @@ compat/linux/procinfo.c: static void get_ancestry_names(struct strvec *names)
      		strbuf_trim_trailing_newline(&name);
     -		strvec_push(names, strbuf_detach(&name, NULL));
     +		strvec_push(names, name.buf);
    -+		strbuf_release(&name);
      	}
      
     +	strbuf_release(&procfs_path);
    ++	strbuf_release(&name);
    ++
      	return;
      }
      
5:  4e378da2cce = 5:  70fef093d8d tr2: do compiler enum check in trace2_collect_process_info()
6:  da003330800 ! 6:  f6aac902484 tr2: log N parent process names on Linux
    @@ Commit message
         on Linux only the name of the immediate parent process was logged.
     
         Extend the functionality added there to also log full parent chain on
    -    Linux. In 2f732bf15e6 it was claimed that "further ancestry info can
    -    be gathered with procfs, but it's unwieldy to do so.".
    -
    -    I don't know what the author meant by that, but I think it probably
    -    referred to needing to slurp this up from the FS, as opposed to having
    -    an API. The underlying semantics on Linux are easier to deal with than
    -    on Windows though, at least as far as finding the parent PIDs
    -    goes. See the get_processes() function used on Windows. As shown in
    -    353d3d77f4f (trace2: collect Windows-specific process information,
    -    2019-02-22) it needs to deal with cycles.
    -
    -    What is more complex on Linux is getting at the process name, a
    -    simpler approach is to use fscanf(), see [1] for an implementation of
    -    that, but as noted in the comment being added here it would fail in
    -    the face of some weird process names, so we need our own
    -    parse_proc_stat() to parse it out.
    +    Linux.
    +
    +    This requires us to lookup "/proc/<getppid()>/stat" instead of
    +    "/proc/<getppid()>/comm". The "comm" file just contains the name of the
    +    process, but the "stat" file has both that information, and the parent
    +    PID of that process, see procfs(5). We parse out the parent PID of our
    +    own parent, and recursively walk the chain of "/proc/*/stat" files all
    +    the way up the chain. A parent PID of 0 indicates the end of the
    +    chain.
    +
    +    It's possible given the semantics of Linux's PID files that we end up
    +    getting an entirely nonsensical chain of processes. It could happen if
    +    e.g. we have a chain of processes like:
    +
    +        1 (init) => 321 (bash) => 123 (git)
    +
    +    Let's assume that "bash" was started a while ago, and that as shown
    +    the OS has already cycled back to using a lower PID for us than our
    +    parent process. In the time it takes us to start up and get to
    +    trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP) our parent
    +    process might exit, and be replaced by an entirely different process!
    +
    +    We'd racily look up our own getppid(), but in the meantime our parent
    +    would exit, and Linux would have cycled all the way back to starting
    +    an entirely unrelated process as PID 321.
    +
    +    If that happens we'll just silently log incorrect data in our ancestry
    +    chain. Luckily we don't need to worry about this except in this
    +    specific cycling scenario, as Linux does not have PID
    +    randomization. It appears it once did through a third-party feature,
    +    but that it was removed around 2006[1]. For anyone worried about this
    +    edge case raising PID_MAX via "/proc/sys/kernel/pid_max" will mitigate
    +    it, but not eliminate it.
    +
    +    One thing we don't need to worry about is getting into an infinite
    +    loop when walking "/proc/*/stat". See 353d3d77f4f (trace2: collect
    +    Windows-specific process information, 2019-02-22) for the related
    +    Windows code that needs to deal with that, and [2] for an explanation
    +    of that edge case.
    +
    +    Aside from potential race conditions it's also a bit painful to
    +    correctly parse the process name out of "/proc/*/stat". A simpler
    +    approach is to use fscanf(), see [3] for an implementation of that,
    +    but as noted in the comment being added here it would fail in the face
    +    of some weird process names, so we need our own parse_proc_stat() to
    +    parse it out.
     
         With this patch the "ancestry" chain for a trace2 event might look
         like this:
    @@ Commit message
               "systemd"
             ]
     
    -    And in the case of naughty process names. This uses perl's ability to
    -    use prctl(PR_SET_NAME, ...). See Perl/perl5@7636ea95c5 (Set the legacy
    -    process name with prctl() on assignment to $0 on Linux, 2010-04-15)[2]:
    +    And in the case of naughty process names like the following. This uses
    +    perl's ability to use prctl(PR_SET_NAME, ...). See
    +    Perl/perl5@7636ea95c5 (Set the legacy process name with prctl() on
    +    assignment to $0 on Linux, 2010-04-15)[4]:
     
             $ perl -e '$0 = "(naughty\nname)"; system "GIT_TRACE2_EVENT=/dev/stdout ~/g/git/git version"' | grep ancestry | jq -r .ancestry
             [
    @@ Commit message
               "systemd"
             ]
     
    -    1. https://lore.kernel.org/git/87o8agp29o.fsf@evledraar.gmail.com/
    -    2. https://github.com/Perl/perl5/commit/7636ea95c57762930accf4358f7c0c2dec086b5e
    +    1. https://grsecurity.net/news#grsec2110
    +    2. https://lore.kernel.org/git/48a62d5e-28e2-7103-a5bb-5db7e197a4b9@jeffhostetler.com/
    +    3. https://lore.kernel.org/git/87o8agp29o.fsf@evledraar.gmail.com/
    +    4. https://github.com/Perl/perl5/commit/7636ea95c57762930accf4358f7c0c2dec086b5e
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ compat/linux/procinfo.c
      
     -static void get_ancestry_names(struct strvec *names)
     +/*
    -+ * We need more complex parsing instat_parent_pid() and
    ++ * We need more complex parsing in stat_parent_pid() and
     + * parse_proc_stat() below than a dumb fscanf(). That's because while
     + * the statcomm field is surrounded by parentheses, the process itself
     + * is free to insert any arbitrary byte sequence its its name. That
    -+ * can include newlines, spaces, closing parentheses etc. See
    -+ * do_task_stat() in fs/proc/array.c in linux.git, this is in contrast
    -+ * with the escaped version of the name found in /proc/%d/status.
    ++ * can include newlines, spaces, closing parentheses etc.
    ++ *
    ++ * See do_task_stat() in fs/proc/array.c in linux.git, this is in
    ++ * contrast with the escaped version of the name found in
    ++ * /proc/%d/status.
     + *
     + * So instead of using fscanf() we'll read N bytes from it, look for
     + * the first "(", and then the last ")", anything in-between is our
    @@ compat/linux/procinfo.c
     + * that's 7 digits for a PID. We have 2 PIDs in the first four fields
     + * we're interested in, so 2 * 7 = 14.
     + *
    -+ * We then have 4 spaces between those four values, which brings us up
    -+ * to 18. Add the two parentheses and it's 20. The "state" is then one
    -+ * character (now at 21).
    ++ * We then have 3 spaces between those four values, and we'd like to
    ++ * get to the space between the 4th and the 5th (the "pgrp" field) to
    ++ * make sure we read the entire "ppid" field. So that brings us up to
    ++ * 14 + 3 + 1 = 18. Add the two parentheses around the "comm" value
    ++ * and it's 20. The "state" value itself is then one character (now at
    ++ * 21).
     + *
     + * Finally the maximum length of the "comm" name itself is 15
     + * characters, e.g. a setting of "123456789abcdefg" will be truncated
    @@ compat/linux/procinfo.c
     +static int parse_proc_stat(struct strbuf *sb, struct strbuf *name,
     +			    int *statppid)
      {
    -+	const char *lhs = strchr(sb->buf, '(');
    -+	const char *rhs = strrchr(sb->buf, ')');
    ++	const char *comm_lhs = strchr(sb->buf, '(');
    ++	const char *comm_rhs = strrchr(sb->buf, ')');
     +	const char *ppid_lhs, *ppid_rhs;
     +	char *p;
     +	pid_t ppid;
     +
    -+	if (!lhs || !rhs)
    ++	if (!comm_lhs || !comm_rhs)
     +		goto bad_kernel;
     +
      	/*
    @@ compat/linux/procinfo.c
     +	 * We're at the ")", that's followed by " X ", where X is a
     +	 * single "state" character. So advance by 4 bytes.
      	 */
    -+	ppid_lhs = rhs + 4;
    ++	ppid_lhs = comm_rhs + 4;
     +
    ++	/*
    ++	 * Read until the space between the "ppid" and "pgrp" fields
    ++	 * to make sure we're anchored after the untruncated "ppid"
    ++	 * field..
    ++	 */
     +	ppid_rhs = strchr(ppid_lhs, ' ');
     +	if (!ppid_rhs)
     +		goto bad_kernel;
     +
     +	ppid = strtol(ppid_lhs, &p, 10);
     +	if (ppid_rhs == p) {
    -+		const char *comm = lhs + 1;
    -+		int commlen = rhs - lhs - 1;
    ++		const char *comm = comm_lhs + 1;
    ++		size_t commlen = comm_rhs - comm;
     +
    -+		strbuf_addf(name, "%.*s", commlen, comm);
    ++		strbuf_add(name, comm, commlen);
     +		*statppid = ppid;
     +
     +		return 0;
    @@ compat/linux/procinfo.c
      	struct strbuf procfs_path = STRBUF_INIT;
     -	struct strbuf name = STRBUF_INIT;
     +	struct strbuf sb = STRBUF_INIT;
    -+	size_t n;
    -+	FILE *fp = NULL;
    ++	FILE *fp;
     +	int ret = -1;
      
      	/* try to use procfs if it's present. */
    @@ compat/linux/procinfo.c
     -	if (strbuf_read_file(&name, procfs_path.buf, 0) > 0) {
     -		strbuf_trim_trailing_newline(&name);
     -		strvec_push(names, name.buf);
    --		strbuf_release(&name);
     -	}
     +	strbuf_addf(&procfs_path, "/proc/%d/stat", pid);
     +	fp = fopen(procfs_path.buf, "r");
     +	if (!fp)
     +		goto cleanup;
     +
    -+	n = strbuf_fread(&sb, STAT_PARENT_PID_READ_N, fp);
    -+	if (n != STAT_PARENT_PID_READ_N)
    ++	/*
    ++	 * We could be more strict here and assert that we read at
    ++	 * least STAT_PARENT_PID_READ_N. My reading of procfs(5) is
    ++	 * that on any modern kernel (at least since 2.6.0 released in
    ++	 * 2003) even if all the mandatory numeric fields were zero'd
    ++	 * out we'd get at least 100 bytes, but let's just check that
    ++	 * we got anything at all and trust the parse_proc_stat()
    ++	 * function to handle its "Bad Kernel?" error checking.
    ++	 */
    ++	if (!strbuf_fread(&sb, STAT_PARENT_PID_READ_N, fp))
     +		goto cleanup;
     +	if (parse_proc_stat(&sb, name, statppid) < 0)
     +		goto cleanup;
    @@ compat/linux/procinfo.c
     +	if (ppid)
     +		push_ancestry_name(names, ppid);
     +cleanup:
    -+	strbuf_release(&name);
    - 	return;
    - }
    + 	strbuf_release(&name);
      
    + 	return;
     @@ compat/linux/procinfo.c: void trace2_collect_process_info(enum trace2_process_info_reason reason)
      		 */
      		break;
-- 
2.33.0.733.ga72a4f1c2e1

