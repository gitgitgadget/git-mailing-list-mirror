Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1850AC6379F
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 08:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjBUImQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 03:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjBUImJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 03:42:09 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2082b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103E746B4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 00:42:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drnU0xgo81svxkde4vW1BE1U6RxSP5qkE9yTcc6ny7L4YD0oqIxUvoBmv7KXSDCZoLlzILYdNQlPtMXnBEA5KNI5ZnXqlBUQrFkZ4VTzfGNZFQyVT1wL7HbEoyTFniLlnu7HeQauDVQcfykiDTAyJjvIIFih0n9b4Vhw3mUXOxJhrcfVMCE5gxNWt9O7KTSHcMUNbjn0GqCD8PhgKSXwtKfyz0iUmPfxffBM3F+Ly3U5uUELvqPZjIzxOMc1bcjqzStaIHgYZRSmzryjhD58NlcCSR3UgKG3HscTtGEs5dVK+N52YJgj2QvdWNU+BvH/TEaZI7TlXNduPXnncv6h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxxHMzfqi6h87EyqQ+R0J/Ow9Oekgi0tZ2jKMPe71xQ=;
 b=Ff9s5UfyXo4sW2HlsRTyEyyWSgyC75D94MejWwPyEjb2r2wjP4GufCNPYghI6+LDIEJJjxWKHAhqCIyPib4OZ7DUyEnYzF41/6F04Be2SSrI63GTuj9i8wkx0KKcZVTgBNBjLWU2608X03PhRIGRg3weGMQFSWTmX/mJJQiKlSStoULlMo9htOfF7wYc1ft4CPimotKD3UVXdJ+Yr0JSikYlwvTk3uaJUa4ruT4kmv8CJl5bC6swi0LFSqyVG7bFswkEeexMD9UFVo1OMGYe3slGFtu5p+nwSF6PVOE8VefZyILOjj4YWfPtB92hsqOfxsMnk82v1HjaULlp/OOJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxxHMzfqi6h87EyqQ+R0J/Ow9Oekgi0tZ2jKMPe71xQ=;
 b=A/D3pxT5fY+SAOwYAmo43KynLDIPR14kmBwK1UBg03j8i8fLfWbO0sy7gizy1bDqZUH6vumBPC4vJH3jtPdmOrD8TdU0v/kFIUxej76vJB9GvyyHlBoo51irmdFSF2htDnq1suXYfigySuL3rbo427QLFJOMZ0GD1GDBjjZafX+4ox3EkoF9PRiID2qxyNiQMcjzbuFt67nyjY6P5nLECbSSQU66SAd2mpBrBQ7rO9qLehLSBU1LHUNCnemwTKI4OokmYvJ9KCeRHLfwBiyM0e/IYm6G2n0KBOJoF29OgoevFueZQH/WEAkqrptNZnoPzlzxr/fs/OEK7e5hQ5IlCg==
