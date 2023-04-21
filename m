Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822DCC77B75
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 05:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjDUF1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 01:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDUF1x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 01:27:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57271524B
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 22:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv4x8jPcgiBPtbLbwCvvZjccrXw8hUbLTZg2PK+DVTFujW4y/7Lgpt4nUTnvby8YCU37WPJoP+Cq8BSJEtJNMA0mY1Ahl6plEpkMaVThqC3sUQxAo7X3Ou1cr/zIeGlkVOJfahKE5LmXAk9RuJKJcDiXYDSRr+1/N3xmsBoVnVBAyeYAcTpE/1LdrRNW9xwXhPw/N8Uzs4/7NXEtcWrJ1rKD5C/Fn8lKVao7knjg1duXOyyyaRlGvoWb0Ugh+IZlnPs5gjFeuA69G/kgka6ltxSEPpn1gQLm8BQlE0mFJkdGs7MMOUr5t5kjG09d9PTdhHz0mSPCacYSuWAVjGGBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWdodsXQh/iZmjbZVsblT3iujvWn7zJAVASPLtDb0WU=;
 b=Isf41MfFi95NIB9VJhZs3pZ1J36Ac6lQT89GIaaS5JOpW0gzHThfUORG470SCfTCbC4XK0XOqOefw7XCvhDy4hNwLY65LNBtq2beQ2KTF3JggF31rhdaAuPI9mes3l4Oxde7+Cm0T+fcaO8CeIEx1kgd16UpAsbpBnDxK/QB3ZroP9jwwTq1L1vnymwavAZtPAUuMLbeOPDInlO+FLxpDSldJoHm4BiIOFPrS2ILrkQqZ64pLne8t4Fm8BsuvV/PYDrJ94boPQ9C7BdZ6HK6eK1rZ6XtuodFz4UlMU1o+f4fl8C0ijXBazI7tbo+gwGBMTJKJqRtnlX4jMao9VLPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWdodsXQh/iZmjbZVsblT3iujvWn7zJAVASPLtDb0WU=;
 b=ULKzAxtrCtAMCDFzcoWK1rNrkXq/IPzsNjYWK3adz7s7JE318JI+r+wprlm9mMRWSh9er3dPPoCilCVNUrRnF3liPY2ujR+qc3Gdsh0uP6QeBxrmMBNdHrGXoDYbeSvtgjmJvx+NbxftcUnjCSnLAQduXrQamh5LRpT0/X13yz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 05:27:47 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 05:27:47 +0000
Message-ID: <4da10b6c-a1ce-c0f7-4b54-3a032b437e54@amd.com>
Date:   Fri, 21 Apr 2023 01:27:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-CA
To:     Michael Strawbridge <michael.strawbridge@amd.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230419202703.2911836-1-michael.strawbridge@amd.com>
 <20230419202703.2911836-3-michael.strawbridge@amd.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v10 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
