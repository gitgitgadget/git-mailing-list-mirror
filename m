Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC788C678DD
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 01:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjATBZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 20:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjATBZf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 20:25:35 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC31A2959
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 17:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lB7PSf5lt9x0gWoXVFaYRNp8jEmk8xm/Ploa0CSjNhKG83dWcb5+NC4i8PPRwoGbQpCf+PkBFeMT52TsJq+NN67fBx4yc0PnQRsa3qUCWknk10TBHekbxY/soJTgnXVBjOONO7XHHea0qZpJ0gOedhBEAU4ueqCBJLmlOjyZPYtNmLJwKYkwyglXZ/WKwubL+TxOvZFeG67phGusPAYziwf9xXC3+9Jqklz4JBQSBIy6z/+TVYzfepAQWc9ko6i0as8c7pP6js8xQf5cSnyOrld3AlAyrttdD4oOmvVMwFExgED+mjS4o/thxBWQzbfY5DC/PdrRDB/vkq51TnCnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ehc82fZiAQ2M8zFztlpIjUxe8WJ7dT0W3bH6zQ5jAvY=;
 b=SImC3y8nJ+P2j2PapoyQnHgv9mNfsUzebdCl1UTPAxbzwG2KmexR1orDlQYQRV6WV3u1i7Qa/epoMHquNcd99fpXB7Hh372xlqUXDANLZNCnK9ai+rovC7EXEJkSDtdzWZ593n085eoj7aSR/n/AXUV48iFdxlqpVQYE+/kbGjiW2Uu8BllW7b3CtN73Ii5058r0/7tRn1MNvagiZLYYOX/j/pBr7GTfX4zsExz/FYznpgn3ZDgwRFhdv4aZUaySANCP8ian/F92xccTE0g8C8wek7NcmxqDRJmAXftXrG4+NlkDzpwzYXyky9cIDL3THU3PcOD5ly5V506Mo+oQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ehc82fZiAQ2M8zFztlpIjUxe8WJ7dT0W3bH6zQ5jAvY=;
 b=NGVt91MJ16CC0pa7/8u5CHB+PWeouQKsAi/uV0mJmeMOcyKejlidbiyI8h1hQGqyMagKwAiyItyUJ/0dKiI4WluIakc9els5W/tsY+kAR136JZvoCRiSuimd4gLKrz1T+S2zP9eJSHxgPXdMkCa1qEK8bJpJKTbVEB0KX4VyvfE=
