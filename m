Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA23C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD775208C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h6krS1vA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgBUDGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:06:17 -0500
Received: from mail-eopbgr760095.outbound.protection.outlook.com ([40.107.76.95]:56064
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729268AbgBUDGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 22:06:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWxqG+EqOvS3THL2V5+IVJ0vgxICV/G1pCDhoawIwLpkyOUsYghbejtO/3/xhPyoJL2LOSdBDTcYQ+TYaTcMi2SzVmZcB7AwyOIXPKl6lLIcq145tv40c8+sR1fMBM9GKj9W3NoU3Ve+/j5TEkVpjd4InMQh0+pCM2BxZkPSuiAy1scPJNU0Ok77W9XISip332oxPM5J5Vz2JagzAdugTIpkkfMLgOgAx6zJ6SVc3sAB56TFKFm/aJ515WV+o08zTLbqb5Dgxr1nUA6sGlCMBe+eyAX1Pb4OTxu+OLdUSflBVpsPh+UxfcOnW4GfN0iiV+u972fZFYe3k6zsT+v6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3+YJz0mRwJ0LBJ9AMjJwMCsmdP+Cblp8p0HrIu7RmQ=;
 b=J0FbAXP2EQuClckxF6Y2wh81Qh7nCrf7FqvMjwil5e5YNLuebPh6iaOp6ZJsyrm6IZUocSvJ0eHQl2FWIIppYcqvkp5iChsu+R3+NRiN75iJRFz1oeE/zee91R3FdFNDO3LFDtLpadxZ6GOdbkCPAZ10YD3wMWnS+1bbQvYvBTRoBr+pCYXkaZQyg2n7u3xIUAbzn9hD8Qbrji5T/58JlOOoyvhIfmYnJnkA5mHp2TgQDr5173iZqCn8ZY3ATAN5RrcUoj1IgUspgQesnKibC1yMxc88AkFNkei4RVVtza326DBd3G7VunRv9sIG92TS2odkYstkcs1XipWrFft6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3+YJz0mRwJ0LBJ9AMjJwMCsmdP+Cblp8p0HrIu7RmQ=;
 b=h6krS1vAbrpb2QuHVn0dD8jT2Lihd41X0h856njU0LSed74uWVUZYNq7pFeemMEr/ra0hbCpMDpDbPy3vwtNxiZZFbnZ1CJoTNConkLvLhcEyzOex7YOSvUp6DT9qIaAlEHPmqQGqv9k5b+wVPiZg5YYEWLZp/H30zt45kRPNb8=
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com (52.132.24.23) by
 BL0PR2101MB1091.namprd21.prod.outlook.com (52.132.24.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.9; Fri, 21 Feb 2020 03:06:14 +0000
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe]) by BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe%3]) with mapi id 15.20.2772.002; Fri, 21 Feb 2020
 03:06:14 +0000
From:   Adam Milazzo <Adam.Milazzo@microsoft.com>
To:     Elijah Newren <newren@gmail.com>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: BUG: git clean -d cannot remove files from
 read-only directories
Thread-Topic: [EXTERNAL] Re: BUG: git clean -d cannot remove files from
 read-only directories
Thread-Index: AdXoSRS8iVe/eRtDQm6EtkdaC0sZvgAClYeAAAMMEDA=
Date:   Fri, 21 Feb 2020 03:06:13 +0000
Message-ID: <BL0PR2101MB1089E6E522A983429473719380120@BL0PR2101MB1089.namprd21.prod.outlook.com>
References: <BL0PR2101MB1089AA571A3277AEF4798B5D80120@BL0PR2101MB1089.namprd21.prod.outlook.com>
 <CABPp-BHJeAfj0=OWLeU8UuXtAu1-cCCLs4O_rLqiDHxGbMEhAQ@mail.gmail.com>
