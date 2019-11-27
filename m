Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72866C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 14:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3297F206F0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 14:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czFiQvRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfK0Odt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:33:49 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36992 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK0Ods (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 09:33:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so21423242qtk.4
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IO5neO67BqLJw2Cb9D6iCfks7aV3rOPRpfscEtQYlr8=;
        b=czFiQvRDRVAsWz3CULqCNRPZgA32aPDmuqOnrGhCbSXJ2H/tCSD7saNtk5u8v/Aakr
         tc6IrZCa/O4hvsnUSJbYHHEGVY2FNinAXzr7t5BGcEKgsPT8XIYS/w7LnRZMjpHmqUsR
         crKY58JAu5+QVx6xiTAlE/oA21KRwRvVAbRKt7KDIqOCxOMwP7tgCnYdq6s1gs/d6EBK
         IshJkF1CkGomwkviA3uo8wkH+02SWD/4X2591aZIvb3weNIFD3SqMUCHoLo7hnL54XIC
         BTM1pW2JIu5lIi31SN0oOvWvd9hLrYAn7/OBFp2X9g20JVm+/U4zf75t6RZBYmCiJ/fu
         r2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IO5neO67BqLJw2Cb9D6iCfks7aV3rOPRpfscEtQYlr8=;
        b=imL/Ql/0TagWVXkbIMZAFOlRxZtoI6Co/u3ibQ/Ktoky6uVJS3jHbcPKZBfQ7b2iIE
         YTTmNRfsbw9Qx3MNX1HfpLWxYdL88cNdsoVluEDSQdLPFdM/Jkq9Ct4/KezDdBYzBSln
         1kQ8esKdb/2UYv7cYPw3inHFcZPRPXDItOnsZ5qyrAELmENjqx4ow+bErXe5HvK4zyyU
         S6B3hvCZAS9tGbbdjl6ffI8QpL/3I+xpBV9hWUX89LXhJsSkBeLqsXKHTtpMvRLN8oe7
         sA8yRFXhrAD15QlgHd0dMPN6/ZiPVNTP63dGda59OOPEZ9bvd4qfHJXQiDFc6sqKSf+l
         fpcw==
X-Gm-Message-State: APjAAAUnkDmwkr0Kk1oRU85ceDwg1ZLeaxDTHl1Imi0qV5bqWRUAcNvq
        J2QGhOcApfhRQvGo957UqKz0ont/
X-Google-Smtp-Source: APXvYqwjZXbhorRr9YAo+DNOe9ggVK5vpC+mSTGCh7qcoAHNTtB6Rjtj6ROINmGSr7T/UxVbEQoAbA==
X-Received: by 2002:ac8:7311:: with SMTP id x17mr31455376qto.10.1574865227015;
        Wed, 27 Nov 2019 06:33:47 -0800 (PST)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id s21sm7933341qtc.12.2019.11.27.06.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:33:45 -0800 (PST)
Subject: Re: Git Test Coverage Report (Nov 25)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>
References: <1cb7ddbf-020e-d63a-85b6-5a9267c0a5a3@gmail.com>
 <nycvar.QRO.7.76.6.1911262116100.31080@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <59ae5223-6dd8-00cd-4c39-b307f8364457@gmail.com>
Date:   Wed, 27 Nov 2019 09:33:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1911262116100.31080@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26/2019 3:46 PM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> thank you for keeping doing these reports.

Thanks for reading it!

> On Mon, 25 Nov 2019, Derrick Stolee wrote:
> 
>> Here is today's test coverage report.
>>
>> Sorry for the delay, but I had some issues working out the new
>> "ignored lines" logic. Now there are a few phrases that are
>> ignored automatically, including "BUG(" or "die(".
>>
>> [...]
>> Johannes Schindelin	eea4a7f4 mingw: demonstrate that all file handles are inherited by child processes
>> t/helper/test-run-command.c
>> eea4a7f4 203) static int inherit_handle(const char *argv0)
>> eea4a7f4 205) struct child_process cp = CHILD_PROCESS_INIT;
>> eea4a7f4 210) xsnprintf(path, sizeof(path), "out-XXXXXX");
>> eea4a7f4 211) tmp = xmkstemp(path);
>> eea4a7f4 213) argv_array_pushl(&cp.args,
>> eea4a7f4 215) cp.in = -1;
>> eea4a7f4 216) cp.no_stdout = cp.no_stderr = 1;
>> eea4a7f4 217) if (start_command(&cp) < 0)
>> eea4a7f4 221) close(tmp);
>> eea4a7f4 222) if (unlink(path))
>> eea4a7f4 225) if (close(cp.in) < 0 || finish_command(&cp) < 0)
>> eea4a7f4 228) return 0;
>> eea4a7f4 231) static int inherit_handle_child(void)
>> eea4a7f4 233) struct strbuf buf = STRBUF_INIT;
>> eea4a7f4 235) if (strbuf_read(&buf, 0, 0) < 0)
>> eea4a7f4 237) printf("Received %s\n", buf.buf);
>> eea4a7f4 238) strbuf_release(&buf);
>> eea4a7f4 240) return 0;
>> eea4a7f4 251) exit(inherit_handle(argv[0]));
>> eea4a7f4 253) exit(inherit_handle_child());
> 
> I think this is actually covered, but only in the Windows build.

