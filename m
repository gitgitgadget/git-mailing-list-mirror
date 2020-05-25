Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FA2C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 23:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343A42071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 23:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbgEYXey (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 19:34:54 -0400
Received: from smtp-1.his.com ([216.194.195.13]:38858 "EHLO smtp-1.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgEYXey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 19:34:54 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 19:34:53 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.his.com (Postfix) with ESMTP id 03097609B6
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:54 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at smtp-1.his.com
Received: from smtp-1.his.com ([127.0.0.1])
        by localhost (smtp-1.his.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I+kqQ+SIyBVF for <git@vger.kernel.org>;
        Mon, 25 May 2020 19:27:50 -0400 (EDT)
Received: from smtp-nf-201.his.com (smtp-nf-201.his.com [216.194.196.93])
        by smtp-1.his.com (Postfix) with ESMTP id 77D56609B9
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:50 -0400 (EDT)
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id EAD87609C9
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:49 -0400 (EDT)
X-ASG-Debug-ID: 1590449269-061c4120522f2600001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id 4qdDsTN4UP3JEl1d for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:49 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 759C7601CD
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:49 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 4205A177EA1;
        Mon, 25 May 2020 19:27:49 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UEfz_o1ljZGh; Mon, 25 May 2020 19:27:49 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 2BF6C177EAB;
        Mon, 25 May 2020 19:27:49 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3jMU0IFlSEq6; Mon, 25 May 2020 19:27:49 -0400 (EDT)
Received: from wings.local (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 04AE6177EA9;
        Mon, 25 May 2020 19:27:48 -0400 (EDT)
Received: from wings.fios-router.home (localhost [127.0.0.1])
        by wings.local (8.15.2/8.15.2/Debian-10) with ESMTP id 04PNRmhG021164;
        Mon, 25 May 2020 19:27:48 -0400
Received: (from keni@localhost)
        by wings.fios-router.home (8.15.2/8.15.2/Submit) id 04PNRmXd021163;
        Mon, 25 May 2020 19:27:48 -0400
From:   Kenneth Lorber <keni@his.com>
To:     git@vger.kernel.org
Cc:     keni@his.com
Subject: [RFC PATCH v2 4/6] doc: Add collision doc to gitrepository-layout.txt
Date:   Mon, 25 May 2020 19:27:25 -0400
X-ASG-Orig-Subj: [RFC PATCH v2 4/6] doc: Add collision doc to gitrepository-layout.txt
Message-Id: <20200525232727.21096-5-keni@his.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525232727.21096-1-keni@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <20200525232727.21096-1-keni@his.com>
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1590449269
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 575
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82102
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kenneth Lorber <keni@his.com>
---
 Documentation/gitrepository-layout.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 1a2ef4c150..8050e8cc1f 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -292,6 +292,8 @@ worktrees/<id>/config.worktree::
 
 include::technical/repository-version.txt[]
 
+include::technical/namespace-collisions.txt[]
+
 SEE ALSO
 --------
 linkgit:git-init[1],
-- 
2.17.1

