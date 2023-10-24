Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A93E474
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lk4lD19z"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B510C9
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzcHGHd08n4sSvNQsBsot1mi2RWdJk6SXFqKKtSNB8cXDOjLzxZ9wDbmwHZovspNnhTcKCnG2iIUHCJ+XGzpnLvm14IAxb/jtvg2ZroNcdLzQCsBe2DQO5EcxJd8jHpHllWjCezTFsr5R+oFmA+BOLxDM0TDh76yenGnrdcndUXZnhH41njj8gKIzD6Kme9td0lXujolF3amN6fXIEjot8vv+Ph0/Gvz1q3gyFbGOQDHg++3MWsdcFziwVrUVSB+i1pr610vr/NfcQ4xoYbaumPYQaaz7OjZMazhB82JI71/pMjZ0LXQ3WC850KDMjmkNRNUfexcEiPmUQRuGrEHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGhNto9JZkl8+vsrrCn95MqqXx5UGUFRBTpB95Jsx3A=;
 b=SaMT+cCMr7lmVMtoO7gp3zV0/jVQ0IUAbJBLpZ1ufFDx6bWltYm+XBzOJrmcmzvRO+Oc5VAjRODja/TkxSQotCGUVT7t3KbqO7x/TJbnJAlaM+EKheqZJZqUShv1wqHe5pz36AZ0g6UAYzNY4N5b7b4tJ4ng9s6kVc/4J1T9ISEKCPtY5Ibl54GyXq0C9fA+Q/SWBus2prb2vjs3O4oeUbP/5kNza5RLIHuOvLt9kE5izwvNOnJJX+ToEW9ltHIOlXRfPB7ZCrOZR+eyVCyH5jVIoNWWrFhqSnbmibC2qjC9bv20xjklzdzOdrwbsBCUOGSU9eW3jDEM0l/P62WVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGhNto9JZkl8+vsrrCn95MqqXx5UGUFRBTpB95Jsx3A=;
 b=lk4lD19zl1krA86Q8vE/6vKnkbg3u8r+L6nu+3RKc5+qoY6II9/XPOptAQ1vsXlh1Kt7uHYC13G0aP//M3ikfR4jgWGKTM33Eingv+bdU5y3ke1UwjVdI9wq3nLmyOUpvZP8zm2nuPOS93GnYv3xPxLmm4rSZtztvG5f/l+vKL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 20:19:48 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b973:5b73:8e3a:e170]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b973:5b73:8e3a:e170%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 20:19:48 +0000
