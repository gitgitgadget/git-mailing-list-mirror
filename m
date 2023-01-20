Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A3C38142
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 01:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjATBZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 20:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjATBZf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 20:25:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5607E5A839
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 17:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/7U8GoqVkwqAd7M2Cd1sItU9inBBxHQ+VSNNKvXATDG2O+35mmoRlB13wBz40CIxwxi3XQ2iR03lTR5a5tdUCllLCRmaZo/OHMo1jY1wtPrCKurbKCZGnHQbXEQ3J2BF5aEOJGpIf7d9BqUxgZPg4VCMJoYGIbn/ZEi2KKKeLwaeHUaUhXtxu/iyrxQasDePF2leVbgHcwz5f5Bs9HKCE9kunt7OgOj7+NAX08nOMTnfZZ5kS5ClclxSttNJhcdJutuQ9r1Yeg7niqz98Sb0cUbU+lniHiAQD4nMwmZqBNXsJ5zJjMpH5dnSme5CAy6zbNK5sQVfgu0n6dFF2A3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvtoFxJMQmtRp1yaeLMXWykTlWg7I5dCE9YqeZZ+g4M=;
 b=K5aKbaPCFiih5bwjIfMzc86YO7xPiQwhkjBnrc3QjVHSu+J2xLb9wA+TuPOJ3kO+NliAtktwZnsE+4SGt4gSjkcRnJ2gJEQag75YZEVPRqTmbJbtHdcaksPnub3yTzj5WfAguA5LrPrYiWItDKYeOisatj7jTl6y0SsRQH8Ww0UNHLxM3luIzk3zHpajwnFL+hr3jJenuH7hc+xaMSpZwfm8Z0dJa3qvTlEnXw+Kqei79rDfc1bNLMoPxmjzs4mY0WF2ATRgSVTJV+Hb+kGi60vofXssyxbV5e9wyNs1Yw/3n16W0ZyMdEwhFDBpan+AtFgfcNwkKHYxlJ88Ud6CjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvtoFxJMQmtRp1yaeLMXWykTlWg7I5dCE9YqeZZ+g4M=;
 b=CdbuYA0gHGJZmP/WUF4CutR8exb0RfwPBhvViTtfbCWp/iglqzwI7V9fK23wqw2BpHtfcbK2Wy6crL5AHRclRJ/vb1oEWb39+EVR+oUpSKgUDWDZGOtmdH5gfrzoXGGe1LuuyWNs7yqIVNm4RQNDgtZYdmbkrjJjMB7/30amr9E=
