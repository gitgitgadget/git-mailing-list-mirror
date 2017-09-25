Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0D020A26
	for <e@80x24.org>; Mon, 25 Sep 2017 09:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934478AbdIYJzV (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 05:55:21 -0400
Received: from mail-sn1nam02on0100.outbound.protection.outlook.com ([104.47.36.100]:37136
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933128AbdIYJzU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 05:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=I1ozlG+PSoFaffZ7yJTfKT07+UAZqddzTQxZSh36tts=;
 b=g1I2OvXaLA10ZJKAj3PaGEPPTbFfIrxVWKgreK//EeJ6eTYyM1Beo6imu1gEh9p2LpCpjUPLzE90orv6hI6BYdNVmaoPeUmE++nzbDND4dISDM3pC8hquEuZz/Cu+l89OTYL7bH0DHyJPicyYvyQiu61A9nlrYpo4rHQHDkFNtE=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 DM2PR21MB0092.namprd21.prod.outlook.com (2a01:111:e400:50c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.98.3; Mon, 25 Sep
 2017 09:55:17 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 0/5] Improve abbreviation disambiguation
Date:   Mon, 25 Sep 2017 05:54:47 -0400
Message-Id: <20170925095452.66833-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:404:b9::17) To DM2PR21MB0092.namprd21.prod.outlook.com
 (2a01:111:e400:50c7::12)
