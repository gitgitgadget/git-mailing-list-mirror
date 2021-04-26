Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB470C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07DF61185
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 21:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhDZVoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 17:44:15 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:32077 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233257AbhDZVoN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Apr 2021 17:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barclays.com;
        s=barclayscom20180719; t=1619473410; i=@barclays.com;
        bh=e8/soCyWFbi5USij8dlhtu4lbdx3HM2sawrzPi2dhVw=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=FQzemWHmaoega5KkdBWl7vaoxUeoU7ICN9i0maimbSjNQxZgurX88qFrGrlZlQz1L
         7yOHBPJbBDdFr8GGU2yUi/dBwmmwyg9BrWzUHOTxTP43T477+v5sJnXqB0Be2fjlpz
         RnAbLLHZmI9wrrdf4HfCxtHZ5qjIKy8drzyEVV6smZv7qVsbWOY6tP6zqe5Dek6kZj
         Hr2YhWweYr9XfpfamsITQ5dUmAuySx+go6EW5UPC1k5gOgG4j4POHWtepJ1SuLuyyZ
         UV3kVRp5K0WSHYLYvqKxKfAb9AAy9Pd/zicm0+gEMFQqtpeVwSJrVcHCJAtWteVfUB
         U+1cJK0t3xSIg==
Received: from [100.113.3.92] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id A0/8D-55623-10437806; Mon, 26 Apr 2021 21:43:29 +0000
X-Env-Sender: Mark.Yagnatinsky@barclays.com
X-Msg-Ref: server-11.tower-224.messagelabs.com!1619473390!111096!16
X-Originating-IP: [157.83.125.117]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.75.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7839 invoked from network); 26 Apr 2021 21:43:27 -0000
Received: from unknown (HELO IMSMGSLB602P.barclays.com) (157.83.125.117)
  by server-11.tower-224.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2021 21:43:27 -0000
Received: from IMSMGSLCP04P.barclays.com (Unknown_Domain [22.112.132.23])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by IMSMGSLB602P.barclays.com (Symantec Messaging Gateway) with SMTP id B3.D6.45865.FF337806; Mon, 26 Apr 2021 22:43:27 +0100 (BST)
X-AuditID: 0a318843-fa467a800000b329-e3-608733ff77e8
Received: from mukpbcc4meg0002.collab.barclayscorp.com (Unknown_Domain [10.250.250.254])
        by IMSMGSLCP04P.barclays.com (Symantec Messaging Gateway) with SMTP id AE.73.40200.FF337806; Mon, 26 Apr 2021 22:43:27 +0100 (BST)
Received: from MUKPBCC4XSN0040.collab.barclayscorp.com (Not Verified[10.32.169.43]) by mukpbcc4meg0002.collab.barclayscorp.com with Barclays Capital Filter ESMTP (using TLS: TLSv1.2, ECDHE-RSA-AES256-SHA384)
        id <B608733ff0001>; Mon, 26 Apr 2021 22:43:27 +0100
Received: from MUKPBCC1XHY0003.collab.barclayscorp.com (22.48.77.21) by
 MUKPBCC4XSN0040.collab.barclayscorp.com (10.37.66.98) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 26 Apr 2021 22:43:27 +0100
