Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738D2C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 21:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B56C20776
	for <git@archiver.kernel.org>; Fri, 29 May 2020 21:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Dv+wEoVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgE2Vdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 17:33:46 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:42175 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2Vdp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 17:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590788025; x=1622324025;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=QSHwIjxgJ9Xa1GFcaq9hNGnbO+0PN+8rWTEjkqhafpw=;
  b=Dv+wEoVDiBiXaK6jo2keCrbTT6Zyrl6SLK+mgOdqSUmmwv9+jZxvinRR
   fqes0bIMm7eT3zbqBjM/XT1bBLIcVBuE07/qT8+/xS2ZY2YdNGcXjFH/z
   2k5HqCQLfZU0vxWuGtr+cfJtWIS6s3YeZZci5LKNQRu00AqEAc6r746l2
   g=;
IronPort-SDR: nVscsCMTYhLgCOvsRHn92u7h0iJy8fq7rRig2LGKfzC6h2GLlxZEE5zFDId4usHvPcaKO1pTxI
 mHkp+5PZYqpw==
X-IronPort-AV: E=Sophos;i="5.73,450,1583193600"; 
   d="scan'208";a="47737482"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 29 May 2020 21:33:43 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 84817A23BA
        for <git@vger.kernel.org>; Fri, 29 May 2020 21:33:42 +0000 (UTC)
Received: from EX13D20UWA002.ant.amazon.com (10.43.160.176) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 May 2020 21:33:42 +0000
Received: from EX13D20UWA002.ant.amazon.com (10.43.160.176) by
 EX13D20UWA002.ant.amazon.com (10.43.160.176) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 May 2020 21:33:41 +0000
Received: from EX13D20UWA002.ant.amazon.com ([10.43.160.176]) by
 EX13D20UWA002.ant.amazon.com ([10.43.160.176]) with mapi id 15.00.1497.006;
 Fri, 29 May 2020 21:33:41 +0000
From:   "Crockett, Eric" <ericcro@amazon.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: add -u stages submodule changes when ignore=all is set
Thread-Topic: add -u stages submodule changes when ignore=all is set
Thread-Index: AdY2ALhSQ/UusDmhREiPtIMsjGB5Lg==
Date:   Fri, 29 May 2020 21:33:41 +0000
Message-ID: <f60c88d8ec2e4efcbbf4f78fd8f87da6@EX13D20UWA002.ant.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.97]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My expectation is that `git add -u` will stage precisely the changes listed=
 in `git status` under "Changes not staged for commit". However, this isn't=
 the case, and it's confusing. In particular, if I set `ignore=3Dall` in .g=
itmodules for a submodule and then make changes to that submodule, `git sta=
tus` does not show the changes (which is what I expect), but `git add -u` s=
till stages the changes to the submodule (not what I expect)! This behavior=
 occurs with git 2.26.2 on Ubuntu 18.04.

This script demonstrates the problem:

#!/bin/bash -ex

echo "Check out a random repository"
git clone https://github.com/crockeea/cryptonite.git
cd cryptonite

echo "Add a random submodule"
git submodule add https://github.com/crockeea/wai.git

echo "Track an older commit in the submodule"
cd wai
git checkout HEAD^
cd ..
git add -A
git commit -m "Added submodule one commit behind its tip-of-master"

echo "What happens if I check out a newer commit in the submodule?"
cd wai
git checkout master
cd ..
git status
echo "git status shows that the submodule is dirty"

echo "We can fix that by adding `ignore=3Dall` to .gitmodules"
echo -e '\tignore =3D all' >> .gitmodules

git status
echo "Now the dirty submodule is not shown"

echo "This looks good; let's stage the changes to .gitmodules"
git add -u

echo "And verify what was staged..."
git status
echo "The dirty submodule was staged! This is not what I expect."
echo "I expect that `git add -u` will only stage the changes to .gitmodules=
"

cd ..
rm -rf cryptonite


Regards,
Eric Crockett