X-MS-Office365-Filtering-Correlation-Id: 2c5fb224-8258-4b43-eb0f-08d503fb86c9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:DM2PR21MB0092;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;3:RV0dTj1UFCkbBmLAVnAUBUKgVWo89VYELZxH56riyyL82uqShjQ1T3KP/wpnrKPVTp7lPorhwnWcqRRjBWQ0jNZzs8hn2b2OVzRxZlrizZiGDIeeFHlWYmNL63OICqrWxUUOzpagsWFd/2N66WBrX5/yViioWD5i9IZNcgKEtbyBkngmSCyy/83J3SHagA65KF5FTqsqcu9+7i5FyRXcNHZtD7fnJHjMyarv7NB7KNaqFLiHaNHNTNijmQbcLfNJ;25:3w5sghcLBv0zYEanjuM+zPpun4xOF1s5gt0V+rtRJa/DkXmyMqqGukRErci8PkYvA4iDwQ1SGyyvuio4KdhpBkjGX9MEsAWGECDGMnEc/ddFoE40WDNmmlIvDf0SmbvePfgbVzUVmSt70plTdqvP3rJoHGGbkqH7dZXBU9tohw9DdJdDFUhiGHw6G1w79R4w3orf4KnCdf5DDgnruTk09d3TL9ebTlRoqzvS1BrQ5aIdJfc3amBazWrpe86HhirJofHKB5Tixk5yG3GAD1mcHnECB3dDn/G17F/epSPZw7CCAlaLEb0JKQeRyJ0DFER/4Xl7LAwNsIBUgsQVSZQU5g==;31:4We5o90b628JvshQr8WHGVbChr/YaWhk0WHT1N/57Rtgt422df2qrdmmVo9xHd9xwSlt3sy1mYb467QDQzqOXkqAQnj7UTLHyXlUYyteS6MzpqNFdQ9wecHab8oSdihQKR0bahZuQZfE+F7MG3DG4BbtViIsW0+uchXqiWH7hs4i6naAD+qhMpzW28H4yMckUrvDxZ33IqSoiJnY1aWiIDHQcZp5TOqdAHzXBov7QAU=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR21MB0092:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;20:WtAJxOxcGova/UjaGxIr5A8jsrgXphlDA7ANTZB+AmWLaALBpWkT4OnSFLbEDUse+8IrEtv4ubuVb20RwWNSIKvtNiV5iKZiCDQUYQhswJTiq/BRODeUqhQ+C8C9l0uimDKHDTRJHV4HZS44gUaQidVYbfcSmtLWqkpNU08mXkRFg+06JJpI5gwhWfUX8kUOD54nPXOt2vvK6CaVTThGvkv26/SOZfPukKChHpPVbe3tkRkRezualyy+Z+roNEqLCEaS4Ehim8N3ERsdHG2ucDg2au81UrQV1zlsXAJXbdMubjwQWKJBCb19pB0VgzZryAKjlifMayjeOrGPf+65gxtRBvoYS14ZP+SLkKFKPevCiH+9KDVKIV+JyhUYlDLrnbNgFI+tV8zK1uYwSpRmpQqtEW2dMkIi6wiQ+caS2rfHMe5SYVUvCyFnwYWzwvqgDNFBfj+TkQYuaFn2iotyU4zli7UFS24QGdFTOfr6hh5i0xmSwCTSKWDDOVjpj+U9;4:yzreqXoZ/EX/v5zdDo0jt8twJIHSgHG0Svi0XAIkfE7y3N1ga7eNtj+wWLjIbNdK4z0HbxMBf2RsnXB7n9h375fbEssX+pLpGNZ6vOXWWRwIIVkbeo60fDLckZDIyJ6BnODmgNfEcA6c9TCbb0ifr8m0pR0umjWdZdR6UMxg6SLMYSl/hAIOHslNazZob0FWnovPIC1OHEn57aq+WhS7/M9yP6Hqh3ZHYg/EuSDzuGYjGUhZzyNnFN8d1X9MStC3OHG0eCKBp5AHqavWRi8RtfJ9MJNWWH6LFzWQ2tVhs+M=
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-Microsoft-Antispam-PRVS: <DM2PR21MB0092825FF09B1BB18F8838B5A17A0@DM2PR21MB0092.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123555025)(20161123562025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0092;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0092;
X-Forefront-PRVS: 04410E544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(346002)(376002)(47760400005)(51914003)(189002)(199003)(316002)(305945005)(68736007)(86362001)(10290500003)(101416001)(6666003)(7736002)(478600001)(105586002)(53936002)(6916009)(2351001)(86612001)(4326008)(2361001)(1076002)(48376002)(10090500001)(6116002)(189998001)(81166006)(5660300001)(25786009)(8676002)(97736004)(106356001)(39060400002)(107886003)(81156014)(36756003)(50986999)(22452003)(6486002)(8936002)(2906002)(47776003)(5003940100001)(50466002)(16586007)(33646002)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0092;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR21MB0092;23:LlDuE6UsNkJOFIBUz0GIw5bjP6Ryn4W/Sx63jnC9E?=
 =?us-ascii?Q?dnlq2Kpe9Fpn0xqTzajCO+jFMRhUCQrawkGhHASTiajyL35AKWz1jYQILh4E?=
 =?us-ascii?Q?WXcVeJAWbnXTXzRgYsouFLFa6wCFCjgpqdnY25bg81i9g25QbNIXZjAXhKSv?=
 =?us-ascii?Q?8QhKU64fd/issRpwUV77mxFs8XHjCiOQV2IkiUsUXq+hHrfI8Fj4AnViTYZ5?=
 =?us-ascii?Q?iF+U5sI4lYAhmDedD6rnZ/xM01s6IUJn9DdFaf7aMPz9mOITWE46VHw4ZclG?=
 =?us-ascii?Q?AgkMr8dJs4YvDkuFWTXcwZAvHsub4r4UWA8tce7PCC48mWqCk64qQLPfoFQM?=
 =?us-ascii?Q?7gXN4m9elce3olBYNhXgFfpeIpw1/jV7wuDV5BY/3v/dTQCZOOMzUMHeIiYs?=
 =?us-ascii?Q?2CmWBfZtOsk06+eTLp8nsz1J07QmR8mUz85SCJg/iqbidTrKDMvvoL4yF44E?=
 =?us-ascii?Q?kqkND2KxTPxHzXDdvE16xfB8K2oyue3XoESMFRdDUagCvriy8/Su5bL6exQe?=
 =?us-ascii?Q?+ikrwZcteEoSXJdEPqzab5RDfh7GSHoJo1CPBDP4VKeX4Jan2u3UZQXUdccp?=
 =?us-ascii?Q?nQd52i1MZakP0KhqA7bcbWGLt+yWvghiLp3SvawZE7raD2INPZeYcP4Ftj5a?=
 =?us-ascii?Q?47xaNvOpwDCrIBSg0Un8OMWgrfJXqQ58u27fK5vZ0xCuvH977BmrplviheW+?=
 =?us-ascii?Q?O9RWKZe+3zThnxfLjLasFRygl22tMuw4JbKUJeHc3p+nE8H7rjw6B6hy0TCv?=
 =?us-ascii?Q?lK/d8E67wGzbjsmwP4kaWNOa1V3kmafYToWM7MO24fTpE/IV3Zrcnept61ER?=
 =?us-ascii?Q?L8I4rHVi7eWPOu4cyk8XnjYUw64QUgZiK9WbcDLBF5iM3DwigP4MVToSpS+n?=
 =?us-ascii?Q?XdsAKHGlVkKcRGBASKDxdl+V7OzhTjXWooCNPc4b4My3TgyEhRkpgCZa1tnb?=
 =?us-ascii?Q?lX68QzQnidd2ox5Ugn7ArCs83XhzKx7ZbpTQQwxJBb5W3FNJi961tLf4tHAR?=
 =?us-ascii?Q?NfNUj1It2nn3+z4K4BKkqSKlVC7rfxpxMirlt3hCxQakqAynOhqXhNkihgkc?=
 =?us-ascii?Q?Si8GCBrKSAe1T12DjeZLNtGeMoQzAc5UcD9HJANl6UWnp7VO07D2gq9bjf8H?=
 =?us-ascii?Q?2wW1kceRIAPj0dXwdgI8x9R0QHdFStUIg/Ke4/67tfi0yzNKXoA4TKsaj6Xi?=
 =?us-ascii?Q?K3YXS8fXLNNw4bdZLEqYDESncIVHGSS6AJ9?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;6:e9ykNgRhlJQDiWLkohiBgSr5PqDQpmFwU8KrMMHKHjB9om9qyVbEA23qT28u5eQ6pHqTlrtBGIwsg2jwzsvDN5WXsVfuEjPDJl9qFsa3J88TrN12evdSsatBHFVCxYQySCtvs2ZqAwl7Td6lGON2oSdKhxPeztDyCkozTzdZXcOlQbW60iEJJyAt6nE4mpkfMdVVbbnddgwf5qME4PrGW/wYPxbtqgvl/VTM44cAVoztNp1dHINMpnhu9iugoanb6SCk4ty9p5oJMrLzFsni99CdzzmEHLoYImtS2iReRcdZ+qL/3UhUN4xJcAxspgBRv01NRsBokloHggrpEUOW1w==;5:aN0otYz+K7eNcStSxWPkTr0Ikby18K2yL513tq8zhJ/zOho3oErY1h2FwjYeqeZC8X7pVVDxIU3l2LANMHw8Qmu9tc4f0wpAYTIrHbvzyXS3OZnBXZ4csqRoiM2i24qFKXpE87+Sdbe8+ig/U3xtMw==;24:VzuBojiBheOYYqC4NDNAfg+DkQixtmaMBvu/aErLuNXdOiyk1DoBniSY7cTrCGtTR6hx2vZYCeSezsvS0/0DdiRXZOAFKkJxRAPUpiI1/gc=;7:hsaGrKOOl2bPoFfxf9Djzo8J2Or4ycRbB+v/k48Kp0BznLbOZRIbq5m5leBXXeyHLL0TjHnC2qqNpthieW1u0MsjHed+j4KR4PhOOIRhr6HI0GUkHZFoLW+vLjrzG11hJgqJzRV8ddX7o1fz6O4kJ6NXonvt2yh0kYbhRxS23IyPLDjYafo75CeHpWXaTdlIAkgZiAeK1Pv8T6YEHfGgkh/wIAUUx+/RwFaTbe0JgrA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2017 09:55:17.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0092
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback on my v1 patch. Thanks also to Jeff Hostetler
for helping me with this v2 patch, which includes an extra performance
improvement in commit 5.

Changes since last version:

* Added helper program test-list-objects to construct a list of
  existing object ids.

* test-abbrev now disambiguates a list of OIDs from stdin.

* p0008-abbrev.sh now has two tests:
    * 0008.1 tests 100,000 known OIDs
    * 0008.2 tests 100,000 missing OIDs

* Added a third performance improvement that uses binary search within
  packfiles to inspect at most two object ids per packfile.

Thanks,
 Stolee

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
| Git   |     1 |  230078 |      0 | 0.12 s | 0.05 s | -58.3% |
| Git   |     5 |  230162 |      0 | 0.25 s | 0.15 s | -40.0% |
| Git   |     4 |  154310 |  75852 | 0.18 s | 0.11 s | -38.9% |
| Linux |     1 | 5606645 |      0 | 0.32 s | 0.10 s | -68.8% |
| Linux |    24 | 5606645 |      0 | 2.77 s | 2.00 s | -27.8% |
| Linux |    23 | 5283204 | 323441 | 2.86 s | 1.62 s | -43.4% |
| VSTS  |     1 | 4355923 |      0 | 0.27 s | 0.09 s | -66.7% |
| VSTS  |    32 | 4355923 |      0 | 2.41 s | 2.01 s | -16.6% |
| VSTS  |    31 | 4276829 |  79094 | 4.22 s | 3.02 s | -28.4% |

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
| Git   |     1 |  230078 |      0 | 0.61 s | 0.04 s | -93.4% |
| Git   |     5 |  230162 |      0 | 1.30 s | 0.15 s | -88.5% |
| Git   |     4 |  154310 |  75852 | 1.07 s | 0.12 s | -88.8% |
| Linux |     1 | 5606645 |      0 | 0.65 s | 0.05 s | -92.3% |
| Linux |    24 | 5606645 |      0 | 7.12 s | 1.28 s | -82.0% |
| Linux |    23 | 5283204 | 323441 | 6.33 s | 0.96 s | -84.8% |
| VSTS  |     1 | 4355923 |      0 | 0.64 s | 0.05 s | -92.2% |
| VSTS  |    32 | 4355923 |      0 | 7.77 s | 1.36 s | -82.5% |
| VSTS  |    31 | 4276829 |  79094 | 7.76 s | 1.36 s | -82.5% |

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
 sha1_name.c                  | 128 ++++++++++++++++++++++++++++++++++++++-----
 t/helper/.gitignore          |   2 +
 t/helper/test-abbrev.c       |  19 +++++++
 t/helper/test-list-objects.c |  85 ++++++++++++++++++++++++++++
 t/perf/p0008-abbrev.sh       |  22 ++++++++
 6 files changed, 243 insertions(+), 15 deletions(-)
 create mode 100644 t/helper/test-abbrev.c
 create mode 100644 t/helper/test-list-objects.c
 create mode 100755 t/perf/p0008-abbrev.sh

-- 
2.14.1.538.g56ec8fc98.dirty

