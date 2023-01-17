Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59859C6379F
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 03:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjAQDjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 22:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjAQDi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 22:38:59 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0061F23652
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 19:38:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVQCRp1WpMaQ9AnOhkKDPIwRi2SB6ebfZbP1N7JPIXmOyx43ZUu8VFGW1cBgD0LaqEWmWVGn8TBNIrJjNSB83/Z6oHWYq+ctDVISP548aRbSMmpQhKZraMSZbieknLaguZucbDX91ak0bnCsGpQfun7xuQJKj/VyZE1C6oTG/xg3B8HL7iAxtRSeX/8PEVrnpM78ss8Xf3ojUb/2EPdRdmfc2I+Hirf3kFZpVOYmnBHReeW0+b1glA4roQsQCj2QCjSrPpVoXKCSf2YWWRgfFQrQUXh6H/8/KLMpFVNWoQWZoohiUBUj3PyCV1figpvAtzS2uxrOshL9nAKmlootYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPw1ccMZCd/nLz0QCqOllc1oLQGZJt9/WROXaLbLZwA=;
 b=iIl2c7xZ+DSmyM5qaX6jW2k7tTRy8Scdj3Ryuz8blRmVIdD9IiCrSS2G1rnPluitgknkIuVnjE8blCugOYs/7uH6VM0ZHgMTirXYpfiRCHPGYjnLMBoPrqH8cjkuFZyFCKgDtmRx6KqGlXiGiuEx5WnvtoTyMZ9BwpjHdnh1K4tgr6yo3bVr6J4ps4l9kvDEqs/QcT+pY3r+1dxrG9vUbRwywinXikNICkLQHvxiDE7clyB9vAnbvovqw3NJ11FuTKEWunIGNk5FBWrhvgDGqzgritUeEeFdNRTIN3dF03QnmhrHB15K86ki/Gu4G7cn2+vIAgM3tm5U36NVzF8zLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPw1ccMZCd/nLz0QCqOllc1oLQGZJt9/WROXaLbLZwA=;
 b=wUN4dB4Sc/it5ycDTGecJcBALyztLae2XSIewR0A4uxCMkHX5cjQpw8SsRowUPn9SoFA87H9SB1AojjOMTNQwgKVVLPX2TxuHwPeN2Ad98fR1RD/VpscX/7ARdsowhTKwnf8mRCaJxddO/fMiiKtBUfFAKzCKGz51ETw6TO3gQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Tue, 17 Jan 2023 03:38:55 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 03:38:55 +0000
