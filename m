Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE50C25B4E
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 14:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjATO1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjATO0k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 09:26:40 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC920D05C6
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 06:26:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBlHFcwo+1sp+jvP/O3JP6piSVPCGClpPz0F+ehNBAc6rmFSaYKdBU2MrT7vX8bz1303R0oeeOSUfcIbFwE439clyo5mro9UErwsuUuSyjzU/m4yWzNValiDi453O7WCDJ7WQ4pcED/fYuDzSHb8YcMZ+khSBhUUvKZMRGko4gJGsgkZ451MZ+Uq8+Wyt+0RJ8V4IEknPc9K7HePKRf7UKx1aaV2lCe8K2LiNTaEd0ZUVPQMbnIUd9EVTZ/XjdTyehdH53ML3EhxZKnIO76q/F+otc4hWdXFKOfiZSe9ZBbTdGOIv9pW13qyotA7GBtyUyjXLd20dcJyRVCnQEw7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhXzn6ZtB03kpqwpWtBUlgxnqOgTh240NBaEzzfriLw=;
 b=AjRnGiaehL5ZMyUoaxyN0gNCP9UQWLFq42B7Im92MIIl/R3Stc3+y33rQRDHlnrV81XKr7xSjMYOhHLtIa7P+n2JDA0OoSesDjVpeie/CAoV/xhksMTaCurNHOC2IoZVlWDzu+jvE6sgnwbA+x9TPLEMcksSzyhnwW3nyARutjipqbuCmoyGcl8r3xzX77EWYvFM6a0CsrU/WjVu8enwjoa6GFvOaSR34LfeF9flOHSreLZA6aRT44Exh4uU2FBdPJJZqxIubmUmqaZpJnoxTwfBRDwYq40xHGZ+dIekh7jj3mlzer3IC9JECU4JtamvhHxGV426OuhS+1qNPxe4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhXzn6ZtB03kpqwpWtBUlgxnqOgTh240NBaEzzfriLw=;
 b=WK5+NygfADy/ufiWSJzhGoRb6eXOO3IVc2cSQ+8f/jT985K6UPKP+HLSJ0KyN/uSOBLwMATIwhTAqyu533OuI9pDOdovmM7hdlM5NiyHbt/94+Q/8DArgxFmliZFBQcAqHl5wnM+mPcXilp1YzLuXXjPLIZMdjUv8ayXU4ct76g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 14:25:58 +0000
