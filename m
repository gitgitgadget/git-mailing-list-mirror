Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F9DC433DF
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 08:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA88D20719
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 08:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qliktechnologies365.onmicrosoft.com header.i=@qliktechnologies365.onmicrosoft.com header.b="k1cuipNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgG0IVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:21:41 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:38017
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbgG0IVk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 04:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcuYEw0YZ5WjX9WNg+DRxStSVcQzez078VtSyhZxxeIrhr9P0IjTXTdonJtoXbYk+d05EfSqtqIp6ZtJRPPDb5piLy6Qudf5aJ3a4r43LBmQ3rcxZ86MPC28eSauFxM1va07gIr7gJy2cJsvSXDcsXH45D0Fzm6sk05xZF8a5b/5XNFBBemBx83K45N/r5QrvcgMDowj+zTDecHnVvqShYrpJUXJaqNqp+8ILdYCZvyeTD/tCrCb3rVRgfdFlNeIXHHqBXQXW3a/qHATSdSO7Q6SFJ67NwWNDBE3S3O33D2f4PXUlCJm1GXQKb9/NWubyckRN6xmIbIAeH3OP07+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIr6BK+qn8jlvUvy1zBKbInkvdwanJilTOf/gTN5jkM=;
 b=IZVuYG70k9XHynnaxTSTF2Uu7NfXgTcKF04+hzirHHfAnRDqDySmsi/zdBCnkeCfExHtn+O0NwkdJ37Za2exSsy2N5SlUQV5Y9TtJNSqaMc0X+Pgw6aB1WfiFkpwV0L9lbBLy+VMID+NIM9j6tR+IJuQMa4/VIg8S4yOKc+sdTjcNIhIJaA3C3NvFh6CfPUH4BhzwgeazXjFERHF0vyNfWlXhC0jKq63Fgi+Zp3NL5PEBJVnXdeCjPOPJy3TvUImaAsmG3d+kmFfHU+RVVPkkHvo1GQm/7Y/FKsrR9+ZFFNZu1ncNPKKgNIatPk/mI+UF9swSA4cPkSBo09hdrV8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qlik.com; dmarc=pass action=none header.from=qlik.com;
 dkim=pass header.d=qlik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qliktechnologies365.onmicrosoft.com;
 s=selector2-qliktechnologies365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIr6BK+qn8jlvUvy1zBKbInkvdwanJilTOf/gTN5jkM=;
 b=k1cuipNR46OFTYjG1ZprR4n2kaL5l63DOjm+GdiYMQnDrQysZRN+4uHwhaj2o2ojqR7v6gAV6v//8h+In7PEE5lwFHSRL/J8IxwkHdK31eQBlpJdIHQDXbic1uAXgfHo9/EN7yhn0uW4jJ8krbBQbU/xySw0X6JQQA83VKNuqhM=
