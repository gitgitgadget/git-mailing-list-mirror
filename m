Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB3DC004D4
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 18:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjAUSIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 13:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjAUSIH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 13:08:07 -0500
Received: from qproxy1-pub.mail.unifiedlayer.com (qproxy1-pub.mail.unifiedlayer.com [173.254.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E919747
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 10:07:52 -0800 (PST)
Received: from outbound-ss-820.bluehost.com (outbound-ss-820.bluehost.com [69.89.24.241])
        by qproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id D68F980334C6
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 18:07:51 +0000 (UTC)
Received: from cmgw14.mail.unifiedlayer.com (unknown [10.0.90.129])
        by progateway2.mail.pro1.eigbox.com (Postfix) with ESMTP id A4F9110048544
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 18:07:50 +0000 (UTC)
Received: from just2054.justhost.com ([173.254.29.24])
        by cmsmtp with ESMTP
        id JIHOpYMoTwVzzJIHOpvlaW; Sat, 21 Jan 2023 18:07:50 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=I7qg+Psg c=1 sm=1 tr=0 ts=63cc29f6
 a=HRuQh6oH0/DWLKy39IFNtg==:117 a=HRuQh6oH0/DWLKy39IFNtg==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=RvmDmJFTN0MA:10:nop_rcvd_month_year
 a=O2wJcz4oqzQA:10:endurance_base64_authed_username_1 a=sSd-RUsyr8HHd-qL7AkA:9
 a=CjuIK1q_8ugA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=laynes.org;
        s=default; h=Content-Type:MIME-Version:Message-Id:To:Subject:From:Date:Sender
        :Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eZznZwS6uI9uyqvEleBelJYlwk0V8d9/80XkXHHC7fI=; b=WcFuPyHnGRrULokm/SNGcdwDdj
        L88EAp2bxBNXZAgMmgzInLnzsn4H2aSHB1DHJiWyjJ6ltNRUXLIWVBoqXO7vZcb5ULB8GkkP+/TbH
        dOfmHSQ0J9JoSrXbmw2TeZWTm8ri+7l7JBvoKVTVt2BOtNohnIpTkh9NtgiXd+mX6IFSONQVcbui4
        rHt1rM2ay7OYv7ACH5GzYVcBbTwscOMdKMeTzghnXsAgIUXC+iJbvihITbfFt6PsS2v+AQjWEIgZq
        L+ItbqYFr6Ri3d7JSkCZbhSudd8pn5TVLjjU5AnSvS2H6hvNT1fsbeUBj9c8593R7Gc7cDVr5IryE
        1gr2n48g==;
Received: from [208.104.59.59] (port=9144 helo=[192.168.1.105])
        by just2054.justhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <keith@laynes.org>)
        id 1pJIHO-003Wzh-6q
        for git@vger.kernel.org;
        Sat, 21 Jan 2023 11:07:50 -0700
Date:   Sat, 21 Jan 2023 13:07:37 -0500
From:   Keith Layne <keith@laynes.org>
Subject: [BUG] `git stash` exits without output when lockfile present
To:     git@vger.kernel.org
Message-Id: <P0LUOR.9QAZEXOQT1VT1@laynes.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - just2054.justhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - laynes.org
X-BWhitelist: no
X-Source-IP: 208.104.59.59
X-Source-L: No
X-Exim-ID: 1pJIHO-003Wzh-6q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.105]) [208.104.59.59]:9144
X-Source-Auth: keith@laynes.org
X-Email-Count: 1
X-Source-Cap: bGF5bmVzbzE7bGF5bmVzbzE7anVzdDIwNTQuanVzdGhvc3QuY29t
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

In clean repo root:

$ touch foo
$ touch .git/index.lock
$ git stash

What did you expect to happen? (Expected behavior)

An error message to stderr explaining that .git/index.lock exists, etc.

What happened instead? (Actual behavior)

`git stash` has an exit code of 1, with no output on stdout or stderr.

What's different between what you expected and what actually happened?

I didn't notice at first that the stash failed, and I was briefly 
confused. I guess I've never tried to stash and gotten this error 
before, but whenever I see the "lockfile exists" error I feel like the 
UX is very consistent with other commands. I expected stash to work the 
same way.

I apologize if this is a dupe, I don't know how to search the archives.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.19.16-76051916-generic 
#202210150742~1666053244~22.04~cf07008 SMP PREEMPT_DYNAMIC Tue O x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]



