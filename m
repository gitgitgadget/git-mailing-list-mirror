Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8CAC6FA82
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 14:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiIYOAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Sep 2022 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiIYOAe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2022 10:00:34 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E64B1EAFA
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1664114432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUmXz4DomkFSBXg3KWSXHzGVjT17VJPO1zcwJxJhHh4=;
        b=JilpoWjNFrBSJZKLQb+5NLuld7tVG7lX0YBnu0WK7GWQOKMNPpN3sKT1InLGNy59FmKTq6
        O05nc7KzlDePYbuv3+tHSal68Vy2e6bsZxv4HoQoyiT/l9NLHhC/sZ6caoSJIf1nY4doAz
        cFPAuYjuGVnnzz15iP0wVOUCt86fXVs=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-centralusazlp17013031.outbound.protection.outlook.com [40.93.13.31])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-0v8JWgwdNU24FkrwVTQIpA-1; Sun, 25 Sep 2022 10:00:30 -0400
X-MC-Unique: 0v8JWgwdNU24FkrwVTQIpA-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by BN7PR05MB4514.namprd05.prod.outlook.com (2603:10b6:408::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.11; Sun, 25 Sep 2022 14:00:27 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5654.012; Sun, 25 Sep 2022
 14:00:27 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH v12 5/6] fsmonitor: check for compatability before
 communicating with fsmonitor
Thread-Topic: [PATCH v12 5/6] fsmonitor: check for compatability before
 communicating with fsmonitor
Thread-Index: AQHY0E5d38XpcWXNI0m/cE524vEv3K3wLYCw
Date:   Sun, 25 Sep 2022 14:00:27 +0000
Message-ID: <BL0PR05MB5571F2A2BA548C5D8F2F5E99D9539@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
        <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
 <421d77775dc24e52ab26336a1a82ed0e7b15ff5a.1664048782.git.gitgitgadget@gmail.com>