Received: from DM5PR1801MB2076.namprd18.prod.outlook.com (2603:10b6:4:67::15)
 by DM5PR18MB1465.namprd18.prod.outlook.com (2603:10b6:3:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 08:21:37 +0000
Received: from DM5PR1801MB2076.namprd18.prod.outlook.com
 ([fe80::d38:3357:7d56:a2cd]) by DM5PR1801MB2076.namprd18.prod.outlook.com
 ([fe80::d38:3357:7d56:a2cd%3]) with mapi id 15.20.3216.031; Mon, 27 Jul 2020
 08:21:37 +0000
From:   Tommaso Ercole <Tommaso.Ercole@qlik.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
CC:     Taylor Blau <me@ttaylorr.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Creation of a branch named that has a directory prefix equal to
 the name of another branch fail.
Thread-Topic: Creation of a branch named that has a directory prefix equal to
 the name of another branch fail.
Thread-Index: AdZhCltmYBIPi/IgS2mYGSlTAcNUJQAmkNBgAAu+CYAACGFSAAABgczyAHzcRwA=
Date:   Mon, 27 Jul 2020 08:21:37 +0000
Message-ID: <DM5PR1801MB20765394FC05BA6830475B7CF0720@DM5PR1801MB2076.namprd18.prod.outlook.com>
References: <DM5PR1801MB2076F807C0B9F29A152DBEB7F0760@DM5PR1801MB2076.namprd18.prod.outlook.com>
        <DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
        <20200724160045.GA10590@syl.lan>
        <20200724200042.GC4013174@coredump.intra.peff.net>
 <xmqqv9ick5j4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9ick5j4.fsf@gitster.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=qlik.com;
x-originating-ip: [212.124.176.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a63aeeea-7541-4ff4-9ef4-08d8320614e5
x-ms-traffictypediagnostic: DM5PR18MB1465:
x-microsoft-antispam-prvs: <DM5PR18MB14652FE1E4DEA8F21045BD1CF0720@DM5PR18MB1465.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XEWUGKxWTz92Ygs3ECi/2dfNMAjE32nJxbv+c++PptlmbVnWWiIirlunAOJ5o8+Cijf+Q/CXAjPNooNv///H0KtG25sKNhkWKxjtV0FVBVYDO0mloqor/hncy8LfXRo2936bKqQ/Mu2/8AbeC4aJzPnR3Z/WbaOGQFynDmfcYahNS2OKNtVOFhVUAd/2iTS1kCSrRYIhkifcoHrsqNE8AjxV2Z4WVyl4D7Kk/tUEss0zk3aff5qA4ArW3sk9QAKd6zy/d6Qkidh+XaJWdnG/D9qcJhX/BSq8D48BtwvVHyISoWqXXEv1m7nQbxd6fF+5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB2076.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(136003)(39850400004)(396003)(186003)(110136005)(76116006)(66556008)(66476007)(71200400001)(66446008)(64756008)(7696005)(66946007)(53546011)(6506007)(2906002)(8676002)(4326008)(54906003)(52536014)(86362001)(33656002)(83380400001)(8936002)(5660300002)(478600001)(26005)(9686003)(316002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: T1dFnqTuJPJ+cHYB8ztYZu+T0clVxjre7dbxHLuNNgBqmQUyeKvsSOXXdzTGfiEcI7bRQO4ammrASyZO55YWF/xGkwpH59GhIe5+h8BucXMn5vXAsPVP7Lve10k++EllnIRfz8Yztzj+ogseFZTgFgwOsAg9Bn1mwYxxyCikwGtwMI63oXANsktGPYTpwVJriqndCRJFtU59K0t68iEIc/E2KZYXQN5J6fRBaJIkE1z8MPAZirNtkPmWTafmjlsP16CmYhwgENwG4j2StV6dRLKf3WQPuhWhjhUWhsoKf49ZgIlbhVc61YGAgmk/lBmZyKcii/9HRciR26bbw/QPNMHE0YSKWqWqZTPVjLNu6NOtvjeUW8GFowFXU2ab2/KaXtqKr91nBWvQqDVxhI3imIHQOUAuUjBvPKFml+PnRLsfNVEVaClAoU9sH1V7kKtu8apn1Qj/OFWO0NwXvYiU41TRPkYQKF0hddvlJyHOOP291J80IexxSb9rsyhWuOWN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qlik.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB2076.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63aeeea-7541-4ff4-9ef4-08d8320614e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 08:21:37.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c21eeb5f-f5a6-44e8-a997-124f2f7a497c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2Zw+WlY484DXgMv3WkptAkrXbdwVZ7uvW0DWX3iDH5REJxThEm6yqGKK1a1ZBC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1465
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all and thanks for the answers.=20

By my understanding it seems that you are aware of all the problems and you=
 have just in place a solution for the future.

I will just wait for it.

Thank you really much for your effort, best regards,
Tommaso Ercole=20

P.S. btw this chat is it private between us or published somewhere, I just =
thought about it now, when I saw my phone number on my signature...


-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>=20
Sent: venerd=EC 24 luglio 2020 22:44
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>; Tommaso Ercole <Tommaso.Ercole@qlik.com>=
; git@vger.kernel.org
Subject: Re: Creation of a branch named that has a directory prefix equal t=
o the name of another branch fail.

Jeff King <peff@peff.net> writes:

> Note that even though packed-refs does not have this limitation, we=20
> still enforce it in order to avoid headaches when moving between loose=20
> and packed refs.
>
> Likewise, we'll probably[1] continue to enforce it with reftables, at=20
> least for a while, to make things less confusing when pushing and=20
> pulling between repositories with different storage.

Yup, that coincides with my understanding.

The files backend could also learn encoding/decoding refnames and that coul=
d be used to transition, if/when we decide to discard the "refs are organiz=
ed in a directory-tree like fashion" design we have been using, to a new wo=
rld order where a branch M and branches M/A, M/B, and M/C can co-exist.  En=
coding/decoding refname to map to the filename would also help those on cas=
e insensitive filesystems.

Thanks to the recent preparation work for reftable, we are ensuring that we=
 do not leave direct accesses to $GIT_DIR/refs/* in our codebase outside th=
e files backend implementation, such a transition hopefully is getting much=
 easier to do than before.
