Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88648C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 11:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDNLrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 07:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNLrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 07:47:20 -0400
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Apr 2023 04:47:17 PDT
Received: from thyone.hiz-saarland.de (thyone.hiz-saarland.de [134.96.7.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC09A3A84
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 04:47:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by thyone.hiz-saarland.de (Postfix) with ESMTP id 71756409004D
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 13:39:04 +0200 (CEST)
Received: from thyone.hiz-saarland.de ([127.0.0.1])
        by localhost (thyone.hiz-saarland.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SlUWnrFzJJfU for <git@vger.kernel.org>;
        Fri, 14 Apr 2023 13:39:03 +0200 (CEST)
Received: from triton.rz.uni-saarland.de (old-smtp.uni-saarland.de.local [134.96.7.25])
        by thyone.hiz-saarland.de (Postfix) with ESMTPS
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 13:39:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by triton.rz.uni-saarland.de (Postfix) with ESMTP id 2E7DD60001AA
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 13:39:03 +0200 (CEST)
Received: from triton.rz.uni-saarland.de ([127.0.0.1])
        by localhost (triton.rz.uni-saarland.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yiA81aw359by for <git@vger.kernel.org>;
        Fri, 14 Apr 2023 13:39:02 +0200 (CEST)
Received: from mail.uni-sb.de (mail.uni-sb.de [134.96.252.33])
        by triton.rz.uni-saarland.de (Postfix) with ESMTPS
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 13:38:59 +0200 (CEST)
Received: from mail.cs.uni-saarland.de (mail.cs.uni-saarland.de [134.96.254.200])
        by mail.uni-sb.de (8.16.1/2018090600) with ESMTP id 33EBbau4026449
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 13:37:36 +0200 (CEST)
Received: from edguy.cs.uni-saarland.de (edguy.cs.uni-saarland.de [134.96.224.31])
        by mail.cs.uni-saarland.de (8.16.1/2023032400) with ESMTP id 33EBcukd005548
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 13:38:56 +0200 (CEST)
Received: from p54aa7f77.dip0.t-ipconnect.de ([84.170.127.119]:50412 helo=[192.168.2.103])
        by edguy.cs.uni-saarland.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <bockthom@cs.uni-saarland.de>)
        id 1pnHkc-0001da-25
        for git@vger.kernel.org;
        Fri, 14 Apr 2023 13:38:04 +0200
Message-ID: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
Date:   Fri, 14 Apr 2023 13:37:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
From:   Thomas Bock <bockthom@cs.uni-saarland.de>
To:     git@vger.kernel.org
Subject: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC--Metrics: mail.cs.uni-saarland.de; whitelist
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git development team,

I've spotted a weird behavior of git in a specific repository, which I 
cannot explain, maybe there is a bug in git.

Repository in which the problem occurs:

git@github.com:LibreOffice/core.git

Problem:

When ordering the commits in this repository by time via "git log", 
there are several tens of commits which appear to be before 1980 
although their author date and commit date are in 2009 or 2010 or 2011.

Example to reproduce:

git clone git@github.com:LibreOffice/core.git libreoffice
cd libreoffice
git log --no-merges --before="1980-01-01T00:00:00+0000" 
--format=%H,%ct,%ci,%ad

All the resulting commits have an author date and commit date in 2009 or 
2010 or 2011, though.

This also appears when you order the commits by date:

git log --no-merges --date-order --format=%H,%ct,%ci,%ad

If you search for commit d3b03514dde317473db0d247f21405b5db6a727e in the 
resulting output, you can see that this commit is placed earlier in the 
list than the commits from 2008 although its author date and commit date 
are from 2011. And there are many more commits of this sort between 2009 
and 2011 which are placed out of order, interpreted to be earlier than 
every other commit.

I already searched for broken timestamps in these commits and printed 
the timestamp in various different formats, but I could not spot 
anything dubious there. So, why does git log think that these commits 
have an earlier timestamp than they actually have?

Thanks for your efforts!

[System Info]
git version:
git version 2.30.2 (but I have also tried it with git version 2.40.0 
with no difference)
cpu: x86_64
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.0-21-amd64 #1 SMP Debian 5.10.162-1 (2023-01-21) x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash

Best,
Thomas
