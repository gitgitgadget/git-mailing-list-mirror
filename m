Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E38EC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17322083B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgJGUvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 16:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJGUvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 16:51:18 -0400
X-Greylist: delayed 1359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Oct 2020 13:51:18 PDT
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEEDC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 13:51:18 -0700 (PDT)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kQG3A-0001m3-U2; Wed, 07 Oct 2020 22:28:36 +0200
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: 2.29.0.rc0.windows.1: Duplicate commit id error message when fetching
Message-ID: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
Date:   Wed, 7 Oct 2020 22:28:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1602103878;1a0260ff;
X-HE-SMSGID: 1kQG3A-0001m3-U2
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm using

$ git --version
git version 2.29.0.rc0.windows.1

Since I upgraded to that version (thanks to dscho for providing these so
early) I'm seeing occasionally

$ git fetch origin +refs/head/abcd:refs/remotes/origin/abcd
fatal: unexpected duplicate commit id
31a13139875bc5f49ddcbd42b4b4d3dc18c16576

The local branch abcd is at

$ git rev-parse HEAD
b6ae1ee2adcb75aee09c4a8d72bfd66f32f6fae1

while its remote tracking branch is at

$ git rev-parse @{u}
31a13139875bc5f49ddcbd42b4b4d3dc18c16576

I have pull.rebase=true set but I think this does not matter for fetch.
I do have protocol V2 enabled.

A full trace is

$ GIT_TRACE=1 git fetch origin +refs/heads/abcd:refs/remotes/origin/abcd
22:23:42.016859 exec-cmd.c:237          trace: resolved executable dir:
C:/Program Files/Git/mingw64/bin
22:23:42.018858 git.c:444               trace: built-in: git fetch
origin +refs/heads/abcd:refs/remotes/origin/abcd
22:23:42.020858 run-command.c:663       trace: run_command: unset
GIT_PREFIX; GIT_PROTOCOL=version=2 ssh -o SendEnv=GIT_PROTOCOL
git@github.com 'git-upload-pack '\''XXX/YYY.git'\'''
22:23:43.284643 run-command.c:663       trace: run_command: git rev-list
--objects --stdin --not --all --quiet --alternate-refs
22:23:43.344644 run-command.c:663       trace: run_command: git rev-list
--objects --stdin --not --all --quiet --alternate-refs
22:23:43.358613 exec-cmd.c:237          trace: resolved executable dir:
C:/Program Files/Git/mingw64/libexec/git-core
22:23:43.360614 git.c:444               trace: built-in: git rev-list
--objects --stdin --not --all --quiet --alternate-refs
22:23:43.492616 run-command.c:1617      run_processes_parallel:
preparing to run up to 1 tasks
22:23:43.492616 run-command.c:1649      run_processes_parallel: done
fatal: unexpected duplicate commit id
31a13139875bc5f49ddcbd42b4b4d3dc18c16576

The repo is public, so if it helps I can provide a link.

Anything I'm doing wrong here?

Thanks,
Thomas
