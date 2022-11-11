Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730D4C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiKKCNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKKCNu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:13:50 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383176177
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:13:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrI4zUaU9IjUQaR/W3sMayxxd5MkILyDznnzmARfxTWRK0NTZ/1QdN0Z+j8FnlAB4fLcn4/RyJWwz6hKfkmarElAK6vR+2ycoFeOJqKm4vM8oEBvwMIf7dHOSMD0UfOTeED07uE+cUYKfRPDrXpdbY2WsRNBmSt8vYqAozMqmcz3I1budeDVH5845BE0yhfKu5E1z6fhtogvRVQ63FI3m8jHA3/NRpaMJdYMzWtOxesArLcNlyLSXCWW7FF4VY/FgxO4QZ0r6fK5LRqxopbhyLOxvCBxQ/nubkiVWmJQk0qzURUB7ZnwG4oq70KfvJ5zUvC9sejd1STxZlPrQ0/TdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61yGLvFQhIh0vzhjRyfo2TMpqg68Ut/qfDLHS3RKYsg=;
 b=lK+18zGrH42vXq7wHMvIY/XNoa3pUyDw3Aa+iHwyjIKSxdfZwi/xBkQNRlukUhydPrx/6zBRxsKPIAQOUb2Ee6qfKSsX6fw8X3B0vnd0I6gYv4Y38kc5Wsgdf76AcabQMk7XChmwUexMUI8Z5zPq0CI4gMG5mKuUse03NfkU2R0EwdovUivefWX8CN3UEh61Ix9Yv501ZTws160sk206XiaGcbgcKr4DyEGs420jYlbABGwuyIjpaFlOcdX6pLfa0JZCjiTKnP2ep+jkDudD6Em2tZiHJ6RkOYOj2Fbat3y36zzvuk1ucujfKqmQTYfsUveAZg+iejsQfJyhm4JidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61yGLvFQhIh0vzhjRyfo2TMpqg68Ut/qfDLHS3RKYsg=;
 b=2qp8U4bDXYC3W3skabqWkNm0DSAhZWhazUsfIw7Z1FJbdDrr8vJSKPbRFGmXB2QpnAeZrT8/NqD4BjDsIcX+yJujQrzG6aDT4QKrgtYB8kpK9mBnaVvHGzV6fXyHbx3Rpd8ywfMD27aWHCISG8RQFb3Jc1JeV2Es321cuc6Z3X4=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.13; Fri, 11 Nov 2022 02:13:47 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 02:13:47 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: [PATCH 0/2] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Topic: [PATCH 0/2] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Index: AQHY9XM7oHOOJy3RS0iIdvBb0CIGIg==