Message-ID: <ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com>
Date: Tue, 24 Oct 2023 16:19:43 -0400
User-Agent: Mozilla Thunderbird
Subject: [PATCH] send-email: move validation code below process_address_list
Content-Language: en-US
From: Michael Strawbridge <michael.strawbridge@amd.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
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
In-Reply-To: <393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:408:e5::27) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 621bdd90-37ac-4c08-51de-08dbd4ce91f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eZtkahR/JQjx+tS5wGWzDaQsCw1JF9mEtaULvsF0dObUFYJDwqRbaEd2tbG7KwMiB0s+YAh3VhRQWQXwzDkSqmfN4OFTuQ6zNH0oJbgbihORPwuEuMsDBBgXt5vRj3nZQIonP61OjaIJrfY/6QX5j3sydE+a3KBGtSgxzs+LcjJnwgLguGDrn+p5w5+VwAl2GmsvR6V6bCzuc4zaSVqD4sPl2PEoIWf4ZKhy9QwunY8vFovzy9t1S2lIb01uo0IU5dDckjmhsUMPJBX3likRjKcPVS6ntI6efno4Nt4eFz/Rkf8Gjo2tEZBNelKpigM2JY5LiUeeKlO7GYRhKa1KQL2gn6gCsZ92UT83nw5gcmtGq4vVrkD72RdoBSMCUO+VmdC3P5u1bgeoN73sB1hN3rRxEX25ALmo5qcSt1bmGTR8dPS0/LCWih5yDpZ6O0vkEe8T3lTZvKsLKLreF4Kuo59kT5h1vEdZ1caH0ofr/0VKsaQXWN7jTbjaq6vy9IHUTM/erY/h9ij9vOKS3ziUyXSPmBP9mRCheTYvRBnafvdev4h8zPqJETuX2BYIZKEWFVyuagQM6GWyqkwY4AROV0DTCc0WI643hCm8A91oMC5BaNMENZdXVMIsWRlJFbdrSgRln1JAFvgA+O6ScD5raQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(31686004)(8936002)(36756003)(2906002)(44832011)(26005)(53546011)(8676002)(2616005)(38100700002)(4326008)(6506007)(6512007)(478600001)(316002)(31696002)(6486002)(5660300002)(6666004)(66556008)(86362001)(66946007)(54906003)(110136005)(41300700001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWlMNU8yenB4M0U3Z1pSbkUrNEhzWkdEVVpTeXdFeU9OeHJVdDJpd0J3dDR6?=
 =?utf-8?B?M2pMdzVBWDZMV2RtWVVIczBBeGVhU0g0U0YxK3Uxa1Z0OGQrTVQyajZkZUJs?=
 =?utf-8?B?dzFMV1Q2b2xzZjF0U2k5MkVmWThzdmtHVWJQd1FRcVhpTlk1Ulg5OHQrZmxi?=
 =?utf-8?B?YUJrTnI3OEl0ejh3NTVtUXpPVFhYUllpNXArNXl5b0FESHRheExwQXZ5N3lP?=
 =?utf-8?B?MTREU1B6Tkg1Y0JLTE5Rayt5MkFTR3NyajJ1aTRKeUdWdDRueVNBQ3hkVWxq?=
 =?utf-8?B?Q1NzbG9VNjhCclY1T013bWFmeUN3NHRFSUJleXVSckZGY0FuTWFwOUk0MnNT?=
 =?utf-8?B?SmhUTGsxamFQbThCYThQeEVwQTFTeWw3dElUSFUraEpmSkpUK25oWGNOdDRP?=
 =?utf-8?B?STNqOW9UbXJhOFVqOStuaXl3TXZSMndoMWJROEV1OWVRK2dKN1RzWUZnV05Z?=
 =?utf-8?B?dm9GakRlL3ZyT2xhUFZTTmkvSmdxZkNzbmtYeWRscVAyK0VqS0ljaEtKRzQ1?=
 =?utf-8?B?Qzh6WTcvcnY5OGlXVFF2dkdSYTVSK3Y0QUlNQWFIZjFpN3lBckc4MVBIVkR6?=
 =?utf-8?B?K1JSQk5LR0plemtRTmZNclEwWTJmaWo2TXVXcUg1RzBoakJGQjlKWUdmYzBz?=
 =?utf-8?B?NGZmQ041S2UwSG5udVZuSEVmME9rNDRYdHZhR1FhVmZ3aEV4WExmS0IyTDQr?=
 =?utf-8?B?bGl1YVlRVVhsZU5YYk1PNm5QazFaNm1Pakc0UVNtdVMxM053Wi8xNTRTZXh6?=
 =?utf-8?B?cHVtUEY2NGkxZUpvRjJaajVSV3ZFZHBhNU9PeUYyUGVPTWd0NU56LzVMeTJY?=
 =?utf-8?B?Zm5oYnRqWlBJUkZzMThBTnpNUHhEOVVCb1dvWjFiYUFGd2ZSaVp0WTZCSnJp?=
 =?utf-8?B?ZFRmUDhhYnNTUEZ0UzA1clgxMmswRXd3UG0veVdOTjFVU0JDQUN6RmhybE5u?=
 =?utf-8?B?YndTL3B1ZzBQbkpQb2hFVlFkU3lDbW9JRElaWDd1cWsrNUpyVGNRSStiWWRt?=
 =?utf-8?B?YkxUWExVU2tONUcrbDF4YTJmN3VpU25WYjVDcFFrOFB6QVJQZ2RuV3NZS21h?=
 =?utf-8?B?TlZRWG5sME5hMDcyUHhqeURrZGoyVWdKOWU2cWV4ZmlQeDFpWEZYYTgrSXM3?=
 =?utf-8?B?ejVEWlJrVWtTS09WQVhEM0l0aFluTkwwN0dzbkMxSVA1blhmeGJKYmp1bHV4?=
 =?utf-8?B?Y0xlNWNJc3NPMzJGeTR2ZmMvOTJUdDBuRU1iV0NVaXhKdzlhS3M1UTg1K0sz?=
 =?utf-8?B?RFRVOU85NTFtQktDUXdOYUlPSFdJT0w3STVhSmdMbDJXOWhTenNWZ05SMk5R?=
 =?utf-8?B?Y21qYXF0eC9FYWZuTU1OOTkrQ2VtRlVwMUV3WXNLV3hTVjN2WEViS2swaG5p?=
 =?utf-8?B?Y28wMlBxNVVmWFBUR2YxNXNqdzV0dHFGTzd0cnliOUdPMlBweGZUeS8zMUJQ?=
 =?utf-8?B?b2FKcWtFd0IwSmFVT1NZc0RJL1lWa0Fqc0w5YzB6cFBxUlgvc20xOGRJVEty?=
 =?utf-8?B?RUc0SEVSSDRrMVFjdjZXVzc1bnZMcDFHNHl4VitlVTIrMGZaaWNOQk12VkFo?=
 =?utf-8?B?eDhPeWpSWldzeGg2UlBBRGV2WjVad2Jlc3EzMjltT2w5dzhkemhZeUNnTk1H?=
 =?utf-8?B?VTQ4SHoyWFZjRGJUY3RqSlB6aG8rR2hxclZHSkhvZnRpNmZmRmNjb2x4cHBB?=
 =?utf-8?B?VjJVQmovYnFrdk1qR3Jpa214NzBJZXkyRmVhOGFuejdtMDFjS0ZkTXA3UXFC?=
 =?utf-8?B?dlFsSXpWZjhDVDZDZVI4K2Z1RHF4VWJCdHZiQm15T2lpY2s5U2d5dUtIWmY4?=
 =?utf-8?B?Yy9KZ1pZSGtzNGZRQTRmV0dITHgvQ0F4OWk1OFhyc1BFZkloaTBUK0R3Uk1G?=
 =?utf-8?B?NzZ2RUtnZ3grV2FQSUw2d0dwM0UvYmIxOG9tamZWT2JlekpRMHUxYzQ0RTgx?=
 =?utf-8?B?eWN5M0o1ekZLaSswWE9kSVNGMkErVVNXRkNmTGZtNlpZaTdDWkFxaDBuV1JB?=
 =?utf-8?B?Rk1nNGtZaDN6eTgya0s1cmFCb0ZtamRXbXJMM1JheTJYT2NYTHphN0xWbnMz?=
 =?utf-8?B?b3c4TnAzZU95L1d0aHR4WVdnQm5pN3c2d0o4bXhZaUtEMEZpNy9POU81V3hE?=
 =?utf-8?Q?hNeOaJeZZ6uVMXLQmUaiwBluz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621bdd90-37ac-4c08-51de-08dbd4ce91f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 20:19:48.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0ceFbWWbFjqJMogy94o9N5u7Rn78yUMseKs00M/dER5M+b/EunpNkMqlH/WXxBaVoO9vAjaqbvKY1ssbND24A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100

From 09ea51d63cebdf9ff0c073ef86e21b4b09c268e5 Mon Sep 17 00:00:00 2001
From: Michael Strawbridge <michael.strawbridge@amd.com>
Date: Wed, 11 Oct 2023 16:13:13 -0400
Subject: [PATCH] send-email: move validation code below process_address_list

Move validation logic below processing of email address lists so that
email validation gets the proper email addresses.

This fixes email address validation errors when the optional
perl module Email::Valid is installed and multiple addresses are passed
in on a single to/cc argument like --to=foo@example.com,bar@example.com.

Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 git-send-email.perl | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 288ea1ae80..a898dbc76e 100755
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
@@ -2023,6 +1999,30 @@ sub process_file {
 	return 1;
 }
 
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
 foreach my $t (@files) {
 	while (!process_file($t)) {
 		# user edited the file
-- 
2.42.0