In-Reply-To: <421d77775dc24e52ab26336a1a82ed0e7b15ff5a.1664048782.git.gitgitgadget@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|BN7PR05MB4514:EE_
x-ms-office365-filtering-correlation-id: 1926b1cd-df18-4d99-8b64-08da9efe4cd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: JsgkKb7Ii5bTK0cdXP8Q/eWiX+4r16tP3F+SnCIyTUaY4GADaQHOSDPPNNcdxnxA9u0lSPAPTcip6AvuviTsDJEylO/mn8lwbgXm1CfTznJhB4X+4Oadgyh69pEWdJ17PqJ3HOoeuDVHxL4nWrW54q9HxuGGeX05RWQ3I1OIRb9MKiF0B05V/rHbSXjI5LJ4McaI0BmR1V5yG16u9FOuruydYq7PVYnziHPNyqmAcimfyrXbFgCDWFEKVuSRwomMl5iTeFPHIxLura73m8dY0F+wKO0v9GmJL7v/RLoIG9Lq035jTK/K9JcQovvpdCmMDXH161tJ0N6jNdKj2yTQhyDHmhsfw7dNpH9vvs9YsGRXU+5a0BBNCXxAux3wAcs02Q/UJrh7af7wiuZSh8HMPxeCGZ9CmVsePyBiomaLMn72abzkXThaxB1Yr7ObKjD3B8SjS0/D9LP7mPZIkCWFNu8FhwA5v//wpIahriZja/qC/w9wMLS/kEjEb1OtLvWsGaYpmeV3cZacBe+FEr+5S0TYOrUmbX0kLaskPOtAHoFnav6lXxN/fYMwvn7RAyZ+eMawFF4HKlDJT6Hiq7BkRjnJtge8kpE6qht6BDYmWI9JLPa3C4Yd03FiG3ErQFcamw0CTKL4wuRYDyVclN4gy1HjOUTqbruQ1Y1ARIxzkS5jye1Nn2z9D5klTFFIGLyVnI/qtnmxy0CHnBIHKB4lbRsqV5lDjlwrJBSMq12I+8+TjMVZjcXGegImw9HSN45yUA9maARmExEo8Ahqyr+dhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(451199015)(76116006)(4326008)(8676002)(66946007)(66446008)(66476007)(66556008)(52536014)(5660300002)(41300700001)(316002)(64756008)(110136005)(54906003)(86362001)(55016003)(33656002)(2906002)(8936002)(83380400001)(38070700005)(122000001)(38100700002)(53546011)(26005)(6506007)(7696005)(9686003)(478600001)(71200400001)(186003)(66574015);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnhxQit2RStKZmJTeEpoS1ljZU9yZFh5S1JjVXIzKy8wSnB5bHN0SDRGT1lx?=
 =?utf-8?B?aTdtTUFvWUtLVzRjOHhYMjlxZUpLVlhnUmZ0eXBPUUVCNFpodmcwV3BmaVow?=
 =?utf-8?B?cnVNZEdMem96VGZlTytaSU9zL1VxcjVFUUFML0duYmR5R040T1p2dEdmdTJZ?=
 =?utf-8?B?cDVVNVU1T01XbVpmSDBxRjRQRmJxZXdKcDJ1MzQ5MlBucmRQR1VDWUl0ZGRS?=
 =?utf-8?B?YmJ6aTBxTGpOQUlOUmN4dWJkTVowd3FkNjlqVzg3dEU0M0dYNWl1UWtGY2RT?=
 =?utf-8?B?ekpHNVpvYzdSNmk1REw4MGVvVmxraFJXY3k1bFBUYUdLUCtadEhjNUpJbXJh?=
 =?utf-8?B?eGl4K0RYYjRyTFM5cnY3SEkrclNxMlc2WXRuN0hDV1ZNS0VWWUJpVkN2dHhr?=
 =?utf-8?B?Y1FqckxkSFowTlVrU2ptUFJJV3JoR2pQSUg2MkNEVWcxZTFoWkVsUGFXSStZ?=
 =?utf-8?B?LzZNeWlNU1V1Um94YThwNVFmMnl5TGFlMk9DcytpUmk0cHhLQzhRTTczU2w2?=
 =?utf-8?B?dVlzdTY5bWpuNU4yYng2ekovVVhESmN6ZjhQVDdWRzE2Njh5d041d2o2OGp6?=
 =?utf-8?B?aXZxdEVoeU9mQjgvaFZyVHowTUJuTU9aOGJLZXp4NEhZajltdWtTbUh0RW9M?=
 =?utf-8?B?V1ZadjAwS3c0Z2Y5YlQ0RFliZG5KUi9BcE1JLzdnaHFVY1JLNFl0VGR6SlB4?=
 =?utf-8?B?TDV3RzFTZ3BTWnR1OGJxaEpSRzk5Qk4vd1ZMcldCcTd1OTB4RzNMcGJ3S084?=
 =?utf-8?B?a0x3ZmRpTzBuRzNpWmwyQ3NyMlRrT0lncGltRitIaFhLTFJlRDhpbFVYTU9U?=
 =?utf-8?B?a2V2YUN0RnFTUEVodTByR25LNG1HUlZBcWtDRnpMODcwS1N3Z3dnYllrd2Vj?=
 =?utf-8?B?K3V6Nk9EdlFoeHNjYlBZSlhUSUx4bFFkcFpXTW80UXlSMEhKRkd5M3p5SFFo?=
 =?utf-8?B?UXNPYkx0M0Z0YmoxRjlxOFoyUzhoYUpmTzVqZGpjamZLVW9jS3QzejJvYkwz?=
 =?utf-8?B?VkpLdFJ1dUF1d0pHWDNZVDdML0dzdm4wZGg3b2pWbzh6ZFNQRWY3NG1SVXZT?=
 =?utf-8?B?djhLc3BEUzR3ZjNPYm1ldEhoT0N1Z21XRitXQzVJQkkwZTBjQWNwL055R0l4?=
 =?utf-8?B?UFJPdlgrRmtSbzNyZTM1bXF1ZEpzOFVOODgrdFVkOUFKK2tZUytEK2VLd3pq?=
 =?utf-8?B?L0h5cUhRNWwrblJSemtVaDErdEV3NVRvc1VjdzJWSlBEd21pamNodDJQWTdV?=
 =?utf-8?B?Zld6bE14aS9nd2ZxV0Q5YVNTN2RaSnhyTFNvMUVOdWRHV2NHRXBWbmZaZHZN?=
 =?utf-8?B?VG1vTENsMHRiOTVpdUpKM2VCR1ZTTHBEcVFmZ0Nqdk5VZ084YnhzbEplc01R?=
 =?utf-8?B?YUlza3h3bmtUNUQrVjloUUVDOXdrcUx2NlFUUUh2alJjUGxGSng2QS9MM1l5?=
 =?utf-8?B?MGJqTmV1OHc3RkxvNjVsWXRGOEpaM2JnUXVYN3NHOE1qaDVQbWhQVGdpWVpE?=
 =?utf-8?B?UUZFYm44Unk5R0tDNng0VUNqNjBXMjh2akJrVjAyT2FFbDVWSStnNFN6ZGQ0?=
 =?utf-8?B?djJFaGorRlZORGpoNVF0OUlaMDlxdGc5NnBSZHBJOGdSY0lBM1o5U2tITHdT?=
 =?utf-8?B?R1NqL2NGZFlmMk5OdGdWTlVqYk1vcENCYVhwak1NNEc2cFpmTW1YUkE4Y3Vl?=
 =?utf-8?B?QUdXcVNUbDZUeCtJd2tubmdEc0Z4WmJGRjlXVWwrYkp1dExzT0MzdU14TzZS?=
 =?utf-8?B?dDhpUmZoYXE1ek1VL3oyUjdLaS9oQnBlR2NDTmI1Tis3K0NGYVVBektJSENO?=
 =?utf-8?B?aHJ4S3N6c1Y5MGdGZjhwVHRUQ3htUmNEM2dQOCs2OVlFQUxzNmRzQ0srM1Zw?=
 =?utf-8?B?dFhzMW1LbkFTT0h2OVg3R1l4TS9KU3pYNk1XZ3BubVlJRUw0QzhQTVJKUHZT?=
 =?utf-8?B?ZkI1UzN4aGVpa05FamtzWTNuaW9KOXRvTXZhSjh5L0VIYlIrM2thMlZjTTdh?=
 =?utf-8?B?WjlxRmJ6ZC9veiswd1kxVFNNZ0orSEQxdWZpNXk1YTNjRm5GbkNHTmpOQ2U0?=
 =?utf-8?B?Mjc4WW9EdUZJZC96SkVsdjN1NXE5TFF6TGpSTFRZNFc4b0tGUERjV2pPWHdX?=
 =?utf-8?Q?zQNUcl5+LisyoACuYQL7CJruh?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1926b1cd-df18-4d99-8b64-08da9efe4cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2022 14:00:27.4397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdiwasBjlcH30F961Hk23QocKBuYwCI53Z2iGdFftlvSm9/S8uN/M2sP6MqWgSyKdlLFQXCcMEBDhQ8hOqXARA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4514
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBEZUNvc3RhIHZp
YSBHaXRHaXRHYWRnZXQgPGdpdGdpdGdhZGdldEBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5
LCBTZXB0ZW1iZXIgMjQsIDIwMjIgMzo0NiBQTQ0KPiBUbzogZ2l0QHZnZXIua2VybmVsLm9yZw0K
PiBDYzogSmVmZiBIb3N0ZXRsZXIgPGdpdEBqZWZmaG9zdGV0bGVyLmNvbT47IEVyaWMgU3Vuc2hp
bmUNCj4gPHN1bnNoaW5lQHN1bnNoaW5lY28uY29tPjsgVG9yc3RlbiBCw7ZnZXJzaGF1c2VuIDx0
Ym9lZ2lAd2ViLmRlPjsNCj4gw4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24gPGF2YXJhYkBnbWFp
bC5jb20+OyBSYW1zYXkgSm9uZXMNCj4gPHJhbXNheUByYW1zYXlqb25lcy5wbHVzLmNvbT47IEpv
aGFubmVzIFNjaGluZGVsaW4NCj4gPEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPjsgRXJpYyBE
ZUNvc3RhIDxlZGVjb3N0YUBtYXRod29ya3MuY29tPjsNCj4gRXJpYyBEZUNvc3RhIDxlZGVjb3N0
YUBtYXRod29ya3MuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjEyIDUvNl0gZnNtb25pdG9yOiBj
aGVjayBmb3IgY29tcGF0YWJpbGl0eSBiZWZvcmUNCj4gY29tbXVuaWNhdGluZyB3aXRoIGZzbW9u
aXRvcg0KPiANCj4gRnJvbTogRXJpYyBEZUNvc3RhIDxlZGVjb3N0YUBtYXRod29ya3MuY29tPg0K
PiANCj4gSWYgZnNtb25pdG9yIGlzIG5vdCBpbiBhIGNvbXBhdGlibGUgc3RhdGUsIGRpZSB3aXRo
IGFuIGFwcHJvcHJpYXRlIGVycm9yDQo+IG1lc3NnZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVy
aWMgRGVDb3N0YSA8ZWRlY29zdGFAbWF0aHdvcmtzLmNvbT4NCj4gLS0tDQoNCkdyci4gU2hvdWxk
IGJlICJ3YXJuIHdpdGggYW4gYXBwcm9wcmlhdGUgZXJyb3IgbWVzc2FnZSIuDQoNCi1FcmljDQoN
Cj4gIGNvbXBhdC9mc21vbml0b3IvZnNtLXNldHRpbmdzLWRhcndpbi5jIHwgIDIgKy0NCj4gIGZz
bW9uaXRvci1zZXR0aW5ncy5jICAgICAgICAgICAgICAgICAgIHwgMTAgKysrKysrKy0tLQ0KPiAg
ZnNtb25pdG9yLXNldHRpbmdzLmggICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZnNtb25p
dG9yLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNyArKysrKysrDQo+ICA0IGZpbGVz
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvY29tcGF0L2ZzbW9uaXRvci9mc20tc2V0dGluZ3MtZGFyd2luLmMNCj4gYi9jb21wYXQv
ZnNtb25pdG9yL2ZzbS1zZXR0aW5ncy1kYXJ3aW4uYw0KPiBpbmRleCA0MGRhMmQzYjUzMy4uNDQy
MzMxMjVkZjggMTAwNjQ0DQo+IC0tLSBhL2NvbXBhdC9mc21vbml0b3IvZnNtLXNldHRpbmdzLWRh
cndpbi5jDQo+ICsrKyBiL2NvbXBhdC9mc21vbml0b3IvZnNtLXNldHRpbmdzLWRhcndpbi5jDQo+
IEBAIC0zOCw3ICszOCw3IEBAIHN0YXRpYyBlbnVtIGZzbW9uaXRvcl9yZWFzb24NCj4gY2hlY2tf
dWRzX3ZvbHVtZShzdHJ1Y3QgcmVwb3NpdG9yeSAqcikNCj4gIAlzdHJidWZfcmVsZWFzZSgmcGF0
aCk7DQo+IA0KPiAgCWlmIChmcy5pc19yZW1vdGUpDQo+IC0JCXJldHVybiBGU01PTklUT1JfUkVB
U09OX1JFTU9URTsNCj4gKwkJcmV0dXJuIEZTTU9OSVRPUl9SRUFTT05fTk9TT0NLRVRTOw0KPiAN
Cj4gIAlpZiAoIXN0cmNtcChmcy50eXBlbmFtZSwgIm1zZG9zIikpIC8qIGFrYSBGQVQzMiAqLw0K
PiAgCQlyZXR1cm4gRlNNT05JVE9SX1JFQVNPTl9OT1NPQ0tFVFM7DQo+IGRpZmYgLS1naXQgYS9m
c21vbml0b3Itc2V0dGluZ3MuYyBiL2ZzbW9uaXRvci1zZXR0aW5ncy5jIGluZGV4DQo+IDUzMWEx
YjZmOTU2Li44NTkyYTRkOWJhZCAxMDA2NDQNCj4gLS0tIGEvZnNtb25pdG9yLXNldHRpbmdzLmMN
Cj4gKysrIGIvZnNtb25pdG9yLXNldHRpbmdzLmMNCj4gQEAgLTEsNiArMSw3IEBADQo+ICAjaW5j
bHVkZSAiY2FjaGUuaCINCj4gICNpbmNsdWRlICJjb25maWcuaCINCj4gICNpbmNsdWRlICJyZXBv
c2l0b3J5LmgiDQo+ICsjaW5jbHVkZSAiZnNtb25pdG9yLWlwYy5oIg0KPiAgI2luY2x1ZGUgImZz
bW9uaXRvci1zZXR0aW5ncy5oIg0KPiAgI2luY2x1ZGUgImZzbW9uaXRvci1wYXRoLXV0aWxzLmgi
DQo+IA0KPiBAQCAtMjQyLDEwICsyNDMsMTEgQEAgZW51bSBmc21vbml0b3JfcmVhc29uDQo+IGZz
bV9zZXR0aW5nc19fZ2V0X3JlYXNvbihzdHJ1Y3QgcmVwb3NpdG9yeSAqcikNCj4gIAlyZXR1cm4g
ci0+c2V0dGluZ3MuZnNtb25pdG9yLT5yZWFzb247DQo+ICB9DQo+IA0KPiAtY2hhciAqZnNtX3Nl
dHRpbmdzX19nZXRfaW5jb21wYXRpYmxlX21zZyhjb25zdCBzdHJ1Y3QgcmVwb3NpdG9yeSAqciwN
Cj4gK2NoYXIgKmZzbV9zZXR0aW5nc19fZ2V0X2luY29tcGF0aWJsZV9tc2coc3RydWN0IHJlcG9z
aXRvcnkgKnIsDQo+ICAJCQkJCSBlbnVtIGZzbW9uaXRvcl9yZWFzb24gcmVhc29uKQ0KPiAgew0K
PiAgCXN0cnVjdCBzdHJidWYgbXNnID0gU1RSQlVGX0lOSVQ7DQo+ICsJY29uc3QgY2hhciAqc29j
a2V0X2RpcjsNCj4gDQo+ICAJc3dpdGNoIChyZWFzb24pIHsNCj4gIAljYXNlIEZTTU9OSVRPUl9S
RUFTT05fVU5URVNURUQ6DQo+IEBAIC0yODEsOSArMjgzLDExIEBAIGNoYXIgKmZzbV9zZXR0aW5n
c19fZ2V0X2luY29tcGF0aWJsZV9tc2coY29uc3QNCj4gc3RydWN0IHJlcG9zaXRvcnkgKnIsDQo+
ICAJCWdvdG8gZG9uZTsNCj4gDQo+ICAJY2FzZSBGU01PTklUT1JfUkVBU09OX05PU09DS0VUUzoN
Cj4gKwkJc29ja2V0X2RpciA9IGRpcm5hbWUoKGNoYXIgKilmc21vbml0b3JfaXBjX19nZXRfcGF0
aChyKSk7DQo+ICAJCXN0cmJ1Zl9hZGRmKCZtc2csDQo+IC0JCQkgICAgXygicmVwb3NpdG9yeSAn
JXMnIGlzIGluY29tcGF0aWJsZSB3aXRoIGZzbW9uaXRvcg0KPiBkdWUgdG8gbGFjayBvZiBVbml4
IHNvY2tldHMiKSwNCj4gLQkJCSAgICByLT53b3JrdHJlZSk7DQo+ICsJCQkgICAgXygic29ja2V0
IGRpcmVjdG9yeSAnJXMnIGlzIGluY29tcGF0aWJsZSB3aXRoDQo+IGZzbW9uaXRvciBkdWUiDQo+
ICsJCQkJICAiIHRvIGxhY2sgb2YgVW5peCBzb2NrZXRzIHN1cHBvcnQiKSwNCj4gKwkJCSAgICBz
b2NrZXRfZGlyKTsNCj4gIAkJZ290byBkb25lOw0KPiAgCX0NCj4gDQo+IGRpZmYgLS1naXQgYS9m
c21vbml0b3Itc2V0dGluZ3MuaCBiL2ZzbW9uaXRvci1zZXR0aW5ncy5oIGluZGV4DQo+IDA3MjE2
MTdiOTVhLi5hYjAyZTM5OTVlZSAxMDA2NDQNCj4gLS0tIGEvZnNtb25pdG9yLXNldHRpbmdzLmgN
Cj4gKysrIGIvZnNtb25pdG9yLXNldHRpbmdzLmgNCj4gQEAgLTMzLDcgKzMzLDcgQEAgZW51bSBm
c21vbml0b3JfbW9kZSBmc21fc2V0dGluZ3NfX2dldF9tb2RlKHN0cnVjdA0KPiByZXBvc2l0b3J5
ICpyKTsgIGNvbnN0IGNoYXIgKmZzbV9zZXR0aW5nc19fZ2V0X2hvb2tfcGF0aChzdHJ1Y3QgcmVw
b3NpdG9yeQ0KPiAqcik7DQo+IA0KPiAgZW51bSBmc21vbml0b3JfcmVhc29uIGZzbV9zZXR0aW5n
c19fZ2V0X3JlYXNvbihzdHJ1Y3QgcmVwb3NpdG9yeSAqcik7IC0NCj4gY2hhciAqZnNtX3NldHRp
bmdzX19nZXRfaW5jb21wYXRpYmxlX21zZyhjb25zdCBzdHJ1Y3QgcmVwb3NpdG9yeSAqciwNCj4g
K2NoYXIgKmZzbV9zZXR0aW5nc19fZ2V0X2luY29tcGF0aWJsZV9tc2coc3RydWN0IHJlcG9zaXRv
cnkgKnIsDQo+ICAJCQkJCSBlbnVtIGZzbW9uaXRvcl9yZWFzb24gcmVhc29uKTsNCj4gDQo+ICBz
dHJ1Y3QgZnNtb25pdG9yX3NldHRpbmdzOw0KPiBkaWZmIC0tZ2l0IGEvZnNtb25pdG9yLmMgYi9m
c21vbml0b3IuYw0KPiBpbmRleCA1N2Q2YTQ4M2JlZS4uNTQwNzM2YjM5ZmQgMTAwNjQ0DQo+IC0t
LSBhL2ZzbW9uaXRvci5jDQo+ICsrKyBiL2ZzbW9uaXRvci5jDQo+IEBAIC0yOTUsNiArMjk1LDcg
QEAgc3RhdGljIGludCBmc21vbml0b3JfZm9yY2VfdXBkYXRlX3RocmVzaG9sZCA9IDEwMDsNCj4g
DQo+ICB2b2lkIHJlZnJlc2hfZnNtb25pdG9yKHN0cnVjdCBpbmRleF9zdGF0ZSAqaXN0YXRlKSAg
ew0KPiArCXN0YXRpYyBpbnQgd2Fybl9vbmNlID0gMDsNCj4gIAlzdHJ1Y3Qgc3RyYnVmIHF1ZXJ5
X3Jlc3VsdCA9IFNUUkJVRl9JTklUOw0KPiAgCWludCBxdWVyeV9zdWNjZXNzID0gMCwgaG9va192
ZXJzaW9uID0gLTE7DQo+ICAJc2l6ZV90IGJvbCA9IDA7IC8qIGJlZ2lubmluZyBvZiBsaW5lICov
IEBAIC0zMDUsNiArMzA2LDEyIEBAIHZvaWQNCj4gcmVmcmVzaF9mc21vbml0b3Ioc3RydWN0IGlu
ZGV4X3N0YXRlICppc3RhdGUpDQo+ICAJaW50IGlzX3RyaXZpYWwgPSAwOw0KPiAgCXN0cnVjdCBy
ZXBvc2l0b3J5ICpyID0gaXN0YXRlLT5yZXBvID8gaXN0YXRlLT5yZXBvIDogdGhlX3JlcG9zaXRv
cnk7DQo+ICAJZW51bSBmc21vbml0b3JfbW9kZSBmc21fbW9kZSA9IGZzbV9zZXR0aW5nc19fZ2V0
X21vZGUocik7DQo+ICsJZW51bSBmc21vbml0b3JfcmVhc29uIHJlYXNvbiA9IGZzbV9zZXR0aW5n
c19fZ2V0X3JlYXNvbihyKTsNCj4gKw0KPiArCWlmICghd2Fybl9vbmNlICYmIHJlYXNvbiA+IEZT
TU9OSVRPUl9SRUFTT05fT0spIHsNCj4gKwkJd2Fybl9vbmNlID0gMTsNCj4gKwkJd2FybmluZygi
JXMiLCBmc21fc2V0dGluZ3NfX2dldF9pbmNvbXBhdGlibGVfbXNnKHIsDQo+IHJlYXNvbikpOw0K
PiArCX0NCj4gDQo+ICAJaWYgKGZzbV9tb2RlIDw9IEZTTU9OSVRPUl9NT0RFX0RJU0FCTEVEIHx8
DQo+ICAJICAgIGlzdGF0ZS0+ZnNtb25pdG9yX2hhc19ydW5fb25jZSkNCj4gLS0NCj4gZ2l0Z2l0
Z2FkZ2V0DQoNCg==

