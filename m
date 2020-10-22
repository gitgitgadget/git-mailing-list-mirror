Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2BCC388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 12:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F7E221FE
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 12:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=altairengineering.onmicrosoft.com header.i=@altairengineering.onmicrosoft.com header.b="JcA6qNwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897840AbgJVMGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 08:06:02 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com ([40.107.93.102]:33952
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2897837AbgJVMGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 08:06:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtZ8CT53gYT4FJrIYgzY0jE5DPLgRUdVybP/qKUWZlQ8LsKJ3bN+p9es4K8hfkv+IRY6JUspW+SyXGERDxbNvcgR6U2+OUIW1QrP1soU8niiDPMrCJFeGQqF/6w7R0qEb++sFmN6oHv4UBiPumJI4T2qTWoP5rQtIHA9lYJkI9jkjL9Yo6OddI2MibA+rEos/4i498WX0/9Wn35eeuKicLibpp+iCnWSehmBNXVW/zxLbWerpuQPREgfdy2rQrpkYWrInCII853yF+xjDUsCuSkVoWEgwSdSgXgtxy08Lb8pyMA6akzCqUsJUT774ENyLvc1jwSthv9OGPEFYnW3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSsV/vWsKL8MH786VNL2ZPgRbuvlByLTKAUXuNBziLg=;
 b=GdHi+dTt3QyF3VZXpcQsnbNX7+A/URUjSo+oNObuRujW8f2tCs7eckg29XdP0rTdQxPhmhyTHdI0kxvPiizuFIAVP5gNVQhJPokdy7/3044KGhuTl1YLRrZmgVx5a/KYDgCxmqsTX9RcfOeX5GqTTmOq0A7VRDrLVo7LXnhXc8gJeDnl3ayGywelJhyOrcl7tYyBDl66mbWSyuKPEt4Ekri2ILu72/+sD2dKbD3HgQusCwYhnrk+ALEj61i3LThmxvQxj/TKsvmBkEt55REIMZ+FPSTq9fK3+bRhkdRsuowi+UQqLIilH1azqktp9dlTWl05K5Gmr1c8e1kCwPF0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altair.de; dmarc=pass action=none header.from=altair.de;
 dkim=pass header.d=altair.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altairengineering.onmicrosoft.com;
 s=selector2-altairengineering-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSsV/vWsKL8MH786VNL2ZPgRbuvlByLTKAUXuNBziLg=;
 b=JcA6qNwVNgRgVf+ggH2sloHJn07o+c+SB8lWXumRDmcTVfPoRI1IwI4LuZQW6RsaNi+++NFjEoG4GOyliX5TCpiIidQVm4I2odf2aZAkX5OXLZjEOm0Brb0HYiqCn3qq/zOWgvzbo7z8GRxgWt2EGsAPN8DwFQPDut/ZFyYGQg0=
