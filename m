Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2272FC433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 09:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41E8206A4
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 09:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="tDZvMotw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgFAJXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:23:13 -0400
Received: from smtppost.atos.net ([193.56.114.176]:25737 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725290AbgFAJXN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 05:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1591003390; x=1622539390;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=FLdySBCT7dHViBxnqNYWg4Nu54oLbVDPwulZeMJu2HI=;
  b=tDZvMotwpTYPoUPsB8npXAo+i9A0ger6zUFplscy2Wf07GR+xu4uQpdy
   wyN7ItdBg39+kZ9ywWtbkTD3qFBukPkNiAJm4w8D+R4iliuj4vOUOQS0M
   kPG0pWytC4GO2bkH635HJtRgBO61RYQSxVGHo7XVAvA/f0zB7Keg+rZdr
   w=;
IronPort-SDR: St3QDpVAwkDHkj+V0dgSVFY3GVy5GCX2pFnlW/DMbmTR5cxJb7tvLMIPzuw+6yRCvwFK/woPcY
 d1rzmI2PJdXOSOoQts+SYBTWPxjXk8mQDx1FeThIrJFrJ640EZgMtwnv+/J0ykcmEyHgMnmjU2
 r+ahi631JQ4pqff1uBxF7xKwHoHwjfv8+o3PJ197h2Ji4WhmlgL+5ngOkT/AFMTD18P/ucUpdi
 pCsFwsaKrF9+5iuWZQonqpX1zigADHkY86N3ZTr3E3+At/y0/2M1EJCMFHr9XM3VwBw/yC5dQD
 RZr7zPxd2BruZIwvUzWkba2r
X-IronPort-AV: E=Sophos;i="5.73,460,1583190000"; 
   d="scan'208";a="59827999"
X-MGA-submission: =?us-ascii?q?MDGBrHLyfuNeYCZZ9vjHlElzArIhr12qfovhXA?=
 =?us-ascii?q?wNTO99iuRv17EuzQGQF6jdOAovESjz5vZsnheI5/lDHo8+FUbFv5YGeV?=
 =?us-ascii?q?7OUmjXlq1aQNOhflseM9STBkgLn7ClOtOsWhsnEllsGmcdz+ns0RPdw7?=
 =?us-ascii?q?21?=
Received: from unknown (HELO DEFTHW99ETTMSX.ww931.my-it-solutions.net) ([10.86.142.101])
  by smarthost3.atos.net with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 01 Jun 2020 11:23:07 +0200
Received: from DEFTHW99ETQMSX.ww931.my-it-solutions.net (10.86.142.98) by
 DEFTHW99ETTMSX.ww931.my-it-solutions.net (10.86.142.101) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Mon, 1 Jun 2020 11:23:03 +0200
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.98) with Microsoft SMTP Server
 (TLS) id 14.3.487.0; Mon, 1 Jun 2020 11:23:02 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1Pk9Q8fsLH2MRP4D5uHvBJt1VjBq62rzUULixj7PsdD7gJiUZh7Y0dpDaAbacUSB2Y/eip1YLmTmVMiowcVK+ASIugRCpUgl40WtWlWt8eNb60bdHlmblJvW6Euk2YGTzV1y8qCEFTfqT8Q7AG/2EyO42jBHVMJuJlpfSmRCZL9xVftLeQ552aFeR+KH1aNp+Zmb+OMRub17rxyykkOn7zG+29VfFizgdJsn5ZWQagVTODbxhbJWxgmR3LOPNj3qyUmFg00JMsbohuJJNOG0vFfrmOKkCSEfkeqL6fDVJHazXoo9Uryc9Z/c9w+X99/jAnBLT7lPtK42yCcMUNpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLdySBCT7dHViBxnqNYWg4Nu54oLbVDPwulZeMJu2HI=;
 b=f7mqkIYUHsVgNKFZVcD2adqKhjHqE0ym712qAP6UMXcFY+t2ZFnVmGS8xZ7lK2FL5gOHNAdv9djLUbKijgIgnhSRF0hvb4VMb2DM3cmTKVtF4XE7tSz88FXPN1t+0Ph46hGIHbfb2tR0ADyP277HwiNvGjIZjFPj2R+bZPXqXyvEuDAqRbklSBHG76SrX1LYzZnlLeGLpNjHPL78SlHDUsYfTyPyVzP1PIMX17BUxnpCBivdgZP9TOFizdT6fb4iRvgqN5OJ7Hr0HzCeHf8J/Jh9VdHix6HW+vT7sqoGQGbgkI7ZzGpRuDLsa+erMmOG5YSE0jHin2O2r7WsfafQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com (2603:10a6:208:df::14)
 by AM0PR02MB4082.eurprd02.prod.outlook.com (2603:10a6:208:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Mon, 1 Jun
 2020 09:23:01 +0000
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::a0e5:332b:1ec1:b23e]) by AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::a0e5:332b:1ec1:b23e%7]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 09:23:01 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Git Mailing List <git@vger.kernel.org>
Subject: RE: [PATCH v4 1/5] rebase -i: add --ignore-whitespace flag
Thread-Topic: [PATCH v4 1/5] rebase -i: add --ignore-whitespace flag
Thread-Index: AQHWNE0SaS0VWJWkeEaxpXaaQGYeA6i+W+iAgAUla8A=
Date:   Mon, 1 Jun 2020 09:23:01 +0000
Message-ID: <AM0PR02MB40817D1733D2070B8E0154B39C8A0@AM0PR02MB4081.eurprd02.prod.outlook.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200527173356.47364-1-phillip.wood123@gmail.com>
 <20200527173356.47364-2-phillip.wood123@gmail.com>
 <nycvar.QRO.7.76.6.2005290437350.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2005290437350.56@tvgsbejvaqbjf.bet>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Enabled=True;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Owner=richard.kerry@atos.net;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SetDate=2020-06-01T09:23:00.0741880Z;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Name=Atos For Internal Use;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_ActionId=404b7074-b2b5-42be-83ba-808f471fff0c;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Extended_MSFT_Method=Automatic;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Owner=richard.kerry@atos.net;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2020-06-01T09:23:00.0741880Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos For Internal Use -
 All Employees;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=404b7074-b2b5-42be-83ba-808f471fff0c;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Parent=112e00b9-34e2-4b26-a577-af1fd0f9f7ee;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=atos.net;
