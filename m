Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F763C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjARQft (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjARQfa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:35:30 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A753F2CFF8
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:34:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGaGHce681AZiVp9UASJtJ+Uv7HdglOOXNWc6qvvBVwphb6SLLCjQ2gOOy1RG8kafa7qvcCzFjw6U83doNKEuVVoq7Bb7Gdx7x0FOSJ68YVsQUTwAkXGApAolHz4VALcgwPGRgoffyuWPz2/Rny5/4RACXYiWSUoBJL6DGh06LgMpNJsGqYknEMxTIGTk4B644eNlSlfuj7P4ifG831cfMrKB/cv+lwNtfrpirM6iw3nfLT89Xgbg2bsw81r4tnqMX5OWEMI2zpZgLuBYotS5vOg7ixlvdUBqBBmcHQHuRVFyr7ZWjVq3vGY4M5q33egDqAf5VMq7UoV+VCN3AJcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8UDajuwIQTjqtoPcmtd5X5lqg4ccuZQq9TvHpYCgrc=;
 b=bN4x1pZTcC0bdirNO0d7VOVToEVyS05TUJwmgpMsq8T/pLSPZd8HYN8sVUzjT2ssGAzSb/+JB7pwvMSbg9FuMC4H0OnMcaWBQoI29q4WyxyaakQ/ZFHyYEJZR75Ay7EYxexal3Mb+acwC8i0DXEAwkhxTM01Dp6b57/zbhe/kDRhmbYqTLcmXcHHESWZlZhi+y3sgb0KzwDNLEDwQsfHqVZ7UUXu1nlBViPjP67aHmbUDaQiq6+UWoRCBKEn9m7ICpB2051+xBDaQeXbUAEeeHuFMR3CGwGCftsbl70e8baum+Dfx7yWKrladcFUXwUj7FVk5Q370Jv+jF421HEBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8UDajuwIQTjqtoPcmtd5X5lqg4ccuZQq9TvHpYCgrc=;
 b=wZd0XoFQ44q3ANvx0vQMEQSdWzFNoV0f077hcJcvnHgRzrig6zWL1byRYJdngjKnQWlIlKivvBOnTvvv4ue3luNZ7JczooTE4acuT/fieFZRtI8xITvwmqaVM/eFKWMZQmNAyfmRbuynAzOX3MO5gOzxxPQw8LVroNg6MJSyApA=
Received: from MN2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:208:178::39)
 by SA0PR12MB4543.namprd12.prod.outlook.com (2603:10b6:806:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 16:34:05 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::6f) by MN2PR19CA0026.outlook.office365.com
 (2603:10b6:208:178::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 16:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 16:34:05 +0000
Received: from mstrawbr-Standard-PC-Q35-ICH9-2009.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 10:34:04 -0600
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     <git@vger.kernel.org>
CC:     <michael.strawbridge@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 2/2] send-email: expose header information to git-send-email's sendemail-validate hook
Date:   Wed, 18 Jan 2023 11:32:03 -0500
Message-ID: <20230118163203.488652-3-michael.strawbridge@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118163203.488652-1-michael.strawbridge@amd.com>
References: <20230118163203.488652-1-michael.strawbridge@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|SA0PR12MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: c094b530-3fe3-4bd8-7af5-08daf971d0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgkC3beSt1qVPMbRZPMGtsl+EI/HF7DrqRavPh+6k1BX0/eV2muklQ3EkDdZU1wBra92GzznS7KNZR8uApD/SMGRJatTFEM3atfu+peRZWya8eoo9S13FLdYO4kWJ4TGwl/NhT9Xx0RWZbLSNXkEflOIonrKIKSB+U7LX5KNbt5eypVwYQT00rgV6SP/Im9AUDXXwpLqe3D/kotlV98WWpQd2FdLzsjKdSo4yFxQU/u6R7hK/aPNmJlyiiyb606vDIrhvFfWdXStHL4451o03BAFo/sZmciw9IbmNYPsGTJ2rWWaExvZ/HPib9XJHzlFJOkrgVDzweKJs5yAA1QVnYAH6ubis+CRAqD+rHTXhgXp4PTc5wLNQkRDdE8yFDDMcV35uolrNyRIzmvV4oOshT+xEiUZxacHNzGyYdemkz+OtXpTJmJa6AtecgXBPYH+LgLo/X8tyPAyqNwG1sedvlre6AyQ5xiPFG9gYWqJYMPIYCSuvhuTzeXm/B7LxiZET2jasAwmSCbrnWQHbeTLcRmpK7t8cSijXwIYbHGv6/Sp5FeH568PWeYEsJCTFMGltl9X1TtAai+bQy7RfYI3tpn34JmG39JqHQ4/LXJz1Plh7mZWuq/CekyYImVlFQnZJIaPCM/wvL5JRsn4znJkc+tXfb7n41cmw34CFOS6wDFigxEHz4Qh8WbZHX+Z06k3XVNGIiA2aSl3oQlXJu2hTO2hWc+TDdO7N4q0cOFE+NY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(81166007)(82740400003)(36860700001)(356005)(86362001)(8936002)(5660300002)(15650500001)(70586007)(44832011)(70206006)(2906002)(40480700001)(4326008)(8676002)(41300700001)(6916009)(82310400005)(2616005)(40460700003)(186003)(26005)(16526019)(336012)(83380400001)(1076003)(66574015)(47076005)(426003)(316002)(54906003)(7696005)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 16:34:05.3255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c094b530-3fe3-4bd8-7af5-08daf971d0b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4543
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To allow further flexibility in the Git hook, the SMTP header
information of the email which git-send-email intends to send, is now
passed as the 2nd argument to the sendemail-validate hook.