Sorry that I have not set up a Windows build, but the Linux test-coverage
build already takes a long time so adding Windows would be complicated.
(Not to mention that merging the uncovered lines across two platforms would
be a huge challenge.)

If anyone wants to consider such an effort, I'm willing to play along.

>> Johannes Schindelin	116a408b commit: give correct advice for empty commit during a rebase
>> builtin/commit.c
>> 116a408b 478) else if (whence == FROM_CHERRY_PICK) {
>> 116a408b 479) if (rebase_in_progress && !sequencer_in_use)
>> 116a408b 1186) else if (whence == FROM_CHERRY_PICK) {
>> 116a408b 1187) if (rebase_in_progress && !sequencer_in_use)
> 
> My understanding is that Phillip is working on a replacement for this
> patch, so I'll leave this as-is for now.
> 
>> Johannes Schindelin	0de7b036 built-in add -i: offer the `quit` command
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	d17e3a76 built-in add -i: prepare for multi-selection commands
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	dea080c8 built-in add -i: re-implement `revert` in C
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	daabf56b built-in add -i: re-implement `add-untracked` in C
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	4ba7c22a built-in add -i: implement the `update` command
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	9d86921e built-in add -i: implement the `patch` command
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	a5ced6db built-in add -i: allow filtering the modified files list
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	465a9699 built-in add -i: re-implement the `diff` command
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	68db1cbf built-in add -i: support `?` (prompt help)
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	76b74323 built-in add -i: show unique prefixes of the commands
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	6348bfba built-in add -i: implement the main loop
>> add-interactive.c
>> [...]
>>
>> Johannes Schindelin	f83dff60 Start to implement a built-in version of `git add --interactive`
>> add-interactive.c
>> f83dff60 571) int run_add_i(struct repository *r, const struct pathspec *ps)
>>
>> builtin/add.c
>> f83dff60 197) return !!run_add_i(the_repository, pathspec);
> 
> This ginormous amount of code without test coverage is exactly the type of
> problem I pointed out with the approach I had to take in the built-in add
> -i/-p series, and which I described in the commit message
> https://public-inbox.org/git/5d9962d4344fa182b37cd8d969da01bc603414be.1573648866.git.gitgitgadget@gmail.com/
> Most of it _will_ be covered by the tests, but _only_ at the very end,
> when all six patch series will be merged.

I figured as much. When we have all six ready to go, then I can run a
"single branch" test for the feature against the base to see what is
uncovered from the entire effort.

