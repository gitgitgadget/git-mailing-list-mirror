Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5831F404
	for <e@80x24.org>; Wed, 21 Feb 2018 19:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeBUTRi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 14:17:38 -0500
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:53852
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751376AbeBUTRg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 14:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xCi0pC8K1GL/HMos/Hg3T+eJLreiEOnya7sv3QV7OsQ=;
 b=ABAqFS6PnvG2kvDlc6mhdTd5Eq0Ddy1h/MvTo/ne7LIDvNkC8xGa+1Wck2f2D28s17SDjStQJ/66f/Ud4vsU0ZEF3dyEtBofeUI2AObWr5JJLN4snsShN1irQE4cG8tMr7S/OZashMIQte0NH+NX1tS6mE4MIzFMzF3I/emIPak=
Received: from stolee-linux.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:7308) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.548.1; Wed, 21 Feb
 2018 19:17:34 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] commit: drop uses of get_cached_commit_buffer()
Date:   Wed, 21 Feb 2018 14:17:11 -0500
Message-Id: <1519240631-221761-1-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180221185204.GA8476@sigill.intra.peff.net>
References: <20180221185204.GA8476@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:7308]
X-ClientProxiedBy: BN4PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:403:2::22) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7285252-89bd-4ddf-26da-08d5795fc309
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:3XeOhfZJksmEfBhQOGEp600sHtuOGsOdMbD5rt7gIijhDM6dzWqX+yt0bgIIAmN04rvJ/vKJV2iGrFDnp3509seaurt/5wBAFNI4XSp+c87sfwZS9Od+y23ctao8IF5GCtWnpGrIg2eS8J7/9k+nTQ6EfXEXNNo+paJoHlrzrSFZKlc7+dAhnfnfHiGoiFq+1bNegTTscEHJuMaC5F2eee1KF/AFen893KOMM9IRjEwMxSCPgtR5SOV+HS4K7Vnx;25:PfNcxAev39BkquevB0uaLpEzN2UF9NeSh5HG4Rj+1Fre41SJpJwt7DuERzE533cFz3aXLS9GPjnn5R8WAs0jYyzQSfkqlhNyMbW3Rp8Ty0Cv6TjtVtknZvN36qFJyeM34Jc59gGvieTnu0lqIjrLMvgufXypUQvgG5Qodbxy+UHb6FY5KY9jGqQA24LpmMsg86Irc8dAHrh+s5c7kwgLwb68Q5UzLSqRJp9TlaWvrq7MAmiDV+6eDWPE34UED97p9XuH0pDN5pwconAY1o/upGgEhnFCGxZ+Q0H7S2VqmYs7OkpznaRBvcDEg5NoVcZu3JIwzq0XTTOee26K3AiSwQ==;31:oTBmIPiouMh5M6yENRmLuuIBizik+4s6LK5EVQ1VbsrJhNPXqeTAOvj6SpVtLalTyGH7dmTj78bof7tv3YiV9asexZSIp3bsady2qTXGUmSZPDu7aHF285PX3T+J/jzPYBvPBzMeaJIMgbEYBG+wMSkoAISvB/JVZaKXnXNaFdOQbLTNofGBfX7rE4PkNWIsghnvrAQSolbLe89UfHZny2DXAC1hEU1on52YLlp/TQ0=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:tYdR2UUyvJocwOkjaRpYiLN+o+q3O/DDSBfU279XUjedb+WahZyLiNbfXoYdN3v7GwsrjO8efP8ElbQ/UAF5uO/xHcv+XN6hiQgDJAt67AxkJihaHPyUSEFa9dzbC16Js7fhabC1MBxUwpfLQ9DpjVF/oZxx96AdAZBS2iEEIQ7UTITcinBMc204N6nFtvZTBjz+sHo7PD20lruT0VOvhUUs6gQ+9fNBquNdD4KMG5bwyE7/nw9EHGOptdTTsDzRlZcEyDKlW/kKWsoVGelE+HEZYWKb8yvS1p2DBkj10YcaEaEyusyrVs+lDNj/doXtHONi9i7gsc21Jf2rrsiD/nhiPBoZKOKOB0Uj6E+xnwznDWTnYIogh6fBzJlZSBH2/JNrMfqTlShVjI97+3yN0091JXJhhCy0Qg8EL8tdq9mX/mNTSdAbwUnurFZKTSegh2WulmXFNRzfPP3tHIKdGNqUk3y29nYpkcjra47wir3hn8BF6y1nP+jPC0HxXR0C;4:rSJr3yu6QCNT7rJXtP/0DrRewqR+cposrQRW7uUFYcCVG2JYAecFpypQEyvssnICGg/DBvuF3ViLhSKTemN1D7vpQeS5+FzcgsKUcCMngKjUHv+TwePu8l6HTVE9w9YoZmjLeG/wdkc0kKki41bT/u4TtPAVMrFaQIC0/15/g+9rDO6tdPXVv7ZzmcQ0XIZH5wre+t9FYoqnPukOre3pHExIyl3KJt48a7VOwebBMc9HCAYYLy1Nd6RfbxmH0Rw6DEF6b3nnOelZ9/RaQzkc258pdFhT/gWY1PRt22Wnk+AMJvwVf97XVW0PF07fcRtx09yvNGrgGStLEpNcA/M01+H98CaAaddmP7KOAxLgZn8=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1011B515312345E16F3AA897A1CE0@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001070)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231158)(944501161)(52105067)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(10290500003)(52116002)(76176011)(10090500001)(386003)(51416003)(50466002)(2906002)(6346003)(68736007)(16526019)(48376002)(186003)(53936002)(1857600001)(59450400001)(47776003)(7736002)(6486002)(6116002)(22452003)(16586007)(86612001)(478600001)(305945005)(316002)(6666003)(52396003)(5660300001)(7696005)(575784001)(105586002)(4326008)(6916009)(2950100002)(86362001)(25786009)(50226002)(106356001)(107886003)(97736004)(36756003)(81166006)(2361001)(8676002)(81156014)(8936002)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:3x3SRDyADo9uT8SQpIWRkwyVH+cXDmtKd2ZJr4O?=
 =?us-ascii?Q?3vDGHZ+MDCNqdtKw+yJoFaJXql6y8P2vXMaor7Thb19fRh1XpvNQRv7t1NbK?=
 =?us-ascii?Q?RDKQFKH5ilIN/GetFKRrDnilGaLhnUQNEozL6Ls8+CmyNfwie204G3zbqsbi?=
 =?us-ascii?Q?mk98ffBqVRs4D7N4+nTv8uC2pTdGJDS4RDmN5Jcqpcdv6KNPKuIr7xoewHqm?=
 =?us-ascii?Q?PYyEVI0G1uK6acCsAw1X6SiteJbUzmK3Jt1xbpMqIHUcV2YHVRW9XLbsll4K?=
 =?us-ascii?Q?itLGbQmwtM85/+5ut/tm+dJwcPtan2GhOJudAnhzfd2AbrIZSQ3IHsvwyzAo?=
 =?us-ascii?Q?sXifGX4EY0KShD48g/FLci/7H6rBbL5dEGF2eYPQfeT+UR2BFO75m6GgbDaH?=
 =?us-ascii?Q?2SSkuSzEJL0p/HEhFGstxlLj8TwsrAIV9RucFD1MzscAyAEKaizjvLdNLAFB?=
 =?us-ascii?Q?3vo2IUheWYjTs7N/hLz5Cmf+XVKg4eOfMH9M69tbQPfKj17Fne0R+9qNUEPS?=
 =?us-ascii?Q?rUuoNHAwj3uVMpGWa6SrNE6szI4Wgw6qTtpXxWj5IOzXygIP4aHS53z+EeIt?=
 =?us-ascii?Q?PQtMoBfPdGbF85Tjegicja6rmPwESlcfW/x/Ok/LN1kAgcpin0QwiQVTiDJU?=
 =?us-ascii?Q?erE6uTbuQnpOZxU3PMVc+/KBchTGD/42nSU6HY1ZeS/cvbi6NuXZxrzvoEp6?=
 =?us-ascii?Q?TiOV8XXPreHiGgAG/EdoieMiR9GQIjxdR+XJoRM44zQefFOnHAusIACwwTOc?=
 =?us-ascii?Q?ltUpKOfc9I0gGVw2Afr+3nJSBtl/6d1TyanFFqEUK4qKBahr6Exn7gyP58VI?=
 =?us-ascii?Q?TGmEPAl8Ss+Q6Wk9czNILLQiK5PtOz1Jwkb22TFVkAYU+4KVSOWSMqvpyt1A?=
 =?us-ascii?Q?9wktd946wXEoAqKij0hb7W3RiRVoq2SDffxPz9f6XI9JuO7JaT/kJlBZQ2wi?=
 =?us-ascii?Q?IJzH2npzf97lU191CYzBNyJwFaVR6V1Hx8SsRm0ougYkydquk9zYHP7CHuPA?=
 =?us-ascii?Q?DHJZZdRL6MVMCO0aY5krGtNDEQ1WFY1dr4MP9nG1FcsQetlMKm8SuV9m5wCr?=
 =?us-ascii?Q?Hh+xt7XGDovFyx8Axb+9MRj8ju80yAStM3yGqjTOdxETRuVGQsBWPRZLe0RR?=
 =?us-ascii?Q?PABUpN/dfMDu4vIhjkjj4fWpjabBC7D9B9IzuZhnTGmj0VqiXLQ5jfl2a8Vz?=
 =?us-ascii?Q?87a7UbhxLvRPv1GR6XVZnknh7BfEj0Ej6f8FRYSSynBTuEDUfrjGX8taoXKl?=
 =?us-ascii?Q?lMoWHgT/o1Z6eUMk4q+zZKYcfz0CVgxLLB8Bo5FAgeZpo01HbKn86DVj279e?=
 =?us-ascii?Q?3OQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:WVZqtqL3Gn32iCtC4bASN/pCNkHJ0ymmDzF6GzHrq65RU2KJ5PxDYQDN9odflRJ/t2qP/kwcmJ4celYQt+YfAML/7qZl9IR7+7hxclvLbDz3lfpOgC+JKimZUGFpsEW+OSb/bPB8ILre37UAlvNUFN0KT/CurSUJ3RFz7OQqiA+gquXsDXG72QEoBss4t9FJk0MR3yPGy9RNrKA1oq1LUF16GNCU/GbeMGrY+l6M1F16IoRSnEWXciQpWdZPueK/xH0l9V1a2u4VuUsTboDbTQBgmCpCa2967dbyoU4A9mEMraiC9j8O7qEnOkBifUKeRTL/wzcvShrKoscEclStGPfJoQV1SWMmKK5VZNukciA=;5:QL9bdJTcm9XkOgGdbbT+rhRihRMSJIti7BgbCXQOJ606x5e8vs/98rDFiBP6k5B/A1SJnPr03aaM+rpJLCWvDVAIMKzABWQEvvCdmRQWvVqQNEErEPPviOa5EH2fjyFthaxCfd1QMBDtk8NKO873n0nCoHtUZSyfoKJ+vrOp+3E=;24:0p6Y4TVhzP1YSCLDpgyJWnBehaKecz7DQCIyqTU7kKiQ1cx3r4zeOmq5O1Ii97j0wJ3nA/aV5mEJ9KsBESh36y06cAQwmRzgJCwSa8maLeg=;7:vfwknrF6/s70w/GlShFqpFW1g67de3PJ923PZcJWjtqBAIa+hfT2ebnnvgZNXCFrRfDyDQuMnZUjqbsCr8cYSnoYAXfi0LPlBpZ5EQXPFAtiLPk9ovH1KIdhV/KX5LYJpI1IgI4lh4mP5luqKxxuDnAh345pQgyL4ZEJD4+H6C5o1KPt+LYRGuqTNzbN/wxlpexgdv1PktKBNMz/5QL0xiBhBCy9nbqRy/E8TnK0m+sFC1yG4ggJaJEw5I6VNIVl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 19:17:34.1802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7285252-89bd-4ddf-26da-08d5795fc309
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The get_cached_commit_buffer() method provides access to the buffer
loaded for a struct commit, if it was ever loadead and was not freed.

