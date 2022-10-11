Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E2BC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 11:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJKLjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 07:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKLjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 07:39:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233EC8E994
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 04:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPOf3aNOQC9SAzNOVNw9k3TwV/MFBZbLn+WuLkSkMQvy3uTx+fklT/Xme40hASYks2MgEWQRiMdLtQmNpo96vApCh7tcO6nc5+r84XeA8A4lQauZ1lfGyNAGZ31mP5nA603fs4ui8Qy+D8CApXaTliPeW7pdmHLL07+dnP7fk5uY2aaWSTEIfjPuvRRFwgAg6LK5cljCSVXYAW40BR0uJN972doPIQK4kPqaaNs2v/u8q+DkUuADQh3hSG39UAaJyFa289Mf6/6lYj8nNmbrkhr7XbgPM5Eq7SLm1r9qB7oI7oEAeVnau8+54Z4KpY22Eu2uYjPoi3kIkaC58TDUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTf9nr5kj506lPRTbsJpvYuxbARe8vbAcKmZrvHKpvw=;
 b=Qgp5gOHRonJCT1ysOTSMRBBsLNKIJtlpuUJudaViZIQMwnEAv0ssgXIZ7O+/Cp1N57zrx3tegGjb/n9mUZp8BFRkdJNOZXw7j5jwD8xE4ilK59LVS4qaBwf+OiOP04x6oNODWap9pesF++5qOWhr0/RpLAuwBeJFTCUQVFvUZ+O/kMyHMqwd0ZX+Wv/OBnDbl0YBO0OSttuWPlyWH8kqySToyFqyETDNrKYjRfUG+IgixyFAkIrCRuA5RlxaM4zf+cRiuPho7G6ae+p1bRL5vxGof7l6AE/vpbyHNG4IVUlI+aYrjJASqANyeRM0iyW0JOPbRDVwwdBUHaXcCF1STw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sidn.nl; dmarc=pass action=none header.from=sidn.nl; dkim=pass
 header.d=sidn.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sidn.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTf9nr5kj506lPRTbsJpvYuxbARe8vbAcKmZrvHKpvw=;
 b=jBTPW+sZtYoVm9WKdH2xShZN4uAOkV0tGFC6ESwsiFYqPKXy5PStJfaLEAyy0BdaZVq7ekDAtUwy2KpD7mupS/W2S9FDpEPJuuAVc64yZjnTXsZaQqGAdLV5c5QJ1vxNHqQPtEjol0iE6zbdaMvqzDd1kw4TLtJGMPetJXCeH6g=
Received: from DU2P194MB1584.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:271::9) by
 PR3P194MB0636.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:31::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.18; Tue, 11 Oct 2022 11:39:07 +0000
