Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9382020281
	for <e@80x24.org>; Mon,  2 Oct 2017 14:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbdJBO5L (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:57:11 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:1204
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751250AbdJBO5G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OLxlWo7R2rYPhdG90M4VC5QqqMDIKoxYQKL1fOfyxbQ=;
 b=WRKFg4Rx6CYuaH0YN19EHMdShRnKvUW/JPFu4xp9tpFY+LV4703bpBLJBvv3Px/EUi5WeLk0E5Y/7WnbfIwPGMEhG6c1zyrU7x3+1xby0fYqHqZbmB13gFuWye10aArcBKSHA6PVU2qO2uIh6v7lgWmX3B4HZoGscGeVFSDlAzA=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 MWHPR2101MB0731.namprd21.prod.outlook.com (2603:10b6:301:81::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.4; Mon, 2 Oct
 2017 14:57:01 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v3 0/5] Improve abbreviation disambituation 
Date:   Mon,  2 Oct 2017 10:56:46 -0400
Message-Id: <20171002145651.204984-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170925095452.66833-1-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: MWHPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:300:115::27) To MWHPR2101MB0731.namprd21.prod.outlook.com
 (2603:10b6:301:81::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef6719c9-f7ed-454f-af5e-08d509a5d6dc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR2101MB0731;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;3:TCASWQiENypf6XtTdZuIYZoHqaHFrBtgnU7byontoXkRAbPmf0y1jf3C9c4BbXfKc5bIoD2+RutFJMFcH19/4xIRO2Vh75aGX5IC+Zpl3bAGn4PV/OVA05+L7Ug1dUH2h/3sHK+XQZbc6Ql20HgPIa1LxwV571PiziNyHhoyt77ZnzcKeeAqp/iBiyDB75tCe87e1XzfZxyKemCLkqB00Qlpc4w/N6bXSDV5m3pFL/aJbZh05qjL9tUDzdNIJ++B;25:xq5tStXc1WLYydYF7O5V/BXehJJHf9mmeSmMgGpNuDEnbY2/shTN7Q4+4K2Zu+adQu3YshfRG5ow7+ZZZfq5qEWKgKDRKfew0gMUTD5jEdPVY9k22hxYdT6Nb+X3DVjATZzbp54hNqoE2gyQSnNWg/a/1B1U4tDWJVwzZv+AvHHs0NMrtSYZTwQMFlFAJ3YMeb3d03Fmy9apG2blfEof+NaTa47ExZvdBnwP9jMAi06dPK4GC8NQ8QvDPG4rIxc8/Popgi8ulMKOY4JMBs8VZstRvXd3nXlJloL5s5natCmtjZCPVj6ksr6FMWOqAAf3a0wXjbQMzWRhAv3IZV4KhQ==;31:hnmhcawgdzqhrDgM8KPcSGz7+jOY+obV63OXTEQNvdveGQ6KDwQ8QTCnJ1rd42pcqmlfxJIokjYIQ2nTb7MUlXFDte+F+hjmuS/QJG5Jb0UtsDR0KWP/sokF7wX5cS91FU3IKCLyPvNvA/gYugbdhdkYQ4mzR0HGkehzIklf2rv10QasoCxQEonWsA3bHYcn7hMDpsr+sWs3/flOpurSt2J4N3bNc8hJApRePDoNM44=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0731:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;20:BB11vOtR7SAHhJRDr+lvcokG+chXguZq0bGEJedTY9hXq9DHiCxwXCmrpVh4qffr4WZkqWfso6AaN4BTZYQ1Tznkk5QHwcBZ9OdgE55xRvmPhKd6IVrVkshVsHIcCyecPMLhlcytHHdJR223D1+ThYx2EYQkkG0sGg8hu0m5dwRefT3zc+vwMnPc8no7I008MzwhmvCfqZyhobcnXT3pr+ZU3U/VOeMxlBzjaY0nVKfwrsBCO/fNTNvvje2X44mSr/tzF6hGZO9y1rmgkWEP+ykJaJh3PY/VGA53kjCtLG0c2seW0Hi3RNHmj294aGQa9kbcYcMRi0bLNLOs+8dh4Favfz+dtyhM8RMBCQ7sbAZ7V6gizXcFVfuuZrVGafye/CBvDNcpqEILcmwE6VsNifKpgN6snKlmdHzvnIkYSfl+IAzXSaghUuF5gKUNSx55tBBQJl5jFSV7J/PvyIlFLMaSShvnlBC5n2l+8Y6faegbzZNsaoGsxlC/2B8iYw/P;4:qBe52qQfTKXsS9IecLIW99qfTcN+bhUZH6AXQU4OUXOm2Md4Yj1vOQtmP2SSqc+ZpztmhK+Me1IEzLDQkvguXRxvUXdD7aFcd24g/eKJNUqj2Rp49jQX55Fl67cBmEELTRsAWl/coT/j2605uxpvsGePw6L10HYIvEF793+fiRJZyXp6yEw9A8a/RgNrXL/oj1j/Vbxfc4OBB+uYLJ5QIq06hqhznxM2Y+tv/sba3c5PJqzrUtAYkyEEqgj2il18Ub19NNXAwzsgeN0VkR0JgoZaEFfXda9zGI41px5Q5s0=
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Microsoft-Antispam-PRVS: <MWHPR2101MB07310BD57BB3D304B136863AA17D0@MWHPR2101MB0731.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(12181511122)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR2101MB0731;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR2101MB0731;
X-Forefront-PRVS: 0448A97BF2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(39860400002)(376002)(47760400005)(51914003)(199003)(189002)(36756003)(68736007)(81166006)(10290500003)(50466002)(8936002)(48376002)(5003940100001)(189998001)(25786009)(8676002)(81156014)(8656003)(50986999)(76176999)(4743002)(1076002)(97736004)(50226002)(2906002)(6116002)(53936002)(2950100002)(105586002)(16586007)(5660300001)(10090500001)(107886003)(106356001)(86612001)(39060400002)(6916009)(316002)(2351001)(47776003)(7736002)(478600001)(2361001)(6486002)(22452003)(86362001)(305945005)(4326008)(33646002)(6666003)(101416001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0731;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0731;23:2lFaYKS/AQgj0ic7uI/xDGtsu/lukW5JV6neCYW?=
 =?us-ascii?Q?sp7FfUiQfj28d0/06fKvY6yPSVZbS690lkDYUTZPut81mRggDWBvRBg/akJz?=
 =?us-ascii?Q?sTuMORRONffQURopsrOXqRyILS9AIBQZi+wf+Dpq2QQThGaPRAqxOyO6t6Mw?=
 =?us-ascii?Q?3IPFbUrEK8ctLPIz7mavWkLE9GMztLK0qzg7NsufhdXhAN60SEmwvVOCN+nU?=
 =?us-ascii?Q?v/+PdCwX85TE5jji/90yL15qccqDh1R7EtKIgMtH8EvMrlqPuxVk45Pd8r1p?=
 =?us-ascii?Q?Kv7cKf4l+QrQfJbSOqPKdLg+i8VxFPyT8UL1Fp01tgUifYhIJV2B+ORm0FQG?=
 =?us-ascii?Q?txbMHctJC+KZiM9VZkFEYWdnR/15N6RrILqmZPFTDE4AO4okBt9D2jHKu4mA?=
 =?us-ascii?Q?BT0sWuapt5fdxFnsD/x5Y4uwPc9+8YmcXUL8KaQ5V0OKXhlmrRUklp+RKxAq?=
 =?us-ascii?Q?0zJ0E9Sm9CrKM0wu2PoI2GEO0nRqpzCY48tt/0WSBMGFCg1DPCWEkK1KNRVw?=
 =?us-ascii?Q?Ki0J9yP3h2JT5rOCbSYZ955vUZxbmEZ57kj+SwgkZ1GqDg9H7EAp9bnU7DXs?=
 =?us-ascii?Q?u5a7+B7AhdML0llUjxnTLGc08IU3NehNoSFcCEhyFjdBLYmv2tIhG9DHlaoy?=
 =?us-ascii?Q?naKyaG157sn9xCuxWleRqrE2Cntjy51Lrh+Je/6/Ok5Sz5Do7u1BmfPUpN2O?=
 =?us-ascii?Q?tTa1UakDQZWIo36ftNmkZP9oKw/fo2fQ5JuMNtd+ra8+R3wv3gReyI6sYgCZ?=
 =?us-ascii?Q?5XQ9dgx7BZH4XFe+MkV/5AeNTCn/bJiolTjUgrjnVBCcGBLmR/O2+K3Yxf2R?=
 =?us-ascii?Q?JkM/1nKiNJ2C8RhIMIlh4Z9E09D0VYPgCGxEaKJPvUvzi1NKTfbyp9zFSGyF?=
 =?us-ascii?Q?ZGPMT2XVaO2XecoC4JxTv0jGr7OSOI6ThXvr70GEuNVSEF+g6vXB1iBlIxv4?=
 =?us-ascii?Q?mCdCB3hhHuhalrzjttuDA049h9CTCYIagX09MTQq2JszFv7k2RK73vgCP1Rt?=
 =?us-ascii?Q?ttUl9050UARZnET49r5hxSnCraNvAiWBgUSk8tjH3RGzlDMboUnSJ1kka4uV?=
 =?us-ascii?Q?0cvDL4tFqor0IUubKcrjUahCgf3Ng81CvL2TnLxhaisJxT1FAZL28qaZhddD?=
 =?us-ascii?Q?7jPaRDclsr9nqGHtHyouDV5xsPD51CgjXBxLfBPh+7P3lD3I899Qh9urj2j9?=
 =?us-ascii?Q?qU02ETp7B0y+EAFbBx9dL228/JshN14L3gxaG5q/syNjrG/wcQTJnY2GQw6w?=
 =?us-ascii?Q?dDfG3vgidCo6KRX5If0FzUZxATd50UeirCWxfccWbL8yMUQsWLSzKU8vmXxM?=
 =?us-ascii?Q?n6A=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0731;6:/6H3wNhPAoH4v8l/YkUmfUmVxEePP93A1/SxYM1CizXOYHHnD6yDqJX61wrWmkfUtkx4vMlpbKWFnxaVMHfX50iHtkkcnQQ77PclBRQZXcdmIYPyme1LwB/30g4BKbEZOtKwscwtaaVRe3JT+WnCMQU+ySmvcxciN/cMlL7g/yZQKfB9/DhbxFNNbNQubD+rHIaWZYCYjKCzs/ZgjeyGuAxiXf1hMwFksxpnsZwKm7y5DRleGRokjYc/cbGctpIiepO+3ni39mt8vSVzOmZuDlp2fQXAEyQqJWbG+y2fF7/PyLOoTlJ3Ec1tld/2bDYcGPa596GtwhjPHURe02wbqg==;5:pjqd1YmWgyJDeDUL1EnI94mBUsEm/UvvLbpKoPRLDx4iLki39dSab4CeJuwRUn2qKgByoRdQ+wdVnUwN0T7n40ZNw6A45+CVK9aEg88ATDVgL+b0LFEHCagzOJu3TH/xptzF9BaHrCkOpFwsMcXUTQ==;24:W22wRSKLrkacaBtHi/oXazP1BETTNclenx+yyq1JXfAhRa+vPBGiEDv5d8wjBIQRPvk7ytzjMHtUBBi5eQquTFizwPjwgGH+Gwoq5ph9bf8=;7:cicVaAiRv+Xh+NPhdbUUuHqRTJ4bnfl3PIJqD+VqP7gq3Tap3XUJzV24BZ9hQKh1SV9oqirjZjoZGyF7uboE57YfjIZ//Q5aB1L7W4uIaW8iV5kMpVBylr0tEnGxeznTzHgFzyAA/97gPujL1AtPvECV6KKkPacEiDwFwMvwSpAs5Trc8xOA3KllpztSMYpSyWxcnPpV0S8GeCAhFssNpXWHbk31Z/3I2uFDJ1lz77Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2017 14:57:01.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0731
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback on my previous versions, and for patience
with my inexperience on the mailing list. I tried to respond to all
feedback, but decided to not apply one suggestion:

* Removed the "sort -R" from p0008-abbrev.sh, since it is a GNU-
  specific flag. The perf test now considers objects in "discovery"
  order, which improved performance all versions of the test as
  expected. New perf numbers are provided.

* get_hex_char_from_oid(): renamed `i` to `pos`. I did not unify the
  code in this method with that in hex.c:sha1_to_hex_r due to the
  extra branch in get_hex_char_from_oid and wanting to inline the
  method. If we want to make this method available for other callers,
  then I would be happy to submit a separate patch for this change
  after the current patch is accepted.

* Removed unecessary includes.

* Use uint32_t instead of unsigned int in test-list-objects.c

* Rearranged arguments in test-list-objects and fixed the n == 0 bug.

---

When displaying object ids, we frequently want to see an abbreviation
for easier typing. That abbreviation must be unambiguous among all
object ids.

The current implementation of find_unique_abbrev() performs a loop
checking if each abbreviation length is unambiguous until finding one
that works. This causes multiple round-trips to the disk when starting
with the default abbreviation length (usually 7) but needing up to 12
characters for an unambiguous short-sha. For very large repos, this
effect is pronounced and causes issues with several commands, from
obvious consumers `status` and `log` to less obvious commands such as
`fetch` and `push`.

This patch improves performance by iterating over objects matching the
short abbreviation only once, inspecting each object id, and reporting
the minimum length of an unambiguous abbreviation.

A helper program `test-list-objects` outputs a sampling of object ids,
which we reorder using `sort -R` before using them as input to a
performance test. 

A performance helper `test-abbrev` and performance test `p0008-abbrev.sh`
are added to demonstrate performance improvements in this area.

I include performance test numbers in the commit messages for each
change, but I also include the difference between the baseline and the
final change here:


p0008.1: find_unique_abbrev() for existing objects
--------------------------------------------------

For 10 repeated tests, each checking 100,000 known objects, we find the
following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.09 s | 0.05 s | -44.4% |
| Git   |     5 |  230162 |      0 | 0.11 s | 0.08 s | -27.3% |
| Git   |     4 |  154310 |  75852 | 0.09 s | 0.06 s | -33.3% |
| Linux |     1 | 5606645 |      0 | 0.13 s | 0.05 s | -61.5% |
| Linux |    24 | 5606645 |      0 | 1.13 s | 0.88 s | -22.1% |
| Linux |    23 | 5283204 | 323441 | 1.08 s | 0.80 s | -25.9% |
| VSTS  |     1 | 4355923 |      0 | 0.12 s | 0.05 s | -58.3% |
| VSTS  |    32 | 4355923 |      0 | 1.02 s | 0.95 s | - 6.9% |
| VSTS  |    31 | 4276829 |  79094 | 2.25 s | 1.93 s | -14.2% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 5.69 s
      New Time: 4.09 s
         Rel %: -28.1%

p0008.2: find_unique_abbrev() for missing objects
-------------------------------------------------

For 10 repeated tests, each checking 100,000 missing objects, we find
the following results when running in a Linux VM:

|       | Pack  | Packed  | Loose  | Base   | New    |        |
| Repo  | Files | Objects | Objects| Time   | Time   | Rel%   |
|-------|-------|---------|--------|--------|--------|--------|
| Git   |     1 |  230078 |      0 | 0.66 s | 0.07 s | -89.4% |
| Git   |     5 |  230162 |      0 | 0.90 s | 0.12 s | -86.7% |
| Git   |     4 |  154310 |  75852 | 0.79 s | 0.09 s | -88.6% |
| Linux |     1 | 5606645 |      0 | 0.48 s | 0.04 s | -91.7% |
| Linux |    24 | 5606645 |      0 | 4.41 s | 0.85 s | -80.7% |
| Linux |    23 | 5283204 | 323441 | 4.11 s | 0.78 s | -81.0% |
| VSTS  |     1 | 4355923 |      0 | 0.46 s | 0.04 s | -91.3% |
| VSTS  |    32 | 4355923 |      0 | 5.40 s | 0.98 s | -81.9% |
| VSTS  |    31 | 4276829 |  79094 | 5.88 s | 1.04 s | -82.3% |

For the Windows repo running in Windows Subsystem for Linux:

    Pack Files: 50
Packed Objects: 22,385,898
 Loose Objects: 492
     Base Time: 38.9 s
      New Time:  2.7 s
         Rel %: -93.1%

Derrick Stolee (5):
  test-list-objects: List a subset of object ids
  p0008-abbrev.sh: Test find_unique_abbrev() perf
  sha1_name: Unroll len loop in find_unique_abbrev_r
  sha1_name: Parse less while finding common prefix
  sha1_name: Minimize OID comparisons during disambiguation
 Makefile                     |   2 +
 sha1_name.c                  | 129 ++++++++++++++++++++++++++++++++++++++-----
 t/helper/.gitignore          |   2 +
 t/helper/test-abbrev.c       |  18 ++++++
 t/helper/test-list-objects.c |  87 +++++++++++++++++++++++++++++
 t/perf/p0008-abbrev.sh       |  22 ++++++++
 6 files changed, 245 insertions(+), 15 deletions(-)
 create mode 100644 t/helper/test-abbrev.c
 create mode 100644 t/helper/test-list-objects.c
 create mode 100755 t/perf/p0008-abbrev.sh

-- 
2.14.1.538.g56ec8fc98.dirty

