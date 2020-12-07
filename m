Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EA5C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 13:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC1C42343F
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 13:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgLGNsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:48:07 -0500
Received: from mail-eopbgr140100.outbound.protection.outlook.com ([40.107.14.100]:39947
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbgLGNsG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 08:48:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIq+d+dFLLz5GTzaiePskBbjsumls6dUVnLcTiFzCY2LeAOFXITK51WgkRr+en+Kc1h6xL5Wln89vLtgbvZvNlEGAs5cy7jLX5ZfLVXSASSmbdRG57l6rycsspPpao5TCAKnZg5x6sxSaGO69aKge6jdj7KiU8pLuUskpZKIX9ua2Vr7ggBc5aH9RZFu/yV5ZUMvBWUDahVaF9ZkTjd7B8cNeFHhk49d+exFRPNntN8iXCHI55SfaYuUt12bS3f4G0H7nUMGeC09LtMeMNMx1OjDDRo5pot6JX6nTvXWCMu5bI6SD9H7HtHY9c/h9JpiaEnR468K1ZWFelN4RF3gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txWpKRT1zdZpu+2YBPjOw6sj1M0ko+haQFRGhH8euzI=;
 b=j5OWifFeuqZ3tg0Nt0pjEqp9rjiBtXUz5wAmdmfROp1Q4jv/r5fM542LJLdtEgBUm4DjwxyG6Atc8iHtaLWqBSbZpzzXEtpn6UMG78TVOz5XoyRKYaWy4Y76FNrDhQmEKfB7yaDOcR3nUYOsiDQOz+UJ7MCUfpJwHlwYXCxx74y1yXRpl4JHLyE7jDvX5flybzKQMhc6i9V/Q+8aSSe6wQ71xR9NQRT64NeoQJx0u6RCzVPvcj18wBt2Q5gyjKNRJuUu0e2MXHdr5DHbbMu5Ug0OQ1NcSZVG4RnIJjFCRcXX/8I1RAK24JvhHsZL1sYdcY+3wyCHL/oCpS03Uqv05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.101) smtp.rcpttodomain=gmail.com smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txWpKRT1zdZpu+2YBPjOw6sj1M0ko+haQFRGhH8euzI=;
 b=Cah+urfMRGlIiuYoaLaIaSuEqYCHCAUcYLEt8Gi17elBUB+1i5tX+iUDR3v26/ayh/GJmftJG0HW9G5oxwiemd9i0/g5ZtSIAi636ZFYzENeom/D4rWDlchvohMnlJ9f9D7FVwBLgVyseypu2KIkM9t0hcpGs9teyTBrsIwJZZY=
