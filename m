Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D07C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4465860E90
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhHPS2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 14:28:04 -0400
Received: from mx0b-00209e01.pphosted.com ([148.163.152.55]:59458 "EHLO
        mx0b-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229722AbhHPS2C (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Aug 2021 14:28:02 -0400
X-Greylist: delayed 2892 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Aug 2021 14:28:02 EDT
Received: from pps.filterd (m0115756.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GHb7Tc001164;
        Mon, 16 Aug 2021 13:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=tGhQ/ZoxmWLXffoYs9FGkvoW7IWgeRiPyjTlDPyDNAc=;
 b=gvm597cKsghAj6EJp6eDUSeSvdGswCLTQeqdo8IClFOvLFvVrsQzpuDx4nR5VaeKUmwW
 UAraZZR5P/LOo8PpKASUkOH0swslmQQg7x25uLaUxFEUUHPrMoitldyeylvOE2imwUEk
 2+el79q+UJd/iNnFOKg0v9ouT4yBqhkjQN+cz6uzhQFsj1dBjF6TKqNwbAdZIRcd5goF
 45u2MFhj5zau0q1Q9FOhufxHqjsbsnkTUIAwKfADbuqsFi7+pxw+RzVVmYWiAaX3VOEg
 lMMWcEmaJVBklvkjY5Eh4WGRfjSi8/sobW2H+l4emPW/xyPKpMatyH9/Or/ZZwHKsdD/ UA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-00209e01.pphosted.com with ESMTP id 3ae8rj6d1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 13:39:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXNi0ooySXKHkJ4fDze4mMqaHEJh1lv0fqAWD0viMZmJ8tJBFR6qri2Mzo1dqq1nDBein9Wv8kXdH4JtiRQ9lcYT3sueOVGYhTTDBwLpdohoal8nTSQ2GqTnk51HDb6S/2maXZeo245HDzMsrv5He2UgnZUeSmS8zpd0bc/GF5ZtAupuy7Nlxg90HlrO8LIKP4xhdYIvEi/WZV+DoGWsil5P7L2oOP54JlISoWKJD46sLv4UOmeDW3/0Azcg3UO0U1w6RKbzJWUYbP4MGZ3+c4FA8z05WlWwSKORFW18wUW4BkKkiSB5Zu8yrKKIBQYgNJ03asT8CpSI88kyw7bRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGhQ/ZoxmWLXffoYs9FGkvoW7IWgeRiPyjTlDPyDNAc=;
 b=dnhJiJXXkW+hK6SH/m7sB74S/KOXivxVOvqm/ghXYkKaUj8JOrMxqgrig9fEKIA83jqqPiz/kJ6cbVXBmmAn9RX5lWoHT4n1XDuysM3IiSZo8GyzLPPFqIJd60FPjIGUUxRerYUw8RVnVmq2PkZkzF28m53JdfOZu7QvD6r7HuBswU6s5nx08N+pANkonEcVZxTQ7UzruSSTELf4zt5RB3+m3SPNtvO8moDqs0DlIB/p+LBLra6+Lmdamj8UDSWgZcoYxx2fSLnvrXybttkISTxQu7I8ym7HfwhLGt72VXDKJde+++zaMmAkJCYJIIoiTczzp8vQ1vyrDZJv1k13kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN6PR15MB1425.namprd15.prod.outlook.com (2603:10b6:404:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 17:39:12 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 17:39:12 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     Jeff King <peff@peff.net>
CC:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git clone corrupts file.
Thread-Topic: git clone corrupts file.
Thread-Index: AdeQbBTmFYBcWaT2QVKI1LhsxFP/CQAAfQYQAAGNnwAAB6C0gACE7ckwAAYxx4AAAE+G0A==
Date:   Mon, 16 Aug 2021 17:39:12 +0000
Message-ID: <BN6PR15MB1426D70E338F6B2A988565A9CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
 <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRqYD+SszvhhySwl@coredump.intra.peff.net>
In-Reply-To: <YRqYD+SszvhhySwl@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-08-16T17:09:05Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Privileged;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=1ad0a7c2-e5b7-48a1-a0cb-b390a8de1115;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
dlp-product: dlpe-windows
dlp-version: 11.3.0.17
dlp-reaction: no-action
authentication-results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f5ff150-7d1d-44b9-0fd5-08d960dcc298
x-ms-traffictypediagnostic: BN6PR15MB1425:
x-microsoft-antispam-prvs: <BN6PR15MB1425581AD2AEE7F0757A50B9CBFD9@BN6PR15MB1425.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +e9ay31evn2q4x7jJsnRHNqM/9d7OEJvshWjX/C3vYKltS1IKgPu8UzN4+lm61vTQJJsC2Gtxlc8jr3Jlpmw+OZOvcFBwh7ocBotQA51Zl5T7En/oEeMVnKvHCs17gvCUQoNz4XzSN+d4rj0J7C0YqsuRdmyiDJL705BiPcK2UE+LGABK0G9KONnQJ74C/qNm7oNtJmBv5/jJQ930K9sgCcwIOApyUMNq6N0Kg+PMDQ4HHG9AxLyo+QXRLvuj7VpcfQGew19hB9S7K1GUdBRk/P3vECSTQA2IwOdYe8PiXdG1V9iVb+hxOmHbA7n41Ib710Gne7760R6UMZXFgSXN95ZJD0Bbi2gD4o8BGbp+Dl0lUykXOVbygbgX761JjTxG6fnR+qWwca55gBnNgyjzyxW0XynrDew0L/9eGiVmXH9eaXGXa4JIoaOTYC3oLvMerGfbuMh5E62+z4WKDLpN8NFCNXPtZAQxvsPoIsXHUY5MvTLdgNWx9Al41z/Q3meiSZD3jWuM9c41XNeiYFYSBUQl9LTEnbpORFopHK30Wl6N7qsZ5iNSzrGM9UApLTEdxbLHMAqYgD3/ZCeUoWR2whrwdZITJpF9RkoXaqdP4AwDKoxSLRADW2WSOyxEKvf64OtqTEStKV2geFYqlI00Diud02GIJ62laLwnvE53Grw9k7sPDH8lCT4e/VqxihSK1PROK8fJbpzGOK6BKD6cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(66946007)(8936002)(6506007)(3480700007)(86362001)(83380400001)(55016002)(4326008)(64756008)(66446008)(66476007)(66556008)(26005)(76116006)(8676002)(186003)(316002)(7696005)(38070700005)(71200400001)(5660300002)(2906002)(122000001)(38100700002)(9686003)(33656002)(53546011)(52536014)(478600001)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azZkaDMvb1lZWUd5MmJ1REN4NFRPcEZmOCtVQy9lbE03dU9Tbms4aEI5d1J1?=
 =?utf-8?B?ci9pYnZ6ZG56c2xsbWNXMmZXNWh3ZGhYZnBHREtxamtrZGlMMmNVVXV4ZXJC?=
 =?utf-8?B?NkQzRiswdmt3RkJDWDN4eW9MWXpvZk9FL0pVUlBhMWJHMTViM3czUEQwZHFo?=
 =?utf-8?B?ZlNwSTB2WTliOWtaaEhwemhzK3lxRFVrZHpENjJSMTdyUDhTbVF1VndOR3hl?=
 =?utf-8?B?SXMzaXl1cXhvLzZDclVGbjBKWnM3Y0ZJckUvZDNrc3RRdWVYZWtwczBhVFRZ?=
 =?utf-8?B?Y00zL1BQNmYwNmJTZy80K1RIZkFWSjdkK2NTSnUxSGt5ZmwwS2oydUdSUGs2?=
 =?utf-8?B?a3J2ZE91MVdBalFpdGczSURiNUV4bVZ0WmJKSThkMVJrdUJySElYRzhRUFZL?=
 =?utf-8?B?WFNRM3NucjY1WGUyeTNnOTFnYzc1RCtlSkdPZkpna3dTdEdPMmQ1ZFIxRUM4?=
 =?utf-8?B?TkJrWnEyN2FscGM0clY0NHdNV04ydDd5NkVwT3lZZmlCK0Z2RFAzL0QzM1lp?=
 =?utf-8?B?MVFSTHBwU1QwOEdlQ0hVL001S3VTeHRSWjFOWnJpK2U2WjNhalcvNjE0QktQ?=
 =?utf-8?B?c2pUK0Z4US9RWXR4QXc5ZDUxY1RSVGNZaS9WMHlrRk9rd3k3aXIrL0xtZHg0?=
 =?utf-8?B?Y1AvU0xxakdTeWNFdUtKazhjUnd4bUNuSUdRcUtZajFYU01OT1RJWWV0TThT?=
 =?utf-8?B?Q1dtdXZnTXZUMmU1UG8yeVArWXpGcXo0OU9ZaXREWGt4S0F4MTVSUFd1allI?=
 =?utf-8?B?UXJBK0o3QWtHNU5BempzTjR3T1NWUnNuazBhNlVybmpFZ0x1OUY3dnhYVjFN?=
 =?utf-8?B?WTQ0RVFzUVpoeUlMYjBIclVldkR2S1VXKzdWME1tZjlEcjQzaGZVVzRpRkdF?=
 =?utf-8?B?VXhXM0R0VGVlc1ZxT2xwTnZleENLckVrakZyMmwxL0NvVmtzNzhBcmVIVWhr?=
 =?utf-8?B?ZnBiZzJuTFJHR2xycTVNOTJNR0U4RldPblJMaHpYYlBWbGk0UEh6M0NvMDdB?=
 =?utf-8?B?SGkwc2Y1ams1NnRsWkh0WEZuT3dSRnc1aUl1VWpmTWl3NXNlRTQyTm82V2Ro?=
 =?utf-8?B?L29iV3BTRTYzWWw1N2dXV2tKZlpSUWR4NGEraHFrbXNENzQ5VmJEYSsvenh3?=
 =?utf-8?B?UHJTaW0wMlJzbndwQi8wZGxFT0IwNnFhUkxhY3NUZlpQQmYrSHlqT29kaE1r?=
 =?utf-8?B?VVl1azZFRURJOExPTkRDZmJoZ3dQa3Fpdno3NE9DbGttTnRRc2l6eEUyOVQ2?=
 =?utf-8?B?akpGVytqanpVSWw2OHFIam9JOG52Y1M3RUhKU05tWjNrQis1dWdTS1pNUTZt?=
 =?utf-8?B?QzRCUWYrT2FhOTJzL2loMEQ0b2RqUFd4NzlYdHBkaVNCbHd1d09EYzdQYVhH?=
 =?utf-8?B?MVo3My95NndkWUdLeVcvdGYzWmNLRUtEdHBnaWUxYnBKZnZrZU5XbVF4Y214?=
 =?utf-8?B?ZjZ5SmdwS2xNOUUvQnBhZ20yeEtCcVFyTnJHS29NRk5sZldqQm5mZFdBbXZG?=
 =?utf-8?B?OHJrdjdIQUlaZXVzRitaV2ZETE80TGlhZ2ZXOThubklhUkpHR2dDVWVqblly?=
 =?utf-8?B?Znh6WXVDRDd2dEM5YTdKazk0QldPQ0RjTmdHQlVURnBTUCt6RWxETGdUMU1v?=
 =?utf-8?B?cy9pT2R6TWxzb244T1V3S2hHL0todmY1eENGWElqaE1kUmdJU1ZFenlQNVdi?=
 =?utf-8?B?U0dEZXZDQmtqWVduSG4xUlJlWEI4eEZyQ09SUklRRXRKWmswM3g4eE5hMXFZ?=
 =?utf-8?Q?LRTwIrDh5d2hKTFWHYFcvqY+JO1wMXc7TE4eETL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5ff150-7d1d-44b9-0fd5-08d960dcc298
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 17:39:12.2193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snrbxCOVMIs10Oob5mjnjSawCA+Ol86HQEX6PyOv1a6YBB+JvRma+6fh8pHweeAsW6dMbtxYE6G96fKR3WUUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1425
X-Proofpoint-ORIG-GUID: XGGiapyEj5mpbqhI3d-3cQ_p2lvakveD
X-Proofpoint-GUID: XGGiapyEj5mpbqhI3d-3cQ_p2lvakveD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_06:2021-08-16,2021-08-16 signatures=0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SmVmZiwgIA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuICAgDQpXZSBkb24ndCB3YW50IGFueSBF
T0wgaGFuZGxpbmcgb2YgYW55IGZpbGUuICBUaGF0J3Mgd2h5IHdlIHNwZWNpZnkgYXV0b2NybGYg
ZmFsc2UuICANCg0KV2Ugd291bGQgbGlrZSBnaXQgdG8gbm90IGFueSBjciBsZiBjb252ZXJzaW9u
IG9uIGFueSBmaWxlLiAgIFdoZXRoZXIgdGhleSBiZSBBTlNJIG9yIFVuaWNvZGUuICAgVGhleSBo
YWQgdGhlIHJpZ2h0IGVuZGluZ3Mgd2hlbiB3ZSBjaGVja2VkIHRoZW0gaW4uIA0KV2UgZG9uJ3Qg
d2FudCB0aGVtIGFkanVzdGVkLg0KDQpEb2VzIHJlbW92aW5nIHRoZSBlb2wgPSBjciBsZiBmaXgg
dGhhdD8gDQoNCglZb3Ugc2FpZDogIFVURi0xNiAuLi4gIGNhbid0IGJlIHRyZWF0ZWQgYXMgInRl
eHQiIGJ5IEdpdC4NCg0KV2UgY2FuJ3QgbWFrZSBhbnkgY2hhbmdlcyB0byB0aGUgZmlsZXMgdG8g
c3VpdCBnaXQuICAgV2UganVzdCBuZWVkIGdpdCB0byBzdG9yZSBhbmQgcmV0cmlldmUgZmlsZXMg
YXMgY29tbWl0dGVkLiAgDQoNCldpbGwgcmVtb3ZpbmcgdGhlIA0KDQoJZW9sPWNyIGxmIA0KDQpm
cm9tIHRoZSBsaW5lIA0KDQoqLmluaSB0ZXh0IA0KDQpmcm9tIHRoZSBhdHRyaWJ1dGVzIGZpbGUg
c3RvcCB0aGUgaXNzdWU/ICANCg0KSWYgbm90LCBkb2VzIC5naXRhdHRyaWJ1dGVzIGFsbG93IGEg
cGF0aD8gIFN1Y2ggdGhhdCB3ZSBjb3VsZCBzYXkgDQoNClxjb25maWdcTGFuZ3VhZ2UgU3BlY2lm
aWNcKiAgIHR5cGUgIC0gICAgSWYgdGhlc2UgYXJlIFVuaWNvZGUsIHdoYXQgd291bGQgd2Ugc2F5
IGhlcmUuICAgQ2FuIGl0IG5vdCBiZSB0ZXh0PyAgVGhlbiBiaW5hcnk/ICANCiouaW5pCXRleHQg
DQoNCg0KVGhhbmtzLCANCg0KU2NvdHQgUnVzc2VsbA0KU3RhZmYgU1cgRW5naW5lZXLCoA0KTkNS
IENvcnBvcmF0aW9uwqANClBob25lOiArMTc3MDYyMzc1MTINClNjb3R0LlJ1c3NlbGwyQG5jci5j
b20gIHwgIG5jci5jb20NCiAgICAgICANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4gDQpTZW50OiBNb25kYXksIEF1Z3VzdCAxNiwg
MjAyMSAxMjo1NCBQTQ0KVG86IFJ1c3NlbGwsIFNjb3R0IDxTY290dC5SdXNzZWxsMkBuY3IuY29t
Pg0KQ2M6IGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+OyBn
aXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogZ2l0IGNsb25lIGNvcnJ1cHRzIGZpbGUu
DQoNCipFeHRlcm5hbCBNZXNzYWdlKiAtIFVzZSBjYXV0aW9uIGJlZm9yZSBvcGVuaW5nIGxpbmtz
IG9yIGF0dGFjaG1lbnRzDQoNCk9uIE1vbiwgQXVnIDE2LCAyMDIxIGF0IDAzOjI0OjI4UE0gKzAw
MDAsIFJ1c3NlbGwsIFNjb3R0IHdyb3RlOg0KDQo+IDEuICBUaGUgZmlsZXMgY29ycnVwdGVkIGFy
ZSBpbiBVbmljb2RlLiAgIFRob3VnaCB0aGUgLmggZmlsZSBtZW50aW9uZWQNCj4gICAgIGNlcnRh
aW5seSBkb2Vzbid0IGhhdmUgdG8gYmUgVW5pY29kZSwgaXQgY2FuIGJlIEFOU0ksIHdlIGhhdmUN
Cj4gICAgIG90aGVyIGZpbGVzIHRoYXQgbXVzdCBiZSBVbmljb2RlLiAgV2UgdXNlIFVuaWNvZGUg
aW4gcXVpdGUgYQ0KPiAgICAgbnVtYmVyIG9mIG91ciB0ZXh0IGZpbGVzLg0KDQpCeSBVbmljb2Rl
LCBJJ2xsIGFzc3VtZSB5b3UgbWVhbiBVVEYtMTYsIHNpbmNlIHlvdXIgZXhhbXBsZSBiZWxvdyBh
cHBlYXJzIHRvIGhhdmUgYSBCT00gbWFya2VyIGF0IHRoZSBiZWdpbm5pbmcgKEZGIEZFKS4NCg0K
VW5saWtlIFVURi04LCBVVEYtMTYgaXMgbm90IGEgc3VwZXJzZXQgb2YgQVNDSUksIGFuZCB0aHVz
IGNhbid0IGJlIHRyZWF0ZWQgYXMgInRleHQiIGJ5IEdpdCAoZS5nLiwgdGhlIGxpbmUgZW5kaW5n
IGJ5dGUgaXMgbm8gbG9uZ2VyIGp1c3QgaGV4ICIwQSIsIGJ1dCAiMDAgMEEiKS4NCg0KPiAgICAg
ICAgICAgZi4gICAgRW50cmllcyBpbiAuZ2l0YXR0cmlidXRlcyBzcGVjaWZpZWQgYnkgdHlwZSBh
cmUgc3BlY2lmaWVkIGZvciB0aGUgYWZmZWN0ZWQgZmlsZXMuIA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAqLmggICAgIHRleHQgZW9sPWNybGYNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
Ki5pbmkgICB0ZXh0IGVvbD1jcmxmDQoNClNvIHRoaXMgaXMgeW91ciBwcm9ibGVtLiBUaGUgInRl
eHQiIGF0dHJpYnV0ZSBpcyB0ZWxsaW5nIEdpdCB0byB0cmVhdCB0aGUgZmlsZSBhcyB0ZXh0ICh3
aGljaCB3aWxsIGhhbmRsZSBhbnkgQVNDSUktc3VwZXJzZXQgZW5jb2RpbmcgbGlrZSBVVEYtOCwg
SVNPODg1OS0xLCBldGMsIGJ1dCBub3Qgb3RoZXJzIGxpa2UgVVRGLTE2LCBVVEYtMzIsIEVVQy1K
UCwgZXRjKS4NCg0KRGVwZW5kaW5nIG9uIHdoYXQncyBpbiB5b3VyIHJlcG8gYW5kIHdoYXQgeW91
IHdhbnQgdG8gaGF2ZSBoYXBwZW4sIHlvdSdsbCB3YW50IHRvOg0KDQogIC0gcmVtb3ZlIHRoYXQg
YXR0cmlidXRlLCBpZiBhbGwgb2YgeW91ciAiLmgiIGZpbGVzIGFyZSBVVEYtMTYNCg0KICAtIGlm
IG9ubHkgc29tZSBhcmUgVVRGLTE2LCB5b3UnbGwgbmVlZCB0byBwcm92aWRlIHBhdHRlcm5zIHRo
YXQNCiAgICBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZSB0d28gdHlwZXMgYnkgZ2l2aW5nIHRoZW0g
ZGlmZmVyZW50DQogICAgYXR0cmlidXRlcyAoZS5nLiwgIi10ZXh0IiBzaG91bGQgb3ZlcnJpZGUg
Zm9yIHNwZWNpZmljIGZpbGVzKQ0KDQogIC0geW91IGNhbiBzdG9wIHRoZXJlIGlmIHlvdSBkb24n
dCBuZWVkIGxpbmUtZW5kaW5nIGNvbnZlcnNpb24gZm9yDQogICAgVVRGLTE2IGZpbGVzIChhbmQg
dGhlcmUgbWF5IGJlIGxpdHRsZSBwb2ludDsgR2l0IHdpbGwgdHJlYXQgdGhlbSBhcw0KICAgIGJp
bmFyeSBmb3IgdGhlIHB1cnBvc2VzIG9mIGRpZmZpbmcsIHNvIHRoZXJlIGlzIGxpdHRsZSBwb2lu
dCBpbg0KICAgIG1hdGNoaW5nIHRoZSBjYW5vbmljYWwgaW4tcmVwbyBlbmRpbmdzKQ0KDQogIC0g
aWYgeW91IGRvIHdhbnQgdG8gZG8gbGluZSBlbmRpbmcgY29udmVyc2lvbiAob3IgYW55IG90aGVy
DQogICAgbW9kaWZpY2F0aW9ucyBvbiB0aGVtKSwgeW91IGNhbiBkbyBzbyB3aXRoIGEgY3VzdG9t
IGNsZWFuL3NtdWRnZQ0KICAgIGZpbHRlciAoc2VlIHRoZSAiZmlsdGVyIiBhdHRyaWJ1dGUgaW4g
ImdpdCBoZWxwIGF0dHJpYnV0ZXMiKQ0KDQo+IEkgd291bGQgbGlrZSBnaXQgdG8gb2JzZXJ2ZSB0
aGUgYXV0b2NybGYgZmFsc2UgYXMgZGlyZWN0ZWQuDQoNCkhvcGVmdWxseSB0aGUgYWJvdmUgZXhw
bGFpbnMgaXQsIGJ1dCBqdXN0IHRvIGJlIGNsZWFyLCB0aGlzIGlzbid0IGF1dG9jcmxmIGtpY2tp
bmcgaW4sIGJ1dCByYXRoZXIgdGhlICJ0ZXh0IiBhbmQgImVvbCIgYXR0cmlidXRlcyB5b3UndmUg
c3BlY2lmaWVkLg0KDQo+IFdlIGNhbid0IGNvbnZlcnQgdGhlIGZpbGVzIHRvIG90aGVyIGVuY29k
aW5nIGZvciBjb252ZW5pZW5jZSBvZiBnaXQuDQoNCklmIHlvdSdyZSBoYXBweSBlbm91Z2ggbm90
IGJlaW5nIGFibGUgdG8gZ2V0IG1lYW5pbmdmdWwgdGV4dCBkaWZmcyBmb3IgdGhlc2UgZmlsZXMg
ZnJvbSBHaXQsIHRoZW4gdGhlIGFib3ZlIHNob3VsZCBtYWtlIHlvdXIgcHJvYmxlbSBnbyBhd2F5
Lg0KDQpCdXQgYW4gYWx0ZXJuYXRpdmUgd29ya2Zsb3csIGlmIHlvdSByZWFsbHkgd2FudCBVVEYt
MTYgaW4gdGhlIHdvcmtpbmcgdHJlZSwgaXMgdG8gY29udmVydCBiZXR3ZWVuIFVURi04IGFuZCBV
VEYtMTYgYXMgdGhlIGZpbGVzIGdvIGluIGFuZCBvdXQgbyB0aGUgd29ya2luZyB0cmVlLiBUaGVy
ZSdzIG5vIGJ1aWx0LWluIHN1cHBvcnQgZm9yIHRoYXQsIGJ1dCB5b3UgY291bGQgZG8gaXQgd2l0
aCBhIGN1c3RvbSBjbGVhbi9zbXVkZ2UgZmlsdGVyLiBUaGF0IHdvdWxkIGxldCBHaXQgc3RvcmUg
VVRGLTggaW50ZXJuYWxseSwgZG8gZGlmZnMsIGV0Yy4NCg0KT25lIGxpZ2h0ZXIgYWx0ZXJuYXRp
dmUgdG8gdGhhdCBpcyB0byBhY3R1YWxseSBzdG9yZSBVVEYtMTYgaW4gdGhlIHJlcG9zaXRvcnkg
YXMgeW91IGFyZSBub3csIGJ1dCBwcm92aWRlIGEgdGV4dGNvbnYgZmlsdGVyIChzZWUgZGlmZiBh
dHRyaWJ1dGVzIGluICJnaXQgaGVscCBhdHRyaWJ1dGVzIikgdG8gY29udmVydCBpdCB0byBVVEYt
OCBvbiB0aGUgZmx5IHdoZW4gc2hvd2luZyBhIGRpZmYuIFlvdSB3b24ndCBiZSBhYmxlIHRvIGFw
cGx5IHN1Y2ggYSBkaWZmLCBidXQgdGhleSdyZSB1c2VmdWwgZm9yIGh1bWFuIGV5ZXMuDQoNCi1Q
ZWZmDQo=
