Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C7C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 20:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbiKVUvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 15:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiKVUvu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 15:51:50 -0500
X-Greylist: delayed 13564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 12:50:53 PST
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D420B
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 12:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1669150252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unTgvEYQBoG8+aY5+TxCgSjAA/7ZzbH5Hv+KbDBSkA8=;
        b=SKtiXr+GRd1HiymzBwXXtXl3jtFzZION/eLDATyd6wEG8eeW+lxPbwISnLbLJlFJnZHDLX
        kJ6nxcUumn8P3VO3bL2a+riV1zB6GupMUO/stDwsFl2LJ9tme3W6QJXHwzbREnFtTII6k8
        uP8eIo79syNglCS8nKsBR3cv0kRNzCY=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17012027.outbound.protection.outlook.com [40.93.11.27]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-BbW16sGGO8ODxqpejkBtTQ-1; Tue, 22 Nov 2022 15:50:51 -0500
X-MC-Unique: BbW16sGGO8ODxqpejkBtTQ-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by MN2PR05MB6622.namprd05.prod.outlook.com (2603:10b6:208:db::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 22 Nov
 2022 20:50:46 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::b941:37b0:820b:e946]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::b941:37b0:820b:e946%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 20:50:46 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
CC:     Git ML <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: RE: fsmonitor: t7527 racy on OSX?
Thread-Topic: fsmonitor: t7527 racy on OSX?
Thread-Index: AQHY/a0IuIT7VXkmYU+PAp54LUxBnK5JYciAgAHKhXCAAD/eQA==
Date:   Tue, 22 Nov 2022 20:50:46 +0000
Message-ID: <BL0PR05MB557192340C68F6771F3962CED90D9@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <221121.86y1s4bfp6.gmgdl@evledraar.gmail.com>
 <Y3t/YbZUIuIJkSil@danh.dev>
 <BL0PR05MB55715FF24BD1AD53EE81A5A2D90D9@BL0PR05MB5571.namprd05.prod.outlook.com>
