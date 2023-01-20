Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18EAC05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 13:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjATNHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 08:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjATNHr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 08:07:47 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B67AA4
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 05:07:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkRfDj7XS6HAo+7yTlW8LcK2AlJLoxoreSoeyPDGTJAbXy8PK/X7bnohVH7QJmMEsCcTbeZNXQpJh4jAU9YYiFGNN6wj1VAuaMLNnm6NLhoOYIxcPmqsxuQaKJs+LCNCdB67/zAQ5uK+/zkDhFSQpichS4g/BLcjS3zNKVTlIyd/DnGUv1Q44v+DfUFsu2x2U8vBAg78h0u+G984FgvFIm7ylM1ogCASS73LXo2K6LgbK4bIAzONOlrQDPYAUeqOLZKD9Z9gqPhcfsDR8ppgYjW3wQBAt5M5PkrIXc/ED/meS1TbXJ2oCMuFQFSaabjjEQXF103K2OMAW2NuJVp4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GC7aSrqWRoNs+ULrB2jGcwtM8BcITP9PDJL+HxFFPyg=;
 b=PX1KiWVpJ/T7zzzGpquba8/zd0n9vketEdUPdFFOqMkmQJ/nDDsARwldd7LdF9cx9wFreI3qRRZzozjPDO+Vs3FKRmj7+hy19L/CbSM/B0Tcil0OUL6ZQBTvUC8WA/02Bq1RaOXLUAJrmurMZxjGR7Qy2e4UZt3zgR8UOZ+AjTk2viESLHuiN70V4ZeLKLUh0ogEnFWzrqabLThrdZex/G/Qf0W81T1/FFuyLUoe9gUZ7fSHEkecfoRVPwvW486kcASaa+/oLY1zfV4fKFMLN1sHjuqemlh6MJEQU5PVwDRMnmNoigPOdnpIvoc+UpOvldGkV8kuzXoih5elpvuJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GC7aSrqWRoNs+ULrB2jGcwtM8BcITP9PDJL+HxFFPyg=;
 b=eG5ZCplsJOuLr/TnCGwGFkcEEoxvm7JePn9JV5JfS/wgimEoXtNXfQYk0qm7Sd68VloK2ujIcbt6N8jP+z4BmGkQlIvHnwc6o/OzjPdhWNSFUULMKrKkm/OXQT1ntKSfiqXFvOw0ZqRTcWwflSH1OV+5eoycmqYE7Hyx8r3onT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.26; Fri, 20 Jan 2023 13:07:42 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::4df2:b32a:e628:c57e]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::4df2:b32a:e628:c57e%7]) with mapi id 15.20.6002.024; Fri, 20 Jan 2023
 13:07:42 +0000
Message-ID: <e353df62-c189-755f-5536-5ea91177c55c@amd.com>
Date:   Fri, 20 Jan 2023 08:07:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-CA
To:     Michael Strawbridge <michael.strawbridge@amd.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230120012459.920932-1-michael.strawbridge@amd.com>
 <20230120012459.920932-3-michael.strawbridge@amd.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v9 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
