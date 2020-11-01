Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE91C2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 08:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CE322274
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 08:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.utoronto.ca header.i=@mail.utoronto.ca header.b="NJgdQtO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgKAIEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 03:04:09 -0500
Received: from mail-eopbgr670138.outbound.protection.outlook.com ([40.107.67.138]:45760
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbgKAIEI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 03:04:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIVEBmnP9wGpGMAGRQtEr/ZxV0G9+bVsJqksofggW3hNPV4pup1iArib+byPdMWbxhh630316tuGNP5UDig4lLGyuTcLJ6kaHeWMjoqstZqdzWu5Ldiny5z/Xoj8deQkQgl03dyRSDt/1Ytn4ztC71qE6kMjpEPV15VFFahodf+mLb/9MgirhfLmgH5J1c0jAuMi/3x1ftTz48FcNNSpHtLMK/sSfVEyBMwLUsfw2SnYHDlraCT6n2Ew2I0LOR+ewXlubJVV78XWZ6uRb9hKw54tkWTUQcwFStlhij73lttVO6sKnveSsViE5AY6MD948dBdajJsT3Z9vsMzMZISJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmUIr1+P5tZFDRPocfVi2roKXdnonxCViYdV9bENokk=;
 b=M0v2ctlI5KRZ5i2xQmi0elC8eWMGL1Z0/oh0GZJ+sKVyX5ryjVJG6XvM6fGfuYGyT/HwImYT2osvJwNwUKnqCZPWmO9RHXoyWN8a2Hb0garyjHOVy7Su2Psy+NjG9YIcE97mtg3DnPiRG2tjwha+NJPU5eYe5HX3kaFNiklnTRJoSL2K2fQt2EIgQUUMuAHofDaByFJnlviJNtXxgbC+oNd7bpNptz0aGfZOoY5Zr2lHnn1Bntrf/6d/+MOqYwj0PqvTMu9pTKZ0TVxDTV2PVX2GOQuPI70I/I+Gwr5YUv9eLWsudpDysrh8hLuJ+/jFscGHIMhASx0Qd7I/XpX6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.utoronto.ca; dmarc=pass action=none
 header.from=mail.utoronto.ca; dkim=pass header.d=mail.utoronto.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.utoronto.ca;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmUIr1+P5tZFDRPocfVi2roKXdnonxCViYdV9bENokk=;
 b=NJgdQtO//G3hvhiY0hN4Vb83SXHyg77HnoPCZLhS4b8X8/Emrss+EBjykanl55fpdept+s5rpso1JNK9zB3I7bmswSds7YkCVLW3abJu+qttfbLfQKd0bKRsoJsvFx1XDqR/H9jXymYxcr9re/hKE1kMy6fxmIBNqGpILjMmA7g=
Received: from YTXPR0101MB0717.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:7::12)
 by YTXPR0101MB0717.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sun, 1 Nov
 2020 08:04:05 +0000
Received: from YTXPR0101MB0717.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::709a:9d3a:6dba:fa2]) by YTXPR0101MB0717.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::709a:9d3a:6dba:fa2%7]) with mapi id 15.20.3499.029; Sun, 1 Nov 2020
 08:04:05 +0000
From:   Sibo Dong <sibo.dong@mail.utoronto.ca>
To:     "gitster@pobox.com" <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitgitgadget@gmail.com" <gitgitgadget@gmail.com>,
        "sibo.dong@outlook.com" <sibo.dong@outlook.com>
