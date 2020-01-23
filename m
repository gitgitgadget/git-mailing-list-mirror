Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045D6C35240
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 23:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4C320684
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 23:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgAWXSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:18:15 -0500
Received: from a3.inai.de ([88.198.85.195]:44372 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbgAWXSP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 18:18:15 -0500
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jan 2020 18:18:14 EST
Received: by a3.inai.de (Postfix, from userid 25121)
        id 64DC058742910; Fri, 24 Jan 2020 00:12:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 6447F60D40699;
        Fri, 24 Jan 2020 00:12:54 +0100 (CET)
Date:   Fri, 24 Jan 2020 00:12:54 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     git@vger.kernel.org
cc:     jengelh@inai.de
Subject: Misrendering of git 2.24 log --graph
Message-ID: <nycvar.YFH.7.76.2001232353220.26179@n3.vanv.qr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings.

I have observed git 2.24 outputting a garbage graph element for a 
particular history. The issue does not appear in 2.25, but the 
underlying bug may still be in there; it is just that _this particular 
history_ does not expose it anymore due to the new, more compact tree 
rendering that 2.25 seems to be shipping.

Reproducer:

$ git clone git://github.com/jengelh/git-issue-20200123 gi
$ cd gi; git log --oneline --graph --all --topo-order | head -n 74
[...]
| | * |   ba85ad93c Merge branch 'kc-8.7.x'
| | |\ \  
| |/ / /  
| | | _   
| | * 79106b731 doc: update 8.7.x news

See that underscore there in line 73. The connection between commit 
610d621dd and its parent 79106b731 is not properly connected (visually). 
I think this should have been [diff notation follows]

-| | | _   
+| | | /
+| | |/
 | | * 79106b731 doc: update 8.7.x news

or something along those lines (pun intended).