In-Reply-To: <20230120012459.920932-3-michael.strawbridge@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0088.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::21) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 657e5a46-ca75-4a5e-5ecf-08dafae7507b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCvOV+kthP1ZsJVBiexlHit2s6ntVC19z/4H9c+x1aqSaxiXM/AfN00Q15sQ5gc2Qv3I8A+hwWW1K5sAGOR41Vn7kAeqQ3b4AUkcoYR1e2+N9cJihSvtOpwTAPmXJwFMYo0YcYaE1s4WVlzF85URFvAbuidNRD5hTdgN+3VI9a3RB6RFsFDxZ+IFYdGQ9eRFvKbykPmcp6V5METn2hDiI4Rl4hJQHgX/cXcgQXw8GIm80jVBQvo5yvRFvjqtileDs4zuZlodl/eyKL0n68i/82yTTZcn4wm6e/h9YUwsiMbZ+Z/3DmVKrm4QThTxXjf33KrdPQ2lnzbLPpATpW5bmAxHTnI0V98ZdhWYlUcZGA8vdLj1NNas6qqWfbJFbRxnSLpffacJfmvX+Itnce1tlFuHNA/dMoHzqN+zfuqgfAOx2/t8trApKqw5kvsj1tQ5QLEKvRoSp0Af0cdd+yoxMFt+XOBiuotUO2HuDkxGaoBK4rbQCK2V2Jz82OsI84Fy9EfiRNtIZO0+eyBzV1V+dHOhJlUTl0IgvytjV/bnMBfTyY/24lJa4KBE0vB1myw2a2Iuyh1V2CdMNEZdi0cA3RklV0qwWXZwJzg+w4dfjMf/DIEYnPiQKUmZjYSz4v1RQVytXb5QEEMSBFXq+UsWnxKKpc9fkx7CHnkfu/QnUWAHLIjBkH6fpvPNnBxE1Usb9gCQyt38REg64Iw9QZWLNhXmZZneqO+0yeogHw0pu58=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(38100700002)(31686004)(478600001)(6506007)(53546011)(186003)(26005)(55236004)(86362001)(6486002)(31696002)(6512007)(83380400001)(41300700001)(15650500001)(2906002)(2616005)(44832011)(8936002)(54906003)(316002)(5660300002)(66476007)(4326008)(66556008)(66574015)(66946007)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWlYWUdOQjlTSmVUYVQwRWY0NkNKS3dnUFB3L1NpTHNrNGZFQ1VmSkdzN2do?=
 =?utf-8?B?Yzk1Q3ZmZlBxbHZBSVl4ZS8rTWRGdGZOV2ZzWFJ1MjJlWWtOdFc3M1ZEd1Q3?=
 =?utf-8?B?ZDE0UWFUWm5keitoV1NiZ0pXVVdBanlob2QwWTJ1TWhsZ1BZQjgvK1VNY3Vj?=
 =?utf-8?B?USt6ME80OURTWlQ3enMraVNZakRVc25mSVJaUUlOUDd5bVRkY1VrbG1oNDdm?=
 =?utf-8?B?UzJ0UjFzNnZHbStRRWhJQmgzYzNMaURZaWxXRmRMS1pRa0VMS0hvbG82RXBm?=
 =?utf-8?B?cEJ0Uk0yaW8vcG1wMjY1SWo1M0VacUdFSThReWNoRXhwWFk2S1ZzcXFUOEZE?=
 =?utf-8?B?aDUreFROOXBMSVFqcFdOcFl1VmlnWlF0UFJRek5NTG9sc1YxSys4cEVjUEZy?=
 =?utf-8?B?UEl0U0Y2ZEsxaEppY3VOWit4TzZuRU1mL0dhRjNzYkdsWlQxUFVZazJXc2k0?=
 =?utf-8?B?UHBydDlNd2NscHJtd0pHaVV5eDlWNXhxK0ZpMzhhZFU3UGpNcXhzVUhqZTN5?=
 =?utf-8?B?NXlVMjVIMmc3eXR3M0tYK1VhZjIwMkI5WWZwRzhkVFRjK01DZ3U5cmZ2TW04?=
 =?utf-8?B?SmZLYzN1dXBsc3YyMGZJVFBndkZrL3ZmdWpKQ3crM2YzdHlNK3hHQklGRHhD?=
 =?utf-8?B?YWk4enpVZmdPSXVxdEJhV3huKzlKU0tTaDlRS1JWUHFRY1BDM3RNVUEyQ2xI?=
 =?utf-8?B?VlVjRjQxRXNOKzVLakM4Und0OEI3UElrakxtR3M3dlpISDBwVmVWYkF4TDF1?=
 =?utf-8?B?LzlYWWRIUDVHWkFQS1hKenNxWE1YYUx6KzlEMEtlTFJtVWM2cWhMbzd3aDNy?=
 =?utf-8?B?UjhPWXB5RklOZlFXYjBRNEQ5aURneEJ2Tklyc2FYSXdFLzVsUnVUamRMdXFO?=
 =?utf-8?B?aXlad3dKZVFVR3UxSE1nWHFRNkdnYkNwOXZyK05CdFBvQjgwUkxtNmpjYm14?=
 =?utf-8?B?bnRuV2pmSjZ0OGd2VG1rbUE1U1BtSkRVZWpnYVFib0J5M0xTWUZWYXlMQjhQ?=
 =?utf-8?B?MUx0SzRqdmFDK3o1c3NVV3pQOEVzZDhkNEhaTDN0T2hlaTYxM2lFTTZFUkdL?=
 =?utf-8?B?RjBQNXpKRTlKNFk0TWs5UzlOMXdvWS96dXNNYXgrRHAvK1lONHlHWEQwSUFq?=
 =?utf-8?B?T3NzVXNGeDNOd2pEKzMwUHpIM3IvUXVxWSt5STZSRmNtdlFGR3IxWWt3NWtB?=
 =?utf-8?B?WjJpaXNwOHQ0OTdGVjJwNEZNdnQ2S09GdkdoQUFyZHFCQUFNVkRRU0RwSUJ1?=
 =?utf-8?B?WGhwZUdqaDYwQTVLL00yYUxYNnRvL3BOdWV3YnRpZGFvaUowN1laRWV4aFIw?=
 =?utf-8?B?K1h5SDJHZWFJQk9JQTZMTjJCMDNwczdzSzVzNkYrVEFmZ3BsMGlDUGY2dUNN?=
 =?utf-8?B?YmIwZHhld3A2UHpTb1RUdXVOVkVqNlk2TDk0QlJjc3JmYXIrQlp0Sm9RVlp6?=
 =?utf-8?B?dDRFQmE3WDBxMysra29rTHVFM0JYREZMYUVMU2VWVC9OazN4VWhuSzkxaFpt?=
 =?utf-8?B?d2VxWFdpZlZ5dHdNWHM1K2MzSm82bmJ6TTFUbnNlZ0UzejQ0bFYxMllzTzl2?=
 =?utf-8?B?V1c2K2txWC82RTZBZUIwdldVcGZTU2Y2VVVkLzZzY05nS1FuMFFSenIydHBS?=
 =?utf-8?B?NER6aWJaSFhlSy9KZVg1bHA1ZE9qcFJUM01ia3MzQlIxcmpMVUJBVUVDWmN1?=
 =?utf-8?B?bzgvUlVMM3hjTERTeGtlUG14b2J3YUJvbXpEV3E3L3hnM3ZUOGt1Q0VzRTBy?=
 =?utf-8?B?Q1F5dEU3UkFZaTkzOWpvUTlYWndxdWppYWpJVjhnTHJFN1BCQTU4K3A4QS8w?=
 =?utf-8?B?ZjdCUWpDYnR6YU41dk4yYloxRXFKVEcvZXNrSWsxeWxkVERBODhtdGNQaW5V?=
 =?utf-8?B?d2tUZW9uMGRraTdLNTZpVVZxdTVtRjN0aHp3LzVvM0FOTkpXamFHK2hnMHhS?=
 =?utf-8?B?ODN2aEpaTC9CaFd5emtkMUlOSDdUTmltdlhvaTkxMG01NHNrSklFMlVWMktB?=
 =?utf-8?B?dDRsSkR1VkJ1ZHV2SzhiSExuUmtJODBBUEdSeDlDazZZa3hoK3NtNUMzdjhM?=
 =?utf-8?B?dExwMEZkUjNLQTRkVlpUcWVqWkJRN1RPNFRoR3poVDBkbHVnLyt2Z2x4L2ZC?=
 =?utf-8?Q?/zO14cxo+TiIBkb1FgZe68DAW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657e5a46-ca75-4a5e-5ecf-08dafae7507b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 13:07:42.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJNdgtjkQ7HedEFPqZE37on2jAa8Zdnzb99+VQTsBNgpPJgyEI2wxRcv7lG5xMCV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-19 20:24, Michael Strawbridge wrote:
