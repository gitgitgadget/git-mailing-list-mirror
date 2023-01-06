Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A64C61DB3
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 22:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjAFW1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 17:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbjAFW1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 17:27:24 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F9E85C90
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 14:27:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnFbqo1k+NxcDR+1LantZn3ppOJ/ePDlq9wF+SNJT75giF/ofHO5ZEUwk1dPLH+MZIDEg1b6qvzyzATCm2Uf4oqW73ZQpAJYbhOhI0yRv5rq4LLQY0cMTYMzo+4XVDUEl3sfUW2AkuY4VhI4o8GZ8reMoruWjYDqyCU9LVhvY6t48CWa0OROARam6N/nP6t82Y5D86KQt/Ur0NJFxVNzMwdKS4FZzPU+9Ab3qHDRQYrX1aUOpo/nHAHWUyl/zt9RwJSS+60xn2VReFSX+IX1o3v8rSIUbHr48tZCmEq4A8qmHPxpqbRUZekoqIU8AjKhRjIm82jtdsMN10qEdwseHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPjKazI4cS0MGbsaJKULI4/HQLXTFM17k74/FQ4iCII=;
 b=kuayk+f3ytysjtSqiXQhTdMbTSE6QEQ2sCq5T6Qk1MMKvjH7/iIVE9sav8wqC4/kmg8n7KXCnjwYaOZMMIP9yn5UESxWhKKS7Z+aWX2LpXWDkEiC6J9oIlWZfNr1eEDX2VHXoWwGQMBPMGY42WMPakUi8+g5xF6EvlTlYBHq2ql1VKVlUThXAQzP1+9acgh7KQDpb1fZvC9j/HSG/l6ZjMX8fL/eeiJCUXa3CNgpZWsWkYu6mcm35jRVokGr6rherVOCDlY1I32589acd5rACnJuZx2bAH6SKzEGQKE9LsWRVlBIbyG9EsbD1Y4W5kqBAElurY8PwYJasdL8CzkWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPjKazI4cS0MGbsaJKULI4/HQLXTFM17k74/FQ4iCII=;
 b=oTA5hQbIQmCMrY4LyzR8QJoO6q1hWRZUX1ahr6m/Rm+Kc7WDXioidIFf9QxQNQ6kZFv/RSpM7TyWJvWZUMEqnOOu6422260ZhhJis8NVF3J11FgDbFLF1J3/MoEx1+Z/KwC0YTZchCVKR3wwf1nocUuM5P8W+WZDbxb+zx0AD3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 22:27:21 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 22:27:21 +0000
Message-ID: <f6027f18-b0d9-8aee-3f9e-0ac91bb86e96@amd.com>
Date:   Fri, 6 Jan 2023 17:27:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/1] Expose header information to git-send-email's
 sendemail-validate hook
