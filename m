Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2346C433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 18:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386778AbiEGSO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 14:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241853AbiEGSO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 14:14:28 -0400
Received: from us-smtp-delivery-104.mimecast.com (us-smtp-delivery-104.mimecast.com [170.10.129.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C23A31834C
        for <git@vger.kernel.org>; Sat,  7 May 2022 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globalfinishing.com;
        s=mimecast20180829; t=1651947036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1GB/gfCFUOR9kOtltpexuN0vECroUUvWhHpejAs4zk=;
        b=UiP7kab1Gu/Cv1PL8jeoo5KsjoZ9qtsRoe0jT7LZuUYe9vvV413WV1YpLOOLTgg+unus0u
        EaTlKrp0zArSiNGqqrGy0cNY9QCgMTxHlyKte2NuhU+hleio0fM85Gu/yfHdPNvBrr+wbX
        cgpUfFcnvOVQjQJp5tyqgyBp0JuxHW4=
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-x2X0qig0Nmi1Qaotyke-8g-1; Sat, 07 May 2022 14:10:35 -0400
X-MC-Unique: x2X0qig0Nmi1Qaotyke-8g-1
Received: from CY4PR16MB1655.namprd16.prod.outlook.com (2603:10b6:910:6d::10)
 by DM5PR16MB1643.namprd16.prod.outlook.com (2603:10b6:4:1c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Sat, 7 May 2022 18:10:32 +0000
Received: from CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea]) by CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea%4]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 18:10:32 +0000
From:   Jason Hatton <jhatton@globalfinishing.com>
To:     Philip Oakley <philipoakley@iee.email>
CC:     =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH] Prevent git from rehashing 4GBi files
Thread-Topic: [PATCH] Prevent git from rehashing 4GBi files
Thread-Index: AdhiMaxrpaoVMSP8QXODQxtttzkm8gACmSjw
Date:   Sat, 7 May 2022 18:10:32 +0000
Message-ID: <CY4PR16MB1655F08CD03748C491FE4BB9AFC49@CY4PR16MB1655.namprd16.prod.outlook.com>
References: <CY4PR16MB165501ED1B535592033C76F2AFC49@CY4PR16MB1655.namprd16.prod.outlook.com>
In-Reply-To: <CY4PR16MB165501ED1B535592033C76F2AFC49@CY4PR16MB1655.namprd16.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 161ccdea-d097-40b0-69b9-08da3054e053
x-ms-traffictypediagnostic: DM5PR16MB1643:EE_
x-microsoft-antispam-prvs: <DM5PR16MB1643DEADF86D468C73053AC1AFC49@DM5PR16MB1643.namprd16.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: pDVN6fviJ2p9nlXFV66BGyc/RycmkKwgA1i+/6Ot1IkYgp4lwjGtpYGfXorseBFZnNv6w/03PczeI5cO3Ldkdn2SSlqEzeOdz00tKBBnVcuTXLxDbemFne8KHVQs+y+68FFKgDBye8YbxW1Lz9Luw/fbXxwDC1ccztgHacVDXn6czcvJRuqhTd1cPwDKYs6ENBLei96RPM3KXIkSwYmeTGmnKsF31w3ka4WGFaZAgfDkB3afKECpjjygehF9/NRwyBEPAmcmNIpdJxBVH6RjYBd6amBMxEj/xSnkup6YzgcIurYmv1pfLnJ8yT4WWmoPV/uf2diwdRbY7pLXOOh+MKp2/kfP4QTBq/dQzRexddoIKJJeKbdkJOKx2i/e1q6n09yMn261x4OD/0bpx+EAQ8zWjlf6ANia3cDBnHQ9nzeRGSu/5GGHhjTk1c0yio5LDvvIxOOJ7hEaicCdxd13mfNa02RMbsazviv6NH32F3utu2vrCNHaor8SOSPyOWolcbQSlrYIZmFWDVQ0WWaBs83KQkm8LRNRZ6HJvk7Fq1KhlXgYP3153vm+Nf/el5uxc8Yb04x+eFeLnrW3c59WNseMltXh5L1D0QVJO1zc9lrVwtEQxqsiR81MLoX5QzoGrNm3Un+18x1h/0kRRnlqYNzho/ylvYx0LHW96nRvNlNLCnWfadaGqOFQvRyFJcqYE0Dbzgpaf6Kv5c2AGuIqmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR16MB1655.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(6916009)(2906002)(186003)(66446008)(66476007)(4326008)(316002)(66556008)(64756008)(8676002)(122000001)(54906003)(76116006)(66946007)(38070700005)(5660300002)(508600001)(38100700002)(52536014)(8936002)(71200400001)(33656002)(2940100002)(9686003)(4744005)(86362001)(6506007)(7696005);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1lGMmFrdVN0akpjZ1BnSUtBZGtoQlpmbHpoUlNjTElmaEhRYW1OM0JyZFFo?=
 =?utf-8?B?aWExcFZBME82MmxwSzJJRnhWcmxGclRCZmlscEVKV1EzWEE2T3k3OGsyQ1E0?=
 =?utf-8?B?ZlU5ZHJwbzlZeHF5enptMkRsa20wakY5TzJGZzJsY1E3aFlkMWwvbHJWYldx?=
 =?utf-8?B?MHN5M0hqZUh3M2J5YWdPNk5wbGxTN2x2eDQ5WkJ6dVhiMGpMY25jRUlSTVpN?=
 =?utf-8?B?NFp2N0h4bjgySUN6Zllxb2ZpcGxwMUord1pTVGcxdW9GNHFDYU5GVjloVFdx?=
 =?utf-8?B?Sk5NYk9TdmJhelEyd01pK00vR2h1YjluSE4zOGJSVmx2L1I1bkE2dWV3a1Fv?=
 =?utf-8?B?WkpJbEdLYzR3MWYycCtxL3FYd2c0aFdzK2lpU0wxRDgyOXh0OU9McC9xdXox?=
 =?utf-8?B?Q2U1NE0veXV1cTZMNW5HYldPK2hrMmRkQ0Q2cnIvSHR6ZWsvempjWndPOHRl?=
 =?utf-8?B?bmt3T0NKQnVJV0ozY3NpZGFHNlRsYzE1cjc5LzhHZGR0bXJsVjVwUjk4LzYy?=
 =?utf-8?B?azVkdDhZWFJKSUwzUzFIMWRUc2srYm90NjlsV05ZcVpWMk5GVlAyV3BvRHZv?=
 =?utf-8?B?WXdocCtwb05JeTVua3d6cUpKdk5OT1BER09yWXpKdHVYMktUU2ZTR2JlUHp3?=
 =?utf-8?B?aXl6NmM5TFFnS2l2SFlRVDE2ZW9xWVZZaDBHdHd0OWRzeGVSMVR4Z1FWM1pq?=
 =?utf-8?B?Y0pRd2pwSmxBSGU2UU5SNlEzUGZHZ25OcnFDY1pNV1lPaUswbmFQNGoxYThM?=
 =?utf-8?B?aS9sSlNzN2VtV2hTUncxdTBCYUNaWm9LaitXc00zVlkzZERjN3FpaG1HbGc4?=
 =?utf-8?B?dDZ1dWd3N3JBNjZBRzVwMzUyOUxLNjY4Zm1YU3B6Sk1CN0l4NU9FTEdVeHRP?=
 =?utf-8?B?YmFoVE8rQXRoZkg3bmJkNkpJSWFxZVhwUTBFNSszRjFhbFdOSHhHR3AyZEtR?=
 =?utf-8?B?TkJDVDJRUE55Ti90WWxldHc1Rmhyd2VOL1d3dzFaUENTckVwZFJ3K3BtcW9R?=
 =?utf-8?B?ajI5OGJLQkt5UUNKR3RMb2NiaU5aOTNYWkt6M2NSVUVya2pvaDZFTHRJQW1m?=
 =?utf-8?B?VFFORzE5d0w5SDVDaFVvRnNkc3BQNE5rbkJJMTA0UnFpcm9hRVBQWkZZbUhK?=
 =?utf-8?B?TXBuZUk4M24xdFJnS2tLQ1AzSFVjWkY2dFJSeThYLzFvZnM0bE5LV0p0Mzc4?=
 =?utf-8?B?SEhPZFJlZDNGNEg0NmUzdkYwdFZtbGMxR2FSUVdEMGpzWGRZaU9weGk5T3JB?=
 =?utf-8?B?UlRWT1hJUUhaRHJtb0UwaGJSdDRwbTVVTlExQlhhbXBYM0Y2UmJ1dTFISjU5?=
 =?utf-8?B?T1lNT1BEVUxlSGtxK0M4UzNjVUh4ckZmZFN0bW1CVGRGSStBc1lRQkY4bTRG?=
 =?utf-8?B?NkJqMlZCSzZhQXdaSDNCajZ1R1pYR1oxak84R0RvdEFPTVBQbExXeXpCZFhp?=
 =?utf-8?B?OEtrSlQ1cDNDcGpMLzNzV25JWmdVR0xmNXo5SHBBTHdjdGNXVVNsQzFreVNa?=
 =?utf-8?B?TGZzOTV3ZTZLNzIyUUYxby9GS0wzVDJMenlQMGo1NWFXMUpMdHlUbU55U0hB?=
 =?utf-8?B?RGhFV3hWZHBFcDJzaFdiaGhMRmdlbFFvMFpBb05VNUt2WWEwQ3BIbWgwN3dE?=
 =?utf-8?B?cHVUcVBTaDBDV3VYVjhaSDVidzZuamRIVE54TE1HRFFmTVh2d1FjbStCUzE3?=
 =?utf-8?B?dXZEVCtOTXRMQ2xkbUx3VGxOZ05heU8rMkZ3c0MzTDJtZmIwY2dkNGxuMUts?=
 =?utf-8?B?TXRvd2d0UjZPOTdmR21VajNsQTZwRlpCU0twUnZpR0c5R1AyYW1FRmxWNW01?=
 =?utf-8?B?MDRuMjJtTWVmSmNzN3hPU3Fjdm9wRVVUMjVJUXNtT0YxUjJvVHFLY1F4Mm1t?=
 =?utf-8?B?UG5PMGFBNW5KVkJIeGNHS0ptY0NTQkprSlRnSU5CUnJnQ0JYMW95eVdXK2Z4?=
 =?utf-8?B?TDM4S3NwbVdWVEFnYW1pOXVrb0lxdXlvNFZ3Sk5SbmJBUkNvUGhvRHozcHQ5?=
 =?utf-8?B?UmRHQm9sbmJnUUdRL2paNGEvaHh2QUxlaFRXaWx3bSthS1VPU3l1eE05TlM5?=
 =?utf-8?B?RWQ1WXBWOUhSSy9sYjVVMk5YQzlycnFlbVUyTkFqeHVweGhQa2lBZTVFMk1J?=
 =?utf-8?B?b3hXM2xDa2NQcHcxN2ZGSXJuSDNrYVp2a0c1bmxNdlR1OGtkRTBXeWxDdHZS?=
 =?utf-8?B?NHh6UEE1SXBYU1B3eWZma0xxUEZtQnI2QWlnTmJiNFN4Z04xNjZ3bTFmaXZN?=
 =?utf-8?B?MldpZFVDWE5GUWRHczE4UGJKendTMTcvaFNUMWt4bzRlWlFwOERiVXljRmRV?=
 =?utf-8?B?MzlQTUZQbWViMkhYM1p6NmVtZHlZTmt5RjZXNDhaRFRWZzNISVJZL2dxUVZT?=
 =?utf-8?Q?ZeQMvPEUJtXA4yN0FUTGaWIWbq+HGxcnqKImdVpxDacaY?=