Received: from DM6PR11CA0044.namprd11.prod.outlook.com (2603:10b6:5:14c::21)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 01:25:32 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::49) by DM6PR11CA0044.outlook.office365.com
 (2603:10b6:5:14c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 01:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 01:25:32 +0000
Received: from mstrawbr-Standard-PC-Q35-ICH9-2009.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 19:25:18 -0600
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     <git@vger.kernel.org>
CC:     <michael.strawbridge@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 1/2] send-email: refactor header generation functions
Date:   Thu, 19 Jan 2023 20:24:58 -0500
Message-ID: <20230120012459.920932-2-michael.strawbridge@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|PH0PR12MB5404:EE_
X-MS-Office365-Filtering-Correlation-Id: 58eafb7b-ac68-464b-791e-08dafa853919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RZOKIKULNbgo3IPPjtFL9nfrC4vP1nwOAoZzgm4wDndoxUDMBp5p21YaJIOWOQ2QZ8rbqGKaFpMGjpNtsPm7qNkJ1td7Oepa8erw1TF8RS+pAjYtwqWHkHbDWLwNnAGLsTxEMWXKkG1xTk0FoM/MUkDBt8XIumNWr6uKgUlxrgiXtXpG+zDds0UpMzMk9HOxus6q67EwbsZjLzqd5Hb0N+tPa/jMlNzzNLgE5UKi8Z7Se7C/a16J0CzJEDcTAnhw8EaKE15/gm6W4gqK1Sb9Gv6mXwoBmbkfl+7anpxq0FbHiRM9WCfHozPDEX2Cdpjae89Ogx0zB5E5uCa6ftAMRbsoViEtm77A6g4j3/MZdJV6EDkgKAJZMw2C3ceC3uTSlq243yEvqan8vWkwTfA1E5LlQXBJH+DSdPLHym8+hgg9kCNvwS6gzhIRKSgelC6fnhtj9+sYqno7LHYTsfKaOtIx+JoUobvILvwYmOiocZC2KvBy7LYKtrav4rPsLA8iSNfTkrICBiesJoACAr+rlko+nsslew+duLNIj6vQjeco/ZpRl9zgaIplLat3TANNgwsnhkqxr/wi/BpgtfvZHYwwx65re9mLxsgiHORFVkf95GO4DlNSb1xE2s0mUMXhCp1p0vgqJ3Ka1kVQtVDNwe8KYVdTZwHyk5PtBM3UDDhdGL4Y2Z37wE3fLWtZFrmgarKk6LpzifWwkzKWMlqICuxYNktVD6mC05v+v0Lumg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(6666004)(16526019)(186003)(81166007)(478600001)(82740400003)(26005)(7696005)(82310400005)(86362001)(356005)(41300700001)(36860700001)(2906002)(83380400001)(2616005)(8936002)(44832011)(54906003)(40480700001)(1076003)(316002)(5660300002)(8676002)(70586007)(47076005)(6916009)(70206006)(336012)(66574015)(40460700003)(426003)(36756003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 01:25:32.1130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58eafb7b-ac68-464b-791e-08dafa853919
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split process_file and send_message into easier to use functions.
Making SMTP header information widely available.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 git-send-email.perl | 49 ++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..42f135a266 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1495,16 +1495,7 @@ sub file_name_is_absolute {
 	return File::Spec::Functions::file_name_is_absolute($path);
 }
 
-# Prepares the email, then asks the user what to do.
-#
-# If the user chooses to send the email, it's sent and 1 is returned.
-# If the user chooses not to send the email, 0 is returned.
-# If the user decides they want to make further edits, -1 is returned and the
-# caller is expected to call send_message again after the edits are performed.
-#
-# If an error occurs sending the email, this just dies.
-
-sub send_message {
+sub gen_header {
 	my @recipients = unique_email_list(@to);
 	@cc = (grep { my $cc = extract_valid_address_or_die($_);
 		      not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
@@ -1546,6 +1537,22 @@ sub send_message {
 	if (@xh) {
 		$header .= join("\n", @xh) . "\n";
 	}
+	my $recipients_ref = \@recipients;
+	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header);
+}
+
+# Prepares the email, then asks the user what to do.
+#
+# If the user chooses to send the email, it's sent and 1 is returned.
+# If the user chooses not to send the email, 0 is returned.
+# If the user decides they want to make further edits, -1 is returned and the
+# caller is expected to call send_message again after the edits are performed.
+#
+# If an error occurs sending the email, this just dies.
+
+sub send_message {
+	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
+	my @recipients = @$recipients_ref;
 
 	my @sendmail_parameters = ('-i', @recipients);
 	my $raw_from = $sender;
@@ -1735,11 +1742,8 @@ sub send_message {
 $references = $initial_in_reply_to || '';
 $message_num = 0;
 
-# Prepares the email, prompts the user, sends it out
-# Returns 0 if an edit was done and the function should be called again, or 1
-# otherwise.
-sub process_file {
-	my ($t) = @_;
+sub pre_process_file {
+	my ($t, $quiet) = @_;
 
 	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
 
@@ -1893,9 +1897,9 @@ sub process_file {
 	}
 	close $fh;
 
-	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
+	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t, $quiet)
 		if defined $to_cmd;
-	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
+	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t, $quiet)
 		if defined $cc_cmd && !$suppress_cc{'cccmd'};
 
 	if ($broken_encoding{$t} && !$has_content_type) {
@@ -1954,6 +1958,15 @@ sub process_file {
 			@initial_to = @to;
 		}
 	}
+}
+
+# Prepares the email, prompts the user, and sends it out
+# Returns 0 if an edit was done and the function should be called again, or 1
+# on the email being successfully sent out.
+sub process_file {
+	my ($t) = @_;
+
+        pre_process_file($t, $quiet);
 
 	my $message_was_sent = send_message();
 	if ($message_was_sent == -1) {
@@ -2002,7 +2015,7 @@ sub process_file {
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
-	my ($prefix, $what, $cmd, $file) = @_;
+	my ($prefix, $what, $cmd, $file, $quiet) = @_;
 
 	my @addresses = ();
 	open my $fh, "-|", "$cmd \Q$file\E"
-- 
2.34.1

