Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1824C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 12:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97796120F
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 12:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhGTLrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:47:37 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:25507
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237659AbhGTLp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 07:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDKasXWtH+qV9Iz45YLI9Tv1M4ZGwbvUkFo7hSARvbg3x0vflcZJ4Q9v2k22rcd2rgtH3M4gcfuT1VR5CKCxmHP473iE23R5qnEXcaVIKOacvIfOftNTZHDanLCJYz6WM4LEE71zKzBoRo1AACHtFnpjhMtWRksqFnn0Pvv25EhKqhd0I/QWNvPFsroT24jUzdRsbiq2yiJE5bm26i+0pkeGjUUyD8bQ4oHpRKmGIQwi2YgWUnu+DZo8bKxdV6bYAgBdYo1REjWviocSvAv4EtObR/KeBoDkUZDFDd+qH4iVid+f9/gB1X0HMyl8m9DO8QCAM43x+TlhBK8fN3nX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XliwRBE/6PCypQbgrq2FaJdP6boFkrms/abXPX1M+cM=;
 b=ChZHLm7Q5RLAImBIMvZgKeFmhc87z6fW/xeczjo54OgRLya3iJCO2Tg2APgVEfmdY8qD1e5pyJ2XKUonNvICGTAI6zl5/TCnFo7qJrKTQ6ykxWAgP3+kBV20xr573D8CsGqdMJZC9yYQJjUnrxye3kpE4aZRUPs9ZBmlUCEe/MPU0lRAEL9MUoP7x6qCDnbksYEWyy7ZG532HQ2wocKS/TIJVisKw3by4ATrFs3KUDLzv4yUWNVx/e7XTAoWYyWvyByzLRcDD0lVJZ2iuAE4s9+BzSshB5hTs0DldLfIqE+WUFVeCnJRrfFN2DF+AuxsrpFRc5SW8+ttk/H1f9b5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XliwRBE/6PCypQbgrq2FaJdP6boFkrms/abXPX1M+cM=;
 b=B2R27Fp4p5lzPdItvFzBl6ST9MMkHhr3Ui6icXftG0J8uQ9ADDuYhC34rGKPhqM0tJuDqPtJxnWBe1Hcba1ZDI08Axy1X3I4oLVo/Mjf3DJ458EAnjM0re+fQszFOYbmbeqLGlRr0rQaMqlu2xqNW3BF4wPwwqCShDu93mjxJKY=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4334.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.31; Tue, 20 Jul
 2021 12:26:23 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 12:26:23 +0000
Subject: Re: [PATCH v4 2/9] ssh signing: add ssh signature format and signing
 using ssh keys
To:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
References: <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
 <pull.1041.v4.git.git.1626701596.gitgitgadget@gmail.com>
 <2c75adee8e1d6147c5be1b3b0832cc90d44ba6df.1626701596.git.gitgitgadget@gmail.com>
 <xmqqpmvdj1xp.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <b673b68a-6525-44fd-0c1b-7943eb794184@gigacodes.de>
