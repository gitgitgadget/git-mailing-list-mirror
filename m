Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64D7C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE75206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BV5dTXnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgBTUFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:05:52 -0500
Received: from mail-bn8nam12on2119.outbound.protection.outlook.com ([40.107.237.119]:51301
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728770AbgBTUFw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 15:05:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC766Yu01VgqoZYNWk38JGZI8HmQy3AyAlpeiH5z/OdQwCbjDrQf/tUh92/AuFVvc9jQihXNNTnpbtz9l69EEXwUlKGOVtXYvx5ED6DwZcBCN98dzAHhcPtylBOWhvdO6MpexzbNUf2GyWACB3SSIyw4DDEblxxlFtwQmkk0SqIMYmbc0HRerEWpGBHQm3v+SakUN8sJ6RiKV4JGs+mF36I4cHNtlm4/pk++nqxteELJvfYabe5qJnkQCqNQuP94m72gCSddeYveA9gk/R9ECkYypO/ICjwl4YLuOKMsTxgDHrZif0lr72n2SwecM9MFdwDZegjDn4D+MTnq72oE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXDRQHTfkoIvT/lweFPdySMLSgLaRKViH/yfIgb1c4s=;
 b=kZqLSZgDjCePbdTfHnAqscBRrVN4jJTStALLAW0hsHn+svkJPtcO/oqwoiTZ12CTJ9FjAFx7EX25GJqJ3ppjdy5UGf+6rWmPwDmZ1ly+4BWzPmKis4cEFfn4kSOTHJwS1ThL4DW7v9f+6/BINTvHHDFf49NnkRw9FMVn+MNRCGuPORVCBkR9V3wyI74VrfIK5Iw2rUvqES3BWQP1m/Ml31Wfy+LyiH0oYH4GgCwVUfUDmM8OaZS5krO9G6Ix0USlMOMh96tiTKqkbODGwH+rzJvyEpmy0PpwS8MmZUyA9QI/REss1LWwyJVSDm5c5DhrSFhye6KM1c3TmeV/9+QQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXDRQHTfkoIvT/lweFPdySMLSgLaRKViH/yfIgb1c4s=;
 b=BV5dTXnBLMCjaGYKdPepO9pqWQ8Nb2mmA+1darWv+GN0BYszukfr5nFirqGdoGzqYy3vo6g5C0GNTOYZf/jBNfZ+0SjiLeSal0NJaf2c6N7rC6ICWknfoGpJRUGwnom+79oQzavT2Hb9LRnUFRtJmxfmkvVdoOKf2L9wF8KmsBw=
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com (52.132.24.23) by
 BL0PR2101MB0883.namprd21.prod.outlook.com (52.132.23.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.3; Thu, 20 Feb 2020 20:05:49 +0000
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe]) by BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe%3]) with mapi id 15.20.2772.002; Thu, 20 Feb 2020
 20:05:49 +0000
From:   Adam Milazzo <Adam.Milazzo@microsoft.com>
To:     Elijah Newren <newren@gmail.com>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: BUG: git clean -d cannot remove files from
 read-only directories
Thread-Topic: [EXTERNAL] Re: BUG: git clean -d cannot remove files from
 read-only directories
Thread-Index: AdXoHrH5FO1NZ7qPQtSWwmVAnLy0/AAB5HAAAAAqcWA=
Date:   Thu, 20 Feb 2020 20:05:48 +0000
Message-ID: <BL0PR2101MB1089E3CE7738BB70B65C17B680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
References: <BL0PR2101MB108917C204868FA653C2948680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
 <CABPp-BE8t+M5A8BpkYzs-WkoKDTCR_4jiT-vqwpLriuxhx46eQ@mail.gmail.com>
