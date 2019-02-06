Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7FB1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 22:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfBFWkB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 17:40:01 -0500
Received: from forward101p.mail.yandex.net ([77.88.28.101]:48646 "EHLO
        forward101p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfBFWkB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Feb 2019 17:40:01 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2019 17:40:00 EST
Received: from mxback5j.mail.yandex.net (mxback5j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10e])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id 97F443280EE4
        for <git@vger.kernel.org>; Thu,  7 Feb 2019 01:33:24 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback5j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id AE8mblLSi8-XOduGADR;
        Thu, 07 Feb 2019 01:33:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narod.ru; s=mail; t=1549492404;
        bh=enM7DYJj/NojNw7oX7rHFZG1voXuYk33aoR5ZupR1Yc=;
        h=To:From:Subject:Message-ID:Date;
        b=hY8frrw2OZqpUCQjRk8vuj27wQJlVMc/lrC5sVROVfcDU6eefrCovxBr1yedsw4a8
         tL+cJA1hSiw3hlkFIyyHcX5n+6oRDruxcIyxm1PSFMDJ6LrZWXbNZukglzKPv9cQ+Y
         DosKbTtOEN8Msz8gbwZEj5Heuq8GsyLPjfrveOBQ=
Authentication-Results: mxback5j.mail.yandex.net; dkim=pass header.i=@narod.ru
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id NnPNeot5gA-XNciVTSc;
        Thu, 07 Feb 2019 01:33:23 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
To:     git@vger.kernel.org
From:   Victor Porton <porton@narod.ru>
Subject: Proposal: Output should push to different servers in parallel
Message-ID: <173ed6e2-7f33-62a0-e1bd-f4663e68490e@narod.ru>
Date:   Thu, 7 Feb 2019 00:33:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I experienced a slowdown in Git pushing when I push to more than one server.

I propose:

Run push to several servers in parallel.

Not to mix the output, nevertheless serialize the output, that is for 
example cache the output of the second server push and start to output 
it immediately after the first server push is finished.

This approach combines the advantages of the current way (I suppose it 
is so) to serialize pushes: first push to the first server, then to the 
second, etc. and of my idea to push in parallel.

I think the best way would be use multithreading, but multiprocessing 
would be a good quick solution.

