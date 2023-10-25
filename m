Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00576286B1
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zh4lj4ix"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F429111
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 11:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8gY+YQGw+Zh/miAFs66sFHpxfIFQuKWdQdOhjshC3Nm7FJk3JFR8xcJnsLKBFy8ZUryTOk8Ih4uEyD2Mym1Lf+N6V3qXdbXiEz9OfzcgPbUWgIRQ5IFH595WpUvur1ZQaQk5OZ4pyXBzJV6E31BUv2SUpLP826/PBdCUUdHk5Wd67zMJnEawTokbyIq/DJ1+fScsvrACdxUswdwRrheJEqUeo1cpcpR9z8K4vhGj2zU0SFeBUxLweFy2u9SZuwK+7TZo5t/krUoI7m46XtX+pCKXoT8PkMv5nr0XX+SzRA7Od5/MdkgVgAjd2GGN6fJxVzXKwECCXSJKqYUtp8wrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cPykJy23srOqnSOJbA82r347n5aCHYCrvKEbXJgKrU=;
 b=mB7SyZt1r6mGYNAAtRwmU6x44Jh2chWPWY2PRprPLJqN4H8vfVE1XGsQp8r3wuRkQ2L4QqfE5ForsKyaV2Ynh0UrQop4m57YBVZsj4UDjP3znzRic0Qi8FPSmqcAzwsHyXL1iJqUCwi0F3A0kxXOQ0sVX0nOYiQZKsobVNYbwKT81ZjtD7oFu8kpEh1zf2lofmF+9uD8iK6xG8Idu6x6j/zq38JxAiUZDdkajsJzxi6KzapApdukDpmvK5D72qruImtYp+UIKtEulRexlvCOnJNFnGXVz9TYgdkhVTCekxkvLZpVVCLSvZmaZExPlBl67M0w9WHVt39MEKMn1Bq6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cPykJy23srOqnSOJbA82r347n5aCHYCrvKEbXJgKrU=;
 b=zh4lj4ixu6YfGtC/L7dMfJ+huGsuE+6zqiuGs53cIGRkpWmFw8tfrMtJxvc5FRVSvYXlLaezUANeX95+wLgyNhtOWiycTtJag9hroo2Tn3VPJ5IFgobaVDAaglWueP3H7mMcRKs1uROQNjop7A4vHBmRZUcCM7pZKzzu9L72xpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 18:51:35 +0000
