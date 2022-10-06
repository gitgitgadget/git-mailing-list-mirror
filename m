Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F7DC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 15:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiJFPz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiJFPzx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 11:55:53 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217939E2E6
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 08:55:51 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ogTDx-0003ra-7v;
        Thu, 06 Oct 2022 16:55:49 +0100
Message-ID: <037901f1-1649-1485-a853-9783b9d43b31@iee.email>
Date:   Thu, 6 Oct 2022 16:55:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Idea: Git Bundle V3 capability @HEAD=ref/heads/<name>
Content-Language: en-GB
References: <8d88ba68-4585-634b-1fe0-61c3465fa682@iee.email>
To:     Git List <git@vger.kernel.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andreas Krey <a.krey@gmx.de>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <8d88ba68-4585-634b-1fe0-61c3465fa682@iee.email>
X-Forwarded-Message-Id: <8d88ba68-4585-634b-1fe0-61c3465fa682@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In brian's recent work on V3 bundles [1, et al] I spotted a potential
idea for resolving the long standing problem that the bundle code may
need to guess at which ref HEAD was pointed [2, et al] at when there
were two branches that pointed at the same HEAD oid.

The basic idea is to utilise the new 'capabilities' field to pass the
particular ref that is HEAD using a 'HEAD' capability
i.e. sending the capability    @HEAD=ref/heads/<name>

It's inclusion in the header wouldn't change the pack in any way, and
would resolve the guessing problem.

It would be optional for those that don't want to explictly export the
HEAD ref's name, and could be also protected by requiring that HEAD is
listed in the pack, and maybe that the ref it points to is also
included, and maybe further that there is an alternate ambigous ref listed.

The idea of the HEAD capability could also be extended to the transport
layer, as well as this bundle sneaker-net layer.

Are there reasons why it couldn't work before I put it on my list of ideas?

Philip

[1] see
https://lore.kernel.org/git/20200726195424.626969-32-sandals@crustytoothpaste.net/
[PATCH v4 31/39] bundle: add new version for use with SHA-256

[2] https://lore.kernel.org/git/20130906155204.GE12966@inner.h.apk.li/

