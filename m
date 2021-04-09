Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E3C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE6F610CC
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 16:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhDIQuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:50:02 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:14174 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhDIQuB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 12:50:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id B1F19A6C;
        Fri,  9 Apr 2021 18:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1617986983; x=1619801384; bh=sDRZn2gzPtjGrR3Guc4
        LAo7PxaTMfVzAgNdLGadTJV4=; b=2eic/qmZMZxPu1wmcLNJPsIxg4K2q3hIhMZ
        PFuy7i+u/D/QxgfTjEeNgupyEQ2Wy0/9CA4d2HunvljsOtR4bJTMBb5bbEUwxJRt
        BZxw3w83whbjg7WLtWeMCkjjcJkA5/7K7nIRBVnrY7xiEbE2PkHUeU+b5RytrBFK
        31vc05npyGfsR0d3p1ZhpotqZ1dvlqm68pamjq1B8QkNItGXZWCMvfcyrKo59xXJ
        NRpkBEtsQVO0wNRanKU8/iPe6Maur0Db/O1FK56BGeGAcj6bzuCvcHI8wbQYvnfC
        +FKvOizrcWI76ZYa2jVlVNG6E7zJG2TkYnGQ48f/FbL2vDdZLF2gqR3FcbFUfolN
        EIowaHScT9Buo2K211xkiJIpTl2lV0fbRmi36/MqdZaMajaZyCcej2iQfAYY5Hbd
        AccdNiIrBfI/6E8F3Qm/xVNmcYzUtBntM/JkbQg0gFHMKJdgH9pOLW9VM6VO5rId
        nlYIJ8+zozLgHL7uFij0TZgFa3s8KI5OGKTGnuBcvPJ8k1y0LE2b2G+X4s0ocO5S
        b+Sb//HX5IyyuiKZFwHHYu6vsD62W8iR07PK7s1ZJcdvIrBjIVZlSbfmRK/OFHsN
        SlYkN+91uH1cOMsf91IPIxKvoAiUOQ0dXvfu1eTrjyR4ovQHVk2rGwv+f0IRyYuc
        u8pL6/jI=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TJoAo0oNprAP; Fri,  9 Apr 2021 18:49:43 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 74A7758A;
        Fri,  9 Apr 2021 18:49:43 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 84E2EEDB;
        Fri,  9 Apr 2021 18:49:41 +0200 (CEST)
Subject: Re: Possible memory leak bug reports for the latest "git" repository.
To:     =?UTF-8?B?7Jqw7Iq57ZuIWyDrjIDtlZnsm5DshJ3Ct+uwleyCrO2Gte2VqeqzvOyglQ==?=
         =?UTF-8?B?7IiY66OM7Jew6rWsKOyerO2VmSkgLyDsu7Ttk6jthLDtlZnqs7wgXQ==?= 
        <seunghoonwoo@korea.ac.kr>, git@vger.kernel.org
