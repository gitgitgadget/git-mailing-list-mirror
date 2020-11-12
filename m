Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC1C56201
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0696C221E9
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 16:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="QKGAZZhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgKLQBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:01:11 -0500
Received: from mail-eopbgr130109.outbound.protection.outlook.com ([40.107.13.109]:17542
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728836AbgKLQBC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 11:01:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THHGU1+4D/+Yoe37iYF0fEFHSW2RfnHmlw15yE/bhxHg+VEml+YpotlTQ1EFYZ1vTHBdqnA16V2I0xxmMUlTwSRyrKpYSSNAUj0B8gJCPchu/kJZW7U/Oq3w4ZZB9YRryZ7oX58NiHXWvBXqZqUezxEmCuKihWrMzdZbXengLcgr1oOAQ0oyNc9fJoMo9L8li1zb8IqMM3mAt447hEpXKFM3Y/cPivFps36+nDI626da9AmJQLaFIxEkTQre3zgb+NC6N93R8ft/8ZWfiFytZLT3FD8G8LC2djoRtM79hP3yakDlHtnMFizVxlvtuBESllKLg1vt4K5tZqIUssSzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vITP0iostx4LizsdW8IBpL5q4GPr+DOfwPw53J+nru4=;
 b=YCpGxwrtVViqPodSKk1erM/IJSKvJt4LE9VpZQOd8o8ExaZIO2Q/TQfwPTg1gg8guP3FRehCOpgaPACmeToCbto1Hu5euexYpQ57PFFnE8zK2kRlBpHVxQFCw8PR5Dhe9zEV0KItgbR0VZuFDGdpXVWLQYviK5tN2gldrAy10qZlJYhQ5/ALGplAG/zVR5NgGCH2AzfTdZqHe4RBa6GCem6seAMjVA/Ok+gIRWHWkjvGAt+zWJiLWdziBNAhlZ0lMh9OLUbqEnF4kmmNNL/NsX8Hut0cyM5JL7QVq3c0T3lBs2SWkvkGhXaupDnFGA52BfO6FTDh5zbAp21T70w0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 131.228.6.100) smtp.rcpttodomain=iee.email smtp.mailfrom=nokia.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vITP0iostx4LizsdW8IBpL5q4GPr+DOfwPw53J+nru4=;
 b=QKGAZZhcT8uzQgEPhslDx/uT7p336Gp0l7rJtTBFKvvGQmpUZQ738u2x+oY6l7xwIm0hD2pgHHLTH+X8iRG9Ale9zwNnEaAHiIkg2JL05ieTqPKJF4APM57eIaI6wheth2aAw9v3yw4FjF7TUWdq6GK1zOwsxtdBbCYrm3CrzBM=