Received: from DS7PR05CA0036.namprd05.prod.outlook.com (2603:10b6:8:2f::25) by
 SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.25; Fri, 20 Jan 2023 01:25:32 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::e2) by DS7PR05CA0036.outlook.office365.com
 (2603:10b6:8:2f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.16 via Frontend
 Transport; Fri, 20 Jan 2023 01:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 20 Jan 2023 01:25:32 +0000
Received: from mstrawbr-Standard-PC-Q35-ICH9-2009.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 19:25:20 -0600
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     <git@vger.kernel.org>
CC:     <michael.strawbridge@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 2/2] send-email: expose header information to git-send-email's sendemail-validate hook
Date:   Thu, 19 Jan 2023 20:24:59 -0500
Message-ID: <20230120012459.920932-3-michael.strawbridge@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120012459.920932-1-michael.strawbridge@amd.com>
References: <20230120012459.920932-1-michael.strawbridge@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: e83c8aab-2a34-4ddc-fedb-08dafa85392b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFldvuo5JO1RV8b5S9fqzvGAI+C9QqOolg1zwKUKi8EJo1xjQztLVlRYJwQvnc8nNbevWUPRmVXR40zx78O8chOYmAJ49aZi6dKkpSB6eZdnOCBIeQ6QtxyLY3LLjYHZnMu2Ry+tI9qLUHpS8uWehYyK/TBBOxHtpcTNuif//IckvIxnr8S0q696fC4h8Tfz/dxvszOrFcAWgTS+3Sakh861YiqCAA532oRe1xF063DAAM7QJm/adyynEiL7uDdViig0C6tSyp4LR9P4p8UQkFCgD6gTNmFrhzEWsknA6Xz72r0qozY1W0Qiv/AVjl6w3gAp7UwLch9QJHpUk8XECOikWP5f/gg61KDEXTmCPY3dWpgck9OTEbj4lhh76+2j0vIdK7R9aeolXreyOjIfmAeWblV21AXu9uECDbaYQvqya51i7dOiOCNtgcYB/43mJRr+29jwxvEbUN5XZoN/vsWPUl4wvH+dkCIC51T8PEtU1u//1J89aI4uuHtUssYbcR0U/GlIXtiqWcUfTwe/krCgiQfpdiQ6YfvOZq1Wp0plTOGTKz7+KRYbkeElVlIeFQnYyroab3p6ZF+L9aBL0phdimAzBDotIjRHP8TrJoXpgfflnBPcT2vy8Gy5cAKsRSLMhRKwEdpsHZwxH2u8loi9ydrxJu7Ft77QfagnkNfZTKRPHVYvfqHlR+dILhieFC6Xz6URkuOZQK7rySSCNJRrAGivqY3qeaqewvEjINk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(7696005)(316002)(40460700003)(86362001)(6666004)(36756003)(478600001)(2906002)(15650500001)(426003)(47076005)(66574015)(54906003)(336012)(44832011)(83380400001)(1076003)(2616005)(70206006)(8676002)(70586007)(6916009)(4326008)(36860700001)(81166007)(40480700001)(82740400003)(186003)(16526019)(356005)(26005)(82310400005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 01:25:32.2344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e83c8aab-2a34-4ddc-fedb-08dafa85392b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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
 Documentation/githooks.txt | 27 ++++++++++++++++++----
 git-send-email.perl        | 46 ++++++++++++++++++++++----------------
 t/t9001-send-email.sh      | 27 ++++++++++++++++++++--
 3 files changed, 75 insertions(+), 25 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c..0decbfc92d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -583,10 +583,29 @@ processed by rebase.
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
+Below is an example for a few common headers. Take notice of the
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
index 42f135a266..0e595d6ac5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -785,16 +785,31 @@ sub is_format_patch_arg {
 	push @files, $repo->command('format-patch', '-o', File::Temp::tempdir(CLEANUP => 1), @rev_list_opts);
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
@@ -1043,18 +1058,6 @@ sub file_declares_8bit_cte {
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
@@ -1214,10 +1217,6 @@ sub make_message_id {
 	#print "new message id = $message_id\n"; # Was useful for debugging
 }
 
-
-
-$time = time - scalar $#files;
-
 sub unquote_rfc2047 {
 	local ($_) = @_;
 	my $charset;
@@ -2101,11 +2100,20 @@ sub validate_patch {
 			chdir($repo->wc_path() or $repo->repo_path())
 				or die("chdir: $!");
 			local $ENV{"GIT_DIR"} = $repo->repo_path();
+
+			my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
+
+			require File::Temp;
+			my ($header_filehandle, $header_filename) = File::Temp::tempfile(
+                            ".gitsendemail.header.XXXXXX", DIR => $repo->repo_path());
+			print $header_filehandle $header;
+
 			my @cmd = ("git", "hook", "run", "--ignore-missing",
 				    $hook_name, "--");
-			my @cmd_msg = (@cmd, "<patch>");
-			my @cmd_run = (@cmd, $target);
+			my @cmd_msg = (@cmd, "<patch>", "<header>");
+			my @cmd_run = (@cmd, $target, $header_filename);
 			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
+			unlink($header_filehandle);
 			chdir($cwd_save) or die("chdir: $!");
 		}
 		if ($hook_error) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1130ef21b3..8a5c111a24 100755
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
+        if test "$#" -ge 2
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

