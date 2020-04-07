Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7CFC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 01:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EC1206C0
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 01:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=1ec5.org header.i=@1ec5.org header.b="XCsq0Mjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDGBzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:55:23 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:56253
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbgDGBzX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Apr 2020 21:55:23 -0400
X-Sender-Id: dreamhost|x-authsender|mxn@1ec5.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7070664020D
        for <git@vger.kernel.org>; Tue,  7 Apr 2020 01:49:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a10.g.dreamhost.com (100-96-14-12.trex.outbound.svc.cluster.local [100.96.14.12])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E89D964037C
        for <git@vger.kernel.org>; Tue,  7 Apr 2020 01:49:41 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|mxn@1ec5.org
Received: from pdx1-sub0-mail-a10.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.6);
        Tue, 07 Apr 2020 01:49:42 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|mxn@1ec5.org
X-MailChannels-Auth-Id: dreamhost
X-Name-Spill: 4ee408a55314b1fd_1586224182176_190120115
X-MC-Loop-Signature: 1586224182176:1770641504
X-MC-Ingress-Time: 1586224182175
Received: from pdx1-sub0-mail-a10.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a10.g.dreamhost.com (Postfix) with ESMTP id A1947B1BEA
        for <git@vger.kernel.org>; Mon,  6 Apr 2020 18:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=1ec5.org; h=to:from
        :subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=1ec5.org; bh=0IDZcnOkGKoJT3cgS1T1i
        JPlccw=; b=XCsq0MjsohzUJleXtI3lmO7nM8/20OCrk4rg7yQSdr8sjd1O+zntU
        JqPTsL4j02ATLxacFbw5AhPkf//2ReoIfakPYObtbS3lEsy20ZVNY1IejrgkA97V
        16LFUEkJFF1RJvdTUEaEZgXAmFWkBQ5PkN3CAhTIKuwkXzqwS3y34k=
Received: from parsec.local (c-24-130-195-9.hsd1.ca.comcast.net [24.130.195.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mxn@1ec5.org)
        by pdx1-sub0-mail-a10.g.dreamhost.com (Postfix) with ESMTPSA id 19377B1BE6
        for <git@vger.kernel.org>; Mon,  6 Apr 2020 18:49:40 -0700 (PDT)
To:     git@vger.kernel.org
X-DH-BACKEND: pdx1-sub0-mail-a10
From:   Minh Nguyen <mxn@1ec5.org>
Subject: [PATCH] fix inconsistent use of checkout and switch
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAABGdBTUEAALGPC/xhBQAAAAZQ
 TFRFAAAA////pdmf3QAAAK5JREFUKM9Vzj0OgkAQBeCHGLAwricQEy/gCVgr72BHPIElBWG2svSM
 dFpSWhDH+TEkVl923+zswwQgZ7yFzMHM6AzYO21j0PQHG8z2gDiREBmEYRE+muWlTr5Q+hbfuSyK
 TEkGChhn7TIc74Uw0v2kzejRKHGD0rgp9Y7CTKrRC4iprwRcJlK6Tkphu9ZuWMkHetkcjPZpIBip
 MsZoXMkzdn4nH5EOhi/T0IhO4C851Xcmi8VTCwAAAABJRU5ErkJggg==
Message-ID: <fe3b560b-be22-b1c0-394f-6bd9a5fef152@1ec5.org>
Date:   Mon, 6 Apr 2020 18:49:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:75.0)
 Gecko/20100101 Thunderbird/75.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: vi-x-KieuCu.[Chuan]
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 40
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeggdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecuogfggedutddqvdejucdlgedtmdenucfjughrpefvhffukffffgggtgfgsehtkeertddtfeejnecuhfhrohhmpefoihhnhhcupfhguhihvghnuceomhignhesudgvtgehrdhorhhgqeenucfkphepvdegrddufedtrdduleehrdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepphgrrhhsvggtrdhlohgtrghlpdhinhgvthepvdegrddufedtrdduleehrdelpdhrvghtuhhrnhdqphgrthhhpefoihhnhhcupfhguhihvghnuceomhignhesudgvtgehrdhorhhgqedpmhgrihhlfhhrohhmpehmgihnseduvggthedrohhrghdpnhhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 =C2=A0po/vi.po | 4 ++--
 =C2=A01 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/vi.po b/po/vi.po
index 5459484048..5af3c3ebb7 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -805,7 +805,7 @@ msgstr ""
 =C2=A0"b=E1=BA=A1n c=C3=B3 th=E1=BB=83 l=C3=A0m th=E1=BA=BF (ngay b=C3=A2=
y gi=E1=BB=9D hay sau n=C3=A0y) b=E1=BA=B1ng c=C3=A1ch d=C3=B9ng t=C3=B9y=
 ch=E1=BB=8Dn\n"
 =C2=A0"d=C3=B2ng l=E1=BB=87nh -b. V=C3=AD d=E1=BB=A5:\n"
 =C2=A0"\n"
-"=C2=A0 git checkout -c <t=C3=AAn-nh=C3=A1nh-m=E1=BB=9Bi>\n"
+"=C2=A0 git switch -c <t=C3=AAn-nh=C3=A1nh-m=E1=BB=9Bi>\n"
 =C2=A0"\n"
 =C2=A0"Ho=C3=A0n l=E1=BA=A1i thao t=C3=A1c n=C3=A0y b=E1=BA=B1ng:\n"
 =C2=A0"\n"
@@ -11661,7 +11661,7 @@ msgstr "t=E1=BA=A1o/=C4=91=E1=BA=B7t_l=E1=BA=A1i =
v=C3=A0 chuy=E1=BB=83n =C4=91=E1=BA=BFn m=E1=BB=99t nh=C3=A1nh"

 =C2=A0#: builtin/checkout.c:1779
 =C2=A0msgid "second guess 'git switch <no-such-branch>'"
-msgstr "g=E1=BB=A3i =C3=BD th=E1=BB=A9 hai \"git checkout <kh=C3=B4ng-nh=
=C3=A1nh-n=C3=A0o-nh=C6=B0-v=E1=BA=ADy>\""
+msgstr "g=E1=BB=A3i =C3=BD th=E1=BB=A9 hai \"git switch <kh=C3=B4ng-nh=C3=
=A1nh-n=C3=A0o-nh=C6=B0-v=E1=BA=ADy>\""

 =C2=A0#: builtin/checkout.c:1781
 =C2=A0msgid "throw away local modifications"
--=20
2.23.0

