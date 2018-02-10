Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF221F404
	for <e@80x24.org>; Sat, 10 Feb 2018 01:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbeBJBB5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 20:01:57 -0500
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:13089
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753300AbeBJBB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 20:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ad/LFPmjcHuo0U2M9dQgkwmAcRprO6UYVcJBCpva0rE=;
 b=VPf9D1M56JnugZESCsOgLX1LsanfLUKlXY0CEZxhfbdN0mINQ3EFycnqBMjxOVuyaIw+rxeeZLXRyIuneJvwCTnao+sZZLfOK7xBkoal/uTvgzdSIIyCHzRzo4EvSrn2Jylb/0IjEZgdxdwsCvxnoMVnaxYvio/Tr9x0cE+im4E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.92.60) by
 BN6P136MB0018.NAMP136.PROD.OUTLOOK.COM (129.75.91.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Sat, 10 Feb 2018 01:01:52 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, matthew.k.gumbel@intel.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] worktree: set worktree environment in post-checkout hook
Date:   Sat, 10 Feb 2018 02:01:32 +0100
Message-Id: <20180210010132.33629-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.92.60]
X-ClientProxiedBy: AM5PR0602CA0009.eurprd06.prod.outlook.com (10.175.46.147)
 To BN6P136MB0018.NAMP136.PROD.OUTLOOK.COM (129.75.91.25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62e8e791-bfe3-40e9-b922-08d57021dffe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0018;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0018;3:uUktnu+BNdRK/8SOWCBaBftLF47AtvryDhiekvrJyCEvqEb1rcx4sVjyydhlUv1oXL0SggS8x2x23RpR2k+IWuguYhWzdJJkiy7Br3w35iwQobtNOaWJHa1wfBglWc9/xjPff25MLH0dGNzk3RzdtZcsJ51cD75B3QaxnRKtvLZSdi03Bsbeh9Lb7pV9+E3aPPR0FNN1G2EomoJIJnq+l1XKs0TqWEx5rZNOoRbkT+biXnxxgdM8WEJTErgd0N+y;25:UDYnn8yAE3zlpkW27Qlk0tBNtI/yHejZ+3G3hIS/IFf8qp3s0oMNz1wVIHfGg8a61UZ31t9Z1tFpSNGYTdZco4kRpomUt61DWPlH644sg1q6b2P3HtvXB4wl58DDN1xa6ISC4jlDW2WpPiZrb2ChNV/nz8UUOoZ4cV//IoduwIlrEtFrQnM7sgxWoF+zO1XZ/suNg19RTqN2uX1mRtIvtIubggK/UlKRgNMKA7eogJp+JzEIhrFF/IYKrJqnTlLbG5LarznQI6/d5PxoYI0NulB/9GhsZ29g+LpPLaGxGuKiITZAXzD0r1DBCsdmARW6oCMaBUrcUQwi6qlCdoLxGg==;31:0mE+CGLSzQbxixzMLSr6tlaSgoof7Oqhp0LNDZJePV86QaFGV+H4eiXle7LoZmUnVvwYKN0//zUohPTl6Mnc4Mh2lvC+tF9I6lKOVqmdxe+dXpmO7KJkcpwzAeLjeKrs1ZYHXLH6/mqGv9JqfuxaBjFfzPF+7S6XSxOCM6AF+fIgeAbYTui25MOYUFN1fJ1Jj3j6Qg1L0RatcuvnzRikltugSr4bD8RZcki/3dt/4bc=
X-MS-TrafficTypeDiagnostic: BN6P136MB0018:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0018;20:09sSej7K/pqbEvbWOGs8vhUuf8xizuPFchHrzOodxWHmUp5kpOJJA3l5KQ8UGL7cyjGfq6z8kCMduyX2zrC5MGodbmTFGLH27cvUe9/+uNo0dGC2bWFfVaNlQnIbfIV7r818xl2ab+Fd+Yh/Qor5aheZp5oB+FBv0KyXG87Pj4gs8gZaJuKIkx831SEXPuGBb0/KUgBA806hue586eHV8NCxACtKdmY94S5fyHl2ZnSBXjIAFRgl7X63z/mdEaHekeF4Wb98E9s+uiqNZNJW8btg2w91L9xNSgfn8FCsPszakf2gCV8mV5wpAzVGg1ZjzzHbfeJSphUNfRkYmLm5gMgxfGZSbLx2uBunUGgLwBFMMdIGYZscarUdcW4PSheZas4gvROTZZMMyV3L13sHtRn0XfFpDF2VTlDe7AEwajP5Vc7K0ZGtYWoX+6PyOKScGUOix8JWdD1pLmE6pps9fBJVIgaoUQy7OrPQmhuiVpuk7qiM/3hN+3VhfUA+A+y6AFR/8AreO8MF66TsWSVkLRuwiMcvZYRLtd82yMgBCgF5KtolEmgUVv3YB9XnTZGLVOb+vzdtHlp/JkP0+47+2J5jAHQ3xGcPwklsNRhxMOE=
X-Microsoft-Antispam-PRVS: <BN6P136MB0018126114A75A4F4AC2D7CAE8F10@BN6P136MB0018.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BN6P136MB0018;BCL:0;PCL:0;RULEID:;SRVR:BN6P136MB0018;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0018;4:jTb2x7oMPodXdZxobHuYFbHEQtPKWlH3kjF4+O9gKYXLBhLJQxDDZnwbQFAN3K2KK1pAERPsgx0cdnRDxyjIvd4nsWkhm8pQpLfXM2l1/q9aFa+mGj1sP1xBtZfsVVukMTs/EDl2j89PHRHHMr0uIajkSkLGfttdTQkPuLyQG1Qi+yTcC/dYeXJybWrDmVndzzWESrEmzZnpLZVhVX9WBvJVWpltZ6e7UEBKYw8O940HVtfnr1rpjIkZRjQwEz7kFo6sDfJG98dCpjDvFkwSNj7AEKAWXjHDDOYRKDZMRG00R6q3/RXGyWyRjz1de/IDplW1iqt7DhIUIs29VtEVsXiRRgaHfmczGdtSeETGvf4=
X-Forefront-PRVS: 057906460E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39380400002)(396003)(39860400002)(377424004)(199004)(189003)(16586007)(85782001)(48376002)(50466002)(66066001)(966005)(6506007)(86362001)(575784001)(6116002)(53936002)(3846002)(47776003)(39060400002)(4326008)(386003)(6512007)(52116002)(2361001)(186003)(9686003)(478600001)(33896004)(97736004)(2351001)(6486002)(25786009)(51416003)(6306002)(53416004)(6916009)(26005)(69596002)(7736002)(16526019)(68736007)(81166006)(316002)(305945005)(6666003)(5660300001)(8676002)(59450400001)(50226002)(36756003)(1076002)(81156014)(2906002)(105586002)(8936002)(106356001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0018;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0018;23:48c1yu0aGrCU3zkGzd/KhVaZd5sSTdbrHE7Wpj/AJ?=
 =?us-ascii?Q?hfTq38DZXHL/EgNHUhrHHrsdg8h9KbSdpZwuLyTT9Tsrandm+E5pPWpz0Zfm?=
 =?us-ascii?Q?jVmtj2NAXtZYmPk1hLhJCz7plbrGZYSYpCWCu3++rpEX1nCyivXMDomag7YB?=
 =?us-ascii?Q?M8csaQl0wIRbQJysmUKjtRZMgXLk5sInhDB43RQ9KVz8oCNQG0a8NqhXDv32?=
 =?us-ascii?Q?sq31aagC52MruiM420ZHWnrcYDXUimyvGxYv40zshrm+ovmQxUQO1ZL9q4kA?=
 =?us-ascii?Q?6TDLingC5dKJex80aeMF1+/wmqvuyeNERxwaqzEF9ArGjKIHE3QVrnBZZs0M?=
 =?us-ascii?Q?lCvz+Y6qRwN5qThdIPHBMc06ZFM4pVf6ZZO6eXbeHmLlk/sHfZiF4xqGyD12?=
 =?us-ascii?Q?KvWy6hBI/Y7RzuQrvn3yubE2zGWgghFAX9zz3aoZ+dAKGvgPl62YIrAwY5Np?=
 =?us-ascii?Q?bSRy4tZUbddoJZLHEaDFamaIgoKLNbACt06m5RmUw7Te//03XWn8gZsqmArS?=
 =?us-ascii?Q?CWcvyGyQb3LVCWADIL8Ntw292gVKEde3R2HvfecvfxTuRYCi/1nLX/VUPPO5?=
 =?us-ascii?Q?mG4SXZEbFvvS2EuldxpWYEBTneBRmNh5BdZNuhqNB5zHU5m9SOSIsWznAkyi?=
 =?us-ascii?Q?IRVpUClC64pf6KC+W88qo1l+CyEwuL2AjklIrJwKLfsajJ0tcA+DXFRp1XFY?=
 =?us-ascii?Q?2TO+LAIhv2fpWBycDpRIh4oruGAzi3xAU1e5+7IG33DB2e+UX9qE+T7cTmoA?=
 =?us-ascii?Q?KDKYFlyz3R8sIc3xfkY9ORtaWZ45oXkKnKvEDVpq9pGausNQjHHzD3uJ09aS?=
 =?us-ascii?Q?s984qkwA5jqqqW3STh2wQGRIWRoHfok0w9wV1mbpe4MqUgXbb65jRxEMIF1P?=
 =?us-ascii?Q?buRIuneLVN6YtRt6gazCkz/fj/dy8zapJx2+zaSaec4aA/EU8RGkYutofiOM?=
 =?us-ascii?Q?9cV6QCuMmv/ekT1tnSM1UUOUFeFN+p518mq2HZVpIY5i9aE17hW7aZVt5QJm?=
 =?us-ascii?Q?njZtPRA0uKVFCxux3z8t1Uz9IWAojDxaALzHIEN+RBLXPBcPsi4eGcmxDoEL?=
 =?us-ascii?Q?/noX02RynQAZ2pnrieh2R+03ObwU0M9zBPSDodztPcpaplw45GuWjGrqhW8n?=
 =?us-ascii?Q?/f60EhyCoHx+n+SujXCVSiOPa3j6ZX6SPUmjj+ppqk5gnLLl+g6oD8kMORia?=
 =?us-ascii?Q?QDKsn+2WPSBHrh2YcavFRaz+FdWzMLWRbFVQztfMVm/eF+2G0KKuCSHnlSBc?=
 =?us-ascii?Q?fP8AwUNnJ3e2G4/jgt9DtqpOWy9kFUT0Tqjl1lBqXI4UjyUNKKCorGjdOdn4?=
 =?us-ascii?Q?zuqvyPb4GRr2xxJX6SeDqiZzllxupcqHsFbrwVqnJz996m5hcBRTbsqSPNr9?=
 =?us-ascii?Q?782mrjqSck2WGpOaYOhxgyCeB8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0018;6:g9FawMzYaryFedKS0YxaNsFiuG6teZZgClqj4ekON2zY0sB+nY+E9vDFHtHkxXMFuH6AXTWhN52/FuZCpNzy+CD7wtRyKLqj/vcSNzjAwVmXvV++Ip8DZMfpx/m+/AS5n0N/q5HTqvWp4wPV701ewFY2gx3rWe6xslyJg0ao1X8GmmN4ZumIinFtgqHY6BP5MF/T+ks/tS9FmNYqN/V+Ub7Iq2uoJi5U9OcnHZgKIABIUuZrAeXKm3qlajS1Y5HxxRwa2iAZMV976fE2iZb9pFgUyZ6y56YOBcMvBt7HZ53zAxgSi/3rjh+8Bu5vkRVaB2JGU+9KA8A9MXUkwZhC95EGKt0RhfoLTYCNpOLycvc=;5:7xPRMb3Ik1oVvbbOT1dL5yUhFcLxblEh7vOkPZO7yOk0Bu49+lCm4tRFyxrIONSZzjGMwWFniCkpCPld1WIEQ6r9abowE8/QBNEwLaxyteviz4emrx6MzwFa/hoTMXt7IPDYlvsaSo5GGykEk43do0Wpu6NEjOxHf1AUz2TNDNM=;24:XX4JBgPLw4JfsgDX9fvVI7f25DJLnj91IZCHJneA7KHrMPSJRgK3ScFQozjThdTMqY59Qyx8kE6gWROSFEMx+sND0UIchVm6i+OP3jInZj8=;7:6xHNfT1hnTMtC/adVvyYk1YBpVgQklyWIQty4577z1m/oBpu0EyMJcYgPLH2zSgbXuz3YGRDc6UBkQGFeMmXiQ0x0gbcQ20LsQJ40D/w9PuW28qUJOy7ikhtqVO3Pyc7GFdcMMjCiIMQbDUtAX7qgxOiunGEro4/3BghVb1q5Kr+MF9VEdmr7lBdyR2aNsKiKB2tHGEIME6CzADOxBiqMXM98W5eHqEe/tY1XG3ySxw6/SK5ylbOplKUE6V0kcoK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2018 01:01:52.8756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e8e791-bfe3-40e9-b922-08d57021dffe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0018
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

In ade546be47 (worktree: invoke post-checkout hook (unless
--no-checkout), 2017-12-07) we taught Git to run the post-checkout hook
in worktrees. Unfortunately, the environment of the hook was not made
aware of the worktree. Consequently, a 'git rev-parse --show-toplevel'
call in the post-checkout hook would return a wrong result.

Fix this by setting the 'GIT_WORK_TREE' environment variable to make
Git calls within the post-checkout hook aware of the worktree.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

I think this is a bug in Git 2.16. We noticed it because it caused a
problem in Git LFS [1]. The modified test case fails with Git 2.16 and
succeeds with this patch.

Cheers,
Lars


[1] https://github.com/git-lfs/git-lfs/issues/2848


Notes:
    Base Ref: v2.16.1
    Web-Diff: https://github.com/larsxschneider/git/commit/214e9342e7
    Checkout: git fetch https://github.com/larsxschneider/git fix-worktree-add-v1 && git checkout 214e9342e7

 builtin/worktree.c      |  7 +++++--
 t/t2025-worktree-add.sh | 11 +++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..032f9b86bf 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -345,9 +345,12 @@ static int add_worktree(const char *path, const char *refname,
 	 * Hook failure does not warrant worktree deletion, so run hook after
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
-	if (!ret && opts->checkout)
-		ret = run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
+	if (!ret && opts->checkout) {
+		struct argv_array env = ARGV_ARRAY_INIT;
+		argv_array_pushf(&env, "GIT_WORK_TREE=%s", absolute_path(path));
+		ret = run_hook_le(env.argv, "post-checkout", oid_to_hex(&null_oid),
 				  oid_to_hex(&commit->object.oid), "1", NULL);
+	}

 	argv_array_clear(&child_env);
 	strbuf_release(&sb);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 2b95944973..d022ac0c26 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -455,19 +455,26 @@ post_checkout_hook () {
 	mkdir -p .git/hooks &&
 	write_script .git/hooks/post-checkout <<-\EOF
 	echo $* >hook.actual
+	git rev-parse --show-toplevel >>hook.actual
 	EOF
 }

 test_expect_success '"add" invokes post-checkout hook (branch)' '
 	post_checkout_hook &&
-	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
+	cat >hook.expect <<-EOF &&
+		$_z40 $(git rev-parse HEAD) 1
+		$(pwd)/gumby
+	EOF
 	git worktree add gumby &&
 	test_cmp hook.expect hook.actual
 '

 test_expect_success '"add" invokes post-checkout hook (detached)' '
 	post_checkout_hook &&
-	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
+	cat >hook.expect <<-EOF &&
+		$_z40 $(git rev-parse HEAD) 1
+		$(pwd)/grumpy
+	EOF
 	git worktree add --detach grumpy &&
 	test_cmp hook.expect hook.actual
 '

base-commit: 8279ed033f703d4115bee620dccd32a9ec94d9aa
--
2.16.1

