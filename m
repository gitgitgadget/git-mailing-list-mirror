Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155101F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeDJSOx (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:14:53 -0400
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:60922
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751367AbeDJSOv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wiWyV20YeKDEtyLSZ1OsLK4Ol4JTW2xvrG00lwKfprU=;
 b=cjaw2F8MXhDe8yh6rolx3/QFV8wR9QaQSQiwQJ53CJbhxWEsQjkpTsUlZvHvMSBz2w25NiPA36/UKhezMlOHwchUD/5uCT0lA5jJssXAl9ylU5rCKn0IBxJWw1RgAHfr7vlF3rB4aPG3qvbL91lLEKYjfS1LWYKHFP2Imz45Kwo=
Received: from localhost.localdomain (70.33.148.227) by
 DM5PR2101MB1013.namprd21.prod.outlook.com (2603:10b6:4:a8::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Tue, 10 Apr 2018 18:14:48 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org, gitster@pobox.com, alexmv@dropbox.com,
        avarab@gmail.com, johannes.schindelin@gmx.de
Cc:     Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1] fsmonitor: force index write after full scan
Date:   Tue, 10 Apr 2018 14:14:31 -0400
Message-Id: <20180410181431.21024-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.16.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [70.33.148.227]
X-ClientProxiedBy: BN4PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:403:2::26) To DM5PR2101MB1013.namprd21.prod.outlook.com
 (2603:10b6:4:a8::35)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1013;3:jAJVSbV4k0GjtgwFGXtDFyizxy3k5r02aDozytrF6eHZjq2bBqXqoQNTpSkAND1qLmw45SRSPhU7ntiLmijtLkLDXaWe5YKFAjwvSOcBOa9qIylEmSKf14MKwjVJ3/qcGUDb2W/Vkr8ZCxyy2fQSVbQdC/5cjQYTrcorvq16pnpE7KhBkQ1/J8HpMAri3azwXXqVmxnl2xJpiYaDO1N8CJmGnMZW5iIZ261htLfxTI797OSjsYIAs97Uo5qUpk6R;25:0cjUoTcvMUadY4DJL9Aft1NuyOsj45D4xy/g28aMblNl7qT5pFG7KSbdCwZJBaqDK1wKSqEiKMps5gURoXpyG9hW+9lEQ9qQuMgkYQ5Kmlnt5MCEvPJSLvB3vJpD4y8/4MaXooa2WtaBJGq84bQhJAh2awNjS8ScLbgHhoolfR6CDuxyvajP5TC69d6P2gVbceDFVj2ZpyHq7lNNkVx6k5hu/PH1vcDy+GvZPm2Yl6bCtxFvJUAQSrrDL3P3c++qiWVpy3zR0fDfSdGHJP9J499pzaU9oAISEdtYxPX76lO8a6DahsDZ4k0Qz7ro9P3AK6aEdFvL6Os+c1OjL20Uyw==;31:ej1CvPbt6IpAWC+qlvJTPWnI86RrVV0ss10nTdN8aXaURM73kVo9htPH2BUvLB0O9FMUVNe+6wMoN0HAmUHoo2LUgm0NVihaZQ5+zBQrG6JvPYw/TlChUB0D/9N9OlkHOuEEZL/9qo7rp4HXW9cNm2O2QKTQ0fvisJejMBVO6Hik7CSBsFB4BAnBaa6gDG9O9/s1scx7Pz6HgdblomSRC1AVI3LWjGD8b0hkvfsUhAA=
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1013:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1013;20:mJFn2ETXnaTmJh0WbTOIgbSuZna9rVHiDuv4/yXq9pTkfKwOth8rwXTvMzz2LkrrQdTkvhvo0xgT8hLcgYrK12MdRjnn6TA7NwUtFSGMXGzh3fkiHguRWc78X4aX28oUNqwNe55ijRk1wzKFk7Z9KDc+wpdTSR7bRNKsyqrqmYR+FEn62gqdL8MiqXcuLtjkILARh5STk5k25UKUHJh96+jQN+6VtG8bvZj3iDXZg7a2+pqPdtRnZGM9FJU8Wx3eTzXh+CNWd4pR25n95hpfjZWtg5ZDWRHkmtPs3zGSrwzrnLL9RuXsfNV/G+HDE4PFdFrfDKyAVgvI4MwW29rWgghqQynNX2yZFaMZXmcElUHDVgyXCT3xMHtfnDYZTpYIiGKQtmcE5W1wzXfNnq9ZqMTRn7gJqTBtDjhq54ODD9dRA2uEeaViWXvNt57Q3tsR1XWREnpA5Z2RD++Dsw3uoM2I6x+A0uz4rbUp+w8jQxCOpVVivtBxHxv1IXw5X9nf;4:88UwaCh/KgYaGVj+2aSQ1cxLkNReofNFbTmufnCswlMKKKn4nmKySpgjCUIdXdB5MGoMFJrbx1zH5ndwntujOdDLcN4CFx4rLOa3tIK2bYQ953SHqpzGbYjsMw/VuNkCHwk6heiwcncbYJoi+oWL+ctaWr9jB2yOfdiKqU6chqwEeYuNjWoMsMKBp4sNFkU66bivZrznE+JKyf2p9ZSb93rTI2cmHEVyYDXVYWaqe3H2c3wBLYQsxQ9TCh0JV2oPNZoAKYu5PkEcz4s08Qy3v/hIovZb/FAyoxsEkzeJYKW7OkpwyclKcb8kwvTBm9UsNZMj6b7TV/yks91meTZtb7l4gv+2Nxb1yGKNCIxhSimtDltgNT1I8yDl1L3kVhYJJhS/nSI8AGqWUXQZ5ju8cOtyw0s/fdygYQLy55Q8mEY=
X-Microsoft-Antispam-PRVS: <DM5PR2101MB10138ABDE026948E6C10AD40F4BE0@DM5PR2101MB1013.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(166708455590820)(15185016700835);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(346002)(366004)(39860400002)(376002)(396003)(39380400002)(199004)(189003)(4326008)(316002)(486006)(50466002)(48376002)(386003)(50226002)(8936002)(6506007)(10290500003)(6486002)(2906002)(81166006)(476003)(6306002)(81156014)(8676002)(1076002)(6512007)(956004)(2616005)(6116002)(3846002)(36756003)(186003)(16526019)(8666007)(16586007)(22452003)(68736007)(53936002)(66066001)(8656006)(107886003)(305945005)(47776003)(7736002)(72206003)(52116002)(105586002)(39060400002)(51416003)(86612001)(106356001)(26005)(966005)(478600001)(25786009)(10090500001)(6666003)(5660300001)(97736004)(22906009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR2101MB1013;23:F/E+RE6sfHCoieMiFtk56tDV6hWPddaefqfto/z?=
 =?us-ascii?Q?t2EN6P2zeJ3rGhhbP9aRS2Wd+ppiYsMxErlZRtXoKAiqDzb1ntFS0Hpz5Smv?=
 =?us-ascii?Q?T23YHzqiCu3IPXjc38RhBSJ5d0f07MR+d0AqJUz0tihQr+wkvpD1xtsySkWk?=
 =?us-ascii?Q?NsCHDTP4WkqW3kqlg0DdlGymFDseEPhJLaUCoWU/Nxj2eqBDlkuqg/lhHpeS?=
 =?us-ascii?Q?HR8SX1Kaf1NsBkjL/1H8kHWmUI5QVTz6JRLsnmdruY22+FSMFoF8Q8QiIoKs?=
 =?us-ascii?Q?n04VERs4spsWxRR5KRvvMiuFAlYJZtY6ebT/NbhbYiplxgBdeZIa+BoTv6yZ?=
 =?us-ascii?Q?7QsSI2/OouctsX9LOiFB6DgBGVhJ0Z8MqAuosDvHMttSmdn1s0zxyN6OuU4n?=
 =?us-ascii?Q?9+HhY9HRnlfmOLDMni7yqKnqI5XIgr1OF56d4wSf8q65zBlC/YjEm7cRHHug?=
 =?us-ascii?Q?1KUOjk4AFOspFo7F8nf1Mmr+bAwA444y/ofMhXuiTxqfAc7YHgB7QUseQiFb?=
 =?us-ascii?Q?3zEf+ipwauK0jLi9lUgV3m6xogIcWfr+8uShqHE9Oz8hB32qjlS4GGfcrrEI?=
 =?us-ascii?Q?jxwVAd7TYMF5hX1m4aMgaQ4vUae328CPHzOHzHyQXG9DGh/v+Vs8JYpqKwVy?=
 =?us-ascii?Q?J6lG2VMrw7Pr2Kid7yAVlFBNYG5vgjQGHwAe/VTcsB2UhOEq9NL3iLWeA+M4?=
 =?us-ascii?Q?uNm/lYFHq9UUaHXThvpxvi/0m7HR6DWTObuZ1Cge4sAlm78MbQOjLkGzhI8/?=
 =?us-ascii?Q?B2wqpSWrdvFbrsxTqLtpk/RWiMPTmZxOrrjvXZ915lGpdI/7+OKisy2bg/eG?=
 =?us-ascii?Q?bSancKHPFbbOKWwinS46V0d3BQV/V+CRuHjT2ax9JVfwO7Wd6PCNrUMlgCib?=
 =?us-ascii?Q?sHsxws0nTfeel59FvZNsVMmPin0VbCCynEBSClieyY2lPWGHVK4L2CUjT1is?=
 =?us-ascii?Q?+diZLx9LJ8/TOgif5QhU3vzFeZwSKdLhEqDYj/y/q9To69Btr1fCrOOq+Ef2?=
 =?us-ascii?Q?TBgCmqtWhaYL5/ZpzM6BcC0CyFDZDJSfGXghmI0sXS76rvVEp/UgwIpB9kJ0?=
 =?us-ascii?Q?xh2EUp8bV6308Dlsqxm4+GBnOlqLYJnN1OwFvW/o8UlgupYsp93q6oOL9Rli?=
 =?us-ascii?Q?74LaoGzUL0ZKSjSlJ1MqzGqLO826oKCJiQ+qYQsQvTzg8+6Yf90fOC10beB1?=
 =?us-ascii?Q?mcPMaZHR6e1LeHgUqa9HGi2a8t4pA3f4rUXlGFJvsnz/f0WRvdcJlQ8uiUEv?=
 =?us-ascii?Q?mUklfWZP7L1WIkq2kU+824hbXKNgF5w1/OYaJNktzSyd+7mw/kX9gSnDFypk?=
 =?us-ascii?Q?iA3ufsJocU2DGZ/oLFCKC+sETUctOYmlJlmchJR7QLv6ZqpHKPSJhRc5vHBu?=
 =?us-ascii?Q?MYJCWyVga8kd1oT2KjW30FwD1e7ZQ7YpbOyKTrjvc+dxYZIlTyEanL8jsB69?=
 =?us-ascii?Q?90mWN1k/vHuH+LPa6Z/lkNsJsg1zlDVn4YAd9ApYsAg8LPHbabSd8MbeLtQj?=
 =?us-ascii?Q?GjYAyidFQcmRhww=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1013;6:dunxwkvAnVuFj//SsFqDnt6xeFPFy5UxG8D/zNWMtpcQnSSCmhetuIdWeGYxnxGwX5gomlQNeNOh+wUSKj5rOwZEHhqAQBVed9fQHwjBebEj7+tgj+N/M7V3MiTp8YOFqmvGI+Z9vccs2gTkKYpoa2WaCK/oeKr8sMXt3pkoicZtJGZpbOOi2Dj6omjPBOKPLttb4a3TQlQwUFj7xCZSkVTfoX4HyrNuwU1CRFj1JdzFuraCTUEmlk3aD/+KJLMgBgrMlkI35m0ALvb6SAx8XPZ6t1hTvMlH/yLma9tvLlWAYhbx72egyOaChsqnuRAgFfrWou1YK1z+UMd9t8Hh3Xd+YW9+g9ex+t5zsVoWBLeCkWHeQOP092xoQAZ8vAeQutqd7DZ8vOUg7wU+dHbrfgvE1/f6gnsDRpcHsVZ8QHCXnrU74IxP7Sy87fLhCLM+AQ0b+TR/ETE9f+oVTrZZ3w==;5:XdiawJvTT6Tw31V+bP83x51lyndTsFis8vgDcqCViF3WzI0nz1DbPfBZ+OfWBVad7HzxpPLMMUsDaow4RjfLMDoZ+OCH21pgmWcfL1v4fANaqshRB9s72wF3ts6rR1BWc5cDfkXCzJEe7JzqirtudQVTHw1uvme0lDOE5h3oer4=;24:UhJzvKt/MZd4D1XDW3vsCx9OdugVVigpraky52M83YwSpm28rPQ/D0VwuhPI8GBH+q4jVixZUcogmQBDsmh8Pmv7wMj6QgDtdA+lAHENRzU=
X-Microsoft-Antispam-Message-Info: i0zL7t6pMe+FAq0VAsK22dLe7e2C13OGebf2KcYdF89xqs9q3EgxyHZzWDZS/hi0BLnKDYGYHGm8U9ld6tEJFhtrS8RqCctC3OJVRPfeD+akTiTarOsy3NxYDf6Xh82uJN4mz1k5jm0N167KFpI3AUDI/+nmGx4+M3NNojsk4D8xnEfwcbNWKAnKlJGeoh+b
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1013;7:LhRDiyv4qNGPfqsV2rqfd+B0NbNKlLBuGWAiZQM+fo3XJPowHF+ebGsGSE6kq6L4lI7WSYRIWjqy8cUQv8TcoYS9+KwpMuUQRjO+WJVXN6q7OcCxoiU5qr/nAlYP+u+kR7skSvvplIcOj2Ww2pwg868dSwz21SjI27yuocargt1Nx6ddxwV2z5FXty1Z2S5Ug+mv2afg34tAqxAFNgqslCnSZeFpi50ofP2DC2lvLL25fGv7QzwGBy2t2iEOaEUV;20:GJ8JhsmKyTX2LoLXKJ+o1OO0mg2PK51GyUj+0h8zK46iIJgU5GcVADNhHrNOpDiIpMoH3nb1r3MlyaI5UCurZi9WWeps311eufKe92Uxz2i6jiz/FlAlhwpiw9XjnlR8M50WCNqLjqF7zyi4QNsIdBKdcYqGSMXCPLpPX2HYrrA=
X-MS-Office365-Filtering-Correlation-Id: 5ccd761d-2879-4ebf-a128-08d59f0ef281
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 18:14:48.4849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccd761d-2879-4ebf-a128-08d59f0ef281
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fsmonitor currently only flags the index as dirty if the extension is being
added or removed. This is a performance optimization that recognizes you can
stat() a lot of files in less time than it takes to write out an updated index.

This patch makes a small enhancement and flags the index dirty if we end up
having to stat() all files and scan the entire working directory.  The assumption
being that must be expensive or you would not have turned on the feature.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref:
    Web-Diff: https://github.com/benpeart/git/commit/4d39ddc2f9
    Checkout: git fetch https://github.com/benpeart/git fsmonitor-perf-v1 && git checkout 4d39ddc2f9

 fsmonitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fsmonitor.c b/fsmonitor.c
index eb4e642256..ed3d1a074d 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -185,6 +185,9 @@ void refresh_fsmonitor(struct index_state *istate)
 		for (i = 0; i < istate->cache_nr; i++)
 			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
 
+		/* If we're going to check every file, ensure we save the results */
+		istate->cache_changed |= FSMONITOR_CHANGED;
+
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 0;
 	}

base-commit: 0ac4dfac5000ef8de7966a3b7229275567d2d707
-- 
2.17.0.windows.1