Content-Language: en-CA
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20230106215012.1079319-1-michael.strawbridge@amd.com>
 <20230106215012.1079319-2-michael.strawbridge@amd.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230106215012.1079319-2-michael.strawbridge@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0092.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::27) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: d16351bc-e87e-4cb9-b937-08daf0352d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAxI/JnLaGBQ9lwuIdCcoVr4ne+I4hPc8rv8snflpDDiUWizMwhTZNqqaMG17y5tJIAU84CHUIpnKFt4kammF4HfOvPZvmG/dWHvMwHWL/kAv0XfkDXM7Cu10h4094Mw8A+3OhkxIwYEqqTWOZaa9B/rjrR2tJ/l4Ric3dEh9KaLwucM+BYCR5ExP+93ZfFFyNsE+bnEel7kcXmwJKwePLipCnq7s3pKis7Fsr0ckzG6ftZdTfATfAO60fd5FUN4qtjypzW2BmK1rs2sSrtOOvWqDDw5hwE0lm7oUlkv+ASiLIPaPGTpWso6S+41mQYIKZIiFteyCfM75VXayUPRkllBFWmROcHoePRTr9VnGGG75mSwM8YQI3Y0N0SFY4Ohwz8RP12DYQ0U+e1FcoqIxDuEPReXL00Pct1beCSVvHmE1G+BePfK6h+X6MXULxJWD0Jwe3yYmDbLf4pfPv2qaAPa0vOhFemlOHHYT5OQAf6jXL6gx1k7+PrZ4KdN90oIy2aFaHM47RxPT5/ssL6x94BUVqCWJBZXxuIeuma5hVZH0NqPzBVFpbxi1npLRxfDl+dWpVuy1CXu95+0gebs5qG9gDYFDJa6i9EmiH3PchOclzV+n5LaJq/OIKmmIlKahb08IAUvUM67gLyaX3+S6CaFNRKgc26jxbloEbsyNckTToAdEnY5kTlzd7dBAgZoPP3d+odS7L8lKuRr0SAgwGISIV7QG6g6qfx0/KXdQJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199015)(5660300002)(41300700001)(8936002)(316002)(8676002)(4326008)(66946007)(15650500001)(2906002)(110136005)(31686004)(66556008)(6486002)(6506007)(44832011)(53546011)(478600001)(66476007)(86362001)(31696002)(186003)(2616005)(6512007)(26005)(83380400001)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTNoamF0SEZ4NDNIUjdUdFd0K3VaTHJleitFNWhmb3BIc1p0dGFOZkpmM1ZK?=
 =?utf-8?B?aGxFSmZsZkNBeER2MEtsdG1KTEozaHRhYldWdVl3d256K0tSSmVoUFcyMERs?=
 =?utf-8?B?UU16cnFvMGhDTFZwY2ExTHNFQnIyeGRBWFlQcmpPS0trbTVud1VyNDdRNUJl?=
 =?utf-8?B?UFhDT1hZbjZJMVJFWE9sNUExSFhKcngrUndLd2dxT2JJbzhrMEdPTlJLWW1I?=
 =?utf-8?B?YlhEenhUVnMxcTl5WEpUeFp1R0xJQ250eUcxdWhqRTBSZzZ4aEtHbFFQYnVZ?=
 =?utf-8?B?cGVtcjBzZldQOVAzNWFYZ0JiTy9xd3VnM2t0SzMvdDJJKzBHcGxpbmh5Sjlj?=
 =?utf-8?B?SldPekt4R2V3UnRHdTZ1ZldGTkVJOUI3ZDVob0kzNWNoMHNzVGVIUzNBSVBN?=
 =?utf-8?B?dGRSSFBnRDVsMmZVZGEzdEl1S2ZNSlFZUmJvcjNPdmVxUWlVSmlSUnBnc2dO?=
 =?utf-8?B?YS9lQko4cHBFY0dkQ2Y3UGJjeDc5QlZGQ0RYUU1pVGJ6Q1F6MU9aUVNNdTBL?=
 =?utf-8?B?bEcwdjlJK2FjaXRaaURaL2w5WE12Q2RlaXJ1T3piQnlKaXNLbFVhZXR5MHZ3?=
 =?utf-8?B?SWR4M3F6dm1JVFhCVjU3RHhLRWJlaUdiRnFsYVU2Z1FwZEpvaE9ncVpIY1Rh?=
 =?utf-8?B?K3hzMUJNVTNoM0hMbW5aUkswOWMrVkpWS1NXa2plU1F0bCtrcXlsc3BUOU9F?=
 =?utf-8?B?WnpHaTNiemFmVmlDbXFwTm1JRkdjMnZhVFBhYkgvdnhLeitad1VNK0xBZnl1?=
 =?utf-8?B?dUtjOFNVaWNLTlNSY0FTblV3N3JaUERlMFFERDB0aHlramNVWUNNZ09VOVMx?=
 =?utf-8?B?V2JueWx1Q21uY1ZMNGxoZnd2SU40amt2Vk5XUUUycGlneWU1d1RhRVAyZGZj?=
 =?utf-8?B?dlhNdmdDdUVMd3hsTlNEamR3U2J4T0gvZTVCR2ZLUWIvNXRvdmJxbEc2cEZW?=
 =?utf-8?B?NXNCWWdwaWlMdnAvZGt2S0xBemVESzFQSncySGtrc2tTZW0xKytBdkxZNHQr?=
 =?utf-8?B?MEJWRWpCL21VZVpHRDNvRTJRL0VwbDdnTmRvR2UyME83R2dxQXJmOTVKTlda?=
 =?utf-8?B?bkZyNWZRbG5TdlJhS21zRUVZaEsxQkNNaFE1OEpUOW9GKzd5NTdUaDIxUmk1?=
 =?utf-8?B?SlFCL1YwVC8rYXNPN1MyaGpXM2xpczFUbEFSNGxQdXhXZnVRbmhWZDNacXVR?=
 =?utf-8?B?Ui9pWjlOcjB3Y24vT2YyTlhaSDJ6YlRQa1luSHcyUUhBbU51THFvaDFMMDFP?=
 =?utf-8?B?ZlZHV3VPVDJEcmxEQ2RBSFpYMGVTSVF1bjJNVEtKTEJWSCttdnRtbDFwazdI?=
 =?utf-8?B?dWVuZW9pcWlQQkMxUSt6TWlXUk5vSGtsRVhhQnY4ZTFIS1RCVmE1RVN0Yms3?=
 =?utf-8?B?R0FYajZqYW9tcS85bDdzaXJ1Q1ZuQUlWSW92dHMvdW1xeE8wMjNlVFI5d0tL?=
 =?utf-8?B?bTZzRytscGlWWnkxRlBhYXI0bU9wN3B5eU4wczZIRDdxQk5YUjg0ZnoxR1BH?=
 =?utf-8?B?dk90VTlQTWN6c2xhN21UT0haNitFaEIyYWRSdi91Smx1cVlPY0piaEhqSUpS?=
 =?utf-8?B?ZVZCTDJ5OVI1ODArUi9kNGNDS01VYmd4ZG9NYVlPNG5tV0UvQ2NCNjl4S0VJ?=
 =?utf-8?B?bFBQbjlVamtDNEl5TDJwWWVoNmNockdRd1Bib1ZuWk83VUVoSXFFR2doRDhh?=
 =?utf-8?B?K3d6MTRJWjhvNU1PZ1ZmUmNoRHZsUTRmazJmOTd0b29vQy82YXQ3UlErQUFj?=
 =?utf-8?B?KzN3ODZ1dWM2NG1zMmRrS3VBMkowZlVwTTZ1MEQwbE0xOENVWW5vQW8vWnF6?=
 =?utf-8?B?MWJXcTQ1VVlyWVFsNjFKaWdSb1VaVWdOUGNMYUU5b0JvR09JM3JJSmNMZU5Z?=
 =?utf-8?B?a1Y2Q0xoQkNJYnAwd2N1NXprc0lwMzlwcVR5Z1ptMUFFeXBQZXl1R0JLU1hK?=
 =?utf-8?B?b29MS1Q5aDVzQ3E2RFpUVERmTW5NRDNYYmVja0FKR2xBTlRaR2p0ajNkenEy?=
 =?utf-8?B?T0ZoTFArN0tsZGpBOGtTZjZRNlZteWpBajdhdWJGcXFMK0t4bnQ1ODE5aXpC?=
 =?utf-8?B?bnBoTVF1aXN4REhxcDJiREV6ZGt0ZVBMQnNPa2h1cEQ1NnlGL2xKWU9USktZ?=
 =?utf-8?Q?7xd48h2dfpNr892hdUFiofUmh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16351bc-e87e-4cb9-b937-08daf0352d62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 22:27:21.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TdgxLvOVbVxqmn9h0ddBhO5f3tMRXLL2wO6ry4I+zc8tzUP8loCiG8j0pfQ6W8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks good to me.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-01-06 16:51, Strawbridge, Michael wrote:
