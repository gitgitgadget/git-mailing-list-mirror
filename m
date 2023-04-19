Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB753C6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 20:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjDSU16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 16:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjDSU1z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 16:27:55 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6745559D1
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 13:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1JY87GTrtWT7a8DL/4LtWjY8AjNSNePeCe3UmUCF0O1q+Gc2hsly46+AKgndE78W+WE/1T9yjA/MueK+f/v98akOXwBJIR1YPehYu/nm7epk3Ku0fzWhC8rYSKtasFiVhJ9blFuf4rtRV8Kq+opjFK1h+onss8Vqbf35wRd89RfHy7qKI3on5MWrY/+bAlybpo6EbOD1sI/QNLbGHYF1JFmIfT2sSHVUGWq6LspottN6IENQl2AqpD20S4OUCSELamT59IBJ7+h1mLYrvX7jijZrnQL+UXGSsc3WyNKLqy2nhcK/5UYenkPWTne+aKrfyG5zlB5yPHu7e8y0Sozag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtQhZwi4ZUeKKLCXPY/HEGEa9T00obtZ5fXNncAy1AU=;
 b=hNcjkcVNCbjXlLplfiFQOy8wgz5ay6p+/xc5wB4iGXhoqxn8e+Bs7A0sEEyhp6N+XBY74hMWND/QNerhsosDynW6oNDOG7ghIpF66fDj05gcoX44y7z/PKvgvygXLmZa236/9H9cR4gpurYkT2G9Ey7XuiNvny68JgP6ZokkToN9hOdhkKTgcOhGeNq6T0+zNsrD97uD+z91qd/dIbaeQ3hScm6ouemMUeqrYlRtLqhhkKGnGzstyrAY/bWDZViWUIDG8zWRw9BxmXSNG2TmEdP4/FNLqnii+3DvvNwU89TEX+9cg/PtjxsNIUySq8Kn/4yIZfhAhXkNowRKN6N2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtQhZwi4ZUeKKLCXPY/HEGEa9T00obtZ5fXNncAy1AU=;
 b=LhIG/ej3WSfnACVozyZ2R6zhCQt8OLH3QaHw9Dyq9BYad3XWmkCDHWNyoaHXf5AoBSzrxaENLYnLLj1wYe3/YVfsIEBSvpsbvDUJyv9wnlbOVjP/RAew1YPdPj6B7wEr57GUQljps8N+m2GBGR6oR88Gvc9tcxFb0IH7BtRnxf0=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 20:27:48 +0000
Received: from CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::8b) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 20:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT089.mail.protection.outlook.com (10.13.175.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 20:27:42 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 15:27:40 -0500
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     <git@vger.kernel.org>
CC:     <michael.strawbridge@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 2/2] send-email: expose header information to git-send-email's sendemail-validate hook
Date:   Wed, 19 Apr 2023 16:27:03 -0400
Message-ID: <20230419202703.2911836-3-michael.strawbridge@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419202703.2911836-1-michael.strawbridge@amd.com>
References: <20230419202703.2911836-1-michael.strawbridge@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT089:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbef714-0e50-468e-edf5-08db411486f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17AqjjdWqbj2YV1187RbdQtH+nBfU/7ozx0cccUGl1qsjNlydBRBbLF+RGxYWbLdN+/UMW2UoKqcd9hKJXna2GFVZrwuJ4XtV0O0fIrCkywzH1oIjSLa200Wq36YvAKR0oWS4y55rRri+Z2XwDg3ccSc22SsnRslIBTeLYk2mFC/tKimrG1PhFNdjtVnNlvhBKJ+oTd98K8dAD0tiRVZDpkvoMSLIlX/d/XD2WFGCX57QlY0CgqIfDZ5pwG3Tja1k/GznF9KMqN5xxEA1zyfVRy4RFdilYxpcS3s7o4gah2uHf5cb7DhEHt7IctCItu1ffzC0wypdaMyXg7jCkXQUmY3psQ+z9UstMli+a1/poczVXbBUstYhDK4NRmS055YZ/S/FdyB54jMzFxGSM67+y/ptikYVhA8+QMPeBfjeIFzA91Zn7RAbx3zJLdw2c7Ss5ipq6aTzOnIZfG6EWEWjFj4+B1+5ie064bDJMeA+Vbliy5CRbsgicDvqeQHtVuOWU/fM0VWyDq/i5KVOBQeuXHP9V55IVqOujb0y94XlOQjCNmlSA32x6Rpen7PSBMZckjNo3B5b26w3bcYJX5tlTDDVfXDxgPMavwQA0pnT8mqnTEvw/XUV+vexPftF8yGu5Uc5Tln5TXEJ3s3kCD7JbHvXXZozF25OfmkKJAdY3G3WiHAEVKRrwB1xTpPeUrdK1dK9RMu4o0cLhxP6oR7OssAHiF/d1E0Bqltw2h1HQc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(8936002)(8676002)(316002)(82740400003)(41300700001)(6916009)(4326008)(70586007)(70206006)(40480700001)(54906003)(81166007)(356005)(186003)(40460700003)(15650500001)(2906002)(16526019)(36756003)(26005)(83380400001)(1076003)(426003)(86362001)(336012)(47076005)(82310400005)(66574015)(36860700001)(5660300002)(2616005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 20:27:42.1132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbef714-0e50-468e-edf5-08db411486f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To allow further flexibility in the Git hook, the SMTP header
information of the email which git-send-email intends to send, is now
passed as the 2nd argument to the sendemail-validate hook.

As an example, this can be useful for acting upon keywords in the
subject or specific email addresses.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 Documentation/githooks.txt | 27 +++++++++++++++++----
 git-send-email.perl        | 48 +++++++++++++++++++++++---------------
 t/t9001-send-email.sh      | 27 +++++++++++++++++++--
 3 files changed, 77 insertions(+), 25 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 62908602e7..9896ffafaf 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -595,10 +595,29 @@ processed by rebase.
 sendemail-validate
 ~~~~~~~~~~~~~~~~~~
 
-This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
-the name of the file that holds the e-mail to be sent.  Exiting with a
-non-zero status causes `git send-email` to abort before sending any
-e-mails.
+This hook is invoked by linkgit:git-send-email[1].
+
+It takes these command line arguments. They are,
+1. the name of the file which holds the contents of the email to be sent.
+2. The name of the file which holds the SMTP headers of the email.
+
+The SMTP headers are passed in the exact same way as they are passed to the
+user's Mail Transport Agent (MTA). In effect, the email given to the user's
+MTA, is the contents of $2 followed by the contents of $1.
+
+An example of a few common headers is shown below. Take notice of the
+capitalization and multi-line tab structure.
+
+  From: Example <from@example.com>
+  To: to@example.com
+  Cc: cc@example.com,
+	  A <author@example.com>,
+	  One <one@example.com>,
+	  two@example.com
+  Subject: PATCH-STRING
+
+Exiting with a non-zero status causes `git send-email` to abort
+before sending any e-mails.
 
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 0a44c0e5cb..a3bc7b33d4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -792,16 +792,31 @@ sub is_format_patch_arg {
 				    @rev_list_opts);
 }
 
