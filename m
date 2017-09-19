Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4BCA2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdIST2d (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:28:33 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:27081
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750919AbdIST2b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=H+u4JMsOqfNop/3dpk7rHE/k7fq2TN49jLiSDVPZznw=;
 b=MvWvLLUQB+OnWB2zwjEjuBqkANaTmKUeceQGAx6mBinLMnvdg7TujcEVTRQu0cyDfDq4mSRVojmdAgvQNH0U1j8eSeU9LkLb5e8CjsgcSRYAZsUY4vQNn+66AHF1qkcgxgDcd9agCELqd5t8aUXsOhx42MXBm95DxVm43xWHs+4=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:27 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 03/12] update-index: add a new --force-write-index option
Date:   Tue, 19 Sep 2017 15:27:35 -0400
Message-Id: <20170919192744.19224-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-Office365-Filtering-Correlation-Id: b290c13b-ccd9-4e4a-4825-08d4ff949afa
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:3nDZxysG/4x6W4HxjzStmFEuQ1XQ9i7UeV59pVmr+nqi6iAZhNz+2MQ3HzJSkqF3sURXdi8TyrAO7wguxQrkKGB5/8CEXVhSf0P8AtrehbrqAWcUJlmXn0an15bNXac0MZC3SqPOZS/oUzUBS7c7RXExtEcGpPvyOEN5T3x0EgyAR+YdUk5S3CejEGDBX7vFF58ML1FT8dd5K4hmhrNwao7yCUW3WZEidJbWyh+zCOKrm2Ti0OHUpX0kULI08eYX;25:c8ng2YctD8F3jW9JDrCVYNDcyJFLcKEgrswuQrSEMFOtyozpUV2Hua0LtWOjNUiTqLpwOquB8/oU/OoyW5jm33vkLnqGsWsTi6Zh06LnyEOsJPE81xHrl6+kUpDu+RgIYngS2JZ7xdvLSGrUcJfgE33WZfJe1B4tVAWo/SqLUQhLqiDfeXNJ2Ef+I5/H4GWzojvejuwCMEtL8Mttc+/qyi424eb41iB/mzh2ySP6fB8/VMF0wMlxX//SE8+u+HnjpGgaEBn1fhqsbCp6AGfNcuYyv0a7Baxu4E+ps7aLRtcALBIJlLPV76PxvlmKoyUvpggxJrqsuQIYtVVLYnA0Ww==;31:6FaY1mmLuGgpM2+mYWkC6iI2V6+lk2MUA1zHmi1BSSck0LGJ8U1MI8VCyiIDsUSX0BKuUHIhvOH4neATGb7lxIfemJtmtPbjim+fVRRfr1oiskJD2F5rSGWxG/lLPXZwuiRsjl73S4rdjiDDGsfzyfiKLz8EDRbIwoQkfyLPVZ7SJCWvClbUWmfe+E+Jo19BaXSkiJj+S9k/No+t/X9F226/+5wlnoRtjUy13Mlu+Oc=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:3ophdpG8hjTy8JHM9f4ni3Xi7pIh4VX+c+wW7M+QGq2kr4OCGR75MCneIxWDSfS97oHseV5tVukHOW0WYngPAhGED88/3XN5HIjBk3zBbO0mwDeSlMJspfHBV/7E9MDVNOOiEeiQ/I/2fgXFPIYF5mDWMaNaC0NgR54EYYcz7qPgK1Nq3xNrMT9eru939jQu5IDQsV+UVzJTat1563HkR4Emd7teFxM+3Juwl4K5tMCKE1VACeqmtuP/NZ8u7oEc+yqJMjpi4kG5+UvrD0OwOXyl/rqgcyllUe66xDY26y182ocGGYcOSu5R1wpfprUfBMCKWuhM9Vp1wAxzxSpZqbs3fnX2wPWxm5Emh32EKKiWbYMMVymi1ZOskSmYDi2RTBWVU+OPJnqivMxvbAzd93PmL7N5skUcbskTFDQejrkVZABIS6dxe6JXV3etdrkglLjRlDcHOptHK56WeEJ9fkqNf1T4mnMYp0QsWGULBnrwFTCHGyjbG0eyfkwJvfdU;4:lS0UGl74yqnJSzXQa8A51KqtcraXeJCiaX0sSxVUMcJO6d/N0W2kQYjd0TNohqupxrLKWw8dK2q1NnQWZOJvLiLRx0Ooh8KVz5OG1tMWeLM5OW7l/rKLcC2syz3OfbSCBePPIHn+D0A1cIY1q0b2FGjOQ2twXQd3860+igkO60J+uvEs0rj2feekVh/yRip3XYh04WoGs6M20SDEidQ6k+Bb2m7Sqb5gbfcrOYFK75YfXuWxDWvUOC+QzyM9EOtl5fbWDkPuKPApr0b/tplsF0a71yEuTLOhmLeqa0OyCu0=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB04712DF655442F366320D3BCF4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(6666003)(5660300001)(33646002)(48376002)(50466002)(36756003)(8676002)(16526017)(10290500003)(316002)(16586007)(37006003)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(15650500001)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(5003940100001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(66066001)(2950100002)(230783001)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0471;23:PxXnHHPnCADZAt7LWkp2G4h5cu2dxqtrK0oR2rBCM?=
 =?us-ascii?Q?jaLoj3TvMlHAWwIW4yCVJ8rn0OjaMAr/D+HS9AuD4m2Y8ZhtGcgoFnqHD+wl?=
 =?us-ascii?Q?9aUyvnPLCreuqB4Q2nyZo/Gt9JflDRlAA0cEzwtyny/Ix4bZVpzxsFieEVcb?=
 =?us-ascii?Q?X7BET0EjY20hEjdxEO/Qks/YK5jT45E9l1lu4RNe1EsokLr1cJnIhbLHSv6t?=
 =?us-ascii?Q?ZYMHRHz6He+OGojePn899NqET/mNA6vrp1Ww/Oxied+RG9hO+R/0viq0YUbz?=
 =?us-ascii?Q?8UK1Sg5ZqCOdSeyg3DIxAGOosk7s8pUoBtHwadNX+eaw+C68iEYhTA2fgJfy?=
 =?us-ascii?Q?As5qYON+dLNoEmKc5+7AAsAbRAk9ZSuwM7rSTLnfWthlyFl0bFN+FhsgJNld?=
 =?us-ascii?Q?U+eXHFVcolxIJUIG/1P2X9V03WRa9r0jG2Ha1eobuKFAWS4D8SczmmEB8FS/?=
 =?us-ascii?Q?xId6eIhvOlxiWYe33KVNVfXg9VHlGfftYyfT6saxrRdvPMxoKW3YTaNFDDKG?=
 =?us-ascii?Q?US2KglB9tCnCtiMusU6+2x5Jv0h7T0+JIJ1WbpuZIerBCuztMzmJTPtwBgGb?=
 =?us-ascii?Q?GLdh9aeGlSBDOra/6Jz7lKFa4VZ9+yZyEHU/SVIOuJ3+UcTDEFdyaA1tDODg?=
 =?us-ascii?Q?TBTaDeHwgBL2dw9oKsYy9tCRRpY+rCmfViKPNcyJkWC0m6OysMspx1eddNFw?=
 =?us-ascii?Q?rFBFneZoNLXFgOKTggbHIKBlSOaxz0IXCFwI6LBRarLdya8YD6nXdHkCW3Dt?=
 =?us-ascii?Q?Jhcug70yAblBRK7yFML7CyunDwcQDaWtgqQ8Qg3xMoJ6zR2GQeKEcBjay4sp?=
 =?us-ascii?Q?rSpQjIZrICvSLCu77H4s8XAJuTT59eJo/V4x1SU+7zrMlYxU4OZMV0UDn+om?=
 =?us-ascii?Q?UHbYm36KmCqjHiIsEDLjBuc9cTZIpeZ3TUm+cD7xoUZOeeNGo3kTCS0kpFuk?=
 =?us-ascii?Q?kgLExzEY+R/zkmleOtWptdln5rZxvgXrNHBp9HyurqQiW8mlAM9GXlwasszp?=
 =?us-ascii?Q?QIf5ryBFERBr0uSQL9uA2M5YnOz+y9bOhRGxUO7dmR8L+9LleQ9OyJDZEFKy?=
 =?us-ascii?Q?61aAEx8ejCaxSyrVHUbH9YZQZzKnzxjBJw8KWCj4ff9gEpr/+bEipqHrXQ7R?=
 =?us-ascii?Q?dIyZpVFp4ZX4HyEDj0PGCUO4JOlMB+GJ+zqgxp1zkJsAzwMq7wCaiAak3HG5?=
 =?us-ascii?Q?+r4T9ZvTFMYyOg5fZN4rqGwtlQX4efwDXjV29DUciHsgbjgKcNVU+vU+NC8T?=
 =?us-ascii?Q?8FSQ/E4deHN2Kes+5ysKAUuccM63QFdSUEv1dqi0Hh2rECvhIfuN1TU2C7j7?=
 =?us-ascii?Q?2fq/nij4JT6hzR2IpD+K22xA33t5kRpMELXkyQyx1drO1+fAQBsSXDlPUChl?=
 =?us-ascii?Q?OZIf45ufzbWKXO0Iw9uwGvnerXUfOh4+NWS8z6RA6JH2KIcibirSZ9j0FoiG?=
 =?us-ascii?Q?y/hzCykJi92/G0ScpWDt00sVzedQmnM9W10ZVQgCOjXIxVhHKPdjzMpurAoi?=
 =?us-ascii?Q?67kq00qHGa+Sw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:SrCBbxeYd/Nb7VZBdspf3YKzfmBZzaKkwzhO1GkbdJAn+US6zxiOUo0eJdnyM9SCyTVBzAtLnW2C0/GaU1R5ezv9/sHOrLAEXesoQpVOH2mYnydQ3FKMscGz+jeO1fGOu18gnvQci8Srcc+6RnGr8zVjPQspM8LVPfbvj9P+KPNGqx7O+UHXXAAq/cwnP8OjTSpUOUpObG+iulaUN2z/z85hL610PhOOxkHykvaYx508WODy/oQA5Xx0/sDE1EyHPJkwZz2W1NIf1sMzzTTtvfHpVOzja4DrPJwisvvLCbIWYGg24g+SLHQydFME52ryvwsU5S5/QwKfS3GQSGFwqw==;5:ZUgzGjoBe436jRG1BIz9Co/CrcYYUTdYc/i/OiW7hCCFJPzZNIk0fGbL93+DuzJhy/Gyq46XgAh2XzluzhPYLpofTpRIIg3YfYNLdvTTTCEly6d5wxU/tnL0lgF8XZsHHFGBwx45owpVzoQMrHVjQA==;24:KPZufk7V5jbFXKEscyTttssb9NLN9/QSvgDoP+F9okIypzuwjWjxMynokvlc6RuxzKUpF6Cp5ef4MjsSq0U+QPUgNhVNTehC/lhB8uwqrig=;7:ZodbpcnndevS1aHMR8/G97v3Z0TOWZ848ub3MnGtsnKd6tVMc9hdLs3KL6d3kS3YzRP9iKEEmEkHvWY5FxCwKGSt41u+7g4TAM57ZY8GlDJfp7Xz7R0e/SPU+/Br6O5dncGHoShBNlLrD1C+3C6PK156XXMNDHZQqaGHgN4FBrcSmfMc2msW4FbFnNOknQyVRtboZzIBwS/3SbKJpTKHENakZBjHBNPWhS4WDwobbwQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:27.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At times, it makes sense to avoid the cost of writing out the index
when the only changes can easily be recomputed on demand. This causes
problems when trying to write test cases to verify that state as they
can't guarantee the state has been persisted to disk.

Add a new option (--force-write-index) to update-index that will
ensure the index is written out even if the cache_changed flag is not
set.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/update-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d562f2ec69..e1ca0759d5 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -915,6 +915,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	int split_index = -1;
+	int force_write = 0;
 	struct lock_file *lock_file;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
@@ -1006,6 +1007,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    N_("test if the filesystem supports untracked cache"), UC_TEST),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
+		OPT_SET_INT(0, "force-write-index", &force_write,
+			N_("write out the index even if is not flagged as changed"), 1),
 		OPT_END()
 	};
 
@@ -1147,7 +1150,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		die("BUG: bad untracked_cache value: %d", untracked_cache);
 	}
 
-	if (active_cache_changed) {
+	if (active_cache_changed || force_write) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-- 
2.14.1.windows.1

