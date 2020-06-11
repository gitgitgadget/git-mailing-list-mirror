Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052F7C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D662065C
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mavenir.com header.i=@mavenir.com header.b="Eh5b6+z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgFKOb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:31:57 -0400
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:43584
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbgFKOb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 10:31:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4b+nFecKGRsCeYL9v3q66V6jHTi1gmWFONahfWk5uQZbf2p5PQ4PI8ohx96QO29zcDKw6X4L3bLHEkZMwwFHHJF90WoFVMZE0Z5MN0rGFd/DU/VH02dms+uNDkWlJlfJf+sXLsH4SuXdvxSCpeHyJ7Nb6F0WhUfFxKPMh6ZkQvZhiLVOc2+StOn6Lk6Cjet8lNYuI1n2iSS2DKfA0yzrmUa0xwaFTQkGFKtXQAXuUlNX7dbF7NaoE3s/W52Qa0XRCunc0ejLoKPAyj74RBvTgoLDKnc4VF0x03F0ViJIBdv3pk7NcSEGOaPOe8Pa3ETM+orB25pWdDghwct/X20eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFtCIBYiiBTYZ3KfCT7rAxeZ22D9T4o7N7hzt1g2bHw=;
 b=LlDddh6ehJJXc9KVOjz7Az7PquNR8DPLQagAs2ha+w8KFYqRrJ77fbMDdGS8Uqeq6KVJlVcGibS3fVCwxs3OmEpOLU7STVIWOkr4vCqiUbspjxxIBEmVOH4WQtoppR8bcIggpuu5rPI5AXpUrHuiKA3VbihQV2cqF6QllmLz1xX1Iie10JwEH0N5OyuybbdB4+5z31RninS7tfa2FS2Qj15Evfdl15tPT6JyBhf8HTp//ghLilVymAWsfv9dOL3E3xuIKC2ti9+TRf2QIvzD+A1j1G+MHkJSJqneqPT7cj04hqgaJGJvVRkrWPtB1eEZ9zk0azPNxun6FhQYKZTsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mavenir.com; dmarc=pass action=none header.from=mavenir.com;
 dkim=pass header.d=mavenir.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavenir.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFtCIBYiiBTYZ3KfCT7rAxeZ22D9T4o7N7hzt1g2bHw=;
 b=Eh5b6+z3/wPtzLvt4mL4WPSv6PAcNa/UgFQ6H2zWVbfuzrYWYKYYBCUGZy9pCQlq8NULUD1Wrx3L6Cz+adeovhoJf+XBu8vs4socVYa3XNhiD/52K4+kzjlmHI6y+56JkvH0a6AnYtAowPXqz8ofTKVvmRqzk8JjCUhuTxvRIo4=
