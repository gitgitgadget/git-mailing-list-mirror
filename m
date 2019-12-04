Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LONGWORDS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F223C2BC73
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CB42073B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ksysllc.onmicrosoft.com header.i=@ksysllc.onmicrosoft.com header.b="KZhECh0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfLDShC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:37:02 -0500
Received: from mail-eopbgr1320040.outbound.protection.outlook.com ([40.107.132.40]:61152
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbfLDShB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 13:37:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+RtBkFx+JzpazuNxrJ7TVCHIOFJ8fU5DvbXYsLoVWgLMZMarKrqpCxhIbH4xtctW80bXtq6dySaRA4APU0pX07XLiz5sCK3DUqM03V88zyqUJBTLyJ2TGWF01Omg5VOxwtfwyKovZUbl+/xtHhUdpIwJQH3cGE3ex+x5W9U6EU3967KPtuWY2mXF0SVhPae6ke1JWKkLV2OJlNEhjtQMX65JMDPqSUJPji+n5Mq0uZ+x3NM9DDoLN5zQtvlJ6Ipd648Yx0jJD8ugGXahg8NMYkpNJYeEcguhrl8NciyivS7ETY95X1+U82SFn6K/RkEY3Eu6/DCsD5ASycRRUgFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3I8GFIfsA3DE1FryiKseX2kkfopEA4Xf0B1+29IJb4=;
 b=PfZvhtr4S1qiIeG825fXA9uxvtsxpYBLuIrBvFSo9Uq7bmXXmXA2AVA0ukUCNjowWJdgWIlbwutyucDqHx5nox+sK3lQixiuVjIMnSd8NEXIbvO9R0YlbgDat9ffLCuJbvUpZNhwiOrcQkKM4S0ocO1t48SsPsbdSSfPeN6fAHKrrnpzMtZDeiyG/GgVGVpQ+vW2luPWcwjOGAre/DEl6R2P+6SilLV7ffp6QxzE2Jey78aJIDrQ5LJItULPMqw2yEdVXPxPTOWKIz1z7BzH8vva+fcKY44vgRtygwWaitVHewn7VL1DKCVsYm3d6S0EO4ifqZ58CcMdYiigpomnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ksysllc.co.jp; dmarc=pass action=none
 header.from=ksysllc.co.jp; dkim=pass header.d=ksysllc.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ksysllc.onmicrosoft.com; s=selector2-ksysllc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3I8GFIfsA3DE1FryiKseX2kkfopEA4Xf0B1+29IJb4=;
 b=KZhECh0wwznXJrSA20sKlM/mkrvPqAv57EM2fzRDpeVsdO84vleB9txVxyuB94P6Lq+jL9/Ak3UhVJILYPnBbSnupft1Mh8nknMVrDOZ6RCCCKpPGWkPyGzVG89BGEPQIUQWYzk365N/MujcrGWAdZA8yrdayOQVhGQ3nnUWnJI=
Received: from TY2PR01MB2427.jpnprd01.prod.outlook.com (20.177.100.73) by
 TY2PR01MB4859.jpnprd01.prod.outlook.com (20.179.172.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 18:36:57 +0000
Received: from TY2PR01MB2427.jpnprd01.prod.outlook.com
 ([fe80::b074:84bd:8776:a29f]) by TY2PR01MB2427.jpnprd01.prod.outlook.com
 ([fe80::b074:84bd:8776:a29f%7]) with mapi id 15.20.2516.014; Wed, 4 Dec 2019
 18:36:57 +0000
From:   =?iso-2022-jp?B?GyRCMkNGIzBsR24bKEI=?= <kato-k@ksysllc.co.jp>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] gitk branch name encoding utf-8 probrem 
Thread-Topic: [PATCH] gitk branch name encoding utf-8 probrem 
Thread-Index: AdWq0cuhgH7WTTbHQwq0du7Qsjt4IQ==
Date:   Wed, 4 Dec 2019 18:36:57 +0000
Message-ID: <TY2PR01MB24271C32E2FD9FD8C27CA8C2CA5D0@TY2PR01MB2427.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kato-k@ksysllc.co.jp; 
x-originating-ip: [123.223.66.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cc30ff8-c149-49ad-6656-08d778e8f1b8
x-ms-traffictypediagnostic: TY2PR01MB4859:
x-microsoft-antispam-prvs: <TY2PR01MB485925A6FDF9C91EDC364ED2CA5D0@TY2PR01MB4859.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39830400003)(189003)(199004)(52536014)(508600001)(14454004)(64756008)(66556008)(66476007)(66446008)(81166006)(76116006)(966005)(66946007)(3846002)(8936002)(8676002)(26005)(1730700003)(81156014)(6116002)(5660300002)(5640700003)(4743002)(316002)(2501003)(25786009)(6506007)(99286004)(33656002)(71200400001)(7736002)(55016002)(2906002)(4744005)(102836004)(6436002)(186003)(74316002)(85182001)(71190400001)(9686003)(305945005)(86362001)(6306002)(2351001)(7696005)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:TY2PR01MB4859;H:TY2PR01MB2427.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ksysllc.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qrXGRYlyfBOrgwRQDGfxR7npnDORkqOZwU2WqSwv0eI4FanSH4k5meqdQ//Hxd0R/RY+LcnjUA0bFqQapo8QskhPa1ITGBjEW47ep3H/Gu3XV4LvbbJ680zv9Cjg76vYGmfHbdfQsrecvObob1QnWR3jz7GyA5SK2F0iFaXVMPPoB5mS9r+hjkrD56n6XhPY3J2BTmIK0y2f/T8mPn6+5Bw5uo35gkusPcvTWgpk+v4/7lVHx9X/+WdbrZBdb3fzSuOnayWnFDAcWFRTNsDnm35drrxshuqJD+AO/CpEy1v5GI7DLU1d0SKifEVuPx0NDJXviycTl3jhoJqfQ9btDJdAfnWV3U+rRIDzUMuqug8rskDiSaszizapSLv/d/BK4LmHiZpcl+1fjc6YOo5xYPcGg5+RjkfgfNjET1y8gRFEpcaHewjg3PgdWOicC0gKvcOBS7m8I7DNxnoYNsZhjwUJzzHs5+ZdzgjyFq0QVMA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ksysllc.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc30ff8-c149-49ad-6656-08d778e8f1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 18:36:57.8484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e2e801e1-1bfd-4c29-8e88-a6b5a79038d8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/lZiRq5Ff3/O/qV01a/M+EzYy5LzvBf9fXYNE5nITHthL9Wp+iAFKefDy+8V2iV5GbhTCv5ZbwEnBP0R78oNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4859
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

Here is a patch to gitk branch name utf-8 probrem.

See issue
https://github.com/kkato233/gitk/issues/1
and fix it=20
https://github.com/kkato233/gitk/pull/2


---

diff --git a/gitk b/gitk
index abe4805..3f61a5b 100755
--- a/gitk
+++ b/gitk
@@ -1780,11 +1780,15 @@ proc readrefs {} {
     global otherrefids idotherrefs mainhead mainheadid
     global selecthead selectheadid
     global hideremotes
+    global tclencoding

     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
        unset -nocomplain $v
     }
     set refd [open [list | git show-ref -d] r]
+    if {$tclencoding !=3D {}} {
+       fconfigure $refd -encoding $tclencoding
+    }
     while {[gets $refd line] >=3D 0} {
        if {[string index $line 40] ne " "} continue
        set id [string range $line 0 39]
--

--
kato-k@ksysllc.co.jp

