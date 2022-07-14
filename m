Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E3CCA47B
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 20:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbiGNUGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbiGNUGH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 16:06:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2040.outbound.protection.outlook.com [40.92.40.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA496759B
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 13:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTuzyCd34qXArVTX3DLkkOGhjgcoKVN6UTlrfSooXwUCGsNnSOVxOA45ylEFHdLGrPF47K51J3YfLt12ArG+YgNIH9QvxndFbTyMrz6FKHp0eImWG2vcxOa9YoATAOJhF4Y7qeTYT0Uw3XU3Tk2EygBqNxPE2dEQBGzwNYMLMgjw/3lCM3pWbT4Y+KZjhKjUOq3MYbT3aNlPxJ3MEk1hvJNuGtdUWB3smOaa3Ckp2fLKdTJgq4wG60KYIFjd6a/3/DApF9MQbJ0TMRveCJg/1GGQbb6kGtFrp8QQ1xjRIDk5UAuP4nFDI7F/1KvFoQyk/0WmUDlcyDjrWa9+eas/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXqvc1EOanbWaMsJiXCxs3cAUIbDJCUB4moldZT+V7w=;
 b=FSm5mQXAC9OhPjAiT0Qag3oly3+2WDoeqSjd+sySx2L4nZobweG/j1oLccKgvxyqsFr3ryYZeqfokyCZcHX24G1UugqrXdS4C2vLBCGI0xMrhekhJX6g1dsn9KWB5i87AoLNdfmekXAgGynuuPRimaD3SDFwhpOuBO0cFOPMHVwAqTAd8gvXzKVZnrHBl0NZOMRM0fgyfDiXmgz9XjzQa1cYXHNirTlZhxLlyK/KSc00QdOwXJ903qs+keQjCn6oy0VQFYwp+HeeLXRfQ2o4cIoFVzYz++Syts+1DUiwiUSWah+COKXnBt2nk/yBSyBREXBGW0hY2VV93hh2jcTO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXqvc1EOanbWaMsJiXCxs3cAUIbDJCUB4moldZT+V7w=;
 b=bJghJHfmT+aUxRvt/VlJXd6t/a8y2XHKGqrgxTeWs4AbazFdBWrOo48zFRIh5nEZh2ezObADdMm4jI3GWCRW+hL7ev/04xJKDyAMw2uwupFEWHYas8/M5gOokRVjwYD+FCjaTGGH9Qbh7hl+KzC4P80tucO4H1OQYVBUE809oESF4WHq/RYqjsvAG05KxyEvACeXsgxEMakGacEgCLznXRLUL0VvZ2CKvQpu1Hw7FLUD0UfmEtv1eHEX4CvbFDDDsbCwePZZM2zvJFPVapM1pM54+TO9Y36ARdxw0ZJg35pddX2pUgZZklUBcmuimpnZIssk6ynoLdsa/Zz503e0Eg==
Received: from BL0PR13MB4275.namprd13.prod.outlook.com (2603:10b6:208:8b::19)
 by DM6PR13MB3547.namprd13.prod.outlook.com (2603:10b6:5:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11; Thu, 14 Jul
 2022 20:05:46 +0000
Received: from BL0PR13MB4275.namprd13.prod.outlook.com
 ([fe80::c4ba:901e:67e5:fffa]) by BL0PR13MB4275.namprd13.prod.outlook.com
 ([fe80::c4ba:901e:67e5:fffa%5]) with mapi id 15.20.5438.011; Thu, 14 Jul 2022
 20:05:46 +0000
From:   fawaz ahmed0 <fawazahmed0@hotmail.com>
To:     Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "reject arguments in cone-mode that look like patterns" doesn't
 work in macos-12
Thread-Topic: "reject arguments in cone-mode that look like patterns" doesn't
 work in macos-12
Thread-Index: AQHYl1asm/9hwI5XDUaHZeKUJukpba19gMgwgAC9pICAAAHdSYAABikAgAADA+s=
Date:   Thu, 14 Jul 2022 20:05:46 +0000
Message-ID: <BL0PR13MB42753E6FEFE67713F0EB0895F1889@BL0PR13MB4275.namprd13.prod.outlook.com>
References: <BL0PR13MB42750BC5C4837B7B0BD1885EF1889@BL0PR13MB4275.namprd13.prod.outlook.com>
 <BL0PR13MB427533B25CCFE6A37F7619E8F1889@BL0PR13MB4275.namprd13.prod.outlook.com>
 <4f4d5d03-2a0d-19c1-fd2e-80ab86aa1145@github.com>
 <BL0PR13MB427538CEAD5481CCBF6D195DF1889@BL0PR13MB4275.namprd13.prod.outlook.com>
 <a1580785-e35c-9a2d-7fa1-c3d7fc62883b@github.com>
In-Reply-To: <a1580785-e35c-9a2d-7fa1-c3d7fc62883b@github.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [MXaCYYTKPakEJGkbFI72X2l1Ma8bDQLh]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 257ece9c-9b66-4e4e-7566-08da65d43d7b
x-ms-traffictypediagnostic: DM6PR13MB3547:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OXpmTLRhrpjsyZJ20di1Gr1RRi36GtWRdTzY3WveLVk8/N25286RQws2I+nbL3mnKUZ3PoHeZQi6QJ7goIR145n9fqYfS1f9LYDJaWy1cGDsUhUQsUWYdHvmhHUMsPJlUVc28+q923/+lWlifOqFoyPiwDlwDIQxoVw203iONSLNze0yDHSqSV9+tzSxk6d7Y1BcORE4fPTWSBB7yWICXCBDdPYXCgXnBorWj+JSXvWPYnUeugj/vui0j4PgnLNHogck30TFAnlkT7lV7bUWu0t8GtxlnEbnTTZSU7nPwkZasuRoi28K0hGVORHRpjBkyhC1StB4OMR7tT96Xs2DhzkWdseiX8WI9NHmVwMlxb3qYAohTTqnMhvCDx2pXhxETjlxURqf/rP1gk7dQb548hbnwJraXQY87pqkUDPmQ7ErJr/zBsEHMQH2JHB+l6fy3S4NiQt71ef7IfoRsF4bBUukmBaJt9pa8H/XupeKdrlGBE7ie6vsTady0xlhDmC8zRkrcsIh/UmfuQ7wFuo2QsI7yatkQ8qZ/mfenTArDczuXyY90DFRhRYfAvmHT/OO2XwXNJ6rKdpnn6ZhzCCjrTloDw3B9++VPbUkgUrSSosbswQ1xCQ/hKu4KHJVbxcVG9j14L4I8UWtgKLPdnnFI4iBna4JFTsYjKGMjyQHgOIe8HnEslw3HnzlxmX7EAT+8VLSTDkWY3DN2ZlVIVX9TJJ6Q8UyY7cc6nl5Yh7sXj3N+YcQb8MbS8AdovnVlB132p6W51mliupBEhllhPZYjA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PqGHm5REdUudgycypI4fxBvnp9PGGFjJ+03MLpVmWrQAnMANJMwuqpPhXQ?=
 =?iso-8859-1?Q?vzycJPIVDtPRD6au56nlrupywx4COuIXhQ5CzbVpCxLvbaOf/hio0P/gF+?=
 =?iso-8859-1?Q?BccFgkN+ONePltGvc9DM/GaWpslg2CvXxABrUZXr/6vrCBNtmbSM+sMd3R?=
 =?iso-8859-1?Q?9iMl4v0jaa/IlfsitGJZNwOpEkP6FNajHcWIST/KC36Y3Eiv7B4gGfrKHH?=
 =?iso-8859-1?Q?CSz3Emcc2Jqw7u86ipWf2RBMbqdloPylIzCk7QgrE+DH7IoGiBS1+IQfM6?=
 =?iso-8859-1?Q?QksMX401rQtiOfB+omRspAhJo1z2Rd9/6e4WPCXX2C38ZC/bJl/LKEaOYI?=
 =?iso-8859-1?Q?5mDZH/hrqTPHrS4Ucc4oYbqLRK9yY1mEs/VCcpqYdsrVZxOSp6OAe0hMKD?=
 =?iso-8859-1?Q?1XwRUfObbxYDw9v+zdtYjFAkCaLBA3qEU1PnbPE0ObNw2Ifmeic9hClb12?=
 =?iso-8859-1?Q?abjUI2xueSJ9JqsnX76JJOGh1emBhXeUbH1b0YeIsryxScRjcvFeJcJVkl?=
 =?iso-8859-1?Q?SitP21cfQPgxYHSmxY+izLAFZOokudJH54J+8J5m/wE3au1JJh8dqiNa5p?=
 =?iso-8859-1?Q?ozKadJXTDViGS1d2jiEoLyHStU1KWxPoeVQUMBtQXFSnTwYvgLqdpc03Eb?=
 =?iso-8859-1?Q?x0B/0GCennnPj7tNjE0oCvYwT5x8blS+zZkYbZ5pBq0FoaDSlokbR/tq0k?=
 =?iso-8859-1?Q?5yDsRDdprFNtK4dcakTIPK+Oun9oEvVYKpPvytF7aj98z46MpCtyTp3ErX?=
 =?iso-8859-1?Q?QIgGx/6hLK8qJSCkVRix05slOL9Bb1HYITPO83sqdUqKXjY05+ccqLPkM4?=
 =?iso-8859-1?Q?osIViGQVPNmKAW0A7ZVg/RcxXSo0B/6f13EM+axu+IEyiYejcD+ASPTz90?=
 =?iso-8859-1?Q?lejSnZXBLVe7z5PKtnqNrr+SiC2E8w+ZgFqY/P0J2BAuB1BBeH6YmFeOJy?=
 =?iso-8859-1?Q?YidQaZ9jVosMWfx8o4OgRE09Zy7/W2WQIAYtPGvqmhvuO1rxw1DjQrzZst?=
 =?iso-8859-1?Q?jI1N/sZQENuEUkoJZlF92ABJyR5dsnddDoAMBMI4nAcvVgawBrTeZfuN0l?=
 =?iso-8859-1?Q?Y1anAPbGcLvrbmRVsgYRDw+q6J1WIa8DMn6F+AvoNo/AYX9Td+XIzG896z?=
 =?iso-8859-1?Q?/833kUypgfZzAJrAuq4gKTi/uiZ5LWvVAPR4me7iPIIeqzEgEEI1rlWCQU?=
 =?iso-8859-1?Q?zZbZmt1PxXZ6eZUgIk9ZjUIOsPA3N+Q9xIZ4EO9HsCe0AW2FpO3hdfldFZ?=
 =?iso-8859-1?Q?oqyRvA0Yq7Kxp2qdP1HWFzzA7PkZAdP3tfuqRH96CY2EiJD3oCA5cS9nUq?=
 =?iso-8859-1?Q?A+jd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4275.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 257ece9c-9b66-4e4e-7566-08da65d43d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 20:05:46.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3547
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=0A=
=0A=
> Per the virtual environment specification [1] linked in the runner execut=
ion=0A=
> [2], the Git version used on these agents is 2.36.1. =0A=
=0A=
> [1] https://github.com/actions/virtual-environments/blob/macOS-12/2022062=
7.3/images/macos/macos-12-Readme.md=0A=
> [2] https://github.com/fawazahmed0/currency-api/runs/7312663698?check_sui=
te_focus=3Dtrue#step:1:11=0A=
=0A=
Sorry, I didn't know that every runner has it's own specification, I was ac=
tually referring the updated page:=0A=
https://github.com/actions/virtual-environments/blob/main/images/macos/maco=
s-12-Readme.md#:~:text=3D7.84.0-,git%202.37.0,-Git%20LFS%3A%203 =0A=
=0A=
Maybe I should have manually checked the git version in runner, before fili=
ng this bug. =0A=
Thank you for looking into this.=
