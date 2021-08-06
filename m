Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C931C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 08:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14821604DB
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 08:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhHFIaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:30:03 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:11143 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhHFIaB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 04:30:01 -0400
X-Greylist: delayed 30294 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Aug 2021 04:30:00 EDT
Received: from [94.228.207.202] (helo=[192.168.2.206])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1mBnLU-0007G2-65
        for git@vger.kernel.org; Fri, 06 Aug 2021 02:04:16 +0200
To:     git@vger.kernel.org
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: [BUG] Amending a shallow clone -> orphan branch
Message-ID: <64760969-1ead-2bfb-6f98-1161d385c0ca@syntevo.com>
Date:   Fri, 6 Aug 2021 03:04:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Consider the following steps :

git clone --depth 1 --single-branch --branch master 
https://github.com/git/git
cd git
 >1.txt
git add 1.txt
git commit --amend

This results in an orphaned branch, where a single commit contains 
entire tree.

I understand that this is a bug, because certainly git knew shallow 
commit's parents and could reuse that when amending?
