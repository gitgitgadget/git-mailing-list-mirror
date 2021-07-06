Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DC4C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2252961A0F
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhGFPgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:36:33 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:14909
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231773AbhGFPgd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 11:36:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxK06EfR8K1sWZK08HSeobmR0besKFYEmfp0XjSAwgKoHMfBbw7g8ir5qvq4v4IeYtWQAUTBVLFXvFNdJb8q0r+bbx5cPsl8pcCAXPRTmyEcUYCUFb4YcyXKjBS0hZUCTNnJcU7+q/xqsR2Jpxu+ODLVU5TloP5sM0DKjYKYLSItP/IHvG+ySg9poVMHCKahuLFVH7l+yO8i1UMLCBayjuL1DmtggHEysU77VlkvzjFQLzwLyFvs31bjtB8VlKM3BS7kRYE1kzEXI6aebS80hhUBuVAxz4vp7mw9iVZLRnwy21UhA4/lkqq6/F7colvGzU+1GL2yOHxy+t2y9u+CUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABMAWoEP8OuxGJ6IalEtD9tUg9hCT591dNWvSSAjzeM=;
 b=HYEMV6vZTWwKV9cy3Cce5C5lv9nGcAzjtusoxeUQl+aMc6ajk1kdhYWISmX+e0sWjTj0H5eXe+Y3XaRjGGusfSwkTw8r82VwuwBPrM0G7mAOiHJCIi+GY4kuMnCKd1BewWGS2xrukuG6rrFp2Gea2MVHWiB0gdAAaMDSCN9KLnDCtD2IXpMj9IHRZyDFykJXKJKKnLpxMEUJ/4mlNqM4zSbv2tWraZTDTLbruRXM/eEJ4FgfETXeSvogMNAfd3AVpmP6Emudp3tBRGmyUaMYcU06Q6hwI2v35mA9oUz3z+SUC6TrBpA+vgAPmkvjI2Otn8HSfI8/5cQ6Gal1cnEX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABMAWoEP8OuxGJ6IalEtD9tUg9hCT591dNWvSSAjzeM=;
 b=rBlwH6cpJaloYBQMBi2mfhxDuh9HMJ4VqvyL/Uo/DI7wguVVfF6Dz0qiSQpCbRproqa0i0KnXUExbmkf3U+hjo4mNlZP5CaAhyiYELsq/4A4rQwkmIih6fmlG4FIMkCdPawx/vOmyyUAiLONZHPeq1dMHQYATLtRyMNKau5STmg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4841.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Tue, 6 Jul
 2021 15:33:52 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 15:33:52 +0000
Subject: Re: [PATCH] Add commit & tag signing/verification via SSH keys using
 ssh-keygen
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
 <YORsVNVC6lVEA7yD@camp.crustytoothpaste.net>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <a45b940f-490b-0b8a-a994-f78d1bb8f90a@gigacodes.de>