-@files = handle_backup_files(@files);
+if (defined $sender) {
+	$sender =~ s/^\s+|\s+$//g;
+	($sender) = expand_aliases($sender);
+} else {
+	$sender = $repoauthor->() || $repocommitter->() || '';
+}
+
+# $sender could be an already sanitized address
+# (e.g. sendemail.from could be manually sanitized by user).
+# But it's a no-op to run sanitize_address on an already sanitized address.
+$sender = sanitize_address($sender);
+
+$time = time - scalar $#files;
 
 if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
+		        pre_process_file($f, 1);
 			validate_patch($f, $target_xfer_encoding);
 		}
 	}
 }
 
+@files = handle_backup_files(@files);
+
 if (@files) {
 	unless ($quiet) {
 		print $_,"\n" for (@files);
@@ -1050,18 +1065,6 @@ sub file_declares_8bit_cte {
 	}
 }
 
-if (defined $sender) {
-	$sender =~ s/^\s+|\s+$//g;
-	($sender) = expand_aliases($sender);
-} else {
-	$sender = $repoauthor->() || $repocommitter->() || '';
-}
-
-# $sender could be an already sanitized address
-# (e.g. sendemail.from could be manually sanitized by user).
-# But it's a no-op to run sanitize_address on an already sanitized address.
-$sender = sanitize_address($sender);
-
 my $to_whom = __("To whom should the emails be sent (if anyone)?");
 my $prompting = 0;
 if (!@initial_to && !defined $to_cmd) {
@@ -1221,10 +1224,6 @@ sub make_message_id {
 	#print "new message id = $message_id\n"; # Was useful for debugging
 }
 
-
-
-$time = time - scalar $#files;
-
 sub unquote_rfc2047 {
 	local ($_) = @_;
 	my $charset;
@@ -2108,10 +2107,21 @@ sub validate_patch {
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
+
+			my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
+
+			require File::Temp;
+			my ($header_filehandle, $header_filename) = File::Temp::tempfile(
+                            TEMPLATE => ".gitsendemail.header.XXXXXX",
+                            DIR => $repo->repo_path(),
+                            UNLINK => 1,
+                        );
+			print $header_filehandle $header;
+
 			my @cmd = ("git", "hook", "run", "--ignore-missing",
 				    $hook_name, "--");
-			my @cmd_msg = (@cmd, "<patch>");
-			my @cmd_run = (@cmd, $target);
+			my @cmd_msg = (@cmd, "<patch>", "<header>");
+			my @cmd_run = (@cmd, $target, $header_filename);
 			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
 			chdir($cwd_save) or die("chdir: $!");
 		}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 323952a572..e8c96d0d4e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -540,7 +540,7 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
+	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch> <header>'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
@@ -559,12 +559,35 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 	test_path_is_file my-hooks.ran &&
 	cat >expect <<-EOF &&
 	fatal: longline.patch: rejected by sendemail-validate hook
-	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
+	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch> <header>'"'"' died with exit code 1
 	warning: no patches were sent
 	EOF
 	test_cmp expect actual
 '
 
+test_expect_success $PREREQ "--validate hook supports header argument" '
+	write_script my-hooks/sendemail-validate <<-\EOF &&
+	if test "$#" -ge 2
+	then
+		grep "X-test-header: v1.0" "$2"
+	else
+		echo "No header arg passed"
+		exit 1
+	fi
+	EOF
+	test_config core.hooksPath "my-hooks" &&
+	rm -fr outdir &&
+	git format-patch \
+		--add-header="X-test-header: v1.0" \
+		-n HEAD^1 -o outdir &&
+	git send-email \
+		--dry-run \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--validate \
+		outdir/000?-*.patch
+'
+
 for enc in 7bit 8bit quoted-printable base64
 do
 	test_expect_success $PREREQ "--transfer-encoding=$enc produces correct header" '
-- 
2.34.1

