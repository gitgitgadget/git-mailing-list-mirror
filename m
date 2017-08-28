Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9057E208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 20:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdH1U3r (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 16:29:47 -0400
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:56768
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbdH1U3k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 16:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CwUg+aczM5npCQ4hOq96Lu/xquOHGe+CCHI4GIvEKpg=;
 b=WSDrwrnj507E9HDbsNtBFz+Iyi01nNjcsAYk9Kue/CAO8Ou6IJHEl+nFE0bvLNYdPll3JcfEalT3NBv5cH7P9+/0uz24mpTVUCPEyJmpmJwLsPA7KLv+Vc5CmOSGQQNg7luJaWb1cFG09CRbR+T0TDdip5atEL7dWr2YLdGT2zo=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 DM2PR21MB0043.namprd21.prod.outlook.com (2a01:111:e400:50c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.13.0; Mon, 28 Aug
 2017 20:29:37 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 2/3] merge-recursive: remove return value from get_files_dirs
Date:   Mon, 28 Aug 2017 14:28:28 -0600
Message-Id: <20170828202829.3056-3-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.gvfs.1.1.g44deceb
In-Reply-To: <20170828202829.3056-1-kewillf@microsoft.com>
References: <20170828202829.3056-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:910:14::24) To DM2PR21MB0043.namprd21.prod.outlook.com
 (2a01:111:e400:50c4::21)
