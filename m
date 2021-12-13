Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2280C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 19:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbhLMT61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:58:27 -0500
Received: from mail-mw2nam08on2045.outbound.protection.outlook.com ([40.107.101.45]:20320
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242622AbhLMT60 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 14:58:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVMVCGwwtuOTKZydtIFJQphJr5lbvJt+E+abQYgYNgI+XvcFML0iNhLYilju5mOgw9e8JudRsa/wwW2n1C4xBtnYdpyxcd2zADht92Vy4UtVAmxZ4Zk3Xqq0M1UBN7097pGRID61fnXHZathP/f8uoitwcuTJW2aX9ZSrFEaRdQ4BvWuKLtqRvclSY30RtyI1XYTA5pCSsPxpchwjNYeSFL5w4qw+TQ1pMEtysLJimazuluK5h2tRPudn33tIQrDpbSGqwdmeNd6DhL4V4vAe4fRuoqqy4mVH/hughBdluUtQqfXf7UXTIvBktzLyBZwO8FT8RlM/6V9cvyRKl5Xtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqiw6r+iZs4Pbo45Izk+E5YZwFgOo1Lm+HaUeR34P2k=;
 b=kUjH8SrigbXab0hhfNepqO512vHNFUKJnw5aIG77w9japab+Jk1XwCh/DWyF01JJivSrfEa4f6HvFh5jbnVVVLPfPTiI+kD5vGVN2W7lXnlr71NnLimN8X+abJ8cn3kN0bJMJAPpXpQAS+MacEEQA6RcxqKESOzZ1DaUD6DHCasdYbaUmlkk+3OxQyBri5XE78ct05l3Z3dLCumKYqjueDFjoA8hqEbdAMJnxzcGLxB4W8Gsj1sBF3Emubde/iYwZjgtRfgZvVgIHihnF0u2658xkM6s6nlcKHuPTZM5lVln7elDs3GecdNrxCHrqGz0jktke1i8Jk9iuFU/W1NT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqiw6r+iZs4Pbo45Izk+E5YZwFgOo1Lm+HaUeR34P2k=;
 b=qwAYhVmIpX4n4yrSIvOMr3cXXFcsKX3dS5g1kwG9lWBM4DBAz7XFSCYCX2pXgpqburBiXOnwPbdghDDcTT2PBSj8OYm4aax+JlemEJDWq8rZD4KSmVtjnSoNkDgxuaNIPaIKix3rTfUYMxA3xNznvWgs6YtE3l/SCxBr0BP83KeXMr+FJVJ/PVgt27SE4pO61bV3G4DADuAhZpfS5yboFlZuEvCLIIgd1WmeajvPFTwRhYVrDdM518wxsf8OxmKslmBlUXQGkx7UAm19X9tUqkWKX4tquFlzWtbb2InpAhc5oWWYfqe9wVfkTSbxhTf7o1R7UXexBaq0pSe1QP8FeA==
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3636.namprd12.prod.outlook.com (2603:10b6:408:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 19:58:24 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 19:58:23 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
Subject: RE: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Thread-Topic: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Thread-Index: AQHX7TjcBdyuTAN1MEKv4eIoPWSSjawrW5kAgAAx4fCAAYNXAIADYpSwgABhp46AAAHwMA==
Date:   Mon, 13 Dec 2021 19:58:23 +0000
Message-ID: <BN8PR12MB336129AD5C148267925FB387C8749@BN8PR12MB3361.namprd12.prod.outlook.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
        <CAE5ih7872E8X-qRfBrBOHmKcUCX46GkXwq2WD3UUX8TuYczZDw@mail.gmail.com>
        <BN8PR12MB33613E4CCDF13E6D0DE155BEC8719@BN8PR12MB3361.namprd12.prod.outlook.com>
        <CAE5ih7-ZoKThXefBN=znytQi=z4_notihQdSksYdMTzKDTAb=w@mail.gmail.com>
        <BN8PR12MB33619656D91E92C50FF1B86CC8749@BN8PR12MB3361.namprd12.prod.outlook.com>
 <xmqqv8zsb8xc.fsf@gitster.g>
In-Reply-To: <xmqqv8zsb8xc.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16f87486-a9d9-458d-1dcf-08d9be72eb90
x-ms-traffictypediagnostic: BN8PR12MB3636:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3636493AF371E71AEDBEED81C8749@BN8PR12MB3636.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7FwcERiF5T/2sQH+pWEWh0bQALdHrD5G8rahU+YUnSpWhyuJOU5wZChrbdearuai+U+8R1RefQhuyKdic7JIr4ibvxHC3zI6kmLLJPyAuoQ9i8SfAUtSDwhs91j5VXrdyW1gJDiRT8eIhCFjp0JF15/EuV3oucE6zG6bXE53vajrpX3w2EVZS4VOSPQ2qGkrID4xOoMEljArcXCXuaPdM/fFDNj871vkZUw2lq/nJ00ErbDY3YthVvFo5sRZx9kwwH5pjtA2MCgd/4Oyf6nqmVEBbUCFuIztSqseK7wlNJFPhJK6q85MLeqiXP7jVdzzBVkSc0zLdqMrNppjismK92j3e32DvZMIqmbUErLzJnvX+dPX8d3pHt+gsEG9f5vWqtoldBB4ExoBn6koS9a8t96DEH3qQCyFByupXClGSUAjsUY8ITaKShwvAN+b9pna+OSCbTw8QL76r3DnN6xKK+2nPa2nVTkgNXXoY9sHR2phj811Nk9T0xkLtbwwaAmXQF/XNlaScx3NmF3BO2C4yjyMu9MHoU4kPqM4Y2tbRCcaDSPsO2Sj7hLFhvBMre8pmf7HCJllXtwAwWBVhm/W8ucCIivAYfyO8WJZPsLY07zHVFI9XbXAGrh0dRR+rVgIc3H9Pz0rferHHv2vxZqMMSUMuDP88nKc/lBPXAui6Xw+XfTwG8sFdBlWskVTZEi5oaGybfD/QRaGtgTeQo+QGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66446008)(4326008)(66476007)(66556008)(83380400001)(33656002)(52536014)(7696005)(5660300002)(71200400001)(38100700002)(508600001)(186003)(9686003)(86362001)(122000001)(38070700005)(64756008)(6506007)(2906002)(316002)(66946007)(26005)(54906003)(55016003)(8936002)(8676002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cNbDnLia1iY7zEn3r4B0YXaMJuQeoyozgXPBKeaAlv5jDELumziVaAEEgef0?=
 =?us-ascii?Q?p73VzAx1heUbio2Kf2BI9tEH+tunTRd12XqdBjwTVohqiQR0kEcjQuvOp0ub?=
 =?us-ascii?Q?0dEmNS21gaInke1behhVJDZVFqK9A9XYMMnZt4kb5z8INCdKqaSwi80tst5u?=
 =?us-ascii?Q?+xOlpUbxYKW5lMuwDfefwFQvTKBLoUYqFbKnnS9caslnP0E+FLOd8g6Um0yz?=
 =?us-ascii?Q?4OQ36KjWipVRCQzjqd1zx9jNBT6zxnubPdOgN1uVnitSMNmw73MGIslQwEtN?=
 =?us-ascii?Q?42tSr6p8R4DSrMcVKaP0E1wPRhaLSTwDO9EKC7ysuSFCDYPQSzaEEYaXKp7X?=
 =?us-ascii?Q?ef7IGrcd6JSegDwm2O+Qzgajc0rGtrzH5vxrFQk85fzTfC1tzDb8or1FCmod?=
 =?us-ascii?Q?xKU8aHtKsGVixi2ejnWtLfASA5nEkVR0qyksEOhlVhEEhrYwhrzNY0WoLPpF?=
 =?us-ascii?Q?evkEE17KeMOOwbBGmIoyblnrQ8LLcaobdJa+kIWyaekTo8k/CUTDaS7bSeN9?=
 =?us-ascii?Q?n6PCkXrccYhD6PEc0S8bA4c0kebEyxbSImZ9cdBBHj1jy4xaI8TDee6mIU0N?=
 =?us-ascii?Q?OPm9+4VoGQ0U7e2k3EzI7IxF8zFx1odIlPzEQ20NVzih/hdBrvnRc7Wrlm6T?=
 =?us-ascii?Q?LmfgR3TMvhC7zXwyl08xfGrGbHpLoCsYW8r3AtNkkHs+LgmeDJmT2o7ZieEP?=
 =?us-ascii?Q?9oaTLfM0V9LR5mcAju7Fxc4izRmEQ3CH2hE299nR/L3PCz+ViFsGU2iMa3vA?=
 =?us-ascii?Q?eQYFhuD2XNWicjCAYUbqvmr7g+IRkv3CvpyFepdIFLDid/qu3gXykseGsvJ4?=
 =?us-ascii?Q?M4VJa4w62YKkGKLN+fZF/eyu/TX1TszfW0Ccq4VDpBtpTQH0j7bIzU2PaeRw?=
 =?us-ascii?Q?bzg1KghRf6PWIN5r5E5IfcO4uqjGuRPMKOQtuW2JkBkz8y/6vWIu6ajlK7oc?=
 =?us-ascii?Q?H3t7PTz58oHJS79DqbYnvVPEorMAif+4nDRkcN3nmXSfwApvEayh4AXwSUYv?=
 =?us-ascii?Q?egdta09lzX3MrfwXxWMmw6xU8QeP+IVFK6OfHsu5yg9R3jzT2coBYaoiEWAW?=
 =?us-ascii?Q?cFIm8lo3F7ci32imreTa11INa28RDVn0n+PT/ikDWRcsFHW86boULiB9YQ4o?=
 =?us-ascii?Q?VyTGbDw9Ra8ga0GrBj2UTyYOasqE7+vgojBBwqjZ6Ie8y1ucRH5k9CmsdlED?=
 =?us-ascii?Q?/8ytDDeagzsxaubpPZo2T103h4Qgasa02Zbd7RLtq2kw0FECgXOMzKlYkppd?=
 =?us-ascii?Q?bDLvicRBy8G5tBRzWxBuH/tXWi+l71cVJZC1BtuINc6O8DO4SW9S57uqlapC?=
 =?us-ascii?Q?qUKPHx5RQE3p0ueFT2YAi2QcnN3qCiUAiqa3zkpFVMZBdSn5iIY+Vperv50m?=
 =?us-ascii?Q?6W0nKsnxaFkTwQAQvBblDzuk9d5bGsoTo8Z1ohTyf0PzsdA8XsY3vsmHZLdK?=
 =?us-ascii?Q?/gCyU30Nuw/Lsxjtut1W7hxXzIbb+bUblN7z6df3ZMhLiT/hg1h3ds96VsXx?=
 =?us-ascii?Q?BKcmJTsxyWZNKBgJGLZahkLzIvERf3UTRahcQ2yByvENkJDWk4XtDjbvKcu6?=
 =?us-ascii?Q?Ss1FJJQ0J8pCe6QG8Pf4p8uUnAH4nWC9KX79AzkRzFdAvxDxYc6gSozsJJAs?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f87486-a9d9-458d-1dcf-08d9be72eb90
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 19:58:23.4597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWSG1BcIrliA1TV3jQNjklSc6qodpIn8L1/0SAvlyn+dm/WNphgIIn1IvJFQxHKDdVMshaxdRYH25nZkggdgmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3636
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sure, but that defeats the whole notion of "python3 is everywhere,
> python2 is dead, and nobody should be using the 2-year dead version".
> "test_have_prereq PYTHON" should be sufficient in such a world, no?

That's a bit of a stretch.

As Elijah said:

> Python2 was deprecated by the python project in 2008, with announced
> plans to stop all support (including security fixes) in 2015.  They pushe=
d the
> sunset date back to Jan 1, 2020.  So it has only been end-of-life for jus=
t under
> 2 years, but it's been deprecated for over
> 13 years.

Python 3 *is* everywhere. During the transitionary period, Debian allowed p=
ython2 and python3 to coexist on a system by giving them the names /usr/bin=
/python and /usr/bin/python3 respectively, because they are effectively dif=
ferent languages. This allowed legacy code to continue to function in view =
that it would eventually get ported over to python 3, opting into it by cha=
nging the shebang to point at /usr/bin/python3

"test_have_prereq PYTHON" lumps all python versions together as if they wer=
e one thing, which they are not. It's as meaningful as lumping together all=
 the Perl versions, or lumping C++98 together with modern C++. If a system =
has Python 1 installed, strictly speaking the configuration script should i=
ndicate that Python is present! - but there's a bit more

I am quite sure the Python 2 will linger on in some form or other - maybe f=
orever, but that doesn't mean the Git project should be developing, maintai=
ning, testing or releasing Python 2 code in 2021.

Python 3 is so well established, that even the minimum version requirement =
I want to bump to: Python 3.6, is end-of-life.

Joel
