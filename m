Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5A520281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdIOTVr (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:21:47 -0400
Received: from mail-dm3nam03on0117.outbound.protection.outlook.com ([104.47.41.117]:20724
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751748AbdIOTVg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cYddFQ56762LBiVVE8UObQuMgv3aM+gKhBrF+pOiLJE=;
 b=SIxafuj+wDuL7RaRVLV72zhQAUOwIm7+eUz/dLCF2auOiteyVNMiA+ZsUei/bDt00Lhn4br60NMjrZ8MegwlisLqzHFnsWxYOKu4rGISbWlQOdsSEZ7jGjcB0DkrA3jj+dMENbqPeIA2puVTlvNXnEu/aNnkl6RWdFfM4WXLVNs=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:27 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 06/12] ls-files: Add support in ls-files to display the fsmonitor valid bit
Date:   Fri, 15 Sep 2017 15:20:37 -0400
Message-Id: <20170915192043.4516-7-benpeart@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e6d8925-dda0-44b9-af98-08d4fc6ef72f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:9fOXx0Oaa1oy9t5PKbUgShywwRwaqO78ie3SHewqWKuxr8pSrpYQkCg4RU2zpS6OctF27oQqP8sIyWkhazx4yzSYnYRj1IzkU+cftfTbqNDwwi6xvsJhT2XRckhwMP2sNm9HTGJNhUSfZqcVWJ/ir+uXZGuF8MRA8N9GqHsXhkL9LD/UJMHoQ+zNkAFBDTHpCwBSmC3qqaww1JZAUkqb1oqvZWl0+NWpymU0WupSiQFO1xRa/Bg55qVujVKSM3iw;25:RGYytFbqtEizZKELavYq+CLT/ptwAKV/kXQf+wAaghjeFYRPPrMkJVvxxvk0OQnaKSZFkRAeyN5ppRAKFuqL2zTV7TD9tA8CdyZMvf8kgpdz734Dsrykw7McwQ3WHPprR0daShxaPjM5/q9DsC5UdRzplLR4C2XxLYbjWN7bUlWeboYnH3axhgAzNOJzo/HocUUXiN50luU/kO6kMzJiv7oYfecL73cRdHr5AYUSVtjp2CvpVdliwwOXet9e7i2B2Xb5b9GjhTsN8Vg7xb3fsoVHL4iUDqdyBY67mcWFh7Si3sNTrPG/5+PTOn49fmuty0vJEu05pHhzkrpzm0/AMg==;31:Mr8v4pew9OfywxLY7XqHHZYu0kHSUwNmGfUfxLTpewrF5/YIsrTlyhQW/U7C2ZVMEPgB6t8PLg4LDoZokaE7Eg1T62XQUzxsjQF9S595G57ADXeh0ucsjRnYIc+lxVY4E52QOkCfKe8A4a7ZdVp6JhOxfXk5uLRz7jAZbKnaofoEePGP3LHNEkxKwfTkScwrpEJr/jtgtVa066rhmqK5VUsSrdNnDb83sVeBLjxNN5M=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:Iy7WFdEn8aNCk+OtypDh1wTCt0B7RB+XznS8GrYsV19xHnboMu+rAwDtXM8uNRbJMfMQStSxsdPxs7KoDKmZW2J+Nqyss79KaRr7GlZU+8lRX1JVAU6C4Jzqrauqfz3gVMuKM7i+1T7rVbEedqHdU/i7d7X44W9KpxncNzwwcofmANuErb5CrsfbMQijzQeudPCheYWzQAyzJnPuYFSu+PL2s/JLZ14OdImk+xnKq13d8fEnxZBDCXRk1KLtKOuLKJFcQ3ULdjxkr2mkH1WUgak1s4dZHfm5OwJn1sMPAubT5gc6kSZjAe4M34pbyMf3kKHSgkcNqslWcY3ktoP85eNdaNYSKOhulftnhnRP52GRqLjycMave/LMKPpN9nKXzVc6qdpHlNIzfzebK+C/C/H2IImeIuuX8aQf4aZQaNylxkrDgbUTfJOsWDamWktxs5Jnbghy9ohrG2PGER380uyMWV+mj90pPwFAI/VhFffjoeJwSsgTGt+5YO2F2p0U;4:hUf17PlLrNoya20vA9ZDQxhovfMWNmVKOxiM+waBaAOszdDX+dYw+eK4e0d2pIAbsApl1JpyN78qt9sqWG14aD00Kq+xLqwMn1GXWkvQL6Gi+Mi18vViRuZqRjzvw2AN9G+VnuPl55JsZ09V1SpLfeworgfktaEVyWfatgB8hZPME+ctTK/jRWLjZW9EqfaKDaHRFBjabWia6YDfZ4DCgPgnum+z05khFL5SwgTI9cyjo12pcqQtnUfdVZmef/UqDNtc1fMXdTfnzEwzqWl6aP2vzQVw28qTZnyG4164pdk=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0469C91AAFB22350A5600336F46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2351001)(50986999)(76176999)(22452003)(48376002)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(16586007)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(5003940100001)(66066001)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(575784001)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0469;23:8q7+NRH6qEs6+/tGfrmcZh6vF048wjhusEGDwU58A?=
 =?us-ascii?Q?iU24Nhpjll6WlzjVrDNsm3XU7Gj4KeX5ZpXZpYPXhvNIUOyQp5zD/VSz9VQc?=
 =?us-ascii?Q?wx6LO0LxpkOTq4yYpJhtj8bz7mWjrbkbGMmiwC4E634tLEFAhj7pZJ8BvV+l?=
 =?us-ascii?Q?jTalhMBnpCoLB1BuXfAGOKTv7PIb/uHNR3tt3FIDGbJEB4/KAyVfStsy6m+b?=
 =?us-ascii?Q?imH2PpVsknocXUc9aNTBGVvtN5KzG46mFk9+4oLZn3kQmtWnRFnCIdDIA4ll?=
 =?us-ascii?Q?earB2JYAJjcICXuYYiphRQekhfKqbhNG6FiVbtZsWB0R8lkLCEoVmdpwQLG+?=
 =?us-ascii?Q?+Rh9NL/eeAUkmN2PX6i6reg42t5s7eaElG05M0fz6wcqJ00nAtV0DZspvAi5?=
 =?us-ascii?Q?y0AYu1vNOrYj+xuvCy6IW4wIfs9Zwn5kh9IGfyrcYnZEFUy/zgl2nUeAPVAB?=
 =?us-ascii?Q?2i15CY/tkPfVaF45g3+9ySndvkEJHSwiQMDZ4sXhMLq94zlRAe3eWVD2tNj6?=
 =?us-ascii?Q?hnrtUYpD4rtr9xihAdhZsKw1DVu1c9ZLQGrp6RscyUNf2r5ZRx9EChHeCP4R?=
 =?us-ascii?Q?QKdcV3KdTVgATjpGm01OweQoaB1WDm2tUy0H0YlyXR5ErufWeDC0+TrBghXW?=
 =?us-ascii?Q?IM6PlXFXooOvqg5p7BuAke+KRQW6yX7rjAnBol937do/ELsoEGbb1so2LCyg?=
 =?us-ascii?Q?1UU2v4oFQFjjEHkQ9GSp1lKVq2dzufqjTBfiOsQLGKBaUMouABAzQiWO+99o?=
 =?us-ascii?Q?yLMXWjXCtZ01slmX+c0vwIUuHXZy34/ii05v8kCHvBsba4EGFNDSQ/xqG2D4?=
 =?us-ascii?Q?coCyDLO53/HATfzIkIZQQi80agYt/fPEKtl+j4503piBJGXb9GGnsyphbRUC?=
 =?us-ascii?Q?EtoGS1Vc6Gt2bRxSBDDOLPROmur6H1vMYp4R8OgmJ/H/m6Y8zxTlVbZ7OSsP?=
 =?us-ascii?Q?bPaF4sCZI/thatxYyDLGQaurDNjc6P5Z+N4gCu8Rwp/OSTX10y5hwDZYgWD9?=
 =?us-ascii?Q?m2DHuX+dAWf9sOOjLRyl+B1Hli5EkGa5CWjh7n8qs/09fe9YnRh8o1q2a02g?=
 =?us-ascii?Q?DmBozgzYDh19f6wFJPB3HwGJy0T/GtTDDdWBA7R3Nhl8y/LR7QC1/NBcPYom?=
 =?us-ascii?Q?/RqItTeYaCXjF6KmhLIOnQ6mC5AqEkkjIMiMe2ryQ/Wb3v91OMWgyxBO26+Q?=
 =?us-ascii?Q?WkEJzcUB/+PM5P1/XyfBBPg7gRhB1WHv/Rw3W8Lyi+B8uKcFsRebF1cs9kwD?=
 =?us-ascii?Q?kgCAtGezPub8sW7ZZxeM/7jJuc8jGV1mPHvJ/lx0dBmjgJWazC6rIJqwN7Oq?=
 =?us-ascii?Q?9OEx5hDLK7ED2ZSGV3spktAPy3l/CD2Zm5OBita2eKJIL7jSI4Pvkq1tQ9oo?=
 =?us-ascii?Q?vdSYaqoKUNiS7ispf/0KEUSr6kNn5+YN2B/RjKHn2/myIjqJCEl2SyNHqGUi?=
 =?us-ascii?Q?bPOcrwcCQPVDBJXKEeZcoqPYh9yjSF4hQ2XVPmL6H9AkZXUsGMaMLNiwgYMz?=
 =?us-ascii?Q?QToL/G/vr7rqw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:vRtTzoc/4xwkc4iRyQFqwGrvASLuFwA5/mA10oBf4tBd0JGyTxmfTaqwvGj1zpUFgr0a0MreoeRTGS1VZBlHqeOG9K3YC0jL3Nue0AxoI7sIImyWSi7vu/S8edLj7sUcaH04sj9vubZ8490pIDZSbz6auvyiGRjCTP1vhWtM3Pj4UZqdUvfKnP/rncluxO8QULuJ/40dPM78VU/50QEWhHWoPYjaC182Sh6NkmoDK4L4+Elkiqf8/eTLQyTC2c9iGWiCXSg7nhnryNuRpTkFdFlqRTZqhXwb2XXiOCioCDUbGZ96FwpzjBAqIFv/yRusAvdKAc/Cm/0R9ESJBkClxg==;5:WJSpMUBCOXE4j36JNoXw/9bz7mmo+IInbgXMpoovEGcMwZ58Yl/Z2bCci97ZuiYQ5Sr/UMjqfnhfMXPmIcoR92Ktukqg28jljJnsGgAZ6lT8phDBCBc29v0DoMLMX59x/rV0DQhSXOFYrldtH1A3YA==;24:c0Im+g5NwbTHceMZyiZCU0KiussxMrhmiAS4UvwlvGgIcaJt47Igt2c/KSP1SWrnpPdDgbAkbY3UyxleyZxv3UNcQeHEiYLQUehy+sMs4nM=;7:FIWn4bogOZy3gtKQHvCniYMLGqACxVgZnK425Yn3nU3lz2euCnwPN+NCv7mDU7IQTcm1/VhfL3Bnlvugert3YQG3CB0Nys7K5cMbptH8rbzfP0bx6v5u1q4yPGFl2X7dQsmkVlbYJjfElcY0MRcsF5I7q0+HUUwRIwhRBVs46lulNso9xYu1j4rSqFCDvwxlAtOaaTTDy8bFG59TuL9L7+4B9GB6UKj+vz0HQW+zoWY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:27.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
2.14.1.548.ge54b1befee.dirty