Received: from MW3PR12MB4363.namprd12.prod.outlook.com
 ([fe80::e938:9d66:8840:315d]) by MW3PR12MB4363.namprd12.prod.outlook.com
 ([fe80::e938:9d66:8840:315d%7]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 14:25:52 +0000
Message-ID: <c1ba0a28-3c39-b313-2757-dceb02930334@amd.com>
Date:   Fri, 20 Jan 2023 09:25:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
To:     Luben Tuikov <luben.tuikov@amd.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230120012459.920932-1-michael.strawbridge@amd.com>
 <20230120012459.920932-3-michael.strawbridge@amd.com>
 <e353df62-c189-755f-5536-5ea91177c55c@amd.com>
Content-Language: en-US
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <e353df62-c189-755f-5536-5ea91177c55c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::6) To MW3PR12MB4363.namprd12.prod.outlook.com
 (2603:10b6:303:56::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4363:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9a82fc-95c7-4381-04c9-08dafaf23c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4LqqVg8oOXBOlTKrVTpJxIsbBzCIYy4M0zzwmyiF4KFogeGvGkTVyyxe8WxP2IX85sT23EfEkkMaZJs2raQ/l9tJgrNp20wg+nX3wiaztYB9/XrJuZvGnd6/SqbhNRSL6FvWEdkEF4PAzexkw04yFA7BOfSJg3cPfkyihDjZKg15hVi1nWdj0eaxKcgaR1A6WV5YK2L1lxTFDCGhKyL/p4pFcdJV+0rFgRMN9Krka3FI27GNLW6MhCPL4uF5OqxtflkSDzHNn9CejZDVoMlo5PolFPXksIfwRryjMmt1XTFl9jlA8oMW7fov/KBb0lqLg6qxIL12LYf8LgSQIKX5vS3pu8iUpTGDFwXHbpje/NNHG3r81vD7yVIFEtt2MgVyrpl6LdJmjFBoO6no/HUZrVBkNE5fGw+xGrO92cAFDHbWLQ6lg01yEhXKsqKJBsZKm7NxMnDrcodh7bJzwEJqVJ2bFNGom212v42IRcIO9YcEohPahqSs9dtdpqE1K28kLh5/Z+QwCXu8h0somno4x1wQJRVxBdE/3WLNaHXnSws1y6gEuIJcuMwkodQatzwu+k+jM8GfDMdJ9Mrf19Pq566vtfKz4zvrk7u4Jvr8oqg9vYqIcjVc1UiMLW4Jt3V+M/pl6XnSPOWZmmoDTosRygenDIl5/YHNgTh1qFuXBb/DF9ok/8HTIddTElpzjMKRHtRuVejBA5RJKQB5xnNxM4wyszfpG/aBHEwsQjPfEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36756003)(86362001)(31696002)(31686004)(2616005)(316002)(54906003)(66556008)(8676002)(4326008)(66476007)(66946007)(6512007)(26005)(186003)(6506007)(478600001)(6486002)(6666004)(53546011)(38100700002)(83380400001)(8936002)(66574015)(41300700001)(2906002)(15650500001)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkp4ajVOT3RFRlJmNjNZZERiTGZEd0dyK2FRYW8vL2plNlVrUk1HWVhKRFY0?=
 =?utf-8?B?NlR2K3BzdEFKOUl0NkNKMnBDV3ovQmlnTm9IS1diYkVORnVzai9pUGcvVUFr?=
 =?utf-8?B?VkZ2cVdNSExRYXVqUzRXUGkrMXRPQXFUSjgrbDBhV2lHZTQ0OUtIcGU4MGI5?=
 =?utf-8?B?TTUzdldRdWFSam05MlZzM1FKY0YrOHdLeXFZQ0xaN2Qydzh3eGFXTHRzK01S?=
 =?utf-8?B?MmpkMTFDY0JORi9CNEpkczdIeGRZRjlZUHl2ZW96VmRCR1l6RHE0Z0NpdElD?=
 =?utf-8?B?R29ScFZ6V3N6U1lEUjdHUDlBeVJTb2VKUGNjUXNnM1d3ODM5R1gxZFptZUhL?=
 =?utf-8?B?LzBEbmNlSTM4bG8zcmVNZ3I2TVZQWVpUeUU5WU5VQXN2SktUcHFZMXN5S2h2?=
 =?utf-8?B?Y2RUdVkzWkZCT215L0RZcnFiaml5a2ducE1RNXQrK2t3bFBxeTk3UzJ6Rkl6?=
 =?utf-8?B?Rk5UNlBzc25Pd21UenhMSFNqVlNpeGJNOGgvaXNPRkpOMFRpZzc3RmY3VThw?=
 =?utf-8?B?Q29FdTBoZnZQbnZwU3FxS1U1ckhEY3NCek5velBzTUt3dkZDWHZxTStLK1BO?=
 =?utf-8?B?YUo3UzlVQUNYcGxnVVRTTXRtUVp4M21XSXVpclE5REYzeDhrM29TNW1KeWJG?=
 =?utf-8?B?UmlSbzZkMVZQVHRBVHNYdTJrWmRDNzZwZHI0SXl6dXErTmVzeEdjOEFaNmgr?=
 =?utf-8?B?YXRId2Y1elNsTjdaeVVkamdnYVpibU5ZL2UvSXBET0Q3bGsvZUg2SktMb05m?=
 =?utf-8?B?MFNPMjRodzBiTzhMa2ZyRjdKV3ZQeHgzanp0TWh2eHdYMWtUN1FPMmpZaUdi?=
 =?utf-8?B?SDJkODcyS1AvMFJjZmlTUmJEWGxtQkh3REduL2pwRXlmak1KajdnTHZaUGFh?=
 =?utf-8?B?MkU0QmFiazBvYjZhM3h0Zm50NEF3dG1pMnJaNjZCaTloRVR4a2gzZ0VMeXV3?=
 =?utf-8?B?S09HSktEcWFCTnU1Umd1Z0JUZkhQayszbDhNS1dyT1Q2MVY1YjIzTnQ1czBj?=
 =?utf-8?B?SFJmejBRTDBaVmJna0hxMWNReWV1UENoVUp4Y3dFOFdVd3E3ZjdCekVueEYw?=
 =?utf-8?B?ekZvejJXT2t2N1JNZ2xNSVpRNHN5YXZ3Ukh3RmF6UVYwNyt6OUFTUDNCSmdm?=
 =?utf-8?B?S05Zd2YyeHh4LzJmSmo5V3VoUnovRmZxbVlhWW1CWVNOakJaVmMra2dzUS92?=
 =?utf-8?B?QjNxMG9Kd0JMbnVCNDNyVnJZTExUMFovYW5iT0hzbElDTzNsc2FhTUNveXV5?=
 =?utf-8?B?eXMxVkxQRWZzb1RjdjMyZ1NuMTh6QllwajhCQnp0MDhSNmd3Mkx2V3Y1ZWFU?=
 =?utf-8?B?YlVPQzNEeXZqSythQW9vYTJyamdzekVxUFlmdWNKck84VVgrek1zUzJGV1FL?=
 =?utf-8?B?UzMrNnFTQm1jdWZvT0dWMENJK1VMaktsZ25hM3RJblk5bnNmdFhoU2tVaXA0?=
 =?utf-8?B?cVhSNjI4SmV6TGNvVVFKK2RDUW01cXJGTmo2QzFnWDYrV2dEZ0dKWWdQMXQ2?=
 =?utf-8?B?UDdrWXdIalorNEJLcWY2bEJBZ0NjZE02bDBJQk9XRHk5VGQvcmtBZzdPQWh0?=
 =?utf-8?B?S0lPNk5neDNMYXBOL1RCMFBTdHl2Sis0ZlFvTW9HSWlqbTJGSHhNY2pZVjJL?=
 =?utf-8?B?UjVqbmdFcU1vMmdiZWhmdjVMZWZtTjZwWWl1MktIeHh1a010SWJteWhkWFAv?=
 =?utf-8?B?dGJMUXcrVnV1TTlUZU92NkI4RllUQjIrTzFManFWcHdzR0Y2S3RvMk5idzdo?=
 =?utf-8?B?MUdFR1QzZlVqSmFWTzZLSzJOQjc3SkRybDdoK3RlOU5GWld1eEVwaUJ2K1Ns?=
 =?utf-8?B?Z3lpdFN1anNjWVYveVpPMFRycG5JMU8rUWlXTHFndzE0MlFYTFhkV2RYZDdp?=
 =?utf-8?B?KzVlZXljZmg4UHU4aUpBWXcxRGlkQlRUQVoycjRaT2VtMlVqMXpmOFBvbTNa?=
 =?utf-8?B?NnM5WTBwcFllNXIwSVVGdWVMZElGZ3BDZDhRb2trR2lGcjRDTDZHc0d3Z2Zq?=
 =?utf-8?B?RXJzQlZQWmpyWXlVZ01zUkFEVjZNZ0lmRFZMUm1nOEoyTjlYK1ZLeFdpdUc1?=
 =?utf-8?B?VllhUThLQTBsY3Fyb0VpZG5naXdkVHI3bWZyY0NrRWFLSkVIRXpTL3RQVTBI?=
 =?utf-8?Q?2n/pcHrsw+0ht3G4ddqAlNqdt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9a82fc-95c7-4381-04c9-08dafaf23c22
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 14:25:52.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmL/2JM/dZqsBCIA4BAyWGSEMv5J5uaIIPZ45rBTWJUMMZCeAwtOcMd9fXNLSoNtIqtDHzqKtB0x6rjAWDXRFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2023-01-20 08:07, Luben Tuikov wrote:
> On 2023-01-19 20:24, Michael Strawbridge wrote:
>> To allow further flexibility in the Git hook, the SMTP header
>> information of the email which git-send-email intends to send, is now
>> passed as the 2nd argument to the sendemail-validate hook.
>>
>> As an example, this can be useful for acting upon keywords in the
>> subject or specific email addresses.
>>
>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>> Cc: Junio C Hamano <gitster@pobox.com>
>> Cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
>> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
>> ---
>>  Documentation/githooks.txt | 27 ++++++++++++++++++----
>>  git-send-email.perl        | 46 ++++++++++++++++++++++----------------
>>  t/t9001-send-email.sh      | 27 ++++++++++++++++++++--
>>  3 files changed, 75 insertions(+), 25 deletions(-)
>>
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index a16e62bc8c..0decbfc92d 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -583,10 +583,29 @@ processed by rebase.
>>  sendemail-validate
>>  ~~~~~~~~~~~~~~~~~~
>>  
>> -This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
>> -the name of the file that holds the e-mail to be sent.  Exiting with a
>> -non-zero status causes `git send-email` to abort before sending any
>> -e-mails.
>> +This hook is invoked by linkgit:git-send-email[1].
>> +
>> +It takes these command line arguments. They are,
>> +1. the name of the file which holds the contents of the email to be sent.
>> +2. The name of the file which holds the SMTP headers of the email.
>> +
>> +The SMTP headers are passed in the exact same way as they are passed to the
>> +user's Mail Transport Agent (MTA). In effect, the email given to the user's
>> +MTA, is the contents of $2 followed by the contents of $1.
>> +
>> +Below is an example for a few common headers. Take notice of the
> "example of" not "for".
>
> This maybe clearer:
> "An example of a few common headers is shown below. Take notice ..."

