Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE01DC282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BB320721
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 18:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgAIShV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:37:21 -0500
Received: from smtpq6.tb.mail.iss.as9143.net ([212.54.42.169]:53964 "EHLO
        smtpq6.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728037AbgAIShV (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jan 2020 13:37:21 -0500
X-Greylist: delayed 998 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 13:37:20 EST
Received: from [212.54.42.115] (helo=lsmtp1.tb.mail.iss.as9143.net)
        by smtpq6.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1ipcQC-0007yY-LR
        for git@vger.kernel.org; Thu, 09 Jan 2020 19:20:40 +0100
Received: from 92-109-146-195.cable.dynamic.v4.ziggo.nl ([92.109.146.195] helo=mail9.alinoe.com)
        by lsmtp1.tb.mail.iss.as9143.net with esmtp (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1ipcQC-00080Z-Hg
        for git@vger.kernel.org; Thu, 09 Jan 2020 19:20:40 +0100
Received: from carlo by mail9.alinoe.com with local (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1ipcQC-0000hD-91
        for git@vger.kernel.org; Thu, 09 Jan 2020 19:20:40 +0100
Date:   Thu, 9 Jan 2020 19:20:40 +0100
From:   Carlo Wood <carlo@alinoe.com>
To:     git@vger.kernel.org
Subject: git submodule update  strange output behavior.
Message-ID: <20200109192040.46aaa01e@hikaru>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: carlo@alinoe.com
X-SA-Exim-Scanned: No (on mail9.alinoe.com); SAEximRunCond expanded to false
X-SourceIP: 92.109.146.195
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=M6j51B4s c=1 sm=1 tr=0 a=at3gEZHPcpTZPMkiLtqVSg==:17 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10 a=BjFOTwK7AAAA:8 a=trHjET0FImasKFl3Dr0A:9 a=CjuIK1q_8ugA:10 a=N3Up1mgHhB-0MyeZKEz1:22 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


In a project containing submodules, one of the submodules
contains a submodule itself, which in turn also contains
a submodule.

Overview:

project/foobar  [submodule]
project/cwm4    [submodule]
project/evio    [submodule]
project/evio/protocol/matrixssl       [submodule]
project/evio/protocol/matrixssl/cwm4  [submodule]

('protocol' is a normal subdirectory)

Running (with or without the --quiet),

$ git submodule --quiet update --init --recursive --remote
Fetching submodule protocol/matrixssl
Fetching submodule protocol/matrixssl/cwm4
Fetching submodule cwm4

This is odd (a bug imho) because

1) it seems to only print this fetching information for submodules inside submodules,
not for the top-level submodules.
2) it even prints this when using --quiet
3) it prints this every time (also when there is nothing more to fetch).

-- 
Carlo Wood <carlo@alinoe.com>