Date:   Fri, 11 Nov 2022 02:13:47 +0000
Message-ID: <20221111021306.449176-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|DM6PR12MB4107:EE_
x-ms-office365-filtering-correlation-id: 5a466398-7a1c-4612-73a7-08dac38a5dd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zvfzWVnOOsCjl9cSDM9RTWnlQIG7iSyUujgxImZ4SQFYGAzgCAJjlHLzOFzyevdGkbKdrYDaOh9hYmR3xQynqg3GQU5YhMt+E9GfiZcebihf+OfhsJGXvw04XnJPKOT+6rglrU5U6eqGmqrtuVMcmBd3zTXraq+v5q76ui8+Uv+oREb1SVxsmALe3kLHStTO2l9bCInLj8hJIyhRUOX2rd+ttDtI0slgc/9YIa66o/QvqxZEClExXCNAU3Htu/+PF/sNlbqqC5O/ILlyAmhmCW1bFdApzH6EZfEO38glhU2WHTxz4/7v2qqbkOoklVdT4HNsCvCh59E5cqs4Ni6xyCaqmfcrgvLk2W2J0ojhkAIMpNhczSt2EQva1H39KsUPc/6h6Tx40V5LbKb+HK4MBlnYhryCSm733W3QpUgz131cl+43gNqF1ZX+XWz05iUbX3uvHDEOySPwNFD1pEJB2w6qjpu35jCdYiQWtJ6zIUY86F2Q0Rf/55dGvA52P5qhnVziKK1YtLU8inC3esngL+N0ySX3pwxV2t3x8R7DSZCgHdYHWJmbWeAiOlxM6678sAja58tmLYymJ/DHiID4pd5enEtubs0xgShpJt1mFKe5SFBxk5gEFkq2wqwdJBsZc75e8DnYVDGrSfXxCBjIkdMKSHoqvG6XOk/yvktgDDrJ7H84gkmLjV2MsDcFvFPzj8F0Sk+E/xRmOvH5NJU6uiT3iMbqw39+8KaipxQpVYUfTyW/DChZI2ygKEJt8U4hJqjm3OaFvLE0RKNa8NQcAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(38100700002)(122000001)(15650500001)(86362001)(38070700005)(4326008)(6506007)(2906002)(26005)(66556008)(6512007)(66446008)(66476007)(2616005)(64756008)(76116006)(91956017)(66946007)(6486002)(71200400001)(8676002)(316002)(83380400001)(8936002)(5660300002)(1076003)(66574015)(6916009)(41300700001)(36756003)(478600001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDhueW5TSWU5TExkMm9GRm1od3ZOeXNGTFU1QThWYmxaSFhLMm91eXRLQlk5?=
 =?utf-8?B?T1NscHNFdTllYmhFZXd2b2Q4ZStaYkN3aGsrSWl5bE0yOGxIVm5lNC9NZ0Er?=
 =?utf-8?B?ZUNJK2JCR0NjNVExVkZHL29NTkVIbkJwbkRVa0h5NjlmcGUrb0YrU2VsU0VX?=
 =?utf-8?B?RnVMS0xxWVp1dWVUOEthNVhaSHAyV1J2ZCtOa0xCWHpvRlNod045ZDZlWUdy?=
 =?utf-8?B?UG0zRnZWL2tsOEdvUEZYaW1nVE1JY1dGdkRBV3hDVklVc0xJQ3QvTnUrUHZR?=
 =?utf-8?B?dFc1RGUvbXkxYnZsOXZnTlZldzQwMWVzZ1BVWWtRaXJVTWxjZEZqNE05SVZO?=
 =?utf-8?B?UmdyczB5L3FiYXV6S0xsT0RoeGl0c0VKYTZ1WGVNY0dvQkxGeTZ3M1Z6OXBo?=
 =?utf-8?B?TXorRWY5Nm1mVmd2TGdFbDRpZldNbEhEcFVTeDdkRTlLbzJyekZCL2xTKytK?=
 =?utf-8?B?bll1bm45akpzQmhueS9RQndud1FkbXNPaXcwVWZVMkUwckFYY3FPamZONnc4?=
 =?utf-8?B?dzlOL0YzWkhFeUhCeENEYU5RYUd4bEk4RHh2VFY0SlRRWFVnU3NETjRZSVh2?=
 =?utf-8?B?Y0ZkbVpZa2tIL25RbjV6Ukdjbk9oR2RaWHhaekdkMFk4bmszbzlUOG9BR1NF?=
 =?utf-8?B?TFVYSDM1SzFnNVk2WFUwYktHaHk4STVoQWhDUGIyeDFhUUtWcXk2QVpBNVg0?=
 =?utf-8?B?RzJYZUpmdWY3Z0IwdHQwS1Z3Nk5MUGVud0ltcG9kcCtEYk9JY2tuSnl4ZEdk?=
 =?utf-8?B?QTNTREZsVUFpOEs2a0Y4VEd5SVRNcEdjSXl5dno1S0hxeGN2eHdWNDVxaTFh?=
 =?utf-8?B?aEpEemIySVhSTm1ua2FzVkpKWkFCRmlEZStuQUhEeW1pOTg1cFV2dzg2VlBH?=
 =?utf-8?B?OS9pUHRaOEhRZWNrYncxeTlMNjYvdGVMVXBBL09Sc3IwUTlmM0k2UkE2NEp1?=
 =?utf-8?B?c3hPMFN3SW5SSjRBVnFSVnUwRTlmaklYTTd6YVdpVDJncXBTcElOUlB0UGlQ?=
 =?utf-8?B?bFVwT0Z4SVkrZTFFbmJkWFpVZHlYYmhDMzNlV1VJeE04YUdNeEpKRHR0bkxM?=
 =?utf-8?B?bTNablZrdUM1YTN2a0FnTys2cTV3TkxpLzFQeGtRazZPdmhuV0JyRzdmREw0?=
 =?utf-8?B?ZUEvU2NKdGxRZU5sNitVYWdrbGViQ0N1dW5GU0hRQ1Q3aWlDU2wwdXNOU2Q5?=
 =?utf-8?B?UGNkeTlGalIrcldKb3NnNmtMWFZzZXFEZlM1bHNXK2hpOVp3TGJWbXQ1VXN2?=
 =?utf-8?B?Qm0vUFdXV3lDQitnTnpsaVk0ck9KcVV2VzV1VHVqTjcrWjczdFJoUm9tMGNs?=
 =?utf-8?B?aG5XOWU4TThzRVJMalVXeUhsNDNVaDlZQk5rVTZ4Um9GTUo5amJFRU51SUVQ?=
 =?utf-8?B?M0NZVGlnZjEvclpPcWxWZ3h1NmVFVVg4a1hvRzVOY3JuSEkxRE9ocElBS0pY?=
 =?utf-8?B?ektRUHc0cDZJQ2VaOTB2Qk9veWRHKy9tZExZQk9TRGJMa0plUTJYc2grZlpk?=
 =?utf-8?B?ZlhsM3J4c3FpTW1MdGhINnNUVzFkb0N6UGszVCsvOU9Sd1NvSzVSRVJHQVpW?=
 =?utf-8?B?NUY4K3BqQW9LRlVHQlZLVmk4N0s2aTQwMWlXY3RkSHhpVVdCTEZubys3TGEr?=
 =?utf-8?B?cHNlMndrMnYveEhMRThOWG02dDB6QmlKbWZBR0Z4Z3ovWEs5OWFwQmxlQ2RY?=
 =?utf-8?B?NDNRekx0ZVkrejlnTXBNRkF6RnBYa1J1Zk1WdjdwRE8wbWVSYmpXbFk4dHNK?=
 =?utf-8?B?R0JPcFA1TXJ4UGFmT3FlcEhmMGg1eDRaM0tPSEpYZlVBQXRSK2d0OHFLZnZH?=
 =?utf-8?B?NWljYmdaZUhJUFJQZS94T2JMNG9VRnlCanV4L09UYlJMS3FMZzZtVzltR21D?=
 =?utf-8?B?SVhoMmRTWEdQMTBRK0pVaE1kUldWNkR2LzNId096VTdZeUdSVGJhYWFNZnlo?=
 =?utf-8?B?UFcycWZvUkRXa2lqV0FNcVorcmJSY1lxVWZoR1ExKy96elRONTF2ZHdQOWQy?=
 =?utf-8?B?WGRoUXpTY2JaOWlUM1YzNE1xMEVqbXdFSWIvWW5XZzl2VnIxQWl2c1M3RUNv?=
 =?utf-8?B?MDZra1U1VkNvV01RVEJ3aWc1VW96YjNJSCt6ckFzOXZCKy9RTUVQUWxTT0g2?=
 =?utf-8?Q?fop3wB6DDNfeD6B85sk/Douj8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C78294A9E5B53E46BBC3C635D7D641E0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a466398-7a1c-4612-73a7-08dac38a5dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 02:13:47.3166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tji/2JGqWxjdJRJ3iRXP7XZ+nooM8M1dPSIf7HfXKhmIh8hRkoXIwJgp8aTU81EKD9kaZcNyFiIXdYO12Vnfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U3VyZS4gIFRoYW5rIHlvdSBmb3IgdGhlIHF1aWNrIGZlZWRiYWNrLiAgTGV0IG1lIHNlZSBpZiBJ
IGNhbiBleHBsYWluIHRoZSBpZGVhLg0KDQpTb21ldGltZXMgaXQgY2FuIGJlIGhlbHBmdWwgdG8g
cmVhY3QgdG8gc3BlY2lhbCBrZXl3b3JkcyBpbiBhIGdpdCBzZW5kLWVtYWlsIHN1YmplY3QgbGlu
ZSBvciBzcGVjaWZpYyBlbWFpbCBhZGRyZXNzLiAgTGlrZSBwZXJoYXBzIG9uZSB3YW50cyB0byBk
byBzb21lIGtpbmQgb2Ygc29ydGluZyBvZiBwYXRjaGVzIGJ5IG1haWxpbmcgbGlzdCBvciAidG8i
IGVtYWlsIGFkZHJlc3MuICBZb3UgY291bGQgdXNlIHRoZSBzZW5kZW1haWwtdmFsaWRhdGUgaG9v
ayBhcyBhIHdheSB0byBjb3B5IHRoZSBwYXRjaCB0byBhIHNwZWNpZmljIGxvY2F0aW9uIGxvY2Fs
bHkgYmFzZWQgb24gd2hvIHlvdSBhcmUgZW1haWxpbmcuICBJJ20gc3VyZSB0aGVyZSBjb3VsZCBi
ZSBvdGhlciB1c2VzIGZvciB0aGUgc210cCBoZWFkZXIgaW5mb3JtYXRpb24gYXMgd2VsbC4gIFBy
ZXN1bWFibHkgdGhlIGhlYWRlciBpbmZvcm1hdGlvbiBpcyBwcmludGVkIHRvIHN0ZG91dCBiZWZv
cmUgc2VuZGluZyBhbiBlbWFpbCwgZm9yIG90aGVyIHJlYXNvbnMgdG9vICh0aGlzIGhhcHBlbnMg
YWxyZWFkeSkuICBNeSBwYXRjaCBtYWtlcyBpdCBwb3NzaWJsZSB0byBub3cgYXV0b21hdGUgYW55
IGNoZWNrcyBvbmUgbWlnaHQgYmUgZG9pbmcgbWFudWFsbHkgd2l0aCB0aGVzZSBoZWFkZXJzLg0K
DQpXaXRoIHNvbWUgdGVzdGluZyBJIGNhbiBjb25maXJtIHRoYXQgZW5jb2RlZCBoZWFkZXJzIChs
aWtlIGEgdXRmOCBzdHJpbmcpIGdldCBwYXNzZWQgaW4gZW5jb2RlZCBmb3JtLiAgVGhlIHJhbmRv
bSBleGFtcGxlIEkgdHJpZWQgd2FzIHdpdGggdGhlIHN1YmplY3QgIlJoeWRkaGV3Y2ggeSByYWPF
tW4iIGFuZCBpdCBpcyBzaG93bnMgYXMgIlN1YmplY3Q6IFtQQVRDSF0gPT9VVEYtOD9xP1JoeWRk
aGV3Y2g9MjB5PTIwcmFjPUM1PUI1bj89Ii4gIEhvd2V2ZXIsIHRoZSBvcmlnaW5hbCBwcmludCBv
ZiB0aGUgc210cCBoZWFkZXJzIGRvZXNuJ3QgaGFuZGxlIGVuY29kZWQgdGV4dCBlaXRoZXIsIHNv
IGl0IGlzIG5vIHdvcnNlIHRoYW4gY3VycmVudC4NCg0KTGFzdGx5LCB3aXRoIHRoZSB2YWxpZGF0
ZSBjb2RlIG1vdmluZyBsYXRlciB0aGVyZSBhcmUgc29tZSBjaGFuZ2VzIGluIG91dHB1dC4gIEFm
dGVyIG15IGNoYW5nZSwgdGhlIHVzZXIgd2lsbCBnZXQgYXNrZWQgYWJvdXQ6IGNvbXBvc2VkIGVt
YWlsIChjb21wb3NlIGFyZ3VtZW50IGNvZGUpLCA4IGJpdCBlbmNvZGluZywgd2hvIHRvIHNlbmQg
dG8sIGFuZCB3aGljaCBtZXNzYWdlLUlEIHRvIHJlcGx5IHRvIGJlZm9yZSB2YWxpZGF0aW9uLiAg
U2luY2UgdGhlc2UgY2hhbmdlIHRoZSBoZWFkZXIgaW5mb3JtYXRpb24sIHZhbGlkYXRpb24gbmVl
ZHMgdG8gaGFwcGVuIGFmdGVyLg0KDQpNaWNoYWVsDQpQUy0gSSBmaXhlZCB0aGUgU2lnbmVkLW9m
Zi1ieSBhcyB3ZWxsLg0KDQoNCk1pY2hhZWwgU3RyYXdicmlkZ2UgKDIpOg0KICBFeHBvc2UgaGVh
ZGVyIGluZm9ybWF0aW9uIHRvIGdpdC1zZW5kLWVtYWlsJ3Mgc2VuZGVtYWlsLXZhbGlkYXRlIGhv
b2sNCiAgVXBkYXRlIHNlbmRlbWFpbC12YWxpZGF0ZSBob29rIGRvY3MgdG8gYWRkIGhlYWRlciBm
aWxlIHBhcmFtZXRlcg0KDQogRG9jdW1lbnRhdGlvbi9naXRob29rcy50eHQgfCAgOCArKystLS0N
CiBnaXQtc2VuZC1lbWFpbC5wZXJsICAgICAgICB8IDU3ICsrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyNCBk
ZWxldGlvbnMoLSkNCg0KLS0gDQoyLjM0LjENCg==
