Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A4CA1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 12:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbeG0OVe (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 10:21:34 -0400
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:27072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728384AbeG0OVd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 10:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8nxX/RtdXSKFD4wSZltBcfRhtv92lerYZgiIyjfLL8=;
 b=d7Q0HDDnNbA8QjYpfApEvRGFUM8+YA3PyoqzMwlvNAofukTWDfD2oZE6EMzEbnipoYcr8mPodtfLyZOMDihLOqYpH6fuSf5yioEYDUjE04o0p9KsfVO5tN2HGFtEErsNDPya5zJurhfTc4dDE25efxga6eBnnmytrGxcOfVaZ4o=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1131.namprd21.prod.outlook.com (52.132.146.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.2; Fri, 27 Jul 2018 12:59:41 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::c945:950:24b2:65cd]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::c945:950:24b2:65cd%4]) with mapi id 15.20.1017.000; Fri, 27 Jul 2018
 12:59:41 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "peartben@gmail.com" <peartben@gmail.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>
Subject: [PATCH v2 0/2] Preserve skip_worktree bit in merges when necessary
Thread-Topic: [PATCH v2 0/2] Preserve skip_worktree bit in merges when
 necessary
Thread-Index: AQHUJamuONs8CP10U0OWSqKQEUmjWw==
Date:   Fri, 27 Jul 2018 12:59:41 +0000
Message-ID: <20180727125923.11744-1-benpeart@microsoft.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
In-Reply-To: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.gvfs.1.123.g449c066
x-clientproxiedby: DM5PR12CA0015.namprd12.prod.outlook.com (2603:10b6:4:1::25)
 To MW2PR2101MB0970.namprd21.prod.outlook.com (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1131;6:+Fcwnq2+NEYat3pNdlH6if29pzoAxfiiz/+vbw801oviM0t3BK462Afn1AEdmt2hWTawQb1qWcwgmBAJMU9cfl1kVE4AxfI/YkXLdh8wUpjfFNhDD5UuXVulusxpHqgi1/Df0/fFflCxR9yF557n5oyfn0OsBHBwtrJeEQG/++G1Zx47l75Fc+Nu3L4mEAXmHixT2ithWScq8SLy4ORNcZcD+C2tErvuAIW/ph94RBdc4aIIah9yPY/iU20dJNSBb9TBmWWNH96iC3sXiRzvj00XqVeEWCnpvRu4l0J2ScQXuzoHi/8NpJaqHjrYUT5alOqCVhmY8A+IE6ILkA+9vQyJGj/JX66uRVH4heoXTA4L65zErk7QLZfSDdryA2rwLmhSLwOdtzVTbL+9hpoyzwOsHLKL6JDOH8cvsoh8ItvPiBQ301oUob+xp6n/ZZXzJr0KJV4X5B+bsmzPH0YK8w==;5:kYKDUizjOdStKFVL41WTgqyXwwVT6V8PR60gCcRVeKJTaZex1jh+Dl07IuBOQlfe52zeqF14tIr1WZ3qcakzJf01bPmPMfsFbykQJvOm7943vruJbmc7CLkXbaJzKsDpODEPJI9+DmQCCqF6a41jF8znYOFQ+tRr/7dz5j7CcsQ=;7:xThtX7eYgq3CtEUs3ev1LS/LNcwJvXHPIsvJlcAJ+Veb3c6qi+wqdiiAI4ldL2+KDJcKKHGsxLY/4zDDzCg0opk23GFVEl35b/JN2qMo1Z0j8Tj0spsFpyYp7Hf/LJ5CbrnX/GYwLolPOoKEY8VArVsCcxUDYDvdi96naw6XyZgsTjkepwRMbZNRLBI+DAQkeZX9WDc1mBzynf418BDBozs/Ghnq8fvsgTiN4DUs4DVOJXy40eGQtOpfj8h56O4e
x-ms-office365-filtering-correlation-id: c2090d86-0d21-48e6-6c83-08d5f3c0d0f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1131;
x-ms-traffictypediagnostic: MW2PR2101MB1131:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB11315572936C8321416CA687F42A0@MW2PR2101MB1131.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1131;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1131;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(99286004)(1361003)(476003)(446003)(25786009)(186003)(5250100002)(14444005)(4326008)(256004)(54906003)(2616005)(486006)(26005)(52116002)(6916009)(11346002)(39060400002)(81166006)(81156014)(86612001)(8676002)(66066001)(53936002)(5640700003)(6512007)(5660300001)(1411001)(386003)(76176011)(102836004)(7736002)(6486002)(575784001)(6306002)(305945005)(6506007)(1730700003)(8936002)(97736004)(6116002)(316002)(105586002)(106356001)(14454004)(72206003)(2351001)(10290500003)(68736007)(966005)(3846002)(2501003)(22452003)(2906002)(10090500001)(478600001)(36756003)(50226002)(1076002)(2900100001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1131;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4Yr5e39lGDDsgrQDtyOKvmvRAHzNTgRh9itB82tMgrVc6yreGeY41EOPMvy22IPXm9dLqzrlpLVCcbQ/pN1sPRtV9TkWOdI4tvFtGehH38TyYDWGPSbSGGyOSKMvNHI2PBxJMkJSX3OJmrLHxLm8gCOQgkjKwBKnkq/+jb/nAzVlT8rs2KHhQMyowxVZlCUSSME5891MROpy7bJBxwzSdnsWOk5+u3YMH+UZlhmt9kGhSqjbjbsAwQmBmLlXd86j8xjJ+ZKOw6TO1UCCs0A+mNuPJwBGqXgq4BBQAW8ZTKgtSNnXfqGftsgtgojV6Tuv6a7ZZ1ftXG7Mo0yCQNfKNpiUXMBSObMyVi91i4MWNAE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2090d86-0d21-48e6-6c83-08d5f3c0d0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 12:59:41.5505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sending this update as Elijah is on vacation.  This only updates the test
case based on feedback from the list.

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/0ab3816d61
Checkout: git fetch https://github.com/benpeart/git merge-recursive-v2 && g=
it checkout 0ab3816d61

### Patches

Ben Peart (1):
  t3507: add a testcase showing failure with sparse checkout

Elijah Newren (1):
  merge-recursive: preserve skip_worktree bit when necessary

 merge-recursive.c               | 16 ++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 13 +++++++++++++
 2 files changed, 29 insertions(+)


base-commit: ffc6fa0e396238de3a30623912980263b4f283ab
--=20
2.17.0.gvfs.1.123.g449c066


