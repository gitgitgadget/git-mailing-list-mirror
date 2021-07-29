Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE50C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 09:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985EF60FD7
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 09:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhG2Js1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 05:48:27 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:34685
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235019AbhG2Js0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 05:48:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cw+/fD9hJIn5+dQUM9Oe333axwMEXpAkTBDXDU+/TmrCjNQ1BG+hYsTHo6nbMJw1EzZ0c6J4p+7a2JOyV3WWZkpVpVWL/GtpKzUxD65LO6FROXi5msD+QRF9S45u4SCk95bbxGzmlRJrFKjXaYNEafFcs83xvp8eTH/D0aILVSJOc1Zuxrptc6IH0OT+4y3EgzkTeRw90DSaEiDpTAtkoU7jglXdA/qnd1mf9wBAKav7Qr8MaiD6OlJGE0mD0/VVIw6EduzYFqHYyGBvEkgukM3AL2yNbVlbzenOV5aT5/Rp2FyDcnoMD7WbBmxGjdxBwubYZPLZqGM0wlPFZjYKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuse2hpTkFdv2ryCNHGiVqldEDXGQmYU4r3319LhmAw=;
 b=KHXnX/+3QGwXSJEK+NsrkhqLBLSKIB0s3PBWJUwctmWv3znp4nb/7Oo2025MoabkgeXJCl47MFLRpNqj5+tjBiNYbvBNlATleNDBbjm9vGb/Zb5RsFX9yXP32JucenDivuqaYVX3RThS7Lf7bbrQgfVy62eE2Nm8hOz4Je/pb8AndMXk0qk7prSSAv/wv82X45PmHN4+aAhgtzw+hR+yspCxpbg6Y3jmEIjjIgjVDtfNf4jMtH6X99PYskbF9n8oyK8OA3E5lbjIyRFMMfn5uHXp2K4qL/VEmc9dftZXMz65wtnSY2X2WF+5sJtYLexlpI+TRmxRgrbbBWXm18aF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuse2hpTkFdv2ryCNHGiVqldEDXGQmYU4r3319LhmAw=;
 b=OsFb32XxCooQLwc2qnpy8g4fhpfgvoIszGEt7hOvG5d4n99DdQ5b8mxrRu+5495eEjRJURC29x551aAofLfqfkFtliTTo3OK+X4sijaV39tWq31wFMUFR5m9QZ3SehM1kJMO8BiyigVz55Aki3v9/qj+wuSccBDJYbTUZstINjc=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
 by DB7PR10MB2090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:d::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Thu, 29 Jul 2021 09:48:20 +0000
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178]) by DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178%5]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 09:48:20 +0000
Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify
 signatures
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
References: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
 <20210728230452.2719333-1-jonathantanmy@google.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de>