Date:   Tue, 6 Jul 2021 17:33:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YORsVNVC6lVEA7yD@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0188.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::32) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR0P264CA0188.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Tue, 6 Jul 2021 15:33:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b023505a-967b-4e20-5c99-08d940937532
X-MS-TrafficTypeDiagnostic: PAXPR10MB4841:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4841CE14A740D968A73381EEB61B9@PAXPR10MB4841.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkYy2vGOlMGBLQtNNeI54coeOz9A4pTYFGKOIzkKJmznWmhaODa6io0OsQJzIFDGbulTqW0BySJ4Xi2/rS1cDxWEcR2koQQZ0fbY0/QOeta1OQi/8HN9rqtTEiY+s7ov0U7G6wL6EBDjiGp8ze2LGQM8rhokvgU40Yj9Wz1S5D8T3XV2f7VQFDvjfVi1AJ/uhiU4iyY5G3wTTB36ZaiCSAYz25ryU08rp8o80RYhGfDIkqxyMEbhzcM7Bfn+K2F5pXv4zNxf4efWLCRkxy2Z/0DdlpZh1bbSw5cDZ/lJasojAFVR6zQMZAhBTjURgscLCigo+u+KJFIWIAy1upvwY0lWKW/xmr6j29ETn+f7uQT3y3aUcidva0/J79/YOjJ6AqF5sbTgX7Oua1rkSyoKMvjYX+N24d9QaHO6/3ccpnDNVFtfbf0C1gpprx94foMty2TfQ8ZYUoNF35tuwwla+z4tnqctRmBtsVoSk7/yXyxIRyFu1vIGeXU0YqlwpqPsH/YopWW7D6sb+xmriN9FcVkEcH0pj/ZYHgRwma5ETV94W6z0bCXnxDTgx6HY2R+XXRMLV9cldmKn5ZJFAMi+bswarkLBE7yJs5la3lGgiH3eNxODgO+exUaMhB7ydlZZjY7MRct7//GQWehOgz7/Jieiw8dbwDgoQ4HX5dJGbIxInkLbxL7xKvYVMrVc7XexLONuyPESn6M74UXjDNf7AWIzFRzeGfCgBkgOuhfXiTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(376002)(136003)(396003)(366004)(6486002)(316002)(478600001)(83380400001)(31696002)(8936002)(110136005)(38100700002)(2616005)(5660300002)(8676002)(52116002)(15650500001)(66946007)(186003)(66556008)(36756003)(31686004)(2906002)(86362001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0lmZ0J6TVQ2V0tJZFVNTDRKQzdwNjYzTTAzQkFpVUd0dnMzanpNVWZCZnkx?=
 =?utf-8?B?SHdrUDZjdnBGbzJWaFhORVVhVy9VY3JNb3c2WmJ3RVFTa3o5eVZuRDhUYXN4?=
 =?utf-8?B?alFpQXhKUG43WDJJS2dBT04xbStST3JhMGFFTVVuYjVNYVdIT2dMK1JrVXVX?=
 =?utf-8?B?QTJRUFhaVDErUWxCSG15V0ovNTlZUThtUUlzY0MvKzFUZGJLVGJJOSsrc01Q?=
 =?utf-8?B?bzFoNTFXZnE1d3Nra201VGV4eno1QzB3SUtrRVRaMElTdC9LTWFHTGFGK0x5?=
 =?utf-8?B?VGNZS2U0eDFrV0xyelByckxuOEx5WGJscXIwZ1NZa2FRWUpWTEJuUnZoL21w?=
 =?utf-8?B?ekFFMWdGeWU5ZE80bXFndlAvMEMwRk9ZSGs3T3V3eEd2MEpHYnNzM3NnSVU3?=
 =?utf-8?B?eWNzVWk2aU1abFRDVXMvTWd0d0srZXNqdi83amJSTzl4ZE4xRnNzcUJ5SVVw?=
 =?utf-8?B?NzR1TG9VcXJlRWlraFV5WjFUc3c3dEVBb1VtUHUvVmEvYkJ0S0ExZmtJREJv?=
 =?utf-8?B?MXMxb0xmcHFuTDdjY084cXY4SUlTNW9SQjVrOCt1dVlCQ2xGTXFHQ2NGTmRk?=
 =?utf-8?B?NVptSjZwWUpwd0ttalkrQ3BESkdPbGJQZkd6SkNLejltcm40RW5jMFVlRkg2?=
 =?utf-8?B?dExyV0dvVUlkS2xoV0JWZUhObm82dGtXQTc0bmUvUStheEFPRFhKNjhCcW1a?=
 =?utf-8?B?a0U1WDlOVWFKR3piR00zcGtJZDcyZ0VnRGRRc2dmR3VWSlhSdWdqaDBZZmtr?=
 =?utf-8?B?ZlozM2tVdXFlT2ZmaWlIOGhxUitXVjJyeFpBUUp6MzdPcjVVcWNtQ1Y5RHpB?=
 =?utf-8?B?L0lHRkRQc1V6QVFhNDhHck9YWkpySExoZHF2bFd4NEhFNlpZeDVRMU1aNE9P?=
 =?utf-8?B?R1QzUlhaK3FlMDNrZG5FM0dGcUdWVlg2dmpmWlZ2Y3VTNkVYUjREblJYVnNF?=
 =?utf-8?B?Ym5nRDd3QjZXRWtJbFIxakhJQTlrN0grYWQveUNLVUpGRVNJSWp6QXNjN3Fq?=
 =?utf-8?B?cnFWbnhVU3VESUlYRTZ2WGFiKzVIUG5wNk1tUUpvU3V5NkorZU9HV2JqclRh?=
 =?utf-8?B?bUhSakdnSE1aUVlISXFFd0JVQWFlekl6N0pic241R3JXaUQydjVjcVQ4T1Fp?=
 =?utf-8?B?MVpqTEFqR3VieHlXcDUxbC9XZ1E5QXg2TXRnY0F1aFJ1NXdzUGpuQ1JZVHcv?=
 =?utf-8?B?a1dnOHdYdCtpNzdCb1hVeTdyZ3dabHNDN3FoSVY3Sm5MUzZienNmK2ZoQis4?=
 =?utf-8?B?SHJaa21tMDBsSnNVc1ZMS3F0T0Q4TWhGcEdXemhOeGMrZXhBL3lpcko4dlBq?=
 =?utf-8?B?bGhlMHMwVzNJOXZwZkZtbUFUa3lIekRML2sxOTNLSk0rNkJSakpGeWIzVFhi?=
 =?utf-8?B?cnpuMk9ZcXFkOEExMjBiRFpZZ1Z5aVpMT3RqUE83Y2ZOUitRampCd084dmFv?=
 =?utf-8?B?cVFmV09mVllReTVXZkFFdGdDYnpTYmtjMWZwY21PMXBPTjVFQzgzUlhRR1Mv?=
 =?utf-8?B?NmlhSElEc2U1N3N0cEJmL3FOY3hzOWI4S3NMVGFRdEFMdGR3QnYxZHhQcHk0?=
 =?utf-8?B?d0MzTGR2cmEyM1JLRXZUK3J4WjYzSzhTaVlpMFlmTW1sS1QxeGlZZ3ZnQzlv?=
 =?utf-8?B?cFpOenQxK3N1elppWXVmTlk0am5Qb29pRjlIay9vdUx2VEhBbWxkMEhUZ1VX?=
 =?utf-8?B?VTJkTE5nVUlMaEhpNXY1K0NuQk1mWW1PSjl3SFp5Tm9HckM3bDlnNGtlR3Rw?=
 =?utf-8?B?OTJtWjVSVTRreTBBYytHcXl4bEVwZm8yTmlwQTFZYXMzT21XeUhIVlk3NFNE?=
 =?utf-8?B?dHhqaldBelhLYzJucUYrZTdDVFhDMFE0dFJ3bnNWZ1ArLyt4a3RKNkM0bHZu?=
 =?utf-8?Q?5/Hrjxj8WwPht?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b023505a-967b-4e20-5c99-08d940937532
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 15:33:52.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riIRaZGsmWICL74hokPP7+DmhffgLzT3nzB49khOEF+Pc97kHU1lRA+Y4r/CGAWZ8mXX282IjCIfngkl39jtSvzy/CX8M9F+URm90mtTuYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4841
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Fabian Stelzer <fs@gigacodes.de>
>> set gpg.format = ssh and user.signingkey to a ssh public key string (like from an
>> authorized_keys file) and commits/tags can be signed using the private
>> key from your ssh-agent.
>>
>> Verification uses a allowed_signers_file (see ssh-keygen(1)) which
>> defaults to .gitsigners but can be set via gpg.ssh.allowedsigners
>> A possible gpg.ssh.revocationfile is also passed to ssh-keygen on
>> verification.
>>
>> needs openssh>8.2p1
> Usually we'll want to write the explanation here in full sentences with
> typical capitalization.
Thanks, i was unsure about what to put in the commit and what into the 
cover letter.
I'll fix this with the next patch update and move some of it into the 
commit message.
In our env the commit messages are usually kept quite short.
>
>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>> ---
>>      RFC: Add commit & tag signing/verification via SSH keys using ssh-keygen
>>      
>>      Support for using private keyfiles directly is still missing and i'm
>>      unsure on how to configure it or if the pubkey in the signingkey field
>>      is such a good idea. A SSH Fingerprint as signingkey would be nicer, but
>>      key lookup would be quite cumbersome. Maybe storing the fingerprint in
>>      signingkey and then have a gpg.ssh.$FINGERPRINT.publickey/privatekeyfile
>>      setting? As a default we could get the first ssh key from ssh-add and
>>      store it in the config to avoid unintentional changes of the used
>>      signing key. I've started with some tests for SSH Signing but having
>>      static private keyfiles would make this a lot easier. So still on my
>>      TODO.
> I think user.signingKey could be helpful for signing here.  That could
> be a file name, not just a fingerprint, although we'd probably want to
> have support for tilde expansion.  You could add an additional option,
> gpg.ssh.keyring, that specifies the signatures to verify.  That would be
> named the same thing as a potential option of gpg.openpgp.keyring,
> which would be convenient.  Also, gpg.ssh.revokedKeyring could maybe be
> the name for revoked keys?
The problem ist that looking up a key by fingerprint alone is not really 
possible with ssh :/
A referenced file (which could contain a public or private key) would be 
fine and i could return the fingerprint in the get_signing_key api which 
the pushcerts code uses as "pusher" info in the cert.
I'll change the keyring naming to what you suggested. Makes sense to 
have this option for gpg as well.

