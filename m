Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC40C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 08:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DB420738
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 08:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=man-es.com header.i=@man-es.com header.b="vQuipy8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgFDI1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:27:33 -0400
Received: from mail-eopbgr80132.outbound.protection.outlook.com ([40.107.8.132]:31299
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbgFDI1c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 04:27:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnDx8T3WfUQIXFFfbU6hv8zr/h2/3j0N4vH05pTGFRajFvElQJPB7pvCZRMEaLtSSEiLfX8GdHse9Lzt9e1OoNCJEENLBagPyXbs0y4r2ful8nhaytJ9zrBk6h+n1eQxGRRpYq6kzadgZMN1OBf5AbnPKSGyczQWQsnMJHyU58uT2f617sT56malQ5sQPr4w22TyGu9fvtag5Huz/rbLO2NrrCwTnmjq4XN/PuwkKA12lm4sIXBMKjxQYmlnES8XedCFqltBtzo6EzpFGbh7xaJFuqtM8KYe6YYENtzp4G8ocPlce2BoMvT/9edOD07E3feIkWod2QfAZgxaV/y4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtbK9nCEWOLU+YvfdB2jlw2oigg3ps7E8M/u0kEjw3M=;
 b=NSkF6/m02AT3UykVdPjr/9G3DbFXjHJBJ6e9WUWGl9MtSlTRkekrQwozfbVgdGC1I3x0Ye0W/QUd5d53jZPuJuFm/fQzyvKow0QJw6k72brtmjYoRNmah59sSISLhlLIqAG6qfVTEI8w/t6VcktDRP991+7mAtv+6XJbVb1WEbZ2d/dWmO0wzhW+t+kLMfCOJP5GVM7GrqIagU7Oqq8XLhXc05BPf+4EqOE8pWRQdEx0gdCuMUW1EeeBREvUteoSexz3xSO/N8pQa69riiOtEZoP+2BA27c9rnOTlC7e17Lh8bxJrDvrDXZcYxpSz5faYLLkBel9Tgp+Lq9qhH1tuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=man-es.com; dmarc=pass action=none header.from=man-es.com;
 dkim=pass header.d=man-es.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=man-es.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtbK9nCEWOLU+YvfdB2jlw2oigg3ps7E8M/u0kEjw3M=;
 b=vQuipy8SK1Y5rOq4ZOHkdqwo7xG57v5CbkfPQO3K3Bq9fHVQrISdT/mNZkhJ43ljsf5OzdIovu3kYKAI/QxqY4hs9JDSKK5FKRcddc3p5BkHI63C8A2Qib7o2U/0GS8IzSxxEUD28madgORjmrkQHiAamtoT0bZQoTP6Mz2+r3M=
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com (2603:10a6:208:148::23)
 by AM0PR08MB5410.eurprd08.prod.outlook.com (2603:10a6:208:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 08:27:29 +0000
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::f05d:e55a:aad9:8bc2]) by AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::f05d:e55a:aad9:8bc2%6]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 08:27:29 +0000
From:   Kalle Kromann <kalle.kromann@man-es.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: The commit-msg hook is not invoked by git-merge as specified in
 documentation
Thread-Topic: The commit-msg hook is not invoked by git-merge as specified in
 documentation
Thread-Index: AdY5pP6PAidBAzepRc2W87PwqBsBqAAOCPWAABsFR5A=
Date:   Thu, 4 Jun 2020 08:27:29 +0000
Message-ID: <AM0PR08MB553711CE7CE5D39EC2CE8422D7890@AM0PR08MB5537.eurprd08.prod.outlook.com>
References: <AM0PR08MB55379DD182941E93F3BD3D37D7880@AM0PR08MB5537.eurprd08.prod.outlook.com>
 <xmqq367crlti.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq367crlti.fsf@gitster.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=man-es.com;
