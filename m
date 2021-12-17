Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC5C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 10:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhLQKt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 05:49:56 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:36950 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhLQKt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 05:49:56 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 05:49:55 EST
Received: from [91.113.179.170] (helo=[192.168.92.29])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1myAj5-0004YG-I8
        for git@vger.kernel.org; Fri, 17 Dec 2021 11:44:35 +0100
Message-ID: <d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com>
Date:   Fri, 17 Dec 2021 11:44:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Should update-index --refresh force writing the index in case of racy
 timestamps?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For one of my Git-LFS test repositories, switching between branches 
quite often results in lots of racy index timestamps. Subsequent calls 
to "git update-index --refresh" or "git status" will invoke the "lfs" 
filter over and over again, just to figure out that all entries are 
still up-to-date. Hence, the index will never be rewritten and racy 
timestamps will remain.

To break out of this state, it seems favorable to write the index if any 
racy timestamp is detected. We will be able to provide a patch if this 
change sounds reasonable.

-Marc
