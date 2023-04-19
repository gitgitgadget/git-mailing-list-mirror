Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8C4C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 20:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjDSU1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjDSU1o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 16:27:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82478268F
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 13:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJ3gsBeOJhHknYrhZollcKW4c2vQhhUbgcpxZPmzvwDKgysaqEz54Vzo8cs0Is4uV2zuUklX5Ri4hZzvLfQWOy73yNXKNARs9ILBFzlicGiCcyRp6aHXDkpj1u647JSmGU3Da+M8bBstMCxCBv8F9vRi8mmHYD17n808R5ud+TXQDl5EAGyv7rvT2JcJbhWSdbFGeMuZxuz6tQ4Co6Osg3/nlRco+tw93++OZLdd0Sp+KkbgorYz7D15JtlviNL7LAlmbV7xoHsosWWL1p7truGFLzVnu7XyeUo/NftTa4jAMQpiDuuJa7cC8gpBPGF0u7M94/4jrO4knB6Zo0yUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb7quleK5Pa+jW/t3v77fztsoFQloaqcQVf8p1ffHvo=;
 b=A6C+seFbKgXCAgO2UGtoHsP/YlPtPfhpEjE+5xtFDazxAICvQ5ay9yizxkcyxxGHlrvyz71L0v6AMvDMFvcx/INn66ySKvCCXzglhd4xhft/SNO+tUp/QufK9ktmnd9IN6X/v4hX4yVnIYroJrKFmMe6IDqWhDzcjdDEzXTmDS8DLHJnJLQKLcJVGv/a+6kkyFZgnte8VXy69UhyAzRujcI6p3XDXel/R0afnAtIPOTTg6A/E7qy3NLqAfNPbIF7NDnFTnQChJ/En9pAPZYlxZ6YGgYimSyBlKD/eK4GVOWDpXkivjU7LCax2V06OcAyr+fpEI2Qtsey4V9HP5+0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vb7quleK5Pa+jW/t3v77fztsoFQloaqcQVf8p1ffHvo=;
 b=tcVGL50ATwzqBFPp+s4wi6JzHNQkIIw8ErE4a+UwCbSeT0aLFeZJAJjxyhyvo0KPajkOYyxBtjYcm08kSWNfbHf35IVh4IumGFRpY/ieMlmE9MikN/XRhJ+GqRZNm0e9RWS46FW3uMreboqqHTqRUlnwXU4dkI0YhgqbDwQh4cY=
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 20:27:40 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::cc) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 20:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 20:27:39 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 19 Apr
 2023 15:27:38 -0500
From:   Michael Strawbridge <michael.strawbridge@amd.com>
To:     <git@vger.kernel.org>
CC:     <michael.strawbridge@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 1/2] send-email: refactor header generation functions
Date:   Wed, 19 Apr 2023 16:27:02 -0400
Message-ID: <20230419202703.2911836-2-michael.strawbridge@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c81855-84f1-4253-249c-08db4114855c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsgU2lJAkpOoo4HYraBvOj0wHcceWCl5T1MdaCJ1bZyyTkcf1g7mUgGbkUtg7zlMYz6gqVDEdOPG4WqGbKewZFffFcAsi8cC3CIxJ3BYnO7og4ArXg/fcDD3e2bLEPYAOHZZdRbVkJKyphFY2tjNiI1R6hPDIrFUNs0dLpsTFKu64EzWvhud9Aeyf+ENKonNqCS4LoCDqoWB0fRJ4NKmpv4W35WMJEjM/sig3HAt/2sLhxp4YtoVsPSa3kEDWiABjmHfSnGDXCjk9r2xJ61hBUGqvb/cFbRNixZpCjdy3c0ef/bDelt28M1163la1x+74V5VTZAtTCBFCm9bj1FhHXGpVKPkOVg+6WlmyIDw6A4QE2Iz1QiP78PDQNAL23IOpKZ5XE4n4k5F8WEwUSAWhJB05QbBDK7Ep6g8444OwC+75yTR+c6XsBxNZySFogQ+GYBmm1CFt7lOSlOExUWvw32VkbP/VJwMYWriFkpWAe02rv3zFcEYQYPeFRgtoCi17L0DKKHHtkfq8hqspOo3CKz2Qc+Hddm7YbFWnk0iniO3r4/V4VpBu5ZK5Du1KhLx7rFu8xYzcmz2tS0s0hspLc97VzeEor/wABPD+/BQ8ToQVIwC2pKyzClu1W88SzMJtX6q/TOK1gxAJ42O5eDCHnIRGZ+Thcknyojz2ZvOSaBJgCc0mGNvk9e10OCyWsTBrg4OlnU3zuy49luAQioXUTe4lcdlbT3bcUNAfRWNF+M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(36756003)(4326008)(1076003)(41300700001)(8676002)(8936002)(86362001)(44832011)(316002)(5660300002)(70206006)(6916009)(70586007)(36860700001)(54906003)(40460700003)(356005)(81166007)(2906002)(26005)(82740400003)(6666004)(47076005)(66574015)(186003)(2616005)(16526019)(40480700001)(336012)(83380400001)(478600001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 20:27:39.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c81855-84f1-4253-249c-08db4114855c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
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
index 07f2a0cbea..0a44c0e5cb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1502,16 +1502,7 @@ sub file_name_is_absolute {
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
@@ -1553,6 +1544,22 @@ sub send_message {
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
@@ -1742,11 +1749,8 @@ sub send_message {
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
 
@@ -1900,9 +1904,9 @@ sub process_file {
 	}
 	close $fh;
 
-	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
+	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t, $quiet)
 		if defined $to_cmd;
-	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
+	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t, $quiet)
 		if defined $cc_cmd && !$suppress_cc{'cccmd'};
 
 	if ($broken_encoding{$t} && !$has_content_type) {
@@ -1961,6 +1965,15 @@ sub process_file {
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
@@ -2009,7 +2022,7 @@ sub process_file {
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
-	my ($prefix, $what, $cmd, $file) = @_;
+	my ($prefix, $what, $cmd, $file, $quiet) = @_;
 
 	my @addresses = ();
 	open my $fh, "-|", "$cmd \Q$file\E"
-- 
2.34.1