Date:   Thu, 29 Jul 2021 11:48:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210728230452.2719333-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0135.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::27) To DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:259::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR0P264CA0135.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 09:48:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6497b72d-6bfc-4ff0-7bfd-08d95275ffa3
X-MS-TrafficTypeDiagnostic: DB7PR10MB2090:
X-Microsoft-Antispam-PRVS: <DB7PR10MB20904ABF455FAB832B65A53FB6EB9@DB7PR10MB2090.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZY5m8BI1V+uzIsccSKl2lAY4KeYoQsz2PCMf2VwyIm7Iu+4uYgli7C9jCY3itgCCrEUJHc0ORZ8CxUX/5+y4Hk87dQMiCUxsaplZYKGScsw6vFQxOGMi7RHcBQcMoLnu+7qy3Ygv2huqSFYWy+tPaaM1Ybzd1/rq7BFEOKI1dMj65jacQKe/+28q3csWYXXRcKHZpqB59bd10u5gkB8G2nmwM459SPm4aegQt9qwK9V+hhWzEhiqarWXQuBlPM1q1m6S3vyx1vBSi4uHFxzRFH6GSAfEd2ED0XnlYL3gYQsH563Y4S46zYh5Kmw3VSYdnMtdACpABsJ/qEumU2K22yJORK4uhcAf6/n8AgWGPO/+bGR0jf955TKcDc59Odu+l1AcUp4llUHgKWuK5fysZgJO8McYepVOKdect/lfjslnY9bGIqlbIAO+Hb5QrdYQ6UtlbMZcE3Pd2hlP7hcCuG5xtyvCMavTq0T1zpby/IlUi7MsstkGoX1YtkoAcEX8/vhe1qlYUpG4wDxiWL2Ni3hiPjFmorxMeeTlCU+GIcI54nad4Fd4nfwjJQhxwCpK5EJkts4394bdln6bwuaLwFlSDCmoe/RJtzG7oTqKKhb1XJGMIkwCgBgTABwEZ93JOYdmolCGXalFVaZxZBBj5pMRdODnrM0c1vqSjSHmjJfRcUf6F/G4xZYBnTTyq5hUIjDRYwdZaUo0bm4ZWhahF4Oh+Q6uuQOcgrYDYWRYBHyjmwre8H3b07nGX/TZYzG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39830400003)(6486002)(66946007)(186003)(31696002)(8936002)(7416002)(8676002)(66556008)(66476007)(86362001)(4326008)(316002)(36756003)(478600001)(5660300002)(31686004)(52116002)(53546011)(2616005)(83380400001)(15650500001)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE9XbXY1OXFMODlmeVo1TllGcVp5RWRZQTdkSFJIK3NPVlp3TGxnamhjUkVq?=
 =?utf-8?B?Q3YzSkNRUzRpY1U5aEVmVWRrUXBWeXZUR0t4K25wbVFRMm01SUQ5OUsvYmEr?=
 =?utf-8?B?VHBPUnpmUEsyclU3dmxuRlNuMDFOcks0QTZtVGg1a2NoQVBlV2NEc0ZxNG84?=
 =?utf-8?B?Lzd0cGxLN0xlZTIrM2RnVmVtWURrc3ZPeld2OGJTTE9QYjBQRjBxaHkyUURl?=
 =?utf-8?B?b1M2YW1hVmcvenZoeTZmenhiQ213T2NxZGtDckZGTnVxWUJlNXpqSlBnWUtp?=
 =?utf-8?B?S3pXaS9zL1MyZ2Nyd0I4eGdsVzdpelBsdGx1S3lKQ3F1SlhUYjRmU25xaVdr?=
 =?utf-8?B?amhsRTYxWWFvYlh6OHNBNkFZTXBSUTV5Nk5JUGR5M3Y0RnRrd1pKcGl4WjdT?=
 =?utf-8?B?eVJZZnlSSDBLZGNtVVdSc1cyZ2ovdlR1UTk1bkhiOHJmK0ptV0VMZ3VWWmFE?=
 =?utf-8?B?SzBoUk9CQkVFTUN0dzJEQXhNdTlLV1BhNXJIQzJFanUweFlWaVFmMXJzeVVy?=
 =?utf-8?B?TDIwbGRSZlh4endwYTlMM1hZQWYxdmFMVjJ0UW5ub0xiVEtWdzVxNVhpN01M?=
 =?utf-8?B?dE1IbWp6UHp0UVY0b1UreUlYdnAwYUpuN01lbkpia005dzZSa2l3RUM0M0Zo?=
 =?utf-8?B?UThUUkppZmk3UDcwaExkNVl2eWswcXp5VHRUM0tidEJxcHZKUkZWbzM4VytB?=
 =?utf-8?B?eHlIWWxmd1l3cmkyRkJweXVSOSthWFIxU2RyeG1sV0F0bndvZldlanRzWXlW?=
 =?utf-8?B?amloQzdURmc1QnRJV1YzVVZua0xCZGhRZlluaGxuNkxCQm8xczR5SlR1MDEv?=
 =?utf-8?B?Q29jbXVvVE1kdldtNTJ2Rjk3eVhsYzBVcStjNE5RUXZnRUFUa3ZybHk1NkJv?=
 =?utf-8?B?WU9mRmdJRmZzNSt4K0lGcWpQOW9ZZ2ZQOXRHZ3FLOG8vdnFDZzY1QTVRc21j?=
 =?utf-8?B?aUpxd1lKc0NyNFVYNkl6bGlBVjF2T3NwSkpibVpucGlYR0w3S2dGVHZqU3RL?=
 =?utf-8?B?UXdEbmFPNXpmS1huN2owaERWd0xzd0JBRWV0UjdPdkhNQmNaSWZ1eHFkdWJU?=
 =?utf-8?B?RmppbmM2WGt2TE04dEQ5YkJocTVEK0dtc1Z0L3dTSlpYeGgyZmd2Y1ExRVkx?=
 =?utf-8?B?bzlJRmNSdGlldmxJam81SVh2Rk5ZcTdIWEppVlUyd2p3bVlJWnJnbmxLaVFD?=
 =?utf-8?B?Y0txbTNVU2FYblk5K0dyb3lDWWdQSXFJU3lqZ1dOaGl3bTdqaFBYYk9JbGVz?=
 =?utf-8?B?dEtrSmREenYvUW42NjdkTy9tMGNHNER6QWZxeE9rT2QvdnlFNFArbVZycitl?=
 =?utf-8?B?NEFrVFh3NTBhYkRNRG1EMVhuZkdGdC9QQmt0KzhROHkyREttZytSNHJsTHNO?=
 =?utf-8?B?bmUwQmlDYmxmbHBRTFZkL25OOWhueklnK1VJQjZaYkhpQm5UdHFGb1U1TGxL?=
 =?utf-8?B?MGNEdVVnWVVoTUJYQUFwcmx4SkpaNzFqb3RmSktpV3BuZ2EwWi81d0pTb0pQ?=
 =?utf-8?B?Wlk0dTUxTDJqN2RqWStoMk9xN2dDdDRpTExPbGpZMGI2cC9ZSUpickpFVmdu?=
 =?utf-8?B?Unp3R1J0aWZMWUdlQWY0K2lVQ0RFZ29OMHJIdEk5ZzA4cXg0bDY2bkM4UXpF?=
 =?utf-8?B?aFJGMEhSQi81QkJtTDU4UjFaOERNYUhEU0thOGdTR3ZqQzM1d0p5QndDYWIv?=
 =?utf-8?B?b3FQOFlnM1ZaMEgxam0ybmZoU1d0YXhJN0VSVUZhb0RWWWpPb05Uckg4R3NS?=
 =?utf-8?B?U2xWU01SUUNZc1BoaEpidkdPQWFkSkVScWNCbmJQcXdhVC9xQ21VZ1REQ2I4?=
 =?utf-8?B?ZzZOYVhPckZvSXVmTjYyT0U4cEJheG5GQXQwNVpmSnZiQkdyRENhT2daSVhU?=
 =?utf-8?Q?JF1chibUidbsB?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6497b72d-6bfc-4ff0-7bfd-08d95275ffa3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 09:48:20.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91+N+AAexbtHy7s0rTWKkVbnLaQ55D6ZjTMSAWjFFV+XYVczCoYlLqWvtbXp6AppO9aiyNSJUXKpTB+4ZmCBHvhOJqDcmImA9QVeEdLs5Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2090
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 01:04, Jonathan Tan wrote:
>> to verify a ssh signature we first call ssh-keygen -Y find-principal to
>> look up the signing principal by their public key from the
>> allowedSignersFile. If the key is found then we do a verify. Otherwise
>> we only validate the signature but can not verify the signers identity.
> 
> Is this the same behavior as GPG signing in Git?

