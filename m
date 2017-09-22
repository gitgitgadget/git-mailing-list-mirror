Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCF0202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbdIVQg2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:28 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:49189
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752506AbdIVQgV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Wqklrk4aRsiVKsGvT4JHgJY3DWY+1fXKEpwraKCSMC4=;
 b=aECFo8V+s7frMsTfUD7Qggm8dz0pjpH0XVRKATgd+04wy/fg7/6b0m2uNqmTm9eapTzMuI9h20ao7PHno/6I/rFoarjuNlQ4GMe6mvp63NU0XYibHQNU9hXR3CMAwsjocP+CCZ/UCKS7vtsQ0HFbG9EiqweIydCFho5aIUO4Kqg=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:13 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 06/12] ls-files: Add support in ls-files to display the fsmonitor valid bit
Date:   Fri, 22 Sep 2017 12:35:42 -0400
Message-Id: <20170922163548.11288-7-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-Office365-Filtering-Correlation-Id: ef5bab70-0ddd-4c87-dd11-08d501d809e3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:RhISVwMAgDhARJQgRR7I8y0/R69fkMe7YUhGnVE1+ICEofxNim3cNfvXfWK5NNqNw24d9tVKrwQ59b3lluOnSaA3tRgZM3OkXNkiKpD4TzawZYpgnmOLTb2kGWCuIzHcsWC0aCFCDwmpMbqR9M8hexPNfzMplrjFMcRN+nreZswdCxQCTCyq/UQdTix+jaaYv4uBP1qU5SEtBcaBxGgdsgwI7AjHhTsrEPEa9WbNdz3h36bqo4Yc1aUf0baaRcoc;25:wvuz9i76AhRbsspNQ4gRAyy8xdd/RrFkST6I3m2tuTx1lCyXiLjZhg+LAigsbEVoI3/AUwn76cxacfOhl/QGIzzm8gtivCJ8xMngqj+A8Yrxe9BZfziaK7o6fmUf1euXc/Ae05gzRSztY/9bAkIdgTPgMvam5C2sLFT/p8AeYjjR85lp0cviUCLblZ5l1IBqnEiX0IKVXpPlGgwzmLptpRQGmSuZhBRuvDmVJlycGBr4JMzFyYUkumzTQRh+TGso0137XEmxU95c6Ohk4VdOVGpf5lFJ1npaJTxiY1V+/Jke0gs7/0wqE8b+aOh8q2/Wd5LKNQ8HSjQf05hTeLS0ig==;31:lH88wHSvpxhDwagp/nGsHtGx2XXbfPtcto5OTIzJaPX4lQRd4mkaTL+rCYQHrPitP5J+e5ZzkM4SVcoDzzxhtZT07xVDWEdOJLwsR/x1S/TGjLg0HEkipQgPzguc+35aVziPnT7l9X9plDHsh0yg6ngoOloxGZad77pBMHe4QjcLJfufE4Rk4+u9FIFf4pKt3Nsm4Rfcbu0cqUK8NcOuWRpRERY72oRDkWyqRu2CGX0=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:AF8mjTTmEeBLNU89i19X4O9aEdzvfbXVvs4EXCI996Ln0P4+mcpUbUTjPkwHGMtK6eNpHheU/y4J4cJ42LTIjVGij6bY1DTkktyqU7vKwXwdYWR0sgVCHRQgOpj0Nth4RP9httdYZCyHLmr2oyE9g/Qge50wD3zinispi7jwlCB1hfE6GyeKiNnDFX2r7Vgj4ebLzUZSKV8IX2C6sDIuCH8nDCjHciCBnYf9yNn1qfgVLZOxPPBiTDo4onO0MpKxrvfIiuWIayOwRxZCWbJMjW9QCWe0falUhVZBKmNW+3QMhU+n17X39SBQ/fr0h3AshSFI6W/0ncU65xZvbw/f/lN7LSv2+maqwoiZ44CFjSLRFbaPEzOWlj9LvTUmnim4u8vXOMaEsvb33tvSug7SJkMQ5k3UnAo1OBTAW/Z4dxBcL39bczcPJ7pAOUQ0Gu6pDQ6rosHdDNHJqQuOcQpvVgxOfFUs7kZSSi2P85NfjuK2olryrbyZhgwgZrsbZwWk;4:7vURwJLOk7rgeA9V8CI1+K1QlPggX990FxYUC/OMO81MJgbo9JpezR7xy1k8qeT+EggPB1pUzOBUbapA15zxwwOMYR6fqrabFL7/Fxs+RRsrln4CjRSxrZ+hjjmX15cFV0lHJItU3V30nfczejmNs3T0G+AP8BklxZnlxf8N8dhoL7xg5wkNhw3LxApXsn05qj3INl7bDAeVnPSirFIq9lNVlEH3Ra0iPdYiDt9MW8KfBjQqJ4IdC4vG/8jpOanlvoqNjNqLyQiPanlAlTxpdB8ZROvl4CkELlC+W5e6j48=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB0466199551BDCA345F9FF410F4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(5003940100001)(1511001)(47776003)(50986999)(575784001)(68736007)(76176999)(50226002)(106356001)(16586007)(6666003)(16526017)(478600001)(53936002)(48376002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0466;23:e1qJ41nAg312ryagJ2tCuozhpHnHNvUFyt24c/nml?=
 =?us-ascii?Q?iEyH4gHX1R43/avJOv87gbX+U1OEhKbhOMOy63XVTYKLmgi9fxxV19vbebQt?=
 =?us-ascii?Q?g5ijC4LEhCWy90nbyvSXd4PcSjXPgZ1fWt9cCOi4ZlY0jy2++BNG6bNitZ4c?=
 =?us-ascii?Q?FMoBW/VWEj3zhppd2j93nbmWWeNfctmTwgh2lJ6XMRemtWwiiseXOUTEAo33?=
 =?us-ascii?Q?Zam7vmfN80+P63CFVmsmmKv47nDayeaVo+Mh9grr+TMDg6zop/U3vjFkY3CC?=
 =?us-ascii?Q?0w9hgrLZ/woZ914oL+pgOetomMC62Gz3egvlsmdyZEFOB99SiH5zrpl7mYIS?=
 =?us-ascii?Q?4ihIwQu3k4yGosvSCurfJ8+nnI7QzZ5LdAuNBJSGVn7PR6jO5WU3Of8ngXvr?=
 =?us-ascii?Q?/kvbJ4kohiPBTRuFE/Qjp1w7SXrprDx2mXz6kD2heIBv+GUGxwBJ/gjf8Axv?=
 =?us-ascii?Q?FjcrOpe0fNTxPSm7DB0UbU/51TxRI/qPScUB6SeqQokbl1gZBa5TQE9Xx7rr?=
 =?us-ascii?Q?j6sZu0rjylNK7RZT/ytwi9yS90PISLDtbxnVFsdomjLp+jlr4p5rwW/w7sZg?=
 =?us-ascii?Q?+IXHQ31JJ94TZ7ZRgKsiJHfOIvytCO+8YkiPakLhiok+FLYfo7gqOWOHFcRj?=
 =?us-ascii?Q?yCfWDnI8aEWmbjgec/V+SvqFZf+BCdMrHabh5YKcBtLtXYm6Qct8C2eAi3Dd?=
 =?us-ascii?Q?kcDNtklhE/IkeNzNB47tTWNce9EV9Yuc9JeOBWQxmqJj5Qmu4jZOBjpSmkzZ?=
 =?us-ascii?Q?g48HIMZ0+I46F+N4vXJk6iY9RfVytP4zAbwRPbrPY/a8bOwjVm0n5/RwH7EK?=
 =?us-ascii?Q?cZ4SllQStZpdwMDbCpSzUxOs6Do3dPn/xejl4MAIxS//1LEAddru6RNBATmm?=
 =?us-ascii?Q?5SrF37nbR8dER9A2s2PPdwe3DlK7VnhJmD7PGCcapY0u8bgfAsD0ZsRCOuZ7?=
 =?us-ascii?Q?elAHFI+GFFpfuG1tZMiqGn0xTpf9oPRw+1whmGvB1pSyDicgTJnphXLyWvwT?=
 =?us-ascii?Q?ghXmS44lvFeloh/7Z9knHnd/klS8koApmagzRHVm7P6/+XPLjLkj+nS0jAnn?=
 =?us-ascii?Q?ntMFfbb30wbfUwCZ3oRbVA1/kYO/3iUDKAprZdBQU0kgecJZBrVT5WdpECpG?=
 =?us-ascii?Q?Y2n7B3P/PAFdg7go69PjunwGrs7tjuCKFT/bc23Wz4Wn4OSkp3SjJF9ZjhxP?=
 =?us-ascii?Q?v7KLU99BREaR49YfyaAZPg31abRJFaNZWBwZTdCWjBnO3GbTCMRLyYiZZ/83?=
 =?us-ascii?Q?zhFUxzK2NAc+tltMyTWaaifU4CU/dDFLd9jjkOBM8eMmzreEfO8AenTLzquz?=
 =?us-ascii?Q?l+CR6FugO/NrwmBbWYiR80cRXRc7np+NQfsf5lZ2ousP/ZmlG6ojuuiVBi3F?=
 =?us-ascii?Q?DoTFz6yx0vuMvH/PENeWGtQ5+FzoV+zO9J738y/PHFEJuNVOGJuJLRkt1pRS?=
 =?us-ascii?Q?sgTLvSYEhf0I/zY4V8MbIewp9geDlI6jA1jHdq8kz6FVmS4QAna?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:lEQSv/xa2rmf8o81Tl4Kzv+lXcsV6/5rPLngVNbseFMp5uBiygGPcB0DYCRjKT9mAZedfPt3Qtx+eVEq1u1L1hEGoFZ7YpElP43D5+uoEeXYszW0+Fdp/GkCwPaN9jU9eXzRIaeNbpf86WJcLlpvxG07CgfhdOOPfauJuLu+OSvU6detUNNYURQCaEW99a+e6E6D4OpMnIBGXAyvNlEa2z9czYHV1hzFHgoQl5rQOFf1FhNvuIqGXQ6xq/Li1yilTJrdW19f1QI6fZ4V4sj3wM8YU9BOhE972GjF558x5OAydTGv8rSAK8wgDKfhWToKXGo4RIgbbatEXIldEEKNJQ==;5:oqhTZOIN6hKjFhEc8slK1tmMEnnOZHYznROEgXDLOQedNc0CQbxPVJoZd6bwl5Arz9GVhFULDKAeAyETAqzQMx5AEbR9WnA830lWvgRO0mTVyqGr4HrW5ppun2VbNy30VhoMV8+xCFQcFs2BnG9YOA==;24:kBZJzRzfxErqnMEE+ch/68e8x7qpldA40pUsRQLfmZGEb627Ff3PP7AWMqP+QQrz70Zs2eE1oZhPwKzpF05rBgcADn0MCYfnVpd2yYr9IeY=;7:HxaOsgy6bn+n/CBpguDK31i/mMalxOnBBnIQ6bE1JS7yHfsyMOZdfxpzB/1+ek3NoIPQTKrhYRkU71B9apwlEAxTqebvPsz4c6K/ZDB5cJJTEjlyMOXhFHi/xEBYxpERshHPdjdXtqjL7tDRwBjiHP1jMfQl5RSqw61bK6QM4IUo6VMdcF8uTbm4n7d9MQd0vLPOOI+Kteyw3T1pg9xRgxGHKxc30EE5Uq3xqH97EoY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:13.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new command line option (-f) to ls-files to have it use lowercase
letters for 'fsmonitor valid' files

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/ls-files.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e1339e6d17..313962a0c1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -31,6 +31,7 @@ static int show_resolve_undo;
 static int show_modified;
 static int show_killed;
 static int show_valid_bit;
+static int show_fsmonitor_bit;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
@@ -86,7 +87,8 @@ static const char *get_tag(const struct cache_entry *ce, const char *tag)
 {
 	static char alttag[4];
 
-	if (tag && *tag && show_valid_bit && (ce->ce_flags & CE_VALID)) {
+	if (tag && *tag && ((show_valid_bit && (ce->ce_flags & CE_VALID)) ||
+		(show_fsmonitor_bit && (ce->ce_flags & CE_FSMONITOR_VALID)))) {
 		memcpy(alttag, tag, 3);
 
 		if (isalpha(tag[0])) {
@@ -515,6 +517,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("identify the file status with tags")),
 		OPT_BOOL('v', NULL, &show_valid_bit,
 			N_("use lowercase letters for 'assume unchanged' files")),
+		OPT_BOOL('f', NULL, &show_fsmonitor_bit,
+			N_("use lowercase letters for 'fsmonitor clean' files")),
 		OPT_BOOL('c', "cached", &show_cached,
 			N_("show cached files in the output (default)")),
 		OPT_BOOL('d', "deleted", &show_deleted,
@@ -584,7 +588,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	for (i = 0; i < exclude_list.nr; i++) {
 		add_exclude(exclude_list.items[i].string, "", 0, el, --exclude_args);
 	}
-	if (show_tag || show_valid_bit) {
+	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
 		tag_removed = "R ";
-- 
2.14.1.549.g6ff7ed0467