X-MS-Office365-Filtering-Correlation-Id: f5cbf94d-1ad8-4bfd-0dd7-08d4ee5380b4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM2PR21MB0043;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;3:j9Kd0XANYjPrg8VHFpDCAE6N6HTNgSZIT3/cYxBHLHCkOJNLLTWFJOD0RHf4I8JC2thlY5OWtLHMfWvyqkCz2TESeUBdz/y+iDpd+J6yohQ55HDOKQKc/gTnOz9Bz1PNGd/ig7/k87hgmluicdgNTpj3VBbjypO1sWjfCSbxOdAH32cNIEAaWUok58Qb2OKdX7enwzodMvB9arSGSx6yBJhLKwo4a/tOCSGkyeWMQmW8CA6tJ3dgF5lD2DBAHW8o;25:SywoWjQg+RChnf0KG/RqBD9jJRZMckX3pDmC350r/WRlnRvysB7wOCtwVD5BCWjS1ZcSwpmvyiDmT9WFdRJAKiBYjGa7Ei8qoq7BW2eylyKTVE52sX5sSY6rqdLrKjq4EhmXRC7hw2usf7dskZdmRN0H6VGfVSj5HokUQsaUQEsYLofR19bs799dyUdQb8j0rUzgchpypLTapHrb9FXBiUj62m390UJftervqynpPOit3xR9TnB+bH4SCs35+uY/yFg83aFkhLbrk36lW9QdR5YS6LH4bkW6vsMSt3hRQTbyQJvpMyG+Ut3purBcunxh7KyZIC0cRPx63zLwR5Ynig==;31:IQYAJi0UH/x6HNBE4zbn+bU2wvQIxkGMEf1cXquePoUcGY05SaqABiUmVgLreDcLGCa/4HAP6c3PsVj+VlZn6ZZ7Lw4XXCEyjdmiyrNx3KTgwS54kYYsuivc2ruQJQVd2A6mBREmaO6qTbbcjAHiNUrKmDD1WOazOMH+mAH4gka04hBq/D54kFASL7vjpzKD8wX18mHYgpF+P+Qzidd/5EKuWzNr2JKWJel9cLAjzOY=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR21MB0043:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;20:xCwjUPq3rKJoLeJ+a826DIIik522IMRQQipKMkQcbS7+4oLTHJP7dNfgyeYMLWrTHyWb6Ta8iHf8Aqvw7UQv92Te92wBaxm7DHskldKJrdQictD49TFcS64fk4t3z9J8pVIeBRkm4/6yFyOBag0OxMXuHWSnQHHJMALaHqmkZ9A6jrnClMlkJQJxU3MNQF+FcigAfcX0yaP920F6WUiBgq6w/Bmv2F1Z85x6gZcRg4REDpeI6Bo5oDb+0mezhAkHV+Loj+fMoJEiAaMoCodv9pZoroa7EsUOC90vWkWLioRdMB8QqDhycsUkI2SM1Zdb0dkQEl8vGt5u7+PxSDuU6zb1JSSgW1cMj0jUyjOfw4Su8PCyayhOXGxKS7pLvdaPtJJ9jkjVYm8y8AeB3mUhqpfTmA/lRfAt1DDWDrJX1ZvQ20etfL0olY3aKxqyzp9n0xZ2NrD6ynQa47xieX/7jLvdSH8sY43mSKQsPQT+eEjh5Geq7yFS3Hx4EJtjoJTe;4:VeU1GzsxqYtGJoPAINT7hFPHKKoBSLrAWDEp+4WxI0g9+j1i3bC3cLrBMKqYupC5hjVhy7LHzR8zLTCJqTVo/iUYX5VRAcPR+POUfkQ/jDWmZatqLxVSPIwvZf7Kinwx+gXH/IW0uys2m0hkiiFrpFvwUFERkbU+x2vNtmmqL5NvQWEEOEcKS/Rvwo7MOY1wqvq1KvZZ7ZxLV7yTF0p5ph1Wc3qRmjswwYkcWyNLrCwGmgLLCKE3tOb96KYxlsq8zQ91Hmj0ihV0xviSsq8m7llFWaL2LBg5jO0p20+e9ag=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <DM2PR21MB0043C611CFBEA532C0B515A7B79E0@DM2PR21MB0043.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6055026)(6041248)(20161123555025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0043;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0043;
X-Forefront-PRVS: 0413C9F1ED
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(7370300001)(4630300001)(6009001)(39860400002)(47760400005)(189002)(199003)(36756003)(10090500001)(8656003)(68736007)(53936002)(101416001)(48376002)(50466002)(6486002)(5003940100001)(106356001)(33646002)(2351001)(5660300001)(10290500003)(42186005)(189998001)(105586002)(2906002)(2361001)(478600001)(5005710100001)(7350300001)(4326008)(47776003)(6666003)(66066001)(1076002)(110136004)(6916009)(107886003)(3846002)(6116002)(2950100002)(305945005)(25786009)(575784001)(76176999)(50986999)(8676002)(50226002)(86362001)(97736004)(7736002)(81156014)(81166006)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0043;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR21MB0043;23:w70+RugsUzsaTZQLJ74Q1vSCZE8XB/gSo1kXXNCzU?=
 =?us-ascii?Q?0r2nJThAkgYtZFH1B1t32J6qLCamk+mOJc96o9hvm1Y38Od/3lQ4sj+mo64n?=
 =?us-ascii?Q?ijJwT5pek5C8s79Lt5ZzJ2uSjYd2bzJ4PTVlpkp9RFBWT69tsJWoiFfN3njz?=
 =?us-ascii?Q?nQIMn+ZRoqIZTi0iW+qp57vbtOFntQ8dSSV0puduJYFgB3jjp72pyyF81tzV?=
 =?us-ascii?Q?n6Gcs1u4Hv7QbrfohC+UkRcpxwiXKi5lP8MEZJdXebK8b/lofl8N9rpHpC4z?=
 =?us-ascii?Q?4zcjRmkE+8IPt+F8WS20fAPEKjw6lW5mF0F3UG50ttlROo0CSoHf9P0PUin8?=
 =?us-ascii?Q?OOgnQKvwLC3mGO2UmCNgDH8xBq4JZqjlNHaoKRZH9v6foErlgDhr4iaUZuBy?=
 =?us-ascii?Q?wYr2ucDM56InK9uP6Kjx0D0mx9P2PhCqDPTZ+tInLtfoScYGtFMCGNZTrx9n?=
 =?us-ascii?Q?QWo1Mv8/WPowNaSDgR4iLdyVWOOIniMALMD72XEh7EFW4YcdNWd57Sk2uqQx?=
 =?us-ascii?Q?ZZ2GFAxjpD72Yg5HIvoWsgeiOjPE5g/egylA+Gb5UbAxLWpiXzusU7vJ7t8s?=
 =?us-ascii?Q?DItkEzBLGKRvuftEGE1RNHQHT9EqWlabXeeCCrQYxyVqRvMERvWjimuUo4Fx?=
 =?us-ascii?Q?TnGuZP0En+ijk/5pfFYaSKA4Y1a+oG1oj2s7X5UzUUWhNt1NUxrItn0uAvsN?=
 =?us-ascii?Q?vK3zaO5rn5REqOmbJpNVWYGApmfWZQ3JGrLHRvFrsDGHrjgPOTcA5TZnPFli?=
 =?us-ascii?Q?faFCe3hlu0BBxM5p1+yrs7fTEHEtCXKnah6RJcx48FI7zlBBGfdc/6q1TQFH?=
 =?us-ascii?Q?Q9gFAEmf3rx43rZcNJqXB/mg/V2bMG8viP/V3ksd09HxqDHdwYyHBwdzpQoB?=
 =?us-ascii?Q?jM0kso771zsUm6YcDkhugPoyk4n7ZGfyV9ksE5BrQF5Yco+0RRSvojs7nhM0?=
 =?us-ascii?Q?KysUtdUH6iqjY0fFtuh56qihpL222YcrMj2ZMfu2a/RLtCLEMPtWvfHBKYsk?=
 =?us-ascii?Q?2ofl5pNT2UehvLvbtKo4Kvw07r+31SaLpyo0EKVJxODszrVVlz1CB+b9hYEo?=
 =?us-ascii?Q?72Wi9FQ/mL28wrv+tSRcAypXUT0lEt9HrTx7bWmPAEetOiE5bWWQon5hQkro?=
 =?us-ascii?Q?soR26epXpTWhtpO00u6MrBE5slsQCYGkqlBeK5o/9kNkcvEmWuoc555jamrs?=
 =?us-ascii?Q?gdY74CzeItK1BTllpe77w5XNFCHYQOcnld1AUpJf/T8MMRhhLYrvGfGWUQ1w?=
 =?us-ascii?Q?YrxfxWOeM2I8kMIH1Pv/n0Ya8ApjPVvMTHvgvCbi9u5lULeEY5MR6aEv1xTx?=
 =?us-ascii?Q?ko1GwXBCdyqYglI2mqjFZxQKRog/oRWvYdPNJKO5XA3?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;6:E2FOO9kNeK1+GW4ieA/PNWpsIlKc3K4OiFSydklx3jZAjC9L0Eyk3D8CyT0Jbm6El3Hz+fKf0Os9TMbQcZcNwwS+fy3Y+FE6O7BSTAks6Se0/HVgLeoYNlVqRBDD7oqKlibhAq/OFUVubExbZnYViVijZouuQxpdtpTYZuNuDCnBU0Ae0jIxliDVLox68jz2tLoI0u85Rt8ucp7cz4URueGGzaevheyk6U/yuw+i7jomAnPm66MrUTf2ZRkWIxv429ToVGUKZqLotVAf9jJ9A4z251+yyO3Eqa7mb4oFq36us4Hej1ghFBAvcFl4oYNgKPKrtOroJSZarLqd5L+Y6A==;5:EtsqCtCHbq9vXt8lx3Ool/nwqY+bGPYcC9/M031UnF1ZdD2h2sBSLtYjkD6TPLt25DUllPN88mDK/rzCBLwe0A6czjf/uYs8R6u9irl+xzKc6OygNsefevNF8DJ2oVUqvQt5oQjq4505VSKTtsi5wQ==;24:5csUvOldLtbLj8O9tm2faTpzEhQOEHfk6vWFABWyK28o1QnJriFstQG6dT5ilcOOm+bpM/biasayXvbYt7GRsLOTreb/M7IkP0Jw+FkX5HI=;7:ZbHTWRFj26WM1BEkJ+EnitmPS3v5mhmkovQ0iDWhNEa2nafFNASxQgqhMDqlOp8Ux6daSssm4Tqs3J57MeBdadalT7M+DchqwVnL0HPHOKivxh+9Vaguts3EvpfHzILnF1/gR17jc0mNvSGeu/IJmGMqcECC+EoLbJWFQOAl8ofI/cxB1seZ/ocsu+OPDWUelULAbSRW/z44qYqAadJFAEYK2NsWy79c7KcQZfwEY78=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2017 20:29:37.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0043
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return value of the get_files_dirs call is never being used.
Looking at the history of the file and it was originally only
being used for debug output statements.  Also when
read_tree_recursive return value is non zero it is changed to
zero.  This leads me to believe that it doesn't matter if
read_tree_recursive gets an error.

Since the debug output has been removed and the caller isn't
checking the return value there is no reason to keep calulating
and returning a value.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 merge-recursive.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 033d7cd406..d47f40ea81 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -328,15 +328,11 @@ static int save_files_dirs(const unsigned char *sha1,
 	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 }
 
-static int get_files_dirs(struct merge_options *o, struct tree *tree)
+static void get_files_dirs(struct merge_options *o, struct tree *tree)
 {
-	int n;
 	struct pathspec match_all;
 	memset(&match_all, 0, sizeof(match_all));
-	if (read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, o))
-		return 0;
-	n = o->current_file_set.nr + o->current_directory_set.nr;
-	return n;
+	read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, o);
 }
 
 /*
-- 
2.14.1.329.g6edf0add19