Date:   Tue, 20 Jul 2021 14:26:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqpmvdj1xp.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0124.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::16) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:176:e980:2d4e:7e07:50bd:bf92] (2a02:908:176:e980:2d4e:7e07:50bd:bf92) by PR0P264CA0124.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 12:26:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a773498a-5c36-47f5-f7f9-08d94b79962b
X-MS-TrafficTypeDiagnostic: PA4PR10MB4334:
X-Microsoft-Antispam-PRVS: <PA4PR10MB43340528DADAEA01E22AD776B6E29@PA4PR10MB4334.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfah4LDtK8fSWUwB1kBz3tt0MGsxDzc9OCn5zRFTbG6dwXDnQ0HKh8DgPvGlpzvmj6R/kC+B3SdaAzWN4N9rgki8J/RBnY9ul9NGsDhPljLHNuyxCs3YcM4ddfvae3I1ljE2HfKiv4jSp4ofPYWEF87q76ZiXUtZUwaePfTeZRrTGKZX820x7gxwdQvSmt6j8EuRZWWa9bNIa8BuUCevSY/8HfDgoM2xM3ATbn27o/YZNxkvUijMHz0WeAuKSiztPws9bmdCSrKiMS8HW0gOIZEVXFYChQm6OJPm3joJT7wAfepuSoRnlyGH+XRoyvabozn79xBaTMCqI1Ng9qCQGvVewVjGEyeGpWMj3bX5GyMP4rKxojfgL8RPBXnsWJ7P2WRsP0GdbEu7d4YIeMDfq+SLmaW4KLX6vnr4n35PZb7ovBNpIAL1Mzwmvo7+MTveKowyzn6E8yUp8DDseaR82S6cadHuXfhLRzTu0hVlqqZgTCYyoeTEqH/X8J+Y9HuUv1bwv5p8BHM926Jfj6PGb7YcS13IaU+Msw+v/XOey8ySBBCEmiOgo6YOuDcyovhtGjKdb/g/sKULK9U5Pou+kTeA8PRJ35sGgb5db6mzBXfQh5l1hUnwdFw3I8uqb/zKBEWxxJg5TkOHu174P1lR8CC5cVZH8RYSSrSiH0bQUEpQH+m9fyHg1uilRMIWwOQ2D2mNvWRLPBbcVJ5z28qEtcGOEZ1pYkgNF6YPewM7gR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(366004)(396003)(376002)(136003)(8936002)(478600001)(36756003)(7416002)(31686004)(316002)(54906003)(52116002)(5660300002)(8676002)(186003)(6486002)(53546011)(38100700002)(110136005)(66556008)(4326008)(66946007)(66476007)(2906002)(31696002)(86362001)(66574015)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDR1NjlGQXNzYUxkWlhyeWE3MU5lazBacHp5R3QvNkIwaFNtSis2T0NtKzdK?=
 =?utf-8?B?TWRXTStQRFhFZUd1TVduaGxFUDZhbGwrd0gwM2tMRjdBZGpEZUljcTZIUEdF?=
 =?utf-8?B?L1FlSlgvTkp3UEtPdDdiMzBDSUdnYmF1bnFwR3cvKzJTM3VkUWV0Ym00dVlz?=
 =?utf-8?B?WjduazBvdVRVWDl0VnMvRTRJamNpQTNCd2dLYzhOdjJBOE1ET09iUFdPVy82?=
 =?utf-8?B?VDlTMVVNdHJoRThrdG1lNEVwcllsR0RHWGsvRzFjTThaeXRiYjdpbEJTOGxV?=
 =?utf-8?B?TDhTMjQrcG5ISU9aS2VQWW93VEJxNGlpSVdvV1JrcnpLY0V3bmZkT2plWGtE?=
 =?utf-8?B?WmkzWlo0aW1IaVp3emMwZ2VBdDNHaHNrOEZLeGpwY0Jic0RSbERvVlZjMEpM?=
 =?utf-8?B?TjR3TFhBeGFDQWgvQ2I5TGZkYnVXSE5xZGlocCtpVER1a3lMQlRPZ2FaVVpz?=
 =?utf-8?B?MDM0RjdsTSsrTGlsb2Q5a3Nua00vMWVvUllHR0ZxNXlBRVUyNVF1RW5OYTRl?=
 =?utf-8?B?dEs0ZnZiWDlNcUJ3ZytCdlpxWGhIWWNzNUgxejVKRGVDRkJkRGpsa3huZ0ha?=
 =?utf-8?B?Q2dKcnJSdnVIQ09tVktUb3ZNdWVUaUh1MGsyaGp5YlhEckNsalNVMGFTRkxa?=
 =?utf-8?B?WnV1QW5yR0wvcXhXL2JsNUNuMlREMVhqNHVwZDQwK1hQZVZwWGVaQ00yM05n?=
 =?utf-8?B?Y29INlNyRkIyWjJ1TmpNSUVCbnVsZ3E5VVlqQ2lhczJ3M2lpRHV3TEdQRExm?=
 =?utf-8?B?dTBWalgxWStmbFlnQTVRWjcvTGVmTENwQko5aDRVMUErMm81UklFUUFEb2N4?=
 =?utf-8?B?MHNRS3h2YndHNTVkbHpacnAraVRMWVp5YVhaQ2laWm1tUWxhWlpIWG4xaDRQ?=
 =?utf-8?B?NXdoREJMYVYza3o0N21lSElScTlGVmhaTmpmM2p5RHpyYlNUMm1kQ2U1VVpp?=
 =?utf-8?B?N0tOTGxlSWttVkllY2krRG12WThVTEdONEUzTWhVUlNzZ2V2WWxVN3BuV09t?=
 =?utf-8?B?K2hwU2x6QVNUVWNMbkRzeStTL3RHWGxmVEk1R3p3aEwyNTJTdXdBN1RndCtl?=
 =?utf-8?B?OUd0U1VLdWtYSFFhQWszNCs1MjFVdmk4YnkwTU9nL3FzdGdaU1d6T3hsZnJS?=
 =?utf-8?B?amNzOVBwS1NraWtvN2I4S1J4U0lKUkNqT1pkREtXL3RLeGJ3SWJsOXpXcVZG?=
 =?utf-8?B?eWpLZXhwVnRYL2VqWllHNG4rQlB5QzRQaTVQT25hSEdZNW9lSEJEdFRnQXVm?=
 =?utf-8?B?azVaV1p5VTJ5YStxbUdlMEFuRnFlREtPUkFYQWl0K1d4NHVER1VhT0h1eFNL?=
 =?utf-8?B?RVl0ZUd2UlhvMnV5cTM5MjF6Ym50ckxPb3pSOWdnNjU0SEErNitGK0ZzNjJZ?=
 =?utf-8?B?b3VKdGVyWG5qeWUzVzhvdEpQYVNDciswZE40K0tFZkNFSUZUTFJvL3pPSWxI?=
 =?utf-8?B?YWFsTk9TVEJ4MEJWazU1YVVhTUY5allPQmZDczN4aEhQVjZCZ3MzeEo4Y0lE?=
 =?utf-8?B?RVdLSGtsaG5GWnNkR3g1WkllZGpHQTZHL1dEbGhXT1JRZVZQMkJIUDVMaDFB?=
 =?utf-8?B?SVE1UXJYRHRwd1M5UWczMUJzL2o4Y2I1S0VTUmVWZkNkK3A0eDF1Y1BuN01n?=
 =?utf-8?B?RnMvTmtrRGRDSXFIOXUreTVsOUoxNHdlb2pJT2JJRHlPNDNBZFBSNkkzYk50?=
 =?utf-8?B?VGpsMmJTWDdhUktWSWRVQXl4cmFySzB6b1JXZEN6WlN4U3FsOHFNeUZKcFBX?=
 =?utf-8?B?Qms0UDNJbXpUenVJOXpZZkxURE1ZbTdtZWNlSjBWTWpINDh5TnZzRWl2NUdZ?=
 =?utf-8?B?VnZFckNYci9qdkNGOUw3SFpMZnV2eXpFSVBvak1zYjN6akc4T2pBUnVuVkhj?=
 =?utf-8?Q?3xcKH8V26+q3d?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a773498a-5c36-47f5-f7f9-08d94b79962b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 12:26:23.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bDZHdxA5MUMuPuKPRjVZcP4hX+PLgtVE9Y1AOe4LxYMJlrrwDEl35S3OAJ27IwL9F84pr3svo2rVdTWWaWgpv7inTt3tFhpystUazePkjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4334
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 20.07.21 01:53, Junio C Hamano wrote:
> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> @@ -65,6 +73,14 @@ static struct gpg_format gpg_format[] =3D {
>>   		.verify_signed_buffer =3D verify_gpg_signed_buffer,
>>   		.sign_buffer =3D sign_buffer_gpg,
>>   	},
>> +	{
>> +		.name =3D "ssh",
>> +		.program =3D "ssh-keygen",
>> +		.verify_args =3D ssh_verify_args,
>> +		.sigs =3D ssh_sigs,
>> +		.verify_signed_buffer =3D NULL, /* TODO */
>> +		.sign_buffer =3D sign_buffer_ssh
>> +	},
>>   };
> A payload a malicious person may feed this version of Git can have a
> pattern that happens to match the ssh_sigs[] string, and the code
> will blindly try to call .verify_signed_buffer=3D=3DNULL and die, no?
>
> That is not the end of the world; as long as we know that with the
> above "TODO" comment it is probably OK.
I thought about adding an if(!fmt->sign) BUG() but since these callbacks=20
are static it shoud really only be an issue between patches of the set.
>
>> @@ -463,12 +482,26 @@ int sign_buffer(struct strbuf *buffer, struct strb=
uf *signature, const char *sig
>>   	return use_format->sign_buffer(buffer, signature, signing_key);
>>   }
>>  =20
>> +static void strbuf_trim_trailing_cr(struct strbuf *buffer, int offset)
>> +{
> This removes any and all CR, not just trimming the trailing ones, so
> the function is misnamed. Call it remove_cr_after() perhaps?
>
> Alternatively we could tighten the implementation and strip only the
> CR that come immediately before a LF.  That would be a better longer
> term thing to do, but because you are lifting an existing code from
> the end of the gpg side of the thing, it may make sense to keep the
> implementation as-is, but give it a name that is more faithful to
> what it actually does.  When the dust settles, we may want to
> revisit and fix this helper function to actually trim CRLF into LF
> (and leave CR in the middle of lines intact), but I do not think it
> is urgent.  Just leaving "NEEDSWORK: make it trim only CRs before LFs
> and rename" comment would be OK.
Agreed. I've renamed it and added the comment.
>
> Shouldn't the offset (aka bottom) be of type size_t?
fixed
>> +static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signat=
ure,
>> +			   const char *signing_key)
>> +{
>> +	struct child_process signer =3D CHILD_PROCESS_INIT;
>> +	int ret =3D -1;
>> +	size_t bottom;
>> +	struct strbuf signer_stderr =3D STRBUF_INIT;
>> +	struct tempfile *temp =3D NULL, *buffer_file =3D NULL;
>> +	char *ssh_signing_key_file =3D NULL;
>> +	struct strbuf ssh_signature_filename =3D STRBUF_INIT;
>> +
>> +	if (!signing_key || signing_key[0] =3D=3D '\0')
>> +		return error(
>> +			_("user.signingkey needs to be set for ssh signing"));
>> +
>> +	if (istarts_with(signing_key, "ssh-")) {
> Is it common in the ssh world to treat ssh- prefix as case
> insensitive?  Not a strong objection but I tend to prefer to start
> strict unless there is a good reason to be loose when we do not have
> to, as loosening after the fact is much easier than tightening after
> starting with a loose definition.
I don't think so. I will make it case sensitive.
>
>> +		/* A literal ssh key */
>> +		temp =3D mks_tempfile_t(".git_signing_key_tmpXXXXXX");
>> +		if (!temp)
>> +			return error_errno(
>> +				_("could not create temporary file"));
>> +		if (write_in_full(temp->fd, signing_key, strlen(signing_key)) <
>> +			    0 ||
> "keylen =3D strlen(signing_key)" before that line, for example, could
> have easily avoided the line-wrapping at such a place.  Wrapping at
> places like after ||, i.e. after an operator with a low precedence,
> would make the code easier to follow.
agreed.
>
>> +		    close_tempfile_gently(temp) < 0) {
>> +			error_errno(_("failed writing ssh signing key to '%s'"),
>> +				    temp->filename.buf);
>> +			goto out;
>> +		}
>> +		ssh_signing_key_file =3D temp->filename.buf;
> It is kind'a sad that we need a fresh temporary file every time, but
> we can easily tell the user in the documentation that they can use a
> file with a key in it to avoid it, so it's OK (actually, better than
> OK, as without this, we may not consume temporary files but we won't
> offer an ability to take a literal key string).
>
> Is ".git_whatever file in the current directory" a good place to
> have this temporary file?  I would have expected that we would use
> either $GIT_DIR, $HOME, or $TMPDIR for a thing like this (with
> different pros-and-cons discussion).  At least it is consistent with
> how a temporary file for the payload to be sign-verified is created,
> so let's leave it as-is.
Intuitively i thought just using mks_tempfile_t() would choose a good=20
dir for such files.
>
>> +	} else {
>> +		/* We assume a file */
>> +		ssh_signing_key_file =3D expand_user_path(signing_key, 1);
>> +	}
>> +
>> +	buffer_file =3D mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
>> +	if (!buffer_file) {
>> +		error_errno(_("could not create temporary file"));
>> +		goto out;
>> +	}
>> +
>> +	if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
>> +	    close_tempfile_gently(buffer_file) < 0) {
>> +		error_errno(_("failed writing ssh signing key buffer to '%s'"),
>> +			    buffer_file->filename.buf);
>> +		goto out;
>> +	}
>> +
>> +	strvec_pushl(&signer.args, use_format->program, "-Y", "sign", "-n",
>> +		     "git", "-f", ssh_signing_key_file,
> Wrap the line before "-n" to keep "-n" and "git" together, if "git"
> is meant as an argument to the "-n" option.
done. some things clang-format can't really understand. overall it is=20
quite helpful but a few things i still had to reformat.
>
>> +		     buffer_file->filename.buf, NULL);
>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +	ret =3D pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
>> +	sigchain_pop(SIGPIPE);
>> +
>> +	if (ret && strstr(signer_stderr.buf, "usage:")) {
>> +		error(_("ssh-keygen -Y sign is needed for ssh signing (available in o=
penssh version 8.2p1+)"));
>> +		goto out;
> This error message is important to give to the end users, but is it
> enough?  That is, unless "usage:" does not appear, we show the whole
> raw error message and that would help end users and those helping
> them to diagnose the issue, but once the underlying program says
> "usage:", no matter what else it says, it is hidden by this code,
> since we assume it is a wrong version of openssh.
>
>> +	}
>> +
>> +	if (ret) {
>> +		error("%s", signer_stderr.buf);
>> +		goto out;
>> +	}
> Also, prehaps
>
> 	if (ret) {
> 		if (strstr(..., "usage"))
> 			error(_("ssh-keygen -Y sign is needed..."));
> 		else
>                          error("%s", signer_stderr.buf);
> 		goto out;
> 	}
>
> would be easier to follow.

I have changed this to:
if (ret) {
 =C2=A0=C2=A0=C2=A0 if (strstr(..., "usage"))
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 error(_("ssh-keygen -Y sign is neede=
d..."));

 =C2=A0=C2=A0=C2=A0 error("%s", signer_stderr.buf);
 =C2=A0=C2=A0=C2=A0 goto out;
}
and removed the if (ret) further down in the function that had no effect.

I had removed the raw stderr output from verify & sign because it=20
becomes quite unreadable when doing a "git log --show-signature" with=20
ssh signatures present and not support in ssh for it.
I think in case of signing the full output is good. The user is taking=20
an active action (wanting to sign something) so we should give them all=20
the help we can when things go wrong.
The output for verification is debatable. The config might have a=20
"log.showSignature" for verifying gpg signatures and when ssh signatures=20
show up we should tell them it's not supported on their setup but=20
probably not showing endless lines of errors when they do a "git log". A=20
"git verify-commit" might be a different case. But code-path-wise this=20
is the same thing at the moment.

>> +		error(_("ssh failed to sign the data"));
>> +		goto out;
>> +	}
>> +
>> +	/* Strip CR from the line endings, in case we are on Windows. */
>> +	strbuf_trim_trailing_cr(signature, bottom);
>> +
>> +out:
>> +	if (temp)
>> +		delete_tempfile(&temp);
>> +	if (buffer_file)
>> +		delete_tempfile(&buffer_file);
> It is clear that the latter one was holding the contents of the
> buffer to be signed, but reminding the readers what "temp" was about
> would be a good move.  Perhaps renaming the variable to "key_file"
> or something may help?
renamed to "key_file"
>
>> +	strbuf_release(&signer_stderr);
>> +	strbuf_release(&ssh_signature_filename);
>> +	return ret;
>> +}
> Looking good, except for the "when does 'ret' get updated?
> shouldn't we refrain from reading the resulting buffer when it is
> set?" question.
>
> Thanks for a pleasant read.
Thanks a lot for your support with this!
>