In-Reply-To: <CABPp-BHJeAfj0=OWLeU8UuXtAu1-cCCLs4O_rLqiDHxGbMEhAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=admilazz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-21T03:06:11.4417517Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dfef7218-f48f-4255-9c3e-7985d936ce5f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Milazzo@microsoft.com; 
x-originating-ip: [73.109.149.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 436ec0ca-da99-42ff-05ea-08d7b67b02c9
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB10918A27BBC505E402BCE32280120@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(199004)(189003)(71200400001)(316002)(7696005)(8990500004)(4326008)(64756008)(66446008)(9686003)(55016002)(66556008)(6916009)(76116006)(2906002)(66946007)(66476007)(10290500003)(6506007)(478600001)(33656002)(81156014)(8676002)(81166006)(26005)(186003)(54906003)(8936002)(86362001)(5660300002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1089.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S6GMLv5hSia03NIO0DKc4wTrI/9wysosRxUsQiqDJoV3Zyt8ftnThiEk6+TsnuTU2AOvTuDeqVlrqrwdOGGk8tSHrmq5aTwDif7PcbMPaD7n6bMURKzaslaZF91YqalP/yAzilx00wf3bU+eUKYILhRLgr6L1/GVSAY+z7Mf3e3gpz6tFwlPI7GKXg7VVP6thmZLXiHHjMPRcAHym9fhfDa3Fi6amrfb6366jlt4XV23YHTnvXMLWEAHEQQhI0DCYXCexEswqkCX2cMoW64wiyFYHee0ESzkw1HA/vban5ABelkojTPu+qL+TboVirazMH4LA6zjQ1TJDx0PvyaYhTHPXaymJW2vhbxxN+12iKeUe0yJpWAXC8l1tFsS9KtMbitqWSZs/8R/uD0FmmV5uXvStXs9KBbH1VcVAj+m8NG5OwtPtO9twOxm2hNpZc6B
x-ms-exchange-antispam-messagedata: PBx0BtyOdJqhGvkWi1gFWZJy/L4DVkYNcvLHsUtauqifbG38jiYn/+aZVUMwqSawn53eOudOZMox+qIdwP2rBrx84k8mQK+2WrY10mEJ3Lo0j8Xmn8iqoPiBT9uKndGtYvPwm8Btl1ncssEMY+FPtw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436ec0ca-da99-42ff-05ea-08d7b67b02c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 03:06:13.8656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIqBVP0+cq+vwXjJ5I39Rw7yH2pr2sPKzqA5WjPRsMfr7mQgfpMdiutZq5q1mGAGFgXmq+p7NR4943K7AbM8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBIZWhlLCBidXQgeW91IGxlZnQgYW4gb3BlbmluZyBmb3IgeW91ciB0dXJuIGFyb3VuZCB0byBi
ZSB0dXJuZWQgYXJvdW5kLi4uICBHaXQgZG9lcyBub3QgYWN0dWFsbHkgdHJhY2sgc3RhbmRhcmQg
VW5peCBmaWxlIHBlcm1pc3Npb25zLg0KPiBJdCBfb25seV8gdHJhY2tzIHRoZSBleGVjdXRhYmxl
IGJpdCAoYW5kIG5vdCBhIHNlcGFyYXRlIG9uZSBmb3IgdXNlciAmIGdyb3VwICYgb3RoZXIsIGJ1
dCBqdXN0IGFuIG92ZXJhbGwgaXMtZXhlY3V0YWJsZSBvciBub3QpLiAgT2YgcGFydGljdWxhciBu
b3RlIGZvciB0aGlzIGRpc2N1c3Npb24gaXMgdGhhdCBpdCBkb2VzIG5vdCB0cmFjayB0aGUgd3Jp
dGFibGUgYml0LiAgU28sIHdvdWxkbid0IGl0IGJlIGluIGxpbmUgd2l0aCB0aGUgd2F5IEdpdCBh
bHJlYWR5IGJlaGF2ZXMgdG8gbm90IHRvdWNoIHRoZSB3cml0YWJsZSBwZXJtaXNzaW9uPyAgOi0p
DQoNCldlbGwsIHlvdSBnb3QgbWUgdGhlcmUuIEluIHZhcmlvdXMgcGxhY2VzIGl0IHdpbGwgc2hv
dyBmaWxlIG1vZGVzIGxpa2UgMTAwNjQ0IG9yIDEwMDc1NSBhbmQgaXQnbGwgaW5jbHVkZSBwZXJt
aXNzaW9uIGNoYW5nZXMgaW4gZGlmZnMsIGJ1dCBpdCBkb2VzIHNlZW0gdG8gYmUgZmFraW5nIGl0
IChpbiB0aGF0IGl0IG9ubHkgZXZlciBzaG93cyA2NDQgb3IgNzU1IHJlZ2FyZGxlc3Mgb2YgdGhl
IGFjdHVhbCBwZXJtaXNzaW9ucykhIFRoYXQgZnVydGhlcm1vcmUgaW1wbGllcyB0aGF0IEdpdCB3
aWxsIGFsd2F5cyBjaGVjayBvdXQgZmlsZXMgd2l0aCBvbmx5IG9uZSBvZiB0d28gcGVybWlzc2lv
bnMgKGVpdGhlciA2NjYgb3IgNzc3LCBmaWx0ZXJlZCB0aHJvdWdoIHRoZSB1bWFzayksIGFuZCB0
aGF0IG1lYW5zIEkgZG9uJ3QgaW4gZmFjdCBoYXZlIHRvIHdvcnJ5IGFib3V0IGNobW9kIC1SIHUr
dyBhdCB0aGUgcm9vdCBvZiB0aGUgcmVwb3NpdG9yeSBtZXNzaW5nIHVwIHRoZSBwZXJtaXNzaW9u
cyBvZiB0cmFja2VkIGZpbGVzLg0KDQpUaGF0IGJlaW5nIHRoZSBjYXNlLCBteSBwcm9wb3NlZCBm
ZWF0dXJlIGlzIG5vdCByZWFsbHkgbmVjZXNzYXJ5IC0gcGVyaGFwcyBuaWNlIHRvIGhhdmUgaW4g
c29tZSBlZGdlIGNhc2VzLCBidXQgcHJvYmFibHkgbm90IHdvcnRoIHRoZSBpbXBsZW1lbnRhdGlv
biBlZmZvcnQuDQoNCkkgd29uZGVyIG5vdyB3aHkgR2l0IG1ha2VzIGFuIGVmZm9ydCBvZiBhcHBl
YXJpbmcgdG8gcmVwcmVzZW50IGEgZnVsbCBzZXQgb2YgVW5peCBmaWxlIHBlcm1pc3Npb25zLiBQ
ZXJoYXBzIHRoZSBpZGVhIHdhcyB0byBsZWF2ZSB0aGUgZG9vciBvcGVuIHRvIHN0b3JpbmcgdGhl
bSBpbiB0aGUgZnV0dXJlLi4uDQoNCj4gVGhpcyBpcyBzb21lIGdvb2QgZm9vZCBmb3IgdGhvdWdo
dCwgZXNwZWNpYWxseSB0aGUgYml0IGFib3V0ICJbaWZdIHlvdSBhcmUgZ29pbmcgdG8gZGVsZXRl
IHRoZSBwYXJlbnQgZGlyZWN0b3J5IGFud3lheSIuICBIbW0uLi4NCg0KV2VsbCwgcGVyc29uYWxs
eSBJJ2QgcHJlZmVyIGl0IHRvIGRvIGl0IHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciB0aGUgcGFyZW50
IGRpcmVjdG9yeSBpcyBnb2luZyB0byBiZSBkZWxldGVkLCBzbyBpdCBkb2Vzbid0IG1hdHRlciB3
aGVyZSB0aGUgdW50cmFja2VkIGZpbGUgaXMsIGJ1dCBhZ2FpbiBJIHdpdGhkcmF3IHRoZSBmZWF0
dXJlIHJlcXVlc3QgZ2l2ZW4gdGhhdCBHaXQgZG9lc24ndCBhY3R1YWxseSBzdG9yZSBhbnkgd3Jp
dGFibGUgcGVybWlzc2lvbiBiaXRzIHNvIHRoZXJlJ3Mgbm8gcHJvYmxlbSBpZiBJIGZvcmNpYmx5
IHJld3JpdGUgdGhlbSB0aHJvdWdob3V0IHRoZSB3aG9sZSByZXBvc2l0b3J5Lg0KDQpBbmQgd2l0
aCB0aGF0IEkgYXBvbG9naXplIGZvciBhbnlvbmUncyB0aW1lIHRoYXQgSSB3YXN0ZWQuDQoNCi0t
IEFkYW0NCg==
