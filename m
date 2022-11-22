Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6539C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiKVRMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiKVRMI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:12:08 -0500
X-Greylist: delayed 322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 09:11:15 PST
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B8A77239
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1669137073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jhUDZWNhT0piml9QP7bkiEog1+2dNxV+apyaUJNC4Rs=;
        b=YFIU7tdZtO+z8O9LNut5lMt016JfPlvjYKp2gw6nI4i7r4hCdk9J5KSTi7w0GwtXPsOABc
        zIeOhXRpFBPbx4VGIDbuxzu/wdWRIhqwPI1Nd529u4OZopqytv8KK1z0FI9FiJAuRZ37bo
        7zqCBBiZH+iSIAglxTYYk3e8TvsMuIY=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17012027.outbound.protection.outlook.com [40.93.11.27]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-0JbZhbPAOLmcrc8hBODxIw-1; Tue, 22 Nov 2022 12:04:46 -0500
X-MC-Unique: 0JbZhbPAOLmcrc8hBODxIw-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by MN2PR05MB6894.namprd05.prod.outlook.com (2603:10b6:208:17a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 17:04:45 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::b941:37b0:820b:e946]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::b941:37b0:820b:e946%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 17:04:45 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
CC:     Git ML <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: RE: fsmonitor: t7527 racy on OSX?
Thread-Topic: fsmonitor: t7527 racy on OSX?
Thread-Index: AQHY/a0IuIT7VXkmYU+PAp54LUxBnK5JYciAgAHKhXA=
Date:   Tue, 22 Nov 2022 17:04:44 +0000
Message-ID: <BL0PR05MB55715FF24BD1AD53EE81A5A2D90D9@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <221121.86y1s4bfp6.gmgdl@evledraar.gmail.com>
 <Y3t/YbZUIuIJkSil@danh.dev>