Received: from DM5PR03MB2826.namprd03.prod.outlook.com (2603:10b6:3:121::19)
 by DM6PR03MB3755.namprd03.prod.outlook.com (2603:10b6:5:4d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Thu, 22 Oct
 2020 12:06:00 +0000
Received: from DM5PR03MB2826.namprd03.prod.outlook.com
 ([fe80::6c66:3392:3508:95e9]) by DM5PR03MB2826.namprd03.prod.outlook.com
 ([fe80::6c66:3392:3508:95e9%11]) with mapi id 15.20.3477.029; Thu, 22 Oct
 2020 12:06:00 +0000
From:   Frank Illenseer <illenseer@altair.de>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git Alias not working in worktree
Thread-Topic: Git Alias not working in worktree
Thread-Index: AdaTV73poiKNnKCUSXa2AlwjpbGP8AAAzTGgAAwLeIACTYdMUALqdVnw
Date:   Thu, 22 Oct 2020 12:06:00 +0000
Message-ID: <DM5PR03MB2826382CD1A5AA8F3ED60FD9B51D0@DM5PR03MB2826.namprd03.prod.outlook.com>
References: <DM5PR03MB2826A616AC30710E169B7237B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
 <DM5PR03MB2826C04CC5AAF3B61BDDAFE2B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
 <20200925222801.GC1392312@camp.crustytoothpaste.net>
 <DM5PR03MB28262362A9D3B0EDECBE6106B50A0@DM5PR03MB2826.namprd03.prod.outlook.com>
In-Reply-To: <DM5PR03MB28262362A9D3B0EDECBE6106B50A0@DM5PR03MB2826.namprd03.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=altair.de;
x-originating-ip: [195.145.7.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3957461a-1a14-45e2-d137-08d87682d756
x-ms-traffictypediagnostic: DM6PR03MB3755:
x-microsoft-antispam-prvs: <DM6PR03MB375595BA10D3F97A68CE9644B51D0@DM6PR03MB3755.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kX0LUKpBaugwpC5wZdpYtV/w61jt9vSrGWN5GLrju+eO2rqKhvtqQkCXOdLY5X4BJWZeK1mpXrfMNb/5Lek6IKYdhcIMXO5lSaWdw4UyIJbUNvcyWvRW+F5E7wrWynUm4lhsZO8Gz5lqWz/m7v9qcIcUl2NJ4WUeOpSr2X3l7jQO1uLs7/FHTA5Quu1pz2hRPv6GBvzxc62li3wCKPQ8zCNsOfWLq6+Qj5nYkVV9pM8pa79r/UMhUnt1iJFKw6kC3o5O5s3qJCCJY824K9c7DlHjVA6y3Z3uNMDHrTptolji8aoOfcojDF+u4AUl/Tvr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR03MB2826.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39850400004)(136003)(366004)(7696005)(33656002)(6506007)(26005)(2906002)(316002)(6916009)(64756008)(478600001)(66476007)(66946007)(558084003)(55016002)(66556008)(52536014)(9686003)(76116006)(66446008)(5660300002)(186003)(71200400001)(8676002)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lpIXn/Le5xfxKThw6TKi7rqNoOIoO4xOuV595/xzxFRsn/lxlI02YDUJf3FVDBUpUkHZ2hZLanyJ40AdoBXJuEHz9WSV4F+Uq4RbUubE9QDrQpRP6ioniBy2Cd5/f5tTLEO7e5SjInsyny9VcDQEi37eteZRqJmqTRcQApCl9a7j1WlAzKpgzNM6dRdOtgwmHGT6dFKSwph3QTWrx0yrZnYt5Za+qL80xAawrVpk2KExmz3SyQFNB29RjFwo0MsP4NBYRCXKrphLPuE84bSp0nkAag+7bSJb00++N+7Epe9IkcJoqC2ApNUXmL3ZT0Tiivb6MwX1N8dWRPncXMqxBXJdaLBhDGDUKXD1iO0EShOCZheo1/3ZuU51c+3HYhmCa5xD8QHA43WTNsrbvDvPdpuZDF0lqvjdWa/GZ5vEyploZDUAeOIqnDhPww1OuUGB91F9HaMP2ymgoJHs78snkuV4YcMTjD2lTzFZwbtKAmBs49y8bRMi+/1mrqKc8FC+Z34RwJgmQBuiCaOaDxsCqiiqS0ZudRRSB8mPS7thj5Abkz1Ay/bZ65UJNHHTxg8wMfWrn+W9Kt4IfMKf2DhQbZSaevFo0iwh62KXXpL3ymOI7gb6TNl4aRJj7wu864DBZzjmcdhyBWyKK6NM1A6MJQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altair.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR03MB2826.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3957461a-1a14-45e2-d137-08d87682d756
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 12:06:00.3042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2bae5b57-0eb8-48fb-ba47-990259da89d2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLAxvaoJOJSUWQff84ev/FMSLm2lv4fYTPAPIQMjF+fWcyaPF3jEvXtO+/CxaxxoI13OhRYvW31dBOrYOXw6mLxFllLR9Yt6l5RhmPxQvnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3755
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgQWxsLA0KDQpEb2VzIGFueW9uZSBoYXZlIGFueSBpZGVhIGFzIHRvIHdoeSB0aGUgYWxpYXMg
ZGVmaW5pdGlvbnMgZnJvbSB0aGUgY29uZmlnIG9mIGEgd29ya3RyZWUgaXMgbm90IHdvcmtpbmc/
IC0gSSB3b3VsZCBzdGlsbCBiZSBpbnRlcmVzdGVkIGluIGEgc29sdXRpb24gdG8gZ2V0IHRoaXMg
d29ya2luZy4NCg0KVGhhbmtzIGFuZCBiZXN0IHJlZ2FyZHMsDQpGcmFuaw0K
