Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E365C1F609
	for <e@80x24.org>; Thu, 13 Jun 2019 17:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfFMRdn (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:33:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfFMRdn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:33:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1BCAD61836; Thu, 13 Jun 2019 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560447222;
        bh=hUArA1rPbND0zEO7qA0z1Tilw3w682aI2G9Hk3d3DE0=;
        h=From:Subject:Date:To:From;
        b=g7Z8C6HLs94VPIBOrYI4xELRup9u1oDJwSfhuCepX0tPoRt/PsFoa2iTFcPnvkPej
         lL9zoSC5Jjr+kllNu5pRBSZk4Smko+FxvEwTQ4JBa+I7GMpHMTeV0ohVxiNBJ4QQSA
         tJjasO2L1SFe34Ucis87z1k5HwfwFxe3yM1CoG5g=
Received: from nasserg1-mac.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nasser@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4EE7261788
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560447221;
        bh=hUArA1rPbND0zEO7qA0z1Tilw3w682aI2G9Hk3d3DE0=;
        h=From:Subject:Date:To:From;
        b=ZYAg5pOPQV7XEJ9Vz2gBLRxRzkKuJMFs98uFSRfxb6N0Jihvn4VY3N22+kgN3fRhq
         YshSzNemO78+imBJIlTduOtdbP3baGm4steHXGs6vfiRaTK5TW0qWYtlYts3CjWYqI
         LYk16Tt/ApJCpPkwL9X09DtVDwDhpPooKWdnf/aU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EE7261788
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=nasser@codeaurora.org
From:   Nasser Grainawi <nasser@codeaurora.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: git receive-pack deletes refs one at a time?
Message-Id: <E203B539-3481-435F-8D08-9C405DF42923@codeaurora.org>
Date:   Thu, 13 Jun 2019 11:33:40 -0600
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a situation where I need to delete 100k+ refs on 15+ separate =
hosts/disks. This setup is using Gerrit replication, so I can trigger it =
all on one host and it will push the deletes to the rest (all running =
git-daemon v2.18.0 with receive-pack enabled). All the refs being =
deleted on the receiving ends are packed.

What I see is the packed-refs file getting locked/updated over and over =
for each ref. I had assumed it would do something more like 'update-ref =
--stdin' and do a bulk removal of refs. Am I seeing the correct =
behavior? If yes, is there a specific reason it works this way or is =
"bulk delete through push" just a feature that hasn't been implemented =
yet?

Thanks,
Nasser

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora =
Forum,=20
a Linux Foundation Collaborative Project