Received: from DB6PR0301CA0080.eurprd03.prod.outlook.com (2603:10a6:6:30::27)
 by PA4PR07MB7200.eurprd07.prod.outlook.com (2603:10a6:102:f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13; Thu, 12 Nov
 2020 16:00:58 +0000
Received: from DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:30:cafe::d4) by DB6PR0301CA0080.outlook.office365.com
 (2603:10a6:6:30::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Thu, 12 Nov 2020 16:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 131.228.6.100) smtp.mailfrom=nokia.com; iee.email; dkim=none (message not
 signed) header.d=none;iee.email; dmarc=fail action=none
 header.from=nokia.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 nokia.com discourages use of 131.228.6.100 as permitted sender)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5EUR03FT024.mail.protection.outlook.com (10.152.20.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.22 via Frontend Transport; Thu, 12 Nov 2020 16:00:57 +0000
Received: from ulegcpbofur.emea.nsn-net.net (ulegcpbofur.emea.nsn-net.net [10.151.74.147])
        by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 0ACG0tCY014537;
        Thu, 12 Nov 2020 16:00:55 GMT
From:   Peter Kaestle <peter.kaestle@nokia.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, philipoakley@iee.email
Cc:     peter.kaestle@nokia.com
Subject: [RFCv2] submodules: fix of regression on fetching of non-init subsub-repo
Date:   Thu, 12 Nov 2020 17:00:53 +0100
Message-Id: <1605196853-37359-1-git-send-email-peter.kaestle@nokia.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <4339e01e-d312-69ee-c810-2fbc65606b0d@iee.email>
References: <4339e01e-d312-69ee-c810-2fbc65606b0d@iee.email>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7cb23ee8-02b8-48dc-7f2e-08d8872424db
X-MS-TrafficTypeDiagnostic: PA4PR07MB7200:
X-Microsoft-Antispam-PRVS: <PA4PR07MB7200596B5F2643E9C63AF8CFEEE70@PA4PR07MB7200.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:283;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHivWHjg09w7c2aZU82vzpF5XN588Wwwx+wmaAsVuNYn2mSPP4vN8lGrDypD0+jS0gi8ISXC44lJT1JPFxIseDwLRq589qEo6QvVcUbz9cWRLuDxnT7pDaL7OULgqyzWnjHkyc5IA4OeVb9d0icDK9qBPuVbC0pm1vOtle23z9P41M61r2Ir0eumFBMH9Fn91bhDPtu9VB3oFiCHe8rByckzKLsRjTyUO/99EVcC2FFXvWvvSlnQms3t0oZraCB9kFh0fQeqOUVSCiix0dcBK23ulZZ3UnDKWPZsswiJF1clmeZxZZY7KKq4jA0lUO1QTwl5al85g9FbIAnE1WDhbNKwd0OOAZFVzPb84+pf/zZqVKghW/Hlx1rHj70RtWx21ou/17B3cZXiQi/VInH6Ow==
X-Forefront-Antispam-Report: CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966005)(47076004)(82740400003)(5660300002)(83380400001)(478600001)(82310400003)(4326008)(81166007)(356005)(336012)(26005)(36756003)(186003)(107886003)(8936002)(44832011)(316002)(110136005)(2906002)(8676002)(70586007)(86362001)(70206006)(2616005)(4001150100001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 16:00:57.8872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb23ee8-02b8-48dc-7f2e-08d8872424db
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A regression has been introduced by 'a62387b (submodule.c: fetch in
submodules git directory instead of in worktree, 2018-11-28)'.

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

This patch reverts the changes of a62387b and introduces a regression
test.

Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
---
 submodule.c                 | 14 +++-------
 t/t5526-fetch-submodules.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index b3bb59f..eef5204e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -499,12 +499,6 @@ void prepare_submodule_repo_env(struct strvec *out)
 		     DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
-static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
-{
-	prepare_submodule_repo_env_no_git_dir(out);
-	strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
-}
-
 /*
  * Initialize a repository struct for a submodule based on the provided 'path'.
  *
@@ -1455,8 +1449,8 @@ static int get_next_submodule(struct child_process *cp,
 		if (task->repo) {
 			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
-			cp->dir = task->repo->gitdir;
-			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+			cp->dir = task->repo->worktree;
+			prepare_submodule_repo_env(&cp->env_array);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
@@ -1505,9 +1499,9 @@ static int get_next_submodule(struct child_process *cp,
 			    spf->prefix, task->sub->path);
 
 		child_process_init(cp);
-		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		prepare_submodule_repo_env(&cp->env_array);
 		cp->git_cmd = 1;
-		cp->dir = task->repo->gitdir;
+		cp->dir = task->repo->worktree;
 
 		strvec_init(&cp->args);
 		strvec_pushv(&cp->args, spf->args.v);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index dd8e423..a7f6f9f 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -719,4 +719,67 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
 	)
 '
 
+add_commit_push () {
+	dir="$1"
+	msg="$2"
+	shift 2
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
+		(
+			git init --bare $repo &&
+			git clone $repo ${repo}_content &&
+			echo "$repo" >"${repo}_content/file" &&
+			add_commit_push ${repo}_content "initial" file
+		) || return 1
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
+	test -f B/file &&
+	test -f B/middle/file &&
+	! test -f B/middle/inner/file &&
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
 test_done
-- 
2.6.2

