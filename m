Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29223C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbjEKT7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238946AbjEKT7J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:59:09 -0400
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 12:59:02 PDT
Received: from ms11p00im-hyfv17281201.me.com (ms11p00im-hyfv17281201.me.com [17.58.38.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E78472A2
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1683834757;
        bh=BE0AXuJUu+40iw5HUNkd6I/+HtndRJyqoP0brcKVQp0=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=EOqcFvMVDWGTaZZ9vNpbewl2T3tpDVmzxNUWnowJ5vZbiEetPB21RKzd0yNB5KBFR
         w0kN+FzWL6+zmc4K4QJDCrU9WC7CEKHPnSfVHDd84qJQqpYTRW2u7P1k2yLqPz0KDW
         FEqLezydr/qb1J/ZDy6Hbgok0eHr1ILSVhneW0gUYk5w/X7mSShjdwAFNaS5xFgAee
         xKufrYzmzzRX8AfGz6dFIB4K3CWlt9uCoaRMHn9r3E4FzStkC6enPhm+WH5Q5Dfn2h
         KDasx7sOZz9kZxXMIPgUM+gtbLw8w2qQlPU06YZpegeAVtIH0t5ZJm+foWqjcNcAxV
         4yL/sISwt2Duw==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
        by ms11p00im-hyfv17281201.me.com (Postfix) with ESMTPSA id B8DB5C8040E;
        Thu, 11 May 2023 19:52:36 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: git rebase --root bug
From:   Christopher Fretz <cfretz@icloud.com>
In-Reply-To: <ZF0U6tneDjLfGxf1@nand.local>
Date:   Thu, 11 May 2023 13:52:25 -0600
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F6C462C-58EA-4E49-ACCC-303EFDD3E780@icloud.com>
References: <5E3AD305-8461-496F-B165-7734D400C4A6@icloud.com>
 <288a9935-264b-4dc5-0d63-200c310f326e@gmail.com>
 <ZF0U6tneDjLfGxf1@nand.local>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Proofpoint-ORIG-GUID: vObLh9wxYAcTmJhf2XTE6QL5s1DXKUfA
X-Proofpoint-GUID: vObLh9wxYAcTmJhf2XTE6QL5s1DXKUfA
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 clxscore=1011 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2305110168
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Wouldn't it suffice to consider the squash_onto commit as reachable =
the
> same way we do for `--indexed-objects`?

I think this is essentially what I was imagining, although I don=E2=80=99t=
 know if it=E2=80=99d be considered the cleanest possible approach. I =
guess I just figured that the logic is already structured such that an =
empty commit is created to avoid having to add special handling for =
--root all throughout the rebase operation, and so it=E2=80=99s not such =
a stretch to then automatically consider that commit as always being =
reachable.

Rebase could also be reworked to not depend on the squash_onto in the =
case of a --root rebase, but I imagine this would be a much larger =
change.=
