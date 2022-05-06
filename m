Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A54C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 17:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444123AbiEFRMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 13:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444109AbiEFRMH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 13:12:07 -0400
X-Greylist: delayed 60336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 10:08:20 PDT
Received: from us-smtp-delivery-104.mimecast.com (us-smtp-delivery-104.mimecast.com [170.10.133.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B4326EB34
        for <git@vger.kernel.org>; Fri,  6 May 2022 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globalfinishing.com;
        s=mimecast20180829; t=1651856898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=x7YIAgyMLMyVv8+7kmWqaRimoP+ReDEqf0A59gb/zYo=;
        b=ZUpQIZ+CCAL+SUMG/x7AvN8umInz03nF8OfYfxI3Jf2NhT/k6kw9wM5aI4LKcrNat/GxEs
        6FmUYuQxbm23J0TD6syV/rVkrkB6EglUvgsQttFBfjnDFL+2Kqq/uTOIGe6X/04XRypzqy
        av/20NPbkvaLSjFrrra2KSyuSt0huDw=
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-oQS3aK7gNb-2_DzVrGSolg-1; Fri, 06 May 2022 13:08:17 -0400
X-MC-Unique: oQS3aK7gNb-2_DzVrGSolg-1
Received: from CY4PR16MB1655.namprd16.prod.outlook.com (2603:10b6:910:6d::10)
 by PH0PR16MB4200.namprd16.prod.outlook.com (2603:10b6:510:5c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Fri, 6 May
 2022 17:08:16 +0000
Received: from CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea]) by CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea%4]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 17:08:16 +0000
From:   Jason Hatton <jhatton@globalfinishing.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
Thread-Topic: [PATCH] Prevent git from rehashing 4GBi files
Thread-Index: AdhhaYB8U/4vzcmgSD+NCPLlEX9JBw==
Date:   Fri, 6 May 2022 17:08:16 +0000
Message-ID: <CY4PR16MB1655EE6CC2218AEA35B451E3AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 583a1e7e-c0d2-4372-872f-08da2f8302e9
x-ms-traffictypediagnostic: PH0PR16MB4200:EE_
x-microsoft-antispam-prvs: <PH0PR16MB42003CD0F00373293B3CC405AFC59@PH0PR16MB4200.namprd16.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: I8qwwal1xBl0VW7pAG9sgs7/TCg45i7Y4mPTTW2ecatz4IRY0C0RQwhJhRNo+atbN1Nss1bWr+6TQDpFegT/LmZrLFzO5NSqp8mRYPh258lyyYmZFSmvjIYN5U2lkPYuPpA6MZFx/eWS6FuuiwQ6b8Ufo6lQb6sjPGI2w8pbjUxrlelsQWeqJcKmnlifrDnhot/l8G7uKs+mZL74830qtNITB1qnl6I81c3p1McX7reGuUsUPW5v3Q7DVeqPBFtMgBkovM1NtUbwmLA9upMi0pwabtBrnr1cWD3fZRlXTeLgSKtyQPFuLMj7742wxaVSv7YFV6EFNumo8QNJ/AQtLA4DSbaYIB4eWglQLVvMAeZeePCKpVTngnxXv5LoKcQCaATZQlqeajjuiSyHYGX+Qz7PJL3JGibHdQPS0SlyQ7lx82lm0TD22P3o5fUQZ1ADIktJ+kN/ufaBxpUMrQIUHJKMWVGPigyhMmOl6/CYUwtQpVnkfhfiPS8kSmtWOalLFF/a9o/MwylGGUDpsB9MMYOeTJpzKbYoSomggAP12Hmx4x6rIFR+B20T19rdFLJOQR5JHMoaBkU9F/Cl22I0VSSUKeSn4swMA28BoTsjbKgdS7wixKPaEtIW5e++9NkedbHwImQ9jpxahbzFzpIPhsx24adJaWAGZY6iMoDNrBrmsQvML/ZtmBPcR0sW3Vcu20CAzSZq/rz27l2a4gTiQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR16MB1655.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(122000001)(7696005)(186003)(64756008)(66574015)(33656002)(5660300002)(55016003)(110136005)(26005)(4326008)(66446008)(86362001)(52536014)(316002)(508600001)(38100700002)(6506007)(71200400001)(9686003)(66476007)(8676002)(66556008)(38070700005)(66946007)(76116006);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OURaNDNvQnlTT0V6TDFTckViMXA0QXgyL3NNSm81VFhSQ3BRWU1SWVFjWUZJ?=
 =?utf-8?B?amt3U3NSTHM2cnpCb2pXOTc2RGJRWGtkWm5iSjZXOWZndm5BQ1NqQ3dsK3JH?=
 =?utf-8?B?R1NZU0NsS0ovQitGNjI4WERIWDRUNDVkWHRQbnZHcTE3VVJRQWFqLzFLckc1?=
 =?utf-8?B?SUxTQXMrWXBGbENzalRseDFaekNMRXVlNU9CQ1lJdys5eldtLytuRlhSK2Q0?=
 =?utf-8?B?Z1QrTGpLVDF3TlVoRk1FVGdrVXJ5Rkt0SEhpTmcyYytpbHZPZGtTSjdRWnk3?=
 =?utf-8?B?ZW5jQ21jeFZ2K0J4Y2NTbnFHaGpxV1pmMWhVUUVsY2F1bGE4cEZOdDVzSy8x?=
 =?utf-8?B?ZHVKYWRpUjFwcW1TUklaT3BpMWhQNVFmRTBFUCtNYkpxeDYrdlcwRFovaFR4?=
 =?utf-8?B?bm9nako2bUdRUXlGdFJ3ZlNkTEI5Nm5MQXd6c2hxM0NEQ0VGVm1lSW8wT0dS?=
 =?utf-8?B?ODR5Nm5hdFY0TDBvcmlET0NyOU5jS2FLdWxtRm8rVk8vM3pQVG5LOXRDYnRi?=
 =?utf-8?B?RXpRRDMrNHV6MUhnQlVUK2xjelRMQ2xCV0FKSkQzdW80UjZETTFYcGdKVHpt?=
 =?utf-8?B?ZGs1UGtlcndzTmVsYnc5QnhQYXhuZVBDQ1dZWXRYVHRLb2xSd2d0eGhDOTd6?=
 =?utf-8?B?QlY4VWowK2lYUGt0SHZJTFlxS0FDU2twY2ZRbzl0Y001RVpUMWprVGN0eG9z?=
 =?utf-8?B?Qi9FR3h0bGtIOWFlUXZsQjJMcVRTSkxyT1J4WHcyNzNER1Fab0tCWHo2SmF0?=
 =?utf-8?B?cXFKOWphdnVJdTRldGdBdEd3MWRHb3k2TWQzMSszQjc2ZlM5eGNBOEFpYXpV?=
 =?utf-8?B?YmVBR3V3WFhadmQxa2tYaEVVbm9pT2FodXI5NDQvK1ZvMWFhbFVGemV3N1hU?=
 =?utf-8?B?THhUVHEyUkw5Zi8xakY2QUVpT2c2UG1RZFNqdm1QS2diWDlxbUx0SGw1ZjlS?=
 =?utf-8?B?a3R0dmNkVlFJSFBobVI1aFUyTnpzUWxibnp5V01Wc2t0d0J4NXEvelBKdFY3?=
 =?utf-8?B?Q0ZuaFNud21nK2kxSk9IT1E4WDgxQVYyY2Z5NFU4R1FEZU1YUTIzd2lzTkRS?=
 =?utf-8?B?QWk2WkFxbEp2aFZXNzc1VTlZNnNzU21HUFJ2aVg4MVF6UlQvRUJXYkFYSFRp?=
 =?utf-8?B?VjMzRUtJS3QrR3hzZ0pPNFFwbHVlQTdvbE1xVTQzZ2ZwNno0N0s4S3UxVFpZ?=
 =?utf-8?B?N21KaEJ5Tmk2WEEySEpBRVAwdE9NT3dFRzBCTVhXb0V2MFJJMmU4a0M3L2Zn?=
 =?utf-8?B?Z0crMllhNHE2QUh4cmcxaHVNOHgyRk94NVFXdGViVi9iMS9OTDRaUlRjRUh0?=
 =?utf-8?B?UzR5dXM5YU5BSFM5YVh4M1RoZjg5UnJMVGdJNCtIMlR4TzJpSlBER0F5bkRW?=
 =?utf-8?B?cTBnMmRJZHRtQktHZGdxUmV2RkJFdno2ZU1JSkNFYWJsdGg0NjR6NnhyNGpH?=
 =?utf-8?B?Qi96R0RuRGlXNWt0TmtzcThuZFg5MUZuYTFKYlBzL3ZZRFB3V2lxbUd0ekt4?=
 =?utf-8?B?NnhaNmFNSzhYQ3FONEQ2dUcxOEdzRWVkN3N6czVtUGgwaXlXODI3ZkRSNDhi?=
 =?utf-8?B?a2tDaFNtenFGd3pvaVhZNzRsZ0wyTGl0OFpxbEx6ZzJmanh3RWk1Rkg1VTR3?=
 =?utf-8?B?SFdrMFdiWWozUHBseTc3S1ljVTZOS2dxUjdpMFgvR0hxSjdEKzZhcWdZZTFs?=
 =?utf-8?B?U1FwRkJnK3c1S2VENjhLWjBEVEsvVmhTSVdockJseU5pbXVLclpMcEM1dXFu?=
 =?utf-8?B?OHh6VjdxVCt4SjJuSzI5cU9uMGxZZExRTEVHajR6TFZZQmJlYzFIQzN5aWo3?=
 =?utf-8?B?T3ZiUVRNWmROa21wZnQ2RUVzTHZ4cVNiMm5HSjk3SW82VXRaVnArQ3NVYzZV?=
 =?utf-8?B?Q3l6OUZkcUsrQklrZ2crVWwwSGZheW5EVHpKWkNDc1dFeWMzcFhab2JmdlAx?=
 =?utf-8?B?Y0U1eERyL1NaTWlzTllha05NMU1SL29QQ0EraWpDdnMzVCswZGUzaEZHbGR3?=
 =?utf-8?B?cC90RU9EVFk4czVyanZiUzd0eWNhNTBoSGhFWmZsZFUybURhaTJoc1kwK1lk?=
 =?utf-8?B?QkszMlRiZkZidjg0emE2RllyQ09QUklJdS8zQkpvM2Jtd3k0Qk1acGI2ODBy?=
 =?utf-8?B?SHhDUDBiL3pSa3g3ZHZDRFMvbk5WeUFxbEg0VG1UR1NnSVVyTE1WNHIwNldV?=
 =?utf-8?B?bS8wNHdwbFdBT3lzZUpMd0l2eE1JQVQzMW9PSUcxak9MZXlCMWpEaWo0b0Rr?=
 =?utf-8?B?QXNyanhCdTdxR0RNM2toNjJpRjcxMTZ3VnA2d3RpVkhHeW9pcWIrSnFUTUZ6?=
 =?utf-8?B?cm9uZEJPQmJ6KzkzTFFVSmhaTmhvQWtGUXlkQWZvTXkyQmpFU3pYZnUxa1Nv?=
 =?utf-8?Q?FR8iL6ZrNOOB/jzk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: globalfinishing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR16MB1655.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583a1e7e-c0d2-4372-872f-08da2f8302e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 17:08:16.1801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41026ff0-b4fb-4e53-ada8-a2e2e3e9ec4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQKCgOvZTUuQ0UhZWyLIslPmkYKFTQPSN4i8+P/0i9LKC7jcRbpcwggr1CtXFZOxYHB8eui0EEYEJgAwVhoE2Xs1+0iBHFyowek3BAeYaAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR16MB4200
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA104A295 smtp.mailfrom=jhatton@globalfinishing.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: globalfinishing.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PlBoaWxpcCBPYWtsZXkgPHBoaWxpcG9ha2xleUBpZWUuZW1haWw+IHdyaXRlczoNCj4NCj4+IFRo
aXMgIk11bmdlIiBhYm92ZSBpc24ndCB0ZWxsaW5nIHRoZSByZWFkZXIgJ3doeScvJ3doYXQnIGlz
IGdvaW5nIG9uLg0KPj4gVGhlIGNvbW1lbnQgc2hvdWxkIGluIHNvbWUgd2F5IGhpZ2hsaWdodCB0
aGF0IGEgemVybyBzaXplIHJlc3VsdCBpcw0KPj4gc3BlY2lhbCwgYW5kIHRoYXQgd2UgaGF2ZSB0
aGUgcm9sbCBvdmVyIGlzc3VlIHdoZW4gdGhlIHN0b3JlZCBpbiAzMiBiaXRzDQo+PiAtIHRoZSBk
b3VibGUgZHV0eSBvZiByYWN5IHZzIGNoYW5nZWQgaW4gdGhlIHN0YXQgZGF0YSBoZXVyaXN0aWMu
DQo+PiBTeW5vbnltcyBvZiAnbXVuZ2UnID8NCg0KbWFuZ2xlPw0KaGFzaD8NCg0KPj4NCj4+DQo+
Pj4gKyAqLw0KPj4+ICt1bnNpZ25lZCBpbnQgbXVuZ2Vfc3Rfc2l6ZShvZmZfdCBzdF9zaXplKSB7
DQo+Pj4gKyAgICB1bnNpZ25lZCBpbnQgc2Rfc2l6ZSA9IHN0X3NpemU7DQo+Pj4gKw0KPj4+ICsg
ICAgaWYoIXNkX3NpemUgJiYgc3Rfc2l6ZSkNCj4NCj5TdHlsZS4NCg0KU29tZXRoaW5nIGxpa2Ug
MTw8MzE/DQoNCj4NCj4+PiArICAgICAgICByZXR1cm4gMHg4MDAwMDAwMDsNCj4+PiArICAgIGVs
c2UNCj4+PiArICAgICAgICByZXR1cm4gc2Rfc2l6ZTsNCj4+PiArfQ0KPg0KPlRoaXMgbWF5IHRy
ZWF0IG5vbi16ZXJvIG11bHRpcGxlIG9mIDRHaUIgYXMgIm5vdCByYWN5IiwgYnV0IGhhcw0KPmFu
eWJvZHkgZG91YmxlIGNoZWNrZWQgdGhlIGNvbmNlcm4gUsOpbmUgYnJvdWdodCB1cCBlYXJsaWVy
IHRoYXQgYQ0KPjRHaUIgZmlsZSB0aGF0IHdhcyBhZGRlZCBhbmQgdGhlbiBnb3QgcmV3cml0dGVu
IHRvIDJHaUIgd2l0aGluIHRoZQ0KPnNhbWUgc2Vjb25kIHdvdWxkIHN1ZGRlbmx5IHN0YXJ0IGdl
dHRpbmcgdHJlYXRlZCBhcyBub3QgcmFjeT8NCj4NCj5UaGUgcGF0Y2ggKHRoZSBmaXJuYWwgdmVy
c2lvbiBvZiBpdCBhbnl3YXkpIG5lZWRzIHRvIGJlIGFjY29tcGFuaWVkDQo+YnkgYSBoYW5kZnVs
IG9mIHRlc3QgYWRkaXRpb25zIHRvIHRpY2tsZSBjb3JuZXIgY2FzZXMgbGlrZSB0aGF0Lg0KPg0K
PlRoYW5rcywgYWxsLCBmb3Igd29ya2luZyBvbiB0aGlzLg0KDQpJZiB0aGUgZmlsZSBzaXplIGlz
IGNoYW5nZWQgYnkgZXhhY3RseSAyR2lCIGlzIGEgY29uY2Vybi4gVGhpcyBpcyBhbiBpc3N1ZSBm
b3INCmZpbGVzIGV4YWN0bHkgYSBtdWx0aXBsZSBvZiA0R2lCLiBIb3dldmVyLCBhbGwgZmlsZXMg
dGhhdCBhcmUgY2hhbmdlZCBieSBhDQptdWx0aXBsZSBvZiA0R2lCIGFyZSB2dWxuZXJhYmxlLiBT
YXkgNEdpQiArIDQyIGFuZCA4R2lCICsgNDIgd291bGQgYXBwZWFyIHRoZQ0Kc2FtZSB3aXRoIHRo
ZSBjdXJyZW50IHZlcnNpb24gb2YgZ2l0LiBJJ20gc3VyZSB0aGUgdHJ1ZSBmaXggaW52b2x2ZXMg
dXBkYXRpbmcNCnRoZSBpbmRleCBmaWxlIGZvcm1hdCB3aXRoIDY0IGJpdCBmaWxlcyBzaXplcyBh
bmQgYW4gZXhwbGljaXQgcmFjeSBmbGFnLiBJJ20NCmhvcGVmdWwgdGhlIHJlaGFzaGluZyBpc3N1
ZSBmb3IgNEdpQiBmaWxlcyBjYW4gYmUgbWl0aWdhdGVkIHVudGlsIHRoYW4uDQoNCkkgaGF2ZSBh
IHF1ZXN0aW9uIGFib3V0IHRoZSBjb2Rpbmcgc3R5bGUuIFRvcnN0ZW4gaW5kaWNhdGVkIHRoYXQg
dGhlcmUgc2hvdWxkDQpiZSBhbiBleHBsaWNpdCB0eXBlIGNhc3QuIFRoZSBvcmlnaW5hbCBjb2Rl
IGRpZCBub3QgdXNlIGFuIGV4cGxpY2l0IHR5cGUgY2FzdCwNCnNvIEknbSB1bnN1cmUgd2hhdCBp
cyBnb2luZyBvbi4gT25lIG9mIHlvdSBleHBlcnRzIG1heSBoYXZlIHRvIG1ha2UgdGhlIGZpbmFs
DQpwYXRjaC4gSSBob3BlIG15IHByb29mIG9mIGNvbmNlcHQgZ2V0cyB0aGUgaWRlYSBhY3Jvc3Mu
DQoNClRoYW5rcw0KLS0NCkphc29uDQoNCg==

