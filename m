Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F4DC433EF
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 01:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378867AbiBEBT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 20:19:28 -0500
Received: from mx0f-00379502.gpphosted.com ([67.231.155.129]:53105 "EHLO
        mx0f-00379502.gpphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344364AbiBEBT1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 4 Feb 2022 20:19:27 -0500
Received: from pps.filterd (m0218362.ppops.net [127.0.0.1])
        by mx0f-00379502.gpphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2151IDbl001006
        for <git@vger.kernel.org>; Fri, 4 Feb 2022 17:19:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=02022021-podllnl;
 bh=P1v1nKAxWTC/kAsU2qUxAQuUnf1YZ8CqSpUs6KjYSe8=;
 b=De0N2dC2vogdA5+nz0nOU53xElUsd4jAR5TZdoUxDuS/ic3kzejfSWIGjd0nhZAeJAqm
 9dZIGNaQyJWrJOw2wL0nK370NGiQl7cYeLlB4Q3z/tlsHm/00UY6c2bTLZn+ftRj4M9Z
 0Nh3GSL0pJFESdMNCLrr7f6we1zu7hrgIfPFyG8qQsKNw4eFyGDCjUMCmZDeCoVy9923
 h5hc9ca/+3uxaUGWQ4DbrY/0Wg0cxba1XUfwN6o4XlFkMW8WccprqTAv1CGqVM62FQMQ
 ASQVQH6a7RQnABoIV5D/4rXUz2bR3DuP+xYoQ2ZA0YECvHMqiFQyRaJJlczN10oqmEtT Ng== 
Received: from gcc02-dm3-obe.outbound.protection.outlook.com (mail-dm3gcc02lp2104.outbound.protection.outlook.com [104.47.65.104])
        by mx0f-00379502.gpphosted.com with ESMTP id 3e187u1ch7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 17:19:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbVaMPl5IGfaHTnHAi9Fx6cZ1uP9S/yScqe7zwFwdP+Gx8WGqsKVEJ3newwTYLtt/quHe+hhNmsNQJX/8HZXEThiSR2T6MvVEUyo+Y1frmYza+mvqFAMCpba9DKxXd0f9d9lRK5IbjYto4EwXTjeE6erMFwF8kP4vYCnkW25PezzwSwFxO3W2O1n4a8JHQt3bg7108N2AJFiy46TxRnY1j1DR4QF7zta4YZ0tJ73KZZID06KzwyGkYXt2BEKlvWei0KAFh9isT3GCyubjnnx5VEPsVAtzlfrSpRyqkHeqjlDsoi7oEQ2iluqUVE7ZMDAnf5QSU0oHYtQaXr+5EKC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1v1nKAxWTC/kAsU2qUxAQuUnf1YZ8CqSpUs6KjYSe8=;
 b=OzZLlHaOCd2M1KNYc4u+a/lr1ipDc/8ZHRFEKEqCOmoAv+7mX+9aaljWIk0T+HXAse4kzSUk3GawXL1B/ZUUlc4bV0JvI/edrChvBULv5Vy+IXJdWZ5HkLhxzTEzS6+WrNypFacGO37O0eVpyVZCX8Xq2JtauaigsIq55DNg6knzvCKMf1EGah572TTuDxiUmtjjmFT8N+C4Uc5Nnspm24YAl6ZeBK3JZqi5yRwm0nL7rXj35TX8tmqpcrAFghPrvAJAk0uQjdTL57QmBH3cB8ERmeaZ3lw4P+BB9mCUxYtNg20zgcPnyJGM2qHml3iZnPYUvBFz8jAZObIOFAXyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1v1nKAxWTC/kAsU2qUxAQuUnf1YZ8CqSpUs6KjYSe8=;
 b=Wf8k0c8O/duLVrrfcROA8IFm4sCzRTnE0QIfZzD6ZXpU6qWPlguBYTgwMNIuEW2K9eV4JcwMovnVyaoZiYGP/QUqHB7QjM6KMWZ3VK/PVAtDpkVYwEbp5nM35rjBYMN+8FNAvZJ7uPYtLnxaw2TlAJEcDZbPtMJTOvdLC25y5Is=
Received: from BY5PR09MB5972.namprd09.prod.outlook.com (2603:10b6:a03:242::12)
 by BY5PR09MB5988.namprd09.prod.outlook.com (2603:10b6:a03:242::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 01:19:24 +0000
Received: from BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231]) by BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231%2]) with mapi id 15.20.4951.017; Sat, 5 Feb 2022
 01:19:24 +0000
