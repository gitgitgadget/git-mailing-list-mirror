Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB58220281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbdIOTVo (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:21:44 -0400
Received: from mail-dm3nam03on0117.outbound.protection.outlook.com ([104.47.41.117]:20724
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751323AbdIOTVh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QNppy2TTbyt9rQQHZMvkLJd7E/clVOBhfwH/VQsXfiQ=;
 b=he/YRH5cZTmfr1qA+ELuZKw/vYnHjD4EJktfgrwnpP21T0Vecfa/GaJQUUfr0lOVVrHUkvKtRmnZqUffB/hsX+l45xa/RZpSF5NFxTCRzGclycKAL+qDVGm+0PN9aF+NJJXOfNYAMmqxeavvFIxrZrcx9/sq26ueSyrUYmpjYSk=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:29 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 07/12] update-index: add fsmonitor support to update-index
Date:   Fri, 15 Sep 2017 15:20:38 -0400
Message-Id: <20170915192043.4516-8-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170915192043.4516-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2201CA0010.namprd22.prod.outlook.com (10.174.119.23)
 To CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147)
X-MS-Office365-Filtering-Correlation-Id: b2e5ee78-8f39-433d-6665-08d4fc6ef86a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:nBY66Tt6qGWgP9acUa9ZkucYNLLQRQ+7APK216P+dbhY6eVklgfByya9e+DQ02rD3G+2qt11/05+D1fmtjJS1vCBHO7KPvcF5qbdW86TOb0+Jnj+gSpZ4LKpTkoyqOOnKaqFp7cOlNNHR//nbUruIowQn5Hr0d4sVdWKxh3jD8teg63s9PCCPEaKCnNH7u+/IASEcoi2q2FwgC5mzVPc+o4WB4hHVN0kFW4KN/7jaHaM8z7ksDV1uKbGPoFWsV7Z;25:B18rIP+gjUx71CTRvwU6r3swn2I1pjge+KBp9slPqxMwBoSDvLq3lNOr+oVOUJEybj6t2pu/IUxYJdmbLlN/1FogRv8vpP128zSNvLYLG+YpN6bzKsX/zQnZM0sdPiQl5RAmoivlAnvmILnexRvy7c+1b4uuc5ydzpg1DOgfoalWhCtQSSFgzBSy+qlSya+wFAHiYSrOy2lvGz0pAII3ueQXSZsb0I7g0vpBY7qvAfc1F7vkS3lYp7xfy/VNnscxfsJSgf/03QkCnYF4mn6gPIeLIlxFumFz1i7NXef/m4yHyr6rF4o9acuMv5A2vWgAM6Tt5aIWiP7FriVZUIUTgg==;31:CKwoM+C8iKSuy1DCvclKP8x6fjVDHf8UA1MHKe9MXBA2D5ei27TdzU0rBLY5OlUWepwmEmW3iAuJlQ3PRWnf5au3aSVmUeR3U1eaAKWUZ+MZcfvOlHJMDD1rMKmv3LYOEMeqUvr0CSqerp3EHBnth1IHC4gaGu2lSnKdVyasPfSRl5zf3HZsBsZ3YpGn370YKRg6OM/6zBvCKujL18uDeiYJBKgDAjYRWBuiRSxf4PE=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:zZNKn91H7H2UzF41bYIYj5/b/lDV7auueqfk3oqkI9OtSMFZaWQD64DjdtcsrHv3xemLU1HxF5wphudVAltOH6mtZ+jnTwt8wQV2LalFo+CMALKcQwdSPsI0udC62bP9XOHR0AwCG+OCWKn4rec9q0MJ4NuqhtlPklOB8tfcoz4twKQxkNdnLkbQ134oxWwXazayvhgltvYNuVORxOJK80O68wYEsRbt2JogSgIE3kX6GgCNJZu6S8LsWiRK46T/6MBvc8O8zq6283PLnmnPTDRVsua1+FKAA4qlYxAfcIv+/+EgYbW3EpGMszK5IBe56Qy5TABAv/NQW8aMJPN3kdEjjwDVrfNW8rxFUGmtPHe9M9Vn78ex5XlSybtOHdCmni+0IeDPWB6Rz/FSTBZu4kXawn4zcuWqXpLkR9wJE95nVOd41bEudmbqGj3dxWYRNz5wq9HhPm6+2qlET0H8qEBD8TWHd+wRIaO5sqMk/9HSNVZA4IG+V4Msf6sGPJUY;4:zvMMDO7BOzGd1JZ/+AgTrwfb7B+Is0ne3mYCfzz/qpwYTluW3gKVJ0t5gqJnLH7ld1ak13aYkA8FDsqmkvzelzrJhhwRKmGvw6CmccC0cpQ7vPy6eQ5984lUusin+HkvVQno0w4MhJaOunUYy2NCfx4zJAuwtLnfejQ00cLBhyX+IHdh0oOYTKgjVbM0+An8dw4YFxgZoRtQNGMpnL4q+5nTWHWb+np2uv1jrxvxA9AzYqAmfYqWN5PIO9sj47+jwOQyGOlE7HFIxKN1ivkE+TPMilWr7ALyzpNke8B7wHg=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB04692B00F08CCE5E0C9475EAF46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(15650500001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2351001)(50986999)(76176999)(22452003)(48376002)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(16586007)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(5003940100001)(66066001)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0469;23:JK25DgRfV48gPMf3D6Sdz7UeVSF9OZGDF9z7ao0j8?=
 =?us-ascii?Q?eMgyxDw3MWLvTiLCAYO+lkd3jEOQhSEzxv2bz7AluOpDoMIEWopNAPe4gozB?=
 =?us-ascii?Q?yKmRo1nJmw/wLFE6lEynMePta9GG7XXfYHVq87j2j2jtLXj1JS7190o3PUza?=
 =?us-ascii?Q?Qz0g6VcBhVHP+qLZmSmRSSScT4Tgw7SPp6fm+zNcRCnZTK33RJUCSYevhnLl?=
 =?us-ascii?Q?cMEuWzYja+i7XO2Npgk8AiQCD9N5SLrHDsjWlvUFWHcFbBOFxbsXOAgXg2Pq?=
 =?us-ascii?Q?foli4cRx0ZHbc3ChtzjjPGuFF4nN2BCdHF38ST/jqS0q/j/RpZ+NVlLUiEun?=
 =?us-ascii?Q?UMK95Lf0hY+Q+8koeLO2GNKi1/S6RK4peS2ti7YHWVziRsJMnq3myOHCJCyW?=
 =?us-ascii?Q?9UZie3g9NLZ8VdZTbDaG23EoK9hPqmkJDnAY4CzxIQwBXcUAywYxcdO51q3Q?=
 =?us-ascii?Q?svqK98O8eNeBxHNfHJE/KsWlC2DJpVYkevck81cnYxatkxxF0r46eYkC6FV5?=
 =?us-ascii?Q?NJkXZLCw1cTa/iMrK6mbF+I/A9AkZjvfy1r2j5RV4xIipTP+blSVHa1/UlqI?=
 =?us-ascii?Q?VA93RpqOM19SefwB267HQAg/GPQ2KeWfwJ+PiZdki4ZFDlf2r3trfCUJyWb7?=
 =?us-ascii?Q?ng9bI3gxtKFy1c9ekoRC6l7zS2S8mpNcUmyi/8uYUL8bDJixMIsJZ1OzxPoc?=
 =?us-ascii?Q?llFLF6RwJ+TCkmc9d2qWzE0ioYtsiVqxPuqL5ppDwLLlOHS3BcP3TzuhfASG?=
 =?us-ascii?Q?t6Ve945qWcNoEwXcrJ4cKQT1NyLweoPI9Hv8WUp3n0B11kZjl/LqjkInFJWj?=
 =?us-ascii?Q?rpwkjzmQEdtlwpVBXgViRQyYB28KjFp2fDHimg09kGGpvIji+4zf8hfIti0f?=
 =?us-ascii?Q?11zE0piY0DBYu9HI41W7FVW+FVBST1w1+rUVHsLYaYZs5JcpXL4FLwqPlIcZ?=
 =?us-ascii?Q?OD7A/7/cEyPYXbAlFE4KUVkZQPYgqOjWv5/GDayuRydFMUURbiA+taTavUBF?=
 =?us-ascii?Q?Hvmf0iP5B2CfNhL8Z5TX/O8KW8z0H3XkxiN56bGKFxtOLEgXWm3YeWSJQMHn?=
 =?us-ascii?Q?s2VMWPX+g2G80tQyRPA8Hr/3c4Qmbm9myp3kWBF7t1MI4KtpnAaZJc/zKy8L?=
 =?us-ascii?Q?KGIKcnmNl2Ki/+CvNIh8+0iBsYtw1JkTV5FZJe8NaxThZTdQzvth3d9Pkr9A?=
 =?us-ascii?Q?I96/daxwD0G+AkedoxPS/5T2/0QN+1vLvgIz7qSkp4C64SPxCuYHijFciRtz?=
 =?us-ascii?Q?ISSZaz0b5i1YWHrK/JQJNAGGWahCYKM75Ihz24ik31c5T3N9zm+7+eZ9SxDb?=
 =?us-ascii?Q?WPxFbBjEYAAi5HFEddT8m2zCyVfcMjPS8EEOwdFnUD/9wr3NPpluGDRZW/5e?=
 =?us-ascii?Q?rbnC6g/Aow/PwjKUlfkPAqgbRppXy9ZHUCFj1sDf8NmeumaJQrRhBgJpdghF?=
 =?us-ascii?Q?CwpLdWlFP08QrXfKsSXB4dCgbmaZVm81AvJgWX20Mg/QmpZkwv2qcVyOgZUl?=
 =?us-ascii?Q?kpVrKzDaTA0bQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:9J5vLJagiOKtyTrw/CQC7AetaHv2WVJpNuudGztDhSAdGI/+ibR7f+meUwDX7NVMY550Y3t320jU4NCkoTUNYpEedv4AksQ+7usw6458d113P842YNL93Y9FJPCHUEluosp5FifXhpNhB9iVO2qozcT8KoTFcp56rBJNnJW9/K3UCDn4TtkZiK2felt6c7+hzQ3g9TA9GmR+M+qX6K1QcwYBlaI3qMKn18iwMuyZndStIAUfBbZWbhlh9IkiwiyJYyqckdNidqWg58hbAci6ua05FcPg6JVl61uWYLWwSHu0hPRo0997YKvEPmVW6kNRe2desRidUbyUdT27bbxEJQ==;5:53rTmy2haE441lL/O/KENe3KaM1DsSelc7w8ZlVbP2Ff1rFUknSjrEY56fieaWdqAJMpmteBDSpNUdwzEKcOJvbvm73CBcjdcmoy2DnYILPqQzkoI4XxkJZZMlMzlifZHDhctrq4R49E0E9/gB8Org==;24:tkYCxz14U3oT4e/M61KMkPOHOIOCIXvzKFCB1S1pUKVyaIDEdRglYuHM6jT7ibww1bd/P7ygizdAMFHkEmlvI5u5R7r6SZLpCKPm4xVv/tw=;7:GMrC08kKdm4LTr2Oo9lhmK0rqHcSOThwdn/QXZPSJfH56ItVOtn3R6Bv4Tg5MSxb/VcNB53ganRIvbJDk/RYJcbtHWyOaB7z80xFgCEg09ZIdlWBFqZYGnzNuE6c8dKwxO9RHiQNEmJ6uiiZprKWSLPOvuhFdpRveR4gVv9g2ypt039HvW/ElSQgm25Begfo+LVe0KaEFCEph/x0e/9zYUWgsym+/e8t44ApECTWXXs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:29.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support in update-index to manually add/remove the fsmonitor