x-ms-exchange-antispam-messagedata-1: IpIHSDPwIjW4dWGlO4Gnt+CbDl//6TevEM8=
MIME-Version: 1.0
X-OriginatorOrg: globalfinishing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR16MB1655.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161ccdea-d097-40b0-69b9-08da3054e053
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 18:10:32.5139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41026ff0-b4fb-4e53-ada8-a2e2e3e9ec4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqadV6SyXRl2BZiNlGsoXOPMFolE7GyLuOA1uPhxqkRJ0E4aKFHwtBt5QmhSzy0yqWJcydeGPSCMG5OmNaavni3bzdrpzSsjjjlA3bs3RoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR16MB1643
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA104A295 smtp.mailfrom=jhatton@globalfinishing.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: globalfinishing.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBQaGlsaXAgd3JvdGU6DQo+DQo+IElzIHRoaXMgb24gR2l0IGZvciBXaW5kb3dzIG9yIGEgNjQg
Yml0IExpbnV4Pw0KPiBUaGVyZSBhcmUgc3RpbGwgc29tZSBpc3N1ZXMgb24gR2ZXIGZvciAyR2lC
KyBmaWxlcyAobG9uZyBWcyBsb25nIGxvbmcgaW50KS4NCg0KSXQgd2FzIG9uIEdmVyA2NCBiaXQu
IFRoZSBMaW51eCA2NCBiaXQgb25lIHNlZW1zIE9LLg0KDQpGdXJ0aGVyIHRlc3Rpbmcgc2hvd3Mg
dGhhdCB1bnBhdGNoZWQgR2ZXIDY0IGJpdCBjaG9rZXMgb24gNEdpQiBmaWxlcy4gSnVzdA0KdXNl
IGdpdCBhZGQgYW5kIGdpdCBmc2NrLiBBdCBsZWFzdCB0aGlzIHBhdGNoIHNlZW1zIHRvIHdvcmsg
b24gTGludXgNCmFuZCB3b3JrcyBvbiBHZlcgd2hlbiB1c2luZyBMRlMuDQoNCi0tDQpKYXNvbg0K

