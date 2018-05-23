Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5AA71F42D
	for <e@80x24.org>; Wed, 23 May 2018 14:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933264AbeEWOrc (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 10:47:32 -0400
Received: from mail-by2nam03on0091.outbound.protection.outlook.com ([104.47.42.91]:56080
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933149AbeEWOrb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 10:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEiK03xWoU/LdXRfx/ff4dpNHch790BzNyz9haI9AfY=;
 b=GxTJ8FsYN8CYiFVTcohzDZ4xgb/s/MnG8r/igFvufDkKnTBnBznPKM23jS2y1fXdp/MpOFAXXnrlRg45c7O7oBrNlQgCs+gdI/vu4Piun1vp96sqVN2BIRu7kp5rdc1iQ7rrukR8e0Poz8s8ncaKNFU6p74AJwEHsllM13X9ia0=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0900.namprd21.prod.outlook.com (52.132.23.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.2; Wed, 23 May 2018 14:47:29 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::89b8:b210:812d:c7a0%4]) with mapi id 15.20.0797.007; Wed, 23 May 2018
 14:47:29 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v3 0/7] allocate cache entries from memory pool
Thread-Topic: [PATCH v3 0/7] allocate cache entries from memory pool
Thread-Index: AQHT8qT4yabJZ/7WG0WRtFmcJ5diXQ==
Date:   Wed, 23 May 2018 14:47:29 +0000
Message-ID: <20180523144637.153551-1-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
In-Reply-To: <20180417163400.3875-1-jamill@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010:1:1060:bd2c:4297:50e]
x-clientproxiedby: BN6PR1801CA0033.namprd18.prod.outlook.com
 (2603:10b6:405:5f::46) To BL0PR2101MB1106.namprd21.prod.outlook.com
 (2603:10b6:207:37::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0900;7:ul15QNuZSY8/hf7bC9crUkrVPpE8pHmWp7EbsHT+xvhP6042L1jpSBn17N3XbXlo+MiWCB0+1WausMEi2Gb+jayLKzBtKhgEENFj3pZhWmhvki7I2s28TYQjwTbjp5g0FabW9M8KNnFONPGnY4hF6XY/r8QvxKPN/SmSjULWEQX/ABZLbWtdmR7GKYsPagkBrj7VrfOAFoq9uHiuKEFV/90O8HswAnTAkUnNV4regd+XTjxawgr7/rNnhnQxsfDF;20:j4BUN9XVadJDZ+ZoxEnIWlbwoxKeAAwVAeXJI6BAk6g8QoKk4Ebwzi1EdmvaXC4hB2qHTn8k6/8Pv0kCIlAWEKPfS6fiEgFv+51wTHE5MutfwZOqFg/N7c/XlmU4+HqR8C7dcKKYs7EAxANQlGqxUA9kEwHv2NyQTgd/mMBKanE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0900;
x-ms-traffictypediagnostic: BL0PR2101MB0900:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0900801557E1A43CAE9AC807CE6B0@BL0PR2101MB0900.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0900;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0900;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(346002)(376002)(39380400002)(199004)(189003)(86362001)(2900100001)(105586002)(106356001)(25786009)(10090500001)(6486002)(5640700003)(6436002)(2351001)(86612001)(107886003)(478600001)(39060400002)(10290500003)(4326008)(14454004)(6512007)(53936002)(8656006)(99286004)(52116002)(76176011)(7736002)(305945005)(316002)(54906003)(22452003)(36756003)(5250100002)(102836004)(6506007)(386003)(59450400001)(46003)(2616005)(11346002)(446003)(476003)(486006)(186003)(2501003)(2906002)(68736007)(8936002)(97736004)(3280700002)(3660700001)(6116002)(6916009)(81166006)(1730700003)(8676002)(81156014)(5660300001)(1076002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0900;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oLV0aDgPzbhCsY4/tZEvzFsxWbXM+zM5iMyu/SrAsxyJ1bRYBst0x3Dny9XoZNwX/vd6964lSLEZHDepKtiSXPJI48Lq0gG+RZVfS6Y3IB935ch3ORqUp7GyhltIIU5FNtuuiu6HJ2aurPMLikLZT8/CHXqTBZyE+NCyByHJaEHcE6wVri6ordhbwXzUxzqz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a00c9ad5-2f66-40ad-a6a3-08d5c0bc1ac4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00c9ad5-2f66-40ad-a6a3-08d5c0bc1ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 14:47:29.1182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0900
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from V2:

	- Tweak logic of finding available memory block for memory
          allocation
=09
	  - Only search head block
	 =20
	- Tweaked handling of large memory allocations.
=09
	  - Large blocks now tracked in same manner as "regular"
            blocks
	 =20
	  - Large blocks are placed at end of linked list of memory
            blocks

	- Cache_entry type gains notion of whether it was allocated
          from memory pool or not
=09
	  - Collapsed cache_entry discard logic into single
            function. This should make code easier to maintain

	- Small tweaks based on V1 feedback

Base Ref: master
Web-Diff: git@github.com:jamill/git.git/commit/d608515f9e
Checkout: git fetch git@github.com:jamill/git.git users/jamill/block_alloca=
tion-v3 && git checkout d608515f9e


Jameson Miller (7):
  read-cache: teach refresh_cache_entry() to take istate
  block alloc: add lifecycle APIs for cache_entry structs
  mem-pool: only search head block for available space
  mem-pool: add lifecycle management functions
  mem-pool: fill out functionality
  block alloc: allocate cache entries from mem_pool
  block alloc: add validations around cache_entry lifecyle

 apply.c                |  26 +++--
 blame.c                |   5 +-
 builtin/checkout.c     |   8 +-
 builtin/difftool.c     |   8 +-
 builtin/reset.c        |   6 +-
 builtin/update-index.c |  26 +++--
 cache.h                |  53 +++++++++-
 fast-import.c          |   2 +-
 git.c                  |   3 +
 mem-pool.c             | 116 ++++++++++++++++++++--
 mem-pool.h             |  25 ++++-
 merge-recursive.c      |   4 +-
 read-cache.c           | 261 ++++++++++++++++++++++++++++++++++++++++-----=
----
 resolve-undo.c         |   6 +-
 split-index.c          |  58 ++++++++---
 tree.c                 |   4 +-
 unpack-trees.c         |  38 +++----
 17 files changed, 514 insertions(+), 135 deletions(-)


base-commit: ccdcbd54c4475c2238b310f7113ab3075b5abc9c
--=20
2.14.3


