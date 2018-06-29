Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CCC1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936866AbeF2QMi (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:12:38 -0400
Received: from mail-sn1nam01on0136.outbound.protection.outlook.com ([104.47.32.136]:36379
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936537AbeF2QMh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdlpqhzP/A1UI6J33dHlC/v46YuuLsTvQdw5S2/8B8g=;
 b=hhxqNogMTRVlyXA7t2ad8xclCj7ujwDEdmgRnrzE3nD2b+f0QMQeAN/g8uDjdLc9aGJHfmBdp9aKGIIIF13KNd+dDmsKMHs6wK4phBRsWHSrZCu/3PxWe5iB517uA+35vQ5cjgN9k/moPzyc2cANvU84qIJfKZEs6kkInfqmJt4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1044.namprd21.prod.outlook.com (52.132.24.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Fri, 29 Jun 2018 16:12:35 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:12:35 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 00/13] Consolidate reachability logic
Thread-Topic: [RFC PATCH 00/13] Consolidate reachability logic
Thread-Index: AQHUD8P9hmH1sA8coEOu6ZFlT+6CBQ==
Date:   Fri, 29 Jun 2018 16:12:35 +0000
Message-ID: <20180629161223.229661-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:406:80::39) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1044;7:wmX5IohKCbY98Wq+ftsJVNMTv9QwVJnGPJOQ4+FE5+E67FL0UWbTZvpPz77huup8xo8mAPzBCUq7izFy1weWbohXaO8Jzhe/e7kCr+QoKiC5KwQST8yew3UbJTImKmGDZotglvMPYt0pwO+eWwnJP7BGeiy8kzNVaZwdW6Bh4sDjZBV3gH3z2uFyAixiHv4TgmpMPGGILUtq58x1R+ROPaqs4nEjrn3TH1R15P+saurwObVWYANUiJYi6ZwBmoLk
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2737d15d-532b-4644-afcf-08d5dddb201e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB1044;
x-ms-traffictypediagnostic: BL0PR2101MB1044:
x-microsoft-antispam-prvs: <BL0PR2101MB10444CE2BC8471A7A1B8C3F8A14E0@BL0PR2101MB1044.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231270)(2018427008)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1044;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1044;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(305945005)(316002)(68736007)(36756003)(476003)(107886003)(97736004)(2900100001)(106356001)(46003)(105586002)(5640700003)(14454004)(5660300001)(6436002)(54906003)(4326008)(6916009)(39060400002)(86612001)(86362001)(6116002)(2351001)(486006)(99286004)(256004)(25786009)(478600001)(1730700003)(1076002)(52116002)(8936002)(10290500003)(53936002)(22452003)(2616005)(81166006)(81156014)(6346003)(186003)(386003)(8676002)(2501003)(10090500001)(2906002)(5250100002)(6512007)(102836004)(6506007)(6486002)(7736002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1044;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 8jTR3vkMg1AHaSui8cTkntBr8DUJS7wUiGATEDJyI5GwuLY0Da8zENtad7ENey4qkkGxYIFjdnuBeL28m1UBnjRNt57NFm3/6JDejryI3nzBreGtDEgHRY2/JKAWpiWMNEf7z2nRiqopUMIiPMBpIXzfy+akV9xivnZDWL2GJBcLmykw1P2urXlo02sypWRZZbLBCoqray6FseWwX7tEQKnXTn47Swk3AG4yizdLErGV1BBNyhX5ft6GgOOhPI7iLg1fnm3GnlliX0q7/+4nkN606VI2vgbFcLpyXZ+3c598f8ShcEWyd7r2kAz+GNY2FqhGAceew0BhqeJo6Bc8KpD85xN80s7TFr0kEa6JL5o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2737d15d-532b-4644-afcf-08d5dddb201e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:12:35.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1044
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC is a bit unpolished because I was mostly seeing where the idea
could go. I wanted to achieve the following:

1. Consolidate several different commit walks into one file
2. Reduce duplicate reachability logic
3. Increase testability (correctness and performance)
4. Improve performance of reachability queries

My approach is mostly in three parts:

  I. Move code to a new commit-reach.c file.
 II. Add a 'test-tool reach' command to test these methods directly.
III. Modify the logic by improving performance and calling methods with
     similar logic but different prototypes.

The 'test-tool reach' command is helpful to make sure I don't break
anything as I change the logic, but also so I can test methods that are
normally only exposed by other more complicated commands. For instance,
ref_newer() is part of 'git push -f' and ok_to_give_up() is buried deep
within fetch negotiation. Both of these methods have some problematic
performacne issues that are corrected by this series. As I discovered
them, it was clear that it would be better to consolidate walk logic
instead of discovering a new walk in another file hidden somewhere.

For the ok_to_give_up() method, I refactored the method so I could pull
the logic out of the depths of fetch negotiation. In the commit
"commit-reach: make can_all_from_reach... linear" I discuss how the
existing algorithm is quadratic and how we can make it linear. Also, we
can use heuristic knowledge about the shape of the commit graph and the
usual haves/wants to get some extra performance bonus. (The heuristic is
to do a DFS with first-parents first, and stop on first found result. We
expect haves/wants to include ref tips, which typically have their
previous values in their first-parent history.)

The "test-reach" commit in particular is not split well or described
well for mailing-list review. I figured I would send the RFC instead of
tweaking it carefully, because I will need to re-do most of these
changes after more of the object-store series is merged. I don't plan to
send a v1 patch until the lookup_commit() and parse_commit() code is
stable again.

Thanks,
-Stolee

Derrick Stolee (13):
  commit-reach: move walk methods from commit.c
  commit-reach: move ref_newer from remote.c
  commit-reach: move commit_contains from ref-filter
  upload-pack: make reachable() more generic
  upload-pack: refactor ok_to_give_up()
  commit-reach: move can_all_from_reach_with_flag()
  test-reach
  test-reach: test reduce_heads()
  commit-reach: test can_all_from_reach
  commit-reach: test is_descendant_of
  commit-reach: make can_all_from_reach... linear
  commit-reach: use is_descendant_of for ref_newer
  commit-reach: use can_all_from_reach

 Makefile              |   2 +
 builtin/remote.c      |   1 +
 commit-reach.c        | 656 ++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h        |  37 +++
 commit.c              | 365 +----------------------
 commit.h              |   6 +-
 fast-import.c         |   1 +
 fetch-pack.c          |   3 +-
 http-push.c           |   1 +
 ref-filter.c          | 147 +---------
 remote.c              |  48 +---
 remote.h              |   1 -
 sha1-name.c           |   3 +-
 t/helper/test-reach.c | 128 +++++++++
 t/helper/test-tool.c  |   1 +
 t/helper/test-tool.h  |   1 +
 t/t6600-test-reach.sh | 177 ++++++++++++
 upload-pack.c         |  58 +---
 walker.c              |   3 +-
 19 files changed, 1035 insertions(+), 604 deletions(-)
 create mode 100644 commit-reach.c
 create mode 100644 commit-reach.h
 create mode 100644 t/helper/test-reach.c
 create mode 100755 t/t6600-test-reach.sh


base-commit: d4f65b8d141e041eb5e558cd9e763873e29863b9
--=20
2.18.0.118.gd4f65b8d14

