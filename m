Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B281FC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 17:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbiAKR02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 12:26:28 -0500
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:59111
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344081AbiAKR0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 12:26:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOfoPhzb+KNXuVAo2NRHUadSWrTOvIe82lEpkuE6KAkjpwYA21+OoO+rChQnBY8nZvFpUx0i4KOYX+/6zRnafSo6Ahcjz0Ng0zUeUw3U5F6j9I9ZDl5xxzQuSXDr88yyF69eEmg3WPTrr8F17guWGQopmYeiobXN/T19KU3HP1tk+NkB+WmZUIu04c3hD2kfJ2yb7orN2cyaYQ38++JUjWu6Pg65k6TP73g2LG0pEIXwU3gJiI1kbwNCgAdoRws8IzltyKLWfTKB+jtxrEVmjwgNPoSYfx78PurYvDmf+GhsgqCH7fEzQ/bZ3apN8OdkVsBopVA81dIEgGuxs3vFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNN1JHtrjsHCZQd2Ih2xkVROxuFOuOK9KVuuKCTHPvM=;
 b=X/H57Gkht8dvdQRw2Lmz8ArX/OqHyhF1aufEvwI/rd3D0AHYgpMIMsq4ylu6z07nfbS0jvwUJpubOsMrpLXYiBWi2ebkEsF595/Mdi2wCLP7kjhVZW9jGYKWFI7Hir53EJUIZSKP5cLzki3JWXVg6ltPMRb5rbMpsUElSd6vqGC7lUUpzUJzTDBUirYNqN1qroIDgu97yYsraFHzUlYbAzGjG9h6Q2AOtoiW+oWulrbYsSOENZuW3PbpCpW8D4HvASovqien64Kn6IvpgtmAMSW4SqJLFdYrVSWtUNpmjq/FrIpBmGmH0BBFFTpLYr9v1/jRqSpalIS7TZNvp7JryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNN1JHtrjsHCZQd2Ih2xkVROxuFOuOK9KVuuKCTHPvM=;
 b=KOfBvZejXG4jEnggZGnmK7iEinIqNU+Eky9q7m4Fm5YbT7BJadDwv0W/Ce0RKnFfUcvVOwb/7278Cd1kkA/2ZBC8h26n3j5/NHAd/tuCKqZLeYD17lI19x1YDHTX9uEVch1vQd6TEjOuFL5bgALbMIcRFmycYe9JOP4zcfhweUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4464.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:106::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Tue, 11 Jan
 2022 17:26:22 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 17:26:22 +0000
Date:   Tue, 11 Jan 2022 18:26:21 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] t/gpg: simplify test for unknown key
Message-ID: <20220111172621.qwupg4oyosvpeguu@fs>
References: <20220107091432.581225-1-fs@gigacodes.de>
 <220111.86r19exl4z.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220111.86r19exl4z.gmgdl@evledraar.gmail.com>
