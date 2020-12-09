Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D98C2BB9A
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 10:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFB92336F
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 10:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgLIK7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 05:59:52 -0500
Received: from mail-eopbgr30099.outbound.protection.outlook.com ([40.107.3.99]:9028
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730180AbgLIK7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 05:59:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsfJEXc24K+eJy2F3JTfmHM8XUqgInCQnJGEWhGWCZ4RFInWJwueop3r4PLzm+LjVyEWBPFpoLpJfmr+f1xpzySrm3RcROnLHjEanmQpfAw+Ji9G/a5orqGxzlbcQgNCzw3FVlulg4JO3u42Vk652DWNe/T/vMKVgAfjW5jdDxqEBpUVnRjB8RZKsokBcIfhHyNWPZ2boBqKxkWEjsPJ7y/hO01BXOS7qmgIjvolJDfDd3OCJrKRH91bnSNf2tNsoFoAs2xFci6CAwuWi9up2z1hXCuxc7YPk0MlLYewXASqA3YaIs+PxU480zalAEHODVLabSFkW6B1P7z1yvuwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ6qmddLxgRWZg8Rforf7AlvsTIMNLq6jj1g4/Wc4O0=;
 b=MsTJ7Sri00imqngK0MvhJvBBoaT3AtY2GbfSQbmu+5ZC7pvY2U0UVxJI4ud6vcA0RnadfWwxeclTXauoVgtN9gGSQMHI837J+VZ6zfQ2J8BGY6z+tkP8w0NrOtyS4ScRtEbN1TiU02BzMoR11emF3YdrAwmtTgViyvZmExIOVM5eCfZcCbdD5wdLRlSK9LqT3f4+R24HIlex+zZoPnZ2RME/omLgIfWsDpi6401RxWbiB0tOO+oZUtworF35XGZbe0eEGwjWdNJIsMIrMu4iPCab3VqR5w0oFH3hFwQtv/HL+f8SYVLLSPuq3nrQvh1YTb05g6DOLwR+yUcEJlfVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.101) smtp.rcpttodomain=gmail.com smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ6qmddLxgRWZg8Rforf7AlvsTIMNLq6jj1g4/Wc4O0=;
 b=cYXVN1dhhURKHRobMwun58Wm4F64nIqlkASyRhfW6Ql5OvispQG0n59vUXaEyvvsAEdov9gDHMOxRGUVqBtOhv9DG3ePgBWa078r0xSgi7KNCxta5gyyOVgoD2tJJ1zH14k+96hWYUgETXOMGo1ooEeeRNNu4q950aUaAW/Bbl0=