Cc:     hanjiyeon0@gmail.com
References: <CAPb83E_r-gx-zDU1eLwPLfC_Zd-4Hyb_x6t_s_pGHwfxuQ0+vQ@mail.gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <b96f76f2-db00-cc7c-eb83-3033873023ec@ahunt.org>
Date:   Fri, 9 Apr 2021 18:49:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAPb83E_r-gx-zDU1eLwPLfC_Zd-4Hyb_x6t_s_pGHwfxuQ0+vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/04/2021 15:59, 우승훈[ 대학원석·박사통합과정수료연구(재학) / 컴퓨 
터학과 ] wrote:
> Dear Git Development team.
> 
> Hi.
> Recently, we discovered that the vulnerable code of CVE-2019-9169 is
> included in the latest version (v2.31.1) of your source repository
> (https://github.com/git/git).
> 
> Vulnerable file: git/compat/regex/regexec.c
> 
> Ref: CVE-2019-9169 (https://nvd.nist.gov/vuln/detail/CVE-2019-9169)
> 
> Original patch link:
> https://sourceware.org/git/?p=glibc.git;a=blobdiff;f=posix/regexec.c;h=084b1222d95b62eb2930166060174ef78cb74b02;hp=91d5a797b82e2679ceab74238416de06693e46ea;hb=583dd860d5b833037175247230a328f0050dbfe9;hpb=2bac7daa58da1a313bd452369b0508b31e146637
> 
> 
> Although the original vulnerability caused a heap-based buffer
> over-read, the vulnerable code seems to cause a memory leak in your
> repository.

I don't feel qualified to comment on the vulnerability itself (except 
that by inspection the code looks the same) - hopefully someone with 
more expertise can chime in. That said, I ran your repro example through 
a debugger and at least /on my system/, the problematic code is not 
being called when using /the specific testcases you supplied/.

Regarding the memory leaks you have found: they are not of particular 
concern - git has a lot of small memory leaks, they're ugly but not 
impactful (that said - I've been working on fixing some of those leaks). 
In fact I don't think any of the leaks you found are in any way related 
to the regex code - see analysis inline:

> $ ./git-log -i '\(\(\)*.\)*\(\)\(\)\1'
> fatal: your current branch 'master' does not have any commits yet
> =================================================================
> ==27253==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 65 byte(s) in 1 object(s) allocated from:
>      #0 0x7f6ff01de961 in realloc
> (/usr/lib/x86_64-linux-gnu/libasan.so.2+0x98961)
>      #1 0x843ee5 in xrealloc  /HDD/POC/CVE-2019-9169/git-2.31.1/wrapper.c:126
> 
> SUMMARY: AddressSanitizer: 65 byte(s) leaked in 1 allocation(s).
> *****************************************************************************************

Unfortunately this log is a bit useless: LSAN should print the call 
stack down to realloc, but it sometimes misses everything above the 
wrapper calls. I haven't managed to figure out why this is happening. 
That said, I can't reproduce this leak locally (clang-11 + ASAN + LSAN), 
so it's plausible that it was fixed recently.

> 
> 
> *****************************************************************************************
> Second test:
> 
> OS: Ubuntu 18.04.5 LTS
> Git version: v2.31.1
> Makefile config: Default
> 
> Result:
> 
> $ printf xxxxxxxxxxxxxx |valgrind --leak-check=full ./git-log -i '\(\(\)*.\)*\1'
> ==63105== Memcheck, a memory error detector
> ==63105== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==63105== Using Valgrind-3.13.0 and LibVEX; rerun with -h for copyright info
> ==63105== Command: ./git-log -i \\(\\(\\)*.\\)*\\1
> ==63105==
> ==63105==
> ==63105== HEAP SUMMARY:
> ==63105==     in use at exit: 118,368,930 bytes in 76,720 blocks
> ==63105==   total heap usage: 463,994 allocs, 387,274 frees,
> 2,273,364,625 bytes allocated
> ==63105==
> ==63105== 40 bytes in 1 blocks are possibly lost in loss record 38 of 142
> ==63105==    at 0x4C31B0F: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
> ==63105==    by 0x355BB5: chdir_notify_register (chdir-notify.c:18)
> ==63105==    by 0x355BB5: chdir_notify_reparent (chdir-notify.c:48)
> ==63105==    by 0x2D5DC6: packed_ref_store_create (packed-backend.c:207)
> ==63105==    by 0x2D02BA: files_ref_store_create (files-backend.c:96)
> ==63105==    by 0x2CC295: get_main_ref_store (refs.c:1900)
> ==63105==    by 0x2E969D: handle_revision_pseudo_opt (revision.c:2578)
> ==63105==    by 0x2E969D: setup_revisions (revision.c:2730)
> ==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
> ==63105==    by 0x18241F: cmd_log_init (log.c:275)
> ==63105==    by 0x18241F: cmd_log (log.c:754)
> ==63105==    by 0x12781D: run_builtin (git.c:453)
> ==63105==    by 0x12781D: handle_builtin (git.c:704)
> ==63105==    by 0x1289A4: cmd_main (git.c:872)
> ==63105==    by 0x127467: main (common-main.c:52)
> ==63105==
> ==63105== 40 bytes in 1 blocks are possibly lost in loss record 39 of 142
> ==63105==    at 0x4C31B0F: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
> ==63105==    by 0x355BB5: chdir_notify_register (chdir-notify.c:18)
> ==63105==    by 0x355BB5: chdir_notify_reparent (chdir-notify.c:48)
> ==63105==    by 0x2D02D6: files_ref_store_create (files-backend.c:99)
> ==63105==    by 0x2CC295: get_main_ref_store (refs.c:1900)
> ==63105==    by 0x2E969D: handle_revision_pseudo_opt (revision.c:2578)
> ==63105==    by 0x2E969D: setup_revisions (revision.c:2730)
> ==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
> ==63105==    by 0x18241F: cmd_log_init (log.c:275)
> ==63105==    by 0x18241F: cmd_log (log.c:754)
> ==63105==    by 0x12781D: run_builtin (git.c:453)
> ==63105==    by 0x12781D: handle_builtin (git.c:704)
> ==63105==    by 0x1289A4: cmd_main (git.c:872)
> ==63105==    by 0x127467: main (common-main.c:52)
> ==63105==
> ==63105== 40 bytes in 1 blocks are possibly lost in loss record 40 of 142
> ==63105==    at 0x4C31B0F: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
> ==63105==    by 0x355BB5: chdir_notify_register (chdir-notify.c:18)
> ==63105==    by 0x355BB5: chdir_notify_reparent (chdir-notify.c:48)
> ==63105==    by 0x2D02E6: files_ref_store_create (files-backend.c:100)
> ==63105==    by 0x2CC295: get_main_ref_store (refs.c:1900)
> ==63105==    by 0x2E969D: handle_revision_pseudo_opt (revision.c:2578)
> ==63105==    by 0x2E969D: setup_revisions (revision.c:2730)
> ==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
> ==63105==    by 0x18241F: cmd_log_init (log.c:275)
> ==63105==    by 0x18241F: cmd_log (log.c:754)
> ==63105==    by 0x12781D: run_builtin (git.c:453)
> ==63105==    by 0x12781D: handle_builtin (git.c:704)
> ==63105==    by 0x1289A4: cmd_main (git.c:872)
> ==63105==    by 0x127467: main (common-main.c:52)
> ==63105==
> ==63105== 65 bytes in 1 blocks are definitely lost in loss record 59 of 142

These are a bit odd: chdir_notify_register() is attaching the newly 
allocated memory to a static list (chdir_notify_entries), and I can't 
see any obvious reason why this would leak (but maybe valgrind doesn't 
like static pointers)? Either way, this doesn't seem to be anywhere near 
the regex code.

> ==63105==    at 0x4C31A3F: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x4C33D84: realloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x340345: xrealloc (wrapper.c:126)
> ==63105==    by 0x30B93A: strbuf_grow (strbuf.c:98)
> ==63105==    by 0x30C8EC: strbuf_vaddf (strbuf.c:392)
> ==63105==    by 0x30CA33: strbuf_addf (strbuf.c:333)
> ==63105==    by 0x2A9700: preprocess_options (parse-options.c:666)
> ==63105==    by 0x2A9700: parse_options (parse-options.c:847)
> ==63105==    by 0x18053E: cmd_log_init_finish (log.c:199)
> ==63105==    by 0x18241F: cmd_log_init (log.c:275)
> ==63105==    by 0x18241F: cmd_log (log.c:754)
> ==63105==    by 0x12781D: run_builtin (git.c:453)
> ==63105==    by 0x12781D: handle_builtin (git.c:704)
> ==63105==    by 0x1289A4: cmd_main (git.c:872)
> ==63105==    by 0x127467: main (common-main.c:52)
> ==63105==

This was fixed in:
https://github.com/git/git/commit/64cc539fd2f8e02f39cfae21e9523da2532c0467#diff-1f0cbd43fdb6fcca38e0bcd390901118a948a9fb3a4f9b2e2edb2783d343f0b8

> ==63105== 84 (56 direct, 28 indirect) bytes in 1 blocks are definitely
> lost in loss record 61 of 142
> ==63105==    at 0x4C31B0F: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
> ==63105==    by 0x2AE9C0: copy_pathspec (pathspec.c:664)
> ==63105==    by 0x2E993A: setup_revisions (revision.c:2844)
> ==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
> ==63105==    by 0x18241F: cmd_log_init (log.c:275)
> ==63105==    by 0x18241F: cmd_log (log.c:754)
> ==63105==    by 0x12781D: run_builtin (git.c:453)
> ==63105==    by 0x12781D: handle_builtin (git.c:704)
> ==63105==    by 0x1289A4: cmd_main (git.c:872)
> ==63105==    by 0x127467: main (common-main.c:52 > ==63105==
> ==63105== 84 (56 direct, 28 indirect) bytes in 1 blocks are definitely
> lost in loss record 62 of 142
> ==63105==    at 0x4C31B0F: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
> ==63105==    by 0x2AE9C0: copy_pathspec (pathspec.c:664)
> ==63105==    by 0x2E996A: setup_revisions (revision.c:2849)
> ==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
> ==63105==    by 0x18241F: cmd_log_init (log.c:275)
> ==63105==    by 0x18241F: cmd_log (log.c:754)
> ==63105==    by 0x12781D: run_builtin (git.c:453)
> ==63105==    by 0x12781D: handle_builtin (git.c:704)
> ==63105==    by 0x1289A4: cmd_main (git.c:872)
> ==63105==    by 0x127467: main (common-main.c:52)
> ==63105==
> ==63105== 191 (112 direct, 79 indirect) bytes in 1 blocks are
> definitely lost in loss record 76 of 142
> ==63105==    at 0x4C31B0F: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
> ==63105==    by 0x2AE381: parse_pathspec (pathspec.c:582)
> ==63105==    by 0x2E9164: setup_revisions (revision.c:2800)
> ==63105==    by 0x180562: cmd_log_init_finish (log.c:206)
> ==63105==    by 0x18241F: cmd_log_init (log.c:275)
> ==63105==    by 0x18241F: cmd_log (log.c:754)
> ==63105==    by 0x12781D: run_builtin (git.c:453)
> ==63105==    by 0x12781D: handle_builtin (git.c:704)
> ==63105==    by 0x1289A4: cmd_main (git.c:872)
> ==63105==    by 0x127467: main (common-main.c:52)
> ==63105==
> ==63105== 464 (448 direct, 16 indirect) bytes in 28 blocks are
> definitely lost in loss record 98 of 14 > ==63105==    at 0x4C31B0F: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
> ==63105==    by 0x217A3D: commit_list_insert (commit.c:554)
> ==63105==    by 0x217A3D: parse_commit_buffer (commit.c:447)
> ==63105==    by 0x296F37: parse_object_buffer (object.c:217)
> ==63105==    by 0x297070: parse_object (object.c:282)
> ==63105==    by 0x274781: add_ref_decoration (log-tree.c:179)
> ==63105==    by 0x2D5C53: do_for_each_repo_ref_iterator (iterator.c:418)
> ==63105==    by 0x2CB9F8: do_for_each_ref (refs.c:1492)
> ==63105==    by 0x274A65: load_ref_decorations (log-tree.c:211)
> ==63105==    by 0x1807C9: cmd_log_init_finish (log.c:262)
> ==63105==    by 0x18241F: cmd_log_init (log.c:275)
> ==63105==    by 0x18241F: cmd_log (log.c:754)
> ==63105==    by 0x12781D: run_builtin (git.c:453)
> ==63105==    by 0x12781D: handle_builtin (git.c:704)
> ==63105==
> ==63105== 37,468 (32 direct, 37,436 indirect) bytes in 1 blocks are
> definitely lost in loss record 120 of 142
> ==63105==    at 0x4C33B25: calloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x3403AD: xcalloc (wrapper.c:140)
> ==63105==    by 0x1806F4: cmd_log_init_finish (log.c:233)
> ==63105==    by 0x18241F: cmd_log_init (log.c:275)
> ==63105==    by 0x18241F: cmd_log (log.c:754)
> ==63105==    by 0x12781D: run_builtin (git.c:453)
> ==63105==    by 0x12781D: handle_builtin (git.c:704)
> ==63105==    by 0x1289A4: cmd_main (git.c:872)
> ==63105==    by 0x127467: main (common-main.c:52)
> ==63105==

These aren't really "real" leaks because they're populating a rev_info 
that is owned by cmd_log. In other words: the data isn't leaked until 
cmd_log() returns, and by that point we don't care anymore.

That said, I have a patch prepared to UNLEAK the rev_info in question 
which will suppress these leaks when running with 
-DSUPPRESS_ANNOTATED_LEAKS, which I'll probably be sending out soon.

> ==63105== 184,176 (183,792 direct, 384 indirect) bytes in 11,487
> blocks are definitely lost in loss record 130 of 142
> ==63105==    at 0x4C31B0F: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==63105==    by 0x34013A: do_xmalloc (wrapper.c:41)
> ==63105==    by 0x217A3D: commit_list_insert (commit.c:554)
> ==63105==    by 0x217A3D: parse_commit_buffer (commit.c:447)
> ==63105==    by 0x217CEC: repo_parse_commit_internal (commit.c:498)
> ==63105==    by 0x2E4C3D: repo_parse_commit (commit.h:89)
> ==63105==    by 0x2E4C3D: try_to_simplify_commit (revision.c:1007)
> ==63105==    by 0x2E84AA: process_parents (revision.c:1140)
> ==63105==    by 0x2EBFED: get_revision_1 (revision.c:3999)
> ==63105==    by 0x2EC1BF: get_revision_internal (revision.c:4113)
> ==63105==    by 0x2EC344: get_revision (revision.c:4187)
> ==63105==    by 0x181538: cmd_log_walk (log.c:422)
> ==63105==    by 0x182427: cmd_log (log.c:755)
> ==63105==    by 0x12781D: run_builtin (git.c:453)
> ==63105==    by 0x12781D: handle_builtin (git.c:704)

I suspect this is similar to the last bunch: we end up leaking anything 
that's added to rev_info when cmd_log() returns. Not a big deal, but it 
will also be supressed with an UNLEAK in future.

ATB,
     Andrzej
