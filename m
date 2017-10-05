Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52F62036E
	for <e@80x24.org>; Thu,  5 Oct 2017 10:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751922AbdJEKpu (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 06:45:50 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:24320
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751494AbdJEKpr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 06:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=N1AKlGfl5/rMLLyEkxpNojetO/4UhRtjyAdQ8/UBImM=;
 b=fM1JvMS0jYhsKQiRKCC13pvIz71PQBvGIaDcTyhQR5wxXRRzlc7RrZExZZwTA5HUCYlj96ZKhE/bvevony8m1wdv2ZHuBgPqHtxc1SvfCUdRv3ZNVn1VTyePWvJoqXm2epbiQXHRFVPT92BtvJ6oj7vprmqbBOYhZzmaOXOrc/s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0008.NAMP136.PROD.OUTLOOK.COM (129.75.90.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Thu, 5 Oct 2017 10:45:43 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, t.gummerer@gmail.com, jrnieder@gmail.com,
        gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 2/2] entry.c: check if file exists after checkout
Date:   Thu,  5 Oct 2017 12:44:07 +0200
Message-Id: <20171005104407.65948-3-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20171005104407.65948-1-lars.schneider@autodesk.com>
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: VI1PR0601CA0016.eurprd06.prod.outlook.com (10.169.128.26)
 To CY4P136MB0008.NAMP136.PROD.OUTLOOK.COM (129.75.90.87)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1991e6a-e86b-40d6-497b-08d50bde3b88
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:CY4P136MB0008;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;3:YJ1ngm9nM/zeSiPYjRua98i4U8IkSVK/WrWU8M8BqRuo+1EPR8U0QAs3KnljSfnUkx2cMAZ9oSSl2GUUj/C91a5IozKalBh5eQZVwWp9TTiM0sVdOz283DK7HpKzbn/joSNJdGN+HiwA3YVLcp1i3dMqLzYXcmNo5HwsIkJczWnK1YrPB66kII2Ht64fmnXXwbs2M9fkXxWv4ws8DRfsMr21DtFS6zFf3bg3KnPUh3GLZhuaGaqLawuobnAmxone;25:XyGaOHxMfb4IcvmxQ9o8pmetUQjsIdtZonL76zb3NUkrTbR/oydc8mPm2SWqjqgwRTZwRJk6OMbNnKlRREwW0mGGt7Rd++wIZnlbGuH2Pcpb87sWSl9RzPP7cKpssh0jBmFIhEVSROztGvj3K/TfEE42dIAkHZg0ibdUMQ0+6+h82DID61eiWFC5rv7Eg/COo53hmdBmSu9CPzhGRG5m1ekBQn2YkrKmCvwnLlxA9dij0thk0cQrix0NHYt4MQH69bDKCa8AXfLIRD6elvkivLl8Ak5p8wEnEtbUm81MxUaWKv06cU9UyNxoIBKZlV/EkNoj2yn/1BpsYDGMEBSsJQ==;31:1L4ocW+5sTCwLrq2WfAnw42jMP3vKqcv5zTCdSCgy+F/SmKlooI8whHMq/sKqaz4wMzM86cqPSVvjjl0EMMWN5Ge3Ju1/maXN6EYHmDrgwcRmjL+m9c+KrUmdr4WDfa3nMLR+fNiI6pcVbOMelEaUQgXPecZr47Bujbs69ymtuYYWcujSAz+6IUfacYIPPT9AfYGWspz64G1+CWocvPcTwPpahx4py1J2b1IV2iy/T4=
X-MS-TrafficTypeDiagnostic: CY4P136MB0008:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;20:wxgpzGYaq/smS4xqr/Dl/G0kBpFawoj5NBFvhf8C1zvJrO5tp8+JaTvtnR7FRFd4pzvqWfP+i9XXE8AhhCdBqTVffyqsqKR6aaF3JoHRT2Psrrcqt6DTv4/xz8I6YNzAkSgSOBNogQnlt4B6ZRSNWIbbTsA41hRldcIgBbGCdLVLGoY4yItc19RSBPWOr/soOTnytQjQIWcFLn85jCMpwISGG3E7V8rdPE8AY9yuq6nV4eodIJmK7+uizZ+E8hVYHDYJzqVJAcmwZE+ykAnrL4ju6/NM9h1a0Sr93OG2bPfWzf14n46lsmGc9WAo6dnmNiXZKeY5g8mRU1SscnN/detFuHLIU5XnbdbD4cGrB7+TlEZu23B9sqj4EAib4HqIJblaWUGQbuIaiHXW6FlxnODyFnEayRpJJSAW+iJOZawV3+6Oeui79ZEfBsKA3KSUoMLgpe7nkSVCnwk3jXGUR4iX4ldOS2dsjwMqMcsg7wdTELpne3VMZE7rIWBI9Pfr;4:KfdoyQHDC+LbYR0lr8KXKLQPUQg6zsKEmD7kCwOCbbJz969wEXG5z7nEgzJushO/eWT0hgI+1RthRz/i9oA6WNUkUujRczMG1XGSAuLsMBvtItHdCF0M08RTtoyDmRu7Vl52Em7y1anv40QtHifyTXxsicxiJsgJp3Z4oBAMfgkYbUUv9Mned6MV1R+BOREiVv3weU5hgWSXkEiUu1mKwsC/DDygWiQO1w1p/CtunL0h6XoeHylBmQhTdd6s6dI0
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4P136MB0008EB9DC1739C1816D2DD7BE8700@CY4P136MB0008.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041248)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4P136MB0008;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4P136MB0008;
X-Forefront-PRVS: 04519BA941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(6069001)(376002)(39860400002)(346002)(199003)(189002)(76176999)(16586007)(2361001)(4326008)(105586002)(25786009)(81166006)(6916009)(48376002)(68736007)(7736002)(316002)(39060400002)(2351001)(66066001)(97736004)(50226002)(3846002)(6486002)(6116002)(33646002)(305945005)(47776003)(106356001)(50466002)(36756003)(8676002)(81156014)(6666003)(2950100002)(9686003)(2906002)(6512007)(86362001)(53936002)(189998001)(5660300001)(8656003)(1076002)(85782001)(478600001)(101416001)(50986999)(5003940100001)(16526018)(8936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0008;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0008;23:A9yzpp8xICSCCHNwNiMLFvYvWvd5MwiHAK4jNOV2X?=
 =?us-ascii?Q?btnvbPO1W4oKZzeR/g7+dG/aQVOfwk6n20575r8WpIs6oS+WQJ+HvXhl05S3?=
 =?us-ascii?Q?xocvCEm2MTtCKj1ruhdmNWrMSm4l4ODx4qVpRPtLJb55h3EYfZjPq3RNnK88?=
 =?us-ascii?Q?U9dQr7SKtSCB5ZOEUZcySgWehcZMrNNw6OReM25GZv+yyJNYSKbPFDjIGLU9?=
 =?us-ascii?Q?pDQ/tnZ5rsPeTzeXheles56NsmWYFYUtfrSr1bWbqE3fsxYWueKbwNhxpJka?=
 =?us-ascii?Q?3mEOibO+nN9gMNXjxi6DTbcuiCbZPVtYiq4L/FI99MnhXNssuJGfoPVVzLUu?=
 =?us-ascii?Q?PZf6RZH70bRPT10RFLglF4KbMxbQyPnGKZRsyiex8cCo0JlGq8vM+IZrjVaT?=
 =?us-ascii?Q?w+ZP9NVa2jWITXN+cOA/UpjOsomfMIZMEjKfw7KqVSjZBSDCx1jF7qPS7SPg?=
 =?us-ascii?Q?XuxuBb37tP5/eRmSmjw4Vcq/20yxSiip0IxAHJoYhQN0nvVKEw7zToBKLJ0A?=
 =?us-ascii?Q?ve5vHGGMcdKZt361juuh991E0/WwoS2L4zyz1zpGW5oLgU11XU5xMYetzra2?=
 =?us-ascii?Q?2qyETjgMsWw/QEueoGzvAYSz/+6/VcBcmLsU4syTaro1mlB9u9Af2DidWliK?=
 =?us-ascii?Q?V+1xQ4wmrFWT2DjgOVy/HHb+MwsMXjMKnPx1ra4DGFYZM7dpwfFfgnITovDm?=
 =?us-ascii?Q?nNZ9X0Nsa82TwFhAnsVCpfYGt1eFJlKQCfurcYuZr37CKUqXoF26Ni3EbmUk?=
 =?us-ascii?Q?fYszK1M5A+vNNp4kDxma+XPjn9BDEGLKpdDTWjv0q9FgVG6WJaeluu/skjeu?=
 =?us-ascii?Q?3N1CP7iEXr5OpmvtQ4hVqDZBiF97jcCl+y2WIU61QR8JnJSZaKvVcLD2DbRT?=
 =?us-ascii?Q?3cEpOJpEUHj9UL1Zb4Hx3VjHRWamE7WtcqnFNQGtSO235rv5p6hf9QnEIw8U?=
 =?us-ascii?Q?JirYjpSp6YtiemVjMbbV7xXYgbzLo9qK/mV0SH6ocusB+wCeOGumMRGSZSUB?=
 =?us-ascii?Q?ccdjGHF1bKQZBZ1De0h76xI9MXX+xdVQiNokEZt+9AkJO6uKm6rGi4xilOO7?=
 =?us-ascii?Q?WKvRyboiuex9c7eeKf4VQ1tiYrPTHj3ta5/Xjv7yKmaOW0SwQhwTSv/K8klz?=
 =?us-ascii?Q?kW17J2Q5Znc8fUYG9EMSadwnfKJg6pd653aOep1k2tR9rWJu3cYfjqyt50fq?=
 =?us-ascii?Q?rNd2hXuA27uKa4gsC3dNFchZX94GDx0VGKsK2eJpyjp5eVclIQN1e409RBd7?=
 =?us-ascii?Q?TPstGY9xLe1Lr+EuQw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;6:KE4sQOzkDkg/3eRy+i2W1qF+K2ncnFDdqECcPgCdUPd5UfmUqlv1kUH+P6/bdcOObmAc/EkwQARg0Gus+ekxwxHors053kv2NQ0v9iJ0y23BDe5PJ6yIVSCLKvqPF+gxRbu7C6p3kps2D2rLo442kdcx5g8YGpnt2LGMpTyT/xFC6+zcnaT2jrOlSB0+T8gBc8wXmKbho1k1jX6PZoW5eGOsEATeSOiHdE17zKjGeJ2wf1w9Xr7inRBuFrkA3wAfrOCVTR3usyEmwv3vobEfoEYoShe8m/1RjXfIiZ/uOrAehwGQl5JhgIBdj038uM0tENJV+mjsMo9UuyWeAVd+9Q==;5:acMhUkspdmW3Jx312sx+1gCuUEKA8qKRsh6y6JNjVyquDK7dwBhtKorQcH/M1rDezjFYJYk0FUYcDSbVaCBb/Q2u5n0ExT0X2T7ZRNTs8MTOUO54ZIKKZWnKvRLDJZaPhmcLESM2maQBbQfkDcsYQA==;24:sp/T6t5ZI7P8PSCvvJ0bC4SYlt9AtzaQYQgB/ft1/Mp8kw9K1sCkW/J2cEy5mMzH4ylaiKu+EnEaJvZ1cuq4Dd31YF5+cg9Jy9py50Jb6JI=;7:k81uc84Dxd1601pX2MXcWkBReMWQKh2kMpWJ9IA7+NkiuqsPQ0J4ABUBdeOwANKzDru7p0W6Nq5642JNzrJx2509Zh0fRodzjfQER3/nAhPcsMoX8u7iaB3s6Ng7xSWCG8e+7A2K1Iy6hQoT/iTFe15qj/u1L0MdjSSHzEnLGnRS9D0H87cZKb2TnlATaMI8arIuATEvHdIk8fyLBVy0Cf77xy4g31H1GcnCKbzOakc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0008;20:I4KGrLDyympVIoIP8+2yMcliVc9Fota3m1+PWTiRt7bUJ8J5DjJtXwdsVDi1h7nkdLjMjtp1+Bb4DTVwmncEsS+fAuyz1OF+hX12+HKAOiVbi4PlTK52oZ7Az0pQusuoQxqrl0OxTk4iMouZew178gLdMUYS4V8iMtk0Q93PB8Q=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2017 10:45:43.6288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0008
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If we are checking out a file and somebody else racily deletes our file,
then we would write garbage to the cache entry. Fix that by checking
the result of the lstat() call on that file. Print an error to the user
if the file does not exist.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 entry.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index 5dab656364..2252d96756 100644
--- a/entry.c
+++ b/entry.c
@@ -355,7 +355,8 @@ static int write_entry(struct cache_entry *ce,
 	if (state->refresh_cache) {
 		assert(state->istate);
 		if (!fstat_done)
-			lstat(ce->name, &st);
+			if (lstat(ce->name, &st) < 0)
+				return error("unable to get status of file %s", ce->name);
 		fill_stat_cache_info(ce, &st);
 		ce->ce_flags |= CE_UPDATE_IN_BASE;
 		state->istate->cache_changed |= CE_ENTRY_CHANGED;
-- 
2.14.2