Subject: Re: [PATCH] git-prompt.sh: make `option` a local variable
Thread-Topic: [PATCH] git-prompt.sh: make `option` a local variable
Thread-Index: AQHWsCWRGDRbY3OUYU2suhku0nRwGg==
Date:   Sun, 1 Nov 2020 08:04:04 +0000
Message-ID: <1d19cdf35c12b1079cee0861469dc1a652642c82.camel@mail.utoronto.ca>
In-Reply-To: <xmqqmu02xbe6.fsf@gitster.c.googlers.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=mail.utoronto.ca;
x-originating-ip: [76.64.132.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc731122-8755-4298-2442-08d87e3cb3b7
x-ms-traffictypediagnostic: YTXPR0101MB0717:
x-microsoft-antispam-prvs: <YTXPR0101MB07171760729BD9F6C1035C4DCC130@YTXPR0101MB0717.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cXEEu0QQwBzdJx/pNjKH1KYl4c4fsK1MG17GMeUFOQq9JVEyV50yIlOvGZn1elsw2qXtiqLy2ZqarlONcoQB143TQ4cBuGFmXIAMOtIC7c1vfmpqTyaCpR6Vmob4BEmeF+azLG+QduxtsixA+kLxBuUXa2Fh0LXEsIZJJQ3GIOObuY/7CGGZgZIlKzN5zfrXS1rcpt4JE1xHc3hzxIgeej/snWq4h1OiEYfV9avvGIsSccFUla1dw3xa3EKFAs+EPe4d1d9F5e2orplxkajpa3bgUZFCDeB1lvijKRyb5rD4qASPWQzV/RxXP03rNr0oTeZ0CZwToap4/LKhCisPaQqeZh5k9HcMgyL2M6deBpAwdNc5mUdxwbihZlVsBEQd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTXPR0101MB0717.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(186003)(54906003)(71200400001)(478600001)(558084003)(86362001)(44832011)(2906002)(8936002)(786003)(8676002)(316002)(2616005)(64756008)(66556008)(66476007)(6506007)(26005)(6486002)(4326008)(6512007)(76116006)(66946007)(6916009)(5660300002)(66446008)(81973001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: thXej/MsIok8idM2y/5+ZwqdFesemdxzNO4AjXelLq7Phjbyv5qEkkyNf50FgGvbRHCO8G/j8CWEWod29gLJxaZ4V5M5dgWIVMxoKUKwrjfHSdDMG7JreUeeEADME1SLPPO43CJV4o9pEq7yr/0FoV8SSCRe6pVCF8Nzrj+28FxX6RHcGFQCLVpcnOrtFx7Yes2vCzz2+rafaZZi7976g+WDznc6yyCPFLvjsofcchzTxdDed6YaIE2Rwf/50gHIn1zxdDsmDyZ3l09pjfCwEJvZDDKcOzKSZXs+ecEAY7wTN9xjV76wacyAXCOSKNbpo7D+IUdNPxbWplOJ+J2+Uk16PptDsmqCms6cDlZvJ97cHJ+uklln7g9LFvdeX7cOi2Q43wMDsDk4G1cM/70AdC7Iz+42+Kh6qUF+T2GJJw4KhzGtY7AZOsL8Pvw7ncOzzVuqHBCg8R51SrIxKqHgi6xh6GFTOZlNRa2E/XASnYtJNPiiYc+xqbdITO91e79ZIZ9XrARhorIXcLiHoQb7aMb3ncOA98T3kLS+1pCEVkKsDGYb+83iRLuqGpMZqLOsGVEWvRf2T0DJHZwf1NOhDiCXvpX3xNk94sie+GMRZQGIjao40o/WIFAU/Ys60Dwd5TQyxkR+iXrCP5aRslz7ZA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C757F8B29B9025499E325F0D5C2CA908@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.utoronto.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YTXPR0101MB0717.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dc731122-8755-4298-2442-08d87e3cb3b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2020 08:04:05.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78aac226-2f03-4b4d-9037-b46d56c55210
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UIR25LgZUyYKOccjPmdwWxXsrcQ+fWL4M71LvICePDO7NbYb7hHftZNJxJakWaJRoksPAtX1RCxoQfvwkRsWOntRSiAgR1WM9+QzW16c4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB0717
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2sgSnVuaW87IEknbSBhIGJpdCBuZXcgdG8gY29udHJp
YnV0aW5nLiBTaW5jZQ0KeW91J3ZlIGp1c3RpZmllZCB0aGlzIGNoYW5nZSBtdWNoIGJldHRlciB0
aGFuIEkgaGF2ZSwgaXMgdGhlcmUgYW55IG5lZWQNCmZvciBmdXJ0aGVyIGFjdGlvbiBvbiBteSBw
YXJ0Pw0KLS0gDQpTaWJvIERvbmcgPHNpYm8uZG9uZ0BtYWlsLnV0b3JvbnRvLmNhPg0KDQo=
