Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A2EC41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 15:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE1420782
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 15:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=altairengineering.onmicrosoft.com header.i=@altairengineering.onmicrosoft.com header.b="Wzr2J5ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgJGPvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:51:17 -0400
Received: from mail-eopbgr760115.outbound.protection.outlook.com ([40.107.76.115]:51342
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728780AbgJGPvR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 11:51:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu+5mvJBv9IHWHacv9Te6s8tl3YpKL1ZRcMtMdeWUS2RKAoep2FqBzRvb5iaVT3IHAXc9VVMYVNT8Bm6pP4f4EBdFztRM3t9xjum/7vq4Wen2rcyosS9GQUq40U2nRcHeuus4+HTKPZOijV5bcuy1v56sg4U21Efyugg0aEeE1ZLlm0U+vCtwCUIiNisL6L4C3i9+JzugYQ7J8gAVJHhGYBrPS70SMcCx0VQCKHAh7xIpZ7FSlchmA4ML2BcV0ZQ7JOG2hvHJCcmieIMnSREUr5qZpOqQcMZ1dVVKHKACwsKY97rzh+m3IW6ms3G1GoXpcU/k0xitKgj3HCVMExdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m0SAXWDDMKeq3CIlQWpEDLcO5VD+Y8kgXKGv3FhXzo=;
 b=DGjN+RG6/cwuPa4UkjttGJ4bW6Rlh0fEnKbr4ckBN51Ybh96QJwY91T3RSH6eDDX8NiZcsAPAQNZHixNprpxt7EDJvIEgpYX6/MElN7J7QITjwHvtqfM8b5He897d13fnQevDH6YKaQ1qB0Zkb4YImSUXOfiR8lcHZ3eB2zacPDqeqiDNC2P1M2gqQL/Uo3G4yKj6qouHSoDi1mf/7T2NXbBbRqgY8gvCn1fWR6igA2CmxNokWp2uDCNAAnpg4kAsl2dlClve4Lx9GkqlfQaBvONMyh6ITDBUAnj4gM/OKY+J85QgNlfJzGnmx3h8ehoGt2it41zqtJamHC9we5v7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altair.de; dmarc=pass action=none header.from=altair.de;
 dkim=pass header.d=altair.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altairengineering.onmicrosoft.com;
 s=selector2-altairengineering-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m0SAXWDDMKeq3CIlQWpEDLcO5VD+Y8kgXKGv3FhXzo=;
 b=Wzr2J5igqBzeYMYZjkealU/vDoKgAdVtjv4/JLi0fEwc9QF8mOvltokkU1B7Ky/Qgpe2vKxHzpTRTgD4OBhGVwyaUVoAgvRszioJKu4t45XVCC+ypfrwXbjpLHtDFrBrjHR2yBMGAeJhlWJf0tK1IpeD6hECv7eY4sER6mzfPaI=
Received: from DM5PR03MB2826.namprd03.prod.outlook.com (2603:10b6:3:121::19)
 by DM6PR03MB3594.namprd03.prod.outlook.com (2603:10b6:5:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Wed, 7 Oct
 2020 15:51:15 +0000
Received: from DM5PR03MB2826.namprd03.prod.outlook.com
 ([fe80::6c66:3392:3508:95e9]) by DM5PR03MB2826.namprd03.prod.outlook.com
 ([fe80::6c66:3392:3508:95e9%11]) with mapi id 15.20.3455.022; Wed, 7 Oct 2020
 15:51:15 +0000
From:   Frank Illenseer <illenseer@altair.de>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git Alias not working in worktree
Thread-Topic: Git Alias not working in worktree
Thread-Index: AdaTV73poiKNnKCUSXa2AlwjpbGP8AAAzTGgAAwLeIACTYdMUA==
Date:   Wed, 7 Oct 2020 15:51:15 +0000
Message-ID: <DM5PR03MB28262362A9D3B0EDECBE6106B50A0@DM5PR03MB2826.namprd03.prod.outlook.com>
References: <DM5PR03MB2826A616AC30710E169B7237B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
 <DM5PR03MB2826C04CC5AAF3B61BDDAFE2B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
 <20200925222801.GC1392312@camp.crustytoothpaste.net>
In-Reply-To: <20200925222801.GC1392312@camp.crustytoothpaste.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=altair.de;
x-originating-ip: [195.145.7.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a8c63fa-e3b6-4497-7eec-08d86ad8d2d7
x-ms-traffictypediagnostic: DM6PR03MB3594:
x-microsoft-antispam-prvs: <DM6PR03MB359488F896F2E6BBD6D32E76B50A0@DM6PR03MB3594.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: scK3e3y31cpTh/SGrPTmGuuy58HKtFaVPHXGMJNpqWTzDEo2Jj/TJY8Pad+8GEqdSHmyrwHGcZjMCRsZfw/cmrfA5mrdwz2cvgtT+f69vAObIjfyny39VUBxTLuIUAFACF+XF2thVIKnElRD0UqgrOtfa50izpKvMqLe0upskKpwZsSX260nXOWeJ9lNj5wmzHLIB8XzLxsJ9ZYpk6SNT1GPLnn7O/ERpN2diTYe+wc/SNkaFJJ7Ui3/vLpZ6+As/6JGth6GsY4JoDE6l4otFcJ0o9LNHf8zp0OTFwJa5vbpG9ZbCIwLioZe00YlQWz8EA2qS+hh2fjUmBkNyUrnNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR03MB2826.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39850400004)(366004)(66446008)(66476007)(64756008)(66556008)(316002)(186003)(83380400001)(26005)(9686003)(33656002)(2906002)(478600001)(76116006)(55016002)(6916009)(66946007)(5660300002)(8676002)(71200400001)(8936002)(86362001)(4744005)(6506007)(52536014)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PufnxVaPW9XKdYnayymvP1pAcbBrNQJuHEWCQuxaPd5L689oS/jfcdKomyKo7RdfSJrFVTXuPoltue7dChn/zbEa6xzGJRxplMYwPBlI2R5bWV5hEB9jRgljGDRiJkvIg/b73abPXYFK6Mm9tJPMJqx0wRnvBoDqZpS6CD/yVRpDi84C5NUH8L7B0ntg1df17aBjWrovCuAu4NV80pBcfrFt3K6GwY3K7q2LJXx7U9zncgN04s5itYHgDtvPc3+gZG9RzOk6L9TGWDHWaBKO6J8o94mcKHWwEsGxStFUKPu2UB+OxGjBP7TO+frZ02vLy+1BBsC6mu0mLPecgyPpJAH5pRNRU5otN7AOxEiIFTWglq2VygFhB/56Y5GbNFZRMmLmg8MAI1aUecy1ZeDsdLGIYenIEUds3zHxtuY1Onvwgod/DaIOpRWN5hifhsHYefpdRlnfhy7BFI/OmLmgRumQW2qPwIQ7s24lK2jtP/vYJX+wfw37JCzmdxR/j5Z7VgGmBQ4N4GCtnntE2t5R5o5R7n1dnS5HHKo7sXUtMyE4opNOFHR6f6I/VZldLzGIZITWjb4iZObTmWYNZOpQaN3IozR1p6w0mjAfhYmq8Cn5WzfcxTSr73fUhwRjZmhkHcx0ecte3MGulj2Y2sgIig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altair.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR03MB2826.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8c63fa-e3b6-4497-7eec-08d86ad8d2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 15:51:15.4184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2bae5b57-0eb8-48fb-ba47-990259da89d2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xBAg01hCl3F6nsiTz2RiZLURdf49LyXeZpZWvbdzT/4SpZgZ7VuuVWxXb+AWQ1wym4q4qNVWTP+VXNPA1fD/zAKy8Su0cW/OrcWC+uCxHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3594
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzLCBCcmlhbiBmb3IgeW91ciBjb21tZW50cyBhbmQgaW5wdXQuIC0gRGVmaW5pdGVseSBh
IGdvb2QgaW5wdXQgYW5kIGFsd2F5cyBnb29kIHRvIGtlZXAgc2VjdXJpdHkgaGlnaC11cCBpbiB2
aWV3IQ0KSG93ZXZlciBpbiB0aGUgc2VjdXJlIGNvcnBvcmF0ZSBlbnZpcm9ubWVudCBhbmQgd2l0
aCBhIGxvdCBvZiBkZXZlbG9wZXJzIChub3QgYWx3YXlzIGRvaW5nIHdoYXQgdGhleSBhcmUgcmVx
dWVzdGVkKSwgdGhlIG5lZWQgdG8gImVuZm9yY2UiIHNvbWV0aGluZyBpcyBtb3JlIGVtZXJnaW5n
Li4uDQoNClRodXMgSSB3b3VsZCBsaWtlIHRvIHJlLWl0ZXJhdGUgdGhlIHF1ZXN0aW9uIGFuZCBh
c2sgZm9yIHlvdXIgc3VzcGljaW9ucyAoYXMgeW91IG1lbnRpb25lZCB5b3UgbWlnaHQgaGF2ZSBz
b21lKSBhbmQvb3Igb3RoZXJzLCBpZiBhbnlvbmUgY2FuIHNlZSB3aHkgdGhpcyBpcyBub3Qgd29y
a2luZyBhcyBJIHdhcyBhc3N1bWluZyBpdCB0byB3b3JrLi4uDQoNClRoYW5rcyBhbmQgYmVzdCBy
ZWdhcmRzLA0KRnJhbmsNCg==