> To allow further flexibility in the Git hook, the SMTP header
> information of the email which git-send-email intends to send, is now
> passed as the 2nd argument to the sendemail-validate hook.
> 
> As an example, this can be useful for acting upon keywords in the
> subject or specific email addresses.
> 
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
> ---
>  Documentation/githooks.txt | 27 ++++++++++++++++++----
>  git-send-email.perl        | 46 ++++++++++++++++++++++----------------
>  t/t9001-send-email.sh      | 27 ++++++++++++++++++++--
>  3 files changed, 75 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c..0decbfc92d 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -583,10 +583,29 @@ processed by rebase.
>  sendemail-validate
>  ~~~~~~~~~~~~~~~~~~
>  
> -This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
> -the name of the file that holds the e-mail to be sent.  Exiting with a
> -non-zero status causes `git send-email` to abort before sending any
> -e-mails.
> +This hook is invoked by linkgit:git-send-email[1].
> +
> +It takes these command line arguments. They are,
> +1. the name of the file which holds the contents of the email to be sent.
> +2. The name of the file which holds the SMTP headers of the email.
> +
> +The SMTP headers are passed in the exact same way as they are passed to the
> +user's Mail Transport Agent (MTA). In effect, the email given to the user's
> +MTA, is the contents of $2 followed by the contents of $1.
> +
> +Below is an example for a few common headers. Take notice of the

"example of" not "for".

This maybe clearer:
"An example of a few common headers is shown below. Take notice ..."