Received: from XUKPBCC1XEDG001.collab.barclayscorp.com (10.232.4.33) by
 MUKPBCC1XHY0003.collab.barclayscorp.com (22.48.77.21) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 22:43:26 +0100
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.56) by
 edge.barclays.com (10.232.4.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Apr 2021 22:43:26 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTrqRtNaylZjFWFURxOH7KIuCuWGlwPhGUe2G541U8L3a7KQuWyBGQqz4CQpi8mSsnUNKIn7UdCYhVffYocmB8f0WA1rEElp/vwth9vqnTK5xHkNIULc2FEM7unpZ0I2ICT3Lgkt7Q5ZAeyFNTfjEPt5UcUX2Olxhk1YLoExSUEQcqqfOX8XYSayKTGUcaiN37rCcrQtsfvUOaVD10cuJ6EjfnFgYe2++b35qoCnpYIdZzDK8rRHdM8Ui7p81Hkq94RV9bEN42MZnzwQETWifLDm8yOa+Xb5GmkA3QuAs861LZm+bdvxFIO17M+MgWG6ptJEmsKJTM9HAMcm3G6UhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xvDCZQK9ecXnJFCxSW3Tq/ypqYBn51AjGZmqMdM/bo=;
 b=P2ND9EPokDBTZd4bgR0kzCbnXCj1AcBNpvJzrgjwvHfyrSW5UI6uSJ1CAcpdjs/RX3I9nWuw2qpZX0EvddB0F1iCESbp3UTcF9322gL1VD2Y/9Lyo9Bw/PJG4by2tBbHpXC0KjhbEJTfVkgN+UZ7dN2nlVmcUreMiB9pydwK8gLS3NzIh8cb9J6c+T4h6NKjSNYBWU4VRGN98BRPYHv2jzZ4amfzBNqipOhM0XKJvk8XuOLgfGZKzk0y95lHmJ6ol/tpPIsHu77243Cz5Wuzr21NksYPgM/p777McH/l1xHQts0rhEd+owvLdOwby8Ce3Dx1c0jVrLctaRvv7W4cdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=barclays.com; dmarc=pass action=none header.from=barclays.com;
 dkim=pass header.d=barclays.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=barclays.onmicrosoft.com; s=selector1-barclays-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xvDCZQK9ecXnJFCxSW3Tq/ypqYBn51AjGZmqMdM/bo=;
 b=Xur/YZamCMlSiav7XnukSpamthubqTNfYxtag2+AkLVeJxZYnPEuDNtcQhAzRxVXxw0qSyEGnsFVerMLPkFRBvlruy5wHocYkhOxDSmBsE6m4EUrDWOAAMAtoz7O2wIiA5YPjjT9o0vopx8wyCHrNxZpJu9GIP15Vi07IgI5NSc=
Received: from AM6PR01MB4166.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:25::17) by AS8PR01MB7494.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:250::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 21:43:24 +0000
Received: from AM6PR01MB4166.eurprd01.prod.exchangelabs.com
 ([fe80::d167:5f40:27b1:e153]) by AM6PR01MB4166.eurprd01.prod.exchangelabs.com
 ([fe80::d167:5f40:27b1:e153%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 21:43:24 +0000
From:   <mark.yagnatinsky@barclays.com>
To:     <tboegi@web.de>
CC:     <git@vger.kernel.org>
Subject: RE: idea to tweak wording of CRLF warning
Thread-Topic: idea to tweak wording of CRLF warning
Thread-Index: Adc6wfQ2HimUVa4FQDejoY5WlEa3eQAHH3AAAAAVdMA=
Date:   Mon, 26 Apr 2021 21:43:24 +0000
Message-ID: <AM6PR01MB4166CB21A23BC78D1757D918F9429@AM6PR01MB4166.eurprd01.prod.exchangelabs.com>
References: <AM6PR01MB4166BC567911A05016DE2918F9429@AM6PR01MB4166.eurprd01.prod.exchangelabs.com>
 <20210426205510.snoqwdipq47fkhbb@tb-raspi4>
In-Reply-To: <20210426205510.snoqwdipq47fkhbb@tb-raspi4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Enabled=True;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_SiteId=c4b62f1d-01e0-4107-a0cc-5ac886858b23;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Owner=Mark.Yagnatinsky@barclays.com;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_SetDate=2021-04-26T21:43:21.3933666Z;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Name=Unrestricted;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Extended_MSFT_Method=Manual;
 barclaysdc=Unrestricted
x-originating-ip: [167.203.54.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 124ccae5-d753-4703-4951-08d908fc5194
x-ms-traffictypediagnostic: AS8PR01MB7494:
x-microsoft-antispam-prvs: <AS8PR01MB7494FE9996505BFB4A721560F9429@AS8PR01MB7494.eurprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MzSXs3y0+yfGeXAny0s2gI8xSfppdNsJxcDwm2BnSnRFdasPUKiymwv29s6EykkNInVJOfwHK1YC3T0PGP4LA0o3aKF7xTROnLEAa3FRDqJxFpWKlc7Y4oHiFiuWcSb3E95zb6grX//w/Iu+4/sqzBqwGPyS3nZyWh12zvdiM20Ae5LsY+nL8flWNTldjJY0J/trWxvKUxwsRekU02399uBif6EAZuklU6+8sH+EGU9BEXHE6ZXRZlzpRHWpxq0+0a5FFogm5/TXaPZXrYG0ASqQiZNVATwKIOzhidX6X7biqLOz5lfCpsifp1LB8u1r/m4jqVeLVaZjiKtGjinLRhaKXHi3dJR7mtKBlW4e8NdmY+tT/V2jOTZ1kgDACWr2SRR7j2rR/Aqin8FRLUXSC2vVns/AeTg1vizo82sV4fkdr3P1IcIi+PEqDC8t056NpsxZxn72n5UwQol4TKKSfyZ7yPA6H+22kzPwzSWLGPJJoTNtnRaeA7KF6HJpZDGBa24yEPQIjIaFkKPXXvSHUUnxyuPtZgl6S32/129NiXPjlTRJ8QMZl94Xcx/xn7NyEEbBCBk3lYxohYbydlhFSJTYwyP2Jg0PSO/nnywiHbY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR01MB4166.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(4326008)(71200400001)(86362001)(10290500003)(316002)(66946007)(76116006)(66556008)(66476007)(66446008)(52536014)(478600001)(5660300002)(8676002)(64756008)(6916009)(7696005)(8936002)(38100700002)(33656002)(83380400001)(55016002)(122000001)(9686003)(186003)(26005)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?FBGfohWqsKV4ReZ2kcbFzEmoae15lp/X5zsGPQ5+88WKwYCOBpUcNfcLk+?=
 =?iso-8859-1?Q?j/g+nkOuGOImYe22r9ZqCMPARHeTZrsOzqZuQvI1yn09GNR8k3/O8AaJBq?=
 =?iso-8859-1?Q?JW1shNPwc0Nm1PI0ZAbjRSXJjkc70WU6sqaKecP6l/5V9BiVgqaa+XB8D9?=
 =?iso-8859-1?Q?o5hY2qzMsBzEnWw+/mG/kfvUJ0TuyGTkto0vdUk3lNY8uEAJ1dLBnSK3yQ?=
 =?iso-8859-1?Q?0uOcd7d9OpR13vsLHkqzmR9kAKcDfvD4LhJV5D7EKUsLkpVbqdhrsBvpAh?=
 =?iso-8859-1?Q?EUTFcCHb5BjB3cBeQ9CIiEigw2r/+6Eaq/3245iseEmR3e9w9NYyDHITA/?=
 =?iso-8859-1?Q?SB1JeTniC/I1mqZo/uvAcri3WTduOUFnP9Ehm/gNTlOqTHyamoro4ayGnC?=
 =?iso-8859-1?Q?Nxi9LA32U67pKxAN99j45gwJ8f+0rML+b8vJSSaI1sU2fSQgHcFHx32x/7?=
 =?iso-8859-1?Q?NahLWeLNkJJu51NUbhgQeOizWe0BCivNXdWGc+SDlDYkhfKSr7ro/zrDSz?=
 =?iso-8859-1?Q?8H5oC6t+kdxT1kVRZRYZLOyzKJaqvb+caR+06rHk6JlMLLdxzONgRcSB+t?=
 =?iso-8859-1?Q?z8KseTnm5NQ8SqtFLBJAr3SgZxLLFa/dbTxNhEQguLEGTBlt8j4M/JFkiZ?=
 =?iso-8859-1?Q?oxH8CN5/e9U4ZhQVzlW8JEgx3+qhBB/vgGuw6gdDOrFsc0ZcQV69PE5kXc?=
 =?iso-8859-1?Q?+F+sRwmSWAq/pI/fP6mNSoyTUC7TH+YlYh6H+mBsY9Z9P6psZU43ZbWjcS?=
 =?iso-8859-1?Q?hHgCEsI3r2htM1HQ7xjpQH8ci+Z+H81w7KpfFPA7dVxOlskRThQHyq6TWA?=
 =?iso-8859-1?Q?vfk1sgmYhx3wIyZ1pMvu79j45yQetSbPU+xWcxTd6oxucMr2z/b8rIXOVK?=
 =?iso-8859-1?Q?rryw4k2joHBPgHODM9DQT4YYgodrkAkGPbP6phG+nPPA2VnN7s2tQK+S5z?=
 =?iso-8859-1?Q?CCqCvrvDCUyVDRbSgUNrXP2tNjurHpqyaIkoPTuTJ5QA+z5FmwTZzMpZW8?=
 =?iso-8859-1?Q?SczKxpZgJNgB1418cSvpNvwDV0ygjhJ+DW1+wLr/ZEANCkm66MhWFvHqRU?=
 =?iso-8859-1?Q?C9EpR0Ellw50I0J9uT04j2et1mZI0LKqDY57r5VGRu8i7jqIelazfLgZD6?=
 =?iso-8859-1?Q?PEvRK1GujmtcZtOyS7tCQgMzT574z91BMMwQCVgKMvgKuv+34SRpzklJwG?=
 =?iso-8859-1?Q?lau5+YDiLTmbVmsBurn2RQPEmEqgIQv2GDXQvS/bsXQ5AUsTASM2SRG/ON?=
 =?iso-8859-1?Q?yOK6GunX8GTDjkTwVddTitDqM73n2Ogy89fp8fmTUS42K3OyNte+7aWkms?=
 =?iso-8859-1?Q?H78Ft+cB3WIMsSWdPLIAyKJu7tGm4bzb1pGIQohxhgETfMlziPoj1U6oIE?=
 =?iso-8859-1?Q?ePfMuE2zkD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR01MB4166.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124ccae5-d753-4703-4951-08d908fc5194
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 21:43:24.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4b62f1d-01e0-4107-a0cc-5ac886858b23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTPZT4nypXXgLz9F/i5QDWFNBDJTrxDTW6v4cvs02pMmFt7P0Mk2TjNuSjmu5QH+AxcYCWctrARGy0dLZ87ZJG6VHEBkc4pepqLvNIcEEus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB7494
X-OriginatorOrg: barclays.com
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUiVtAirvvfuD3BoHG1lkXXlW4mi86Or4wO
        TB6fN8l53H62jSWAKUrUpiSnWKE4taQkMy/dVsk3NDhESd8uQTRj1/wljAUnVSse3HnC3sD4
        VL6LkYNDQsBE4m1DShcjF4eQwB4micnrWpi6GDnB4ncnPmCDSNxllHi59CsThNPKJLH0egMr
        hHOJUWLjr5nMcM6vWQ+hnEOMEg2frzGCOIwCy5gl2tZ1skA4p1gklpw/zQKyhlFgB6PEtJfp
        IDaLwFZmiW1LKiDa1zJJbPu6jxHCecMoceHmUbDD2ARUJWbtXA9miwgIS+w/Pp8R5BFmAUmJ
        GctCQcLCAkYSC6+vYoYoMZZY9WIxC4RtJXGuB6KcBWjMueXxIGFegUSJL78fQT3Uzyhx/PYR
        JpAaTgELiXXreCHuFJP4fmoN2FZmAXGJW0/mQ4NJQGLJnvPMELaoxMvH/8Dm8Aq8Y5GYufAn
        O8TH7YwSlyatYYWoUpCYvPIgG4QtK3FpfjfjBEbrWUgGQ9h6EjemTmGDsLUlli18zTwL7FhB
        iZMzn7AsYGRZxcjj6Rvs6x7s42RmYBSwiRGYQLgMO5x3MF488ULvECMTByMwDjiYlUR42Xa1
        JgjxpiRWVqUW5ccXleakFh9iNAUGwkRmKdHkfGAKyyuJNzQ1NTAwM7AwNDU3MFQS55Xp/xkv
        JJCeWJKanZpakFoE08fEwSnVwNSapzPDbMHEqyl+bnN+HbZ5oux0469XzoGlnXIffs+xX8iZ
        KhAmejPlNmfLcaf9Yf6FU63n9u24I7FyvVLaXLM0Nf4jn19eevyX9y5nZ8G92x1L0/47Tz6j
        bBcnKNWhUO2tvpPxenJrkPBz1QU3F2xY5XqnpCJePkR15bfwsMILBS+jKrvrpn1lun3gpinn
        4Ya0/e3OJsnZzXWKjj9e8XvtX9mqt7zn0sa7hXyb86xf75rfr7x9y0VWuy2dRxf4LmxRYbxZ
        IfpCZo1q0Y6K9lsq3va38ryFP6/s1Nr06uGr2f8m180X5NAs76iSevTHQTj4Y96a0Mz/vP+m
        t55qMJKd8/xA652AI57xW6Ye9VNiKc5INNRiLipOBACfLoHcqQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyzUYRzH93y/X+fr5vRE5RMhNps0urjqJGIKqRuLWquG2/qGJekolOpq
        SeinX+tMLguNyY9+XLIiN5Isyip0lCs/00oda85WOY9a/73en+f9fN7P53keljafYKzYmLhE
        ThYnjXXg8Rm+Xv/L5bd7eqSwSGUvznydRYkzzk8hHypQd8c2UDOsYkKo3fwN+7jYmKOcbJV3
        JD+6XlmC4tsckwf6Bo3laMguE5mwgEXQf3WAl4n4rDnuRzBWOkURkUZBabfciIguBLV6Bf1P
        6Au080KNQK57iwwC4TIazlVlMEQ8Z6Cks50xxCBchyB/LMrADL5Pg6okmWy/TYFqqgER8QXB
        y94WyuDiYUcoeFg9x4uwBTS2KmdNLEvjpXCtbIehbIHdoLi7giYWd6gYvckQXg8dF4idmW3T
        cSvCUBZgKUzOfJwf6DKCVk0zZfCYYDFUVQnIOZfAz+eVc6k0toR3g0qKXBOGkkedNOHFMPbp
        11wfAf7KgKJ42phMnI6gK7vSiLiWQ055E4+wDXQpsxBhCbTWT/EMwYCd4ek77goSF/yXR9gV
        evJyeYRXQlnxOF0wN8NCaFMMMjcQU4FMt0hCJQGh2/xChKKQO2j2UyyJP2tZh8qbR13ViGLR
        7NOwtMMiAa8+LdJcsE+acoyTHYqQHYnlEtTImmUcLAUeKr9IcxwlTeQOcFw8J/u7SrEmVnJq
        6zKnFesCRkzt1vi3+YrYe/ZeQ8sVtunC/NOJAr6i2UOThzQnelVPcWdRbXcQLXncG+zZuOvT
        4EjMxb5VmrcthZNVnvIH7kHHnZOwZ9Yz39Akp+OVl9J8N7vJO+PDjLrOvKGbntSl7MlteuHj
        9lmmV7lc944ohOG8IHt9e78TOFUHnWLYhDN1ZrIMO63L8E5dT8PhqKhU7X1Fe8Daap3paZu1
        Jhv2B6P3QnXcyRmU/qPpw3bri1kb/RWismm8eFdv+d0eXY9Wma1enWRfs+CV+Lsk5ptwo3OG
        u7H6bOymsHGv/r3+yoO2r0U52pbUTWsmsKWVaY1ZuG946swA6nNgEqKlq51pWYL0D7clXmaD
        AwAA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Is that material too hard to understand, or too hard to find?
> Or does it take too much time to read?

Easy enough to find; first place I looked.
Too hard to connect the stuff I was reading to the error message I was ge=
tting.
I saw things like "git will normalize CRLF to LF", while git itself seems=
=20to be warning me that it will normalize in the exact opposite directio=
n, when I'm already committing LF.

> However, as a very first step: "or something along those lines." needs =
to be defined.
> Which short text would have explained the whole story better?

If the goal here is merely to explain the whole story "better", that is e=
asy.
Add the words "on checkout" somewhere near the end of the existing error =
message.

> git checkout t.txt (which has LF) in your scenario will not checkout th=
e file with CRLF rigth now.
This shows that "better" is not the same as "perfect".
My suggestion is indeed a bit misleading in that department.
But I think it is less misleading than the current wording.
It doesn't take the user all the way to the final destination, but does p=
oint them in the right direction.
The current wording pointed me in the wrong direction.
I think, but obviously can't prove, that if the words "later" or "at chec=
kout" had been in the
error message, it would have been clear enough that I would have eventual=
ly figured out what's going
on without having to ask on stack overflow.

> In that sense: Suggestions (the complete new text) of the warning messa=
ge are welcome.
Okay this is actually kind of hard, since there's a tension between being=
=20concise and being precise, or at least not lying too much.

Something like this might be a bit too verbose, but tells only one white =
lie ("will be converted" should really be "will be converted unless your =
git settings (git config plus git attributes) change by then"):

warning: t.txt will be committed with LF line endings, but will be conver=
ted to CRLF in your working directory the next time this file needs to be=
=20checked out.
Until then, it will have keep its LF line endings in your working directo=
ry.

Alternatively, here's a less drastic change that's more concise but perha=
ps still "hand-holdy" enough:

warning: LF will be replaced by CRLF in t.txt the next time this file is =
checked out.
Until then, it will have keep its LF line endings in your working directo=
ry.

I could come up with more variations on this theme but I think you see wh=
at I'm trying to gesture at.

Thoughts?
_________________________________________________________________________=
_________________________________________________________________________=
_________________________________________________________________________=
______
=93This message is for information purposes only, it is not a recommendat=
ion, advice, offer or solicitation to buy or sell a product or service no=
r an official confirmation of any transaction. It is directed at persons =
who are professionals and is not intended for retail customer use. Intend=
ed for recipient only. This message is subject to the terms at: www.barcl=
ays.com/emaildisclaimer.

For important disclosures, please see: www.barclays.com/salesandtradingdi=
sclaimer regarding market commentary from Barclays Sales and/or Trading, =
who are active market participants; https://www.investmentbank.barclays.c=
om/disclosures/barclays-global-markets-disclosures.html regarding our sta=
ndard terms for the Investment Bank of Barclays where we trade with you i=
n principal-to-principal wholesale markets transactions; and in respect o=
f Barclays Research, including disclosures relating to specific issuers, =
please see http://publicresearch.barclays.com.=94 =20
_________________________________________________________________________=
_________________________________________________________________________=
_________________________________________________________________________=
______
If you are incorporated or operating in Australia, please see https://www=
.home.barclays/disclosures/importantapacdisclosures.html for important di=
sclosure.
_________________________________________________________________________=
_________________________________________________________________________=
_________________________________________________________________________=
______
How we use personal information  see our privacy notice https://www.inves=
tmentbank.barclays.com/disclosures/personalinformationuse.html=20
_________________________________________________________________________=
_________________________________________________________________________=
_________________________________________________________________________=
______
