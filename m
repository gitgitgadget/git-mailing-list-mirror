Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8066C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3B76120A
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 08:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhGOIbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 04:31:31 -0400
Received: from mail-am6eur05on2048.outbound.protection.outlook.com ([40.107.22.48]:15264
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231524AbhGOIbb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 04:31:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Swu9ciHgNvpo1R4cKejM7N21ovs/pU6rEhz7m3rYg0o4+llBpVBSi/nHKt7qilu2ZJyaNVviE3zhLsu6nuyyXsV1DXx7oHmMEHiy+rggpRGasIAIa6NcbU1XIweBH165ATPTp4PcTBljeI9iOtW8pkJdfnryspwbc5DWueH1lRgQSxTk+BXKOcraqeUfE5/Af/Ox0T8tHzQp4SsnM2osJ5ykFk68n5kuk0VhHzzSJck1ryc7Zsjo9c9XK2l98qcYX6EZmLt4wUnWaIry3M1rhVCiloCWTyY/o/kUnO1I6gNS7kygjfLuK3ctCKDVLDLw2heUAEhdhTfsfkiwTR9WNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC9Nnd0MQCxSvv9XARFTS+k5cpGtEUrxw/m9sevyESA=;
 b=PIIHqfuc4/5+v4lklCgNG99i6Q2I+S6BnjyaLmQ0tSjT7ZDx0bElaodHnPqnov1NE/2MOZo4Jct88DBtPXmF2Clo8ZfDg8LMEM+NzqByRtE4lhQPiSyToDyC7hiwBPx7Ighrh7Putfa24HeSpElBbxqCeb46wfIVsEtUnblqYBN++nATGcf/N6dkx2KqOWEdvMVtob7JLfewBAh5ebHH3P2mfUDrU1L0OJ0H58ePT/o64draffabTXKsMM9IsSaUaRE6nFDKDXE9T80Oeb+5LpRi8ZuM6i3h/qhAcQUDrWXViNP1LUgfxK7wdD8sbP4NG5lo+kkHVCs0OgX+6HEjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC9Nnd0MQCxSvv9XARFTS+k5cpGtEUrxw/m9sevyESA=;
 b=oq4kbPdNM7fVVmSjwuvxkn5VSYIThZJuYs5nTY5sAx88WDudVzLLd4v2QLyD2jTrWD5GfGqy81Prt+ZXXI/HyC9OcK7JOvV2EGFfEvAcwEkzmM1XaGwBNtDgZA+3bus96gH5oVMJXXJTGl6aBlGyeH+pmgjEM+hkYD3xSwmFzLY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4638.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:15b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 08:28:35 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%4]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 08:28:35 +0000
Subject: Re: [PATCH v3 4/9] ssh signing: sign using either gpg or ssh keys
To:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
 <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
 <df55b9e1d5989766b08596f5b9057ba0be38c10e.1626264613.git.gitgitgadget@gmail.com>
 <xmqqmtqovdpg.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <50eca062-f2e7-28d7-09ae-97250f620be4@gigacodes.de>
Date:   Thu, 15 Jul 2021 10:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqmtqovdpg.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0257.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::29)
 To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR0P264CA0257.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 08:28:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7300a5a6-1dc4-4ec7-747b-08d9476a89f4
