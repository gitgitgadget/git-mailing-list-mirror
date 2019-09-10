Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E553B1F463
	for <e@80x24.org>; Tue, 10 Sep 2019 14:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbfIJOV5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 10:21:57 -0400
Received: from blade-b3-vm-relay.servers.aueb.gr ([195.251.255.106]:48360 "EHLO
        blade-b3-vm-relay.servers.aueb.gr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730779AbfIJOV4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Sep 2019 10:21:56 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2019 10:21:55 EDT
Received: from blade-a1-vm-smtp.servers.aueb.gr (blade-a1-vm-smtp.servers.aueb.gr [195.251.255.217])
        by blade-b3-vm-relay.servers.aueb.gr (Postfix) with ESMTP id 42588806
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 17:14:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aueb.gr; s=201901;
        t=1568124894; bh=fdKU3QR0GtVdSyOS1iiTmjIv/SAbQauCudQvWDch3hk=;
        h=To:From:Subject:Date:From;
        b=AVJmtM7UrWk+Myt1dJzGxGnCIMQ/i+SlzYXyIeiFkRWl7Wpw8dTqn1rYcpUlWBimF
         iq7UAyjU6b3l+19DxHxcyaeZ5HhuYs1DMH0NDx8uUhEqKW578YSmwgROVdlfOrVDl2
         lVrbOkUPGrAXeHfJlOBsU89A5EMtQ+zCLvMptjbeNriAP4SJWeRJlYXmGAB09/beVE
         2h+vszq0bblbXHcqzPdPdhK8KZLYSFJdu3b/1c9dO73pSwb6lCYWT4gnlMiKEVXzuR
         9aXvsFI2i7069d1SeexljtaLrSKWl40jEXTmHaxPmKWMNStmlosTSXDXuMnvcdA1FU
         crhs8LVS/0ijA==
Received: from [172.17.186.49] (unknown [147.67.241.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dds)
        by blade-a1-vm-smtp.servers.aueb.gr (Postfix) with ESMTPSA id 1541A606
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 17:14:53 +0300 (EEST)
To:     git@vger.kernel.org
From:   Diomidis Spinellis <dds@aueb.gr>
Subject: Patching Git to handle dates before the Unix epoch
Phone:  +30 210 8203621
Message-ID: <c12e3505-7a02-3eaf-7d71-57a3b4df28d1@aueb.gr>
Date:   Tue, 10 Sep 2019 17:14:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: el
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As people use Git to create synthetic commits of code written in the 
past [1,2] it becomes important to handle dates before the Unix epoch 
(1/1/1970).  I see that modern C libraries, Unix kernels, and tools can 
handle such dates.  However Git seems to mishandle such dates in several 
places, such as in date.c [3,4].  I'm planning to work on a fix, but 
before I embark on this I have a few questions.

- Do you see any reasons that may prevent the acceptance of such a patch?
- Can you think of any non-obvious issues (e.g. backward compatibility, 
switch to the Gregorian calendar) I should be aware of?
- Should I submit changes as a bug fix on the maint branch or as a new 
feature on master?

[1] https://github.com/dspinellis/unix-history-repo (original dates)
[2] https://github.com/chrislgarry/Apollo-11 (wrong dates)
[3] https://github.com/git/git/blob/master/date.c#L21
[4] https://github.com/git/git/blob/master/date.c#L776

Diomidis Spinellis - https://www.spinellis.gr
