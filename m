Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121EAC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 01:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B6A206CC
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 01:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teradici.com header.i=@teradici.com header.b="kjdIw3nO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgCaBNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 21:13:02 -0400
Received: from mail-eopbgr750095.outbound.protection.outlook.com ([40.107.75.95]:51937
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729129AbgCaBNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 21:13:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA3qIfWTLjrUMzzkIBIsKjuScTu0nVQA8Ik/Jj5lCPFzOL3gfylBajT89Esuj9nkp23iGtUxQgIrl1/pIRI0BNg8HlMjPQ6F0iStjFebMCy7jOLVT2vhgXwqNRp38TiAIEe+uBDk/MZmFMHz7U4Sz10RPxI5HbJn6VnTfNUphV3nFXExd280SOEjbrNxKlV8tt0cDGlo+05XwYsYpg2F3EPkJ9kkmSo4XpNF9yR+ozjyJGGAm13Lrzu4TKAsLnZkW/h2j1PitwUjSGOZx2sApDf1GC+mT4CGa9SeEKJfK1PM83yFtK2FCN/8p/wFBBnSYuJDBPdymMQtSL/1/YZ1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjO28qaxhndcYEljOeV9E4KdtRaXY5Ns1Pk7AnY5WVM=;
 b=WOEJvpn6kGpUXhA660EHWod5N962/aC57+4qTw1ZsEnNY2lEr4tC3AArJqHVqpJtCGJm5IEa2z8cofsQ6DuXD97s+KaIlJ7CZWtVa5MYEGBr+PpLa6IRsEUV+un06hywQun8bgFJge7uHSAveZ9TpjTlZdvfe2RYK4qEMtzP4L+oGMli3XMqcAAkoY1EPewtCOn11DaexzXb/2M6W5WKb7XHL562hg9CU/yNmeHBDYX7eUVS9X+JAuf4NPj7A3D6opRs/eds3d5jzrWTNHUBSpjcne+qFJt4OddKAKiSgLB7oV5sZPx3pfuj2Urjyjlje/J2KbCTovTw64P+iMdKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teradici.com; dmarc=pass action=none header.from=teradici.com;
 dkim=pass header.d=teradici.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=teradici.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjO28qaxhndcYEljOeV9E4KdtRaXY5Ns1Pk7AnY5WVM=;
 b=kjdIw3nOw1/g3VorEDRa9kET2VFMK71k8DQGuuo91qEsHEjOuzhv6FBew8M1wCyHsOOhNwgGtHh1Y5V/UQJEOHmsvu3/TkLInluyYfDmKb95oltwx/qakDG0mhaTf1LUJBLPaEYkxAoM1YawJchacUqbM1L1jTEt+YexT4r0gFs=
Received: from MWHPR19MB0046.namprd19.prod.outlook.com (2603:10b6:301:62::29)
 by MWHPR19MB1391.namprd19.prod.outlook.com (2603:10b6:300:d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 01:12:57 +0000
Received: from MWHPR19MB0046.namprd19.prod.outlook.com
 ([fe80::1545:87df:62ba:c9f]) by MWHPR19MB0046.namprd19.prod.outlook.com
 ([fe80::1545:87df:62ba:c9f%6]) with mapi id 15.20.2835.023; Tue, 31 Mar 2020
 01:12:57 +0000
From:   Andrew Fuller <afuller@teradici.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Unexpected tag chosen by git describe
Thread-Topic: Unexpected tag chosen by git describe
Thread-Index: AQHWBvVxPdFvhQHjBUmEecTvdtcb1Q==
Date:   Tue, 31 Mar 2020 01:12:57 +0000
Message-ID: <MWHPR19MB004604CA28B77762DC44E880D5C80@MWHPR19MB0046.namprd19.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=afuller@teradici.com; 
x-originating-ip: [54.149.26.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38309456-744d-4110-7fd4-08d7d510a5d3
x-ms-traffictypediagnostic: MWHPR19MB1391:
x-microsoft-antispam-prvs: <MWHPR19MB13911617246328A9F3D6588FD5C80@MWHPR19MB1391.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR19MB0046.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(366004)(136003)(396003)(39850400004)(376002)(86362001)(186003)(64756008)(316002)(66556008)(76116006)(66446008)(71200400001)(55016002)(52536014)(26005)(9686003)(66476007)(66946007)(8676002)(7696005)(8936002)(33656002)(55236004)(6916009)(2906002)(5660300002)(6506007)(478600001)(81156014)(81166006);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: teradici.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0SRxCCgxLesPHrWh/mtIIE2ck8qup3Tsjvdbfyp8gCbEZHATQy64cFkpsiTAjolLMWz0gK9xsWcRSyr0RVNau9lFI+irXqmjF9L+mEpVgj9p8K+WklaSpakn9IETAe8k3JFKSJ9fHr5fXkQ169aBBL53A1RVvtDUtR9aktfidDx2XA1/D3D+JBi5AxX4qZqj/QZJAaMfav9AXsfAPwIDtMs26R7rKl9DwulQZGNojKqwHyBEOfekerzJTC6mdzBCw5n3uZAp0/ZEvegQ5Rfhvdcw3Sx7/RfLbi7YlMfFtT4s4N6zM5KqfOsSQrTYyQ0sHST3P9O91WFXG7jXmu6XejkV0QPL6MD9g5BTx8mjsS6pWRYkyhJXq8+76l7vtZBZJw636AhV4hoZj24x/Qv0S+lBxu2ZOf0+OjxVqu+OY5hSy7P8I5iD/gYn8MDFCs8
x-ms-exchange-antispam-messagedata: HfIQM3os76YKMRhU5nGycqqoFxYhsygzzZlnSHKNLsu+cxBuONbmtn3nZ95GBBwe7ivIWe8nR3bXGjkg3ei9+Qwx92ZyYnKuHZdw9G359coq4AeN4/LHCNTdbLDNbQV1yb/dEcnRD9QOfYJb3FNzZg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teradici.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38309456-744d-4110-7fd4-08d7d510a5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 01:12:57.3979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 715c7afb-027a-4b6e-9a60-dc385a62cf18
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjdBdKqQf1+ZVHNMrzTviNK6ThpNcQfnkPdVb3HasQ4XGmpE1eSYYM8CXJBQm3p4Gb0/NdjGOdBDAC0bKdh8sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1391
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Twice now we've found ourselves in a situation where git describe chooses a=
 tag that we weren't expecting.=A0 I'm wondering if this is an obscure bug,=
 or whether somehow We're Doing It Wrong.=0A=
=0A=
$=A0git --version=0A=
git version 2.25.1=0A=
=0A=
$ git describe --debug --candidates=3D10=0A=
describe HEAD=0A=
No exact match on refs or tags, searching to describe=0A=
 annotated        432 release/20.01.1=0A=
 annotated         71 release/20.04.0-rc9=0A=
 annotated         75 release/19.11.2=0A=
 annotated         77 release/20.04.0-rc8=0A=
 annotated         79 release/20.04.0-rc7=0A=
 annotated         85 release/20.04.0-rc6=0A=
 annotated         87 release/20.04.0-rc5=0A=
 annotated         91 release/20.04.0-rc4=0A=
 annotated         94 release/2.14.7-rc1=0A=
 annotated        121 release/20.04.0-rc3=0A=
traversed 866 commits=0A=
more than 10 tags found; listed 10 most recent=0A=
gave up search at 704bbef36b7f66ea0d56ecf4fe1ad9812dfb126a=0A=
release/20.01.1-432-gd11dd98b90=0A=
=0A=
$  git describe --debug --candidates=3D11=0A=
describe HEAD=0A=
No exact match on refs or tags, searching to describe=0A=
 annotated         71 release/20.04.0-rc9=0A=
 annotated         77 release/20.04.0-rc8=0A=
 annotated         79 release/20.04.0-rc7=0A=
 annotated         83 release/20.01.1=0A=
 annotated         85 release/20.04.0-rc6=0A=
 annotated         87 release/20.04.0-rc5=0A=
 annotated         91 release/20.04.0-rc4=0A=
 annotated        113 release/19.11.2=0A=
 annotated        121 release/20.04.0-rc3=0A=
 annotated        159 release/2.14.7-rc1=0A=
 annotated        171 release/20.04.0-rc2=0A=
traversed 634 commits=0A=
more than 11 tags found; listed 11 most recent=0A=
gave up search at 65df08f972d970f0e85dfa5503cb02b48c9238ec=0A=
release/20.04.0-rc9-71-gd11dd98b90=0A=
=0A=
So when git describe looks for the 10 most "recent" (I don't claim to know =
whether that means date, shortest commit distance, fewest commit delta, etc=
) it finds release/20.01.1 with a weight of 432 and tagged recently and cho=
oses that over release/20.04.0-rc9 which is only weighted 71, but tagged at=
 an earlier time.  Here git describe chose the highest weighted tag when in=
stead we were expecting the lowest weighted tag.=0A=
=0A=
However when git describe looks for the 11 most recent, the weightings of s=
ome of the tags are actually different.  release/20.01.1 drops from 432 dow=
n to 83, and release/19.11.2 rises from 75 to 113.  And then the tag with t=
he lowest weighting is chosen.  We're happy with this result.=0A=
=0A=
So my question is why is the distant (but fresh) release/20.01.1 tag chosen=
 by git describe when candidates=3Dn is low but we get the tag we expect wh=
en candidates=3Dn is high, even though both tags were considered in both sc=
enarios?  A bug or PEBKAC?=0A=
=0A=
Thanks,=0A=
-Andrew=