Received: from DU2P194MB1584.EURP194.PROD.OUTLOOK.COM
 ([fe80::85a6:7ae8:c5da:2032]) by DU2P194MB1584.EURP194.PROD.OUTLOOK.COM
 ([fe80::85a6:7ae8:c5da:2032%8]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 11:39:07 +0000
From:   Bart Kuster <bart.kuster@sidn.nl>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Seemingly inconsistent checkout behaviour
Thread-Topic: Seemingly inconsistent checkout behaviour
Thread-Index: AdjdY0G6Z+ux8H0rQpG1Bvxj06huLw==
Date:   Tue, 11 Oct 2022 11:39:07 +0000
Message-ID: <DU2P194MB1584B11245DF0DE7515297B6E3239@DU2P194MB1584.EURP194.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: 50aa9764-3d87-48a4-87ec-342dc2e29c0f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sidn.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2P194MB1584:EE_|PR3P194MB0636:EE_
x-ms-office365-filtering-correlation-id: 07430cac-3567-470c-58bc-08daab7d34c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8Y38jbCfiyjv0KUR6CbfuNZbCUFbpuROu+B87fiXAi207/uQ0NiDXOVgcoYLxaTdDgmDwlfKML2enxRVKScfM3APvweg+but+k8LldmyLP0epBlHZJJbFb4hv1/ru8cpOZ8+72kodDo0p7tvhfZXMy8dGidAnPE9pD9UJUY1d5WIfzzzZ8vChqytWxjq5azzWurZB63s0LP/OZOWUgV8pMSiBsAU3+VzB3l/7SRsmxz4vF+p3Tt2RNF0ORd3cTkVQJbze4ZcNPf4kjM9Tj7BoXNe1xrG1jEFzUGCrmfiH6gU/I1DjuZPp55d5/UceSylzqGCp+A2HxcKtEq49qxpdBDRCzQT4r0fowQMtR6dawPuEQOv7yF+BMihnSRku6BjRtvglYjetD7xca6DqB+DCkaEZr0/G+ZqtWjs9kZR7uGf+kxbpCas1USu+5dcYTJHNyuux2rejpKlUJ6U4hpweG4Sgd2m6tdpWRbi+Vm3AEltCMz/ULzhC5ERWbEsklGTSUZM4PTbbPq9RBxJUio+3JbtkhjQe2htptwIClkD09pAzE+2OkjM0N0wOiH7ACC+EeSljFTGy+HnzIjfK4EQrDJWRrR4oa33H4EZAVpNlnh0BCGmsadiJQotBL7/9zCMNCD+trk1a4VvTLTfX5KxsA1KOYJ/Yh9Wr9KSMVDcL1RKvZnyZH/9da/daijFFlKuN7O8oHA924kc4+BFton+FkGkwQkGL7C8Nz01YojjENaP/znTU2Cnn5hzB+ZIOtM76OxBVM89T8CcAQyXTznMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2P194MB1584.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199015)(41300700001)(33656002)(3480700007)(83380400001)(55016003)(186003)(38070700005)(6506007)(5660300002)(7696005)(52536014)(6916009)(26005)(122000001)(8936002)(66946007)(8676002)(76116006)(64756008)(66556008)(66476007)(66446008)(86362001)(9686003)(316002)(44832011)(2906002)(71200400001)(966005)(478600001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVdYL3h2eStOaERYSnkzT2d1Q2xBUjdGUy9LMFR1aUlaWUk5UnhOb0lJMG5s?=
 =?utf-8?B?WmpBaHB3QzdWcG9iSGlMRnVUbnpPSnMwc2ZFKzc0cktJYWR5NVpGTzgwelBi?=
 =?utf-8?B?WlZWWHl0MzZQdGYyemVmb3VGUmF3Y1AvR1ZTbENmTythM1hPOXhYMGlXQ2N5?=
 =?utf-8?B?ZThseFhyTVJxU2ttYXZBQklpQTBTUW1kYlluRlRFNURFYmVEUXJpcGdydS9H?=
 =?utf-8?B?SjRES2VZdExQWHpSU3E5TGN5N25GcCtMdnd4K1lqSEpZZTlqdDlERk51ZXZC?=
 =?utf-8?B?OHdJVlUycVBnaFplZnNoUkcyRXVUQjJQSGh3dS8zMjRNT1V3dDFxWXBIb3Jq?=
 =?utf-8?B?TFZrUzVPRjJZUmVEK3BkTXhLb2dBREdNQ3dXQkJhd0tBNHBMYURPTU5OaDFZ?=
 =?utf-8?B?K0J1QUZyNS9wOHJJY09vM2JyYWFuVTQyWlRBQ1g2NGFra0dsOHpsV0NSd3pV?=
 =?utf-8?B?MXhlOEdtMVNEQTB6NGovV3lJeGs4NHd2ME04Y2FXL1grbW9OQ3QrdVNVOSs1?=
 =?utf-8?B?dEhTZEU2aGRPSXd0QVpVMERleDIwdHM3Z0VjdXVGMGdlMmJtRjRGZ2VnZWl2?=
 =?utf-8?B?eEcwM291ZEZqbGozL3BNVVc2UFY1QlZEUzh2bVZBM2ZWVG9vYmJ4d3ZOalVR?=
 =?utf-8?B?alpmaGJldlpIdWFkUDAzcmJhZzBnMlhDVFhHL0lka1Z5SnhqWjJFYWpRRnJU?=
 =?utf-8?B?OTF3amJZOE1henpsaDNEWUtIdHQ4OHRiZGI4MWh3NVl4Ry9ZOWN5TTR1dXhz?=
 =?utf-8?B?NEhwKzU3T3drTmJoRFZzUlBwNWNLZ3l6YjFoSU9GTFg3Ymw2NFpERkJFR1dZ?=
 =?utf-8?B?MTVhVlgrMENKcGQ2VGhURG9MWVRucFQ1ejRXVzdFYU9kOHdZdjd5TXpNbVl1?=
 =?utf-8?B?M0hOSURWQnlzSnNMZVUzMGZMTHdmM2hCZmlGeXg2b05HcWlaZmxpMmk0TlNo?=
 =?utf-8?B?STdrbU9IN0d6eWZ2cVhJOE4zNHNzdVhPMm0rUmxNcDR4OXpiY0JlQVU3R01N?=
 =?utf-8?B?dGViWXFRVDg1dmcwbFppem5yQjR0S3hQekdwUll2TTE0d29pcWZyZU42ZmZB?=
 =?utf-8?B?eGl2RWJJbW5pUWhtU0RZYmVlWTF6b05VRjVsSmFjT3RWb2RnOXdoSUN4YVgy?=
 =?utf-8?B?WUdIVTFVOXgySzJqRVhNZnB0TGFKdyt0cnRQL0JEbkZVR0d6RTdJdDN1OU9Y?=
 =?utf-8?B?Vm9WTnUzV0RyWitYcENkbmdTNEkrTFBxYXdZUGpQSElzMUhaNlpCb3A1dTYv?=
 =?utf-8?B?QXZyTE93UjBhblRpaGxnNTRxQlduVWRyUnlaaDA3VGZHcytkZWJlUzJOZWJW?=
 =?utf-8?B?K2VNZGJhVGE1TTl5TUFVMW1DSXI0dXZ2YjBDdmh0WnI1VWRKbjFCaE96eFVW?=
 =?utf-8?B?ZUJGZU1oa0NoMFRXUk5HN0hNWm1hZkJDWHMxK1JLOEpIbGMwN3FFdnROUCsz?=
 =?utf-8?B?eDFNNko1L3N4d09HeldhekFVL1c4YkFZTG5IdldNTS9oL0RUTXltY2J1WFhl?=
 =?utf-8?B?U2ptTHFvVzQxUGVUdEVWcm5MMWxCVkpzSHdCZzRYc0dlaXZGcU04VTNaaVdX?=
 =?utf-8?B?cXUyNFdQT1hYUkxSZVduK2o5a3NNL0ZRTVc2b3RGdUUyL2k3ZkQ1OVYwQXpL?=
 =?utf-8?B?S1J3bWJwV2pCT2ZSb2syN1B2aTNrSU5NM2kyaklYckdjcTBuV0tkaFQ5YnUv?=
 =?utf-8?B?UzFkSVo5Q1hnUFo3S01BZnphZWtwaXRCc0lQTTVJSnVLTHZhdnY2V0Z5R3J6?=
 =?utf-8?B?VzVTNVBvOXU0R3ZNcDVtVThmUDVaSFlySXVpRW5FdkhoWWU3UzA2dFd2ZnRm?=
 =?utf-8?B?SHdMTERYOVcya0NweU92bXpMVUV6SWIrNUJERE1mR0xIdHc1RS90ZDFYNHpB?=
 =?utf-8?B?dDRJSEprTnNNK3VVSTdudWxTSklxaStnUWdIdmlMNVJESXhwS1hPeFpEOVB3?=
 =?utf-8?B?cHBGbUw3N0YvbzA3R25UT3pkUHVBaUwwZUhVYnJESWd3cFJLeFJEZFg4ckZx?=
 =?utf-8?B?NVkvNUYxVVk4a0IxR2hvc2VQd1Eyc2p1ZGNqVS9TWW13YjJNVWJUSVc0YnBD?=
 =?utf-8?B?U2N4TjhsSnQyWTEzWXRNZEdXaktEWVlLbWg1Q0Q1NXNsRE8wNGMySXhvMnhJ?=
 =?utf-8?Q?UXLHsDMt7zc9YA9AXBLhF/1af?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sidn.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2P194MB1584.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 07430cac-3567-470c-58bc-08daab7d34c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 11:39:07.0669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ab4d3626-c1c5-4a75-ab85-427f1a644a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CoyXUa/B/oX8OI4tjSQSL4ZEzDE/Qwn5gADweEgnJI8TW8JvsDNBWn5EN+q2yaDDxLLvGorMoM+ssmAJ1+PqNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P194MB0636
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhciBQZW9wbGUgb2YgR2l0LA0KDQpJIGhhZCBzb21lIHRyb3VibGUgZ2V0dGluZyBvdXQgb2Yg
YSBkZXRhY2hlZCBIRUFEIHN0YXRlIHVzaW5nIGdpdCBjaGVja291dC4gSeKAmXZlIHNvbHZlZCBp
dCBub3cgYnV0IHRoZSBiZWhhdmlvdXIgb2YgY2hlY2tvdXQgd2hlbiBkb2luZyBzbyBsZWF2ZXMg
bWUgYSBiaXQgcHV6emxlZC4NCg0KSeKAmWQgZXhwZWN0IHRoZSBiZWhhdmlvdXIgb2YgdGhlIGNv
bW1hbmRzIGJlbG93IHRvIGJlIGVxdWl2YWxlbnQ6DQoNCiAgIGdpdCBjaGVja291dCBvcmlnaW4v
bWFpbg0KDQp2cw0KDQogICBnaXQgY29uZmlnIGNoZWNrb3V0LmRlZmF1bHRSZW1vdGUgb3JpZ2lu
DQogICBnaXQgY2hlY2tvdXQgbWFpbg0KDQpCdXQgdGhleSBhcmUgbm90OyB0aGUgZm9ybWVyIGxl
YXZlcyB0aGUgSEVBRCBkZXRhY2hlZCB3aGlsZSB0aGUgbGF0dGVyIHNldHMgaXQgdG8gbWFpbi4g
SSBmYWlsZWQgdG8gZmluZCBhbiBleHBsYW5hdGlvbiBpbiB0aGUgZ2l0LWNoZWNrb3V0IGRvY3Vt
ZW50YXRpb24sIHdoaWNoIHNlZW1zIHRvIGluZGljYXRlIHRoYXQgY2hlY2tvdXQgYWx3YXlzIHVw
ZGF0ZXMgSEVBRC4NCg0KQ291bGQgc29tZW9uZSBjbGFyaWZ5IHdoYXQncyBnb2luZyBvbj8NCg0K
QSBiaXQgbW9yZSBlbGFib3JhdGUgdHJhbnNjcmlwdCBvZiB3aGF0IEkgZGlkIGlzIGJlbG93Lg0K
DQpUaGFua3MgaW4gYWR2YW5jZSENCg0KS2luZCByZWdhcmRzLA0KQmFydCBLdXN0ZXINCg0KLS0t
DQoNCiMgQ2hlY2tvdXQgYSBjb21taXQgdG8gZ2V0IGludG8gZGV0YWNoZWQgSEVBRCBzdGF0ZQ0K
JCBnaXQgY2hlY2tvdXQgYWFjMDJiODFkNzM1ZDVmMTViM2IzYzYxYTg0Y2NiNzlhOGE5MDE0NQ0K
SEVBRCBpcyBub3cgYXQgYWFjMDJiOCBNZXJnZSBicmFuY2ggJ21haW4nIG9mIGh0dHBzOi8vcmVw
byBpbnRvIG1haW4NCiQgZ2l0IGNoZWNrb3V0IG9yaWdpbi9tYWluDQpIRUFEIGlzIG5vdyBhdCBh
YWMwMmI4IE1lcmdlIGJyYW5jaCAnbWFpbicgb2YgaHR0cHM6Ly9yZXBvIGludG8gbWFpbg0KJCBn
aXQgc3RhdHVzDQpIRUFEIGRldGFjaGVkIGF0IGFhYzAyYjgNCiguLi4pDQokIGdpdCBjb25maWcg
Y2hlY2tvdXQuZGVmYXVsdFJlbW90ZSBvcmlnaW4NCiQgZ2l0IGNoZWNrb3V0IG1haW4NCk9uIGJy
YW5jaCBtYWluDQooLi4uKQ0KJCBnaXQgc3RhdHVzDQpPbiBicmFuY2ggbWFpbg0KJA0K
