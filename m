Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F22C1FF76
	for <e@80x24.org>; Thu, 15 Dec 2016 08:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757654AbcLOIY1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 15 Dec 2016 03:24:27 -0500
Received: from mail1.bottomline.com ([64.140.254.101]:10935 "EHLO
        mail1.bottomline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757548AbcLOIY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 03:24:26 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Dec 2016 03:24:26 EST
Received: from US02VWMX0002.us-bottomline.root.bottomline.com (unknown [10.70.8.182]) by mail1.bottomline.com with smtp
        (TLS: TLSv1/SSLv3,256bits,AES256-SHA)
         id 312d_1c87_3269bacd_6bec_460f_95e2_a8fdf755b69e;
        Thu, 15 Dec 2016 03:12:50 -0500
Received: from CH02VWMX0001.us-bottomline.root.bottomline.com (10.70.40.25) by
 US02VWMX0002.us-bottomline.root.bottomline.com (10.70.8.182) with Microsoft
 SMTP Server (TLS) id 14.3.224.2; Thu, 15 Dec 2016 03:13:36 -0500
Received: from CH02VWMX0001.us-bottomline.root.bottomline.com ([::1]) by
 CH02VWMX0001.us-bottomline.root.bottomline.com ([::1]) with mapi id
 14.03.0224.002; Thu, 15 Dec 2016 09:12:48 +0100
From:   "Delanoe, Yann" <YDelanoe@bottomline.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Cherry-pick applied X times
Thread-Topic: Cherry-pick applied X times
Thread-Index: AdJWqpfEbPiEngfAQGyYtdDbqthvFw==
Date:   Thu, 15 Dec 2016 08:12:47 +0000
Message-ID: <86615A36E8C3764D961288367F120A475E5C0DE9@CH02VWMX0001.us-bottomline.root.bottomline.com>
Accept-Language: fr-FR, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.122.1.9]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community, 
 
I'm new to GIT and responsible of a project to migrate our SVN repo to GIT.
I've made the migration with the git-svn tools ... it was long, but everything seems fine ; source code is correct and all its history is there.
 
It happen with our delivery workflow that we will have to use cherry-picks to prepare our patches, so I made some test on it.
 
During those tests I saw a strange behaviour: I tried to cherry-pick onto a release branch a commit from the master that had been previously already merged onto this branch with SVN. GIT did not detect it and added the code a second time in the source file modified. I supposed this was du the fact the first merge had been made with SVN. I tried to cherry pick the same commit again ... and GIT add one more time the code of the commit. It appears I could cherry-pick this commit X times with GIT, and each time he added the code again.
 
I looked in SVN, the merge property of the first commit from master to the release branch is ok.
Our SVN repo has more than 22K revisions
 
I found out that some other commits had the same behaviour.
 
Is there a direction onto which I should investigate to determine where the problem comes from ?
 

Here is an example of the multiple cherry pick.

Branches:
 
> git branch
  master
* release/15.0.0
  release/15.3.0
 
Check commit already exist on release (cb8c480) and get master hash (bee110c):
 
> git log --oneline |grep GTX-20264
cb8c480 GTX-20264 : Missing end of string in field hostReference for custom network ack
> git checkout master
Switched to branch 'master'
Your branch is up-to-date with 'origin/master'.
> git log --oneline |grep GTX-20264
bee110c GTX-20264 : Missing end of string in field hostReference for custom network ack
> git checkout release/15.0.0
Switched to branch 'release/15.0.0'
Your branch is up-to-date with 'origin/release/15.0.0'.
 
 
And now I cherry-pick the master commit onto the release/15.0.0 a multiple of times:

> git cherry-pick bee110c
[release/15.0.0 e8bfc33] GTX-20264 : Missing end of string in field hostReference for custom network ack
Author: Yann Delanoe <ydelanoe@bottomline.com>
1 file changed, 3 insertions(+)
> git cherry-pick bee110c
[release/15.0.0 2b98c8d] GTX-20264 : Missing end of string in field hostReference for custom network ack
Author: Yann Delanoe <ydelanoe@bottomline.com>
1 file changed, 3 insertions(+)
> git cherry-pick bee110c
[release/15.0.0 820cd8a] GTX-20264 : Missing end of string in field hostReference for custom network ack
Author: Yann Delanoe <ydelanoe@bottomline.com>
1 file changed, 3 insertions(+)
 

 
Best regards
Yann DELANOE - Product engineer - Bottomline technologies
