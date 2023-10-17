Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FDF436AF
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=globalfinishing.com header.i=@globalfinishing.com header.b="c+PMjNo8"
X-Greylist: delayed 70 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 07:50:26 PDT
Received: from us-smtp-delivery-104.mimecast.com (us-smtp-delivery-104.mimecast.com [170.10.129.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB579421C
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globalfinishing.com;
	s=mimecast20180829; t=1697554218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXNFqwAEskoo9np8EgHEH/cXDnIUjm1HnDVdU4VNseE=;
	b=c+PMjNo8g+EMIvphIbx4PJNv6ohA6PneNcnQrUJCqCV7/2U4LMv792wT6kfj8iCw1PnjUs
	mvC/vyg0xyQbahEM3mVF33zEATtSqUE18HswssiKxBQhrehuvorxFbj68iK2KDhjsHvA2k
	pLqBhh+LbWQcLOj1CIfMwc6fUse2Q1o=
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-8KL3cFYCMQSNaJXJQ7uT2w-1; Tue, 17 Oct 2023 10:49:13 -0400
X-MC-Unique: 8KL3cFYCMQSNaJXJQ7uT2w-1
Received: from MW5PR16MB5079.namprd16.prod.outlook.com (2603:10b6:303:1cf::9)
 by LV8PR16MB6331.namprd16.prod.outlook.com (2603:10b6:408:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 14:49:09 +0000
Received: from MW5PR16MB5079.namprd16.prod.outlook.com
 ([fe80::a7a0:f497:719c:e596]) by MW5PR16MB5079.namprd16.prod.outlook.com
 ([fe80::a7a0:f497:719c:e596%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:49:09 +0000
From: Jason Hatton <jhatton@globalfinishing.com>
To: Jeff King <peff@peff.net>, "brian m. carlson"
	<sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] Prevent git from rehashing 4GiB files
Thread-Topic: [PATCH v2 2/2] Prevent git from rehashing 4GiB files
Thread-Index: AQHaAQkWlwsX20paO0u8/s3qVXKm/A==
Date: Tue, 17 Oct 2023 14:49:09 +0000
Message-ID: <MW5PR16MB50791EDD3D006EFBE8DBBCB3AFD6A@MW5PR16MB5079.namprd16.prod.outlook.com>
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
 <20231012160930.330618-3-sandals@crustytoothpaste.net>
 <20231017000019.GB551672@coredump.intra.peff.net>
In-Reply-To: <20231017000019.GB551672@coredump.intra.peff.net>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR16MB5079:EE_|LV8PR16MB6331:EE_
x-ms-office365-filtering-correlation-id: f854f9d2-4e62-49cd-f543-08dbcf203887
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: OVzikn+/tDZa9rt2Ygj54iu1WmoJqsdis66AYVBmZXYJPOWiyr/jkpbFjOf6ElKfCEDTOOTk5BVMnxHPgm+jjbFQHDMFxT2zXbimilnA9mXk4QlPY3mxpXZ8g4cHf1yjrsroNx+q7odZpt7cYbbpbokHavVvtumwDv9VLXlLQ3zj7Jl5a4glp49iUDyNkEy82MS7kecwivJ8EPUb7LJszllpuqQwfUT77bQ8wOGY3wnSnKbtBSYcC6IBr3mrVLpHuTYasq2+MpXGe9zJ9RcUgkKx+1m+l5bpXHzsCf+ySdCiKqLRpvDB1aXzodj7m558oKDAexNmbVVQu4OMdqpiZD3nbOZ7u5Uza7PUmjp214Duxpc6RgoXOQhY85ZBTbuTUodhKGbDfpc62bOwCrZ+X1AmFKAvYJKOYRL3a5NNhcNoXwgQOnUjK8vncCggsjoano81We5GhQu59645VZKH+wKFX2cwLxN/tz165HhCWuP3jr8Lcv6iLUbgs/FtZeXOyyCu5DDIvn7mTiS2wSuZLXwe2Ju87oifXwuW30bBRiInfGet9lq9iW4pzQ7rQPPE4Jw+l8Pnz4oruHutIuYiH5/DIppoS7OsAUKeN1Aricmwiq1Vthg5DFzVbU2i8Ln5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR16MB5079.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(366004)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(55016003)(66476007)(26005)(110136005)(52536014)(54906003)(66556008)(66946007)(64756008)(66446008)(76116006)(8936002)(8676002)(4326008)(316002)(9686003)(7696005)(6506007)(71200400001)(41300700001)(5660300002)(2906002)(478600001)(38100700002)(38070700005)(122000001)(33656002)(86362001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGQ1eHVBL0oyTWJnNUowWmhSNHFqWHUrQjkzcGVtWDFZTTlZNnpGMDIzenFR?=
 =?utf-8?B?OTFPT3ZCS296OTh1cXB5cytKNVQ5bVhHTTVkUjZWdmw2Nkx0b3RKQTllbEF2?=
 =?utf-8?B?dTFTZWtrU2IrWFI4eU4xTW5JbE5WS1RDeElQZTdzL3pvVDFFNjdEd3pOUFNY?=
 =?utf-8?B?Z1BLc1MyTWkwaTBZdW13eWc5UlVGTTA1bnNQRTlRRWJCQUQ4b3pZVDFPUUFt?=
 =?utf-8?B?bURsTVQwaVhYcDFhZDZnOUR3aDFzY3RCVlhaSUNKUGNCSllualVmMDhNWEdm?=
 =?utf-8?B?b0JBMFlJUEhjSG45d1dUZUhXRVRHOVlaL244RGlXd2NBOWt0NGFZdmp0QTVj?=
 =?utf-8?B?V1N6WDRpWXVhSTgrbXVHZEVNc1ExNnNvY0c4ajAyTnNHM0tzVUtFUGlPQjRK?=
 =?utf-8?B?MnhjM1BWbTVtYWxkVHZmM3ZuWnVOMjhwdlJTanMvcDVmbS90MEhaN1oyK2RJ?=
 =?utf-8?B?WUpOOTVMamgwSk95dmV1Qit3REJKcGdZaklOZkJrTjhyd0xDTThJN3BjbE9h?=
 =?utf-8?B?Ni9ueitSREFINnlUUDNENWIvZm45Z0ZJcm9xbUxIQnNBQU1BdE5pK2g2ZUpq?=
 =?utf-8?B?Z1VaWW9MbEZ3blIvTVlDcGpXanp6b29YSVV2ZkJBVnc4T1k0T1VYWjJ5NWRV?=
 =?utf-8?B?TGorTVI3Vko5SVJiVVVoTHJhdlZ6YWo5aytBVWlZaDBwdFFqSUpad1NpRXE1?=
 =?utf-8?B?alJMSGFQbXlVckdOcFRDbmJRRUVlSjAxRzhtMFhTRXN1b1V4YlZJWnRRbzFy?=
 =?utf-8?B?QkQxdE40blZUUU9KdS94Snh0cEZwbFVUL0pjbVQ5cG1JcVppNFltYzFvS0Ur?=
 =?utf-8?B?OWxOT0NuVDJISXFXcGxmZXRnR21lc3o2ZmQwczVod0VYK3pLZTN5K2Nycncy?=
 =?utf-8?B?UENYQlZ6L210WE1CdE05NFNPcmhsaEJ4S2JkMjgvbjhpWlVabGNMNy9uRkhW?=
 =?utf-8?B?eERnNTMwZmVhSm9TcjFTNVZVMEFXdlNVRnd2OWVKSWh4RU15Qm9NaXVNQ2Nj?=
 =?utf-8?B?R29mTEczQTdQM0xLVngyVkRNTFFxRTZsa0NmMlJmWXZCaW1rRXpOQXUzb2N2?=
 =?utf-8?B?SHJpOXpYK2tIN2lLMk45akZrYzJlY1VtQTU0eHpuVndRbSt3RCt6Zzl5cElK?=
 =?utf-8?B?em5lNEZnaTYvc1ZKQS9XK01TNUF5VnBJenNNR1YwN3VZbjNsM25ab3ZIU0RO?=
 =?utf-8?B?a3VWSDNURXhEaWxwRVhka0FmSnYrZjJpd1pFYWdWZStLQzZWY0dDNGVVTjdF?=
 =?utf-8?B?eGZMYzJ0VmJZTTBwb2lhMjc4MmtoZ05uMG9OS3ltYnoweEVKS1lxbm9OUW9M?=
 =?utf-8?B?NGVoTHMva2NwdDk0b1cvM3BCR25SREhNN3prZTVZMlRyY01welNlY0lheDVn?=
 =?utf-8?B?alBHSTBFRzBXYU0zc2llT3I1NEZVamJYWE0xRmhZOU9SZDdoVWZNR3RoYnhJ?=
 =?utf-8?B?YWpzMkJ3dnU2UWhDSWtIcmt1cTVXZldlYVdHSDZiMUhJU0dHeFRiVGtNOTc5?=
 =?utf-8?B?S29ZKzk5enJVVmpYSEwvZGJMV0RzUlNLaW9qemhGQ2FnYnVBTndTR2E1cmxV?=
 =?utf-8?B?WDNIaXBJdjNObjkydWhZR0F4RDI5NSswNis1dTNEeDZsMlo2bXRyTTNHbFV4?=
 =?utf-8?B?YUFzRzFsaWdabDM0VjhCdUdxZFR6SHlEcExCdVE1cVRVR2Uya2JkWVBUZnVY?=
 =?utf-8?B?U2NTaFB4U1IvT1JocGJndkJMNmZwVmRLY1N1MWtZbW1DWVV6TjNGN21QNytp?=
 =?utf-8?B?aG5KcExlZkxtRmRoYjcrVmpwcHRUb3FRSE9FYk0vUXhCNjhpNDhrVmI0UjhD?=
 =?utf-8?B?VTAyTTdzYjd0NE9leHZLV3JHajVsS1FaV0c1eVh3OUdBT3V6eUNldmN1SmVz?=
 =?utf-8?B?YWFrTmM3KzFNaEhsclVlc3BTZk4zb1JMYWxWMHJ1VFpMZEVHbUNSMStMdlVp?=
 =?utf-8?B?dVFzRHJQR0h3Z1l2RFpYVGtRRlJwcUhZdUpkYlI0VHFVRG5jSGI4MlFNbGx5?=
 =?utf-8?B?ZUVaWGROWGNsbkxuYUgyaDMwQm0zSEJJdzZRSFhyaEU0M1YyT2Q3OEhFV2ZZ?=
 =?utf-8?B?WmhzVXpJOVE0VW8rRjZqUVkzS3hKWVNBMTBTd3BJT052aElMYWlZVVBvUU81?=
 =?utf-8?B?N0JURGMramo5cFQwZkhjNldST1N4NGNZc1p2ck81QWpIaTM0ejBuTW1BZm9p?=
 =?utf-8?B?NGc9PQ==?=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: globalfinishing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR16MB5079.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f854f9d2-4e62-49cd-f543-08dbcf203887
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 14:49:09.6823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41026ff0-b4fb-4e53-ada8-a2e2e3e9ec4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+ZIu9hdF1+m1JN8BJsXj7Ft3ZnpZq3RwlXnhjEDz2euklFP3KeT4Wzu+YkY264zh9Ote7aboJgc/p9UYbpbgnghsADROhJqDN6FOGMSBEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6331
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: globalfinishing.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0Pg0KDQo+IE9uIFRodSwgT2N0IDEyLCAyMDIz
IGF0IDA0OjA5OjMwUE0gKzAwMDAsIGJyaWFuIG0uIGNhcmxzb24gd3JvdGU6DQo+IA0KPiA+ICtz
dGF0aWMgdW5zaWduZWQgaW50IG11bmdlX3N0X3NpemUob2ZmX3Qgc3Rfc2l6ZSkgew0KPiA+ICsJ
dW5zaWduZWQgaW50IHNkX3NpemUgPSBzdF9zaXplOw0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkg
KiBJZiB0aGUgZmlsZSBpcyBhbiBleGFjdCBtdWx0aXBsZSBvZiA0IEdpQiwgbW9kaWZ5IHRoZSB2
YWx1ZSBzbyBpdA0KPiA+ICsJICogZG9lc24ndCBnZXQgbWFya2VkIGFzIHJhY2lseSBjbGVhbiAo
emVybykuDQo+ID4gKwkgKi8NCj4gPiArCWlmICghc2Rfc2l6ZSAmJiBzdF9zaXplKQ0KPiA+ICsJ
CXJldHVybiAweDgwMDAwMDAwOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJldHVybiBzZF9zaXplOw0K
PiA+ICt9DQo+IA0KPiBDb3Zlcml0eSBjb21wbGFpbmVkIHRoYXQgdGhlICJ0cnVlIiBzaWRlIG9m
IHRoaXMgY29uZGl0aW9uYWwgaXMNCj4gdW5yZWFjaGFibGUsIHNpbmNlIHNkX3NpemUgaXMgYXNz
aWduZWQgZnJvbSBzdF9zaXplLCBzbyB0aGUgdHdvIHZhbHVlcw0KPiBjYW5ub3QgYmUgYm90aCB0
cnVlIGFuZCBmYWxzZS4gQnV0IG9idmlvdXNseSB3ZSBhcmUgZGVwZW5kaW5nIGhlcmUgb24NCj4g
dGhlIHRydW5jYXRpb24gb2Ygb2ZmX3QgdG8gInVuc2lnbmVkIGludCIuIEknbSBub3Qgc3VyZSBp
ZiBDb3Zlcml0eSBpcw0KPiBqdXN0IGR1bWIsIG9yIGlmIGl0IHNvbWVob3cgaGFzIGEgZGlmZmVy
ZW50IHNpemUgZm9yIG9mZl90Lg0KPiANCj4gSSBkb24ndCBfdGhpbmtfIHRoaXMgd291bGQgZXZl
ciBjYXVzZSBjb25mdXNpb24gaW4gYSByZWFsIGNvbXBpbGVyLCBhcw0KPiBhc3NpZ25tZW50IGZy
b20gYSBsYXJnZXIgdHlwZSB0byBhIHNtYWxsZXIgaGFzIHdlbGwtZGVmaW5lZCB0cnVuY2F0aW9u
LA0KPiBhcyBmYXIgYXMgSSBrbm93Lg0KPiANCj4gQnV0IEkgZG8gd29uZGVyIGlmIGFuIGV4cGxp
Y2l0ICImIDB4RkZGRkZGRkYiIHdvdWxkIG1ha2UgaXQgbW9yZSBvYnZpb3VzDQo+IHdoYXQgaXMg
aGFwcGVuaW5nICh3aGljaCB3b3VsZCBhbHNvIGRvIHRoZSByaWdodCB0aGluZyBpZiBpbiBzb21l
DQo+IGh5cG90aGV0aWNhbCBwbGF0Zm9ybSAidW5zaWduZWQgaW50IiBlbmRlZCB1cCBsYXJnZXIg
dGhhbiAzMiBiaXRzKS4NCj4gDQo+IC1QZWZmDQoNCkkgb3JpZ2luYWxseSB3cm90ZSB0aGUgY29k
ZSB0aGlzIHdheSB0byB3b3JrIGV4YWN0bHkgbGlrZSB0aGUgb3JpZ2luYWwNCmNvZGUgd2l0aCBv
bmUgZXhjZXB0aW9uOiBOZXZlciB0cnVuY2F0ZSBhIG5vbnplcm8gc3Rfc2l6ZSB0byBhIHplcm8N
CnNkX3NpemUuIFRoZSBvcmlnaW5hbCBjb2RlIGlzIGhlcmUgaW4gZmlsbF9zdGF0X2RhdGE6DQoN
Ckkgd2FzIGF0dGVtcHRpbmcgdG8gdXNlIGV4YWN0bHkgdGhlIHNhbWUgaW1wbGljaXQgdHlwZSBj
b252ZXJzaW9uIGFuZA0KdHlwZXMgYXMgdGhlIG9yaWdpbmFsLg0KDQpXZSBjb3VsZCBwcm9iYWJs
eSB3cml0ZSB0aGUgYmVsb3cgdG8gZG8gdGhlIHNhbWUgdGhpbmcuDQoNCnZvaWQgZmlsbF9zdGF0
X2RhdGEoc3RydWN0IHN0YXRfZGF0YSAqc2QsIHN0cnVjdCBzdGF0ICpzdCkNCnsNCiAgICAgIHNk
LT5zZF9jdGltZS5zZWMgPSAodW5zaWduZWQgaW50KXN0LT5zdF9jdGltZTsNCiAgICAgIHNkLT5z
ZF9tdGltZS5zZWMgPSAodW5zaWduZWQgaW50KXN0LT5zdF9tdGltZTsNCiAgICAgIHNkLT5zZF9j
dGltZS5uc2VjID0gU1RfQ1RJTUVfTlNFQygqc3QpOw0KICAgICAgc2QtPnNkX210aW1lLm5zZWMg
PSBTVF9NVElNRV9OU0VDKCpzdCk7DQogICAgICBzZC0+c2RfZGV2ID0gc3QtPnN0X2RldjsNCiAg
ICAgIHNkLT5zZF9pbm8gPSBzdC0+c3RfaW5vOw0KICAgICAgc2QtPnNkX3VpZCA9IHN0LT5zdF91
aWQ7DQogICAgICBzZC0+c2RfZ2lkID0gc3QtPnN0X2dpZDsNCiAgICAgIHNkLT5zZF9zaXplID0g
c3QtPnN0X3NpemU7DQorICAgICAgaWYgKHNkLT5zZF9zaXplID09IDAgJiYgc3QtPnN0X3NpemUh
PSAwKSB7DQorICAgICAgICAgICAgc2QtPnNkX3NpemUgPSAxOw0KKyAgICAgIH0NCn0NCg0KLSBK
YXNvbiBELiBIYXR0b24NCg0K

