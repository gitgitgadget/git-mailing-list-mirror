Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2401AC38159
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 01:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjASBFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 20:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASBFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 20:05:53 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886EE59552
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 17:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMY1xWjEpj+KgmGgfdrpiPu6j+OLvYkETOHVaI7jchZnolFcaFSBr6A0LtmYm8I8PRDwggFGAudExlVBfxZ/v2KEVZHuIQ8kwy6Q6z5myariAuiSssg7R4xdJ/i6OndTbzIdeQubspfFRSZlrvxwk8A7ZUfThNc/5N4o84d6kQ1w0miTNWCxSyilgji13iPpLioRVpw3Z/v4Q0KiLunj7BI/izAkWkJj2iWQsaZZhk7r98FrpQeiix810x2FnTdV3ojsYvTLE7PhMZBL7UtuR/rPJdQSXW9zRvkXTFHaESlxaTwzfWfUaSAyXd6UeOxtyjT6mcCnKrJEoD1+MPiJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJh2MXtVMicyBTHp+15P+h/JZv52jz3uH5YeyA6mzBU=;
 b=L1LPnozLVwtxEZHZwcRGlfms/bG8oEMl5n9GERxGzrQoQAndgkDfjM/Z+mFOCE5g3/WJhJWp72wi3LakjMl9oWLse6spLbM23w1hQN/TSiIfEx4EkzfcaBT/ZoPiAZkx6sHGxPoJi0XLqZ3xWenprSYSfWf0ZJVZ+Ad4O1Pqo4jPK+kDKnDjG3T3obo+edzvv88JVLAWm65WtZGRh2sVeDRUzPGgTM0ZfQ8uUnEEMdApSulhN4z1mB8q50XOOpG1so8mN1uHWoO9otgTmvh3ru/sBINesj4cvEbyLUzqUFeAApGTe5WT7jr3seFyRrFv5PaRCERo5oQigO5XOGoV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJh2MXtVMicyBTHp+15P+h/JZv52jz3uH5YeyA6mzBU=;
 b=ngIlI7jsLyErkXI0lnc805cn2PYwjmtHBF1mjwiQS4OACf8hnmkB4NHxBsVSzZC3XNketUg3RBbunxpChn69/XiDsUqibz3J/CChLk/BPmMu/uvLoZofONV54pytKaYvKXcqmtSsqXii1WmO3ifmruh76ixEAmP0hseyTd7zIrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.21; Thu, 19 Jan 2023 01:05:47 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 01:05:47 +0000
