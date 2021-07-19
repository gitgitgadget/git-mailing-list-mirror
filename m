Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE02C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41564610FB
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhGSJbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 05:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbhGSJbY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 05:31:24 -0400
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Jul 2021 02:17:00 PDT
Received: from smtp1.fnusa.cz (smtp1.fnusa.cz [IPv6:2001:718:806:2::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A46DC061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 02:17:00 -0700 (PDT)
Received: from smtp1.fnusa.cz (mailfilter.fnusa.cz [172.30.0.204])
        by smtp1.fnusa.cz (Postfix) with ESMTP id 94752120B09;
        Mon, 19 Jul 2021 12:04:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fnusa.cz; s=mail;
        t=1626689095; bh=pA0LGyRUzFc+8w5pD8UIA2CSgSAwb5L74e1bENrS+TI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Op6d1aOjLW+lcW5THaJqzE7qsCbYjQF/U8KAfj8HW6tzv1NkffbFfrrfbo/s17nWr
         t4Xox9Z8r4XmLKuz4gvkIpecAQR30qYkXsNCCmpla+Y5qDGoUeaHBFRUlOjT2vK3xu
         AIu/HVa+XTHz4fvrzsXu+mEIU8ZfDgowNZ5jaQQM=
Received: from [172.30.22.150] (unknown [172.30.22.150])
        by smtp1.fnusa.cz (Postfix) with ESMTPS id 748CB1208E3;
        Mon, 19 Jul 2021 12:04:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fnusa.cz; s=mail;
        t=1626689095; bh=pA0LGyRUzFc+8w5pD8UIA2CSgSAwb5L74e1bENrS+TI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Op6d1aOjLW+lcW5THaJqzE7qsCbYjQF/U8KAfj8HW6tzv1NkffbFfrrfbo/s17nWr
         t4Xox9Z8r4XmLKuz4gvkIpecAQR30qYkXsNCCmpla+Y5qDGoUeaHBFRUlOjT2vK3xu
         AIu/HVa+XTHz4fvrzsXu+mEIU8ZfDgowNZ5jaQQM=
Message-ID: <8636b96be256b47d207e543995abbecde9ca5055.camel@fnusa.cz>
Subject: Re: git pull --set-upstream segfaults on branchless repo.
From:   Jan =?ISO-8859-1?Q?Pokorn=FD?= <poki@fnusa.cz>
To:     git@vger.kernel.org
Cc:     Clemens Fruhwirth <clemens@endorphin.org>
Date:   Mon, 19 Jul 2021 12:04:55 +0200
In-Reply-To: <CAG6gW_uHhfNiHGQDgGmb1byMqBA7xa8kuH1mP-wAPEe5Tmi2Ew@mail.gmail.com>
References: <CAG6gW_uHhfNiHGQDgGmb1byMqBA7xa8kuH1mP-wAPEe5Tmi2Ew@mail.gmail.com>
Organization: =?ISO-8859-1?Q?Fakultn=ED?= nemocnice u sv. Anny v
 =?UTF-8?Q?Brn=C4=9B?=
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.1 (3.41.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Clemens Fruhwirth píše v Po 05. 07. 2021 v 17:46 +0200:
> What did you do before the bug happened? (Steps to reproduce your
> issue)
> 
> Run "git pull origin nixos-unstable --rebase --set-upstream"
> on a repo that had no branch set, e.g. when running "git branch" gave
> "* (no branch)"
> 
> What did you expect to happen? (Expected behavior)
> Pull from upstream and set upstream.
> 
> What happened instead? (Actual behavior)
> Segfault with the following trace:
> (gdb) bt
> #0  0x000000000044a8c9 in do_fetch (transport=0x2557920, rs=rs@entry=0x7ffd42335c00) at builtin/fetch.c:1568
> #1  0x000000000044ac61 in fetch_one (remote=<optimized out>, argc=1110662144, argv=0x7ffd42335fc8, prune_tags_ok=<optimized out>, use_stdin_refspecs=0) at builtin/fetch.c:1892
> #2  0x000000000044af15 in cmd_fetch (argc=0, argv=0x7ffd42335fc8, prefix=0x0) at builtin/fetch.c:1992
> #3  0x0000000000406354 in run_builtin (p=0x70d3e0 <commands+960>, argc=argc@entry=5, argv=argv@entry=0x7ffd42335fc0) at git.c:453
> #4  0x00000000004065c3 in handle_builtin (argc=5, argv=0x7ffd42335fc0) at git.c:704
> #5  0x0000000000407c4a in run_argv (argcp=argcp@entry=0x7ffd42335e8c, argv=argv@entry=0x7ffd42335e80) at git.c:771
> #6  0x00000000004080a4 in cmd_main (argc=<optimized out>, argc@entry=6, argv=<optimized out>, argv@entry=0x7ffd42335fb8) at git.c:902
> #7  0x00000000004c614c in main (argc=6, argv=0x7ffd42335fb8) at common-main.c:52
> (gdb) p branch
> $1 = (struct branch *) 0x0
> 
> What's different between what you expected and what actually happened?
> Not segfault
> 
> Anything else you want to add:
> 
> Dropping the "--set-upstream" makes the segfault go away. Looking at
> builtin/fetch.c around L1568 I see,
> 
>         if (set_upstream) {
>                 struct branch *branch = branch_get("HEAD");
>                 [..]
>                 if (source_ref) {
>                         if (!strcmp(source_ref->name, "HEAD") ||
>                             starts_with(source_ref->name, "refs/heads/"))
>                                 install_branch_config(0,
>                                                       branch->name, // <- SEGFAULT HERE
>                                                       transport->remote->name,
>                                                       source_ref->name);
>                         [..]
>               }
>         }
> 
> It's rather clear that branch is just NULL from the gdb session above,
> and the branch->name dereference fails.
> It might be useful to catch branch == NULL.
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> [System Info]
> git version:
> git version 2.31.1
> [...]

observed something pretty similar on Fedora, with both
git-2.32.0-0.3.rc2.fc35.x86_64 and git-2.32.0-1.fc35.x86_64, e.g.:

$ git clone https://github.com/git/git.git
[...]
$ cd git
$ git checkout --detach v2.1.0
HEAD is now at 6c4ab27f23 Git 2.1
$ git pull --set-upstream origin master
From https://github.com/git/git
 * branch                  master     -> FETCH_HEAD
error: fetch died of signal 11

  1625			if (source_ref) {
  1626				if (!strcmp(source_ref->name, "HEAD") ||
  1627				   starts_with(source_ref->name, "refs/heads/"))
=>1628					install_branch_config(0,
  1629							     branch->name,
  1630							     transport->remote->name,
  1631							     source_ref->name);

(gdb) p branch
$1 = <optimized out>
(gdb) p branch->name
value has been optimized out

   0x000055b5bceba921 <+8705>:	nopl   0x0(%rax)
   0x000055b5bceba928 <+8712>:	mov    (%rsp),%rax
=> 0x000055b5bceba92c <+8716>:	mov    (%r8),%rsi
   0x000055b5bceba92f <+8719>:	xor    %edi,%edi
   0x000055b5bceba931 <+8721>:	mov    0x8(%rax),%rax
   0x000055b5bceba935 <+8725>:	mov    0x10(%rax),%rdx
   0x000055b5bceba939 <+8729>:	call   0x55b5bcf75d40 <install_branch_config>

(gdb) info registers r8 rsi
r8             0x0                 0
rsi            0x55b5bdbe430b      94239060804363

This is just a generic reproducer; original use case revolved around
the use of submodules (also happened to be in a detached state within,
"--set-upstream" attempt was then my rushed response to "You are
not currently on a branch." error message on a plain pull there).

> (Please cc me on replies, not subscribe to the mailing list).

(ditto, please)

-- poki
