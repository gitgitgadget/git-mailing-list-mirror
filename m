Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C2CC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 15:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228CD23AA9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 15:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgLHPoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 10:44:22 -0500
Received: from mail-vi1eur05on2102.outbound.protection.outlook.com ([40.107.21.102]:6092
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729558AbgLHPoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 10:44:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmXj/WpJQbtq0Er5AuGOJHym+lZ2cBPCATk69chOtn3pW907iH8BXOu0788Gb0BUXvNijna7xaNMU+EwEHj7joPffS4N0ronQPjtc1R2sEAFG4PhMTD8mnA6zUmAS9zhjlqjRzo9FKwVXd2wS7LEhp5mVbi6aRivnLSQJyaYdXV5RVRB2PS3swRVcvGc6RKdoVApPispW6RtQOd1rqGzKf6unm+bThzKvWQQzxS9GjD8C64wzrKJbukf5OfOWnq4Zu11PUMHBYGEbxL0TOtiwwFMicWeQfqqcU/607MiBL5SL+zc9WO+cwZI1vmkrawYS6Yqno8q9NlRQlkm8kyx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+roheIDD1Blqt882OFWRBv4/Nd4G2Vbtl9npWOtmCHY=;
 b=Cr+kUMQH7duAjagWCw/aioRClRBndn1JyZnY63UxVes0tq+UIlTeVYsg5e1e5FHUDwJnAH7MFgtfvvJkzOsQDLMFB0fDaWebpiOFU6yKSV/afxvX1kSpxT/WOdIWTiHiPONFJbUbB0FW2drg0NuOVqCuUw6PfjLfm5+tDCbKB9h5PGC+i3yn1xmZtNuhmDFW2x1XTA/Jw2traNJm0nvZCcljWfl93isI7rvWbKktjYw3GcEKWJCAvDWGTCMXI3pMaOzmHJ0RlLBbD06+rF7Gy4BbXfvr+jBrv5abca72+qTQm7U2rDeNS9G72IT8e8Wcm9juQaB1p79ZL2fbETaHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+roheIDD1Blqt882OFWRBv4/Nd4G2Vbtl9npWOtmCHY=;
 b=GJ9si69mow5+R+Mue5/8xUVFAq+yCIcSeMHFat5BOtqKSUcZDzF3j9zeQIBqRqvbhsK/nURqsxvw6I+kEEePeYasr0V6rjxe91o2LL3laDpxqvGqBdt5TUi19npvqY9eapeA1lBLdg1K3ZIcHnK1UIWjU/DFUlYe7nhZy9KKW1Q=
Received: from AM5PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:203:69::16) by DB7PR07MB4537.eurprd07.prod.outlook.com
 (2603:10a6:5:2c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.10; Tue, 8 Dec
 2020 15:43:30 +0000
Received: from VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:69:cafe::9e) by AM5PR0202CA0006.outlook.office365.com
 (2603:10a6:203:69::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Tue, 8 Dec 2020 15:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.100) smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not
 signed) header.d=none;gmail.com; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.100 as permitted sender)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 VE1EUR03FT049.mail.protection.outlook.com (10.152.19.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 15:43:29 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 0B8FhQDg004622;
        Tue, 8 Dec 2020 15:43:27 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.us>
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v3] submodules: fix of regression on fetching of non-init subsub-repo
Date:   Tue,  8 Dec 2020 16:42:06 +0100
Message-Id: <1607442126-34705-1-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <d52db91d-af6d-c93c-2c4a-e2460905623d@nokia.com>
References: <d52db91d-af6d-c93c-2c4a-e2460905623d@nokia.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e1164aa-1cc8-4ce9-3d64-08d89b9002ea
X-MS-TrafficTypeDiagnostic: DB7PR07MB4537:
X-Microsoft-Antispam-PRVS: <DB7PR07MB4537C33F2F811AA434AC5E92EECD0@DB7PR07MB4537.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tbgp44mkKnlVvVbsnwCL6HSPIoFn4AWPFMrhXlXvgGODklZjBvoaTvbwiQi9VMTkOO0aUp3o0SvaGeWscGf1Wgq1RaqenJFjeH9KPxmYabZQnTmZWq1YVumO0qxdMj4mkEZOz50AzazouLy2QeEo0m5a6yEAmh/ijnfi7gtHJBMusDF+wkRG8FCoBw4lTZMwtR1JAlHFsxBV1cfuXj1G+Tn5bo4esz518oLCe0saVanmF++iL06trdW3T0PNu9UBkbzR91yNDafq3IMW04BsgKY4ZvCzTet2KuIZUH2XB4ya2319qWem08pQOHntLcrvZZYhjUac9M85acPrww1JyYNBFZNC/ivQpV/qi1MyuGSyOh/ZEgPlw4lGNFd+jS570NcAO6aCBhomcHBZP8AT1Q==
X-Forefront-Antispam-Report: CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(46966005)(54906003)(110136005)(70206006)(6666004)(8676002)(4001150100001)(2616005)(70586007)(36756003)(83380400001)(508600001)(86362001)(26005)(356005)(82310400003)(336012)(44832011)(81166007)(186003)(47076004)(4326008)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 15:43:29.8437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1164aa-1cc8-4ce9-3d64-08d89b9002ea
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB4537
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

Furthermore a regression test case is added, which tests for recursive
fetches on a superproject with uninitialized sub repositories.  This
issue was leading to an infinite loop when doing a revert of a62387b.

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
CC: Philippe Blain <levraiphilippeblain@gmail.com>
---
 submodule.c                 |   7 ++-
 t/t5526-fetch-submodules.sh | 124 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index b3bb59f..b561445 100644
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
index dd8e423..495348a 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -719,4 +719,128 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
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
+fetch_with_recusion_abort () {
+	# In a regression the following git call will run into infinite recursion.
+	# To handle that, we connect the sed command to the git call by a pipe
+	# so that sed can kill the infinite recusion when detected.
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
+	# setup a remote superproject to make git fetch work with an uninit submodule
+	git init --bare super_bare &&
+	git clone super_bare super &&
+	git init sub &&
+
+	>sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+	git -C sub rev-parse HEAD >expect &&
+
+	# adding submodule without cloning
+	echo "[submodule \"sub\"]" >super/.gitmodules &&
+	echo "path = sub" >>super/.gitmodules &&
+	echo "url = ../sub" >>super/.gitmodules &&
+	git -C super update-index --add --cacheinfo 160000 $(cat expect) sub &&
+	mkdir super/sub &&
+
+	git -C super submodule status >out &&
+	sed -e "s/^-//" -e "s/ sub.*$//" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'recursive fetch with uninit submodule' '
+	# depends on previous test for setup
+
+	fetch_with_recusion_abort super sub &&
+	git -C super submodule status >out &&
+	sed -e "s/^-//" -e "s/ sub$//" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'recursive fetch after deinit a submodule' '
+	# depends on previous test for setup
+
+	git -C super submodule update --init sub &&
+	git -C super submodule deinit -f sub &&
+
+	fetch_with_recusion_abort super sub &&
+	git -C super submodule status >out &&
+	sed -e "s/^-//" -e "s/ sub$//" out >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.6.2