Received: from AM6PR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::14) by VI1PR0701MB2848.eurprd07.prod.outlook.com
 (2603:10a6:800:81::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.9; Mon, 7 Dec
 2020 13:47:16 +0000
Received: from AM5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::b5) by AM6PR01CA0037.outlook.office365.com
 (2603:10a6:20b:e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 13:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.101) smtp.mailfrom=nokia.com; gmail.com; dkim=none (message not
 signed) header.d=none;gmail.com; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.101 as permitted sender)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM5EUR03FT053.mail.protection.outlook.com (10.152.16.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 13:47:16 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 0B7DlDOd014148;
        Mon, 7 Dec 2020 13:47:13 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.us>
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] submodules: fix of regression on fetching of non-init subsub-repo
Date:   Mon,  7 Dec 2020 14:46:59 +0100
Message-Id: <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 10608f75-2d1f-4eba-e859-08d89ab69c18
X-MS-TrafficTypeDiagnostic: VI1PR0701MB2848:
X-Microsoft-Antispam-PRVS: <VI1PR0701MB284810F2FF7DD1FC6FB26770EECE0@VI1PR0701MB2848.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuEeQ+Zlzb31dPk1QU6JICgItVAF8Rq1Mr61gkiykYYWiG4e7mZOhXezi5Ue5ybna9TYyIbRdbxvdm/gkbwYQ/lhnTobgq1nSOlQcGIP2uBypPQkbx9jTryYoRzjZNR9v2nytxS8Zl5aH5E6Xn7OpaXcbajoAIWcUUPFkETcT9eX020u3WocoQ8CsFCaw55fiQ9aqC0FCNVkq1JJ+Rw1L9PJpIOB9YPe0vtWdwtOyzNrJ0q55N9n4/JNFhnlmnSOWrVDyvB1BPHdsH1224SUA9CmxvBkm0R3dvm/kLg2AuUZHSbgL1j+1/u+i6KfM20KsXI/+m1x71kikbwCvqo1UNyDgZHKClHRgBUdF6tglX4x2k4Zeys5c5Q6jFujY3uVRfzLeu9BTdd9Z4Z83L/TQQ==
X-Forefront-Antispam-Report: CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966005)(36756003)(82310400003)(26005)(44832011)(8676002)(2616005)(70206006)(4001150100001)(54906003)(5660300002)(81166007)(86362001)(83380400001)(8936002)(2906002)(478600001)(47076004)(70586007)(6666004)(110136005)(316002)(336012)(36906005)(4326008)(186003)(356005)(82740400003);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 13:47:16.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10608f75-2d1f-4eba-e859-08d89ab69c18
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB2848
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A regression has been introduced by a62387b (submodule.c: fetch in
submodules git directory instead of in worktree, 2018-11-28).

The scenario in which it triggers is when one has a remote repository
with a subrepository inside a subrepository like this:
superproject/middle_repo/inner_repo

Person A and B have both a clone of it, while Person B is not working
with the inner_repo and thus does not have it initialized in his working
copy.

Now person A introduces a change to the inner_repo and propagates it
through the middle_repo and the superproject.

Once person A pushed the changes and person B wants to fetch them using
"git fetch" on superproject level, B's git call will return with error
saying:

Could not access submodule 'inner_repo'
Errors during submodule fetch:
         middle_repo

Expectation is that in this case the inner submodule will be recognized
as uninitialized subrepository and skipped by the git fetch command.

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

Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
CC: Junio C Hamano <gitster@pobox.com>
CC: Philippe Blain <levraiphilippeblain@gmail.com>
CC: Ralf Thielow <ralf.thielow@gmail.com>
CC: Eric Sunshine <sunshine@sunshineco.com>
---
 submodule.c                 |   7 ++-
 t/t5526-fetch-submodules.sh | 104 ++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 1 deletion(-)

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
index dd8e423d25..666dd1e2b7 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -719,4 +719,108 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
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
+	compare_refs_in_dir A origin/master B origin/master
+'
+
+
+test_expect_success 'setup recursive fetch with uninit submodule' '
+	# does not depend on any previous test setups
+
+	git init main &&
+	git init sub &&
+
+	>sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+	git -C sub rev-parse HEAD >expect &&
+
+	git -C main submodule add ../sub &&
+	git -C main submodule init &&
+	git -C main submodule update --checkout &&
+	git -C main submodule status >out &&
+	sed -e "s/^ //" -e "s/ sub .*$//" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'recursive fetch with uninit submodule' '
+	# depends on previous test for setup
+
+	git -C main submodule deinit -f sub &&
+
+	# In a regression the following git call will run into infinite recursion.
+	# To handle that, we connect the grep command to the git call by a pipe
+	# so that grep can kill the infinite recusion when detected.
+	# The recursion creates git output like:
+	# Fetching submodule sub
+	# Fetching submodule sub/sub              <-- [1]
+	# Fetching submodule sub/sub/sub
+	# ...
+	# [1] grep will trigger here and kill git by exiting and closing its stdin
+
+	! git -C main fetch --recurse-submodules 2>&1 |
+		grep -v -m1 "Fetching submodule sub$" &&
+	git -C main submodule status >out &&
+	sed -e "s/^-//" -e "s/ sub$//" out >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.29.2