Received: from SA0PR12MB4365.namprd12.prod.outlook.com
 ([fe80::1b2c:f2cd:1534:b38f]) by SA0PR12MB4365.namprd12.prod.outlook.com
 ([fe80::1b2c:f2cd:1534:b38f%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:51:35 +0000
Message-ID: <ddd4bfdd-ed14-44f4-89d3-192332bbc1c4@amd.com>
Date: Wed, 25 Oct 2023 14:51:29 -0400
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] send-email: move validation code below
 process_address_list
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
References: <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
 <xmqq1qe0lui2.fsf@gitster.g>
 <20231011221844.GB518221@coredump.intra.peff.net>
 <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
 <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
 <20231020064525.GB1642714@coredump.intra.peff.net>
 <20231020071402.GC1642714@coredump.intra.peff.net>
 <20231020100343.GA2194322@coredump.intra.peff.net>
 <xmqqil71otsa.fsf@gitster.g>
 <20231023185152.GC1537181@coredump.intra.peff.net>
 <393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
 <ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com> <xmqqmsw73cua.fsf@gitster.g>
 <xmqqil6v3cgq.fsf@gitster.g>
From: Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <xmqqil6v3cgq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0433.namprd03.prod.outlook.com
 (2603:10b6:408:113::18) To SA0PR12MB4365.namprd12.prod.outlook.com
 (2603:10b6:806:96::22)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f9afa0-4052-4abd-0492-08dbd58b6976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pt2kS0EJyuhxA2WXPp3hL7tKrJkLEgwT9za98VauGy1Ne6OdoT+LaYEaB0HTESpE45Yu+PlUS3ZmULR0bQvbm6X/RI1tNeY69584R7Zs6SF7VhI5+TzV6268j2qhK1GVPX4oxgU1HxukrqBpoevIonUcrtKC7FIopuIWl8+TUQnReUcIs4jEXNxtudAAHwz7g9NHl73IXss37wvAfNhcAofHX2wDis53HFS5aspacSHYWZ91/H0U5xMVdau3AagkXK4WEbq5SlnW6a2lI6tdF9lXLKTQBhmy35XvGcIACGsKzW8mu0lmsosYJseh+LeusWhvmU2eQcdMFS58hdhqtJ2HPiVVwjoIwk+hrzEID730tlhhH92iuULgSFCNcul+60iHmuQqNc7k1J2LCOBmLMD0Mh3qgagg+X4aCpXHbCRS/Z9ROLbwfaHsQGapkEk2m3obQhMtdwVdsJNQ/AO2oyl1xzuFF+BW28Su91Q1mBrE3zw9g6K5lfvXC0yLl/Y27Gpxp4HwdPEDT1r38lX2QscwMKKJZBjpK0umH3t4GZraOLbpvpDRIxZ1e504KPCNZRo7Kk63/mQc4B/9hElzH9ZdVmKQxP6apcENdyTCJb+54oSvFIcBVk9gpThC+I9dgLJC4lkElVZfhVza5Vgnbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4365.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(5660300002)(31686004)(41300700001)(44832011)(8676002)(8936002)(4326008)(2616005)(38100700002)(83380400001)(54906003)(66556008)(316002)(6916009)(66476007)(66946007)(36756003)(6666004)(53546011)(6506007)(26005)(86362001)(31696002)(6512007)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWxpQmZVZFFqLzVjTG1FNVBIWGN1NlF4YXVQalRkL3JHS1RBSzJRSWwzczE0?=
 =?utf-8?B?b2tuQkZvTmptbzRLM2RkbndKWHBFWFVGYStKejBQYmNVTWtINjhXcnNpd09K?=
 =?utf-8?B?Z21Ic1E2YTdLZGtGSEh6RTVUYlNTTUYxYnJ5ZGpQMU1wMFRyU1daR2E0djZ6?=
 =?utf-8?B?RGtkekRHZXRteDl5cFA2NjA2WTN5ajVsc0RtV2c5amVmdlIwalIzRGExa1ZL?=
 =?utf-8?B?dmVDanZQQlRDSzlMTmFqdm9SLzFPS3M0d2xOSWlKUjRMaHVLY0RMSjI1R09m?=
 =?utf-8?B?OThZWWx1cllmWm5YRGRKcEdXRWFheTFrN3lqV2orRzRDN1Y1TkYyc3lRMGhQ?=
 =?utf-8?B?RmNWZGxjdS8rSkJOb1JDT1J3Ymg2UUJnVG5UeTJUR0NTQ1h2bGZKSGhPeHBu?=
 =?utf-8?B?MUVRUm1CdkM4QTdJTUZ0YktWTzY3clJYbUh1OWhLVExUZThpRm5VNlFjU0Fj?=
 =?utf-8?B?Qk4vRWVaS3J4Q203SGpZaEtmL21QNjZ0RTVkQjVJcWV6a09DVk5IZm5PbWU3?=
 =?utf-8?B?T0FPWDlMUUVCR3NoRkpadDZ1YTVHc25yQTZidUtoZmVBVmU3QWNpZmRDdVpP?=
 =?utf-8?B?eUNGdHpSaFVqYzFwN0lIK0xYY3ZnbkJNN0d6dkpteEZaTVRRQ210Y3pQNFM0?=
 =?utf-8?B?VUtoZ21ZcThPRmlKV2tZd1FsMjUrQU9iQ3QvT2JERUJqaVpJTmpUS0lrUzg3?=
 =?utf-8?B?bzJBRnN5UjFKWUp4cEJrd0F3bE5xZ3ZJeEloZEpuMjd1azBWVDlsbnFUU1Jt?=
 =?utf-8?B?TGtNVVRHTzZjVUxieG1wWHUxT21xelUyaUozc2hWU2NOZEx4Szg4VTd5cHV2?=
 =?utf-8?B?T2dOWmxVREY1NkIwWms1dzRSaTlPS1pWRzJSbFhxZzUwOFI0U2FITm5pdWRy?=
 =?utf-8?B?ajZDVWo3bWtwbmRQRHppRHcrL09ocGhPMEw1a0FtbDJUMEljNzl4ak1SOElT?=
 =?utf-8?B?SzBBRWdTQi9VWTV3L0dsd1ZPbVBaSnJHbXQ2TGkxMlNhU1FDMkVBNmdpRDdn?=
 =?utf-8?B?eVh2S3dnMjFqQWQvWWM0TEtxUGdiV2h3dFo3ZnpkbE5lRmJEcEJjVVY2OFZC?=
 =?utf-8?B?RlBaSk4wbm1ISnkvRmpOSFROY04rU243VXE3dHBVTU9DVFFqYzVrRCtVeXkv?=
 =?utf-8?B?ekJJMzBsSUxqYzFyOXlBTHlPNkw3OVdvWUgvalZhR2VrUW1SNEF6U3JXcHlR?=
 =?utf-8?B?dXdzc0E3VkU2WnpHb2NpNkIxSEl3UW5Oa0l0WGN2aU5GbVNzZDN6RzRPUGs2?=
 =?utf-8?B?cXRHY0lLVFErWTFFZWFJNmhkbGkyZjdEMmhJdHpyMUU1eHVwQkVYcEdEOEt3?=
 =?utf-8?B?aXNiNzVMeE9UREthRnJRVHdza0xwalJHRXFVNWJJakN5RTBzZUFJSk9vYnBH?=
 =?utf-8?B?MXhxcjVrQjkzemJEdTl3dUJBN1ptUjVNQkdNbzAvTEJ2WkRXT1BWdWZ4TVBW?=
 =?utf-8?B?K2pPb2FkRUZzNFAyNGF1YW80QjA5REs4WWVKbjNTYjhBLzdReFJUaVJRMTBD?=
 =?utf-8?B?allmUFdOZDQxRFNPNlVpWUwwTzBMaVl2ZzYrL2JraVZGUmxxcWxuZCtPM0xZ?=
 =?utf-8?B?YmgyQ0h3WnRibUxnZVg4SHBab3RxUzZHVm1QL01DWENqN3lGU0I2aWRvdnVN?=
 =?utf-8?B?SmE0MUpuTFFxay9nc1J3Z3Vpd3NBSlN3NktJQm5jSVVEZnhwaThCVTVMUVk4?=
 =?utf-8?B?c0dqd1pwUjhmYkxkbWZveUpFbEZXZVpnZmxYRnNnaXBBc1ZsZk1peWVLY3N3?=
 =?utf-8?B?d3RnRXpibm0xTjJvVW1UNTVUVEJLZWZuQVdiVmczbXZpa2RUN1hjampxODdI?=
 =?utf-8?B?N21icEdKOGlFVU5kWHpXSVRVdWNaN2ZHbHN5dWY0aHp2S2hkVFUxT1owOEhD?=
 =?utf-8?B?Unl0TGJJcmZTR1p1YTh3Q2VNWmEzeHIwSWJ6VDl0aUs4cFh4YVJYVi9JUXlV?=
 =?utf-8?B?K3JHNXZzZWZwakVTVktQYS8ySk9OYWVaOFlWbkxNd3E3cEJYVEF1ZTY4OGpo?=
 =?utf-8?B?MWVSU2h3VWQ4VWJOV2E0azVBZ3ZlbEg2bnJMVFFUQ0tzTzBMeHRkVkZLY0c3?=
 =?utf-8?B?dlBpaW5mc3BRaXpKUmxPRGdieVA4RzRnOVQvUmdRVHZFaStCSUpKQnUrdzFF?=
 =?utf-8?Q?iYhEguU1WnDzhdiE6ieVu0k+5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f9afa0-4052-4abd-0492-08dbd58b6976
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4365.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:51:35.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdleRyT0LAwBGbBeTlmNqV3FKJMpHCtpFexq9SqqdmWNLymApJ0KA/xG1YIzUK5OLdAa1/YwJ6S0Wpyaq87DCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586

From 67223238d9b1977d20b1286055d7f197e4d746e9 Mon Sep 17 00:00:00 2001
From: Michael Strawbridge <michael.strawbridge@amd.com>
Date: Wed, 11 Oct 2023 16:13:13 -0400
Subject: [PATCH v2] send-email: move validation code below
 process_address_list

Move validation logic below processing of email address lists so that
email validation gets the proper email addresses.  As a side effect,
some initialization needed to be moved down.  In order for validation
and the actual email sending to have the same initial state, the
initialized variables that get modified by pre_process_file are
encapsulated in a new function.

This fixes email address validation errors when the optional
perl module Email::Valid is installed and multiple addresses are passed
in on a single to/cc argument like --to=foo@example.com,bar@example.com.
A new test was added to t9001 to expose failures with this case in the
future.

Fixes: a8022c5f7b67 ("send-email: expose header information to git-send-email's sendemail-validate hook")
Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 git-send-email.perl   | 60 +++++++++++++++++++++++--------------------
 t/t9001-send-email.sh | 19 ++++++++++++++
 2 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 288ea1ae80..ce22a5e06d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -799,30 +799,6 @@ sub is_format_patch_arg {
 
 $time = time - scalar $#files;
 
-if ($validate) {
-	# FIFOs can only be read once, exclude them from validation.
-	my @real_files = ();
-	foreach my $f (@files) {
-		unless (-p $f) {
-			push(@real_files, $f);
-		}
-	}
-
-	# Run the loop once again to avoid gaps in the counter due to FIFO
-	# arguments provided by the user.
-	my $num = 1;
-	my $num_files = scalar @real_files;
-	$ENV{GIT_SENDEMAIL_FILE_TOTAL} = "$num_files";
-	foreach my $r (@real_files) {
-		$ENV{GIT_SENDEMAIL_FILE_COUNTER} = "$num";
-		pre_process_file($r, 1);
-		validate_patch($r, $target_xfer_encoding);
-		$num += 1;
-	}
-	delete $ENV{GIT_SENDEMAIL_FILE_COUNTER};
-	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
-}
-
 @files = handle_backup_files(@files);
 
 if (@files) {
@@ -1754,10 +1730,6 @@ sub send_message {
 	return 1;
 }
 
-$in_reply_to = $initial_in_reply_to;
-$references = $initial_in_reply_to || '';
-$message_num = 0;
-
 sub pre_process_file {
 	my ($t, $quiet) = @_;
 
@@ -2023,6 +1995,38 @@ sub process_file {
 	return 1;
 }
 
+sub initialize_modified_loop_vars {
+	$in_reply_to = $initial_in_reply_to;
+	$references = $initial_in_reply_to || '';
+	$message_num = 0;
+}
+
+if ($validate) {
+	# FIFOs can only be read once, exclude them from validation.
+	my @real_files = ();
+	foreach my $f (@files) {
+		unless (-p $f) {
+			push(@real_files, $f);
+		}
+	}
+
+	# Run the loop once again to avoid gaps in the counter due to FIFO
+	# arguments provided by the user.
+	my $num = 1;
+	my $num_files = scalar @real_files;
+	$ENV{GIT_SENDEMAIL_FILE_TOTAL} = "$num_files";
+	initialize_modified_loop_vars();
+	foreach my $r (@real_files) {
+		$ENV{GIT_SENDEMAIL_FILE_COUNTER} = "$num";
+		pre_process_file($r, 1);
+		validate_patch($r, $target_xfer_encoding);
+		$num += 1;
+	}
+	delete $ENV{GIT_SENDEMAIL_FILE_COUNTER};
+	delete $ENV{GIT_SENDEMAIL_FILE_TOTAL};
+}
+
+initialize_modified_loop_vars();
 foreach my $t (@files) {
 	while (!process_file($t)) {
 		# user edited the file
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 263db3ad17..ccff2ad647 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -633,6 +633,25 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 	test_cmp expect actual
 '
 
+test_expect_success $PREREQ "--validate hook supports multiple addresses in arguments" '
+	hooks_path="$(pwd)/my-hooks" &&
+	test_config core.hooksPath "$hooks_path" &&
+	test_when_finished "rm my-hooks.ran" &&
+	test_must_fail git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com,abc@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--validate \
+		longline.patch 2>actual &&
+	test_path_is_file my-hooks.ran &&
+	cat >expect <<-EOF &&
+	fatal: longline.patch: rejected by sendemail-validate hook
+	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch> <header>'"'"' died with exit code 1
+	warning: no patches were sent
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success $PREREQ "--validate hook supports header argument" '
 	write_script my-hooks/sendemail-validate <<-\EOF &&
 	if test "$#" -ge 2
-- 
2.42.GIT
