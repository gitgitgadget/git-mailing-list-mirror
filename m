Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAF1C6379F
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 04:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjAQENZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 23:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbjAQENY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 23:13:24 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7273C22DD9
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 20:13:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGQBr2/7DFb21sn2HUuItuwdvTBS01d9kN134e0CxU20P5By/bNyBvujZS2TC97u3GzH3pWdSqCmr3DQQaOEJvz2qnkv+P0cvFNzNz4hq9P07AFB3MeGIEge8CLYS2I7PtjhEebejmq8IVPGvb2R5HOyq2e8+54t1B8gVEf4ISGrx9vbZ8JI58groqOOKthxXGX6+uiFN35oUqtCUNX280dha9C1lKU63RYP9u5QAtokzRdwJxZU3/gPsAEjwDwSP3ACbFSrFCMnLUowP+QRa4blqeSSMaU8n37Su87ts5XJ1gj7yAjZLZ09j6qxapmPH0NA/sM4qbSMWEFlCNSlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9UEAXbi8EPCa8OeWK5HXmVAGZZHjMuY4aJ/0EOg7j0=;
 b=PfmQUAAxLMTcyf8STVrjW6yIyPNcJU95dGHPjEFq07wIp5pCqwFcsUpd13qP/y7XVB9W+jvsvU+Z7F9fs4M3Ewej3u+ZBw8sdyaXWYcgMXb1x6mbgnHRrdsCC34razd0WKNhRRKglLg1Z3G1eh+4xtCvgw/N89cyjCZrzh7V+3EFSG2LD9AYnOs8ijL69exqg4D3u8uRFRcZh7wKhU+xUFNtUWr+GVJAU4EIgAICo+SYLd3UurQmDzLGWxWmorBv7OihLeJwOBJWUDR8uN5seGZ6ZFyeLClF/l0Tkfo8S58OYtUqU0e1aJ9U4LL7S0MiOnDGRnHHQx0iccmwN/T//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9UEAXbi8EPCa8OeWK5HXmVAGZZHjMuY4aJ/0EOg7j0=;
 b=5jtvEVt6kZazgifwthRv5T0T5l0HG2Wdcsam4qTKwBXBOmBf3aPw8NR/sNJ4VNVZCBvhuoW9ZoVQE1eqBTyErsB9dt82jhEsRkBIQmtYTQr7BIujUgmdiMiQ1FT8XOnZ0acL23VeRnqjBoKTTtdROES6GbJFleGQ3qsRPKUwTnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 04:13:19 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 04:13:19 +0000