Message-ID: <045ef69a-607c-7644-9790-0af367109b5e@amd.com>
Date:   Mon, 16 Jan 2023 22:38:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 1/2] send-email: refactor header generation functions
Content-Language: en-CA
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230117013932.47570-1-michael.strawbridge@amd.com>
 <20230117013932.47570-2-michael.strawbridge@amd.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230117013932.47570-2-michael.strawbridge@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 266e9d95-3fd4-48b8-16af-08daf83c5be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wojxXKMjW1phusUZ23j/kfDBNdTInhRDD7Z6TQNsTkYsQpAfWQ30l+PHw8RO1b53TzVtW9AYRwesUO5z8KN1E6068yVXFoQL7/T7NwFFBkxexXCHCQTgLZO9VTb4GnzrWWGlNmjUh8lKQf9uXPSs9fCesaYxKH4ungn8THDGdbnIymsEXuKDDEymbf68JOem4kJDNou3W97GE0V3KintF3Z07i83HFnYAv2o5xAnBymnq+3SpWab/tYdjrq6NC/vRRQU2wZJpEecI8JK7xTs5RxpHr1zbcOt11mBEmp9LrjwJNnnanG3yDiUj5ZBl6bimZUmZ3WastkbC/6zDgha6bjjq7d7YmVLvhbC1VJjGPbIfKcIGucHgkhrmfver80LNFEu4yE+MYvuyt6GQ6dsuCpAaAlDl+xd4GIQwrrjnWdNbomfN6gpoZAt7vrs1cNEbju05u/ChZVkjx709dTu5rOa36RdaAGcc/9ipMO1/ettydVmR+j9mAkFhyoQLkzrVIU7AjZuY3H6BdMFRI1gQ3kppJ+q9WJ0gKC1Uc98cgorrOdnohnX88pXz1fEmuky2hAP8ESiDsFkxSjJLpE2EgtpPPbYOBeIlAsZ9hgjtKffxRvkeb30uWX36tnVdLwUucKf3/RbkTa/R/NujkNrkbd84T77+uiW2RWfTx5zwEnzG3mf6LUMQgLCiCjgup/KcM8229pxtVfu3Or+6ZvXTN/godIqLDdGU9xa42fzx+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199015)(6506007)(6666004)(5660300002)(2906002)(53546011)(8676002)(31686004)(8936002)(83380400001)(44832011)(66476007)(36756003)(6512007)(38100700002)(41300700001)(4326008)(478600001)(6486002)(66946007)(26005)(66556008)(186003)(86362001)(31696002)(110136005)(316002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEpIWSsza01NUWxremFIYzlLcmFXMUE3UEZTNUZIeGljSDhHMDY0dThXQ2dn?=
 =?utf-8?B?NitNOE5ReStHU2d5cGxYejVCbW93cGdJR1ZVZkdPdDN5OVQ4M09NUDdVQWMr?=
 =?utf-8?B?RWtxWTJxc3UrVGw3Z3Jjc2YvWENmWEZJcDh4QVBWNml4dDhOY2pVckQxcHlD?=
 =?utf-8?B?eUptREdKaExiUmQ2bGtESVUvL3E1MEJMSkZkb3VJZjY3d0FDTnZvY2dVejZo?=
 =?utf-8?B?RjNnOElsTUJYU0NmdkFKMW5OZGNubDRJUE1oLzYxbUo5YnFFeEx2TG5xQWY5?=
 =?utf-8?B?VUhKY1dRU05lZkdzb2Vvd3FQcmFBUmd0eWFCUW81cytTVTRacmYxL0hZdmM1?=
 =?utf-8?B?UTd4RnkrallxT1lWcnRFQkgwWFpoV2pDbEhUakkrNGVsYzhjVURXUis4MHRl?=
 =?utf-8?B?d3dzZzdablR2QVRkekw2VkpIQlV0dmY3SEZPZW5Ua3czU01WZWswM2o1R0hh?=
 =?utf-8?B?OEJhc0FOaVdhcmhPSGZwSDVTUFZDZ3dLQnMxNnFRcnZ2a0w3SjNBL3krSWxQ?=
 =?utf-8?B?dUNFM2krNDlaWkt3K3M1STlGUTFlVVJYV1E4bitVTDFOT294N0ZxN0owcDZL?=
 =?utf-8?B?SFB1M1ljbEwzeXY3YXV6SGRST2NDMW91TVZWQ2dXT1llckpLZkFaZ2hja1NJ?=
 =?utf-8?B?emZKMGpBQndBekUxM3FWL2ZHM3RKOS8zTVRDL2lHald3K0NSZmxhQTQ2UkhG?=
 =?utf-8?B?amMwdWJtYzJ6Z2hRKy9BdHZzemxjTmVuVXIrRVNqNVQ2TmczekZJVGkxNVNN?=
 =?utf-8?B?VFdEVWptNkYyazdvb1pKQmt1UUFuaFZSRmJLcEZCYjRNdFptQm9DRkM1Q3Zn?=
 =?utf-8?B?cXNKQVhSQTlOMHBvN1I3SUNhcGkrNnpiank0RWJaWVEzcVp2SDhqTTJLY1BC?=
 =?utf-8?B?T0pCV25pVEtGNlM5SFpiUWZLTWRtaERJU2RJbXcxUVEwNXJ4S2ZhY0dDZXRr?=
 =?utf-8?B?RWpXYnQvVzRobVcxdC9sdFR2K0JrTi9NaXpzaGI4VUZNbjZYbEJQeVQ1cFUx?=
 =?utf-8?B?aW9WWjFFSWJxWmkvNWRTQlpHRS9TQWh5dzN1eWFmOE9vSWp1QWNjMGVzN1V0?=
 =?utf-8?B?bzBBWGNrekg0L3phM3BBUmR1OXZTZVcvbVlvekgvM0QzYWQ0RUJ6ZkxOb3JE?=
 =?utf-8?B?K3Noak0vVmR4YXNBdjBxMFNiRXl3OVdZSVZTOGNQYmx2aElOKzlxMkc0Z0Js?=
 =?utf-8?B?ckJHYlgvMUhkQzQ5YkQ2R01LYUxZM0toSzE4TlJ2WTFhckJUZ21kTnQ2Ujla?=
 =?utf-8?B?Tm5za29oTmEzNEdZdENDNEwxcWptZzI4bmU5Uk5NeVduNnc5NlcycUxSY3lC?=
 =?utf-8?B?anhDN09acDd4TmZ6dFFBemhRNkl1K29ZZWpvZGt2NGR4MWNwWDJyMldINkh2?=
 =?utf-8?B?OEk2aTd4aHNzOUw4Yng1dzhzbjVycHI4ekJaOURwSnJDZStUVDJuWjU5aWhq?=
 =?utf-8?B?cmlCNVVRL013V21WK0ZxUDJBZHNJTndzbzNvQmVLZjdWNVdvSUxzT3J5MWFt?=
 =?utf-8?B?UndLMXBkM0dlUmJHMGp1cHNKZVRpeTdwNjRoRlhOeEdMSitCL2MzdFRPVHl1?=
 =?utf-8?B?WHNybDR5dU5KZUFXQXo1eG00TGF2dlgzVzJ3SlJuNjVNTTc3SGYrRll3NzNa?=
 =?utf-8?B?QTNQQWsraUJmRW8vcmVudXBScVp3ODlFVUxVd0hyUU44anZQRzZOamhscGcv?=
 =?utf-8?B?b1dOVElWTC9abGNpUUJOYlZKclpNZVhpVE9vTEdUNkhzNXRnNmlTZFhXMWtE?=
 =?utf-8?B?TithSVJZS25pYnRLNk5Lank4VHBPMmdHMlNhdzBxZGg1WXp1a2pOVGhsSjB0?=
 =?utf-8?B?WDR2MWh5WnFob0hxalZUcDZnUitaZ1EycjJHMTYyOHVvbzNMVllLT2ZQbTVu?=
 =?utf-8?B?cFgwWHJtNEtKTGd6SWMzZVVWbEg5RWtSMEFzQ1M5YlcxK0tRWWlEdnR4Z3N1?=
 =?utf-8?B?MUxpVC9KaDdnMUpJcXdRRUFJWCtMeUYybnl4SHUxUFpwbFRKbnpnMjNDelZS?=
 =?utf-8?B?UWhwYnJ5T0F4WHBDdDh0bUM0WmFkb2RreHcvZGh1VG9qWkRrdmVZVXV4dmli?=
 =?utf-8?B?Y29mSEgxQm1tRlRxNFRNMm1tSVhuRkNWOTFBWVZvUjVwYzRUN0dEU1FSSXVL?=
 =?utf-8?Q?T9s5dlziR5uRmG9DsjykuK/Jn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266e9d95-3fd4-48b8-16af-08daf83c5be1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 03:38:55.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xBXaGNSpfRDI/KEHMKsewLjptNWGPzxdD1+rt7m5lMePVoF0jGN91A08IRJ6oFP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Acked by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-01-16 20:39, Strawbridge, Michael wrote:
> Split process_file and send_message into easier to use functions.
> Making SMTP header information more widely available.
> 
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
> ---
>  git-send-email.perl | 49 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5861e99a6e..810dd1f1ce 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1495,16 +1495,7 @@ sub file_name_is_absolute {
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
> @@ -1546,6 +1537,22 @@ sub send_message {
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
> @@ -1735,11 +1742,8 @@ sub send_message {
>  $references = $initial_in_reply_to || '';
>  $message_num = 0;
>  
> -# Prepares the email, prompts the user, sends it out
> -# Returns 0 if an edit was done and the function should be called again, or 1
> -# otherwise.
> -sub process_file {
> -	my ($t) = @_;
> +sub pre_process_file {
> +	my ($t, $quiet) = @_;
>  
>  	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
>  
> @@ -1893,9 +1897,9 @@ sub process_file {
>  	}
>  	close $fh;
>  
> -	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
> +	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t, $quiet)
>  		if defined $to_cmd;
> -	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
> +	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t, $quiet)
>  		if defined $cc_cmd && !$suppress_cc{'cccmd'};
>  
>  	if ($broken_encoding{$t} && !$has_content_type) {
> @@ -1954,6 +1958,15 @@ sub process_file {
>  			@initial_to = @to;
>  		}
>  	}
> +}
> +
> +# Prepares the email, prompts the user, sends it out
> +# Returns 0 if an edit was done and the function should be called again, or 1
> +# otherwise.
> +sub process_file {
> +	my ($t) = @_;
> +
> +        pre_process_file($t, $quiet);
>  
>  	my $message_was_sent = send_message();
>  	if ($message_was_sent == -1) {
> @@ -2002,7 +2015,7 @@ sub process_file {
>  # Execute a command (e.g. $to_cmd) to get a list of email addresses
>  # and return a results array
>  sub recipients_cmd {
> -	my ($prefix, $what, $cmd, $file) = @_;
> +	my ($prefix, $what, $cmd, $file, $quiet) = @_;
>  
>  	my @addresses = ();
>  	open my $fh, "-|", "$cmd \Q$file\E"