Not quite. GPG requires every signers public key to be in the keyring. 
But even then, the "UNDEFINED" Trust level is enough to be valid for 
commits (but not for merges).
For SSH i did set the unknown keys to UNDEFINED as well and they will 
show up as valid but not have a principal to identify them.
This way a project can decide wether to accept unknown keys by setting 
the gpg.mintrustlevel. So the default behaviour is different.
The alternative would be to treat unknown keys always as invalid.

> 
>> Verification uses the gpg.ssh.allowedSignersFile (see ssh-keygen(1) "ALLOWED
>> SIGNERS") which contains valid public keys and a principal (usually
>> user@domain). Depending on the environment this file can be managed by
>> the individual developer or for example generated by the central
>> repository server from known ssh keys with push access. If the
>> repository only allows signed commits / pushes then the file can even be
>> stored inside it.
> 
> Storing the allowedSignersFile in the repo is technically possible even
> if the repository does not allow signed commits/pushes, right? I would
> reword the last sentence as "This file is usually stored outside the
> repository, but if the repository only allows signed commits/pushes, the
> user might choose to store it in the repository".

yes, thats correct. I have changed the wording.

> 
>> Using SSH CA Keys with these files is also possible. Add
>> "cert-authority" as key option between the principal and the key to mark
>> it as a CA and all keys signed by it as valid for this CA.
> 
> Is this functionality provided by SSH? I don't see "cert-authority"
> anywhere in the diff below.

I'll add "See "CERTIFICATES" in ssh-keygen(1)."
It is a SSH feature that i just wanted to make people aware of.

> 
> Also, I notice that the tests are all provided at the end. I think that
> it would be better for the tests to be incrementally provided along with
> the commit that introduces the relevant functionality, so it is clearer
> to the reviewers how it is supposed to work (and also for us to observe
> test coverage).

The problem is that nearly all of the tests use both signing & 
verification of signatures. I could move the initial test that creates 
all the signed commits but probably not much else.

>> +	git_gpg_config(var, value, NULL);
> 
> Check the return value of git_gpg_config() to see if that config was
> processed by that function - if yes, we can return early.
> 

fixed


>> +static void parse_ssh_output(struct signature_check *sigc)
>> +{
>> +	const char *line, *principal, *search;
>> +
>> +	/*
>> +	 * ssh-keysign output should be:
>> +	 * Good "git" signature for PRINCIPAL with RSA key SHA256:FINGERPRINT
>> +	 * Good "git" signature for PRINCIPAL WITH WHITESPACE with RSA key SHA256:FINGERPRINT
>> +	 * or for valid but unknown keys:
>> +	 * Good "git" signature with RSA key SHA256:FINGERPRINT
>> +	 */
> 
> Is this "ssh-keysign" or "ssh-keygen" output?

ssh-keygen. ssh-keysign is only used for host keys. But the names can 
get a bit confusing sometimes. i changed it to ssh-keygen here.

> 
> Also, is this output documented to be stable even across locales?

Not really :/ (it currently is not locale specific)
The documentation states to only check the commands exit code. Do we 
trust the exit code enough to rely on it for verification?
If so then i can move the main result and only parse the text for the 
signer/fingerprint info thats used in log formats. This way only the 
logs would break in case the output changes.

I added the output check since the gpg code did so as well:
ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");

> 
>> +	sigc->result = 'B';
>> +	sigc->trust_level = TRUST_NEVER;
> 
> A discussion of trust levels should also be in the commit message or
> user documentation.
> 
>> +	if (!strcmp(var, "gpg.ssh.revocationFile")) {
> 
> The "F" in "revocationFile" has to be lowercase. (If tests were
> included, as I suggested above, it might have been easier to catch
> this.)
> 

fixed

Thanks