> +capitalization and multi-line tab structure.
> +
> +  From: Example <from@example.com>
> +  To: to@example.com
> +  Cc: cc@example.com,
> +	  A <author@example.com>,
> +	  One <one@example.com>,
> +	  two@example.com
> +  Subject: PATCH-STRING
> +
> +Exiting with a non-zero status causes `git send-email` to abort
> +before sending any e-mails.
>  
>  fsmonitor-watchman
>  ~~~~~~~~~~~~~~~~~~
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 42f135a266..0e595d6ac5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -785,16 +785,31 @@ sub is_format_patch_arg {
>  	push @files, $repo->command('format-patch', '-o', File::Temp::tempdir(CLEANUP => 1), @rev_list_opts);
>  }
>  
> -@files = handle_backup_files(@files);
> +if (defined $sender) {
> +	$sender =~ s/^\s+|\s+$//g;
> +	($sender) = expand_aliases($sender);
> +} else {
> +	$sender = $repoauthor->() || $repocommitter->() || '';
> +}
> +
> +# $sender could be an already sanitized address
> +# (e.g. sendemail.from could be manually sanitized by user).
> +# But it's a no-op to run sanitize_address on an already sanitized address.
> +$sender = sanitize_address($sender);
> +
> +$time = time - scalar $#files;
>  
>  if ($validate) {
>  	foreach my $f (@files) {
>  		unless (-p $f) {
> +		        pre_process_file($f, 1);
>  			validate_patch($f, $target_xfer_encoding);
>  		}
>  	}
>  }
>  
> +@files = handle_backup_files(@files);
> +
>  if (@files) {
>  	unless ($quiet) {
>  		print $_,"\n" for (@files);
> @@ -1043,18 +1058,6 @@ sub file_declares_8bit_cte {
>  	}
>  }
>  
> -if (defined $sender) {
> -	$sender =~ s/^\s+|\s+$//g;
> -	($sender) = expand_aliases($sender);
> -} else {
> -	$sender = $repoauthor->() || $repocommitter->() || '';
> -}
> -
> -# $sender could be an already sanitized address
> -# (e.g. sendemail.from could be manually sanitized by user).
> -# But it's a no-op to run sanitize_address on an already sanitized address.
> -$sender = sanitize_address($sender);
> -
>  my $to_whom = __("To whom should the emails be sent (if anyone)?");
>  my $prompting = 0;
>  if (!@initial_to && !defined $to_cmd) {
> @@ -1214,10 +1217,6 @@ sub make_message_id {
>  	#print "new message id = $message_id\n"; # Was useful for debugging
>  }
>  
> -
> -
> -$time = time - scalar $#files;
> -
>  sub unquote_rfc2047 {
>  	local ($_) = @_;
>  	my $charset;
> @@ -2101,11 +2100,20 @@ sub validate_patch {
>  			chdir($repo->wc_path() or $repo->repo_path())
>  				or die("chdir: $!");
>  			local $ENV{"GIT_DIR"} = $repo->repo_path();
> +
> +			my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
> +
> +			require File::Temp;
> +			my ($header_filehandle, $header_filename) = File::Temp::tempfile(
> +                            ".gitsendemail.header.XXXXXX", DIR => $repo->repo_path());
> +			print $header_filehandle $header;
> +
>  			my @cmd = ("git", "hook", "run", "--ignore-missing",
>  				    $hook_name, "--");
> -			my @cmd_msg = (@cmd, "<patch>");
> -			my @cmd_run = (@cmd, $target);
> +			my @cmd_msg = (@cmd, "<patch>", "<header>");
> +			my @cmd_run = (@cmd, $target, $header_filename);
>  			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
> +			unlink($header_filehandle);
>  			chdir($cwd_save) or die("chdir: $!");
>  		}
>  		if ($hook_error) {
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 1130ef21b3..8a5c111a24 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -540,7 +540,7 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
> +	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch> <header>'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual
> @@ -559,12 +559,35 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
>  	test_path_is_file my-hooks.ran &&
>  	cat >expect <<-EOF &&
>  	fatal: longline.patch: rejected by sendemail-validate hook
> -	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
> +	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch> <header>'"'"' died with exit code 1
>  	warning: no patches were sent
>  	EOF
>  	test_cmp expect actual
>  '
>  
> +test_expect_success $PREREQ "--validate hook supports header argument" '
> +	write_script my-hooks/sendemail-validate <<-\EOF &&
> +        if test "$#" -ge 2
> +	then

There appears to be an extra indentation of the "if" statement.
-- 
Regards,
Luben

