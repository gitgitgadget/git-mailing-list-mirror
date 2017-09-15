Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D7F20281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbdIOTWU (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:22:20 -0400
Received: from mail-sn1nam01on0119.outbound.protection.outlook.com ([104.47.32.119]:19075
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751632AbdIOTVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VzZ1+bKKxzGFcNlG4PvoEIfeJNfpzm9SA3bKWkpK8/4=;
 b=gCzef9L4VQxMqT921GZ7gXESS6grODGQQTO0q+DVgi85qpL/KW/1UEcQIm/ty208bxb/xZzJE7G9r6yhKK7ksDBSN3ZFgdEsUtGcq5WPylu5/hJRLQNM1q3Ssr6Oqn1PcrZbz3wRH8BwM6gF8SqHsPGMiqdiK/zMmGtb8dchDP0=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:17 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 02/12] preload-index: add override to enable testing preload-index
Date:   Fri, 15 Sep 2017 15:20:33 -0400
Message-Id: <20170915192043.4516-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170915192043.4516-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2201CA0010.namprd22.prod.outlook.com (10.174.119.23)
 To CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7805cf58-7758-47c0-7a47-08d4fc6ef188
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:yKLXmAVOWU9PBPf2Q3ZzG6dokF6cyHbGZF6Xpa5e+ga1pAchIYi698uKb1420RLMxPUXokkQ5jGrIr9C3K1Y1PbVa6X//oFyu65y4KAdYII15d3UCMUs0Xw0mLiR63fdttcIk2YdMwkltzsGZNGFdY7+IGYdYnDPSo/Ys/Sgb4uRAm5is+Mxnc7or1/npxkXbFbEU2mk2WgJbQO76rFXdLvbPGvJKvqKVD6/PsC0QbmHQcYnAtY6X3bA7Sd07HAn;25:sdmDI4PiJzCP0du+gch02vVFYszKI34dkP3zpf54PormvWiUZkgSPbang8eOgaN6IsU00Z1fv/EwBPHs5cPmsEFTMVmbq5JB68sZ3nES2g3lOEh4V9srhsMee4oEuS28ryB5Kt6cwi+HC3b6c1Dw9Tfdt1GRnhwxbu5m7Ew492q200y3KTBIFXf7ajwkbkSEv5Fz5cRg8ry3A/2X08uFtycZDRsRyBUDpYCGL/+zFa2cl9+GVkb5fX1vNqxjkj2nlP5PTwuiBHM3TGYp1s1NXioMJAs5GFlH0TSZFmLiZZOvFFpaGELih2ijIER8ksi6LEGyn+dxIo3glr877fss2A==;31:IQJIpDEAD4OMsvBcEOgqZStEUivAV7EyuyB4ae8jiHxQ5VpM6lOGf3FLVhv8GO73Jrl0qUZJX2VYJrjacyMb4tkRCAnux7uMpC/pnrzG9fdoBLki+mCPgHaHiQJEPRVvA/fZcNyRcVgJEBwYb2jkJ9uI6PxmYhasKd+KnIv7kpEaJGR2P/QQFFkXtwQC9JwrSgdQ0GV47I+LVA04MP6vGiW3VEcay7Tz1xaUjVU3cKk=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:xX00NS36pdxD/3gwM7VUiht1jClTTWO+Wv/idC3Kd3YhcFKPuuTpnzOqufcqYfkT/pgK50+i3JA/+av2cnDInwPt4nu609q9fvnz2sIhwxVr/f5iU0S4QgiWkEGR6JHLeZ6/dWKXZhfMwTGeDZopFtqcFlhd4unMKnfOB/Y9Aeuno2lmstIq0JNIr4r4NbNOqgkWssP9PMcjLRy73ZUekZbJyqThPEkLbRu5Ke9PCJ8/NNnoE8NppsX7xI/u7GVKvGjP6ReBqIO2Thqsw6DrSnB6+CCnHHcw69r3vOKiGHBU7+S71oh865klFxtEANhOnx3pWfp7mObxzxroY/Kz9K208Sfz3iTlfm/5sWeTuCFTFAkSSyJMFTs2OCCgodltcEStzMvrcmvq+G0c/okXf6Bct92mSo7pi5kBhzGh8roc8IBEMo8/2ZEbg655JX20ZbAGb116q8vg6Q9wHCL1M4syUUdgVkb32vtM4mfK8YWpubha0qL3QivC1TwTAFZM;4:z/3tkVdty9Fbb/0KRzgN8PUUfiqypwUr9VUThhggL+Qls9GBEO7hUq8EJeYVWvQonpvTxz4y/2vpqI+JzlcRI+Dcvx71LzuhPvvyEQkqCL5gkgp5WgT3nYk82Po47luZ7dNH20tQe7WLTNiS3SUHIxHAeco2fPtDJrusjPOJ8unhbggpFAvANRurCHsyc+CWvn4o+9hHgEorvsk6N7P7wccG/++yqsZRuj0JSezGbboOyxAEO8I+Vv3wvbDdahnlKcfQfxbKjIB50SV2O3qGMH2Y8OwRNJYXyBbKlSJkvd4=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0469CE9DB6EAAEEEEB06E1ECF46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2351001)(50986999)(76176999)(22452003)(48376002)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(16586007)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(5003940100001)(66066001)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0469;23:6LFut+VEmF36yiHP0u7Ax/S8Nlng2o+uyJcZ7jhtv?=
 =?us-ascii?Q?Am0IGk2l08oNX6dtbFmvZvEMfBrD5a5aRDX9YEeCHC0mDXcLqHRKRnbQs3YH?=
 =?us-ascii?Q?WCRftDKPg1Mnpy5n9ogXnCqXyfEkOaUlphB53iyDFL9Qh/1nDJ+TdN4rNN2H?=
 =?us-ascii?Q?NJSWaU64rURO6m+5PYqFyeLFhdOigimn84DJNUTgpgTgN6Fqhwfry01iOeYf?=
 =?us-ascii?Q?1hRKUsoF4iWnqGDv8EREV8ZivMP1IiF7wcJNibcuuJPfk+t3Fpg7iOXQz21J?=
 =?us-ascii?Q?t2Lgv7EzlIXM94UfogLcQOEqVNu7EMKJ0rtJQZ3V9XeJQX9kncGaV1F3ZYi0?=
 =?us-ascii?Q?Qg+/NfB/MVEBtWePIBoucaPhi7qjiTu5QcVBuSMVCs8W2TCH+FFrIvwanwzm?=
 =?us-ascii?Q?CVBOgY7+65z2KAMtUFOZ1VPbD3xMMWnj9mHtsiV9g5QtCHjgEbKRfvbGm221?=
 =?us-ascii?Q?LYh4nkht2KxznTKTeUYovDuNJ3bRe2JfnRWwh9b7tjKlkenaB+ie5EHU27Hz?=
 =?us-ascii?Q?YnMSf2OVpvGlJ1mDjoPZsCKFmvt/4hujSRicMTtoUc412pJeEOJryLbQlHB6?=
 =?us-ascii?Q?VpQcoYr36yV7YU9Dnjoec+mlT9DYscUu0NKF8fM7J48p0r4e2r+MMM6y5A88?=
 =?us-ascii?Q?wP7oEEBHG8ilINVEOiKg57o19/BAxt3yKc+uOMMC35eqtC2qO/I0ffvA8eok?=
 =?us-ascii?Q?agiu5diaNDRctqgVZ+Dz7eo+Mn5I7+OS/EhN4CqCuYID/JkiCBqyjYsjpnuz?=
 =?us-ascii?Q?5cWf3ox4aIe1jmI1wsXbt6SfrijhU9Qx1X8EGhN8BCefzvKsLa/onzp806kN?=
 =?us-ascii?Q?Al+eC4McpgyR0JJlnCOZDcan5KNkMgyqejobhxvL40u8bi6NSUM7q46oP8U6?=
 =?us-ascii?Q?/LDLqRfEHJgDDwn1rDBp1ktH/xRiEuYTXOivj2MZB4I/wxYFqCYp/cKP/S2L?=
 =?us-ascii?Q?OQoKaLuE4wkTx4OYV9arqB/cO3s3hiOySxijRg7KD56kgar3jqwrLhFcLsNV?=
 =?us-ascii?Q?YNwKPm0WxP+NFhul8rzcsBU1NHhDbw+O7GDGrBEYfKHrPXHgq796Vl07dP6S?=
 =?us-ascii?Q?O+lvK34UK29GJOmp8IIoHjdr/AeO/B97CEaiMP3czCSArVlRCq/kPi0CG/Zw?=
 =?us-ascii?Q?KjIih1eEsca78MNPSXtuLcgRSAgtHfip+f79Bhf1rj/3hOY0CE4sc7v1iyIY?=
 =?us-ascii?Q?R/PBwu91T7qs1gdDdhj+CP+cKnm61TNf6+FSyJ9iJzWTVqenZ+kyNDzbyT2v?=
 =?us-ascii?Q?7VtfA5rYBnty31dpS8pvroKvX6ErA4pDJrb4Nk6aL0/pi5ds19Rp+J7kDliW?=
 =?us-ascii?Q?bNEAYqjcsial/88xo5j3T+Ka/2HzMVvnKrc7PEEp/yNWa4RQznBFBeEvhcFn?=
 =?us-ascii?Q?gL/Q7uhEIxekGF+EE0lF3HVqrdFecOz7ynobbxI/22OuvBH+XaFTcScDLkt6?=
 =?us-ascii?Q?ojnqnJs+p2dYfhZADAyPeJjXAnc2P5PsukxPxqsYGhhdpOjGRtb?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:3vYSb/fXGU2WOJDwhYWJSV7Ip6DGmh0TSpNvVZ84YBbIuFbf7ORSlOojNcLypRi0gcdZYVRUBChN+PI0YYCEcRUU8zKvm5NLPVou2md+uBTwsZCPIcssl3ilTtD3LfS54k6PwZX88GrW112Pr+aEzWuF6GcthADSrsaARMLjXBGzqe/NbkB1Ppl//63dZxmEb6ISJEQAYG+VAIJdHrBWlxzRZGsJ3APXm/8o2bnWfiBqblRWc20+2/5vpyzVSAFR6EZHJI8RPXNat6xFesvvGW8MLigyEGcUdGEEJ6EuX4azSs1H1yHBqZiB4Wr9gA8AEUixsWqhWtJMEJCiAUo0/w==;5:Njq5eAcb2q9mIGtc1q4pWLD6WLEWfky5zSDSHcfOc7TvnklHFnhDh10014Jps/g3EHkFd8UoxnboLmfC6HxhEUxreZeRyYEjQcSl+WLXZ7EYwzmS5afp+8LWDPU1guMpoVpJddMAZUK873BTF7VdvQ==;24:5K7T5Lg9ehPx+wQlbIbZqhtEuQEZVOcaDmIj0PQ0LsbPHbavXiyvkpEwrMdAOXAjIx+NaU+jNEGLN6WFgTOiRDDLfp7icOe8yEjSaJwLlU8=;7:7Y3dm2Jb4pALBciTnJDha62btlyNlD6z8E4OCruOnnoQQx2Y/0IfSfgiGl7QFZi5e6Vnue5mPZyf8jdSTgzxF4BxJD3bL6Gxt+58A2Gb6q7y6aJ27mCoXbIY8L7B8a7ey81vvbuu/9zLBSoe2M9yC9S/QTdN/9yKJfdKo71dAPkv1Zc4zI+SwEENFzAQoYh7gmhKlMTVJFyqO5tgqXHkqgJsdTNRrQyY/pIDscmspvs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:17.8219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Preload index doesn't run unless it has a minimum number of 1000 files.
To enable running tests with fewer files, add an environment variable
(GIT_FORCE_PRELOAD_TEST) which will override that minimum and set it to 2.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 preload-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/preload-index.c b/preload-index.c
index 70a4c80878..75564c497a 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -79,6 +79,8 @@ static void preload_index(struct index_state *index,
 		return;
 
 	threads = index->cache_nr / THREAD_COST;
+	if ((index->cache_nr > 1) && (threads < 2) && getenv("GIT_FORCE_PRELOAD_TEST"))
+		threads = 2;
 	if (threads < 2)
 		return;
 	if (threads > MAX_PARALLEL)
-- 
2.14.1.548.ge54b1befee.dirty