Two places use this to inform how to output information about commits.

log-tree.c uses this method to short-circuit the output of commit
information when the buffer is not cached. However, this leads to
incorrect output in 'git log --oneline' where the short-OID is written
but then the rest of the commit information is dropped and the next
commit is written on the same line.

rev-list uses this method for two reasons:

- First, if the revision walk visits a commit twice, the buffer was
  freed by rev-list in the first write. The output then does not
  match the format expectations, since the OID is written without the
  rest of the content.

- Second, if the revision walk visits a commit that was marked
  UNINTERESTING, the walk may never load a buffer and hence rev-list
  will not output the verbose information.

These behaviors are undocumented, untested, and unlikely to be
expected by users or other software attempting to parse this output.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/rev-list.c | 2 +-
 log-tree.c         | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 48300d9..d320b6f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -134,7 +134,7 @@ static void show_commit(struct commit *commit, void *data)
 	else
 		putchar('\n');
 
-	if (revs->verbose_header && get_cached_commit_buffer(commit, NULL)) {
+	if (revs->verbose_header) {
 		struct strbuf buf = STRBUF_INIT;
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
diff --git a/log-tree.c b/log-tree.c
index fc0cc0d..22b2fb6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -659,9 +659,6 @@ void show_log(struct rev_info *opt)
 		show_mergetag(opt, commit);
 	}
 
-	if (!get_cached_commit_buffer(commit, NULL))
-		return;
-
 	if (opt->show_notes) {
 		int raw;
 		struct strbuf notebuf = STRBUF_INIT;
-- 
2.7.4