> To allow further flexibility in the git hook, the smtp header
> information of the email that git-send-email intends to send, is now
> passed as a 2nd argument to the sendemail-validate hook.  A new t9001
> test was added to test this 2nd arg and docs are also updated.
> 
> As an example, this can be useful for acting upon keywords in the
> subject or specific email addresses.
> 
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
> ---
>  Documentation/githooks.txt |  8 +++---
>  git-send-email.perl        | 55 +++++++++++++++++++++++++-------------
>  t/t9001-send-email.sh      | 25 +++++++++++++++++
>  3 files changed, 65 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c..346e536cbe 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -583,10 +583,10 @@ processed by rebase.
>  sendemail-validate
>  ~~~~~~~~~~~~~~~~~~
>  
> -This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
> -the name of the file that holds the e-mail to be sent.  Exiting with a
> -non-zero status causes `git send-email` to abort before sending any
> -e-mails.
> +This hook is invoked by linkgit:git-send-email[1].  It takes two parameters,
> +the name of a file that holds the patch and the name of a file that holds the
> +SMTP headers.  Exiting with a non-zero status causes `git send-email` to abort
> +before sending any e-mails.
>  
>  fsmonitor-watchman
>  ~~~~~~~~~~~~~~~~~~
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5861e99a6e..5a626a4238 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -787,14 +787,6 @@ sub is_format_patch_arg {
>  
>  @files = handle_backup_files(@files);
>  
> -if ($validate) {
> -	foreach my $f (@files) {
> -		unless (-p $f) {
> -			validate_patch($f, $target_xfer_encoding);
> -		}
> -	}
> -}
> -
>  if (@files) {
>  	unless ($quiet) {
>  		print $_,"\n" for (@files);
> @@ -1495,16 +1487,7 @@ sub file_name_is_absolute {
>  	return File::Spec::Functions::file_name_is_absolute($path);
>  }
>  
> -# Prepares the email, then asks the user what to do.
> -#
> -# If the user chooses to send the email, it's sent and 1 is returned.
> -# If the user chooses not to send the email, 0 is returned.
> -# If the user decides they want to make further edits, -1 is returned and the
> -# caller is expected to call send_message again after the edits are performed.
> -#
> -# If an error occurs sending the email, this just dies.
> -
> -sub send_message {
> +sub gen_header {
>  	my @recipients = unique_email_list(@to);
>  	@cc = (grep { my $cc = extract_valid_address_or_die($_);
>  		      not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
> @@ -1546,6 +1529,22 @@ sub send_message {
>  	if (@xh) {
>  		$header .= join("\n", @xh) . "\n";
>  	}
> +	my $recipients_ref = \@recipients;
> +	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header);
> +}
> +
> +# Prepares the email, then asks the user what to do.
> +#
> +# If the user chooses to send the email, it's sent and 1 is returned.
> +# If the user chooses not to send the email, 0 is returned.
> +# If the user decides they want to make further edits, -1 is returned and the
> +# caller is expected to call send_message again after the edits are performed.
> +#
> +# If an error occurs sending the email, this just dies.
> +
> +sub send_message {
> +	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
> +	my @recipients = @$recipients_ref;
>  
>  	my @sendmail_parameters = ('-i', @recipients);
>  	my $raw_from = $sender;
> @@ -1955,6 +1954,15 @@ sub process_file {
>  		}
>  	}
>  
> +
> +	if ($validate) {
> +		foreach my $f (@files) {
> +			unless (-p $f) {
> +				validate_patch($f, $target_xfer_encoding);
> +			}
> +		}
> +	}
> +
>  	my $message_was_sent = send_message();
>  	if ($message_was_sent == -1) {
>  		do_edit($t);
> @@ -2088,11 +2096,20 @@ sub validate_patch {
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
>  			my @cmd_msg = (@cmd, "<patch>");
> -			my @cmd_run = (@cmd, $target);
> +			my @cmd_run = (@cmd, $target, $header_filename);
>  			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
> +			unlink($header_filehandle);
>  			chdir($cwd_save) or die("chdir: $!");
>  		}
>  		if ($hook_error) {
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 1130ef21b3..11e68f9c18 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -565,6 +565,31 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success $PREREQ "--validate hook supports header argument" '
> +	test_when_finished "rm my-hooks.ran" &&
> +	write_script my-hooks/sendemail-validate <<-\EOF &&
> +	filesize=$(stat -c%s "$2")
> +	if [ "$filesize" != "0" ]; then
> +	>my-hooks.ran
> +	fi
> +	exit 1
> +	EOF
> +	test_config core.hooksPath "my-hooks" &&
> +	test_must_fail git send-email \
> +		--from="Example <nobody@example.com>" \
> +		--to=nobody@example.com \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		--validate \
> +		longline.patch 2>actual &&
> +	test_path_is_file my-hooks.ran &&
> +	cat >expect <<-EOF &&
> +	fatal: longline.patch: rejected by sendemail-validate hook
> +	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
> +	warning: no patches were sent
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  for enc in 7bit 8bit quoted-printable base64
>  do
>  	test_expect_success $PREREQ "--transfer-encoding=$enc produces correct header" '