Received: from DB6P192CA0006.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::16) by
 DB6PR0701MB2438.eurprd07.prod.outlook.com (2603:10a6:4:5b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.11; Wed, 9 Dec 2020 10:58:58 +0000
Received: from DB5EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::8) by DB6P192CA0006.outlook.office365.com
 (2603:10a6:4:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 10:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.101) smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not
 signed) header.d=none;gmail.com; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.101 as permitted sender)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5EUR03FT050.mail.protection.outlook.com (10.152.21.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Wed, 9 Dec 2020 10:58:58 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 0B9AwtKT014704;
        Wed, 9 Dec 2020 10:58:55 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.us>
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.us>
Subject: [PATCH v4] submodules: fix of regression on fetching of non-init subsub-repo
Date:   Wed,  9 Dec 2020 11:58:44 +0100
Message-Id: <20201209105844.7019-1-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.29.2.457.gf179bca
In-Reply-To: <c0971d1b-3bc5-8004-09f8-7ce10fb3df26@nokia.com>
References: <c0971d1b-3bc5-8004-09f8-7ce10fb3df26@nokia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf858ad3-12f3-427a-91e3-08d89c316dd1
X-MS-TrafficTypeDiagnostic: DB6PR0701MB2438:
X-Microsoft-Antispam-PRVS: <DB6PR0701MB2438DA167FB4F466114B20ECEECC0@DB6PR0701MB2438.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkrBkzVWH86qMwI3sYBzqG633O5vsipQe5RbO/f1+iVfq+OsBEfWJ1qH/IQoZBGQdTNrDoVXRNIjk/6rhMCjC/cJMAVdVNmEiXJcdwq4bjxsr2iezWQ6BYBGqe5+zhqfzpwOwmhe4oM/0dg+Jsw8hbGuKc4JRhJedd/rwAVY3Dtz8auV663MaJ8ol8suzITC1p3IwSnvIp7zF1NRUnUVfHYRt7lb1Tif3Fyza5OX2FeOLW1LsV9i5BVk/suM9TSCnp/F876ZL3FsYEdgVt9CqagSIH8olBEGbyzAcIs17pGQ+jlX4oQpV1/Z18Bsv2ev/pcI8CJ4c9ejBQj+z9CgpgggFfVg2UIcUt1JtQy4hvOFLf7UgWLEmV1D2mYvnn1M4w6EBumrqm6grCBzrMR0iIPKQX66mBH7J1SY9chtl9o=
X-Forefront-Antispam-Report: CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(46966005)(34070700002)(4326008)(2616005)(81166007)(47076004)(44832011)(508600001)(8676002)(356005)(36756003)(8936002)(86362001)(336012)(54906003)(110136005)(2906002)(83380400001)(1076003)(5660300002)(70586007)(82310400003)(186003)(6666004)(26005)(4001150100001)(70206006);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 10:58:58.1737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf858ad3-12f3-427a-91e3-08d89c316dd1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2438
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A regression has been introduced by a62387b (submodule.c: fetch in
submodules git directory instead of in worktree, 2018-11-28).

The scenario in which it triggers is when one has a repository with a
submodule inside a submodule like this:
superproject/middle_repo/inner_repo

Person A and B have both a clone of it, while Person B is not working
with the inner_repo and thus does not have it initialized in his working
copy.

Now person A introduces a change to the inner_repo and propagates it
through the middle_repo and the superproject.

Once person A pushed the changes and person B wants to fetch them using
"git fetch" at the superproject level, B's git call will return with
error saying:

Could not access submodule 'inner_repo'
Errors during submodule fetch:
         middle_repo

Expectation is that in this case the inner submodule will be recognized
as uninitialized submodule and skipped by the git fetch command.

This used to work correctly before 'a62387b (submodule.c: fetch in
submodules git directory instead of in worktree, 2018-11-28)'.

Starting with a62387b the code wants to evaluate "is_empty_dir()" inside
.git/modules for a directory only existing in the worktree, delivering
then of course wrong return value.

This patch ensures is_empty_dir() is getting the correct path of the
uninitialized submodule by concatenation of the actual worktree and the
name of the uninitialized submodule.

The first attempt to fix this regression, in 1b7ac4e6d4 (submodules:
fix of regression on fetching of non-init subsub-repo, 2020-11-12), by
simply reverting a62387b, resulted in an infinite loop of submodule
fetches in the simpler case of a recursive fetch of a superproject with
uninitialized submodules, and so this commit was reverted in 7091499bc0
(Revert "submodules: fix of regression on fetching of non-init
subsub-repo", 2020-12-02).
To prevent future breakages, also add a regression test for this
scenario.

Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
CC: Junio C Hamano <gitster@pobox.com>
CC: Philippe Blain <levraiphilippeblain@gmail.com>
CC: Ralf Thielow <ralf.thielow@gmail.com>
CC: Eric Sunshine <sunshine@sunshineco.us>
---
 submodule.c                 |   7 ++-
 t/t5526-fetch-submodules.sh | 117 ++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index b3bb59f066..b561445329 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1477,6 +1477,7 @@ static int get_next_submodule(struct child_process *cp,
 			strbuf_release(&submodule_prefix);
 			return 1;
 		} else {
+			struct strbuf empty_submodule_path = STRBUF_INIT;
 
 			fetch_task_release(task);
 			free(task);
@@ -1485,13 +1486,17 @@ static int get_next_submodule(struct child_process *cp,
 			 * An empty directory is normal,
 			 * the submodule is not initialized
 			 */
+			strbuf_addf(&empty_submodule_path, "%s/%s/",
+							spf->r->worktree,
+							ce->name);
 			if (S_ISGITLINK(ce->ce_mode) &&
-			    !is_empty_dir(ce->name)) {
+			    !is_empty_dir(empty_submodule_path.buf)) {
 				spf->result = 1;
 				strbuf_addf(err,
 					    _("Could not access submodule '%s'\n"),
 					    ce->name);
 			}
+			strbuf_release(&empty_submodule_path);
 		}
 	}
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index dd8e423d25..c42ece1f04 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -719,4 +719,121 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
 	)
 '
 