Received: from DM6PR11MB2795.namprd11.prod.outlook.com (2603:10b6:5:bf::24) by
 DM6PR11MB4139.namprd11.prod.outlook.com (2603:10b6:5:196::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Thu, 11 Jun 2020 14:31:53 +0000
Received: from DM6PR11MB2795.namprd11.prod.outlook.com
 ([fe80::9caf:c724:631e:b29c]) by DM6PR11MB2795.namprd11.prod.outlook.com
 ([fe80::9caf:c724:631e:b29c%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 14:31:53 +0000
From:   Tiran Meltser <Tiran.Meltser@mavenir.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Excluding files from Git merge
Thread-Topic: Excluding files from Git merge
Thread-Index: AdY/+aPcWx+IybP3QFixgHxiFuLlWg==
Importance: high
X-Priority: 1
Date:   Thu, 11 Jun 2020 14:31:52 +0000
Message-ID: <DM6PR11MB27959B6BE6ABDB1F79238126E5800@DM6PR11MB2795.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mavenir.com;
x-originating-ip: [109.186.30.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dcad7f1-7a54-4745-c9ed-08d80e142f72
x-ms-traffictypediagnostic: DM6PR11MB4139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB413944ABCB1356AAF07110FCE5800@DM6PR11MB4139.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3eVP2pNmGIYC7i0J5iFZm4DntjKodmTIZL+PoR+fulBFIeSnEwyQhG4EtjjhqJ4jVGCrE+BNNXc5zzKYwmNUF5wHdBa4GLVxMyZ4SCCkmhBRiiKuT/kJYACTjOxB0gtpjjYM2/8InQ3oiDOARoaR86oKH9PW3K5uvkxcz9nb57rqiGTk8OMZ+TfiGmyB3xmZW/CbC01sSEq63zc7iFc+Q8EgVlWMi9EeJLCRCBMcIujgdvxn27bZLBeeOhIFmNjHPnKlGkZWTmKxdYcolyRUZ3pPGQLaKexARHE49g2M4Ozcb6iPa4q5zi4CD78CVHiJhDJgzC3EVh0E1IGqQVB9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2795.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(396003)(136003)(366004)(52536014)(64756008)(71200400001)(66556008)(107886003)(66476007)(76116006)(66946007)(66446008)(83380400001)(6506007)(6916009)(8676002)(66574014)(55016002)(26005)(4326008)(478600001)(9686003)(316002)(2906002)(8936002)(5660300002)(86362001)(33656002)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6vEMr0hfuUoQtp0/wFyXa3q8oYb+yqdDSkhnk97eYNsdKNPIaM7S80GHYll8Ptsp5gNUg0y1BVNPfjj9iBfK9Gn0oXUVtlwUQfOjvMKP7TgmMDjyqBFvLrXT506jEP+fKT05dtnJ9i7T6krAm2kUX59ojOSZpnVTOa0JTNNejN6NEWXfoyKM1foaVOiLUWGBfwpYvmfdptaaDq9eVwIfOIORKFvqjeB9JjkxDkiKLWhxE5nbung7fkMkBNDm4G2mDWpA6xr8IHRlcDCGCOCFdebCvRWVv3FkyNNce9Y96BRfA8XI6or2vYFq2RqfRfyt6VSHgUFh/5XhbfKlnrXrVFFw95UbwEfds984V8SvV83HtwZH6kPifSHkhNp0siWRXZHWjtrJKcQTVxDZ7rjaoXgZAXow5O2f7yCUS7qtn6M3/OeVnJjFuumT4iJohjKkp56zN+zgPuK/QyXe6+jVuMvh5SMH8/FMJA6l9AP/IRiyLOa1Wh4qlhbNIKcWa4PI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mavenir.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcad7f1-7a54-4745-c9ed-08d80e142f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 14:31:52.9542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7fa7d4ff-bf19-464b-89a6-a132b269d68c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJgCZHumxbYiHbQLTW7BI+0lg+FFfC1LsZOs2q362mOsfpOalsGBQQMDRzyfjWklPpmSOj3AY75j4YUz1z8NNtoTMr2i6Xc0MloRofgGCWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4139
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQpUaGlzIHRvcGljIGlzIHF1aXRlIGNvbW1vbiBpbiB2YXJpb3VzIHVzZSBjYXNlcyAoZS5n
LiBwcm9kdWN0aW9uIGNvbmZpZ3VyYXRpb24gdnMuIHN0YWdpbmcgb25lKSBhbmQgdGhlcmUgYXJl
IHF1aXRlIGEgZmV3IHRhbGtzIGFib3V0IGl0IGluIHRoZSB3ZWIuDQpOZXZlcnRoZWxlc3MsIHRo
ZXJlIGlzIG5vIHNwZWNpZmljIHNvbHV0aW9uIHRvIHRoaXMgcHJvYmxlbSwgb25seSBwYXJ0aWFs
IHdvcmthcm91bmRzIChpbmNsdWRpbmcgdGhlIGZhbW91cyBtZXJnZSBkcml2ZXIg4oCcb3Vyc+KA
nSkuDQoNCkkgd291bGQgbGlrZSB0byBzdWdnZXN0IGFkZGluZyB0aGUgZ2l0IGEgc2ltcGxlIGFu
ZCBwcmVjaXNlIGhhbmRsaW5nIGZvciB0aGUgbmVlZCB0byBtYXJrIGZpbGUocykvZm9sZGVyKHMp
IHRoYXQgYXJlIGJyYW5jaCBzcGVjaWZpYyBhbmQgc2hvdWxkIG5vdCBiZSBpbnZvbHZlZCBpbiBt
ZXJnZSBvcGVyYXRpb24gYXQgYWxsLg0KDQoyIHN1Z2dlc3Rpb25zIEkgY2FuIHRoaW5rIG9mIGFy
ZSAoYnV0IGFueSBnb29kIHNvbHV0aW9uIHdvdWxkIHN1ZmZpY2UpOg0K4oCiIEFkZGluZyBhZGRp
dGlvbmFsIG1lcmdlIHN0cmF0ZWd5IGluZGljYXRpb24gdGhlIGZpbGUvZm9sZGVyIGlzIGV4Y2x1
ZGVkIGZyb20gbWVyZ2VzIChlLmcuIG1lcmdlPWRpc2FibGVkL25vbmUvc2tpcC/igKYpDQrigKIg
QWRkaW5nIGEgbmV3IGNvbmZpZ3VyYXRpb24gZmlsZSAobGlrZSAuZ2l0aWdub3JlKSBmb3IgdHJh
Y2tpbmcgdGhlc2Ugc3BlY2lhbCBmaWxlcy9mb2xkZXJzLCBmb3IgZXhhbXBsZTogLmdpdGlzb2xh
dGUvLmdpdHF1YXJhbnRpbmUvLmdpdGJyYW5jaHNwZWNpZmljLy5naXRzaWxvL+KApg0KDQpBbnkg
Y29tbWVudCB3b3VsZCBiZSBhcHByZWNpYXRlZC4NCg0KDQoNClRpcmFuIE1lbHRzZXINClN5c3Rl
bSBBcmNoaXRlY3QsIEdsb2JhbCBQcm9kdWN0cyAmIE9wZXJhdGlvbnMNCg0KDQoNCg0KDQp0ICAg
dGVsOis0NDExODkzMDg4MjYNCm0gdGVsOis0NDc4OTQ2MDQwNDANCmUgIG1haWx0bzptYXJpYS5o
dWRzb25AbWF2ZW5pci5jb20NCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
VGhpcyBlLW1haWwgbWVzc2FnZSBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgb3IgcHJvcHJpZXRh
cnkgaW5mb3JtYXRpb24gb2YgTWF2ZW5pciBTeXN0ZW1zLCBJbmMuIG9yIGl0cyBhZmZpbGlhdGVz
IGFuZCBpcyBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lw
aWVudChzKS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIG1l
c3NhZ2UsIHlvdSBhcmUgaGVyZWJ5IG5vdGlmaWVkIHRoYXQgYW55IHJldmlldywgdXNlIG9yIGRp
c3RyaWJ1dGlvbiBvZiB0aGlzIGluZm9ybWF0aW9uIGlzIGFic29sdXRlbHkgcHJvaGliaXRlZCBh
bmQgd2UgcmVxdWVzdCB0aGF0IHlvdSBkZWxldGUgYWxsIGNvcGllcyBpbiB5b3VyIGNvbnRyb2wg
YW5kIGNvbnRhY3QgdXMgYnkgZS1tYWlsaW5nIHRvIHNlY3VyaXR5QG1hdmVuaXIuY29tLiBUaGlz
IG1lc3NhZ2UgY29udGFpbnMgdGhlIHZpZXdzIG9mIGl0cyBhdXRob3IgYW5kIG1heSBub3QgbmVj
ZXNzYXJpbHkgcmVmbGVjdCB0aGUgdmlld3Mgb2YgTWF2ZW5pciBTeXN0ZW1zLCBJbmMuIG9yIGl0
cyBhZmZpbGlhdGVzLCB3aG8gZW1wbG95IHN5c3RlbXMgdG8gbW9uaXRvciBlbWFpbCBtZXNzYWdl
cywgYnV0IG1ha2Ugbm8gcmVwcmVzZW50YXRpb24gdGhhdCBzdWNoIG1lc3NhZ2VzIGFyZSBhdXRo
b3JpemVkLCBzZWN1cmUsIHVuY29tcHJvbWlzZWQsIG9yIGZyZWUgZnJvbSBjb21wdXRlciB2aXJ1
c2VzLCBtYWx3YXJlLCBvciBvdGhlciBkZWZlY3RzLiBUaGFuayBZb3UNCg==