In-Reply-To: <CABPp-BE8t+M5A8BpkYzs-WkoKDTCR_4jiT-vqwpLriuxhx46eQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=admilazz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-20T20:05:47.1497165Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ba1ec959-df6d-4ffe-a47d-2a5677fbf595;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Milazzo@microsoft.com; 
x-originating-ip: [131.107.147.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54ce9de1-bd40-4e96-c514-08d7b64047a7
x-ms-traffictypediagnostic: BL0PR2101MB0883:
x-microsoft-antispam-prvs: <BL0PR2101MB088341F42536EF6E465ED91A80130@BL0PR2101MB0883.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(189003)(199004)(7696005)(10290500003)(478600001)(6506007)(33656002)(5660300002)(52536014)(186003)(26005)(8990500004)(81166006)(55016002)(66946007)(76116006)(6916009)(66476007)(81156014)(2906002)(86362001)(8676002)(4326008)(9686003)(64756008)(66446008)(8936002)(66556008)(71200400001)(54906003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0883;H:BL0PR2101MB1089.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KHnIFX+IeCdg+QMPYFxXdKoJXAyD7QxHGy+FakJbS+UE1r0cd4b4JvVGZnsUliOR2DyaXIVM2QtUr3rOoscMSxj4ZzD+anJ+zlhNZMvGwXTcQ3rzyGHScYD4GvYKI03VN6cjib4oWMd6WLNOD8qyn3CtddZOBYFHszihypk/U+g5iGe+b440FoFFklwINfUJItVGQopdYYfuJN8uyAjWSJBLNzgVSSrvhB3PcPU9n5pDOa3ckGCyHcXI/HP2V9jWsPse1IcfutGO+jmjxQTYUwPZxRWInWa6UQF1+6zbWNozpTq+WuxMcAlysY+Wru0Kce/sQ8Eqz5DXviKDaANNR2AEejgF1enzswxxNt1eJyfzQhlS9uu0/TUY2jCGDOr19+pcDfe0cpAXA4wPLCys0tmtRlCCRMNeSY6knJvxlXgV2z1F65muVBaanPEqUvBh
x-ms-exchange-antispam-messagedata: lJB/xjT+Rlf32qo7GJjFlU+miNwkpXPX5BPsTGrb6llgVMfQ8V/SVzTwsm8PWtBJQ/GnDEJ1jJKn0oL9fVuEPap6xHUNbF4VLRlK4eAVdIc2mS9Rnsq9hSA0pmxniwnN9NK635ViotboBk7riYExjg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ce9de1-bd40-4e96-c514-08d7b64047a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 20:05:49.1184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQcs45eQA0bOuCqvSni2EuizuRiTQxBNo8qnlOwccPXgChWsMF4qcLPXlgy2jr+UTiZFBmtT7n4RDVwrzyu2EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0883
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBUeWluZyBwZXJtaXNzaW9uIG92ZXJyaWRlIHRvIGUuZyAtZmZkIHdvdWxkIGJlIGEgcmVhbGx5
IGJhZCBpZGVhLiBQZW9wbGUgd291bGQgc3RhcnQgYWRvcHRpbmcgdGhhdCBmb3IgdGhlIHBlcm1p
c3Npb24gb3ZlcnJpZGUgcmVhc29uLCB0aGVuIHNvbWVvbmUgaXMgZ29pbmcgdG8gYWNjaWRlbnRh
bGx5IG51a2UgYSBnaXQgc3VibW9kdWxlIHdpdGggdW5wdXNoZWQgY2hhbmdlcy4NCg0KRmFpciBl
bm91Z2guIEknbSBub3QgYXJndWluZyB0aGF0IGl0IG11c3QgbmVjZXNzYXJpbHkgYmUgYW55IGtp
bmQgb2Ygb3ZlcmxvYWRpbmcgb2YgLWYuIEl0IGNvdWxkIGp1c3QgYXMgd2VsbCBiZSBhIHNlcGFy
YXRlIG9wdGlvbi4gKFBlcnNvbmFsbHkgSSdkIHNheSBvdmVybG9hZGluZyAtZiB0byBtYWtlICIt
ZiAtZiIgbWVhbiAiYWxzbyBkZWxldGUgdW50cmFja2VkIGdpdCByZXBvc2l0b3JpZXMiIHdhcyB0
aGUgYmFkIGlkZWEsIHNpbmNlIHRoYXQgaXMgbm90IHRoZSBvYnZpb3VzIGFuZCBpbnR1aXRpdmUg
bWVhbmluZyBvZiAiLS1mb3JjZSIsIHdoZXJlYXMgInRyeSBoYXJkZXIgdG8gZGVsZXRlIGZpbGVz
IHlvdSB3b3VsZCBub3JtYWxseSBkZWxldGUiIF9pc18gdGhlIGludHVpdGl2ZSBtZWFuaW5nLCBi
dXQgdGhlIGhpc3RvcnkgY2FuJ3QgYmUgY2hhbmdlZC4pDQoNCj4gQWxzbywgYW5vdGhlciB3YXkg
dG8gbG9vayBhdCB0aGlzOyBjdXJyZW50bHkgJ2dpdCBjbGVhbiAtZmQnIGJlaGF2ZXMgdGhlIHNh
bWUgb24gdW50cmFja2VkIGRpcmVjdG9yaWVzIGFzICdybSAtcmYnIGRvZXMgYW5kIEkgdGhpbmsg
dGhhdCdzIGEgZ29vZCBtb2RlbCBmb3IgaG93IHRvIGJlaGF2ZS4gIFdoeSBzaG91bGQgdGhleSBi
ZSBkaWZmZXJlbnQ/DQoNCkkgd291bGQgYXNrICJ3aHkgc2hvdWxkIHRoZXkgYmUgdGhlIHNhbWU/
IiwgYmVjYXVzZSB0aGVyZSdzIG5vIG9idmlvdXMgcmVhc29uIHdoeSBiZWhhdmlvciBvZiAiZ2l0
IGNsZWFuIiwgd2hvc2UgcHVycG9zZSBpcyB0byBwdXQgYSByZXBvc2l0b3J5IGJhY2sgdG8gYSBw
cmlzdGluZSBzdGF0ZSwgc2hvdWxkIGFsd2F5cyBiZWhhdmUgdGhlIHNhbWUgd2F5IGFzICJybSIs
IHdob3NlIHB1cnBvc2UgaXMgdG8gZGVsZXRlIGEgc3BlY2lmaWVkIHNldCBvZiBmaWxlcywgYW5k
IG1vcmUgdG8gdGhlIHBvaW50IHRoZXJlIGlzIG5vIHJlYXNvbiB3aHkgdGhleSBzaG91bGQgaGF2
ZSBubyBvcHRpb24gdG8gYmVoYXZlIGRpZmZlcmVudGx5LiBJIGFtIG5vdCBhcmd1aW5nIGZvciB0
aGUgZGVmYXVsdCBiZWhhdmlvciBvZiAiZ2l0IGNsZWFuIiB0byBjaGFuZ2UsIHNpbmNlIHRoYXQg
Y291bGQgYmUgc2VlbiBhcyBhIGJyZWFraW5nIGNoYW5nZS4gQWxzbywgdGhleSBhcmUgYWxyZWFk
eSBkaWZmZXJlbnQuICJnaXQgY2xlYW4iIHdpbGwgcmVtb3ZlIGEgcmVhZC1vbmx5IGZpbGUuICJy
bSIgd2lsbCBub3QgKHdpdGhvdXQgY29uZmlybWF0aW9uKSwgYWx0aG91Z2ggInJtIC1mIiB3aWxs
Lg0K