+add_commit_push () {
+	dir="$1" &&
+	msg="$2" &&
+	shift 2 &&
+	git -C "$dir" add "$@" &&
+	git -C "$dir" commit -a -m "$msg" &&
+	git -C "$dir" push
+}
+
+compare_refs_in_dir () {
+	fail= &&
+	if test "x$1" = 'x!'
+	then
+		fail='!' &&
+		shift
+	fi &&
+	git -C "$1" rev-parse --verify "$2" >expect &&
+	git -C "$3" rev-parse --verify "$4" >actual &&
+	eval $fail test_cmp expect actual
+}
+
+
+test_expect_success 'setup nested submodule fetch test' '
+	# does not depend on any previous test setups
+
+	for repo in outer middle inner
+	do
+		git init --bare $repo &&
+		git clone $repo ${repo}_content &&
+		echo "$repo" >"${repo}_content/file" &&
+		add_commit_push ${repo}_content "initial" file ||
+		return 1
+	done &&
+
+	git clone outer A &&
+	git -C A submodule add "$pwd/middle" &&
+	git -C A/middle/ submodule add "$pwd/inner" &&
+	add_commit_push A/middle/ "adding inner sub" .gitmodules inner &&
+	add_commit_push A/ "adding middle sub" .gitmodules middle &&
+
+	git clone outer B &&
+	git -C B/ submodule update --init middle &&
+
+	compare_refs_in_dir A HEAD B HEAD &&
+	compare_refs_in_dir A/middle HEAD B/middle HEAD &&
+	test_path_is_file B/file &&
+	test_path_is_file B/middle/file &&
+	test_path_is_missing B/middle/inner/file &&
+
+	echo "change on inner repo of A" >"A/middle/inner/file" &&
+	add_commit_push A/middle/inner "change on inner" file &&
+	add_commit_push A/middle "change on inner" inner &&
+	add_commit_push A "change on inner" middle
+'
+
+test_expect_success 'fetching a superproject containing an uninitialized sub/sub project' '
+	# depends on previous test for setup
+
+	git -C B/ fetch &&
+	compare_refs_in_dir A origin/HEAD B origin/HEAD
+'
+
+fetch_with_recursion_abort () {
+	# In a regression the following git call will run into infinite recursion.
+	# To handle that, we connect the sed command to the git call by a pipe
+	# so that sed can kill the infinite recursion when detected.
+	# The recursion creates git output like:
+	# Fetching submodule sub
+	# Fetching submodule sub/sub              <-- [1]
+	# Fetching submodule sub/sub/sub
+	# ...
+	# [1] sed will stop reading and cause git to eventually stop and die
+
+	git -C "$1" fetch --recurse-submodules 2>&1 |
+		sed "/Fetching submodule $2[^$]/q" >out &&
+	! grep "Fetching submodule $2[^$]" out
+}
+
+test_expect_success 'setup recursive fetch with uninit submodule' '
+	# does not depend on any previous test setups
+
+	test_create_repo super &&
+	test_commit -C super initial &&
+	test_create_repo sub &&
+	test_commit -C sub initial &&
+	git -C sub rev-parse HEAD >expect &&
+
+	git -C super submodule add ../sub &&
+	git -C super commit -m "add sub" &&
+
+	git clone super superclone &&
+	git -C superclone submodule status >out &&
+	sed -e "s/^-//" -e "s/ sub.*$//" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'recursive fetch with uninit submodule' '
+	# depends on previous test for setup
+
+	fetch_with_recursion_abort superclone sub &&
+	git -C superclone submodule status >out &&
+	sed -e "s/^-//" -e "s/ sub$//" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'recursive fetch after deinit a submodule' '
+	# depends on previous test for setup
+
+	git -C superclone submodule update --init sub &&
+	git -C superclone submodule deinit -f sub &&
+
+	fetch_with_recursion_abort superclone sub &&
+	git -C superclone submodule status >out &&
+	sed -e "s/^-//" -e "s/ sub$//" out >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.29.2.457.gf179bca