From:   "Gamblin, Todd" <gamblin2@llnl.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Commit SHA1 == SHA1 checksum?
Thread-Topic: Commit SHA1 == SHA1 checksum?
Thread-Index: AQHYGi5plyRCtORi7ESRVYj3Pq/mhw==
Date:   Sat, 5 Feb 2022 01:19:24 +0000
Message-ID: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eef53733-7ec0-4d7f-4a85-08d9e8458bfc
x-ms-traffictypediagnostic: BY5PR09MB5988:EE_
x-microsoft-antispam-prvs: <BY5PR09MB5988E5D91DF91C28DD30CB4FF82A9@BY5PR09MB5988.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFJWRZ3bp/6fTe3zM/j+UCNaD6U6ykLZR45Ofm+Y2FfJwFgDa210fDVWfrwbHjFzHAQZh8LHC06eHXVhDA4tt2NLOvlRvw8+NS0wYnFbBK1GR1i15c9jCewfwZ/vUMh2r1EVsTM6xwI4dB2EaLAJonXaHVKKVFlc0txYuRzhsmb4TPz74vUw9ha1wp1I1pKygORFbMierXkVZ83v7cMUyFFjSsqQiZTIdk042JmKaPXWvcAcL/0+aKfzk6gc4beG0PKVEZqEYSprchk40sv/YjWrpDRcHF912dwq6DbtLRcSr3qs7ioY0HfC45xaB3oTeABAjrwTYVPIl6Z6SMEbibtx49rCpOBVOvTpybhRYUGcHUSYWeRnCj+m5j3wlILd1tJCgHvFeojKLW1l/rOEUYiab3aB84EcXJ4Vh4CVPwwzoNT55pxhkF3JLZnDtTdwtcqbZd0DEJQfesSgHzg76NYmjD4znDsJqr+Q8CREKBXYkAq7PhjEqtLCdz3DBLRLbrcrxy9RTJuBJTLhAyb09Jl3iCAsShRN96uXTtcmH/oyToiUjiOrlpNudF4oizanKnEYCRGXytchNVflRCNU+GuX0IzqIzYw1RHluSLDT0PxXK+RHgevlx3r8r9Ua6pVYYbLC99s0XZVeHePqbYOR7Nv5l/0PWmCbu5zRObPdALHQzZzFCFBzqjh66KRsQowDMc/azF64HDUU7995qw0FHdJT6gs+v8Eia8VXzoHl/6Qxv+78zQvUPmHfnqgMw7MUjJHtypB1ieHOqp0kKYgz0Kec0iDBqhwEZyiExB75R2tqoWEOuW8I5M4kYv6RODUMEUrNGJ5UfgWQEqbXUCjF1rjgDX+Gz2AChzkpTZ8VqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB5972.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(19273905006)(186003)(26005)(2616005)(83380400001)(38070700005)(966005)(508600001)(6916009)(316002)(6486002)(82960400001)(36756003)(33656002)(8676002)(8936002)(6506007)(76116006)(38100700002)(66556008)(64756008)(66446008)(66476007)(66946007)(71200400001)(5660300002)(122000001)(6512007)(86362001)(45980500001)(563064011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3JXMExQd2Fvb3hvZWRZRmFOenk5RG14aWx0UUNySmYwc0R4WHRFczNyWUN2?=
 =?utf-8?B?U0ZWTzk1TEVhL0JDcWlJRW96V3RwY3ZER21vc3FqK1VWY3NCMlRoZGFEZDNt?=
 =?utf-8?B?S214S3d2MzY5S295MWVQWlcrdlV2UjVSYnFPK1d6WnNxcC9CUnBxcW5yckRK?=
 =?utf-8?B?eWFJb1kxQlQ5VkJSeW9SMkhMQkZzWVZBN0xaVDdVV1A0aERHUmVxNm9LNmJq?=
 =?utf-8?B?YWVQblhTZmNUTnFYT0hHNGtSUy9QUmJrN05ncGt2Rk55amh1OWxJTzYyempv?=
 =?utf-8?B?U0RhdDRPeWVlYXpuVUVsYm1GMk10SUZLdUE4VFNFMjBLemx2UVdob0hPemYw?=
 =?utf-8?B?VWVnMjkzYkNxSTdJQ2FQTXZjRlYxN01pVDg4N3AvUnZZajliV1lCV2JtdEt1?=
 =?utf-8?B?WUNUdTBLQSsyNWNYNzV5cEE1aC9hbzRhdUNQQXY4MFZjdUk1MDdHRFFyZnh1?=
 =?utf-8?B?NVk5eUZaT05tZUlUNnJTR1hJWGxWS3pMV2xveTFpUnNxRG9vS21KMVpOK1dG?=
 =?utf-8?B?dTNlQmhSSzhvMUJxWUhWZmpLWGxsSEJmVzBsM0RzNUVWTWNCcGR5NDE2Ukdu?=
 =?utf-8?B?Q1F0Z0NUbk9icWhxWWtQM1lHWGZucStqTDRIN3JBVTV4bHZMbDRWcGV0UUJG?=
 =?utf-8?B?emFLeWoycHZlZGdBZGtRam9GNkt4RzVIY1N1WUVlN1VVZ01iOEs5TFZmVzBQ?=
 =?utf-8?B?SDZHcW83dUIxVGtBVFNoa3FSNVpXNDBHUUVLV2pmd3BrSUQrMTV6N2szZ3lG?=
 =?utf-8?B?blZYVDFkTWNEZjhJY2xGM3BDY2FXWmZiVENZdnpPMWV3ZnFqQXh1bG9TVDc5?=
 =?utf-8?B?QjhjOWZmaEpBbFRaZUFxeTdjeTluTVN1S0V4d3p3SmcrWU43eDZFUWlwQldh?=
 =?utf-8?B?NEdVVVdoZzBmOSs5dzRSQlg2UWlhdHRUNWFrR25sTmVYQXZrVzg0MmNKYzUr?=
 =?utf-8?B?ZmdMbmExaWdMOHp5SUdISTJLV3h0eWMvOFdzSFNsVy9CZ3pMNFRXVitPUWR5?=
 =?utf-8?B?RlltK05MTjJNT1lIWTlZN1hNTWYzeEFRSW12aUlyejVOTE43QW0vVHpHMU1T?=
 =?utf-8?B?UWtsUUQ3amRqTTlIc2QyQmJxYzBaN2lPaGpjWXBHQ0oxODFWcWVvbFZKcHMx?=
 =?utf-8?B?ZjdlZjFjeDcvM3hOZUgxd3Q0WDlFT2MwTzFLTzlGVEJSclhQa3hTWFJVdnNX?=
 =?utf-8?B?am85Uk8yQkc2RHRIVkVpQTdRTmhRbk5oUEplRXZzL1BlMWlLN2M5QUVWUWt0?=
 =?utf-8?B?ZFJIY29zU0N3Y3ZGNEZzRHBTenh4RW1uZGZ5OHlGZ2pKSlhPdWdIVW92TTM5?=
 =?utf-8?B?aCs3TWRjVDFCdXoyckRWM01PVENKVnpCQkJEaUczTkwzVkNWR3c4K253ZkF5?=
 =?utf-8?B?YzhRRHI4YWRHTStmeHBNemwzWnUwTXMxVXZxSXZmT1FRSDN3dHZTMzdqbmRO?=
 =?utf-8?B?NnhjVFM2R3VtVWRIUC9LSHhqRS93OFRycGt4cGpBYUZzRm1Ub0lHeWcxYU8r?=
 =?utf-8?B?M1VvaHArNE4zVmJNWFFNdnJwdDBRbDFzZzNITisyVlBzek54djZSKzFoa1Ju?=
 =?utf-8?B?WlczZFlpUitsOFRtODRWUjFuR2RCK1d2ME9hbStINDBhYXkyY0pVNW5hdElL?=
 =?utf-8?B?T21FYVViWnQ2SHJRMngxVFB3YmlHWnRnRFdRbG5VSS9Wd1o5QjJHSldsbWFQ?=
 =?utf-8?B?WHVVU0E1Sk5VYmlpOHZXZjZYWU9nK3J4RS9uMGZlWHF6UW4yQ2R4aFJkaVJa?=
 =?utf-8?Q?49N1cTi7XFUJc+NmqJhd1asLCcENeGlpjJCh06t?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06D671D450FCA14188BFE80B06738E86@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB5972.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef53733-7ec0-4d7f-4a85-08d9e8458bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2022 01:19:24.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR09MB5988
X-Proofpoint-ORIG-GUID: 2SKkq4I0t6GH5-I0quVvCfvKNfM9RBw5
X-Proofpoint-GUID: 2SKkq4I0t6GH5-I0quVvCfvKNfM9RBw5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-02-04_07:2022-02-03,2022-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=719 lowpriorityscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050004
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QXBvbG9naWVzIGlmIHRoaXMgaGFzIGJlZW4gYXNrZWQgYmVmb3JlLCBidXQgdGhlIGNsb3Nlc3Qg
dGhpbmcgSSBjb3VsZCBmaW5kIHdhcyB0aGlzIHRocmVhZDoNCg0KCWh0dHA6Ly9wdWJsaWMtaW5i
b3gub3JnL2dpdC9QaW5lLkxOWC40LjYyLjA1MDQxNjA1MTkzMzAuMjE4MzdAcXluYXQucXZ0dmFm
dmdyLnBiei8NCg0KVGhhdCB0aHJlYWQgZGV2b2x2ZWQgaW50byBhIGRpc2N1c3Npb24gb2YgdGhl
IHNlY3VyaXR5IG9mIGRpZmZlcmVudCBoYXNoZXMgYW5kIGRpZG7igJl0IGFuc3dlciBteSBxdWVz
dGlvbi4NCg0KSSB3YW50IHRvIGtub3cgd2hlbiBhbmQgd2hlcmUgZ2l0ICpndWFyYW50ZWVzKiB0
aGF0IHRoZSBzbmFwc2hvdCBJIGhhdmUgY2hlY2tlZCBvdXQgaGFzIHRoZSBjaGVja3N1bSB0aGF0
IGdpdCBzYXlzIGl0IGRvZXMsIG9yIGlmIGl0IGRvZXMgYXQgYWxsLg0KDQpUaGUgdXNlIGNhc2Ug
Zm9yIHRoaXMgaXMgZm9yIHBhY2thZ2UgbWFuYWdlcnMuIEkgd29yayBvbiBTcGFjayAoaHR0cDov
L2dpdGh1Yi5jb20vc3BhY2svc3BhY2sgaWYgeW914oCZcmUgY3VyaW91cykgYW5kIHdlIGRvd25s
b2FkIHNvdXJjZXMgZnJvbSB0YXJiYWxscyBhbmQgZ2l0IHJlcG9zIChsaWtlIG1hbnkgc2ltaWxh
ciB0b29scykuICBGb3IgdGFyYmFsbHMgd2UgcmVxdWlyZSBhIHNoYTI1NiwgYW5kIHdlIHVzZSBp
dCB0byB2ZXJpZnkgdGhlIHRhcmJhbGwgYWZ0ZXIgZG93bmxvYWQuDQoNCkZvciBnaXQgcmVwb3Ms
IHdlIHdvdWxkIGxpa2UgdG8gcmVxdWlyZSBhIGNvbW1pdCBzaGExLCBwcm92aWRlZCB0aGF0IGl0
4oCZcyBiYXNpY2FsbHkgYXMgc2VjdXJlIGFzIGRvd25sb2FkaW5nIGEgdGFyYmFsbCBhbmQgY2hl
Y2tpbmcgaXQgYWdhaW5zdCBhIGtub3duIHNoYTEuICBTbywgaWYgSSBgZ2l0IGNsb25lYCBzb21l
dGhpbmcsIGlzIHRoZSBjb21taXQgc2hhMSBhY3R1YWxseSB2ZXJpZmllZD8NCg0KVGhhbmtzLA0K
LVRvZGQNCg0KDQpQUzogSSBrbm93IHRoYXQgc2hhMSBoYXMgYmVlbiBkZWNsYXJlZCDigJxyaXNr
eeKAnSBieSBOSVNUIGFuZCB0aGF0IGZvbGtzIHNob3VsZCBtb3ZlIGF3YXkgZnJvbSBpdCwgYW5k
IHBsZWFzZSBiZSBhc3N1cmVkIHRoYXQgd2XigJlyZSB1c2luZyBzaGEyNTbigJlzIGV2ZXJ5d2hl
cmUgZWxzZS4gIEhlcmUgSSByZWFsbHkganVzdCB3YW50IHRvIGtub3cgd2hldGhlciBjbG9uaW5n
IGEgZ2l0IHJlcG8gYXQgYSBwYXJ0aWN1bGFyIGNvbW1pdCBpcyBhcyBzZWN1cmUgYXMgZG93bmxv
YWRpbmcgYSB0YXJiYWxsIGFuZCBjaGVja2luZyBpdCBhZ2FpbnN0IGEgc2hhMSwgbm90IHdoZXRo
ZXIgb3Igbm90IHNoYTEgaXMgc2VjdXJlLg0KDQoNCg==