X-MS-TrafficTypeDiagnostic: PAXPR10MB4638:
X-Microsoft-Antispam-PRVS: <PAXPR10MB463807C1689A5901D0F3EB60B6129@PAXPR10MB4638.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dyRDawQTtW74CxNpfEYhtm4R9bQJfAMlr0yhPRYOixtybo+JCpVPs5wpT+9Cj9yBODc8S2/sbJngGZVFN3GwD4+2hYJDEZJ/u03fUPK5L3taFTyhs1Wtj+leIyF5+P+mpfPbXmrvMUI4fMJNqn5e9HJVf0+Z8OSeRGRRFanpyd+14zgPIv3RCFryi1rK93TNn6Xfmu1p8rDZgHEOsCoNbdgG/MPB6nJiHQTyQMerU1tZEjvnpE6bF3nuLz6nFLM8DYQ+9jNIDcs4sQPUWs9D2uPxzv4lx0Vdm2mnPp6/dW17BkMih7+5mwkD6aERfU2cAnk4cIB/B/nRX0lSj48R6u9wqE82GIZxrxMpqfkvvs4zzXp/S+Jbg6ZXiV6EIuKdg0wUwpvXInkKtkVFkNBEVFZBTetaCsMrNxRJSpCq2ixyJAyUpg2wlKvdSpmDMROFTsbkdMH1W604PrBx09frQYxFzvkE5bMLQ/RqsBjceT7Rl6jUjNbDYCWdT9jDX0Up9ZNqzYe5h+UcG/zv7BQwWQyE1KqCVvaJVOLKNO3Ipm68fmdNIuGb7zKBjhxZM4ll1aCBVnI7KFNdrSN51C5B8WTQp65jtT5nko0xgQw7Xc38hc7sT16EyQRzRDymB3AyfTaIUnhFdVrtDTlTx8HYtDfkd1GDI35/hKeD70ATFgK92MwbgfBLTzC10wiQ6wD7ZHaqQ9xnrlcSAIEbxfu2/SQFM6VzDN4RyWVlz8jmK5zofN4iE0eSeiXPQWGsfKjQ/pjVZwIq+UJsU9gJp90PvDOHMt2jBKTFdVo1kv00axB47h0ohuV0GOlGMYip4GwbZeuyYDti+QaSHUK2U1EBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(366004)(136003)(396003)(376002)(8676002)(6486002)(15974865002)(8936002)(31686004)(316002)(66574015)(31696002)(5660300002)(38100700002)(86362001)(110136005)(4326008)(7416002)(54906003)(2616005)(186003)(2906002)(83380400001)(478600001)(36756003)(52116002)(66946007)(53546011)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDd3SThEY01FcEJpY0l6c21wSGJIem5ZOEpXamI1WXRieXBuWW9JaFJKSGg4?=
 =?utf-8?B?bkVKdTJud255ZFZsZWJJVlFvZmNwNVRpbitlMEZGRHdIQ2pDUEdtbmtpMXRz?=
 =?utf-8?B?MloxNXlIdEdPZTVmUW40Y1AxNWVxY3BWYVdPUFlFN0xRZEI5bVZIRGJMbGtr?=
 =?utf-8?B?YzQzdDVIUDQwR2NkaDVNaGtTbTcyc0dkQVM0M21Td0ZudDZ4R3Q5R2JDbEdr?=
 =?utf-8?B?WmJpdGlIM292b2xRNThRbGFnazZCQnBBdEpUTXBhdTdSSDg0T1J4V2ZaUnVZ?=
 =?utf-8?B?ZFI1KzRwVko1MW5NdnRoWHRtQU9vcXNIUVRaRmZKYXpRNDRNWHVZWFgxb3h5?=
 =?utf-8?B?Q01hR3FyaHIrNDFydEk5cEh4MmJjZzZJVTQ0enJZZjFWakRaQkkyd3BBQnQw?=
 =?utf-8?B?aXFHQURnNlUreUVHYlY5bE50cXQrK25DVEMxWUl2bTlwN0YraGZyeXI0ZVNo?=
 =?utf-8?B?OTE2ZHVVdGd5S2xEdFhIZFZiemxCYVh3cEFXRVVrRzFUcWhKVlVtd2tlaDhW?=
 =?utf-8?B?YXh2ZzJpeVlRMVhDWXpWSGJuQjFScC9qL2dMNE9pTWpDRC83Y0x6RVExY0J2?=
 =?utf-8?B?Y1A0QXpPVU55YlJkSnp2VUJyTGdseHlWRFJ3VHhSTFdZN1V4bTMyWFY2U2Iw?=
 =?utf-8?B?YnhFTDNRNmR5cS9MR3lKV3U1WEVRYk1VbllXa0t3QVdTaW91RC9LdXhxN2dz?=
 =?utf-8?B?MkJ6WGdRMnMwTkhlemcyTUg2MW1mdnJUeXVyclcySWpjTEJ3T2NseHM2MEt3?=
 =?utf-8?B?ZEw1WGkwSlR3SW9CWEFvd0ZHN1k1QURGYVI4b1JENWo3U1Z6ZUkxdkRjNHlB?=
 =?utf-8?B?RUFNVkVCTWpCWFJCN0pYWmo5MThCTkRNSkx5MjZmT0lOY0sweENrZEhyUFpi?=
 =?utf-8?B?SnNuYSszU09FdnU0aG9zcnkxNFNkMUs2STdJeWZVSXhmVDJLUkRCakpaN2ZP?=
 =?utf-8?B?Z1hyRDgyQ1VoYXRYVDR2VjIyUmk5UmNkOFNTOEhLeXQwTno2OE04d1FCOVRD?=
 =?utf-8?B?bHE3anJ0c005U1l1L2hoQ3BVWStCYmdQUGFBYmw4N3VNL2haZVdrcDd1bDMz?=
 =?utf-8?B?aEZYZnJQbGRJL1pFdkJFZWhXOTNvZndET0hQRkhyU2dDRFRSY2F2SGZNTHIx?=
 =?utf-8?B?S3o4TVFnbU00eXVhdGpoVWhyeWNxcFR2Rmtrek13TDBOQlAyZUNpams5NHdp?=
 =?utf-8?B?VEE1UEVDbkJ2a01xWTUxbERYZmJKZ0c0ZUd6M2xLc200NGhFUXZJZnZzQ3hz?=
 =?utf-8?B?VVM1eGJmVHVMN3hGdWEweHFSOXkvMzBVU1JyS0NEZERJYTZPYjFGdi9kK2Ra?=
 =?utf-8?B?WkR1WXVWbzNOSEM4TmJIc0NaQjdsVjd1N1Z1ejh5bTVQLzlZdmlGMEdvR1R1?=
 =?utf-8?B?Rkh1YVh2TW1URlAwdVh6Ni9TR0NaZWloZzE0d25GT3paUjhHL1hSRlEwRVcx?=
 =?utf-8?B?aHNxS3hOaU1SWTZLZklrY0hzclN3SU5kOG95UjBVYWpwLzVKeUdjSXZYd1Fs?=
 =?utf-8?B?QXoyMnRlQ1RTSWUxYVNzYytxZ0pTdCtJR1kyYjc1TGFEQUtncVREeGYxZnFE?=
 =?utf-8?B?SUxIeVVYYXdER1RraExoeFl1TE41YjI0eTl3UmVXQUtJUFZYcGNBYXBEcVJO?=
 =?utf-8?B?dU14VVFMZmV4UGJpaGxWYjEyUURudkpuMHNITUkyUGplVkZ4RHBNL0VPNXFY?=
 =?utf-8?B?OTN1SUdvMkFIdGpXSUlpMXM0MitINmI3bzNsWnI3bzlyVEVZUjFuUTRJdm13?=
 =?utf-8?B?Sy9MclkwdEo3ekNhWXNkd0tyM0VWbWVSL0h4QkIxUEhPWnYyWnJEaCszUnh5?=
 =?utf-8?B?YjZaRlQwK0RFRzMvNGV4eEppd2JuNjRkKzV5UjRkWGpLSDdzTEZ4QVNxclNk?=
 =?utf-8?Q?MpUK6PejQJL2L?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7300a5a6-1dc4-4ec7-747b-08d9476a89f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:28:35.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEmHQFVccnd6yl5hJ34ZqNxYR95CcuN+EH4Lt8dcD2MX/XF1beyqOn0jqQXU8UB90RY7HyzVIW+sJBqG9pRTWKLhGeW7ocNP+hqW/MAQK70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4638
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 14.07.21 22:32, Junio C Hamano wrote:
> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>   int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
>>   {
>> -	struct child_process gpg = CHILD_PROCESS_INIT;
>> +	struct child_process signer = CHILD_PROCESS_INIT;
>>   	int ret;
>>   	size_t i, j, bottom;
>> -	struct strbuf gpg_status = STRBUF_INIT;
>> +	struct strbuf signer_stderr = STRBUF_INIT;
>> +	struct tempfile *temp = NULL, *buffer_file = NULL;
>> +	char *ssh_signing_key_file = NULL;
>> +	struct strbuf ssh_signature_filename = STRBUF_INIT;
>>   
>> -	strvec_pushl(&gpg.args,
>> -		     use_format->program,
>> +	if (!strcmp(use_format->name, "ssh")) {
> I wonder if we can split the body of these if/else clauses into
> separate helper functions, point them with fmt structure and
> dispatch via use_format->sign_buffer pointer, just like I suggested
> how to do the same on the signature validation side.
yes, i like the idea and will do that.
>
>> +		if (!signing_key || signing_key[0] == '\0')
>> +			return error(_("user.signingkey needs to be set for ssh signing"));
>> +
>> +
>> +		if (istarts_with(signing_key, "ssh-")) {
>> +			/* A literal ssh key */
>> +			temp = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
>> +			if (!temp)
>> +				return error_errno(_("could not create temporary file"));
>> +			if (write_in_full(temp->fd, signing_key, strlen(signing_key)) < 0 ||
>> +				close_tempfile_gently(temp) < 0) {
>> +				error_errno(_("failed writing ssh signing key to '%s'"),
>> +					temp->filename.buf);
>> +				delete_tempfile(&temp);
>> +				return -1;
>> +			}
>> +			ssh_signing_key_file= temp->filename.buf;
>> +		} else {
>> +			/* We assume a file */
>> +			ssh_signing_key_file = expand_user_path(signing_key, 1);
>> +		}
>> +
>> +		buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
>> +		if (!buffer_file)
>> +			return error_errno(_("could not create temporary file"));
>> +		if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
>> +			close_tempfile_gently(buffer_file) < 0) {
>> +			error_errno(_("failed writing ssh signing key buffer to '%s'"),
>> +				buffer_file->filename.buf);
>> +			delete_tempfile(&buffer_file);
>> +			return -1;
>> +		}
>> +
>> +		strvec_pushl(&signer.args, use_format->program ,
>> +					"-Y", "sign",
>> +					"-n", "git",
>> +					"-f", ssh_signing_key_file,
>> +					buffer_file->filename.buf,
>> +					NULL);
>> +
>> +		sigchain_push(SIGPIPE, SIG_IGN);
>> +		ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
>> +		sigchain_pop(SIGPIPE);
>> +
>> +		strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
>> +		strbuf_addstr(&ssh_signature_filename, ".sig");
>> +		if (strbuf_read_file(signature, ssh_signature_filename.buf, 2048) < 0) {
>> +			error_errno(_("failed reading ssh signing data buffer from '%s'"),
>> +				ssh_signature_filename.buf);
>> +		}
>> +		unlink_or_warn(ssh_signature_filename.buf);
>> +		strbuf_release(&ssh_signature_filename);
>> +		delete_tempfile(&buffer_file);
>> +	} else {
>> +		strvec_pushl(&signer.args, use_format->program ,
>>   		     "--status-fd=2",
>>   		     "-bsau", signing_key,
>>   		     NULL);
>>   
>> -	bottom = signature->len;
>> -
>>   	/*
>>   	 * When the username signingkey is bad, program could be terminated
>>   	 * because gpg exits without reading and then write gets SIGPIPE.
>>   	 */
>>   	sigchain_push(SIGPIPE, SIG_IGN);
>> -	ret = pipe_command(&gpg, buffer->buf, buffer->len,
>> -			   signature, 1024, &gpg_status, 0);
>> +		ret = pipe_command(&signer, buffer->buf, buffer->len, signature, 1024, &signer_stderr, 0);
>>   	sigchain_pop(SIGPIPE);
>> +	}
>> +
>> +	bottom = signature->len;
>> +
>> +	if (temp)
>> +		delete_tempfile(&temp);
>>   
>> -	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
>> -	strbuf_release(&gpg_status);
>> +	if (!strcmp(use_format->name, "ssh")) {
>> +		if (strstr(signer_stderr.buf, "usage:")) {
>> +			error(_("openssh version > 8.2p1 is needed for ssh signing (ssh-keygen needs -Y sign option)"));
> This looks iffy.  You do call error() to show the error message, but
> you do not set "ret", which affects how the return value from the
> function is computed at the end of the function.
I can of course fix the ret logic, but i'm not happy with this check in 
general either :/
The problem is that ssh-keygen seems to give different error messages 
especially in between the versions when the command was added (8.1 -> 
8.2) and mac os x has one of those by default. The check in the 
t/lib-gpg.sh is much safer, but requires an additional call to 
ssh-keygen which i wanted to avoid here.
>
>> +		}
>> +	} else {
>> +		ret |= !strstr(signer_stderr.buf, "\n[GNUPG:] SIG_CREATED ");
>> +	}
>> +	strbuf_release(&signer_stderr);
>>   	if (ret)
>>   		return error(_("gpg failed to sign the data"));
> And this error message belongs to the GPG half of the logic, not
> ssh (you are allowed to have a separate "ssh failed to sign"
> message, of course, but the point is that the error message emission
> should happen in the codepath dispatched for each crypto backend.
>
> And of course, again the "if (ssh) {do this shiny new ssh thing}
> else {do gpg thing}" structure is questionable.  We should be
> dispatching with use_format->fn (whatever the method name is), no?
  I will rewrite this with the fmt->fn logic.
>
> THanks.
>
-- 
GIGACODES GmbH | Dr. Hermann-Neubauer-Ring 32 | D-63500 Seligenstadt
www.gigacodes.de | fs@gigacodes.de
Phone +49 6182 8955-114 | Fax +49 6182 8955-299 |
HRB 40711 AG Offenbach a. Main
Geschäftsführer: Fabian Stelzer | Umsatzsteuer-ID DE219379936