x-originating-ip: [85.24.121.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8af531b4-9fc8-4e02-9a97-08d808611ee7
x-ms-traffictypediagnostic: AM0PR08MB5410:
x-microsoft-antispam-prvs: <AM0PR08MB5410C178010D18D232B8B020D7890@AM0PR08MB5410.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGqLBYbP5LH9dXQdPZZgWcsoMxgintjEwQiXwgww4OgEbrsVb/Le5KQgHrwM+LVNIHR0YRJzdUFfvSsHicvHBzdh5PJezSTjrgrgS7aQbw8IqRf5FZfR4c/Uz8gjBa27Hf0pfTeSOew0Fi9GaK3NFl8w37DIU7L7QJTklN+//eykItrfcZU22W9C4q+72n0JIExrqwZSzWIoOF286TIxl2MfEbcTvnnGIWOHH3pQ6BjXbqksTodE2zlLL3rMmzJXkY/KejWYB0c/8j9K507z7yOCRjAUw35JIiu/e2Z9mLskZpkXjRuqcvofu56NOBDNrk6wOqQcUuzIx6eQZ2Uaeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5537.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(66476007)(6916009)(66556008)(26005)(186003)(66446008)(64756008)(8936002)(83380400001)(7696005)(55016002)(316002)(2906002)(44832011)(52536014)(86362001)(71200400001)(5660300002)(8676002)(6506007)(9686003)(4326008)(478600001)(66946007)(76116006)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WH6m3Ogmg+1moOQEB4Sm81WVNDRFzYpmk1Js4YHnUTWaBG5uCYJqBzJ8mYDbmm8OiGuXw8k4db7ASjGBG57pQGA8hjCYZGPyLAmr5fIQoDJiNDfFECWKoBHFGW1pKLRAw4EQOgPr6/7WE1uCg7KTXijU9n9svI8HtCEukMnQMPqjGuqGR9ipf9SYS/ZS4Qls79Y5NASd7/EhEjjaNV5AFe8ev5+Bj0rkudghIHfkUhgU0pdSydZd8GJDzHTGPymLvJW8LC/fRfvjQmjh5T8Vl+oRsC5KFUaOjvX9ZaghxYRe0MFIq6SjRz8aXruDLCFiD9LGZ6DH3kAJU7XsOLHkjKEbFl40zZ/W/ZTzoRO6M+zzPGdogZVBE2FgZhi4IncwjN1iad6Q3S9mAd6fh+F+GboNr+BdbZhz7lYuCLyYYo/liQTRXQHnLORGCIfWwIxCUKxOQj04qsQLlmRyTiwwQDw5E8ydo2FDfEtwmDVpyxw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: man-es.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af531b4-9fc8-4e02-9a97-08d808611ee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 08:27:29.4900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d5f1616e-c93d-4966-a1a4-a5ccabbd76cb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBFfrLoFQT36k4XQ3IslB9B/ERuKn3QaPHi1qnkG5K1Y7vy7rUM6HFRdLArHL3hRVPhac1iBas1zl8LZFCkd64sepF12mHmc0pjTAb9IFkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5410
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, thanks for the reply.

Sorry for not including it originally, the platform I was using to test was=
 WSL (Windows subsystem for Linux).
And the git version was the latest available from apt-get in WSL, 2.7.4.

It seems like one of these things is affecting the execution of the hook.
I just did the exact same test in Cygwin with git version 2.17 and it works=
 as expected here.

Do you know if it's a recent change that git-merge should invoke the hook a=
s well?
Or do you think it is related to using git in WSL?

Thanks again!
This is an e-mail from MAN Energy Solutions, branch of MAN Energy Solutions=
 SE, Germany (CVR no. 31611792).
This e-mail (including any attachments) is confidential and may be privileg=
ed. If you have received this e-mail by mistake, please notify the sender b=
y e-mail and delete it from your system.
Any unauthorized use or dissemination of this e-mail or its contents in who=
le or in part is strictly prohibited. Please note that e-mails are suscepti=
ble to change.
MAN Energy Solutions SE (including its group companies) shall not be liable=
 for improper or incomplete transmission of the information contained in th=
is e-mail or for any delay in its receipt.
MAN Energy Solutions SE (or its group companies) does not guarantee that th=
is e-mail has not been compromised or that it is free of viruses, intercept=
ions or interference.
