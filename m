Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A621202AA
	for <e@80x24.org>; Fri,  1 Mar 2019 06:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfCAG0D convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 1 Mar 2019 01:26:03 -0500
Received: from mx-relay68-hz2.antispameurope.com ([94.100.136.168]:46121 "EHLO
        mx-relay68-hz2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbfCAG0D (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 Mar 2019 01:26:03 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Mar 2019 01:26:02 EST
Received: from unknown ([91.229.168.76]) by mx-relay68-hz2.antispameurope.com;
 Fri, 01 Mar 2019 07:19:49 +0100
Received: from bruexc101.brumgt.local (10.251.3.120) by bruexc102.brumgt.local
 (10.251.3.117) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 1 Mar
 2019 07:19:48 +0100
Received: from bruexc101.brumgt.local ([fe80::8192:a565:2dec:8204]) by
 bruexc101.brumgt.local ([fe80::8192:a565:2dec:8204%19]) with mapi id
 15.00.1473.003; Fri, 1 Mar 2019 07:19:48 +0100
From:   "Wendeborn, Jonathan" <Jonathan.Wendeborn@bruker.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: fast-import fails with case sensitive tags due to case insensitive
 lock files
Thread-Topic: fast-import fails with case sensitive tags due to case
 insensitive lock files
Thread-Index: AdTPonIg/9QWZqseSg6y1MSsuJUGaA==
Date:   Fri, 1 Mar 2019 06:19:48 +0000
Message-ID: <ceb9b34681c14d9ab2a33ba909b5ca75@bruexc101.brumgt.local>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.251.3.124]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-cloud-security-sender: jonathan.wendeborn@bruker.com
X-cloud-security-recipient: git@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay68-hz2.antispameurope.com with 0EAF1F44A6C
X-cloud-security-connect: unknown[91.229.168.76], TLS=1, IP=91.229.168.76
X-cloud-security: scantime:.1536
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a problem with fast-import on an NTFS drive: If I try to import tags which are identical apart from their casing a failure due to identical lock file names occurs.

I am running git for windows 2.15.1.2 x64 on a Windows 10 machine (10.0.15063):
$ git --version --build-options
git version 2.15.1.windows.2
built from commit: 5d5baf91824ec7750b103c8b7c4827ffac202feb
sizeof-long: 4
machine: x86_64

MCVE:
 (echo "commit refs/heads/master" && 
 echo "mark :1" &&
 echo "committer me <> 0 +0000" &&
 echo "data 0" &&
 echo "" &&
 echo "tag tag_A" &&
 echo "from :1" &&
 echo "tagger me <> 0 +0000" &&
 echo "data 0" &&
 echo "" &&
 echo "tag tag_a" &&
 echo "from :1" &&
 echo "tagger me <> 0 +0000" &&
 echo "data 0" &&
 echo "") | git fast-import

Instead of having 1 commit with two tags ("tag_A" and "tag_a") I get his error message:
Unpacking objects: 100% (4/4), done.
error: cannot lock ref 'refs/tags/tag_a': Unable to create 'C:/tmp/.git/refs/tags/tag_a.lock': File exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.

Best regards,
Jonathan