In-Reply-To: <Y3t/YbZUIuIJkSil@danh.dev>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|MN2PR05MB6894:EE_
x-ms-office365-filtering-correlation-id: d974525c-05c4-424d-495c-08daccaba7a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: gWHEnp31QZr5A3x42M0OCUOsKmPcmAl5FdD9ZlZYsb5TOhk42YwBzU5uRhu3wT5p/5VWw+TNUKjEXkasRi/E2TbNgvT03MMblmBLL3ugXpS4wANreKO/KLgpSm97WvQWkxgKosECJ2d9mHkclDvfNKg9kwx5BysU0Hh4T9xeuOJNvYFeD/Aays3m/oiaBSHvW4Q6UN10ocoi9NV4EeJpsKj13ILL6POpWFP9Q/rkYqhsxP4XNawapy4M8CbbdUuZldjzNSpb5beRGIwT0xMnOwqIOK7THueDru8TgBN5VBrgm+jmJsaPC4M9uPJ1GeSBLdaeFYY7Tw0+Pb1KJb5+aMjOe/4ElaSYoPeQR1AlYtip0rr4CGL7H3xwm+KtUATMnTOUrXAtTGspupm+1o81MTVXkVW0n1yEnLcHWaKDR4HLiKpH/ckdQpOUAIhpeapwwT8hFLstXFARIAetfDNE5oBk7zvVekwxeJfZoe8pFxugHGLWyAu3Ep8FHjWSJ8iICHDjCAUdGvKePuS12liKMmvoKJilszz80ldRCNFwcyAzqm4PzNMcEI1kLfgeKXK6P+JO4hcNdhBxKlki8P3JVUSLfrB5i7gFwA+M526+1BlnnHR4JbewavVBEw5xwo/EnrLCl6yFkV4Pmi1RKW8qdL46mGUpVo/5NIxECQ3G6GeFb58gQrpt3Jo9pQgWcjTIJOLSmQj14b4cW47BYjQd0APev7Z5zqlN645+lA4Xuxw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(2906002)(83380400001)(84970400001)(4001150100001)(186003)(33656002)(55016003)(66946007)(66446008)(64756008)(76116006)(66556008)(86362001)(66476007)(38100700002)(6506007)(54906003)(110136005)(53546011)(41300700001)(7696005)(38070700005)(122000001)(71200400001)(52536014)(5660300002)(66574015)(8936002)(4326008)(8676002)(316002)(9686003)(26005)(966005)(478600001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDBZZnZlNWxrZHp3K1k3YWRsc3JaMnVzcW9NQ0VtdDRnZWpzRmpWemU4WExM?=
 =?utf-8?B?bGZXS1JsVjM0dFpJaXVxekxjaTlFZ1pIQW4wTTFHZmN5RDNtSTBpUVQ4Zytj?=
 =?utf-8?B?cGtHb3ozM05pcWZCSi9MZUlTTFNZdzBmSU05ajJiMldQSUhhRkRmV0h3R3ZP?=
 =?utf-8?B?NE1mSDhpUWljRHo0b3RsMlA2dU45YmhhNnFUWktRaU93Mm1OdWUrTUdKTEJN?=
 =?utf-8?B?M1ZmWjBRT1RmdFpDYmRhSDBScTlEbnhhNE1wQVdYVlBNRThKTVBUZDB3cjFF?=
 =?utf-8?B?SFdSVW1qNUdCd2NlU2c3VUtqcmk2VDRGUHZIQjd0a3hCRWRGb3Q1c3MrRldZ?=
 =?utf-8?B?bjZhTHJMSnU3bVpLd1lkcGRjY2xDVWtIbUViNjA5VFRIMjhEZDRrL3pFeE9S?=
 =?utf-8?B?TVdGang2USsxYnRkVnNrS1ZWWGJaS01zSXd1UHo1VTJQVWJnOHA2TmhWYkxo?=
 =?utf-8?B?NlV5UUk0RnJXSXdYTVQ3YStHdDNNc1BHei9TYWdDRFc5UXFoc3o5dlVrMWlm?=
 =?utf-8?B?VnlHOTZsVWt4akdJelZ2Y3NTVXdyNTlsdmUzRk83MXlVVzJCcnlKVjNsNWhL?=
 =?utf-8?B?czI5aHNCSXhmc0FyMHpBcUc5dng2Vm9QSGJCODl3U0lOR2ZTV0JzZStGTFZt?=
 =?utf-8?B?ZzF2NVkwM2hvNm9vZVJ2c1ZVZEVGTE01MCtWeHFQVk5rWlZUMVl5THBlWFFh?=
 =?utf-8?B?NkRmNWtCZm1wYjRrZko3UDQzMDg1TFJxTUt1ODVVVFdkaklnaW9CeFdPT0ZV?=
 =?utf-8?B?anJiV21oellsMkNMOW9jK2JRTDl0Qk16UWlTM1FnbmpyNEN5YUgyeHBnNGxN?=
 =?utf-8?B?VUY4a3V1TmE4WFhBS0JJMXlzbVRCT1hBYlVXbGtkVlJkTEVXay9HajdKL0Rv?=
 =?utf-8?B?dDhoR2Qvbi9yRWlnYldQOVBJQVhXbTdDRm5STGFSVTZZVUFlTStKK2pTK1hv?=
 =?utf-8?B?WmNYWURKUFJnRnRvaWt6NnlhZVlYRjJLdEVtZzcrUWNhbDlUd2M1Sk4wVXRn?=
 =?utf-8?B?ZjdwWS9OQytQNnhoeGYyOG5IK2RhOWNXSno2RTFuVDZ5WVljNGFlS2ZqWVpP?=
 =?utf-8?B?TS80dWFTQkw2OXAvNmY3M2pTTVB3UVBIYmJpZ2p2TGg1YzlJcFpVMWJrNmd1?=
 =?utf-8?B?Zy9lbVNNdGhtdmZybDAzUDRIQkZJNW9NNzN4L3pEaGo3bW9PYk5ySk1lZ0xl?=
 =?utf-8?B?MEJRY3V0eC8vSi9WZ3RzczN3Q2RhKzVXQnJsWnZ6WEdnZEZUMHkyZ3hFT3kw?=
 =?utf-8?B?RnpBZjViajB0ZWVRTHhjVG9GUmJmd3ZHeTRiNWVpYjJkeWcwMnlRaTl6bThN?=
 =?utf-8?B?ZXhnUE1xTFRncWl3VjNlL2haSXZWYkY0OHdORUF5dWRyZTJXdTFmNlY3aWJD?=
 =?utf-8?B?REVhYmo5eEE0ak1MSXdka2xJaWZXcUJMVDRjKzJXMGozdnZJbWF5aU84QXRO?=
 =?utf-8?B?RjlXNEpuR2JVREQyRFMrUXE2aUxPZjl5dGNvcjdBbURPRjljWW51YU11TUwr?=
 =?utf-8?B?Rk5LY09pd01EeFFIcGdiMzU0ZGE3T25XQlcxOGxkYzRmWU13NldBdlRTVy9l?=
 =?utf-8?B?TWtITXovZHNjNFg2aEZpTTFRV2NuRGgvM01DNEpzWE9KLzJDVDRnbVJVeTVq?=
 =?utf-8?B?c29abmJ5cDZtbUdmUnhCa0JNMDRkdERUMWlGclJBdG1zZnNNendWSFBxaWFi?=
 =?utf-8?B?eXVmeWlyYlMySWJpbG40NXJhUmVHREx6d3hzNnlBNDhCK3pXMG8xc0dJTmNR?=
 =?utf-8?B?bnJjQkFyNjd5QVVjd0VHMHYrbktTTlJoaFRzeHk2UXBTRWVIRk11QmY4MXg3?=
 =?utf-8?B?R3V6dVJSeEFpWWd3cUViMkR4WmdraHFzbkZyaDN4SFFzdzJmZ1Mzakx0dnVC?=
 =?utf-8?B?LzdPd1BWKzZISCtmakJFOFBucDBhU1U0eEpGTm5FaHlSQkhJUEZHK01kMTVn?=
 =?utf-8?B?SFdHcjNuSWZtalFwV05BekliK3N3U2txTmxPZlo1aWRBNTBlM1BLWFFQRUhG?=
 =?utf-8?B?OWVJT0VkTGlUN0FQL2o1S3QxaWFzLzM2TFhtR3lYdUllMHN1NVZ4VW1VWDVE?=
 =?utf-8?B?ZU9JUUJKWFVyZXJ3WFlCWlRvaEpkcHpBQ09xeFE3Q0g2cmRvUjcrcW90S3pl?=
 =?utf-8?Q?Q0frXLi6SXI5bsgW6sfZQRbhz?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LtZzdQ31d3PFm0cpvgTuU4fpzIR1w2h+AjbunS3NbczlmyEKgblQHquRq+lqaB5Og0m4ZP7/Ok2o2hnx2LXtcsRlEwOZ6xJregh4SffrjLMa+qGE1TG9dGgotLmOye4yyrSLf17gsK6dB2b91K01QpxURqZ25e6X9lqxD6tD2KRBLvNf8z2kzi4hlE3L1urHbWxMHu49+PYrJEAkA/jLv0fabn2d4WBeekokDIje7bQ+BR/3PtJeiaSLaVg5U/0iaRuDgdeyz3zAj1MgL6Afkv1tJHQQlcVD6PpJo/OsV4eR4I7sn7ANiiv64UjfC/Q0TOopgl5+EdWctbl3kUhWKZIRpIVVcGzFF4rQzIu5X38EEA/QmpRB6q3NeCOTazSfscvKIcKjdqFz5JsrnmLhluxBU0Ah9C3YUrNUudW/JjXwBkDoxXkByaO9jOCXLruirV5R8P5cDLo0V2yciBba4AGYb0payczV8eIh1vSKaKxPKA3wrPPXvM7IVYnPP61MwfnIWX+UVGaP2ly7hJzEEYqDTc1LnMbwdPHsiHOB8JjbYUddhoQBszA8voOh7lyANrYSlHAtygVQdd7EiKdUOiTIIGFwUewZGj/fCzAHCBa8l0n6bdayA5u1w7w3qtOmP/6X2b+Of0DbRt3ABRgAKbh8rVBcOevr1+Xica5BzE+L5JeVFNeKJ461NZDC8+i3hh9VPlxnKGCVzEVnbcMY0EiNjNobw7046AIQ5FsH3pE8zDCUGFAM8/Wb7vWDZYLRSR12UIAT7ES8uvQRuVKSr8zlAMRPb+S11bC2g36IJ4iV/yFos3TQ4bDchj3qaCC6h3ZApuFkoAlKAmm05a5CQPJSB3KcJ5Qwd156G4eZSUY=
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d974525c-05c4-424d-495c-08daccaba7a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 17:04:45.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4ZurHYD8CoDy3fc+cISxu814Rruw8lUQ5uN9Bghes+acjrvI3U4JQYgqYMzqGfBAUp+dctJFhJoye798UEtCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6894
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogxJBvw6BuIFRy4bqnbiBD
w7RuZyBEYW5oIDxjb25nZGFuaHF4QGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJl
ciAyMSwgMjAyMiA4OjM5IEFNDQo+IFRvOiDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiA8YXZh
cmFiQGdtYWlsLmNvbT4NCj4gQ2M6IEdpdCBNTCA8Z2l0QHZnZXIua2VybmVsLm9yZz47IEVyaWMg
RGVDb3N0YQ0KPiA8ZWRlY29zdGFAbWF0aHdvcmtzLmNvbT47IEplZmYgSG9zdGV0bGVyIDxqZWZm
aG9zdEBtaWNyb3NvZnQuY29tPg0KPiBTdWJqZWN0OiBSZTogZnNtb25pdG9yOiB0NzUyNyByYWN5
IG9uIE9TWD8NCj4gDQo+IE9uIDIwMjItMTEtMjEgMTQ6MDc6MTMrMDEwMCwgw4Z2YXIgQXJuZmrD
tnLDsCBCamFybWFzb24NCj4gPGF2YXJhYkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IEkgaGF2ZSBh
Y2Nlc3MgdG8gYSBNYWMgT1MgWCBNMSBib3ggKGdjYzEwNCBhdCBbMV0pIHdoZXJlIHQ3NTI3DQo+
ID4gcmVsaWFibHkgZmFpbHMgZHVlIHRvIHdoYXQgc2VlbXMgdG8gYmUgYSByYWNlIHVzIGRvaW5n
IHNvbWV0aGluZywgYW5kDQo+ID4gYXNzdW1pbmcgdGhhdCBmc21vbml0b3IgcGlja2VkIHVwIG9u
IGl0Lg0KPiANCj4gU2VlIGFsc28gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZ2l0L1l2WmJHQWYr
ODJXdE5YY0pAZGFuaC5kZXYvDQo+IDxodHRwczovL3Byb3RlY3QtDQo+IHVzLm1pbWVjYXN0LmNv
bS9zLzU4MFJDcFluNkVURE9Cb3ljWVZrVXE/ZG9tYWluPWxvcmUua2VybmVsLm9yZz4NCj4gDQo+
IEkgcmFpc2VkIDMgbW9udGhzIGFnbyBhbmQgaXQgc2VlbXMgbGlrZSBKZWZmIEhvc3RldGxlciBp
cyB0b28gYnVzeS4NCj4gDQo+ID4NCj4gPiBUaGlzIG1ha2VzIHRoZSB0ZXN0cyBwYXNzOg0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL3QvdDc1MjctYnVpbHRpbi1mc21vbml0b3Iuc2gNCj4gPiBiL3Qv
dDc1MjctYnVpbHRpbi1mc21vbml0b3Iuc2ggaW5kZXggNTZjMGRmZmZlYS4uY2UyNTU1ZDU1OCAx
MDA3NTUNCj4gPiAtLS0gYS90L3Q3NTI3LWJ1aWx0aW4tZnNtb25pdG9yLnNoDQo+ID4gKysrIGIv
dC90NzUyNy1idWlsdGluLWZzbW9uaXRvci5zaA0KPiA+IEBAIC00MjgsNiArNDI4LDcgQEAgdGVz
dF9leHBlY3Rfc3VjY2VzcyAnZWRpdCBzb21lIGZpbGVzJyAnDQo+ID4gc3RhcnRfZGFlbW9uIC0t
dGYgIiRQV0QvLmdpdC90cmFjZSIgJiYNCj4gPg0KPiA+IGVkaXRfZmlsZXMgJiYNCj4gPiArIHNs
ZWVwIDEgJiYNCj4gPg0KPiA+IHRlc3QtdG9vbCBmc21vbml0b3ItY2xpZW50IHF1ZXJ5IC0tdG9r
ZW4gMCAmJg0KPiA+DQo+ID4gQEAgLTQ0Myw2ICs0NDQsNyBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNz
ICdjcmVhdGUgc29tZSBmaWxlcycgJw0KPiA+IHN0YXJ0X2RhZW1vbiAtLXRmICIkUFdELy5naXQv
dHJhY2UiICYmDQo+ID4NCj4gPiBjcmVhdGVfZmlsZXMgJiYNCj4gPiArIHNsZWVwIDEgJiYNCj4g
Pg0KPiA+IHRlc3QtdG9vbCBmc21vbml0b3ItY2xpZW50IHF1ZXJ5IC0tdG9rZW4gMCAmJg0KPiA+
DQo+ID4gQEAgLTQ3MSw2ICs0NzMsNyBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzICdyZW5hbWUgc29t
ZSBmaWxlcycgJw0KPiA+IHN0YXJ0X2RhZW1vbiAtLXRmICIkUFdELy5naXQvdHJhY2UiICYmDQo+
ID4NCj4gPiByZW5hbWVfZmlsZXMgJiYNCj4gPiArIHNsZWVwIDEgJiYNCj4gPg0KPiA+IHRlc3Qt
dG9vbCBmc21vbml0b3ItY2xpZW50IHF1ZXJ5IC0tdG9rZW4gMCAmJg0KPiA+DQo+ID4gQEAgLTk3
OCw2ICs5ODEsNyBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzDQo+ICFVTklDT0RFX0NPTVBPU0lUSU9O
X1NFTlNJVElWRSAnVW5pY29kZSBuZmMvbmZkJyAnDQo+ID4gbWtkaXIgdGVzdF91bmljb2RlL25m
ZC9kXyR7dXRmOF9uZmR9ICYmDQo+ID4NCj4gPiBnaXQgLUMgdGVzdF91bmljb2RlIGZzbW9uaXRv
ci0tZGFlbW9uIHN0b3AgJiYNCj4gPiArIHNsZWVwIDEgJiYNCj4gPg0KPiA+IGlmIHRlc3RfaGF2
ZV9wcmVyZXEgVU5JQ09ERV9ORkNfUFJFU0VSVkVEIHRoZW4NCj4gPg0KPiA+IFRoZSBmYWlsdXJl
IGlzIHdoZW4gd2UgZ3JlcCBvdXQgdGhlIGV2ZW50cyB3ZSBleHBlY3QsIHdoaWNoIGFyZW4ndA0K
PiA+IHRoZXJlLCBidXQgaWYgeW91IG1hbnVhbGx5IGluc3BlY3QgdGhlbSB0aGV5J3JlIHRoZXJl
LiBJLmUuIHRoZXkncmUNCj4gPiBqdXN0IG5vdCAiaW4iIHlldC4NCj4gPg0KPiA+IEkgdGhvdWdo
dCB0aGlzIG1pZ2h0IGJlIGEgbGFjayBvZiBmbHVzaGluZyBvciBzeW5jaW5nIGluIG91ciBvd24g
dHJhY2UNCj4gPiBjb2RlLCBidXQgYWRkaW5nIGFuIGZzeW5jKCkgdG8gdHJhY2Vfd3JpdGUoKSBk
aWRuJ3QgZG8gdGhlIHRyaWNrLg0KPiA+DQo+ID4gMS4gaHR0cHM6Ly9jZmFybS50ZXRhbmV1dHJh
bC5uZXQvbmV3cy80MSMNCj4gPiA8aHR0cHM6Ly9wcm90ZWN0LQ0KPiB1cy5taW1lY2FzdC5jb20v
cy9TNllOQ3F4b1hHSVdrb05SSEVmTXp1P2RvbWFpbj1jZmFybQ0KPiA+IC50ZXRhbmV1dHJhbC5u
ZXQ+DQo+IA0KPiAtLQ0KPiBEYW5oDQoNCkhvbmVzdGx5LCBJJ20gbm90IHN1cnByaXNlZC4gU3Rv
cHBpbmcgdGhlIGRhZW1vbiBhbmQgZ3JlcHBpbmcgZm9yIGV4cGVjdGVkIHJlc3VsdHMgaW1tZWRp
YXRlbHkgdGhlcmUgYWZ0ZXIgaXMganVzdCBhc2tpbmcgZm9yIHRoZXNlIHNvcnRzIG9mIHJhY2Vz
LiBTbGVlcGluZyBpcyBhIGJpdCB1Z2x5LCBidXQgd2l0aG91dCBhbiBleHBsaWNpdCBtZWFucyBv
ZiBzeW5jaHJvbml6YXRpb24gaXMgcHJvYmFibHkgdGhlIGJlc3QgdGhhdCBjYW4gYmUgZG9uZS4g
SSBjYW4gdGFrZSBhIGxvb2sgYXQgaXQgc29tZSBtb3JlIGFzIEkgaGF2ZSBhY2Nlc3MgdG8gTTEg
TWFjcy4NCg0KLUVyaWMNCg==

