Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9889EC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjARQfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjARQfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:35:23 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEA92DE66
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:34:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXqlB+da+OXLysl0UntpN7LwJjwl4Uu/Bg33RYQauxkJm0UPIsr7dnal8Vd68yV9bGaHKC/yPYDuqy6wCU+AhPKKBXC6YM858J8n//VOep8en8tLoGZQ50u1902+CJBvnfMk/xOmSShqcERSdpnPemzNFuobC8o7BIJX1nZNrlK3WJEYLVrP/rojWRwF6Sb4pQOmsYP+ZD9F1wdGd4fnZ8LNAMUdOd+ZjAeRIOH8ByoX9U2PBHmXU1qYsfCNEABA0TdFCHtPylasL4PvKKpXEkysLcvvRLIwUpIYuStLvFESasQ8gTU2OvWA8hZe+M46uj0a0oa0Pg0axhEhDDh2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvtoFxJMQmtRp1yaeLMXWykTlWg7I5dCE9YqeZZ+g4M=;
 b=ElyxEaiBreGCbzPvPXjmJQD9Y42oL/uw4QkG7dioKDpzsq1MXVntZqVzj0NrRYtWF4bM3gDTWjPuj286tnxPOC4d80UvvrlCI+o/8Q/H0cC/kKnCJcuCePp7/B6GE8+EEkaqXo293GwGe9OZRza5hOY6RpvOxLys0kgYuMdjQKa3KtI9iKhOyCvk+3Z/rEKfNkd858c8IB88oo1iiEF0KA/WAdj5kuxWWP45K0RommMdxl/EIZYEtLOXeJSAKdRwoeQ8SeFemxGHlu1PHf53+XRme+o11hGQNsI9Hx2uBb1J9xS2X2PbKPVVGDbhaAaZJQXkWxkE+HNLp3HOFX34jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvtoFxJMQmtRp1yaeLMXWykTlWg7I5dCE9YqeZZ+g4M=;
 b=PAM5PdARjL9CN0PwT4palmaufqCCnNS0JkgtU5epR1A2VT4AtkZjJ+1opTgmCiWgbHo7R+kpGvov8FDCh6OtVw94XdvBwfqgkSsG8OUdR1cmI7cmCjztq3cX4qxI0NNFdGpFw6b7LOzulirgFFyaVHa70PqShYJAjTR374oG2DY=
Received: from MN2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:208:178::29)
 by PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Wed, 18 Jan
 2023 16:34:03 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::b9) by MN2PR19CA0016.outlook.office365.com
 (2603:10b6:208:178::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24 via Frontend
 Transport; Wed, 18 Jan 2023 16:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 16:34:03 +0000
Received: from mstrawbr-Standard-PC-Q35-ICH9-2009.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 10:33:59 -0600
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     <git@vger.kernel.org>
CC:     <michael.strawbridge@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 1/2] send-email: refactor header generation functions
Date:   Wed, 18 Jan 2023 11:32:02 -0500
Message-ID: <20230118163203.488652-2-michael.strawbridge@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb90b40-8ed1-4605-4d0a-08daf971cf7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVGWAisLgXximD86BPlahZ2vKbMxK6iRw/Ks2b7AM9yJ9eQEbHYxKY1JChXXJ2A/sb9zcwcRlq/PQif+BDfF5XONOxFjV8gSjccUKCs9jHqqz4hElM1kuoLGRjcXFFSRfRu3HqE15wP6JjofbOS8fH9TYXm3U0oh1OfTnltUWe3pQxdbsIybPSrJeIffai3/5p6+iqwDxZp8xdUxKnPxd3K9BrG3gAufK/UHefYnxJoIE3tPtPirba5uGAwvK8UIJ6dH2Q/OuxQIlRe/7GtV1+nkWdSVR74Sqrnieki4HUOa1VVfr+U9V0/FO8vYAkU7EIHvt0KwGcpEhgvxkVcjPr8uz48DOMuFtQr4ka25OubEE9mspM/0uGmqFF3+Lsk6xESGHaMxiVwOMFh6QsUt4O+zDHDIwRiKV9Vtlqn4xsa4uwxJAeHt3pHY8/B0U2B0Ci2+egMcwM+PMaKo3sIIk/8navnwGrOc9v4W7Tpc/GLx31d+uQmPmokT7eOh7pGtPsEdpGGE+gYvxoB89QMBA811wMIdWQUIKM20lzjfBRSNvK/rCaT0cbKEPBifMBBcsw1W1EjEZf7fXJBrUXBlbWH0VDPTZ6Z6Z+I1jD7byqRkERUOxFR7uxh+x14Dkmv+46QwoJmYC4Qy21TvzZwsKiPsnjUS6Te4J8BZEtsviN5BUZViQ2RR7ey3Q+LVMS5RoooWEYy8pyW92T4S2p59ZDWWLTzUlXd2RZSqvVxj470=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(16526019)(40460700003)(41300700001)(36756003)(36860700001)(44832011)(5660300002)(186003)(26005)(70206006)(478600001)(82740400003)(83380400001)(2616005)(336012)(1076003)(47076005)(66574015)(316002)(54906003)(426003)(82310400005)(6666004)(8676002)(356005)(86362001)(4326008)(6916009)(7696005)(81166007)(40480700001)(70586007)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 16:34:03.3568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb90b40-8ed1-4605-4d0a-08daf971cf7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869
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

