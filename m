Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B54120281
	for <e@80x24.org>; Fri, 15 Sep 2017 16:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdIOQ6S (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 12:58:18 -0400
Received: from mail-sn1nam02on0096.outbound.protection.outlook.com ([104.47.36.96]:44448
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750838AbdIOQ6R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 12:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DYp+E72J/X+BVgNc4hXOE0HdTt02fgLs8OsHqGfWnA8=;
 b=WhVvkLas8nBzTeMuhb9AqGC0+PneWjWxAHSt13u4dNvT4NbtpInrgd5ydsbwSev6BDeqHdESYGueKEK4reRAc708EjQHoeCtr3XYsNhjPo/ZcQBaqeIlnegRTJz92dVnYYiJtlo3jq4B64Avnk3KZFxbDDd2k6b4WagkDSpfLuY=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 BY2PR21MB0082.namprd21.prod.outlook.com (10.162.78.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.77.4; Fri, 15 Sep 2017 16:58:12 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, git@jeffhostetler.com,
        kewillf@microsoft.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/3] Improve abbreviation disambiguation
Date:   Fri, 15 Sep 2017 12:57:47 -0400
Message-Id: <20170915165750.198201-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: SN4PR0501CA0038.namprd05.prod.outlook.com (10.167.112.143)
 To BY2PR21MB0082.namprd21.prod.outlook.com (10.162.78.14)
X-MS-Office365-Filtering-Correlation-Id: 9e3eed8f-02d1-41d4-0df8-08d4fc5af3e1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BY2PR21MB0082;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;3:tPa3Ztfjos+w9LMBYSxLMZObJhVIuPHhp4LAxfZVqlgtpNE8jScS3XNLYj6lxRlGynV15zKP5rFioBgQZxBzAKkHwV+DCOpvbKUMIPmCTOQmz/7SdZWvrUis7jgc1vtbmJ1gg/k+MIXIoml1pdA7fEgtJLx+98ydMowptly8T4W7I0D7FAvkulgNWTCbyviUXUmlSw3WYL3TJrB0SPAYLuc+UTjk6mnwkS5rg25KB3If56NBVjNnwps3hRuVl9pu;25:99YRGXDjDNCIE3TwA64rS+K4ZWfWYX4QRCxtHmB7kNHARoFpeeCbNUOFMvIlDqN31KwNr+u9NV35tzbclz6VejMXSuuRy5QAbJafEhzg6l4piLt+h+6VcuSZ7zuH7+N0UkjxtssF1aZ9SyAKrOzm7DsY/BxFYyCoq2CAeSlBTsblDi9irm0MiRfvWxP9vGcsuzNWbJMNKLK0bdfmOXCKUVHQIUfj2aRvrms4lvEnHMOD8Tv3m3EGo6cs9aaeVOykcrzOIM/prk5p1kDxk5vclf19RztDjVjLsokXkluAym+gGNkK2OZncdIYHQfKjsTeXMzQZJqXntYMDld352VE2g==;31:5xTEtiuYf872nolhaqXioMNbrz16FjNy89IKZv1GVd38zPWIPifXO7TLg3RX89PD/F9E7DtuB9zooQ/mcr8HhXOk4XUeOzVc+Gy+HiNk6WJb8x6EeTDxb7vevFAXshGtkKN0J3aGkXINP1RcsEpePXLNKLX+YDWO6urvFMZDTr2V9Kwd8VwYHphE+nQmznR0ppv2v88MTbI2Nsjh1rFU6XRTwo5tiKTC3HMV/77Uuv8=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY2PR21MB0082:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;20:JWm66vFB4lvJXF4BSwDVd/7ZjcaJMg5xFqpN65W4vfIiBZ8zSumzGGoyCZrwMi3xtQ2i/zYV2NT+Uu9qvxDH3wSisaHXLUYx4AMThYlBhAjYPNtyOLi5UcIQWmLaoFdx6e4SZq3bn/HVofxBdsjg5aBrnJpAH2qHuOjGDj2AWSUWkbpM/4Pa/btmu+03/E3ppeMa09roMxbi7a4ZbMxDI/GKb70wIsvbTCEemZ768sevxcWJK4ACfthJP12vTljDlhLXsqNb01/dek95VdXn2E9huOI66CQi3ZKdXL7GVxzhHLHUJhflaLkiQUOx5yOwv++azorR7qkifOfJHY7520SDvKF9qTp8vJ9RTf6/5d3zUTSh4heelW1dl9U2P7i3MQH1fmx6i9vQYcDRzHzAAcNmHIYHJBTSf8Ei3gsSmZhZJZcieakC152OyAFzqF/bNy33Tm2fUA2pQBT6fLQTkC7qSkTlSUjUeDzuTCKFMDCA7VYwpV+ptXMZYFonj7D+;4:gKmZA4Au1uO2AkMr7QBN6PYuLaR7fdTB3pJURqg6vHe5XXRxDjVwaaxYM43BHYnTNvGlFe0Uq8n4RIChRwOJXuz97wbiKyhlJUoBmHaDiB0yiFFqBFubbwkDy/t1j6jrzVw/zdrAHOkuiaBZEcWY6W25UtlEKaxPlE86ZFSqFFzhdq/LYO1ZvnF1iZlTlqdNSiuoBdZCK4GYzPiwjiBbOj0TKqrJE3xLrUeaIMFiYflyJUGc1ycf2MzwZavPMkfMvcx8A9P29HM3eSs6Rdq/ks6uHQNZZA2yuQjRRniiZ/QlugE4isDTyA2z5OZ2VZfJo8kcjfD/kL6W91YEUgQrGA==
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(211171220733660);
X-Microsoft-Antispam-PRVS: <BY2PR21MB008204FDABB200A16A4F5E7EA16C0@BY2PR21MB0082.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BY2PR21MB0082;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BY2PR21MB0082;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(376002)(346002)(47760400005)(199003)(51414003)(189002)(8676002)(5660300001)(81166006)(81156014)(7736002)(50226002)(305945005)(68736007)(47776003)(8936002)(101416001)(189998001)(50986999)(86362001)(86612001)(48376002)(50466002)(2906002)(36756003)(105586002)(106356001)(2361001)(2351001)(33646002)(1076002)(4326008)(53936002)(25786009)(110136004)(107886003)(5003940100001)(6486002)(555904003)(10290500003)(6116002)(478600001)(316002)(6666003)(10090500001)(97736004)(16586007)(6916009)(22452003)(8666007)(404664003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR21MB0082;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR21MB0082;23:Kds1B1keGuwwz/p7RwIYduQDEbtH7vKBxjFqxFoM2?=
 =?us-ascii?Q?wo+ujl7+vl502HoVo+4CuWhdvuDtyzuoL7NP4ZifkHFJe2ADyu1ot/HGrzRX?=
 =?us-ascii?Q?oAqpWZUTGbCsAAR+OGPg16MovAmvTjtLjARVti3gXvPY0Sh4pV4JXgS5CL8c?=
 =?us-ascii?Q?sl41UxtfVZ6L8A/qzV+CsO3NMlEkUq/pTXQ45lu053d0z2AdZoMgWyOrVjc+?=
 =?us-ascii?Q?CMnW2pZxr9FcQ9lW1WlOudSaoJclK4CEWjRykGjTNEqUkTEzQtZzje5/7wvJ?=
 =?us-ascii?Q?EQasuVZgjeiTWYlVlkTmw3/AMsOyLSOZECtfFaCU6re6yJbfljDYH2B9N+4p?=
 =?us-ascii?Q?pEEBo07ZHUlGIOAoZV9Ii1BeaLZ0U3d0OlrMDEvGuL1xkD+s0Ai9CMZK9w6Z?=
 =?us-ascii?Q?PWxMETA+1ZJXqhwzG6CnFZamYYN/qWtv3pM2dmyWjHwFLQ1SQb0Xft0CQaY8?=
 =?us-ascii?Q?HKpg1yWZuaudJmvO/Csr39Ep3LN5kR8E/HcwnAsmaZ3zZdpxYHOO8qrXIXxo?=
 =?us-ascii?Q?G6lwzLoJaLwz79w3HWXXYde7BvB+PCIhnExU5ikaPMGI2FvDrj4/cqd6JofT?=
 =?us-ascii?Q?G+DdzqRbEGf2TBpa9mFGYW24FynsgONLuquk+Gv4y0BNMabHMF2DlhFWnvmu?=
 =?us-ascii?Q?gPh18Lc+R0W6fU6KF6WxJBggm2DQm8De5vyFSoOyIaSKDWlqaVgZRk5F8On3?=
 =?us-ascii?Q?mOTf0rDFj4y9j3njaiKeVy8jGzGg7Sz3Z1bOvUFFT/FevxBBCca4/mgTfOo9?=
 =?us-ascii?Q?2iE0UlC2fdQlF1abOzZMEDJS4DuuFIBkCS0quYi6CbDdsnFgN3REviCFbNS+?=
 =?us-ascii?Q?bHqbsIRUtTcreTuZ6/KAAP9EYOvojUlkwKJ5T/mVIv49TZ0rNOCsvorZL5w0?=
 =?us-ascii?Q?enJ8zs0GzXfusFDKWmyrSx3hGG30qaKbv4CLRZq+w2nY/BLq4StLdIYr6t3D?=
 =?us-ascii?Q?+ntwIwBoJSXGvBlhMCgmIJy9XnQLeZtM5Aq7PMmnh2MZisYy5/cRPJrcFAgM?=
 =?us-ascii?Q?31lLJWJkjg/GrTLtDYycqOoOpMXHvgI0zoAQP7Bb2Iz0YDjKksthyw0VCewH?=
 =?us-ascii?Q?LosIrZk6mgg8cO3jjhPs7Nr/3Img6JvCOFa5qA1kDBAH/Sgg50EqWKrFBfq1?=
 =?us-ascii?Q?v871er9lKrK7pvxJ57XgAaVZT1nAEloGg7UDAFL7AS3wyye2S/Pu4H+Lmdbw?=
 =?us-ascii?Q?W7bA8ls2/TeqbC+gQFPglA49mh1xInbgzTcy5w5A3NjPDesJT11qveCtLKhY?=
 =?us-ascii?Q?o7fAgTOcWkjoMVhhOs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR21MB0082;6:hpqikQkWtyad70V1M7wVyB6NaSs6H0tGRvbYYLsWwSv63tRgkcnrOOdUjL66Bl/D6AOQvU/qzkvo9x9vSbjlgY7LvC4yvwl9MxvVAZJwQH9ze0jHgWJ5EHZjkhCEYIMMrcVznqKc+7LH4A76KRWoEnCRAJ98TKYtIpt71Xr4o1e+30Zn587vmBmH9583fdctQFXurzmIfYkNvuzCJV6TIBJvwE17puOdIgzVF8etDgrxfN3eXrTlW1k/3m+nPl+d0SRraJygs1DlY99npYiPZhLYklIY6Apv9x3trHAIoM1Ya4wpN6kpG9paWgfTX7Pjsgg7YuDueqFs8d4LnDQmRg==;5:TT85qIvjVToPA+467mqG16WLtGtUsMghDB3V9hkL1vHXb/xqDVDRGq4O793OwFbJ5+8MGl9YDl+DE25wQpEAjuLjj+8sB7mGby19+gmRc73uv+9oB4DbjYJYYZRHhYA3bvgALgkvn04ENWPXzKMxng==;24:gGJaFHQ14AU4Ubnf3m7UPQBoziZ07LBR+e7vQlXFlCdinRzCLEcDhLQ4fMTkgN07D0Zh9vhVgk+/l0joewffHC5/mNlr68DtgUZo1BzF84M=;7:qVEMk7NBGoHyn0gSMT/IcfSPwqQejSlTxjBlMrk3LsLRboB8EfsfcNsZUqnEllOKi2ib+sMv+bmQ5/ZXmf8auPVywVt66EY3jGuANFaXoRyzy3rzMffD009fqcOowzneUt6myhMZO068lf28Eorkld0v+VHje9vbpkvzhH+qQzZrxaua0zE0rMNJDoSFngz0+LGg8/u0SF5Bd2R1nGGnsih9lSzRY3aXRjgNXT9tv9k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 16:58:12.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR21MB0082
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My name is Derrick Stolee and I just switched teams at Microsoft from
the VSTS Git Server to work on performance improvements in core Git.

This is my first patch submission, and I look forward to your feedback.

Thanks,
 Stolee


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

A performance helper `test-abbrev` and performance test `p0008-abbrev.sh`
are added to demonstrate this performance improvement. Here are some
performance results for the three included commits, using
GIT_PERF_REPEAT_COUNT=10 since the first test is frequently an outlier
due to the file cache being cold.

Running git on a Linux VM, we see the following gains.

| Repo    | Pack-Files | Loose Objs | Baseline | Patch 2 | Patch 3 |
|---------|------------|------------|----------|---------|---------|
| Git.git | 1          | 0          | 0.46 s   | -87.0%  | -87.0%  |
| Git.git | 5          | 0          | 1.04 s   | -84.6%  | -85.6%  |
| Git.git | 4          | 75852      | 0.88 s   | -86.4%  | -86.4%  |
| Linux   | 1          | 0          | 0.63 s   | -38.1%  | -69.8%  |
| Linux   | 24         | 0          | 5.41 s   | -69.3%  | -71.5%  |
| Linux   | 23         | 323441     | 5.41 s   | -70.6%  | -73.4%  |

Running a similar patch on Git for Windows, we see the following gains.

| Repo          | Pack-Files | Loose | Baseline | Patch 2 | Patch 3 |
|---------------|------------|-------|----------|---------|---------|
| GitForWindows | 6          | 319   | 7.19 s   | -91.1%  | -91.5%  |
| VSTS          | 3          | 38    | 7.83 s   | -88.9%  | -90.9%  |
| Linux         | 3          | 0     | 7.92 s   | -87.9%  | -90.2%  |
| Windows       | 50         | 219   | 17.8 s   | -98.6%  | -98.6%  |

Note that performance improves in all cases, but the performance gain
is larger when there are multiple, large pack-files. This gain comes
from the lack of in-memory caching of index files that have already been
inspected.


Derrick Stolee (3):
  sha1_name: Create perf test for find_unique_abbrev()
  sha1_name: Unroll len loop in find_unique_abbrev_r
  sha1_name: Parse less while finding common prefix

 Makefile               |  1 +
 sha1_name.c            | 66 ++++++++++++++++++++++++++++++++++++++------------
 t/helper/.gitignore    |  1 +
 t/helper/test-abbrev.c | 22 +++++++++++++++++
 t/perf/p0008-abbrev.sh | 12 +++++++++
 5 files changed, 87 insertions(+), 15 deletions(-)
 create mode 100644 t/helper/test-abbrev.c
 create mode 100755 t/perf/p0008-abbrev.sh

-- 
2.14.1.538.g56ec8fc98.dirty