Message-ID: <68bf66f2-d9b0-5f29-2e40-7a5b97ea7d79@amd.com>
Date:   Mon, 16 Jan 2023 23:13:16 -0500
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
X-ClientProxiedBy: YT4PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::23) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f92ea57-f85f-4b6c-e8be-08daf8412a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu1JRr83gN259r6eX7fDUKI7vUDNuAbtdfKh+hZ7KveaAAEA0uXyd9fNeZeb8NdzT5NCQqKa0yxykEN6/xOtAAqSDTZk81tZ3YJ+lj0N+HLj4ob85l+qvFFiwVy1p08VwD57RZgtlnfD/g/KLA7YBMAwi4ezpDbCpT5MRpKFQ5L6ir8dITP2vuTXEUtt1BdT9Yb3RlnNgVfSz4IjfobeCpVJGHAFKMUDBBNwu8J3IblFfBzcYxxnpOm5NK1a1S+Eipk09HuxvOSIZxZrgFVhWf2Gfebae7krj2ZPAx5n8A/d329yMKAlcxpkYu7kkyntHEGdRO36QgeGO7F2yfyEh4qoxaas7h+YzG9Pga35HrWAM8/VU4KR86lyNjOvJVQetpezhhLVmKAtI16AnQEbcGydTUFxkFBt1EfKLKBQ3prDx3hHTNZRfrCWviQlQIoAzcJIK7B35nqdhqrozsL/jJd39knbL/qXNZvj5R1psxy7kn4/Mhl4ez0lyTBPlwdg7f/a9DiwskQXiRhVz2SNd+z/yWo4zvckurTm+FwR2gIms1zUUlDA4XttReqYIHLwccEKayWirt5uO7XuSZbvlhRpBzU1zM8lWPzlhW5VFGL3UEuXGm1QnkYXGv2QT3l4MhWHU+xaUHga9VD2l9dZ9d/UpXxp6NLF09kR4bwpd8CzIDpoqoK4dczjKBC49W2uRW1NPkzuEjdWYEcHAzPEpXDYKU0EZ209ATKShXIrviY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(31686004)(478600001)(6486002)(8936002)(44832011)(5660300002)(4326008)(66476007)(66556008)(53546011)(26005)(41300700001)(36756003)(66946007)(8676002)(2906002)(316002)(31696002)(86362001)(110136005)(38100700002)(6506007)(6666004)(6512007)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpzcElOSXdKN1RNUVErM3NDRmdLTzMxVnJlR1VadWJRcURKWHpOS2tkbE4z?=
 =?utf-8?B?RTFmQjkrcG9BODVEMGRDdnNIR3RJcVlQTWF5Y2MzM2IzeDlZcE5YOU4yajc2?=
 =?utf-8?B?YUpOenQ4MzJ6WStiU2oyVWNLTHNjSk5iWGRIeXdpdVBWcFp6SzU0a1hPQ0x5?=
 =?utf-8?B?SWR1UEFrYjlLV1ZueUVGbmlQbTlmZ1B1K24wbFQvZFROdmpWVDlic2ZBMzVu?=
 =?utf-8?B?Z2wxdHVLN0JqcUtyYnBDMXY5ZGo5YlhybWEvN1lOclF6MFhhSGlsNkVpQkov?=
 =?utf-8?B?U2tWUjltVTduU2ZCTHZzanJNekFEYzZ1RzZYYWtBeEJFMjRtOVZaR2pGaE1W?=
 =?utf-8?B?K0ZHMVc2SGlJT0xTWVlDNSs1K3llS3VkbzBXaWVqQ285bUo1MTNCZVFMdTU5?=
 =?utf-8?B?b3lPejdpYWJ5aG9MbzFRaityNVVhM3IrYjV6TWQvcTJNL0hMVWFCMGVod3NZ?=
 =?utf-8?B?bS8wYTZuSCsvR3BEOXJSYjl3OFRNSHVKVWVOcThJdXVOOE1VL2taYzI2aWRv?=
 =?utf-8?B?WXZrZjgzeVU1WThwaUU1aU1kL3JGLzJrYW44eStxSENrMWE3VEZiVmlReEpt?=
 =?utf-8?B?eTQvTkJJTFUxWVlsdmVjL1FoUG5HZzlFRmdFRklTb0tEMEV6MjBTUGxnSTVE?=
 =?utf-8?B?ZVIzcDN3cGJyT0ZRblFTN3dKRjA4dlJkaUc2RXpDS2ZWVC93Lzl3SEFFdFJ5?=
 =?utf-8?B?TE85VDJmMXBNa0JZK3Z6VkUyZDZNQmEwRlhHOEY5c2NPTmUvSEVUdHVZOTNV?=
 =?utf-8?B?aWFOd1craks3bm1ubFg0VTF2NHV0dTBObDMrdW9XYlo5S2ZVeXVxSSt6dFpC?=
 =?utf-8?B?Ym8vSEhXeHNqRnJISWdRbDJlNlF5TnBsRm1maFNoalZpQXdaV0pUZUw5SHlz?=
 =?utf-8?B?THBtbGtDR3dwdjZTRVQzMExrWVhpdHExTncwTVdzVkZWYmptazN5VkdmOFo5?=
 =?utf-8?B?NDZrZWZGYm0xTVdzWGZTSk54SVdwQmZGUnhJMGFJVnhMdlRudEZJckhxRlFG?=
 =?utf-8?B?OWRWNHVSUXVNNll3dGVZRkhWc3Ixbzc2TzRYNjh0bmlNK0k4T2lMWDVtbGtN?=
 =?utf-8?B?bWdSNXBVQ2pRQTkwSTgyVG9jcHFQSFFMTmloVW1heFJaYWR0N21hcisvQjMz?=
 =?utf-8?B?cDZERlVKTU5odXpHSHVlbDIzR05xTEIvQ29MWWxTS3hZbGxzYXBjWDdNYUZM?=
 =?utf-8?B?SDFURXlWbThIWjE3RFk4b1FkVWFVblRQSXgrUTU0NElxbnA0V09kSjU5czh4?=
 =?utf-8?B?QW9GelJTWUUyMWJPTGlWS2ZjRVJGWXNYL0RVMlV3MkNNVDQ2alU1dnZmSVlr?=
 =?utf-8?B?OXNndFYyMTlJWElyNzFwbHBpZ3NUNWRWZTVwQWhHL1ZMTEpHQ1hzZnZ0Z0Yx?=
 =?utf-8?B?Q3JBYlRDTUplQWErd1FPczd5M3Z2UG1aZXV2eS82cXVaN25KTjF2dllCMjVi?=
 =?utf-8?B?bHl2RTd0cENiV2xKV29HQURmbWZtOTJ5Wkd1Y1MvaklKd2ZIdWhLTzJXZGhB?=
 =?utf-8?B?Z0w4QldFNnYrY3pNNEgyREhESGxMZGo2Mmh6elJndS9idEgybXhubFRnMkk2?=
 =?utf-8?B?YmNkNUtZL3lKaXNlbjBEUGdpblJJV2NTSkFNcGw5YUR5dXhPY0w1cngwNzVm?=
 =?utf-8?B?M1ptYnp0UXJUMTdCTnA0UWJIVVNUVlY2cm0vVUFjRlBUeklCQTJzYWh1UmFk?=
 =?utf-8?B?T1liWFJRdzFCNVF1a1BScndKbWluMThOelNEVTRvc3lmZkpibC95Sy9wU0hC?=
 =?utf-8?B?K1p0OURhVktVSjRhZmpEL0FLbG01dEJkNjI2aFVzUjk2cEIweUtmbUFjM1Bn?=
 =?utf-8?B?M2lZSjdvS1JoNlcyMkVHZ3FwRzdLWnRaME9BSm1GQ2U0OGxyTWFwVlduRDEz?=
 =?utf-8?B?WWVLZW05OFZaSzJtTjI2M212aHY2QW4wUkhLSFEzdnFDZEtRRTF5YU1CQVJa?=
 =?utf-8?B?YXo2cUYydnQyaDZ4ejFZNG5kb3k2MHVyNTFpQ2twaHNraDFOVzhZQ0VWTHY3?=
 =?utf-8?B?NGNuU294ak9pMXArVytVUW8xWUZ2V3FMWCs2ZFIyNERxRjlqMktZV0tGZ25Y?=
 =?utf-8?B?ajJNNThPUUJhUW9MSEZ5ZGJ4T1ZhNmVuSzFlcGpSSnhjQ0pmYjA2NS9BMUZI?=
 =?utf-8?Q?OpakV6qDLDP1z61imcxOrSkDy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f92ea57-f85f-4b6c-e8be-08daf8412a57
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 04:13:19.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HI/JELpIC4jSgj+2nctUQSaMzaVg5gqz7zU71TXUeehYlMFBGB59jogOQ7WlxunN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-16 20:39, Strawbridge, Michael wrote:
> Split process_file and send_message into easier to use functions.
> Making SMTP header information more widely available.

"more widely" --> "widely"

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

Perhaps add an "and" as "... user, and sends it out."

> +# Returns 0 if an edit was done and the function should be called again, or 1
> +# otherwise.

"otherwise" is usually used on error. Perhaps we want to say here
"or 1 on the email being successfully sent out."?
-- 
Regards,
Luben