Message-ID: <5c3f8309-8dfd-9888-3c7f-1ca32b502e3e@amd.com>
Date:   Wed, 18 Jan 2023 20:05:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Luben Tuikov <luben.tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230118163203.488652-1-michael.strawbridge@amd.com>
 <20230118163203.488652-3-michael.strawbridge@amd.com>
 <230119.868rhzwi36.gmgdl@evledraar.gmail.com>
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <230119.868rhzwi36.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::26) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a0593f-318c-435d-a0a1-08daf9b94c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dS5PA4gttn3jCd1OPGOBQSNUgZfTzoN5UPq74GnD3onVrZSG9AVOoVRhelO9J86V7k4TE/5IY6qciTNWgbCXkCc/AemQJL339+A9GQKTNSymylpRsXaDQwFaWcV3vsQPGIZ11XbkrTatw9RYCXkDRVh9LgxY/B9ZkHovM735Qb3h8/P0FAy7fwYL46syLqydviTg079XoxAkxBE9ej+sm5oKfL39W1SBh6oS06G82FAkPDfZIHaUJoIJhQVi8XiSEUOwh8fInCvQym0oaUs7wnrXE5w7TbRgcA+euZmsS35kWv0dy5pTWiQEXyF2GalQGkgVfz5pLWOmi85o/8owbIE0NX0Ao+d4otPtheWP/fPWfD4gBvzZElTxKGlHaelqMUGHBhLzGdwbfATSBau91sa4R2/Z3aG0NMOyr5JdPH/jIyzejFQPBlQua65NTu4Y0pS5DDS3O91RUPdjmrLnrMi+7cHei4D8Zm3iEM8HKH3iwVkCo7U3T2pXp9eXbOY07sEwVn1oHDyg8ipqptVgz/nk94QrnKgx33YQXL4JilcBjjvBSzMO9mOuYsK1zFHp2HuZS6CvoocagzupibuIWpvcPaV8YAJh+JiaiGZrZLGGAEMw1xdk58uRQ5PwxZjEifA841eX/FKQcdDPLtwbpoafbT1zjH5yCDey7/Y0OQaHQzAkZQvNWnZURHWhyBTmFj+jzj4zx8TWZMBcrWEFAMf2MwQJA1Bqaa74FUg8ZRLuqzb+szJYNzsBoqYjeffzSGGTIXkaqgC3jJNpyJV9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(6916009)(6486002)(8936002)(66476007)(41300700001)(5660300002)(54906003)(4326008)(8676002)(36756003)(66574015)(316002)(66556008)(6506007)(38100700002)(186003)(86362001)(2616005)(31696002)(53546011)(26005)(6512007)(66946007)(83380400001)(478600001)(15650500001)(2906002)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0JsSXZEVTkvY1lkdHR1eW9YOHBwYmpTRDZUaDhiOHROeGZKaHAzcVd4c3ZQ?=
 =?utf-8?B?dlZ3NTFSUFdwN3RmVG56dXYvZVN5ZEFjSUxZVmVXV29tM2hQaFhCMmU5OFpv?=
 =?utf-8?B?d29FQllkczJUN3R0WWd6VjM1dytYK1F6UXUwTWo2UGtISkkvaFZVTndLMFl1?=
 =?utf-8?B?Rk5rSi9jaTJkTWNlbER5RUpTenFxZklmc2lZNnBpZk9BVHlPaThMM0YzYTlq?=
 =?utf-8?B?eG5ybVJrd1YyeXpLbFRZR2RFdjVRR3hYTU1HMHNlaXhZU3hlMWdVQ2JLTWhn?=
 =?utf-8?B?SXJpczNPRVZFbFBKUC9wVjNTZ1U5a2J4SGdmTEU5RWdpK2cwRnMvWmRvSE1V?=
 =?utf-8?B?S05CMzVncXlXdUUyS0xJdkNqbmVFeXlwbmJ3ZzBoOERUZytiVkhHbmNtN0hI?=
 =?utf-8?B?WGZJVUp0S3VJdE9JREZFUFZDd1VLSUhTMGtxNjhzNGZHNGpURXVnSllFWk50?=
 =?utf-8?B?ZnN3WDg2cFFiMVJLRGVLMGhuSTNXL1ZUbnVtRFpyVDM3QlV3czh3V1RJeHpK?=
 =?utf-8?B?bTRDQlhUVGd3cEdJdUlEVW52TTNITWxJKzdxbmhyYmVidkg5MDdZQ3U4U1Fs?=
 =?utf-8?B?UkhMSVZpQ3ZLYUxPdUtFWjRRSnZZOHpRQmxWOTREc0JVaDBiSkl4eWs3UFZG?=
 =?utf-8?B?bXBQZ05HVmVNRmZVYmdtUjdaMGNUZ2RRa0k1WURyRCtnVnk3a21FVFJaZ1gw?=
 =?utf-8?B?TmJmVW1oT0QwZi9YeCtsRmNyZ1dFYzdLMktJMEpHZFBtRFhaTlNzSmY1LzZt?=
 =?utf-8?B?OUZCTjhnY2ppbExpSStQSjFIRVJiWEcwMjllY1NNZVZjd2k5aGkvai9aMzFL?=
 =?utf-8?B?QjJWVUM0TzVRZy9aNlJmQUF6NHRjckdYVEhaa2VKaHEwQmlOcEx0Q1YxZXdj?=
 =?utf-8?B?ZkxkdHZ3dDN4T3BKNnhLU29lS2I2TUQ5aHVqWEp2NzF3eTh2WmpvNE9xaFQz?=
 =?utf-8?B?Tnk0SFk1THJSV3dGZjg4cTVsTUsxM1Q1NG1hTmtJU2dWVWFGMktSWUlheldJ?=
 =?utf-8?B?cXFrTU1oNUNGYkd4MmhsQTkwd01BRFl6VWgzYlFpL1QvdmNBSVlaT2k0clRB?=
 =?utf-8?B?Q1Y3WkVvMXViMk5HTXduMFhiM1hVNTJ0Q2NUSCtkMy9GdjYzU0dvd0FjYjhI?=
 =?utf-8?B?T2R4anY4UjMvN1R2Tmp4VHB4S0hjWnMwL3RwWFE4Qm56SC9GTmtkZHVRb2wz?=
 =?utf-8?B?RWp0eUNJMG5kR09lNzhHbW5hbEN6Q2RLa1U5dkZLdVo5d05HM0tLbVdJU1Jw?=
 =?utf-8?B?czU1UjdWcDNaSmZQSnFyaTJ1b3kyOWptWE5tYzgrNSszSzBZeGV6alo1ZWNu?=
 =?utf-8?B?KzU5SXRZNjAxQklVT2FvdEhEc3pmNlNYMWl3eHNodjBTOFpxczYwOUE5UU81?=
 =?utf-8?B?RVZUMm41d3FCU05heW9TMUxZZUppR3BudUpyeXY5d1FoUERURURrZlpUNStI?=
 =?utf-8?B?S3lPY0NrZ2Fhakp2Ri9UTjhHZmo5b3dOSHdwTE00YmZzdndHTEo3bUd3MGI1?=
 =?utf-8?B?M2JTME9vL3FLcW5NaHhzZ0xwM1FSdnBSaEljV0lneU1pejZLRUluSjVxaytJ?=
 =?utf-8?B?aXJoTmk4WG1rbmJQY3RCeng5dmc4bm94VUwzTk5jOWUwQnZYenVsQzRLM3VW?=
 =?utf-8?B?V2FMQlZWUnRtWTg3bkE1amtlaURKa0crQWpLMzdRZjFZcjBtT0tWb2YyRElF?=
 =?utf-8?B?dkpZcmdnL2ZhWGRYdW5SOVhqaGJOS1BmM04vdzN0c0RxTEE5UGNxaUt4WENJ?=
 =?utf-8?B?dGJTYXFMU2c2VEw3ZStoWWRLUEtUeVMxbGxDMFJOa2JTcGtJZ3UwU3AxRmJp?=
 =?utf-8?B?bmJKNTM2ZnZzRWFxZUpuZ3BBVUsxR2hSSHJVY1VBcEtoSndMMnFvOGtIektq?=
 =?utf-8?B?OTFQOVE3YnFvdXp2a25UcWJLMi8vSS9ISzgwWjdxRzlreWxtdEtud0RXdHc4?=
 =?utf-8?B?M1pER3JFcS9Gc2wxVG5wL0hPcmh1NFNPeTJkdE1XRDZueG5seDlFYm53eFQz?=
 =?utf-8?B?NVFsZFZhcHFJb2RqL0cyZkhDMXdySGV0SGJOd3VYbk80YUljSDhMMnhURFVl?=
 =?utf-8?B?cDdDdHgwdE9Vb0I0T2RVQi93SVFmZkVIbzBjcEhsTnd1VGRlYjRYSEFQYVEx?=
 =?utf-8?Q?z3RnwKoEVQx2olFL9ezrjpHts?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a0593f-318c-435d-a0a1-08daf9b94c70
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 01:05:47.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqnrJcxBvBXzIRO4GuHk5u06SWG9sRHqYY5i5jqo1A47MEWBY3knMWcGC7IK6uJb42kvPTOYgu5UmGBp2+FEQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2023-01-18 18:12, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Jan 18 2023, Michael Strawbridge wrote:
>
>> To allow further flexibility in the Git hook, the SMTP header
>> information of the email which git-send-email intends to send, is now
>> passed as the 2nd argument to the sendemail-validate hook.
>>
>> As an example, this can be useful for acting upon keywords in the
>> subject or specific email addresses.
>>
>> As a consequence of needing all the header data, validation has been
>> moved later in the sequence to right before sending the emails instead
>> of at the beginning.
> Ah, I see. I tested this (i.e. moving it back to the previous behavior)
> and you did this change because you don't have the $sender variable yet.
>
> I tried this quickly on top, which seems to work, i.e. now we do this in
> the same order as before, but we just move the $sender code earlier:
> 	
> 	diff --git a/git-send-email.perl b/git-send-email.perl
> 	index d123dfd33d5..7e7681116bb 100755
> 	--- a/git-send-email.perl
> 	+++ b/git-send-email.perl
> 	@@ -787,6 +787,28 @@ sub is_format_patch_arg {
> 	 
> 	 @files = handle_backup_files(@files);
> 	 
> 	+if (defined $sender) {
> 	+	$sender =~ s/^\s+|\s+$//g;
> 	+	($sender) = expand_aliases($sender);
> 	+} else {
> 	+	$sender = $repoauthor->() || $repocommitter->() || '';
> 	+}
> 	+
> 	+# $sender could be an already sanitized address
> 	+# (e.g. sendemail.from could be manually sanitized by user).
> 	+# But it's a no-op to run sanitize_address on an already sanitized address.
> 	+$sender = sanitize_address($sender);
> 	+
> 	+if ($validate) {
> 	+	foreach my $f (@files) {
> 	+		unless (-p $f) {
> 	+		        pre_process_file($f, 1);
> 	+
> 	+			validate_patch($f, $target_xfer_encoding);
> 	+		}
> 	+	}
> 	+}
> 	+
> 	 if (@files) {
> 	 	unless ($quiet) {
> 	 		print $_,"\n" for (@files);
> 	@@ -1035,18 +1057,6 @@ sub file_declares_8bit_cte {
> 	 	}
> 	 }
> 	 
> 	-if (defined $sender) {
> 	-	$sender =~ s/^\s+|\s+$//g;
> 	-	($sender) = expand_aliases($sender);
> 	-} else {
> 	-	$sender = $repoauthor->() || $repocommitter->() || '';
> 	-}
> 	-
> 	-# $sender could be an already sanitized address
> 	-# (e.g. sendemail.from could be manually sanitized by user).
> 	-# But it's a no-op to run sanitize_address on an already sanitized address.
> 	-$sender = sanitize_address($sender);
> 	-
> 	 my $to_whom = __("To whom should the emails be sent (if anyone)?");
> 	 my $prompting = 0;
> 	 if (!@initial_to && !defined $to_cmd) {
> 	@@ -1120,16 +1130,6 @@ sub expand_one_alias {
> 	 
> 	 $time = time - scalar $#files;
> 	 
> 	-if ($validate) {
> 	-	foreach my $f (@files) {
> 	-		unless (-p $f) {
> 	-		        pre_process_file($f, 1);
> 	-
> 	-			validate_patch($f, $target_xfer_encoding);
> 	-		}
> 	-	}
> 	-}
> 	-
> 	 $in_reply_to = $initial_in_reply_to;
> 	 $references = $initial_in_reply_to || '';
> 	 $message_num = 0;
>
> All tests pass with that, which is less good than it sounds, because
> shouldn't your tests be checking whether we have this non--quiet
> print-out of the files as expected before or after the validation hook
> runs?

Thank you very much!  That idea to move sender earlier actually
simplifies this a lot.  I had to move a piece relating to the date field
earlier as well but after doing that I think the patch gives the same
output.

I think checking the timing of stdout in tests is not easy.  I'm a bit
unsure we would want to test such specific stdout behaviour in the
tests.  I have focused on the functional output (eg header output). 
Luckily with the above, my change will no longer introduce any stdout
differences anymore.

I will wait a little before pushing out a v9 in case there is more feedback.

>> +
>> +			my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
>> +
>> +			require File::Temp;
>> +			my ($header_filehandle, $header_filename) = File::Temp::tempfile(
>> +                            ".gitsendemail.header.XXXXXX", DIR => $repo->repo_path());
>> +			print $header_filehandle $header;
>> +
>>  			my @cmd = ("git", "hook", "run", "--ignore-missing",
>>  				    $hook_name, "--");
>> -			my @cmd_msg = (@cmd, "<patch>");
>> -			my @cmd_run = (@cmd, $target);
>> +			my @cmd_msg = (@cmd, "<patch>", "<header>");
>> +			my @cmd_run = (@cmd, $target, $header_filename);
>>  			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
>> +			unlink($header_filehandle);
>>  			chdir($cwd_save) or die("chdir: $!");
> I'm still curious about the "stdin" question I asked in the last round.

For the stdin question, are you referring to the git hook run question? 
I know there have been a lot of parallel threads so you may have missed
my reply
(https://public-inbox.org/git/20230117215811.78313-1-michael.strawbridge@amd.com/).

Here's what I responded with:

I was trying to follow the convention that the original hook was using.
I'm not against changing this if the out of tree patches you speak of
are going to be rolled in soon.  However, I'd prefer not to delay this
patch if these other patches are far off. Thanks.