>
>>      This feature makes git signing much more accessible to the average user.
>>      Usually they have a SSH Key for pushing code already. Using it for
>>      signing commits allows us to verify not only the transport but the
>>      pushed code as well. The allowed_signers file could be kept in the
>>      repository if all receives are verified (allowing only useris with valid
>>      signatures to add/change them) or outside if generated/managed
>>      differently. Tools like gitolite could optionally generate and enforce
>>      them from the already existing user ssh keys for example.
>>      
>>      In our corporate environemnt we use PIV x509 Certs on Yubikeys for email
>>      signing/encryption and ssh keys which i think is quite common (at least
>>      for the email part). This way we can establish the correct trust for the
>>      SSH Keys without setting up a separate GPG Infrastructure (which is
>>      still quite painful for users) or implementing x509 signing support for
>>      git (which lacks good forwarding mechanisms). Using ssh agent forwarding
>>      makes this feature easily usable in todays development environments
>>      where code is often checked out in remote VMs / containers.
> I think some of this rationale would work well in the commit message,
> especially the part about the fact that using an SSH key may be easier
> for users and the fact that it can be well supported by smart cards.
> Those are compelling arguments about why this is a desirable change, and
> should be in the commit message.
>
> I haven't looked too deeply at the intricacies of the change, but I'm in
> favor of it.  I would, however, like to see some tests here, including
> for commits, tags, and push certificates.  Note that you'll probably
> need to run the testsuite both with and without
> GIT_TEST_DEFAULT_HASH=sha256 to verify everything works.
I'm working on some tests but there are lots of GPG / GPGSM tests in the 
suite and i'm unsure of how many i should duplicate.
Thanks for the info with the hash setting.
>
>> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
>> index d94025cb368..fd71bd782ec 100644
>> --- a/Documentation/config/gpg.txt
>> +++ b/Documentation/config/gpg.txt
>> @@ -11,13 +11,13 @@ gpg.program::
>>   
>>   gpg.format::
>>   	Specifies which key format to use when signing with `--gpg-sign`.
>> -	Default is "openpgp" and another possible value is "x509".
>> +	Default is "openpgp". Other possible values are "x509", "ssh".
>>   
>>   gpg.<format>.program::
>>   	Use this to customize the program used for the signing format you
>>   	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
>>   	be used as a legacy synonym for `gpg.openpgp.program`. The default
>> -	value for `gpg.x509.program` is "gpgsm".
>> +	value for `gpg.x509.program` is "gpgsm" and `gpg.ssh.program` is "ssh-keygen".
>>   
>>   gpg.minTrustLevel::
>>   	Specifies a minimum trust level for signature verification.  If
>> @@ -27,6 +27,15 @@ gpg.minTrustLevel::
>>   	with at least `undefined` trust.  Setting this option overrides
>>   	the required trust-level for all operations.  Supported values,
>>   	in increasing order of significance:
>> +
>> +gpg.ssh.allowedSigners::
>> +	A file containing all valid SSH signing principals.
>> +	Similar to an .ssh/authorized_keys file. See ssh-keygen(1) for details.
>> +	Defaults to .gitsigners
> We probably don't want to store this in the repository.  If OpenSSH has
> a standard location for this, then we can default to that; otherwise, we
> should pick something in .ssh or in $XDG_CONFIG_HOME/git.
I'm not aware of a standard location. I think there are use cases to 
store this in the repo, but i'm of course fine not defaulting to it.