X-ClientProxiedBy: AS9PR06CA0144.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::10) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c74f6d5f-c42c-47f0-95b3-08d9d5277c84
X-MS-TrafficTypeDiagnostic: PA4PR10MB4464:EE_
X-Microsoft-Antispam-PRVS: <PA4PR10MB4464BA7B49A749BF31AED8ECB6519@PA4PR10MB4464.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNN+jR/v9GzuilDev6sY1K/2aIQObsK8cMUR6yedwA8WQ/Ffw6pspC6FC5gZrtM6PjxkJuWY4uAZVlIuCU6u0RrYNX76yAkQqzIC9YvaIUGfZR72lhr/HZarWA+h0NBPSzRHnv5mA+gJIdO795wR7u4HMoRB6yueMTArkumzWBOKrVxl5P9vDSQOHWxnhzxiC+JfO873UQ7sPV4wwv3wVxuwA7BMF5D3dzw3HOFDn88GaUpmRk8yrm6qIFD1KWw+4q+AlO2QUR5QLyvsDloos+7ZJj0h2Q5B215VgKO8nRQBYbXb/kz1yFiBPH9WUhJMwYVWsM2nQ6L3s8yhPy+om9m0Q2zipsi6jQvtKrZLCTJT9ilEdadnggW7kl1wP6K/DuriXTwTakMfvwuJ21B23+Kac0kRwZoGi0+vMuSHE3YvtMKFLcN08//9gUEzPzzH+S2VB2wEYrVKXrmPS9EMS/wqt5lgblB5cH4kHklLk1bsRXx0ATzxawQ520X8qS29LaqbEl7x+3dopk/jH9/T+bgRW9zDXc+ySsjBp/HlUA2MIL8iWvUW/FUCzWRklZzXj+v0TNUd1VnfLHqB9jFWtAIeb2E7TDmSSryecWm6YIggWJNaSlmY+lPqWOq/uXncAyZpRL3L6/pthoJeOb+AgwleMyLiZnVEbdk7NHwAMUl8i1lHGFzG3WHsVMx6LYCwfuKS/oktWYoxVZvMcTik4udzrKFE7452uSPc4CcmGPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(136003)(396003)(376002)(39840400004)(346002)(186003)(2906002)(4326008)(8676002)(5660300002)(66946007)(86362001)(6916009)(38100700002)(7416002)(316002)(1076003)(54906003)(6486002)(8936002)(83380400001)(6512007)(9686003)(53546011)(6506007)(66574015)(26005)(66476007)(508600001)(66556008)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW5kaCtkK25ZMDdiTUVxYkFQRFVRazdZSm1wUG9GRnByc2R0LzNTM0srR0to?=
 =?utf-8?B?VzNzTkQ1cytqcmV0RS84SHdJRXd6NHF5ZXdhYXpGOWtOVnVKQ1AyQ3UrMXdG?=
 =?utf-8?B?R0pqdURyWndIaXliVnNCWEc0cnYzbHowWG1YK0trRWhmVFFFSUFHcHhDZ29L?=
 =?utf-8?B?MFVSZHZDZldNUXRQTDF0RU5hblFxeCtWWE9ocVRMc1QxYzkxR0kySnQ4Vit4?=
 =?utf-8?B?TG1HOTFic3dwU1pucTNyM2wvekFlQXBKU2JNSk83U0xTUkhiM0RvQVc3WnF1?=
 =?utf-8?B?Q2svZ0tCZWM2b1BvK3lvRkRSTmhmbFlhTUZnKzRzbnUzbTRKUDkzK1Q3eWdG?=
 =?utf-8?B?a3RROGV4SEpXOTVCQURRUmxsT0lUQzRhaldDSG15ODdoWVlQVkFjRnFOS3lG?=
 =?utf-8?B?ZWo0NVpVeUM5aEVQYVlFcDRmWk1XR3JlbTUvODJFYUozSWZDVE92NmtSc0xK?=
 =?utf-8?B?SDBBN012bWNENzVma3lqWGcyRWZ6VGtLQXNqQnhDTG5SeEFiUTdIVW85UlFG?=
 =?utf-8?B?OUVtdVE5UEw3eHVwM0FSazhhQk1Sbzg2eUd2TWFsVzhnLzJiSzBEcHY4amhz?=
 =?utf-8?B?bUhRMWZqZUw0N0FkUFdLRW5UeXNqT1kvTVJUZWFtZ1NldWZuTHgzczlzL0Ja?=
 =?utf-8?B?VVVXM2VKYTZGVXc3WGVlN1A3SkdUR2VndmpzMVBaWnk4bC9EV0MyMHo2dFJI?=
 =?utf-8?B?b3dCWmhVei9MNGxzV0VBak1VU2FIYzhzT3BXd0Rzcm1STHBKdEN5bjJDTFYy?=
 =?utf-8?B?RGg1M3dwN2xKTkdPVGVKS1FlTUR3UytIVWNoOTFKZWFjd1hrR29SQ1lUM2JO?=
 =?utf-8?B?M0UwdmVwYjh5M2liWmVxY215TTh6N2xweTRkcDl0ak9IM2R2d1pnZHFKWkdz?=
 =?utf-8?B?S1ZkSFlQRFFldHF5N3pzVFNHMmlQMEY5RGlOSTVJOWhRM2lTQ0xyY3RuV0tz?=
 =?utf-8?B?SEo3VE55NndxTzFvTFg3QVYrYVBNQXNJVVhTYzR0aklxQy9zRStDQWNSN1E2?=
 =?utf-8?B?aHp3dlNGa3JOU1g5SjIxbDI0MEhyM0pkWm43NTZsWC9Nb2c2eFpjNjZVaWxa?=
 =?utf-8?B?dWFPNlhxRHFtNlErSllJYkh3aXUxdU90TFZ2blF4TjIrOEk0WXBoam1rRDNW?=
 =?utf-8?B?akFZM25oWEcwYmFoVmIzc3YzZ041WTJmUGhFb3UwNlMxRHZHRUErcUJjMHR0?=
 =?utf-8?B?eFBzVDhpWWppRWRYYktMdUw2N3FwWXQ1Q2FocWZFUW16S1JnWWxqM2E2ZWhW?=
 =?utf-8?B?eHRSdDE2VGM2L2QwQXFoN1I0alVwcHhCOUR5NEt5VWxVSDJpZzY0c2RVK1hN?=
 =?utf-8?B?R2I4T0tTTmRaSk04NEtHeWlSR0phcmJ2UVdScjk0UWVoM3JhS0Nxa204WTR0?=
 =?utf-8?B?NXYwQWVTZlVtU1ZiaGN0ZmR6NFlVbXFYVTZQOWVqbE90enA3RFRpeU1zdWZt?=
 =?utf-8?B?a1FvdXE2ajFRNW9DTEloUXVVZGRMcE84NWtLdytTbHkyM1QyckxVVHlpbjY3?=
 =?utf-8?B?bk9ZdE1ac2s5YjU1Mmh5eUk3R0NUVUF1a1cvaWU4L3c0U0I5N2JVdG1Hc2Jw?=
 =?utf-8?B?S1VxZXd6ZENjN0VUOFVON1REZzBaZ3VmUjFrTmsrY1p2bzBKUGRsMUZXSERn?=
 =?utf-8?B?c3dsbjFJSnByUFQ5WCtVOCt4VGt3SGtnVXpLQTAxWTRrN2dyVnorVE9SWjFx?=
 =?utf-8?B?VmZDTHJkbkZmMFg1MjhIVDlPcDNZOFZhUlZmb3hKTFpJSkluZDhTVThxeHVW?=
 =?utf-8?B?V0hNak9KWE94bWlrb0drSUJIK200RFJSRTFyYjVoUk11ZzU3UmErMStvVWRv?=
 =?utf-8?B?ays4a212QUZycmVUeng4SDF3dVhSNkdjNjdGenExcm0wb0h3TEp2NFhlNzFy?=
 =?utf-8?B?cXYvR0w0OFhERDd4TG1ETkU4WHVzRWhSbmZYaUlRWUl6UTJZZE9OL2NFZnZt?=
 =?utf-8?B?OUI0UWdRZmtOa3Z1YTYxaHdmemtMSXRGQ2FEaWdYaXMwdjQyYjNQa2lPK3pj?=
 =?utf-8?B?L1gyQ1kvSGs4d21DNXZwYnlSMmhubFNSbXJvci95VWdUOVhMUjV4cTBhTzd4?=
 =?utf-8?B?N0Y1Zk1HNmJzWkNBVVBZOEt5am5lc2JOWmdxM2FrZzVESUtEWWYyWHNHZGtV?=
 =?utf-8?B?dGVWZDNVNXFJNzdhV1U4UUJYQ1ovZ2w5bjFsQ2dLaWVqV0h3bkhGeVlNMW44?=
 =?utf-8?B?WTVMd1R4QWJ0eTJVdlAwN1dxQzNPMk9LSUpQN3ZXZXRqdUtsdDF3NVJjYkNq?=
 =?utf-8?Q?v4ZPk25oMJcsDxRkVGmylIraMlt/YmK5dr1XQUZ3j4=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c74f6d5f-c42c-47f0-95b3-08d9d5277c84
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 17:26:22.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gM9bJUS+GEoK20EAFbOYuac5CTxHYK+uUxuWojl8yjvSkGfkhYx5VqPI4TL2R3r+wwmMCyDbUK+RfedS3gF5B5rhhffgAaBVtJrhlHqTRvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4464
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11.01.2022 17:56, Ævar Arnfjörð Bjarmason wrote:
>
>On Fri, Jan 07 2022, Fabian Stelzer wrote:
>
>> To test for a key that is completely unknown to the keyring we need one
>> to sign the commit with. This was done by generating a new key and not
>> add it into the keyring. To avoid the key generation overhead and
>> problems where GPG did hang in CI during it, switch GNUPGHOME to an
>> empty directory instead, therefore making all used keys unknown for this
>> single `verify-commit` call.
>>
>> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>> ---
>> This was reported by Ævar in <211222.86ilvhpbl0.gmgdl@evledraar.gmail.com>.
>> Just using an empty keyring / gpg homedir should achieve the same effect and
>> keeps the stress of generating a gpg key out of the CI.
>
>Thanks, it would be great to have this in and before v2.35.0. I've run
>into several boxes (on the GCC farm) that hang without this patch.
>
>>  t/t7510-signed-commit.sh | 22 ++--------------------
>>  1 file changed, 2 insertions(+), 20 deletions(-)
>>
>> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
>> index 9882b69ae2..2d38580847 100755
>> --- a/t/t7510-signed-commit.sh
>> +++ b/t/t7510-signed-commit.sh
>> @@ -71,25 +71,7 @@ test_expect_success GPG 'create signed commits' '
>>  	git tag eleventh-signed $(cat oid) &&
>>  	echo 12 | git commit-tree --gpg-sign=B7227189 HEAD^{tree} >oid &&
>>  	test_line_count = 1 oid &&
>> -	git tag twelfth-signed-alt $(cat oid) &&
>> -
>> -	cat >keydetails <<-\EOF &&
>> -	Key-Type: RSA
>> -	Key-Length: 2048
>> -	Subkey-Type: RSA
>> -	Subkey-Length: 2048
>> -	Name-Real: Unknown User
>> -	Name-Email: unknown@git.com
>> -	Expire-Date: 0
>> -	%no-ask-passphrase
>> -	%no-protection
>> -	EOF
>> -	gpg --batch --gen-key keydetails &&
>> -	echo 13 >file && git commit -a -S"unknown@git.com" -m thirteenth &&
>> -	git tag thirteenth-signed &&
>> -	DELETE_FINGERPRINT=$(gpg -K --with-colons --fingerprint --batch unknown@git.com | grep "^fpr" | head -n 1 | awk -F ":" "{print \$10;}") &&
>> -	gpg --batch --yes --delete-secret-keys $DELETE_FINGERPRINT &&
>> -	gpg --batch --yes --delete-keys unknown@git.com
>> +	git tag twelfth-signed-alt $(cat oid)
>>  '
>>
>>  test_expect_success GPG 'verify and show signatures' '
>> @@ -129,7 +111,7 @@ test_expect_success GPG 'verify and show signatures' '
>>  '
>>
>>  test_expect_success GPG 'verify-commit exits failure on unknown signature' '
>> -	test_must_fail git verify-commit thirteenth-signed 2>actual &&
>> +	GNUPGHOME=./empty_home test_must_fail git verify-commit initial 2>actual &&
>
>Before I noticed this thread (I looked at
>https://lore.kernel.org/git/20211230111038.jtoqytdhkilv2732@fs/ first,
>and the In-Reply-To chain wasn't connected)

Yeah, sorry about that. I forgot to add the in-reply-to :/

>I was about to submit
>exactly this patch for you but with:
>
>	-       test_must_fail git verify-commit thirteenth-signed 2>actual &&
>	+       test_must_fail env GNUPGHOME="$GNUPGHOME_NOT_USED" git verify-commit initial 2>actual &&
>
>Both of those are probably a good thing to do here. I.e.:
>
> 1. Didn't we have portability issues with "ENV_VAR=VALUE shell_function ..." ?

I'm not good with portability stuff and trust your judgment on this.

> 2. You're pointing to a nonexisting ./empty_home, but shouldn't we use
>    $GNUPGHOME_NOT_USED? The existing "show unknown signature with custom format"
>    test in the same file does that.

I was not aware of $GNUPGHOME_NOT_USED but it is used in a similar fashion.  
However it is set to the old value of $GNUPGHOME before we change it in 
lib-gpg.sh which seems wrong to me. Wouldn't it then just pick up the gpg 
homedir of whatever the test environment has?
Using the variable is good, but i would set it to a known empty directory 
or?