Good idea - I've fixed it locally.

>> +capitalization and multi-line tab structure.
>> +
>> +  From: Example <from@example.com>
>> +  To: to@example.com
>> +  Cc: cc@example.com,
>> +	  A <author@example.com>,
>> +	  One <one@example.com>,
>> +	  two@example.com
>> +  Subject: PATCH-STRING
>> +
>> +Exiting with a non-zero status causes `git send-email` to abort
>> +before sending any e-mails.
>>  
>>  fsmonitor-watchman
>>  ~~~~~~~~~~~~~~~~~~
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 42f135a266..0e595d6ac5 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -785,16 +785,31 @@ sub is_format_patch_arg {
>>  	push @files, $repo->command('format-patch', '-o', File::Temp::tempdir(CLEANUP => 1), @rev_list_opts);
>>  }
>>  
>> -@files = handle_backup_files(@files);
>> +if (defined $sender) {
>> +	$sender =~ s/^\s+|\s+$//g;
>> +	($sender) = expand_aliases($sender);
>> +} else {
>> +	$sender = $repoauthor->() || $repocommitter->() || '';
>> +}
>> +
>> +# $sender could be an already sanitized address
>> +# (e.g. sendemail.from could be manually sanitized by user).
>> +# But it's a no-op to run sanitize_address on an already sanitized address.
>> +$sender = sanitize_address($sender);
>> +
>> +$time = time - scalar $#files;
>>  
>>  if ($validate) {
>>  	foreach my $f (@files) {
>>  		unless (-p $f) {
>> +		        pre_process_file($f, 1);
>>  			validate_patch($f, $target_xfer_encoding);
>>  		}
>>  	}
>>  }
>>  
>> +@files = handle_backup_files(@files);
>> +
>>  if (@files) {
>>  	unless ($quiet) {
>>  		print $_,"\n" for (@files);
>> @@ -1043,18 +1058,6 @@ sub file_declares_8bit_cte {
>>  	}
>>  }
>>  
>> -if (defined $sender) {
>> -	$sender =~ s/^\s+|\s+$//g;
>> -	($sender) = expand_aliases($sender);
>> -} else {
>> -	$sender = $repoauthor->() || $repocommitter->() || '';
>> -}
>> -
>> -# $sender could be an already sanitized address
>> -# (e.g. sendemail.from could be manually sanitized by user).
>> -# But it's a no-op to run sanitize_address on an already sanitized address.
>> -$sender = sanitize_address($sender);
>> -
>>  my $to_whom = __("To whom should the emails be sent (if anyone)?");
>>  my $prompting = 0;
>>  if (!@initial_to && !defined $to_cmd) {
>> @@ -1214,10 +1217,6 @@ sub make_message_id {
>>  	#print "new message id = $message_id\n"; # Was useful for debugging
>>  }
>>  
>> -
>> -
>> -$time = time - scalar $#files;
>> -
>>  sub unquote_rfc2047 {
>>  	local ($_) = @_;
>>  	my $charset;
>> @@ -2101,11 +2100,20 @@ sub validate_patch {
>>  			chdir($repo->wc_path() or $repo->repo_path())
>>  				or die("chdir: $!");
>>  			local $ENV{"GIT_DIR"} = $repo->repo_path();
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
>>  		}
>>  		if ($hook_error) {
>> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>> index 1130ef21b3..8a5c111a24 100755
>> --- a/t/t9001-send-email.sh
>> +++ b/t/t9001-send-email.sh
>> @@ -540,7 +540,7 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
>>  	test_path_is_file my-hooks.ran &&
>>  	cat >expect <<-EOF &&
>>  	fatal: longline.patch: rejected by sendemail-validate hook
>> -	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
>> +	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch> <header>'"'"' died with exit code 1
>>  	warning: no patches were sent
>>  	EOF
>>  	test_cmp expect actual
>> @@ -559,12 +559,35 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
>>  	test_path_is_file my-hooks.ran &&
>>  	cat >expect <<-EOF &&
>>  	fatal: longline.patch: rejected by sendemail-validate hook
>> -	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch>'"'"' died with exit code 1
>> +	fatal: command '"'"'git hook run --ignore-missing sendemail-validate -- <patch> <header>'"'"' died with exit code 1
>>  	warning: no patches were sent
>>  	EOF
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>> +        if test "$#" -ge 2
>> +	then
> There appears to be an extra indentation of the "if" statement.
Good catch.  It was a matter of spaces and tabs combining that wasn't
easy to see.
