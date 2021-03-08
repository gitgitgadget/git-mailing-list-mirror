Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEDFC433E6
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD9865191
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhCHVb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 16:31:28 -0500
Received: from sender4-op-o18.zoho.com ([136.143.188.18]:17889 "EHLO
        sender4-op-o18.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhCHVa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 16:30:59 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Mar 2021 16:30:59 EST
ARC-Seal: i=1; a=rsa-sha256; t=1615238151; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KO1f/qn4Jmy7AHCFcuPks8sevBC5jT7XEH2F1nkxVGB1nLQOjHviDtGgtN+w3tsibgp5/wtuo7nvIU6WXlgqNrqXg+rB+wYgZA5XsbI0x3WISTG8mY5rBGp+p4z/xxv3cLz7yL2CUu8IC2ZXkB2QFwdzbjAn88woaQJHS5GZxgM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1615238151; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=jzweo4A40UPGlwoqan5nFzEjOcP43Swj4OZflI9ZEfc=; 
        b=Hx+b3AnbT87yNcN56Va2WY52McuJwwSjWqg6OYUi7oCIo1OHuB8AK1B4WqOXL8B1C2Fx7UO2BlV1Vmqr3Ez4BHUvLSbiF0OmG9nsHf2vXkyYorBLZ3lWAMfUj9V+RfRqNVkJKg8hAl3fSJ8WEmSGJ53b/kXFF2x8U4s+I7JrwSk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=monospace.sh;
        spf=pass  smtp.mailfrom=anthony@monospace.sh;
        dmarc=pass header.from=<anthony@monospace.sh> header.from=<anthony@monospace.sh>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=pdk; d=monospace.sh; 
  h=date:from:to:message-id:in-reply-to:subject:mime-version:content-type:user-agent; 
  b=O88XPwUDx+flzATJSo6+HKE/jyfEX8kwESQ2CFYbNqdxw3pOLz5hmru3wtRV66pQonuIsMQRzCEZ
    Bpz6LW0gy90DDmyvE1tgf83+UsKlJjjJk9A7mnx8akJheWABgNW6P7L09G6wDojXLxCU8kl1n4+o
    +eTCSAtSwmL7vSZgCVU=  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1615238151;
        s=mdk; d=monospace.sh; i=anthony@monospace.sh;
        h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=jzweo4A40UPGlwoqan5nFzEjOcP43Swj4OZflI9ZEfc=;
        b=mjrGfm0UmhLJBccAaHGAJcJtOKYZ6HiHA40KQO+PJbPDPMbQmqvkHy9ACVxKivpk
        ScTr1Jc1l0ys0WN8UmOeelieUGjJGZW6LhJomg6ExpJ66r92DL3j71q5DiTnHt6dMl9
        4oPv2lCpn8PJES7S7SWo/6AF114jL2b6uGc58ciU=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1615238148863160.34575115860002; Mon, 8 Mar 2021 13:15:48 -0800 (PST)
Date:   Mon, 08 Mar 2021 21:15:48 +0000
From:   Anthony Muller <anthony@monospace.sh>
To:     "git" <git@vger.kernel.org>
Message-ID: <17813b232e9.e48d03c3862272.7793967418558853913@monospace.sh>
In-Reply-To: 
Subject: Performance of "git gc..." is extremely bad in some cases
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

git clone https://github.com/notracking/hosts-blocklists
cd hosts-blocklists
git reflog expire --all --expire=now && git gc --prune=now --aggressive


What did you expect to happen? (Expected behavior)

Running gc on a ~300 MB repo should not take 1 hour 55 minutes when
running gc on a 2.6 GB repo (LLVM) only takes 24 minutes.


What happened instead? (Actual behavior)

Command took 1h 55m to complete on a ~300MB repo and used enough
resources that the machine is almost unusable.


What's different between what you expected and what actually happened?

Compression stage uses the majority of the resources and time. Compression
itself, when compared to something like zlib or lzma, should not take very long.
While more may be happening as objects are compressed, the amount of time
gc takes to compress the objects and the resources it consumed are both
unreasonable.

Memory: RSS = 3451152 KB (3.29 GB), VSZ = 29286272 KB (27.92 GB)
Time: 12902.83s user 8995.41s system 315% cpu 1:55:36.73 total

I've seen this issue with a number of repos and size of the repo does not
determine if this happens. LLVM @ 2.6 GB worked flawlessly, a 900 MB
repo never finished, this 300 MB repo takes forever, and if you test something
like chromium git will just crash.


[System Info]
hardware: 2.9Ghz Quad Core i7
git version:
git version 2.30.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Jan 12 22:13:05 PST 2021; root:xnu-6153.141.16~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.28)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/zsh

