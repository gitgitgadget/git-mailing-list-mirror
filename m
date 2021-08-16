Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE3EC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7253660EFE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhHPQ2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:28:12 -0400
Received: from mx0a-00209e01.pphosted.com ([148.163.148.55]:21240 "EHLO
        mx0a-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229733AbhHPQ2K (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Aug 2021 12:28:10 -0400
X-Greylist: delayed 3784 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Aug 2021 12:28:10 EDT
Received: from pps.filterd (m0115755.ppops.net [127.0.0.1])
        by mx0a-00209e01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GFBgdo024406;
        Mon, 16 Aug 2021 11:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=gejvyaOaIvGPpvEnRVDe7amncJ5Jgs9w/E+Du5MQUzM=;
 b=n2h3M4rEMV80ucL3jn1j+AD3/gRIZsfTsi6K3cZ0oa1H6LiqMdl+lgN5gDA5sitKX1vL
 mHLKstCyB5yAMz2RfVldy41I+tOEmBB3FFI76P2wOGIvKKmbPBM4gayG2uxREQl4OYSi
 6iXoFomo0QiZdpe0j3yIGuVjfYCnCgyjnemRzOXN4Edl91047IEUyG5jZGV6lgAzvCEs
 Kue3Ctcar3EMUrYgdNCUNpQUNFGj6VEeTjfMHpiXQwCmtN+PppKr+WNyEJiocGqQbJv6
 tQr8TLQzBIBwgxXCYPbqus6FiTxLUXCTIVPHGO1e9UGqv9ar43otONA95pH8LI+CyITq GA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00209e01.pphosted.com with ESMTP id 3ae7ftht3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 11:24:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyFDyMiz9zdZdN07D6jP+nLKGR/XTzot5QFNS3FhyCAjxBZFU0fCA6DWA8LsGIk6D14NkD2UgN7hRjMAJA47vDyvKhcVRmmPE0XunWIs/rr4ykoLiBVRU1xeltjc9QExVEG6cIKj9LnJCOQtzi7qZRUaoCSMmec9Zxq7H+el3WGgv0fCoruUqf0ahLfsspV46BQTaiRlnw/SjhGIJ091JfDExT1bMirzSIEucoWC5XocELT6Cw/06bOsZMoqSvGZrwtHyEPtznDSzJ5ymZ+2CaHmA7mUmVsYf2VHa+274v1DCS/szMu8g3yRzQpDfVHahPvIXmRTk0uMJ2hFkBfbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gejvyaOaIvGPpvEnRVDe7amncJ5Jgs9w/E+Du5MQUzM=;
 b=GWxSDYQYMocIwwKJjEVb1laXgr1OfTjGXKsR3B3HkioyErXNHYbdvURjxHn+X3k+q+S28kszvWh4F/itY9Sx7kZC1nOXZFLy7sAA/NKoiE2BxDuZYLIIaHmzZf/H6gcC9KabKmrg+8cGe1Im/dGnIxa5JiKvHcIu5Bo8KUnTo1e3DREDgjMB6ouUXwlHTldCdFjOOpy18YMEMKlqbu+dGOiz/C1Nx8IM864vVrAGIgkhmRoQvdCchzkDqwJmSSmWQln47aNFsov5mdJSxNUjwg4XPPyOsBgfGfk5EPDPs/X2+xp8QomGc5kEYR2lqkZu/wQsrgxgdfGrC1K1XJlhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN8PR15MB3121.namprd15.prod.outlook.com (2603:10b6:408:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 16 Aug
 2021 15:24:28 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 15:24:28 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git clone corrupts file.
Thread-Topic: git clone corrupts file.
Thread-Index: AdeQbBTmFYBcWaT2QVKI1LhsxFP/CQAAfQYQAAGNnwAAB6C0gACE7ckw
Date:   Mon, 16 Aug 2021 15:24:28 +0000
Message-ID: <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
In-Reply-To: <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-08-16T14:01:36Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Privileged;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=bd8a07cf-5a80-4204-85a9-0bfb77127ee3;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
dlp-product: dlpe-windows
dlp-version: 11.3.0.17
dlp-reaction: no-action
authentication-results: crustytoothpaste.net; dkim=none (message not signed)
 header.d=none;crustytoothpaste.net; dmarc=none action=none
 header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99df6386-413f-409a-8660-08d960c9f03f
x-ms-traffictypediagnostic: BN8PR15MB3121:
x-microsoft-antispam-prvs: <BN8PR15MB31217286F9C45C044522D164CBFD9@BN8PR15MB3121.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TromHHR7yjd/fbFVACyQKNws87cFVV2B8ZE4wwXsl5pGxBj2BU9mr151YT5lFP+UNeLldI7XIyCmcmUd3JU4HR7FPR8kRA6/SnXkKyVitwGs4MADSGvdlaUuiAXP5lCdUjmUXzSB0ueXAPPjRZGxd8iAGtcxbTc7AFJC1HjZwPSL9Dz8yQLpSQQ6+08VWhMfJJ2HmzW+0rqlurzzdXZmRP6QiFXlU7HJ2dghE4GTeZSQiuoyXuXR36q6iKEQmooPlvkhGw0PQXBisb9iJEa0fvnR7obJ2BIZ3jXMNldmLI6vZMyYTm+E4elIijG1TAbkmAFtxGInB1wnzCxRH8r7u+D7+quoDKGgss/dsWkyxUMdDIMnVU/K4nAfrFoMCQ2KxDLjfwp76xPGdHnjgTPhjGZO77lhP5LBPwp8M8PiKP3UZ5sERwZZcB9/Cm8UyyWfhd7YrfDGVpxWs3wEtZLzhKyh6bsVpDmSEIJWwd++Z3YJ7uYN+Fr74Pw31ZMpSelrTK5H20cc/nlalOb9hdNCqpZjfSvvAhKlzurwTeXHRYFqbVU95VaqecdxvPjZb42px2uWxZqa9fB1oz12i6/AsiAzyuZ1UReE0t1mLRJdnxdKyTYwWl5q7P6MuFIYb24phA+jDDspSIYlAzjIMLRkqkJtzKUVjpMq7tHOmBDh43BKKXQpLQEYu3aYTLdto/N6LRU9u0N7ME1DJeDZSR2m6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(478600001)(2906002)(64756008)(7696005)(66446008)(4326008)(66476007)(66556008)(5660300002)(66946007)(66574015)(9686003)(33656002)(8676002)(76116006)(3480700007)(38070700005)(83380400001)(71200400001)(26005)(53546011)(6506007)(316002)(55016002)(8936002)(6916009)(38100700002)(86362001)(186003)(45080400002)(122000001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkxPN05Ka0ZIajRwTTJUM2xjd0wrWGZ6bVZaY3AxZTExM3FRc2tFdGw2MXZt?=
 =?utf-8?B?cURnVkczaEF6eWs1SklWOGw3dTBkQ3dKTmJsaGc4UUh0SGM3ckU0bS9ySWlN?=
 =?utf-8?B?NUF5ZnFEZ3krQWR0U0lNSStBdC85b1gxa3lZV2lMVlM2UElMb1FiT2NBbVlS?=
 =?utf-8?B?RWJuSUQ2dUt5OU0wUEh3SytqbWIvNjNLUS9JSjJBa09XZWVzZVlMNlVnNlBo?=
 =?utf-8?B?bXhMekJ3V3B4bVg5WXFXRm1tWEhWS2tFdUpiSTQrMnNXUE5ITnBKRVNCVkdz?=
 =?utf-8?B?NEtwNE5HVm9CSmwvK3ozTjIwTytQcVkzVEVJR1lEL1VmcDVMeHpna0RDc2tS?=
 =?utf-8?B?VnllQTNJd0dJWGNwR09TMEZwMWxCVk1wR0FtdUdUblp0aFpEWTlEa3VTNmw1?=
 =?utf-8?B?SGt0VGZYV0xkcmpLVklRVGhINXhwcUswYzRGQ3hNTFFIT3JHNVNPRkdHVEtX?=
 =?utf-8?B?QzB2VlpFclNtWWZZZ1lJc2NiZFVxVnlDL1pMdWVKbm13cVRiVENET2RtT2gw?=
 =?utf-8?B?Z2hsN3pwTUVzbzY2a3hrRkN6ejBUNk1WWDE3WmJxdllvZDdDcERtRUZLZWdC?=
 =?utf-8?B?eVJic0ZYU05Dbzd0ZWd3K2tBSnJ2YjM2aWwzTXFJT2tQZWZLeXFNY3czeEJO?=
 =?utf-8?B?QzE2blRTbVhZQ0xlR2g5cG5zSXEzYWMwMkRSaVNUcy9oVmpTWmhCSnFYZjEz?=
 =?utf-8?B?eDBmWWtHdEVGaFBjV1JHMVFSQlZlaUpMYnhvNHF3NUJOOGFiblRsM1NaRE0w?=
 =?utf-8?B?TFNFcXlWZ3FkQXN6TUFQNFgzVVVCSm5xYS85K29RTXNzMnlZTkRORC96MTZV?=
 =?utf-8?B?RDhzNldrd3FyQWhTTWx1K0h2VjFHR3lGektRcjBNeEIwMWNiQS9ZTTRITzUy?=
 =?utf-8?B?UHZVKzQ0U2grV2dFZDNKN29ZZFYxS1BxZGZIOFhQRnFJeW1QajdVV24vd28y?=
 =?utf-8?B?RmtEbE5WYXo1R2M2QkpDeDVpVVRVbzVaSUY1TEhkL2ZueXZjMEtLd2k5R0VU?=
 =?utf-8?B?K0tMYWJwOTV0YUdoZVF0R2diQlNRWFE2MnVzd2FIdHJYcFg5OWNaN2VyTVV2?=
 =?utf-8?B?RlRJaFlPVWpvWldiMFdWKytYcmlTTmNjdjNPMXBVSFZHc2xKNFREd3V5SjAw?=
 =?utf-8?B?ZFFkNkV0WFpIMnR5bFBQbjRVbnNYNDg0cjJGcUZNeldTS0dOc1hZVFdOVytD?=
 =?utf-8?B?N05qU0dNWjBsOGZwSjRLNTNJZDIvdmRZUnI5a05ZQzlPVXpEMVl6UXFJeDFh?=
 =?utf-8?B?SC9FVkROTGJYemhEbkJxTmJhQ293RVFCSkl4UGZYelVUL3A0VGFFMWtCL0No?=
 =?utf-8?B?UnVBcnRYakh3RVBBTEFQaFdRYk9FMnQ3TktGVzlkQjZLSWRNVkNmSUJKSExI?=
 =?utf-8?B?NndNeWE0WGFOdTFwWExwcXBDRktwVjgvRXhadDhiQjdaSVR5anNId0k4ZCt5?=
 =?utf-8?B?ZDJpbXp3MC9jQjBJMWVBYmtpRXp4VkRRUnUraVovdmxXTitaNGZXQkR4WVRw?=
 =?utf-8?B?UDhGcHdKT1NWUTExWE5EMUorN2IxUmIxQ0dRZ0twTlJzTmVmK2xUODJFZnRv?=
 =?utf-8?B?ZnJMNlVlemRiUy81WWRNeURJMUs0SGtEcldqMmt0RjdUaklBWWh5elpIRjNZ?=
 =?utf-8?B?YU95MnBvT2R5cmRlMlZpaTU0ZXF0bEk0d3R6M0Iyb0ZORnMrYnhZV2N0RGQ5?=
 =?utf-8?B?L3E4SzRHd015MUwwSEsvVC9yTTlvcVdRZ0hnY3hYbWNCYjdNbkxtSmREZG8v?=
 =?utf-8?Q?rMhxgRP1weDMyweOrrYxgH+Z/CsPfR7QvtLg8oo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99df6386-413f-409a-8660-08d960c9f03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 15:24:28.3964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNX/05XtFElGGrSX1cK4us1XetQGI0FPXwj3KXyzE/EtyMI7y2PWnZKnrYHgPsuuTpO+OQI48PRkKI3Z5mwEuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3121
X-Proofpoint-GUID: KVS7N3hnFKtov4K59c10wwFzY1LsuBKy
X-Proofpoint-ORIG-GUID: KVS7N3hnFKtov4K59c10wwFzY1LsuBKy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_05:2021-08-16,2021-08-16 signatures=0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QnJpYW4sICANCg0KVGhhbmtzIGZvciB5b3VyIGludGVyZXN0IGluIHRoaXMgaXNzdWUuICAgVGhl
IGlzc3VlIGhhcyBiZWVuIGRldGVybWluZWQgdG8gaGF2ZSAyIGZhY3RvcnMuIA0KDQoxLiAgVGhl
IGZpbGVzIGNvcnJ1cHRlZCBhcmUgaW4gVW5pY29kZS4gICBUaG91Z2ggdGhlIC5oIGZpbGUgbWVu
dGlvbmVkIGNlcnRhaW5seSBkb2Vzbid0IGhhdmUgdG8gYmUgVW5pY29kZSwgaXQgY2FuIGJlIEFO
U0ksIHdlIGhhdmUgb3RoZXIgZmlsZXMgdGhhdCBtdXN0IGJlIFVuaWNvZGUuICBXZSB1c2UgVW5p
Y29kZSBpbiBxdWl0ZSBhIG51bWJlciBvZiBvdXIgdGV4dCBmaWxlcy4NCjIuICBHaXQgYXBwZWFy
cyB0byBjb3JydXB0IHRoZSBmaWxlIGJ5IG1ha2luZyBsaW5lIGVuZGluZ3MgY2hhbmdlcy4gIA0K
ICAgICAgICAgIGEuICAgR2l0aHViIGhhcyB0aGUgY29ycmVjdCBmaWxlLiAgSXQgdmlld3MgY29y
cmVjdCB0aGVyZS4gIFdoZW4gZG93bmxvYWRlZCBhcyBhIGJpbmFyeSBvciB0ZXh0IGZyb20gR2l0
aHViIGluIGEgYnJvd3NlciwgaXQgaXMgbm90IGNvcnJ1cHRlZC4gDQogICAgICAgICAgYi4gICBH
aXQgc2VlbXMgdG8gY2hhbmdlIGxpbmUgZW5kaW5ncyBhcyBpZiB0aGUgZmlsZSB3ZXJlIEFOU0kg
b3Igc2luZ2xlIGJ5dGUgZW5jb2RpbmcsIG5vdCBVbmljb2RlLiANCiAgICAgICAgICBjLiAgIEdp
dCBoYXMgdGhlIHNldHRpbmcgZ2l0IGNvbmZpZyBjb3JlLmF1dG9jcmxmIGZhbHNlLiAgIEJ1dCBh
cHBhcmVudGx5LCBpdCBpcyBub3QgYmVpbmcgb2JzZXJ2ZWQuICAgDQogICAgICAgICAgZC4gICBU
aGUgLmdpdGNvbmZpZyBmaWxlIGhhcyB0aGUgW2NvcmVdIHNlY3Rpb24gd2l0aCB0aGUgZW50cnkg
YXV0b2NybGYgPSBmYWxzZSBmb2xsb3dpbmcgdGhlIHNlY3Rpb24uICANCiAgICAgICAgICBlLiAg
IFRoZXJlIGlzIGEgLmdpdGF0dHJpYnV0ZXMgZmlsZSBpbiB0aGUgcmVwby4gICANCiAgICAgICAg
ICBmLiAgICBFbnRyaWVzIGluIC5naXRhdHRyaWJ1dGVzIHNwZWNpZmllZCBieSB0eXBlIGFyZSBz
cGVjaWZpZWQgZm9yIHRoZSBhZmZlY3RlZCBmaWxlcy4gDQogICAgICAgICAgICAgICAgICAgICAg
ICAqLmggICAgIHRleHQgZW9sPWNybGYNCiAgICAgICAgICAgICAgICAgICAgICAgICouaW5pICAg
dGV4dCBlb2w9Y3JsZg0KDQpJZiB5b3UgbG9vayBhdCB0aGUgMXN0IGxpbmUgb2YgdGhlIGJpbmFy
eSB2aWV3IG9mIHRoZSBvcmlnaW5hbCBmaWxlLCBpdCBsb29rcyBsaWtlIHRoaXM6DQoNCkZGIEZF
IDJGIDAwIDJGIDAwIDdCIDAwICAgN0IgMDAgNEUgMDAgNEYgMDAgNUYgMDANCjQ0IDAwIDQ1IDAw
IDUwIDAwIDQ1IDAwICA0RSAwMCA0NCAwMCA0NSAwMCA0RSAwMCANCjQzIDAwIDQ5IDAwIDQ1IDAw
IDUzIDAwICA3RCAwMCA3RCAwMCAwRCAwMCAwQSAwMCAgIAlOb3RlIC0gVW5pY29kZSBDUiBMRiAg
MEQgMDAgMEEgMDAgICANCg0KMm5kIGxpbmUgDQoyRiAwMCAyRiAwMCAyMCAwMCA0RCAwMCAgNjkg
MDAgNjMgMDAgNzIgMDAgNkYgMDAgIGV0Yy4gICANCg0KSWYgeW91IGxvb2sgYXQgdGhlIGdpdCBm
aWxlLCBpdCBsb29rcyB2ZXJ5IHNpbWlsYXIuICAgDQpIb3dldmVyLCBnaXQgaGFzIHB1dCBhIG5v
biBVbmljb2RlIENGIExGIGludG8gdGhlIGVuZCBvZiBsaW5lLiANClBsdXMgYW4gZXh0cmEgTlVM
TC4gICBUaGlzIGV4dHJhIE5VTEwgdGhyb3dzIHRoZSAyIGJ5dGUgVW5pY29kZSBlbmNvZGluZyBv
ZmYuICAgSXQgY29ycnVwdHMgdGhlIGxpbmUuICBPbiB0aGUgbmV4dCBsaW5lLCB0aGUgZXh0cmEg
TlVMTCBsaW5lcyB1cCB0aGUgMiBieXRlIGVuY29kaW5nLCBzbyB0aGF0IGxpbmUgYXBwZWFycyB1
bmNvcnJ1cHRlZC4gIA0KWW91IGNhbiBzZWUgdGhhdCBpbiBteSBvcmlnaW5hbCBlbWFpbCBiZWxv
dy4gICBFdmVyeSBvdGhlciBsaW5lIGlzIG5vdCByZWFkYWJsZS4gIA0KDQpGRiBGRSAyRiAwMCAy
RiAwMCA3QiAwMCAgIDdCIDAwIDRFIDAwIDRGIDAwIDVGIDAwDQo0NCAwMCA0NSAwMCA1MCAwMCA0
NSAwMCAgNEUgMDAgNDQgMDAgNDUgMDAgNEUgMDAgDQo0MyAwMCA0OSAwMCA0NSAwMCA1MyAwMCAg
N0QgMDAgN0QgMDAgMEQgMDAgMEQgMEEwICAgCU5vdGUgLSBVbmljb2RlIENSIExGICAwRCAwMCAw
QSAwMCAgIA0KDQoybmQgbGluZSANCjAwIDJGIDAwIDJGIDAwIDIwIDAwIDREIDAwICA2OSAwMCA2
MyAwMCA3MiAwMCA2RiAgZXRjLiAgIA0KDQpJIHdvdWxkIGxpa2UgZ2l0IHRvIG9ic2VydmUgdGhl
IGF1dG9jcmxmIGZhbHNlIGFzIGRpcmVjdGVkLiAgIA0KDQpJdCdzIGltcG9ydGFudCB0aGF0IHdl
IHJldGFpbiAyIGJ5dGUgVW5pY29kZSBmaWxlIGVuY29kaW5nIGluIG1hbnkgb2Ygb3VyIGZpbGVz
LiAgIEFuZCB0aGF0IGdpdCBub3QgYWRkIHNpbmdsZSBieXRlIENSIExGIGludG8gb3VyIDIgYnl0
ZSBmaWxlcy4gIA0KV2UgY2FuJ3QgY29udmVydCB0aGUgZmlsZXMgdG8gb3RoZXIgZW5jb2Rpbmcg
Zm9yIGNvbnZlbmllbmNlIG9mIGdpdC4gIA0KDQpUaGFua3MsIA0KDQpTY290dCBSdXNzZWxsDQpT
dGFmZiBTVyBFbmdpbmVlcsKgDQpOQ1IgQ29ycG9yYXRpb27CoA0KUGhvbmU6ICsxNzcwNjIzNzUx
Mg0KU2NvdHQuUnVzc2VsbDJAbmNyLmNvbSAgfCAgbmNyLmNvbQ0KICAgICAgIA0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYnJpYW4gbS4gY2FybHNvbiA8c2FuZGFsc0BjcnVz
dHl0b290aHBhc3RlLm5ldD4gDQpTZW50OiBGcmlkYXksIEF1Z3VzdCAxMywgMjAyMSA2OjMwIFBN
DQpUbzogUnVzc2VsbCwgU2NvdHQgPFNjb3R0LlJ1c3NlbGwyQG5jci5jb20+DQpDYzogZ2l0QHZn
ZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IGdpdCBjbG9uZSBjb3JydXB0cyBmaWxlLg0KDQoq
RXh0ZXJuYWwgTWVzc2FnZSogLSBVc2UgY2F1dGlvbiBiZWZvcmUgb3BlbmluZyBsaW5rcyBvciBh
dHRhY2htZW50cw0KDQpPbiAyMDIxLTA4LTEzIGF0IDE4OjU0OjQzLCBSdXNzZWxsLCBTY290dCB3
cm90ZToNCj4gRmlsZSBmcm9tIGdpdC4NCj4gDQo+IOCojeK8gOK8gOKAgOS0gOakgOaMgOeIgOa8
gOeMgOa8gOaYgOeQgOKAgOWYgOakgOeMgOeUgOaEgOawgOKAgOSMgOKsgOKsgOKAgOacgOaUgOa4
gOaUgOeIgOaEgOeQgOaUgOaQgOKAgOakgOa4gOaMgOawgOeUgOaQgOaUgOKAgOaYgOakgOawgOaU
gOK4gOC0gOC0gA0KPiAvLyBVc2VkIGJ5IENhbVRlc3QucmMNCj4g4KiN4ryA4ryA4LSA4LSADQo+
ICNkZWZpbmUgSURNX0FCT1VUQk9YwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgMHgwMDEwDQo+IOCojeKMgOaQgOaUgOaYgOakgOa4gOaUgOKAgOSkgOSQgOSQgOW8gOSEgOSI
gOS8gOWUgOWQgOSIgOS8gOWggOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKA
gOKAgOKAgOKAgOKAgOKAgOKAgOKAgOOEgOOAgOOAgOC0gOC0gA0KPiANCj4gRmlsZSBpbiBnaXRo
dWIuDQo+IA0KPiAvL3t7Tk9fREVQRU5ERU5DSUVTfX0NCj4gLy8gTWljcm9zb2Z0IFZpc3VhbCBD
KysgZ2VuZXJhdGVkIGluY2x1ZGUgZmlsZS4NCj4gLy8gVXNlZCBieSBDYW1UZXN0LnJjDQo+IC8v
DQoNCldlJ3JlIHByb2JhYmx5IGdvaW5nIHRvIG5lZWQgYSBsaXR0bGUgbW9yZSBpbmZvcm1hdGlv
biBhYm91dCB0aGlzLiAgTXkgZ3Vlc3MgYXMgdG8gd2hhdCdzIGhhcHBlbmluZyBoZXJlIGlzIHRo
YXQgdGhlIGVkaXRvciB5b3UncmUgdXNpbmcgdG8gdmlldyB0aGUgZmlsZSBpcyBzZXQgdG8gcmVh
ZCBmaWxlcyBhcyBVVEYtMTYsIGJ1dCB0aGUgcmVwb3NpdG9yeSBoYXMgdGhlbSBzdG9yZWQgaW4g
VVRGLTgsIG9yIChsZXNzIGxpa2VseSkgdmljZSB2ZXJzYS4NCg0KQ2FuIHlvdSB0ZWxsIHVzIHdo
YXQgZWRpdG9yIG9yIG90aGVyIHRvb2wgeW91J3JlIHVzaW5nIHRvIHZpZXcgdGhlIGZpbGUgYW5k
IHdoYXQgc2V0dGluZ3MgaXQncyB1c2luZyBmb3IgdGV4dCBlbmNvZGluZz8gIENhbiB5b3UgdGVs
bCB1cyBhYm91dCBhbnkgd29ya2luZy10cmVlLWVuY29kaW5nIGRlY2xhcmF0aW9ucyBpbiB5b3Vy
IC5naXRhdHRyaWJ1dGVzPyAgWW91IGNhbiB1c2UgImdpdCBjaGVjay1hdHRyIC1hIFBBVEgiIHRv
IHNlZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHRoYXQuDQoNCldoYXQgY29kZSBwYWdlIGFyZSB5
b3UgdXNpbmcgb24geW91ciBzeXN0ZW0/ICBBcmUgeW91IHVzaW5nIFBvd2VyU2hlbGwsIENNRCwg
b3IgR2l0IEJhc2g/ICBJZiB5b3UncmUgdXNpbmcgR2l0IEJhc2gsIHdoYXQgYXJlIHlvdXIgbG9j
YWxlIHNldHRpbmdzPw0KLS0NCmJyaWFuIG0uIGNhcmxzb24gKGhlL2hpbSBvciB0aGV5L3RoZW0p
DQpUb3JvbnRvLCBPbnRhcmlvLCBDQQ0K