>> Johannes Schindelin		rebase-merges: move labels' whitespace mangling into `label_oid()`
>> sequencer.c
>> 867bc1d2 4539) }
> 
> Not sure why this closing parenthesis isn't covered :-D
>
>> Johannes Schindelin	4d17fd25 remote-curl: unbreak http.extraHeader with custom allocators
>> http.c
>> 4d17fd25 417) string_list_clear(&extra_http_headers, 0);
> 
> I think it is okay to have that uncovered. This line is in the unlikely
> code path where a user will try to unset the extra headers via `git -c
> http.extraHeaders [...]`, i.e. without setting a value for that setting.
> 
>> Johannes Schindelin	2e0afafe Add git-bundle: move objects and references by archive
>> builtin/bundle.c
>> 2e0afafe 115) return 1;
> 
> I have to admit that I am slightly curious how this commit from 2007 ended
> up in this list: 2e0afafebd8 (Add git-bundle: move objects and references
> by archive, 2007-02-22). That's quite the blast of the past.
> 
>> Johannes Schindelin	116d1fa6 vreportf(): avoid relying on stdio buffering
>> usage.c
>> 116d1fa6 16) fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
>> 116d1fa6 17) abort();
>> 116d1fa6 22) *p = '\0'; /* vsnprintf() failed, clip at prefix */
> 
> Those are defensive programming, so this is expected not to be covered.

I wonder why we are not using BUG() here (for the fprintf and abort).
 
>> Johannes Schindelin	d54dea77 fetch: let --jobs=<n> parallelize --multiple, too
>> builtin/fetch.c
>> d54dea77 113) fetch_parallel_config = git_config_int(k, v);
>> d54dea77 114) if (fetch_parallel_config < 0)
>> d54dea77 116) return 0;
>> d54dea77 1566) static int fetch_failed_to_start(struct strbuf *out, void *cb, void *task_cb)
>> d54dea77 1568) struct parallel_fetch_state *state = cb;
>> d54dea77 1569) const char *remote = task_cb;
>> d54dea77 1573) return 0;
> 
> I guess that yes, this points out that setting the number of parallel
> fetches via `fetch.parallel` is untested... I am willing to leave it like
> that until the time a regression is found in that code (if ever).

I believe that anything that is multi-threaded is untested in this build
target as to avoid issues with race conditions in the gcov data.

>> Johannes Schindelin	e145d993 rebase -r: support merge strategies other than `recursive`
>> sequencer.c
>> e145d993 3304) (!opts->strategy || !strcmp(opts->strategy, "recursive")) ?
> 
> I am a bit puzzled by this because the added test case in t3430 should
> cover precisely this line.

It could be that we hit "!opts->strategy" and short-circuit the strcmp, which
would mark the line as uncovered.

