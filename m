Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B57FC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 03:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61DE24679
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 03:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="p/ryUCq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLPDuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:50:12 -0500
Received: from mr85p00im-zteg06021901.me.com ([17.58.23.194]:46219 "EHLO
        mr85p00im-zteg06021901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbfLPDuL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Dec 2019 22:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1576468210;
        bh=fV5V+RZcXZxN++VFfdkOfxThzsQHQdrM77JEK7bpsFU=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=p/ryUCq387G5D74Uzo2vu2jxHn/MLGlESW/Jn2oUbCtd6obcAXC1NoU5PCEy2Wnf5
         7a1ZLzMJ86ctfn1WSJk+fJMbnFEUxTh+Votp3f92yIWqzBoHw2nIh7sANeVNg7XpMp
         0lglwvF1s6oShq16EJkycmaoC1IwiRq2C8K/AxWYYJ0udieNchmIpgaU7ULVOWKdJW
         r8bxYhE2TROjDrICDVRtZRjwRkHb8FHxwkqjA/ZGSjBn8+nf9UIAmxBc2cYTOtsmG2
         yPsbVUj8nCOi06RcRw3EjixilPbRDqSoJQvyTBbqcDoxDv6VNyUwTDDYRsx+j/HBVt
         E6H3JI2iAeDaQ==
Received: from [10.100.5.246] (unknown [49.255.65.138])
        by mr85p00im-zteg06021901.me.com (Postfix) with ESMTPSA id 9FE0A720C0F;
        Mon, 16 Dec 2019 03:50:09 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <5C8CA727-370E-4CEE-BBF9-F336C5921D98@icloud.com>
Date:   Mon, 16 Dec 2019 14:50:04 +1100
Cc:     "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "marc@msys.ch" <marc@msys.ch>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F323B43-44AF-44C0-87DC-5A5C7C17FEB1@icloud.com>
References: <nycvar.QRO.7.76.6.1912091615200.31080@tvgsbejvaqbjf.bet>
 <7E95BE86-BD96-482F-9ECA-DBDD9C10D114@msys.ch>
 <nycvar.QRO.7.76.6.1912092037540.31080@tvgsbejvaqbjf.bet>
 <D99ED706-EC49-4A52-8186-5C9B0B5BC744@icloud.com>
 <038c72f0349174bb92e1dd9c3b38f02543ba1d95.camel@swri.org>
 <5C8CA727-370E-4CEE-BBF9-F336C5921D98@icloud.com>
To:     "Strain, Roger L." <roger.strain@swri.org>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-16_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=820 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912160032
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have put together a patch (currently testing on GitGitGadget) that at =
least fixes things for my repo - Commits from before subtree add are =
recognized as a dead end, so it no longer runs out of stack space while =
finding its way to a root commit.

I think the issue Marc ran into is a bit more complex in that the =
recursion eventually producing the wrong result suggests that correct =
identification of mainline commits remains an issue. While I have some =
ideas on how to improve that, it=E2=80=99s probably best handled =
separately.

However, there is a decent chance that excluding a large number of known =
irrelevant commits will catch the problematic ones in that scenario - =
and should match the previous behavior of treating the problem commits =
as initial.

