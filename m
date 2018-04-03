Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3788A1F42D
	for <e@80x24.org>; Tue,  3 Apr 2018 16:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeDCQwK (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:52:10 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:45952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752582AbeDCQwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=J65kecXWyanhND4tcFfW/00yzhdMhx4B08h7sAtM4Iw=;
 b=A0K9lH1RmObwQzWTIGFonVFpyX4pnStSsLFhuA01djuZ8nkC60RJYm8qZZP9xXbv3u/kf3ggCR1CdMwmJms6mwmfZ9P86sh9LVYmTAdpBk/vm+SHdmr6UGuOK/dIWtEuKjn5UJLYs7G62h4wrcXrWgVINORZ9ivNeWB59b/pfig=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 16:52:07 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/6] Compute and consume generation numbers
Date:   Tue,  3 Apr 2018 12:51:37 -0400
Message-Id: <20180403165143.80661-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d46c7a4-b658-427e-5776-08d599833c47
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:cC5V8apQW1LQHk7d63+0gYU0LbkjLPeFA/AgPrvdVNnXEbL7bO8SN7plw7Qx6o9eueQ9D+vEQ03Su2gAJ1HmHCdl0CJg7bACR+EyOySMkh2baSy2k+qMZ9bzRv1pJ0hIeJeT8kW5gKQs5MnjWAFvzvfQ6XdxP3ZriUneCUZlLG/+D2v+qQHbfWak1KGCTVR4x99rEvzSa+l3bmbiDGQp0jnmLdsfcm6FVFaDuQQrTUpFxTZjQT5DZ4o+tvfrcWwD;25:qvE3VLXPe6oS8CxsGTxM/M0l0xBtHaC0w8UQjRGMVQO7v0CdGtub+CEXBh16oTg3vqGsBtgZCRyQnXj3s/xyVNKI7825hN1QZXmRaCwqJTzzeFB/CPt15h+K25knx/CTZPSRAaIKnxiD7Rbrm97GEsJne5Tpf1u0Q+CtdfYxy78KTib+07FGqoWkkh7/e51fHcp+DUFmmSDc07PMp7CrNsjY8E93e9R7pLKXTchgYiiYNmAQIjFq5CSagj5cLuUpuEZjLvGNVxjUr71bQ5Wg7eJtUg+aYQzLLxAbiDp8PVkXiT/epzdarYdKZYGR1iEEZpbl4YC1OhMI3qrYbj/paQ==;31:TYSUPiy+S+vXryi6JieC+g8rj+mUdto57Vfm59PdFpS3tWd9chq+TUB6INbjcQ4h6EqTuLtY/9jURf8vPPIVJSk8QadmkT7MICC5cmsZ+2ubu70s9M3dhSTisbCPlZboMoCs0HnCtjvH/FWM/b47ageC45rWZmIHfPn6jQ53iJCfeiEYCyNnHtrGNHwcihmBqHo+oJKAqF0WHAS0FhDNyF8FAtg/NKc801CNugeEznw=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:h9W6lKdQoOoN8mTpSgLXGDW7y+RrxI/7VuKCaI7hGkDubp0kaGKNprp59/1XHgeGVN5EJaVsXzablA5W/KrB0FpU1YMxnXblvMIDdaWErBRsEgXg1de2n+V/EzR/vQc/UQrzwjPSgKJ4489zDwfySOkJuV6vR8pRUihmXOsFZUM08sDE4+KG+U9l64w77PjRO6bMDZwG4JTFSxQTfXbFvRf8NkSCsXEZq0yrspf3+FJc9YP9XTdx1EPl24ltyND8R+n8mXsw3HUMMD/h9Zz+VcraUZpd7d6LpnQIculSzGNLPdrrfC+5zGc+crt8At/ch2V/o22ReuR0GKO1QaZeUk0gfDYCaZcmfDljatvB/OhpUgvRCvylljnp5jT3jVtc9ZUxyaHc5jNoHDAb3KvnGVyOQ7zBuO5I6VV0KKmqxRcil8JDExIj2lVCATsfoa67RDdIt8+3B993uv0geYpVtngdIUTWpV0dPF2e1bz2kh/dj0vwBmFUytRq0eBoXpiK;4:hnMqk+SBcfAX7yCdnc3ejebmr4MdmjedghZDjoZgGjlfWRfZZbPIx2yADAfYPhAVk7mqLVILgMla7vGwkNhWgHSAPAiQgT9tsn+8TL10i0ft7QWOgKYaXUMI21ekhnuXgHUXd8eAu814keOjuqTBXg8MBtD8u8rWUyx6KauUqeaY3NpjRUFhlfEdBAf72SJqQDrot/XZUgg0u8fPcsHF/IdJE6slgQuKo3lbpmsGkP+80XaeRUbcdei08hwBmtdXez1Ot83wUJrXNwZYHDKslQ==
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1011195219269AC92A9C6260A1A50@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(199004)(189003)(6666003)(6916009)(105586002)(53936002)(7696005)(52116002)(68736007)(51416003)(4326008)(52396003)(1076002)(107886003)(86362001)(386003)(106356001)(59450400001)(39060400002)(6116002)(22452003)(478600001)(86612001)(2906002)(16586007)(316002)(50466002)(2616005)(5660300001)(25786009)(97736004)(81156014)(486005)(486005)(50226002)(186003)(476003)(16526019)(305945005)(81166006)(48376002)(8676002)(7736002)(47776003)(46003)(6486002)(2351001)(2361001)(10290500003)(10090500001)(36756003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:OnuIlnrXjYy2ocJs84h1QtNoeIy91zRX0Z4CDyZ?=
 =?us-ascii?Q?wPAbKvXLfYKRSUGUKcy/C9Uq0tL4I+AMxReGIzfZ8agf3T4U5KsQBF/kGF29?=
 =?us-ascii?Q?q2AHJz/iQKW97vSiv6FMkbw/os1TjQ76jm2FYoKwaXN31Kqukeo77WHwLXuB?=
 =?us-ascii?Q?xraXL/UIf0N4Qsivs5APzI8hYdnu7iPI/lVBtgocrcirwhptq7mIZAxidR2j?=
 =?us-ascii?Q?RPXb6AdEWOJAPpzvEGqNHG6TXUN2eZu9H3dKVneCqv8V3lLw1gkCWJMzreXp?=
 =?us-ascii?Q?8Lj4zWEMmwGt23H5r3Au110CrBOuCGK54Dr1UfujWuobIMoNZQv4MT1N35Ba?=
 =?us-ascii?Q?sHNtMvU0qspVgRvXu1d+1PHjalp0FyjDLWQkPvmKFlkozRu0B60QXeyfaosP?=
 =?us-ascii?Q?yaeNlHew5wxZl8yx27ZzsaHO7xGCf4BKOFrADYuBw6za5JOgz8v5RHPqLbh4?=
 =?us-ascii?Q?rYR4YyCauBFCnLayYwqC+rQOMuaxT8jkGXeAgQozwYnXXLFn6hSE7EqPvm+s?=
 =?us-ascii?Q?yGk54W4jtyPcUKv6slLFtIwDCJJmoDqqTNAksCh5WrKWl93iIQX7axiK0Zdm?=
 =?us-ascii?Q?U/HhF7P44ZAEe0CckCqEeMr1jqtCo5bptakQCGPLbc9F0iMvwcrA+Wo5BMiq?=
 =?us-ascii?Q?xnKLC8nJJVoF38fLp740wSZtwK2v+V/4fZ7+KUP7w1IZLiilvBv7j/HzDyML?=
 =?us-ascii?Q?uSdB/lNp92G8RpSol/aTJU7Um4MC3uUwhNwm5vh6ysEAcNB7aQbnzCVPbOQr?=
 =?us-ascii?Q?gWBxOaPJxwq06fRrr52ob2fjTb0juEOU6D4JQj2QpfyRBpw/6ORBd/Kvpmcj?=
 =?us-ascii?Q?j//BydiXXRDLcrP+Y638vvR4KzoHAiHtf7yhPfgXHfR1QSCwpRjt459kesNa?=
 =?us-ascii?Q?5VCLFIrPvY5YZgCRraBzWu+LN5saejoWCDIcff7P1zHTNFWJBukhVoKNk/Nm?=
 =?us-ascii?Q?E0bEJkpZ5wsZ6T0ZvsFSqk9Inda1l8txk25ZxF20jmcU7Qh2mkG86HuRO8H3?=
 =?us-ascii?Q?rfGo7RhzrrGZVrJS0yI2Jiuzml5NpKmm7Xefdx4whg+M0VsoGUcrXSUtRxzY?=
 =?us-ascii?Q?obGlv2PIwV3WuO3E0SQXMdNP0BSzUYWcz3XIe4iq35HmD6cT58vlWYuI5yd5?=
 =?us-ascii?Q?spy2SxAxrwE50ddsqWqJYS6bdZXiIgNAJduWGV8fx4dyeyPkOthtocX70uVs?=
 =?us-ascii?Q?gLE+IqivFoiA7m+jqRA+0FeCIF4MuF+z6ap6URebOKmYNIj+BNqhLvqRK6u9?=
 =?us-ascii?Q?MB8IYV/J+Kw+5KrQF2w+Y5QxNQBR9SKARd11l2BpglS9QNM86I2tGVF+yhbl?=
 =?us-ascii?Q?bg59TGV2ouiMffj+fnEbH780=3D?=
X-Microsoft-Antispam-Message-Info: UeEpHVFBxLkr35Uv5BZbY1KwXZfMu1EtOVktO7GhS+OjvDsg98IFOETEGZrVbQm4oLc7LylsUOTMWszVrD1htLzANjiF3XTu9UjndnXzRv7qEwvIW7VX7HKf3gyi3Fb2pFIcKYlJ05HL/HdBnTq1At2Xh+qYR75kIIoje9zw6BMxdnQzjsIv5uqgEGvD//7D
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:FDSvMNjJxV/Qw8mhybBkyJiUFhlrt2/gsdFjfxBEoyqCufrOOAmbvM9CZdZ4PUwmg0YjoEHVvAv4eBnE8T5X6bRXCMgOaynY93+vzPxIien2dX/PJxJE9LKErNs7zknmhOZnbrkCpNJZBA0lPXOs5C6h4G8Px8jp02U9CqF/mKSyd74selpkSOD5+F/TVOSfeN/zb0PYqDb7uBXJQcIWFhgtRTavkU0s3jNWLB4CFixBcQZmpo13GlVErXa4zMG1s6ML+KJQfWo/jT01ucg9xuFxYo7SD2RkgD+WwCeOpimJoCxVnLr4tiYtOZ19HzYXcfUyNmPn61V+1KyFu5LbJGBtU6aC2P+b43U1Od6IuTtI6aRFIZPCFnrM18e4Pqte1ZsZnE9bjd+dqp1aY88WyDVq+yHwoTe1dD0ZKbrCaCvJzdI9y2wmKvmN4ygDLw17iXhnF/1/o7g60HW/LUynQg==;5:SlG+YlFKCeduD3pY2orwr+LhXhk9Ql2sdnQLHjfpDb2KXmU04B5zjx/ym8tPmVPAGynqFEGjZa+kBlTJUbX2TiRnf1RdxHwT9kAj75n5SP8ouv7jjntyGkPwclZgTAFw6nfUobACBd5xWgeCLVPXjLYA+XkdHAjMZbXllS9WtSM=;24:0qDQ6tz6cXrFXUNksAmuQ3dkaGT8dJJ7DXd3irEmNkSsiCp41QlPuaV1Buxby5BAZ8+Ft7LrtQbES4XLUged3NRLmZBcu+yCkfl6E4XH+M4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;7:jbVD6OGZ8CARWncq5uYiKOxMFbKq5gvlJi49srE3WmT6ADc4p54MGrHu3KjGoduC2u6waiXmmJIZZEt8CW829Y3o7Eg0sd36evG0zeLNnTiJZZptK//v9aeOE648FNYyc28SJIBIDgQvdcUP1KQnJisGO4/jqCJ44T57p2LlBTmboQOM5lUX7H0YpNniVFrUjYJBLJugsgR7HuJtX+IQ4YNLQbOehjc4KQ/n4EZleqqQtQtNe7loZWPxyq/Xt2An;20:dFexMpIfyw/mIz2QpjthmukZ17X4ggSi3MpKYMvitKvO0makgTXA0I5e/fs+Eu+R7WnbfTbeuaa9qH/4pQFr4+fjRFjmWOAkG3a3rdCWYD7yHgJ7W7Uctn6mcSeDLPfF/QhTqzgs2OLKFGnqQ4IomBrYdfq73Pvy8wU7RBFZ+PI=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 16:52:07.1367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d46c7a4-b658-427e-5776-08d599833c47
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first of several "small" patches that follow the serialized
Git commit graph patch (ds/commit-graph).

As described in Documentation/technical/commit-graph.txt, the generation
number of a commit is one more than the maximum generation number among
its parents (trivially, a commit with no parents has generation number
one).

This series makes the computation of generation numbers part of the
commit-graph write process.

Finally, generation numbers are used to order commits in the priority
queue in paint_down_to_common(). This allows a constant-time check in
queue_has_nonstale() instead of the previous linear-time check.

This does not have a significant performance benefit in repositories
of normal size, but in the Windows repository, some merge-base
calculations improve from 3.1s to 2.9s. A modest speedup, but provides
an actual consumer of generation numbers as a starting point.

A more substantial refactoring of revision.c is required before making
'git log --graph' use generation numbers effectively.

This patch series depends on v7 of ds/commit-graph.

Derrick Stolee (6):
  object.c: parse commit in graph first
  commit: add generation number to struct commmit
  commit-graph: compute generation numbers
  commit: sort by generation number in paint_down_to_common()
  commit.c: use generation number to stop merge-base walks
  commit-graph.txt: update design doc with generation numbers

 Documentation/technical/commit-graph.txt |  7 +---
 alloc.c                                  |  1 +
 commit-graph.c                           | 48 +++++++++++++++++++++
 commit.c                                 | 53 ++++++++++++++++++++----
 commit.h                                 |  7 +++-
 object.c                                 |  4 +-
 6 files changed, 104 insertions(+), 16 deletions(-)

-- 
2.17.0.20.g9f30ba16e1