>> Johannes Schindelin	e2683d51 Fix .git/ discovery at the root of UNC shares
>> setup.c
>> e2683d51 952)     !is_dir_sep(dir->buf[min_offset - 1])) {
>> e2683d51 953) strbuf_addch(dir, '/');
>> e2683d51 954) min_offset++;
> 
> I think this is only tested on Windows.
> 
>> Johannes Schindelin	be5d88e1 test-tool run-command: learn to run (parts of) the testsuite
>> t/helper/test-run-command.c
>> be5d88e1 66) static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
>> be5d88e1 69) struct testsuite *suite = cb;
>> be5d88e1 71) if (suite->next >= suite->tests.nr)
>> be5d88e1 72) return 0;
>> be5d88e1 74) test = suite->tests.items[suite->next++].string;
>> be5d88e1 75) argv_array_pushl(&cp->args, "sh", test, NULL);
>> be5d88e1 76) if (suite->quiet)
>> be5d88e1 77) argv_array_push(&cp->args, "--quiet");
>> be5d88e1 78) if (suite->immediate)
>> be5d88e1 79) argv_array_push(&cp->args, "-i");
>> be5d88e1 80) if (suite->verbose)
>> be5d88e1 81) argv_array_push(&cp->args, "-v");
>> be5d88e1 82) if (suite->verbose_log)
>> be5d88e1 83) argv_array_push(&cp->args, "-V");
>> be5d88e1 84) if (suite->trace)
>> be5d88e1 85) argv_array_push(&cp->args, "-x");
>> be5d88e1 86) if (suite->write_junit_xml)
>> be5d88e1 87) argv_array_push(&cp->args, "--write-junit-xml");
>> be5d88e1 89) strbuf_addf(err, "Output of '%s':\n", test);
>> be5d88e1 90) *task_cb = (void *)test;
>> be5d88e1 92) return 1;
>> be5d88e1 95) static int test_finished(int result, struct strbuf *err, void *cb,
>> be5d88e1 98) struct testsuite *suite = cb;
>> be5d88e1 99) const char *name = (const char *)task_cb;
>> be5d88e1 101) if (result)
>> be5d88e1 102) string_list_append(&suite->failed, name);
>> be5d88e1 104) strbuf_addf(err, "%s: '%s'\n", result ? "FAIL" : "SUCCESS", name);
>> be5d88e1 106) return 0;
>> be5d88e1 109) static int test_failed(struct strbuf *out, void *cb, void *task_cb)
>> be5d88e1 111) struct testsuite *suite = cb;
>> be5d88e1 112) const char *name = (const char *)task_cb;
>> be5d88e1 114) string_list_append(&suite->failed, name);
>> be5d88e1 115) strbuf_addf(out, "FAILED TO START: '%s'\n", name);
>> be5d88e1 117) return 0;
>> be5d88e1 125) static int testsuite(int argc, const char **argv)
>> be5d88e1 127) struct testsuite suite = TESTSUITE_INIT;
>> be5d88e1 128) int max_jobs = 1, i, ret;
>> be5d88e1 131) struct option options[] = {
>> be5d88e1 145) memset(&suite, 0, sizeof(suite));
>> be5d88e1 146) suite.tests.strdup_strings = suite.failed.strdup_strings = 1;
>> be5d88e1 148) argc = parse_options(argc, argv, NULL, options,
>> be5d88e1 151) if (max_jobs <= 0)
>> be5d88e1 152) max_jobs = online_cpus();
>> be5d88e1 154) dir = opendir(".");
>> be5d88e1 155) if (!dir)
>> be5d88e1 157) while ((d = readdir(dir))) {
>> be5d88e1 158) const char *p = d->d_name;
>> be5d88e1 160) if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
>> be5d88e1 161)     !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
>> be5d88e1 162)     !ends_with(p, ".sh"))
>> be5d88e1 163) continue;
>> be5d88e1 166) if (!argc) {
>> be5d88e1 167) string_list_append(&suite.tests, p);
>> be5d88e1 168) continue;
>> be5d88e1 171) for (i = 0; i < argc; i++)
>> be5d88e1 172) if (!wildmatch(argv[i], p, 0)) {
>> be5d88e1 173) string_list_append(&suite.tests, p);
>> be5d88e1 174) break;
>> be5d88e1 177) closedir(dir);
>> be5d88e1 179) if (!suite.tests.nr)
>> be5d88e1 181) if (max_jobs > suite.tests.nr)
>> be5d88e1 182) max_jobs = suite.tests.nr;
>> be5d88e1 184) fprintf(stderr, "Running %d tests (%d at a time)\n",
>> be5d88e1 187) ret = run_processes_parallel(max_jobs, next_test, test_failed,
>> be5d88e1 190) if (suite.failed.nr > 0) {
>> be5d88e1 191) ret = 1;
>> be5d88e1 192) fprintf(stderr, "%d tests failed:\n\n", suite.failed.nr);
>> be5d88e1 193) for (i = 0; i < suite.failed.nr; i++)
>> be5d88e1 194) fprintf(stderr, "\t%s\n", suite.failed.items[i].string);
>> be5d88e1 197) string_list_clear(&suite.tests, 0);
>> be5d88e1 198) string_list_clear(&suite.failed, 0);
>> be5d88e1 200) return !!ret;
>> be5d88e1 209) exit(testsuite(argc - 1, argv + 1));
> 
> This is exercised extensively in the Visual Studio job of our Azure
> Pipeline.
> 
> Thanks,
> DschO

Thank you!
-Stolee
