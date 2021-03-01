Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3FEC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817D1601FA
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhCATYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 14:24:05 -0500
Received: from siwi.pair.com ([209.68.5.199]:43678 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241433AbhCATVx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 14:21:53 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 141E93F40B7;
        Mon,  1 Mar 2021 14:21:05 -0500 (EST)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F1D7B3F4096;
        Mon,  1 Mar 2021 14:21:04 -0500 (EST)
Subject: Re: Argument list too long when fetching many missing objects from
 partial clone
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
References: <fd1ba192-b90c-ef20-0843-c0e47925c76a@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <be2a9647-3e3c-b88f-0f86-729dba5488c3@jeffhostetler.com>
Date:   Mon, 1 Mar 2021 14:21:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <fd1ba192-b90c-ef20-0843-c0e47925c76a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/1/21 8:18 AM, Bagas Sanjaya wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> I'm poking around with partial clone. On my local server on my computer
> I have full clone of Git (git.git) repo.
> 
> I do partial clone from that server as remote (which is actually on the 
> same
> computer):
> 
>     git clone https://my-local-server.git/myself/git.git --filter=blob:none
> 
> Inside the partial clone, I tried to convert it to full clone. First, I 
> gather
> list of missing objects:
> 
>     git rev-list --objects --all --missing=print | grep -oP '^\?\K\w+' > 
> .git/missing.list
> 
> Then I fetched those:
> 
>     git fetch origin $(cat .git/missing.list)
> 

That command will build a very very long command line and cause the
shell to complain.  Instead, try passing the list of objects via stdin.

     $ cat .git/missing.list | git fetch --stdin origin



> What did you expect to happen? (Expected behavior)
> 
> All missing objects fetched successfully
> 
> What happened instead? (Actual behavior)
> 
> Git returned:
> 
>      -bash: /opt/git/bin/git: Argument list too long
> 
> What's different between what you expected and what actually happened?
> 
> (nothing)
> 
> Anything else you want to add:
> 
> I think the problem lies on how to feed list of 110K+ objects to `git 
> fetch`.
> 
> Note: Both the local server and the computer use Git 2.30.1
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> [System Info]
> git version:
> git version 2.30.1
> cpu: x86_64
> built from commit: 773e25afc41b1b6533fa9ae2cd825d0b4a697fad
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.10.11-kernelorg-upstream-generic #1 SMP Fri Jan 29 
> 12:56:19 WIB 2021 x86_64
> compiler info: gnuc: 9.3
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /bin/bash
> 
> [Enabled Hooks]
> (none)
> 