In-Reply-To: <20230419202703.2911836-3-michael.strawbridge@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::11) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9d9d47-3754-427c-5997-08db4229241d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQZVDueAFxge4jV9N++B3P5f9uV0wibyOI41MYTWciuBT9QTp7To58y1L1UsG3Fk3WFX69xYHsU9O1mGsASUMgpsYbLeOaUegFRXhRBfPDg6Uf9EtDgTmvWt7+g/DTrVx+FXuU4ucOI+ZacM5LNRmsnrYEwSEWJ2ATyvbdrcdnel7BK/5GSGxDq3akcMj3g4paX4dFsgqQ4jJbKlR/huUpGxJPMmUyp91x0B2PbL3m5cPbRL6d67dQZ7rRC5l59h6x3wqdZKNkuRen6UvsoGAc+lffiPRMIDG70qc+Hw3ZSTmqeUSTrQ+4RhkASK9f3Tm5kSXyFSSUwDiFNQtnVNZMGyeemNMPqIrHEXORotEjbY3gOj5q3O5mbOFvCDWX6tyHEvWcrcZBZ7a9d1c/THlh5rBbJmI6eWeJR5ihO4vQkJ8ciddZPJnhViWrie/ljO0grgHmYjzaCuFZ6LU/hpAdEjl1Iq+mgK+bknDpYnjdV8np/wm2ZfaCgPAQvVDBeuOnTeb2QYYD1P78B7YIon+Lz96YnEeaD9KmpXi1JJLQEX5wGgDGqQAe+zRfQqWrddRfncnxVsxvdI5hOhyMPyqKJYmnyq7EpXuD1MSue4g9+OC4wieLKQM4ro66LhxbzElDQExQ6oYC827eYgwnLehQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(5660300002)(316002)(41300700001)(4326008)(38100700002)(8936002)(8676002)(31696002)(15650500001)(44832011)(86362001)(2906002)(6512007)(6506007)(26005)(53546011)(6486002)(2616005)(83380400001)(66574015)(36756003)(186003)(31686004)(66556008)(66476007)(110136005)(66946007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RldhR1V1YkROZExTcTZoK3p6YW9KYmhlWlMwbG5rMmZNZlNCSllsTkxkWERh?=
 =?utf-8?B?TGF3Q2tPa2JJOFVuNktWTlNTM2lKODBERUVqU2FjbUk5bEhlMGs4aHEvLzAv?=
 =?utf-8?B?T0xnK2pWN25VcXBNcXhvQ0QyL0lpQzIyYjNEdzB0TU1VQThvZGdhVUh5NHQ5?=
 =?utf-8?B?ckZOS21UWUE0b2xOWFhhVytWWTBnVDlpb1FaN1VXSXI4S3FWbjdLSm0zdm9C?=
 =?utf-8?B?d0p5NG5IeU1JeVpvcm1KVUh5TEZPMGhqTU9JRkJ6NlZuK3BHYVJFWjNGQSs2?=
 =?utf-8?B?V3NSQkh3QnV6eEhYZDJQY1J0czQ4Sm13cHhLOGVRSTVYTE1JV0V2M29nRnZZ?=
 =?utf-8?B?NElqcW00S2J1a3JNNHpZVGlVQ1h1UGU3QnVqUHc1eUQyb3NwQnBBRVVTR1o0?=
 =?utf-8?B?bW9Nck1jKzZxZzI5Z2Rwb3EvdUFiWldwcHk0dGpDTnVKS1IwR3Z0OWg0YjFJ?=
 =?utf-8?B?MlRMcUdvbU1YeFhGMlZkOHN4SDVGTnQ5ZFFtUjRXOFhiWE5TYjhmQ2xvdEJu?=
 =?utf-8?B?cUFNbXdjY2t3UUJadytMVXFXMHF1QVZURWRoT0FSdjRCcnpaYlFmekxDOHZq?=
 =?utf-8?B?aGF2NFUvNXBVV2ZGdWl4Y2x5UlJWRE5HdlRHd2grT0RtRThLaUVJdzhMZHoy?=
 =?utf-8?B?a213dVh4SVVoOXgxako2SmJBc3M2eFFlNWFXUFplV21KVi9ZUXR1ekhKZklI?=
 =?utf-8?B?V0dBYVpJZHZOUm5sREk4NjdPZlQzalU4b0E0a2t3L0lmUHRkT2pYbnQ1aEsr?=
 =?utf-8?B?U3ExSVJyR0phcWM3ZWgwS2RBcXhHaGJ1ajdCS2ZpbmVmQ0xlOFBpcmRRWGM4?=
 =?utf-8?B?ZW5iZWpQbTRqSkFmVkpac2lpSGdlTDRoQjQ5eWFJajdLZlJYdlpacENreTdL?=
 =?utf-8?B?VCs3Nkc0aHZScmRXZ0JYaGZNc1RTNGVHdkg5NG5WM1RraE44ampjT25rbWp2?=
 =?utf-8?B?YW1IbEdMZEpQdjRrbk9IZURKOEdubHRnZ09IeXdyQkxiVkxPcDRyUkRmZlhS?=
 =?utf-8?B?cXYxYTVFZkxuZVArZUxsTEdwdGxVUTl0YytnQXI3V3JtQ0d0c1pMdFJKZFdp?=
 =?utf-8?B?ZEp3enllckdYZGxrRCtGYkFZRlpGaGNqVVdDTEtsOHpVc0J3anRpVklRVGpN?=
 =?utf-8?B?YXBlY3RJc1M1MzUzbnJGNjZNYlM0ZWVvY2FLa1F4Szc5OGhwTi9jcGlRM2xp?=
 =?utf-8?B?b1d4SGptWTBLQWhPR1g2QW1SdVRsOE4vU3kwaUxGbTQrKzF3VEpHczNyM0Mx?=
 =?utf-8?B?Y0ZYc3hZbzNlOFBKVG1vRWN3YnMrYXNPTzBUQmZzN2svMTZ1MzZUUEk0aUV6?=
 =?utf-8?B?V1RqbGNISHBGalRvZUxvTTJPTlpiZkoxVkhuazVyc3E3cGRsS3VDelN3Q3Mz?=
 =?utf-8?B?eDR3TjdNRDBYcUROZFNNOWlSV3dvUUl4blZDOE1sRkczRHN1Z0N2SFFOMWV5?=
 =?utf-8?B?VmcyY1NhdEFIVThBZFk3dis1UnRwSFlMUjFXNHAxRngzWldwOWRSMkE1N1pV?=
 =?utf-8?B?Z0lmb3lkZWRDMHc0T2wyc1NOT0ttNXVjMXVSSnIwMkJEQWNmbnFLamh5WU1Z?=
 =?utf-8?B?VllpRVltQVhieDJXSVJyTUc4VXNpRFZyTlBXNGJYZm9UbTBrRy84SzY2WlBI?=
 =?utf-8?B?OUlxanpJSkVHUWVmd1ZidjFDUHk3SXpNZGl3LzlXOTZYSUxjRHEvUFl5ZXNY?=
 =?utf-8?B?UHptSHBUSko0ZGZiU3FpZVlXY2R3QTRjV0FvOUc5VXcvUlp6MmdtUHMxcjE4?=
 =?utf-8?B?NFpRTGZqMGZSTzZWTnpqMzIvbjBDRWFmbHJ2SUdEbTN4OWJ2M3U2Nko0OGxq?=
 =?utf-8?B?dkNoWEpiYmdoY3hLR0NXSHZuNVkwVDZ5TGtEdCtCS1c2ekNVYUxWc3NseDY3?=
 =?utf-8?B?TGlCRTYxQXFsZVdwSmEwNkFhS015ZXU5TWpFOFRhTjNVeTJmdEptRm1URC9B?=
 =?utf-8?B?ejd3TFFFMitVaTh2TENIdHBqZFovUjkyWDdQZ1poUTVFb21tVlB6QlhIMEE2?=
 =?utf-8?B?ZGxzSmFISU1FaVY4L2NOb3p3SVpqZDVpM3JlYytlS2dLU1FXd2NSdXVET2d3?=
 =?utf-8?B?WnYwemJFRmx0aUV4UlRFeUNaeHI4Q1o0azZxaDltMmVVczBUZUpYdzhSdkdS?=
 =?utf-8?Q?c+Ri9AAr2tVseAFPzDcsUFqF+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9d9d47-3754-427c-5997-08db4229241d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 05:27:47.1805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: of/ZhQkN41qoOuaKnI2f57wLutduPLcE5gZ0+jbqSQXOGYjGx2F5oWyLRiMY9Hpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-19 16:27, Michael Strawbridge wrote:
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

Thanks for posting this Michael. Perhaps this should be pushed now.

Regards,
Luben

> ---
>  Documentation/githooks.txt | 27 +++++++++++++++++----
>  git-send-email.perl        | 48 +++++++++++++++++++++++---------------
>  t/t9001-send-email.sh      | 27 +++++++++++++++++++--
>  3 files changed, 77 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 62908602e7..9896ffafaf 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -595,10 +595,29 @@ processed by rebase.
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
> +An example of a few common headers is shown below. Take notice of the
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
> index 0a44c0e5cb..a3bc7b33d4 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -792,16 +792,31 @@ sub is_format_patch_arg {
>  				    @rev_list_opts);
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
> @@ -1050,18 +1065,6 @@ sub file_declares_8bit_cte {
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
> @@ -1221,10 +1224,6 @@ sub make_message_id {
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
> @@ -2108,10 +2107,21 @@ sub validate_patch {
>  			chdir($repo->wc_path() or $repo->repo_path())
>  				or die("chdir: $!");
>  			local $ENV{"GIT_DIR"} = $repo->repo_path();
> +
> +			my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
> +
> +			require File::Temp;
> +			my ($header_filehandle, $header_filename) = File::Temp::tempfile(
> +                            TEMPLATE => ".gitsendemail.header.XXXXXX",
> +                            DIR => $repo->repo_path(),
> +                            UNLINK => 1,
> +                        );
> +			print $header_filehandle $header;
> +
>  			my @cmd = ("git", "hook", "run", "--ignore-missing",
>  				    $hook_name, "--");
> -			my @cmd_msg = (@cmd, "<patch>");
> -			my @cmd_run = (@cmd, $target);
> +			my @cmd_msg = (@cmd, "<patch>", "<header>");
> +			my @cmd_run = (@cmd, $target, $header_filename);
>  			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
>  			chdir($cwd_save) or die("chdir: $!");
>  		}
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 323952a572..e8c96d0d4e 100755
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
> +	if test "$#" -ge 2
> +	then
> +		grep "X-test-header: v1.0" "$2"
> +	else
> +		echo "No header arg passed"
> +		exit 1
> +	fi
> +	EOF
> +	test_config core.hooksPath "my-hooks" &&
> +	rm -fr outdir &&
> +	git format-patch \
> +		--add-header="X-test-header: v1.0" \
> +		-n HEAD^1 -o outdir &&
> +	git send-email \
> +		--dry-run \
> +		--to=nobody@example.com \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		--validate \
> +		outdir/000?-*.patch
> +'
> +
>  for enc in 7bit 8bit quoted-printable base64
>  do
>  	test_expect_success $PREREQ "--transfer-encoding=$enc produces correct header" '

