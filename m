Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682CDC001DB
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 17:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHDRuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 13:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHDRuH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 13:50:07 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 10:50:04 PDT
Received: from mail10685.corpmailsvcs.com (ovarp0685.corpmailsvcs.com [149.111.143.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C639049FF
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 10:50:04 -0700 (PDT)
Received: from unknown (HELO mail10685.corpmailsvcs.com) ([10.188.14.134])
  by mail20685.corpmailsvcs.com with ESMTP; 04 Aug 2023 12:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=wellmed.net; i=@wellmed.net; q=dns/txt;
  s=dk.sep2016.2048; t=1691171339;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version:content-transfer-encoding;
  bh=Q9diwFK0z0p8Lo1AuGjbzDAvyxTFQhPMyhyX3la007M=;
  b=mf66pQixRzeSIsToObEvo+YeP7oPJmAQs5fvfOgbvnEmnjyVx7DBhgfe
   +njbeUTyn6EeE9oeJunNAgray+vfUkx71/HJZqGZ7A5DP4YDE3RrRwp/w
   iy0992Txh+UrKwcQhLWt4MPLgtY4udN9wT1YhsHjx6J0skQRCr9fKjTFh
   gOEpYJAoUJoUDaZ2FgCaSb650Yrj468PEu2y2BRLi6Wju663zJWVa4gSD
   sfKE8HbEXOVtX44x/tXdO9pKcwQqJXuOPJN+QlinM2D0QkBPJAX+Ef0rr
   5OZETG+trCeREaI5JSypBwVaV6nZzdAQExKHafsHmkEqlX1GiSyE6EtKD
   g==;
X-REMOTEHOST: mail-mw2nam12lp2044.outbound.protection.outlook.com
X-REMOTEIP: 104.47.66.44
X-IronPort-AV: E=Sophos;i="6.01,255,1684818000"; 
   d="scan'208";a="50007340"
X-CONF-FOOTER: True
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by mail10685.corpmailsvcs.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:48:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6E0lRbZarj0ICxcPa7qyH4G941tSXlRZDKv0cFHcbLrGWc/+1d1JWtCCuf5t3LSkGEdla0I7doz7E8vMWppl0yunba2qh5P4Of0GtNFreTV4NRX8bno//MGgvbR7Q46wSXGmxUOqtqES8HtvTYTO8QqsMbTYTEPLFCrscpvRdnzgkt5BLy6KOTojMkP0XRNppVW+kxBkejq8DBkfQC1L9nfGj+Uqn+prn5WfgQ1LZz0R2cdgVMVMCcoV1NzezwllarCz8NJJ75EvAxLlzc3IFbmC/HWT16mJxn7ZvvXkFvmUTAhjb8VoDoRFJ+ogzb60gaJ3EFrWV/tW+gGOVqg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky0NvUHpCmc5t4qWUpkjAudwHsMzvNrPDxWAyh0LxSM=;
 b=fIdumqpPAnXGGPFjazE1K9Fl6c/NCi057F2eSNvCSE2nfsmpUkkdvvDn5ezherK8WOrPv5mMSYB7qA9rArzHpEpcWLWWRHPFkFaM5yht7+6Ifn1BevCp0W6xjZGjbr0JeOQNMLCe6aaXuj9OfkL1KKaLfguCnwv9TJtfQAPlvSa4uugBIktS3+xLgIybkImA19G2VZ9aGsSkLxj5LEMdD5EvTP65s2mpCdYboJN2RVNplZVbdC5iB9Ry++oxNYfWxuoJwTbBlPOwGU8OuYcPEuyY4RWSAoP6yGAxtFMsrWaAiQPZCTyfnbVDUl5XtfOOHXuNjDZHiR8tsbPxOI7FmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wellmed.net; dmarc=pass action=none header.from=wellmed.net;
 dkim=pass header.d=wellmed.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=optumcare.onmicrosoft.com; s=selector2-optumcare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky0NvUHpCmc5t4qWUpkjAudwHsMzvNrPDxWAyh0LxSM=;
 b=E/yDYIJXlSET/hYxr1vAaCj+H+75146JdeCrJb6DYzDfqWRB+RQALILf2il3dn0AmmqTS4svz6iwQS5PkFQeDQOzNdZxZK5o91H5niaoC3L5uIA3isJGQPnEEZF04wpSUP9rJJCygpdRkgftetnpdF1+KKBVO0I4o6qcHDV0d3I=
Received: from MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:31f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 17:48:57 +0000
Received: from MW2PR12MB2555.namprd12.prod.outlook.com
 ([fe80::8baa:c5b7:42b2:9dae]) by MW2PR12MB2555.namprd12.prod.outlook.com
 ([fe80::8baa:c5b7:42b2:9dae%4]) with mapi id 15.20.6631.045; Fri, 4 Aug 2023
 17:48:57 +0000
From:   Paul Watson <pwatson2@wellmed.net>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] RE: git bug report
Thread-Topic: [EXTERNAL] RE: git bug report
Thread-Index: AdnG8xecm6DeBHiFQeKkAf96rNThYwABgX+AAACQyhA=
Date:   Fri, 4 Aug 2023 17:48:57 +0000
Message-ID:  <MW2PR12MB2555BB4CEE6BA6B38F4381428709A@MW2PR12MB2555.namprd12.prod.outlook.com>
References:  <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
 <015101d9c6f9$218ceb20$64a6c160$@nexbridge.com>
In-Reply-To: <015101d9c6f9$218ceb20$64a6c160$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wellmed.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB2555:EE_|SA3PR12MB8764:EE_
x-ms-office365-filtering-correlation-id: 4adbd9c3-03ee-43a5-ce7c-08db951313fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  R0jMkLS3gLRBXgIRzopyrwr0gq2K54zHDtoPYi8Tq6WhGszoWsseEiZcwf3Zs+7D2bBsYwfmUCHbZr8GPYMlNaRVygFvVB00fzQI7IasIn4fjGHNlPM+pMICMD6T2gyy26BtFGmSAiVipwy1FJP/IeYqZhWGLcYbrLvK4aBwxmQWmocje80BGepATyks3dYsIHcRAoQZYgzogBiS9rhO+ah7uCyKY6ASRclzznrMcZwpqWW+6xi4KjnHFVP6dU0bCvrJ8sXtth8h/qkCbnyk69sorwmDcd0ddlqGYRHeYw3h3Sb79pVWLfC7MS1tRuh1djAP5PNAkec2x0ts2aSrTaXdLenDr9HIWI1PLTkdCyD5wm7z7cx9wnNHDiHvU3nb62WwnjrF6ZVR9ilByRAidWn991hcRHpemxq1maI8gUZfoPwc/mjYQpvnB/EPQ/Nng8MA4/oaxz82Scc3jcs1gkSvsgXR6pnFDpHGg0ndZDOhJ1Nkv6IAS3iGVcZO1hIOr6OwcbzznE97jWjNnFyHx9yxa3SLyX3bhmyC4+NPeKyME7tyn9Yl/KiTm3jL0h+6qtv+WA67XBEA0/Ygd4tCjOboU3VbjHbFcHPcCmemxPYXs5Znc1//GP2b8ZPYimno33Q9p6JEJNYmwaa4XvbQlUPgXyV42bpRwVoIV/DsbIs=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2555.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(1800799003)(451199021)(186006)(26005)(6506007)(8676002)(2906002)(66476007)(316002)(76116006)(66946007)(5660300002)(66446008)(64756008)(66556008)(8936002)(41300700001)(7696005)(71200400001)(52536014)(9686003)(110136005)(478600001)(55016003)(82960400001)(38100700002)(122000001)(83380400001)(33656002)(86362001)(38070700005)(460985005)(134885004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WGJJNjJGSHd6WE5ST09na1htc29Xd3hhc3h2NmNZaHZoUCt6WDJyOVRNaXd6?=
 =?utf-8?B?QnJCSDgrTWhJME1laExES2RlOVdrWnVweGN5NW5pdCtZM3JrOEIybUo4Ky9N?=
 =?utf-8?B?cHN5QlplbGVNNWJSbUhsZ05xUjIydU9STGVjK1hnbWZXUW1UUkNyeEtiU0Qr?=
 =?utf-8?B?Z3lqU3d4cXJ6M1VxZXpVaVd4SzFURzc2d2FlYytiMGhvblkzSTVIN0pTd3VP?=
 =?utf-8?B?b1lJOVF1QUhiOWR1dUxoZ0JXZVlJVEpWZldNNHovVzRLam1nbFR6M21mVE5h?=
 =?utf-8?B?NnIvMHFKS2NPYUk2Y1hrdHZkcndDbUxvdEduVE5SRXZOK2ZvTXE4RG4rZWlh?=
 =?utf-8?B?UXRXbHNJaW1Vc2FJeHdobmluOTJXOFFKbFFvTDQwajlwR09FQWtuS2YxK25X?=
 =?utf-8?B?MG04ZkF0V2JPRmlmTUMrVFpmNWxyVXNxY0thVmNqdUtQdHU2UDNCNjQvcmVB?=
 =?utf-8?B?NHdHeGhrYTRLL01KaTNvcjMrZEFqNjhiVG5NMHpOdXNFc2F4bnVZRkdZUUty?=
 =?utf-8?B?UlBhWnZyK2RqN2x3OVNuR3ZhSUdlTzRQNU9BQmlmcWNmNEIzbUxDc2Y2TW02?=
 =?utf-8?B?VGVETTA1bGRkUmtVNmFUb1NtZzZ5MjQ1Q0FxbTI4V0lCRHhRMDl6Y0dNUklZ?=
 =?utf-8?B?elRSMEVVU25IUzZsOVI5YXJ0SjY5cXJHNlVxRjM2N0d6cTV6ZmNPZE1KTjE0?=
 =?utf-8?B?ajB6c1NadHkrbmc1SzRpRDc4R2lKTUZ0cExYTEhRQ2xXSjhyL2VCaWg4Q0ZW?=
 =?utf-8?B?RElpWUNHdnBCdXlPOTR3cnJseFZ6MDVOMmFlZDdFaHJ1dnBJTlJCbnB6RG51?=
 =?utf-8?B?N2VvcytIZ0ovbVNpMEhhblEzQkRoSE5LZWE5LzF3WmlvZ0VacTMrS2tUU0tC?=
 =?utf-8?B?M1ljL3czYzhoL2hPeVNFT0xPd2FsNEI0KzJhWDJsZ2FqT0ZkZkI1QU9UUU0w?=
 =?utf-8?B?dU55bVpmZTE1K3I0M2ZkUGtvcWNtVHRTVHBmSkUwQm8zWTRveS9lcVBSZEZ3?=
 =?utf-8?B?dk1HMEFrbHpGRVpvZ3M4c1dMb3p4Qk95YlhBYzBKaE93VkdydVpnZ2N5Vk1n?=
 =?utf-8?B?MEJmcXVlelJSYkhFYWtESlRxa1lJTm0vaEZTamdvZjZCdHZ5MDhHeHo2TjRQ?=
 =?utf-8?B?NVFCb0tZc2tpdnlJbmUwUjh5Unk3bWp1TnhINHMveGhlaTBkTUVMbnhKQTRG?=
 =?utf-8?B?R1FYNFlmcUd4bTMrL2pxK3FFc2xBNC9WS2Z5UHNwWnpNbGs3SjNEdUUyajdW?=
 =?utf-8?B?a1lkZ0wzME9wU2cyc1VmRGtXdklTTzdTVUpJeERmQ0wzTkZDeFhsL1pGOExX?=
 =?utf-8?B?NXFqNk1LQTRBMTdVU05uUUhTdGZJaXBtM1BqRldzNDgvZno3VFJwWDJsUmIz?=
 =?utf-8?B?bjhmOTNYMDdMT0RJdGNlNEFxVlpKWXRIZnBaN2xvMEt0VmRSUmFYZmJ6Y0dK?=
 =?utf-8?B?UmE5U2U1VlRoSE5HZSthSEE2bm1kTHcybU5sa3pOeEJJYk5sQklacGlBeU9r?=
 =?utf-8?B?L1l0VndGNGdzcklWNTJoRXlKcmFMcFJxSHludXBjSE5TNnZzNG5qZUQ4WVNO?=
 =?utf-8?B?ZUNEMkdaRnVyWTlOOHBSVkFjR3JBelRkNlc5dWQ1VXV6cjRTazU1eENhYkhl?=
 =?utf-8?B?b1N2eTBka0d1TG4zMFJqQ3JDY01CV0g4WVlQSHBaV2xJOGdXYkZMdTFybG5O?=
 =?utf-8?B?dDhQdEJXUHNMRkhia2Mwb29Qc0p1ai9pRWRZcDFlcVBpTzJYMkRuUnZDRW84?=
 =?utf-8?B?L0NPMTlVZXhPbC9YYmx1UmU2ZFZQWTlxWFhqRDQ4Z2VjVUdVRmNFb1BFOVc4?=
 =?utf-8?B?UGNLc0c5c2Zqa3F3N2dQYWRpNjhwNEtLKzhLaDdzcXJLenlQWUM5ME1vdTNo?=
 =?utf-8?B?MElLVmRMSjhXZ0JIMHp0SmNwSzVuOElKNFJmZS84YW9nLzVyeThKMHhyVFZX?=
 =?utf-8?B?R0lOZlJHd0crbE9pb1RUc2lIMnpFeW96Qk1MZ0hGUjZCb1MwSFlhQ3VFWXpx?=
 =?utf-8?B?VERmdzlwNGxSd2YwbWhJTEh5aURMYlpzSlVxY0dHZ1NwWVd5cUV3VGliRkRx?=
 =?utf-8?B?eGxRdGMzSDFDZkxRQjBWYjVrSmlmYUVpdHI3Q1VUVGVCM2pFU1N5RVlYcTFM?=
 =?utf-8?Q?m5Nklrp1d3sOeW4YwTdc7vrDl?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:       emjF7YHWJi3krTp+RkRHQvsAmLYUHohYf11Go8Af0FpY5y+NzJbltqnHk5uQ4nYW5ks3WtdDD/Y/DxPWPHEJRt9WqMEgdT+GgO18UTpuirRgVT30jkW6QghG0j5+Ar+2R+3HXGV559BINMz5lVRgBWc4EBm4peVC/WTWbEEvmBUSNh2DQR9olAQmzMxZML5IC1es4BpcFY9kOpqoY91JAboMcbRbM3c+Ee/W/GEffIJGgglwnzVQ1qu9NVa9i/1Ysm3HO0/hFlCqkqH4avLTx9iovAixCO9hSZu20MR+DExUA8lr7WdOwCIl3CIXmDWPK1I/wdc0xLDRxSIU2ZO7IAayJ+tJMJHP6NMbPhVo9F+w0NQyIU4VypnPMU/tzlzvo37SAwspzGIwjzZgMsPTwoPFeiv5Y/fQIAK/rJPsW8LfS13swiWwfw4PnjzzrZnsMruPYIOArVl3/F5DGPuG6AiFrD3/VCwtjVvmSkhIookoyZShB1T5uCzL1V1nBppkurtkAYPoU7lWIkNwR/VnRPDDAyP/tVN9pYDmL6DzaXhDmMbHVuT6AdKQRizZRQ+wv8iwNdKxrm//qJ0nOuwH82LcGhe6kJdZsQ9j1wcgh5G83+xuKzh3egAyh5B8UVWoijUvjD0o44iqmYx0b6nhJkhNrC9l8uc8xVLDIRQS3Sa2ukIedn270cq+2BvLSQmSnZoYD9JkBfsZoLi0Z2O07b4twcgZUJiL9CjDbn7u1QSD3aD3TM8y+vpzSLWvjdpGVVQ2YSJ3RNjslNm3ekj+Yg==
X-OriginatorOrg: WellMed.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adbd9c3-03ee-43a5-ce7c-08db951313fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 17:48:57.4714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 85f46a4d-265f-41b9-aaef-c494b7617e7f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cmEBndZ6gb4jW09eOKQP1AeFw21cqgMSJQd5v7Egl43uyT08hw45704DFCoYp9mK6lwaCQnfpjWjoCYhCL+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
Content-Transfer-Encoding: base64
X-IP-VFilter-R: R
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IHJzYmVja2VyQG5leGJyaWRnZS5jb20g
PHJzYmVja2VyQG5leGJyaWRnZS5jb20+IA0KU2VudDogRnJpZGF5LCBBdWd1c3QgNCwgMjAyMyAx
MjoyOQ0KDQo+PiBDYW4geW91IHJldHJ5IHRoaXMgd2l0aG91dCAtLXNob3J0c3RhdCBzbyB3ZSBj
YW4gc2VlIHdoYXQgZ2l0IGlzDQo+PiByZXBvcnRpbmcgYXMgYSBkaWZmZXJlbmNlLg0KDQpUaGUg
cHJvYmxlbSBhcHBlYXJzIHRvIGJlIHRoZSB1c2Ugb2YgLS1zaG9ydHN0YXQuIFdoZW4gLS1zaG9y
dHN0YXQgaXMgbm90IHVzZWQsIHRoZSBleGl0IGNvZGUgZm9yIGRpZmZlcmVudCBmaWxlcyBpcyBv
bmUgKDEpLCBhcyBleHBlY3RlZC4NCg0KMTI6NDY6NTYuODggMjAyMy0wOC0wNCAgQzpcc3JjXHRc
c2NyaXB0cz5UWVBFIHQxLnR4dA0KdGhpcyBpcyB0MS50eHQNCnRoaXMgaXMgdDEudHh0DQp0aGlz
IGlzIHQxLnR4dA0KDQoxMjo0NzowMS44OCAyMDIzLTA4LTA0ICBDOlxzcmNcdFxzY3JpcHRzPnR5
cGUgdDIudHh0DQp0aGlzIGlzIHQyLnR4dA0KdGhpcyBpcyB0Mi50eHQNCnRoaXMgaXMgdDIudHh0
DQoNCjEyOjQ3OjA2LjQxIDIwMjMtMDgtMDQgIEM6XHNyY1x0XHNjcmlwdHM+IkM6XFByb2dyYW0g
RmlsZXNcR2l0XGNtZFxnaXQuZXhlIiBkaWZmIC0tZXhpdC1jb2RlIC0tbm8taW5kZXggIC0taWdu
b3JlLWFsbC1zcGFjZSAtLXNob3J0c3RhdCAuXHQxLnR4dCAuXHQyLnR4dA0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCjEyOjQ3OjE4LjIyIDIwMjMt
MDgtMDQgIEM6XHNyY1x0XHNjcmlwdHM+RUNITyAlRVJST1JMRVZFTCUNCjANCg0KMTI6NDc6MjAu
NjEgMjAyMy0wOC0wNCAgQzpcc3JjXHRcc2NyaXB0cz4iQzpcUHJvZ3JhbSBGaWxlc1xHaXRcY21k
XGdpdC5leGUiIGRpZmYgLS1leGl0LWNvZGUgLS1uby1pbmRleCAtLWlnbm9yZS1hbGwtc3BhY2Ug
Llx0MS50eHQgLlx0Mi50eHQNCmRpZmYgLS1naXQgYS8uL3QxLnR4dCBiLy4vdDIudHh0DQppbmRl
eCA2ZGZiODg0Li42NjgxMmM1IDEwMDY0NA0KLS0tIGEvLi90MS50eHQNCisrKyBiLy4vdDIudHh0
DQpAQCAtMSwzICsxLDMgQEANCi10aGlzIGlzIHQxLnR4dA0KLXRoaXMgaXMgdDEudHh0DQotdGhp
cyBpcyB0MS50eHQNCit0aGlzIGlzIHQyLnR4dA0KK3RoaXMgaXMgdDIudHh0DQordGhpcyBpcyB0
Mi50eHQNCg0KMTI6NDc6MjcuNzEgMjAyMy0wOC0wNCAgQzpcc3JjXHRcc2NyaXB0cz5FQ0hPICVF
UlJPUkxFVkVMJQ0KMQ0KDQoxMjo0NzozMC4zMiAyMDIzLTA4LTA0ICBDOlxzcmNcdFxzY3JpcHRz
PiJDOlxQcm9ncmFtIEZpbGVzXEdpdFxjbWRcZ2l0LmV4ZSIgZGlmZiAtLXF1aWV0IC0tZXhpdC1j
b2RlIC0tbm8taW5kZXggLS1pZ25vcmUtYWxsLXNwYWNlIC5cdDEudHh0IC5cdDIudHh0DQoNCjEy
OjQ3OjM2LjU4IDIwMjMtMDgtMDQgIEM6XHNyY1x0XHNjcmlwdHM+RUNITyAlRVJST1JMRVZFTCUN
CjENClRoaXMgZS1tYWlsLCBpbmNsdWRpbmcgYXR0YWNobWVudHMsIG1heSBpbmNsdWRlIGNvbmZp
ZGVudGlhbCBhbmQvb3INCnByb3ByaWV0YXJ5IGluZm9ybWF0aW9uLCBhbmQgbWF5IGJlIHVzZWQg
b25seSBieSB0aGUgcGVyc29uIG9yIGVudGl0eQ0KdG8gd2hpY2ggaXQgaXMgYWRkcmVzc2VkLiBJ
ZiB0aGUgcmVhZGVyIG9mIHRoaXMgZS1tYWlsIGlzIG5vdCB0aGUgaW50ZW5kZWQNCnJlY2lwaWVu
dCBvciBpbnRlbmRlZCByZWNpcGllbnTigJlzIGF1dGhvcml6ZWQgYWdlbnQsIHRoZSByZWFkZXIg
aXMgaGVyZWJ5DQpub3RpZmllZCB0aGF0IGFueSBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24g
b3IgY29weWluZyBvZiB0aGlzIGUtbWFpbCBpcw0KcHJvaGliaXRlZC4gSWYgeW91IGhhdmUgcmVj
ZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlDQpzZW5kZXIgYnkg
cmVwbHlpbmcgdG8gdGhpcyBtZXNzYWdlIGFuZCBkZWxldGUgdGhpcyBlLW1haWwgaW1tZWRpYXRl
bHkuCg==

