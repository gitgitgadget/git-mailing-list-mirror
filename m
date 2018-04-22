Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C751F424
	for <e@80x24.org>; Sun, 22 Apr 2018 17:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeDVRmF (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 13:42:05 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.184]:25490 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751564AbeDVRmE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Apr 2018 13:42:04 -0400
X-Greylist: delayed 1431 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Apr 2018 13:42:04 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id A718F34A72C
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 12:18:12 -0500 (CDT)
Received: from gator3035.hostgator.com ([50.87.144.38])
        by cmsmtp with SMTP
        id AIcufSqSBWCOCAIcufNue5; Sun, 22 Apr 2018 12:18:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=schemaczar.com; s=default; h=To:Cc:Date:Message-Id:Subject:Mime-Version:
        Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S7hQuqUdOpHh24jdztPBYs4WABKYUtIdPr3bCRP4oF4=; b=iy59OHIRHOL6icjxNDUaTzcIVJ
        9Pt79xSl2/Pn4MWJQoZAEQFpnwELReLJtAleD7Ys3Hnk5r7PzB+UNNnFj769Z02PVXcJs/rFdi1vX
        ILJFIXrOQ9su/J7vGpe8zbiT7laoR9nhNqA/jNLHyokUPlfPNsd1+dF1irsVPNqJfK30=;
Received: from pool-100-0-63-86.bstnma.fios.verizon.net ([100.0.63.86]:51050 helo=awolfe.local)
        by gator3035.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <andrew@schemaczar.com>)
        id 1fAIct-002BYL-Se; Sun, 22 Apr 2018 12:18:11 -0500
From:   Andrew Wolfe <andrew@schemaczar.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Git enhancement request - checkout (clone) set modified dates to
 commit date
Message-Id: <585A3A2E-7DA6-4718-BF85-2D17AAAF3EF5@schemaczar.com>
Date:   Sun, 22 Apr 2018 13:18:10 -0400
Cc:     Andrew D Wolfe Jr <andrew@schemaczar.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.6.18)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3035.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - schemaczar.com
X-BWhitelist: no
X-Source-IP: 100.0.63.86
X-Source-L: No
X-Exim-ID: 1fAIct-002BYL-Se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-100-0-63-86.bstnma.fios.verizon.net (awolfe.local) [100.0.63.86]:51050
X-Source-Auth: andrew@schemaczar.com
X-Email-Count: 1
X-Source-Cap: b3VybGlnaHQ7b3VybGlnaHQ7Z2F0b3IzMDM1Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

there are several timestamps in the lifecycle of a modification to a =
file in Git:

	=E2=80=A2 file write timestamp
	=E2=80=A2 git add timestamp
	=E2=80=A2 git commit timestamp
	=E2=80=A2 git push timestamp
	=E2=80=A2 git merge timestamp
	=E2=80=A2 git checkout timestamp

Right now when I check out/clone a repository, all the files have the =
checkout timestamp as

	=E2=80=A2 ctime - creation time for the file
	=E2=80=A2 mtime - modification time for the file
	=E2=80=A2 atime - las access time for the file

Not only does this force more work for timestamp-based build programs, =
it also deprives me, as a developer, of a visual 'file blame' that could =
be very useful in spotting changes without having to do git log over and =
over.

I would like to propose that the checkout process set the create and =
modification times of a file to the timestamp at which a file was =
committed.

When repository servers have different clocks - which is normal - each =
clone/merge/push should record the time offset.  Each timestamp on each =
commit should be corrected to the repository's specific time, and that =
should be a marking on the history.

Sincere regards,

Andrew Wolfe


