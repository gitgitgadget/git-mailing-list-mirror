Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658C91F453
	for <e@80x24.org>; Mon, 24 Sep 2018 22:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeIYEJf (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 00:09:35 -0400
Received: from mail.onyx.syn-alias.com ([206.152.134.66]:6547 "EHLO
        smtp.centurylink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeIYEJe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 00:09:34 -0400
X-Greylist: delayed 1204 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Sep 2018 00:09:33 EDT
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.2 cv=PuPRVEE3 c=1 sm=1 tr=0 a=yq6KBQdhjYNuzzW9wyfViA==:117 a=yq6KBQdhjYNuzzW9wyfViA==:17 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=JBFolyDoGHsA:10 a=s5tG97AM4P0A:10 a=Y4RQVEFPAAAA:8 a=q0PEjVARhc1itZAI5jEA:9 a=QEXdDO2ut3YA:10 a=JlNcNiPnxhPThaunNiio:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: aGlnaGxhYkBxLmNvbQ==
Authentication-Results:  smtp03.onyx.dfw.sync.lan smtp.user=highlab@q.com; auth=pass (LOGIN)
Received: from [70.59.37.62] ([70.59.37.62:6267] helo=bifrost)
        by smtp.centurylink.net (envelope-from <seb@highlab.com>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPSA (cipher=AES128-GCM-SHA256) 
        id CE/8A-18885-9EA59AB5; Mon, 24 Sep 2018 17:45:13 -0400
Received: from [208.185.63.8] (helo=[10.116.4.235])
        by bifrost with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <seb@highlab.com>)
        id 1g4YfI-0007ar-M3
        for git@vger.kernel.org; Mon, 24 Sep 2018 15:45:13 -0600
To:     git@vger.kernel.org
From:   Sebastian Kuzminsky <seb@highlab.com>
Message-ID: <fd340f7b-61c0-2661-bdca-c239e51bc464@highlab.com>
Date:   Mon, 24 Sep 2018 15:45:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 208.185.63.8
X-SA-Exim-Mail-From: seb@highlab.com
Subject: bug in 'git describe'?
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on bifrost)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I've run in to a bug in 'git describe' (reproduced with git 
2.11.0, 2.16.1, and 2.19.0.221.g150f307af).

I've got two tiny git repos whose commit graphs are identical, but where 
'git describe' gives different results.

>     *   merge 1.1 into 2.0  (HEAD -> release-2.0)
>     |\
>     | *   merge boo into 1.1  (tag: release/1.1.1, release-1.1)
>     | |\
>     | | * dummy commit  (boo)
>     | * | dummy commit  (tag: release/1.1.0)
>     * | |   merge feature into 2.0
>     |\ \ \
>     | * | | dummy commit  (feature)
>     |/ / /
>     * | | dummy commit  (tag: release/2.0.1)
>     * | | dummy commit  (tag: release/2.0.0)
>     |/ /
>     * | dummy commit  (release-1.0)
>     |/
>     * dummy commit  (tag: release/1.0.0)

The tag 'release/1.0.0' is the first commit in history.

The histories differ only in the timestamps of the commits (and thus the 
SHAs of the commit objects).

Good repo: release/2.0.1-6-gbc33a04
Bad repo: release/2.0.1-8-g2c0a20c

Details, including full copies of both repos, here:

http://highlab.com/~seb/git-describe-bug/


-- 
Sebastian Kuzminsky