extension via --fsmonitor/--no-fsmonitor flags

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/update-index.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 6f39ee9274..b03afc1f3a 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -918,6 +918,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int lock_error = 0;
 	int split_index = -1;
 	int force_write = 0;
+	int fsmonitor = -1;
 	struct lock_file *lock_file;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
@@ -1011,6 +1012,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
 		OPT_SET_INT(0, "force-write-index", &force_write,
 			N_("write out the index even if is not flagged as changed"), 1),
+		OPT_BOOL(0, "fsmonitor", &fsmonitor,
+			N_("enable or disable file system monitor")),
 		OPT_END()
 	};
 
@@ -1152,6 +1155,22 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		die("BUG: bad untracked_cache value: %d", untracked_cache);
 	}
 
+	if (fsmonitor > 0) {
+		if (git_config_get_fsmonitor() == 0)
+			warning(_("core.fsmonitor is unset; "
+				"set it if you really want to "
+				"enable fsmonitor"));
+		add_fsmonitor(&the_index);
+		report(_("fsmonitor enabled"));
+	} else if (!fsmonitor) {
+		if (git_config_get_fsmonitor() == 1)
+			warning(_("core.fsmonitor is set; "
+				"remove it if you really want to "
+				"disable fsmonitor"));
+		remove_fsmonitor(&the_index);
+		report(_("fsmonitor disabled"));
+	}
+
 	if (active_cache_changed || force_write) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
-- 
2.14.1.548.ge54b1befee.dirty