Received: from PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 08:42:05 +0000
Received: from PH0PR12MB5608.namprd12.prod.outlook.com
 ([fe80::83ed:e56e:73b9:dd48]) by PH0PR12MB5608.namprd12.prod.outlook.com
 ([fe80::83ed:e56e:73b9:dd48%4]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 08:42:05 +0000
From:   z gh <18994118902@163.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "vdye@github.com" <vdye@github.com>
Subject: [GSOC] Discuss a microproject on Modernizing t9700 test script
Thread-Topic: [GSOC] Discuss a microproject on Modernizing t9700 test script
Thread-Index: AQHZRcI117A2RmBnsES6C8dikZ2WLg==
Sender: z gh <outlook_FAC2D503A5260E44@outlook.com>
Date:   Tue, 21 Feb 2023 08:42:05 +0000
Message-ID: <PH0PR12MB56085988A8C807BAAD4784C2EBA59@PH0PR12MB5608.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 2
x-tmn:  [jwUGH8dDc2ILNwRN9n/tXoxcqU4hTcTR]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5608:EE_|DS0PR12MB7535:EE_
x-ms-office365-filtering-correlation-id: 82d395f1-21fc-436a-ae9c-08db13e782c5
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jR2vC4xSZCqOMz6F6nWjR9cP2avO/mnXYlustcEShDAgDChdXpX4fyB3qtnCpeWMPfoXxONiVIIHOM3MdZaok33ZLACrG/gHX9K2neu8IIUy3sPav8txhxQTeCxnuzpOWi98qeMwE3OHh+XWxSFYMrQkrSPf9RLv7REzBexfSZ9FNcaebCR+XVweCF+LTlIKlB5C8w42MGC/h8++m3iqhxiTVIYmOD4Ev8rQzXLsf0HaD6/5uv5vMteXOva4EpUHV9KbyhJTuerjzibnsymSivvH3JWhT39OkOv5yV7GjEAK+9OnOhgI9qp5Vr/NDjm0LgDNELDZEQi0otdDLV7vPtl4P6hC3IXC103zbUI21q42q7p6Ni3EOK0FnGvCyOzhQJK8ZI7yM08k3vLMs0bC5qZp/zVZ8QwpYBDjVuRMflSaiFUyB3E6T/c9Y9sz+FpRt4BoRgpqNeicD2XMdFNJgObBJT+j2H4wFlTY6/b+50LJei1XeixskUR3GelR8EBCO4+GrawGAbo+U/icYZ0dIXeKOf8Uzp37J3Rfj57jFmZSoDutc55NanHj8LXHV0JBMGzBF5Iee9dGZjN/RK8xpQkPbggH0yTIS4+dJetaRc5suYufhVw+pE4fxu5Tr+1MeVHW4VUvtI5SzcPaVekurw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WDVaTnhxWXJBMG9oUVpqRXVtVWREU01oeUxzNVhUT05tcndCSW4rbnFhbFpV?=
 =?gb2312?B?VHpJRTl4ZXA3M05uNld4OHM4bVdWMHFydHpRWFhMMXZ0eW5hNmhwd0U5YmNI?=
 =?gb2312?B?MkhjbmpUeFlFSXI4Y0RYK2Rjck5VdGh4SllxZUYvelo3Tjc3MnJCZGY2STY0?=
 =?gb2312?B?K2lrY2ZzeXBLazMyWEltd3krc2M4S01VUm9KblpvNnN5bGhnSGNzSG9NN0pN?=
 =?gb2312?B?NVVNTUU2dHphVXo2Qmw3L29qVkQxRDZiZ0lqb0thTjlrYTdORDgxWmU0c2FP?=
 =?gb2312?B?TDRXWmNoM1F2b1RMRWMwUzVjRWZieTRCbDg5U0lQZU9ZQi9jd1RVc05yUWEz?=
 =?gb2312?B?R3NWdlI3M3JGcHRUWVdSUDA4SzVkQjFGNlhjZFdvK2tQaVlGdmpsanQyaktk?=
 =?gb2312?B?d1BtOFBJck51VUd1NjlrMDJZQXdpU1lHLzFwSzd2bTM3bnM0SHE1dENqUi9L?=
 =?gb2312?B?dU5PZWNlUVJNWjdZOGdIZWc4VmF0WE9RMERvNDY2TFZPd0V1ZForektuRUts?=
 =?gb2312?B?Y3lub3VnNXZxRG5hRWtKZ0VGOWRWKzNlOVdSTEpRNThDc1UvTEl4bWJqYW1r?=
 =?gb2312?B?OE01V1A5R29xL3VDMHpTVDlqR1FmV3pOM2E1OFJJaVhXbWtySWRmZVpmYnFv?=
 =?gb2312?B?dlVNbnl3eFlPVWc2R2RMY21SbjU5bUFJRE9USGZiT3lwMGZ1V1BsUlRHNVV0?=
 =?gb2312?B?YVlwRnc1b2dBYlFIRW5JYzZOVC9pZUoxdTNVbFloc1NHQlg0M2lzcm5MeExH?=
 =?gb2312?B?S2NMN1pwam1mNzlxVTF0SE5LL3VuVG1BYVRiRXY3QXRuN29yUGt0alBqNUcx?=
 =?gb2312?B?U3kzQzIzbEY3bkhoVXVhb0QwNHduTWRiRDI3YUd6cGgzWldVY2lkTlRJMnhw?=
 =?gb2312?B?WWVJOFJmV1lzRzdkb1RzRm92RnNaVFhzK3FjRWZDRXFTQW92RnZEMTVYRjk0?=
 =?gb2312?B?OThML2xBWThjVmhYWDBJMkNwSGVKdmtBd2RwNDFwVytxcm1uYTg4RE9uZndV?=
 =?gb2312?B?WWd1NlJoYmV6VWNsTHRzMzBBQlpwNXBveHQzdW5nZ2Q4ckd6cGF4NWpGZFpH?=
 =?gb2312?B?dDZtWnIwNEhPRUk3TzhUbUZreE5PT1VReVZjMFprYTNjNTBhUERxWm1MRmZw?=
 =?gb2312?B?R0ZOM0FaQURjclJaOXVZdUNZcFRaWWhtTkdaZzRFS2JmaWp4WmRGTTBubmpF?=
 =?gb2312?B?bHZ4K0FETVVZYkV1VEh2QTlaT2l5VG1CZHRQVzVFUTI5TzlKN0MwZjVKSUVX?=
 =?gb2312?B?MEJqVDZ2VjJKUlRiNmtpbEpqTGsrT2JlRDNJKzNpY0lyOWtNVEF5YXQ2UENK?=
 =?gb2312?B?Z1cxWERYWWQ5NCtVY1FvK2xSa3FDMnFTa1FJMTJaMG5oUjRIbXhUV1hsWGo4?=
 =?gb2312?B?LzEvbUlUSThsd0ZKcURLdmxBTHhIZXZkWUkwc3FLc0RnRVZNd3dPdEMxUTRz?=
 =?gb2312?B?Qm9CY2RhT0NnYWNFZ3BGeERDWDBaVXgrWFVvSzA1elFjc25WejZtT3FpSDlz?=
 =?gb2312?B?ZXhLUzlPSm14NGZKdzdvVDl0dmM3SklUUFp2Y3VVNDJmNGtoWGUzMTIwUXFp?=
 =?gb2312?B?RlIvTW02SXNQZ2dLUUpNUHptM0lTY01ENEhtR1MySVVxOUZiVzVabWFDMTIr?=
 =?gb2312?B?ZXNrRTU1dzNUYndTazlETmJNTW9pd0kzNlEzSUdMUUplK2lwc0ltTEZiNFdT?=
 =?gb2312?B?dStUVE9oRXUwRmNYY1dyUUo0K2RubC9kMFpWa08vNDRXTDNSUFJXVm1GNzVH?=
 =?gb2312?Q?brTBxZ2N7Gy2eKMfwA=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d395f1-21fc-436a-ae9c-08db13e782c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 08:42:05.5266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGVzdCBzY3JpcHRzIGluIHQ5NzAwLXBlcmwtZ2l0LnNoIHNlZW1zIG91dGRhdGVkIGluIHdoaWNo
IHRoZSB0aXRsZSBpcyB3cml0dGVuIGluIGRpZmZlcmVudCBsaW5lcy4KSnVzdCBmb2xsb3cgdGhl
IHN0ZXBzIGluICdHZW5lcmFsLU1pY3JvcHJvamVjdC1JbmZvcm1hdGlvbicgdG8gbWFrZSBzdXJl
IG5vIG9uZSBlbHNlIHdvcmtpbmcgb24gaXQgbm93LkFuZCBpZiBzb21ldGhpbmcgd3JvbmcgaW4g
dGhpcyBlbWFpbCxmZWVsIGZyZWUgdG8gYWRkcmVzcyBtZS4KCgpTaWduZWQtb2ZmLWJ5OiBaaGFu
ZyBZaSA8MTg5OTQxMTg5MDJAMTYzLmNvbT4KCi0tLQpIaSwgSSdtIFpoYW5nIFlpLlN0dWR5aW5n
IGF0IFd1aGFuIFVuaXZlcnNpdHkgb2YgVGVjaG5vbG9neSBpbiBDaGluYSxJIHdpc2ggdG8gcHJv
Z3Jlc3MgaW4gc29mdHdhcmUgZW5naW5lZXJpbmcgYW5kIGNvbnRyaWJ1dGUgdG8gdGhlIG9wZW4g
c2NvdXJjZSB3b3JsZChvciBldmVuIHRoZSAgd29ybGQpLkJ5IG5vdywgSSd2ZSBkZXZlbG9wZWQg
c29tZSBzaW1wbGUgcHJvamVjdHMsIHN1Y2ggYXMgYSBjaGF0cm9vbSB3aXRoIGNzIGFyY2hpdGVj
dHVyZSBpbiBjIGxhbmd1YWdlLCBhIHNlY29uZC1oYW5kIGJpY3ljbGUgZXNob3Agd2l0aCBzc20g
aW4gamF2YS5CdXQgdGhlc2UgcHJvamVjdHMgZG8gbm90IG1lZXQgdGhlIHJlYWxpc2l0aWMgZGVt
YW5kLkFzIGEgcmVzdWx0LCBJIGZlZWwgZGlzc2F0aXNmaWVkIGFuZCBzdG9wIHByb2dyZXNzaW5n
IGZvciBhIGxvbmcgdGltZS5JIHZhbHVlIHRoZSBvcHBvcnR1bml0eSB0byB3b3JrIGluIGFuIG9w
ZW4gc291cmNlIHByb2plY3QgdmVyeSBtdWNoLldpc2ggdGhlIGJlc3QgZm9yIGV2ZXJ5b25lLg==