x-originating-ip: [212.56.108.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fc11e19-541c-467a-d412-08d8060d61af
x-ms-traffictypediagnostic: AM0PR02MB4082:
x-microsoft-antispam-prvs: <AM0PR02MB4082A4D8BEE5CF830DCB9A3A9C8A0@AM0PR02MB4082.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sTy81YIDwv2syKJpu89gcD6wHaYIheQ46KQq0xejYIEXZqIpQ95otX7XSl1oAfsYZyHNHg0+w5VezCA9tHd+5Ab2IYnFUoh7gsQcVZWO5iFfYulLt35x9NCtQlZPlEDMuhstdQOgCWs6jZEVUUdWHAB3p4pv+ijuEiIt75t8wPJlBdNaAwWHpwgcgtPsfwUG8crkhSa+gw9R0Z/4t1Krj4DW5YnVgxB2JYoSC2BMPGsS+4Ot0yYuDHfyfO9j05UZDM7eiZ5tzuuDwWO9pfWQizvzMSvH1Ds0epiL6eyXDZT3F7ynMH8WHW9PPIjuseLtV1TDl9D98pc8EvuFiP3dKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4081.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(5660300002)(316002)(33656002)(2906002)(52536014)(6916009)(9686003)(8676002)(86362001)(55016002)(478600001)(71200400001)(6506007)(7696005)(8936002)(186003)(66946007)(66446008)(76116006)(26005)(66476007)(83380400001)(64756008)(66556008)(66574014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9ju9VlNZfts1/1X0CvGybPuBn+ljiBjY9tskkE/geKq2W64n4jbu+yLfK07TdCfrQId8oN2ItNGH/lQ/c6fKHeDAHX/uWVaFc29BGsqR00Y1uZikAG8fbuhKpxEZksdLZIY+mMTDID0R8y7b4igwn3YQ1uJBSqtE70hSH6tiNK2HKkU+5pMt06roZ4wD3U2kE3gqe+q08Sqp+wwCjyvBcB11AU+BqFk7kx8B19kDbog1pBY+lpEqrYbfCG+4xn3cToBG8gjerG4ngaZmsY98pixnQUxPgi8XGkoqBnYyp7lxuJGVwy6GuiaUS2NT3y51G6794y67crX2Qz/3Xtoy9pmzS/hjX9w+n22u5X4fi2YKJLFsvxruTNjPr6RGju7N4zFUyK5s/frUUF8TXVPOGc2vSThRTOttlWfHpytLDdkh/8jny+F/06yedYOe/mAMdrckoqU02fmmCLdvfBXj67wccWW0XTlcnDa2u+5bAuW1kWA1/2/R0V7NCIUa+Y8v
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc11e19-541c-467a-d412-08d8060d61af
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 09:23:01.4680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLA3fH2NqzvDcmAy/1LHGyh3Hr0cxswtKZGHJgfxOCs11r8olq6EWxh1STLE5I6VvBoR2E3359Y6j97nLIPvsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4082
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQpBcyBhIG5vbi1uYXRpdmUgc3BlYWtlciwgSSBhbSB0aHJvd24gb2ZmIHdoZW4gcmVhZGluZyAi
YXZhaWxhYmxlIHRvIg0KaW5zdGVhZCBvZiB0aGUgZ3JhbW1hdGljYWxseSBjb3JyZWN0IChJIGJl
bGlldmUpICJhdmFpbGFibGUgaW4iLiBMaWtld2lzZSwgIm9uIGdvaW5nIiBpbnN0ZWFkIG9mICJv
bmdvaW5nIiBqdXN0IGRpc3J1cHRzIG15IHdvcmtmbG93Lg0KDQpNYXliZSB0aGVzZSBjYW4gYmUg
Zml4ZWQ/DQoNCltSS10gVGhlcmUgaXMgYSBkaXN0aW5jdCBkaWZmZXJlbmNlIGJldHdlZW4gImF2
YWlsYWJsZSB0byIgYW5kICJhdmFpbGFibGUgaW4iLg0KW1JLXSAic2VydmljZSBBIGlzIGF2YWls
YWJsZSB0byBlbnRpdHkgQiIgZG9lcyBub3QgbWVhbiB0aGUgc2FtZSBhcyAic2VydmljZSBBIGlz
IGF2YWlsYWJsZSBpbiBlbnRpdHkgQiIuICBUaGUgZm9ybWVyIGluZGljYXRlcyB0aGF0IHNlcnZp
Y2UgQSBpcyBpbXBsZW1lbnRlZCB3aXRoaW4gZW50aXR5IEIsIHRoZSBsYXR0ZXIgaW5kaWNhdGVz
IG1lcmVseSB0aGF0IGVudGl0eSBCIHVzZXMgc2VydmljZSBBLg0KW1JLXSBBcyBhIHJlYWwgd29y
bGQgZXhhbXBsZSBjb25zaWRlciAiVGhlIGludGVybmV0IGJhbmtpbmcgc2VydmljZSBvZiBCYW5r
IFggaXMgYXZhaWxhYmxlIHRvIG1lIiwgd2hpY2ggbWFrZXMgY29tcGxldGUgc2Vuc2UuICBCdXQg
IlRoZSBpbnRlcm5ldCBiYW5raW5nIHNlcnZpY2Ugb2YgQmFuayBYIGlzIGF2YWlsYWJsZSBpbiBt
ZSIgd291bGQgYmUgbm9uc2Vuc2UuICBJIGRvbid0IGtub3cgd2hhdCB0aGUgT1AgaW50ZW5kZWQg
YnV0IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlc2UgaXMgbm90IHB1cmVseSBncmFtbWF0aWNh
bCwgdGhlcmUgaXMgYSBkaWZmZXJlbmNlIGluIG1lYW5pbmcgd2hpY2ggSSBtdXN0IGxlYXZlIHRo
ZSBPUCB0byBjbGFyaWZ5Lg0KDQpbUktdIEFzIGZvciB0aGUgb3RoZXIgaXNzdWUsIEkgdG9vIHdv
dWxkIHN1Z2dlc3QgIm9uZ29pbmciLg0KDQpbUktdIFJlZ2FyZHMsDQpbUktdIFJpY2hhcmQuDQoN
Cg==