In-Reply-To: <BL0PR05MB55715FF24BD1AD53EE81A5A2D90D9@BL0PR05MB5571.namprd05.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|MN2PR05MB6622:EE_
x-ms-office365-filtering-correlation-id: 3b90ff30-7dd4-4a67-c8b5-08dacccb3b10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: AiydHLRlXoq0aL9twEAo3H5ZS8IJrbIPGArS1iEmeRzCHCWQwgvF+GfOL+is6rvoibW2LezgO9ykt9EFus8/oa460vzO+MuisgCMBI1Jys6ojxlavHV886qj3q4sXZdwHp5e/rC2H/4beImGDcxchlly9AlIDvLF7BajpHgJ4I0tmtcAjdH4IIilCVYQueSaHhA5gXc4MXnv1uCdRIL+IqeFnOEgeGX2MvlneU5kZw7YSGuTGVlDa1vIm8DfwJf7ZfIF4wZ9sxvh2w5oQGKZ9/ZQBauVw58x5RQZ7rsIWMV0RN4Y4ALQ9CRK6qP8nQcyWPg8aV4mTlkruS+B3WDj5lRXsgmtoSmx4WSDrXASoOAfpvoaaA4tIEFtPhiOH8Avl+045xyEHDLywZImn+w9YYO59gmOg0pBDRYpgvzYW+24WF6gVqZdOkmBHvBBTwggSdlZ4Z3r3ek/x6kiRcqBrcKD7zV3c/jwLpI/7SdnqNleAljBsVNbjD1EUaAQqqZHkbA2sy5p1DSGk8HbBikAf2a7x6NYoD15Z3ZXX8Lg3hsGitQ7F89zLZ5YvidCNL2kH5L0CEFzvdwYXEUZBfyR8enXBwNO5oihP5FP5kUdiKxcme78bbqH/xWSh4vvgfMY5n38u0jsEbTF7rZTsRdUAxo0lABNvk84PXwIrWGuq4XzsWa9ilNoUS8Lo51ceD7hM1VwVvQsXVUGasZN5kJmjpPA+kA+6JXlEIAZ4sHfXFQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(7696005)(86362001)(55016003)(38100700002)(122000001)(38070700005)(54906003)(110136005)(53546011)(478600001)(6506007)(316002)(966005)(71200400001)(5660300002)(33656002)(83380400001)(84970400001)(52536014)(66574015)(4001150100001)(2906002)(2940100002)(8936002)(26005)(186003)(66446008)(9686003)(64756008)(8676002)(66476007)(41300700001)(4326008)(76116006)(66556008)(66946007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUtteU4rLzZTTXBLY3l1SkswSXlpL1V5bEFkSU12WVc2RnhjSk4wcHBWaXFM?=
 =?utf-8?B?cHR4RVJLYTV6MTNzM3FNYkphRzYwOWJiOERyOHlpSndvWmVuL3o1Z25BNzU2?=
 =?utf-8?B?VXo3UEsyRFNoNFozeEcvcHhleVlvVVhyd0tEeDh4bnV5Y3g3dzd1clNXZWlF?=
 =?utf-8?B?ZWxId1crYmdDa2VodnZWNW5KWDhmbFFjTXNDeG0yYXZIQXdQNEtzR0Rvd0Zt?=
 =?utf-8?B?b3FOU2plcnUvNC9ycTRIZzNnMHdTMUVLL0IvVE5lU3JpM1hJYjFKdkxaR0NH?=
 =?utf-8?B?ejBFL0wrZDcreDdvTGxhSU5zRTNKNnRDZVlLYjA1N3BidkZiVDJkaHIvbEJH?=
 =?utf-8?B?WDl0VmlsR3Z5bnBwVDROVjZhVGRKMzNxM2FpazJsTWVPVnNqTkVjSzJvZFNP?=
 =?utf-8?B?aWZ4L1Nzb0FtOGJrdzVPYVM0NU5WeGRIbEd1SmZBQ3dDR1dMcSt6VHN5QlhI?=
 =?utf-8?B?TjMyWHpTM2p1YlI5Z1E1djlnZUFvOFlRQkJESEpjSXlZY2lTdTBjeDF4RDg1?=
 =?utf-8?B?TlgvWXY4MHBVaTlnMzRjT1ZDanZZb0x1SWVBZTg5MnRUODlXSVRtTmFhdW9V?=
 =?utf-8?B?YytqMXBJQUhEMEZHQnorVkJSanRzRGpJOE9HTkhhVkRsdUJza28zaWhZVmMx?=
 =?utf-8?B?QXp1dFNJNkhVb3hQelYraFpWYTA5OGNjMmVSZDUxRUk4a3h6RGhkbzlEZkV1?=
 =?utf-8?B?Z3E0RW5lditWSEtGSmlhZFpFQkJ2SkY2dEpvQjlGa3hwb0VBUlRoS1BDMUkw?=
 =?utf-8?B?NzRRYmF1UldUb0FJQUZUTHR4N0t5NzBUbXpCd2h6NHFZbjcxYTJxY3JUaWg2?=
 =?utf-8?B?V3B1ayt5Rjl2eEhkOFRLMERPSnRYaDlZdGl5SGJxVXVGb3piemhJcXJqeUtr?=
 =?utf-8?B?cDRTVjcxYVVqWURhOWpCa1lmbjZrL3hvRm42N3FSb3VURnphUHhTa2k5Q0o1?=
 =?utf-8?B?RDFPb2xrWEg0ZVNaekRUaHJtUjkyN29nZXBTZTBjQ3RBczRiY2p1MUl1Y3hV?=
 =?utf-8?B?UzhNZkpmMEhlZlhGTHpaVW83QWtQRmg4OHBsSHp6ckE0QldNeVR4TENYQlFy?=
 =?utf-8?B?UWpMOFFIMUx6K1dlRkJjRmxoYUFVM0d4bCtyRG9PNVI5bFZQcGxocTQyRWNs?=
 =?utf-8?B?SDRLZDZRKzVzbHcrMy9UVzhmWnpKYVR4alYwVitqQXo3eWxlQitEN1I3TG1S?=
 =?utf-8?B?KzlPbWRDOW9FdVBYa1JJaEkyaXg4blBldDJ2Z2V1TGxVOFRVUTRQR0I3QStz?=
 =?utf-8?B?MEM1aVh6em80cFpmS2NrTU11VFQwdzd4djBER2xqWU1CSmk4QzZPSHZINEU3?=
 =?utf-8?B?ZWo5V2JZWUJ0dXRqWDdGM0hpVUxEMktkOUhpMkhpVGxsUkJuZXhOMk5kSUxt?=
 =?utf-8?B?VnhHbzRZVHR3NFlLcDRsVHVBd0JZNGtHSkJmbVNha2Jjdy9jeFR6NmtFYzZ5?=
 =?utf-8?B?amFabzBVN1dwWHU5bncvMjlyalZiTDN2dUxMRUo0OHRvaXZRU2hNcFlNblpk?=
 =?utf-8?B?TmJqR2pkaVNrWnNwQ091cDlMRm9uMlhDYlF3dFhIWGduOTlMaUtHMkx1K2t6?=
 =?utf-8?B?UnFjRW9GdFM1dkZ1OFMvTXhQVUcrSFBGWVNHTlNQVUU0Tnpvck02M1lZKzdB?=
 =?utf-8?B?TXhxV3dBU1BEbGlmbStqaTJlQStoK0dESnFTVCtTbGxRS0ZIb2dFNHlSclNR?=
 =?utf-8?B?blB1ak5hNG1CbEFFVTlSZjBRV2poRkRkcjJROHFEbGlGY0VXeWVRN0VQZTFw?=
 =?utf-8?B?Y01VcVVPQlRpdFJxaXowdFBCTWJNKy9aT1lLb241SHVhUnlwNzR6bS9BRC9E?=
 =?utf-8?B?Y0JmcFk0bndXYTZyQ3YrMTR4bTJhUWFoVTBKamp3Z1o0TFRpODNwTlRLMXpX?=
 =?utf-8?B?eEtUYzlyUnNETWtJSkZ5ZFNnd0tyY1lVd0dleFZXSnFzVXJoWHVMSmFjVXR1?=
 =?utf-8?B?elV2cEFkT1d5REhsUTdzcHUxQm0xai94UjEwbFkxRkt5UURRMmtjbUdrQlJZ?=
 =?utf-8?B?emsySEVON2M5U2JiTDRKcFJucXRWMGZEVSs0b0Qwbk4rQ1hTTzdoRFdOaCt1?=
 =?utf-8?B?bmdaSTVFSVlvYzVQQ2FIUmpxMXc2cEs2RDRGcm8yV3JWQWlHSjdqTGxTQ3lq?=
 =?utf-8?Q?huJcbq42xehhOHZyBsWApZX4L?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C9xdKYPl6d4SKWmUhvXvrrQ14TILjFRomgCKQOC6+NgDvmbn1tNXiGNwXZ1oPEjJ6eb9cbXWYuUC6lmnBTMxY33T7j7c93eCXQ/LpE/VMZ/iZr8uXTYu7WmLpZK1i4o+n4LUILEn3MfMVlFv9jmUh8RtoKM3UFzeGJmQ/pOg0L8uweKc/TR0PaPEMFfjCXkrpfQBP9o1tiCD+gTI9S3B32lSu69CdQgxfgYeLBj4T0y7YOOGv5tmyCq8PG6/Vc/seXsx/0hDuJR9wolRbIfD9ahhXLHS4UIY1an4bDojrBWBb80Sual4lMD72gzKVhE6nwZUFeDHYHomCcN1SxBMuBnquzWGZmzNaBQU++onCKqKVdowrJ4hnHvGZH001jw/AQas8Hjs1qejx1nZ+bM1NDPd9s77Z+xmI8vtLnzawxqLuOECnA4a5qdonJveS2CpDrdU0tkl+e3Syk2/X+w1rS87hpTrEv2h3BBXgLxoiuBVaWDjo9QvoNqM+0uyK86vsxBJ0xF1zO0V97Hs9Ssu7ck5c3/KqAz3fVRPEVWOvvR0bblL+voC6ZELP3JeNS1cV/uWWR/RGgibOTIg/7g62hID9docSZZAzXqTs6qraN7qZLIOkkUn7KlllyyWgXmuqk24GaOTwIS6fyrROLLC9RfpCJdTcYeyllgOvIBF9dNMpiTJlezNKhaqJE2Qo4dmKn/Er8N0nm7XM3rr0Bbe7vjK+46+VhCrOKw1w9LV2bgEBDJenQdHWbg9BFRa2CbOEXlkvcHu3DSBzmE2BtKMOnt8vNfDmY4CxsdxNKVpQNIs8XkHfQFalWGcMG4YjEVn6X9dxEMPmJWWIEsVCM4b/t+fAdHymAsv3NuSUqWs96A=
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b90ff30-7dd4-4a67-c8b5-08dacccb3b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 20:50:46.7260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEhwc+7dqir7VO0p28VgAXe1Fl0dRVc3UjY46tUeh7Sotg+XOPeoJ45gg7VJcNOJSJxC/02mzE/sQwO6wNA7sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6622
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBEZUNvc3RhDQo+
IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDIyLCAyMDIyIDEyOjA1IFBNDQo+IFRvOiDEkG/DoG4g
VHLhuqduIEPDtG5nIERhbmggPGNvbmdkYW5ocXhAZ21haWwuY29tPjsgw4Z2YXIgQXJuZmrDtnLD
sA0KPiBCamFybWFzb24gPGF2YXJhYkBnbWFpbC5jb20+DQo+IENjOiBHaXQgTUwgPGdpdEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBKZWZmIEhvc3RldGxlciA8amVmZmhvc3RAbWljcm9zb2Z0LmNvbT4NCj4g
U3ViamVjdDogUkU6IGZzbW9uaXRvcjogdDc1MjcgcmFjeSBvbiBPU1g/DQo+IA0KPiANCj4gDQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiDEkG/DoG4gVHLhuqduIEPD
tG5nIERhbmggPGNvbmdkYW5ocXhAZ21haWwuY29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgTm92ZW1i
ZXIgMjEsIDIwMjIgODozOSBBTQ0KPiA+IFRvOiDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiA8
YXZhcmFiQGdtYWlsLmNvbT4NCj4gPiBDYzogR2l0IE1MIDxnaXRAdmdlci5rZXJuZWwub3JnPjsg
RXJpYyBEZUNvc3RhDQo+ID4gPGVkZWNvc3RhQG1hdGh3b3Jrcy5jb20+OyBKZWZmIEhvc3RldGxl
ciA8amVmZmhvc3RAbWljcm9zb2Z0LmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogZnNtb25pdG9yOiB0
NzUyNyByYWN5IG9uIE9TWD8NCj4gPg0KPiA+IE9uIDIwMjItMTEtMjEgMTQ6MDc6MTMrMDEwMCwg
w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24NCj4gPiA8YXZhcmFiQGdtYWlsLmNvbT4gd3JvdGU6
DQo+ID4gPiBJIGhhdmUgYWNjZXNzIHRvIGEgTWFjIE9TIFggTTEgYm94IChnY2MxMDQgYXQgWzFd
KSB3aGVyZSB0NzUyNw0KPiA+ID4gcmVsaWFibHkgZmFpbHMgZHVlIHRvIHdoYXQgc2VlbXMgdG8g
YmUgYSByYWNlIHVzIGRvaW5nIHNvbWV0aGluZywNCj4gPiA+IGFuZCBhc3N1bWluZyB0aGF0IGZz
bW9uaXRvciBwaWNrZWQgdXAgb24gaXQuDQo+ID4NCj4gPiBTZWUgYWxzbyBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9naXQvWXZaYkdBZis4Mld0TlhjSkBkYW5oLmRldi8NCj4gPiA8aHR0cHM6Ly9w
cm90ZWN0LQ0KPiA+IHVzLm1pbWVjYXN0LmNvbS9zLzU4MFJDcFluNkVURE9Cb3ljWVZrVXE/ZG9t
YWluPWxvcmUua2VybmVsLm9yZz4NCj4gPg0KPiA+IEkgcmFpc2VkIDMgbW9udGhzIGFnbyBhbmQg
aXQgc2VlbXMgbGlrZSBKZWZmIEhvc3RldGxlciBpcyB0b28gYnVzeS4NCj4gPg0KPiA+ID4NCj4g
PiA+IFRoaXMgbWFrZXMgdGhlIHRlc3RzIHBhc3M6DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L3QvdDc1MjctYnVpbHRpbi1mc21vbml0b3Iuc2gNCj4gPiA+IGIvdC90NzUyNy1idWlsdGluLWZz
bW9uaXRvci5zaCBpbmRleCA1NmMwZGZmZmVhLi5jZTI1NTVkNTU4IDEwMDc1NQ0KPiA+ID4gLS0t
IGEvdC90NzUyNy1idWlsdGluLWZzbW9uaXRvci5zaA0KPiA+ID4gKysrIGIvdC90NzUyNy1idWls
dGluLWZzbW9uaXRvci5zaA0KPiA+ID4gQEAgLTQyOCw2ICs0MjgsNyBAQCB0ZXN0X2V4cGVjdF9z
dWNjZXNzICdlZGl0IHNvbWUgZmlsZXMnICcNCj4gPiA+IHN0YXJ0X2RhZW1vbiAtLXRmICIkUFdE
Ly5naXQvdHJhY2UiICYmDQo+ID4gPg0KPiA+ID4gZWRpdF9maWxlcyAmJg0KPiA+ID4gKyBzbGVl
cCAxICYmDQo+ID4gPg0KPiA+ID4gdGVzdC10b29sIGZzbW9uaXRvci1jbGllbnQgcXVlcnkgLS10
b2tlbiAwICYmDQo+ID4gPg0KPiA+ID4gQEAgLTQ0Myw2ICs0NDQsNyBAQCB0ZXN0X2V4cGVjdF9z
dWNjZXNzICdjcmVhdGUgc29tZSBmaWxlcycgJw0KPiA+ID4gc3RhcnRfZGFlbW9uIC0tdGYgIiRQ
V0QvLmdpdC90cmFjZSIgJiYNCj4gPiA+DQo+ID4gPiBjcmVhdGVfZmlsZXMgJiYNCj4gPiA+ICsg
c2xlZXAgMSAmJg0KPiA+ID4NCj4gPiA+IHRlc3QtdG9vbCBmc21vbml0b3ItY2xpZW50IHF1ZXJ5
IC0tdG9rZW4gMCAmJg0KPiA+ID4NCj4gPiA+IEBAIC00NzEsNiArNDczLDcgQEAgdGVzdF9leHBl
Y3Rfc3VjY2VzcyAncmVuYW1lIHNvbWUgZmlsZXMnICcNCj4gPiA+IHN0YXJ0X2RhZW1vbiAtLXRm
ICIkUFdELy5naXQvdHJhY2UiICYmDQo+ID4gPg0KPiA+ID4gcmVuYW1lX2ZpbGVzICYmDQo+ID4g
PiArIHNsZWVwIDEgJiYNCj4gPiA+DQo+ID4gPiB0ZXN0LXRvb2wgZnNtb25pdG9yLWNsaWVudCBx
dWVyeSAtLXRva2VuIDAgJiYNCj4gPiA+DQo+ID4gPiBAQCAtOTc4LDYgKzk4MSw3IEBAIHRlc3Rf
ZXhwZWN0X3N1Y2Nlc3MNCj4gPiAhVU5JQ09ERV9DT01QT1NJVElPTl9TRU5TSVRJVkUgJ1VuaWNv
ZGUgbmZjL25mZCcgJw0KPiA+ID4gbWtkaXIgdGVzdF91bmljb2RlL25mZC9kXyR7dXRmOF9uZmR9
ICYmDQo+ID4gPg0KPiA+ID4gZ2l0IC1DIHRlc3RfdW5pY29kZSBmc21vbml0b3ItLWRhZW1vbiBz
dG9wICYmDQo+ID4gPiArIHNsZWVwIDEgJiYNCj4gPiA+DQo+ID4gPiBpZiB0ZXN0X2hhdmVfcHJl
cmVxIFVOSUNPREVfTkZDX1BSRVNFUlZFRCB0aGVuDQo+ID4gPg0KPiA+ID4gVGhlIGZhaWx1cmUg
aXMgd2hlbiB3ZSBncmVwIG91dCB0aGUgZXZlbnRzIHdlIGV4cGVjdCwgd2hpY2ggYXJlbid0DQo+
ID4gPiB0aGVyZSwgYnV0IGlmIHlvdSBtYW51YWxseSBpbnNwZWN0IHRoZW0gdGhleSdyZSB0aGVy
ZS4gSS5lLiB0aGV5J3JlDQo+ID4gPiBqdXN0IG5vdCAiaW4iIHlldC4NCj4gPiA+DQo+ID4gPiBJ
IHRob3VnaHQgdGhpcyBtaWdodCBiZSBhIGxhY2sgb2YgZmx1c2hpbmcgb3Igc3luY2luZyBpbiBv
dXIgb3duDQo+ID4gPiB0cmFjZSBjb2RlLCBidXQgYWRkaW5nIGFuIGZzeW5jKCkgdG8gdHJhY2Vf
d3JpdGUoKSBkaWRuJ3QgZG8gdGhlIHRyaWNrLg0KPiA+ID4NCj4gPiA+IDEuIGh0dHBzOi8vY2Zh
cm0udGV0YW5ldXRyYWwubmV0L25ld3MvNDEjDQo+ID4gPiA8aHR0cHM6Ly9wcm90ZWN0LQ0KPiA+
IHVzLm1pbWVjYXN0LmNvbS9zL1M2WU5DcXhvWEdJV2tvTlJIRWZNenU/ZG9tYWluPWNmYXJtDQo+
ID4gPiAudGV0YW5ldXRyYWwubmV0Pg0KPiA+DQo+ID4gLS0NCj4gPiBEYW5oDQo+IA0KPiBIb25l
c3RseSwgSSdtIG5vdCBzdXJwcmlzZWQuIFN0b3BwaW5nIHRoZSBkYWVtb24gYW5kIGdyZXBwaW5n
IGZvciBleHBlY3RlZA0KPiByZXN1bHRzIGltbWVkaWF0ZWx5IHRoZXJlIGFmdGVyIGlzIGp1c3Qg
YXNraW5nIGZvciB0aGVzZSBzb3J0cyBvZiByYWNlcy4NCj4gU2xlZXBpbmcgaXMgYSBiaXQgdWds
eSwgYnV0IHdpdGhvdXQgYW4gZXhwbGljaXQgbWVhbnMgb2Ygc3luY2hyb25pemF0aW9uIGlzDQo+
IHByb2JhYmx5IHRoZSBiZXN0IHRoYXQgY2FuIGJlIGRvbmUuIEkgY2FuIHRha2UgYSBsb29rIGF0
IGl0IHNvbWUgbW9yZSBhcyBJDQo+IGhhdmUgYWNjZXNzIHRvIE0xIE1hY3MuDQo+IA0KPiAtRXJp
Yw0KDQpodHRwczovL2dpdGh1Yi5jb20vZ2l0Z2l0Z2FkZ2V0L2dpdC9jb21taXQvNjNkYjYxNmQw
ZWM2NDRjZWU5ZjgxNTI5ZWQwOTNiZWVlMGEwMWY2NQ0KDQpBZnRlciBhcHBseWluZyB0aG9zZSBw
ZW5kaW5nIHRlc3QgY2hhbmdlcyB0aGF0IEkgaGF2ZSBiZWVuIGRldmVsb3BpbmcgZm9yIGZzbW9u
aXRvciBmb3IgTGludXgsIEkgaGF2ZSBiZWVuIHVuYWJsZSB0byByZXByb2R1Y2UgdGhlIHByb2Js
ZW0gb24gTWFjIE9TLg0KDQotRXJpYw0K