As an example, this can be useful for acting upon keywords in the
subject or specific email addresses.

As a consequence of needing all the header data, validation has been
moved later in the sequence to right before sending the emails instead
of at the beginning.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 Documentation/githooks.txt | 27 ++++++++++++++---
 git-send-email.perl        | 60 ++++++++++++++++++++++----------------
 t/t9001-send-email.sh      | 27 +++++++++++++++--
 3 files changed, 83 insertions(+), 31 deletions(-)

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
index 42f135a266..d123dfd33d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -787,14 +787,6 @@ sub is_format_patch_arg {
 
 @files = handle_backup_files(@files);
 
-if ($validate) {
-	foreach my $f (@files) {
-		unless (-p $f) {
-			validate_patch($f, $target_xfer_encoding);
-		}
-	}
-}
-
 if (@files) {
 	unless ($quiet) {
 		print $_,"\n" for (@files);
@@ -1124,6 +1116,30 @@ sub expand_one_alias {
 our ($message_id, %mail, $subject, $in_reply_to, $references, $message,
 	$needs_confirm, $message_num, $ask_default);
 
+my ($message_id_stamp, $message_id_serial);
+
+$time = time - scalar $#files;
+
+if ($validate) {
+	foreach my $f (@files) {
+		unless (-p $f) {
+		        pre_process_file($f, 1);
+
+			validate_patch($f, $target_xfer_encoding);
+		}
+	}
+}
+
+$in_reply_to = $initial_in_reply_to;
+$references = $initial_in_reply_to || '';
+$message_num = 0;
+
+foreach my $t (@files) {
+	while (!process_file($t)) {
+		# user edited the file
+	}
+}
+
 sub extract_valid_address {
 	my $address = shift;
 	my $local_part_regexp = qr/[^<>"\s@]+/;
@@ -1189,7 +1205,6 @@ sub validate_address_list {
 
 # We'll setup a template for the message id, using the "from" address:
 
-my ($message_id_stamp, $message_id_serial);
 sub make_message_id {
 	my $uniq;
 	if (!defined $message_id_stamp) {
@@ -1214,10 +1229,6 @@ sub make_message_id {
 	#print "new message id = $message_id\n"; # Was useful for debugging
 }
 
-
-
-$time = time - scalar $#files;
-
 sub unquote_rfc2047 {
 	local ($_) = @_;
 	my $charset;
@@ -1738,10 +1749,6 @@ sub send_message {
 	return 1;
 }
 
-$in_reply_to = $initial_in_reply_to;
-$references = $initial_in_reply_to || '';
-$message_num = 0;
-
 sub pre_process_file {
 	my ($t, $quiet) = @_;
 
@@ -2006,12 +2013,6 @@ sub process_file {
 	return 1;
 }
 
-foreach my $t (@files) {
-	while (!process_file($t)) {
-		# user edited the file
-	}
-}
-
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
@@ -2101,11 +2102,20 @@ sub validate_patch {
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

