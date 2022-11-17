Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977B9C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 17:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbiKQRSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 12:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiKQRSU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 12:18:20 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2077.outbound.protection.outlook.com [40.92.50.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9226786CB
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 09:18:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3FVI/pVa3oXS/qgbgPu/HYSYoXNcVEpt9SKQ7na5CrOsJ1Rn5bIXGwA4OyU5eZhgnxtjy73jVg+L0PzqzFeiUqUJ4IuwKLx8uWNaCr2Mzv/oLBhMYlxSgcdZI6wrtxKrI1FiY75cFMygm3fMFjRwPxLRh/wHGrJlbCh+hzKL23EqBvkf6I08bPO5G91OjMDPe+7uC7vG8JSWWengzQBgeNXb2aRewpbQWr0YzRNUxsNwgmBC1j2gN41UOvnkfJnYb5pvaZtzU7nA2KPciP82FUTldGk7A0Dxk1TG+1FBgr7FhGb1iGGFCiFfJ1Bhnwrl2uIDk2w64mlv69DRWK/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V+GmgGWz7J1t5UpE3ijSGMC58vAiIEj4Gj9wEDMTOQ=;
 b=bHDNFHkHdJ7zQZoIKbI0WJtuu6sD/koqrQMQ7669X543cld7Vxjf/u0mulUMTMzZNHCEe3kWxA9mNHDkV5SbI5MnI44YjO1kSJMq9/LyZGtIs6+UcWhLgy1ZZczdFLMEzvRzYlYXeUpnTeMXhJdEYwBmA1pLPP0AxaxLIXKDGJFTw8/yBcWoScwYiMD6ObcdUmNgx8BUk9Hk2bfSDbwQouyM4T4nKYpkhKTfHjFR6n8uh0EU1ZaNtwKXbz25SX5Mo2W01s+zriy3CdFgnh1aAFHHYQLEQnDfkMMOvSbH1vEZYqd5f3RZVEiK9a1uBpirK3YcyR3VvSmJZJ/qGp46Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V+GmgGWz7J1t5UpE3ijSGMC58vAiIEj4Gj9wEDMTOQ=;
 b=cw/TheI0A+E6GHcl4hikpCf2yH8GiXQFM0JZP1mAqtppmM2lq7hILSg1c0asUqnrpwsIU45bIQMkFJNw2feVGcZZikwKXDVMpvY/pdLpdGr4A7Qp2wgW7Bi7V+uXYhI2zMYrQYdV6NhYDJfY2azCh+XA6pnXx2ycq9uQj2YYb9bIucheVm+ebJ7PQkmsiFJp6wMpqROq6s+/7MWDVXvNdTJV8yEsbzOVytXu4ukcTPJzgtj6KOZFAxkjDFvnab9uYVV4NlbMEKLRYGZ3V8VJboLndW8Dby9N6nW+Kx5MqiC0nmr/WO6D6qYAH22QtXKuMP3KDeigQqYxqJIPRGoOAA==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AS8PR03MB7461.eurprd03.prod.outlook.com (2603:10a6:20b:2eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Thu, 17 Nov
 2022 17:18:02 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::e829:a187:754:6a85]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::e829:a187:754:6a85%3]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 17:18:02 +0000
Message-ID: <AS2PR03MB98158D49DC655F6DC6D10ECDC0069@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Thu, 17 Nov 2022 09:17:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: The enduring popularity of git-credential-store
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
        "peff@peff.net" <peff@peff.net>
References: <CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com>
 <Y2rdw7RD8mGTF40w@tapette.crustytoothpaste.net>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <Y2rdw7RD8mGTF40w@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [Qh2L2yJ2Fv6Ihm0GW5VJ3TYZwUhb/srhkrqsm2i/BQY/48gtncFRVQbHdAjyxyIU]
X-ClientProxiedBy: BYAPR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::16) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <775ef7c9-4e4d-be69-5240-22ef70abfb21@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AS8PR03MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: d66ef34f-adf9-49c3-8577-08dac8bfad15
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkp+RhmyaoGoi3K2zOIUPuiB+KnW68dEZZfCO5XeMjVF9UgW+oDELt16ZDC5YbfKJs5M7Tw2SRGrj5F1m5ZahCTt9/iEamsnBd22QlRKS3fjDXulHqgFdHcQwrjCeT3Butgll7A1RxFrx1pBfITIGUIfyGn6gySM0Hw8amA1uVmsGF8hcBc+lyEOsz4uLXDJZnLIOBjlOi70uoZCCHONpqvS+KDO8idbQeO7YFrlVru9OFc93vecJeQ0pSayu9JkoI9dmkojqRhgKbnRmYOEmBjFQKf+vNBBY0EeB/VC20agE0NQKPv40uydor3e/ZIoLsM/8j14POYw7wUdYKb8VJQxI4bHbcDCCw4jPYnKlnmmXIvAOOTB8i8t7kqjifZ51vbrqZPZzx6DFxGxVjprgra5GIHqtvgyecm37Hz+G2O72Kl0AD5ljRZszyckz9dwtNoIk4UvBPe+duXbC7xL9UAHaNDtp+qjAodzux4CIDfkJiZfXlXbuz92so4Q5R3gPdFWWeVrLa1goT6VcDT/GKNornJaa2FSbJie4uvYU8YmORRCF5P3diBtbJmqd8dDgxscRNQpXu6QiDCxcTwk/pdPH0KwCukg0VnWLaP1Tjsiw7Sq0fLdoFPK5bHmM3pjv3YInCrsrdYMPb3Y8PNdmUE/kIzZGhkiIMEdOj+EUOceaptDD6yzxliyuqefrgoj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNOT2oxTDdxUVd3bXRDMlpkeUlZZVhNdHMzOVhaMm9yK2lSSmZOSXZHOER2?=
 =?utf-8?B?T1JuR2Y5WVp4NDlpZm1aVlBCTkpzVkJKNzA3OVplMVBOWTJOVHlGTDFKOXVG?=
 =?utf-8?B?R2Z5am9ZMDFoeHJYcXBLdG5rYWdWZGtRWEJNMWdGSUdXRGRneFp4ZGVwemNz?=
 =?utf-8?B?d2Z0dzM4dkxtaWlsMmpGK1NkRUVQTkVPOVA4K0pCUTBRczVBd2lwbW1kVnIz?=
 =?utf-8?B?eWtqeUNoMVhzNjNTcEZhYjlxUGF3cXFTRFA1aDdHRTFxSGRiOVhrZW1xeGRH?=
 =?utf-8?B?R2ZVT0lXU2g4UUd6N3puSTFMM0lMVlUrR215V3U2TUhTYkFGOWE5dGlUMEJ0?=
 =?utf-8?B?MnFzWkdOMHBxUkc5VmNIbk96ZDJ1SDRKc2tvWk8wV1IwMm9TVUJBeHpHakFn?=
 =?utf-8?B?dktQcjdYMG5kQ0t4aHRmOFptTDU3bmltUUw3NHlnT2U2VGtGQ2lrVFBqT3Js?=
 =?utf-8?B?ZUlrQ09DTUdnVVdkaVZtOUFpeU9WUmUvS3lkV3hLdG5EbURSU3lTRXV4d1cw?=
 =?utf-8?B?SHFJL0JueXNRYUh5REJ2VDZObTZwTUp5NUlMNE85Qk4rbVh3MDF2M3gzVEpJ?=
 =?utf-8?B?Q0VYQWNsNnpPK1ExTUhtS0NReFR3NmlTOE5vMEQ4Q3QrK09EYjVwVXErQzhh?=
 =?utf-8?B?SG03QzkxRlhYRy91bG5abkFILzB6RHJVMXd2RkR6eHFYSGRIUlpnRXUzVTEx?=
 =?utf-8?B?QnoveElKUEVHYS9TWVRiQU5NY01qeE92eGo1ajZEREV6WWh0S1dOQWRiV2Ir?=
 =?utf-8?B?RjBGK0YyRjd4bGpmcEpWU0ZOSytYQi9FaHJtZzJKMHkrOWE5WFBVOFNYcDZz?=
 =?utf-8?B?bDZOZjdxd0I0bjFXTWo0MnpWZHRlWGZuVWZPeTRLUEhQVFg4dUgvclhYVlVn?=
 =?utf-8?B?RzBqbXo4Qkk0a0wwVUh3blFkTVdMdnkveDdlYU5WMldUNUsyRmFSZEZVSHgv?=
 =?utf-8?B?K1hWZ0d5dkJvRVdhaGJyaEY3WWs5K25XTWhvdk5XalR0cDAxWTNqc0ZYNGk2?=
 =?utf-8?B?ZlZvcU05QzY3SUZWNGhxdVcxbkJmdHBMcUN6ajdBRW0weU1CTEdmY3BEVVJr?=
 =?utf-8?B?U0hlVGN4QUcrSWhaT3I0QTJwbDdmS3pFUTZKdDk1bndFWjRPWThncU5sWUhI?=
 =?utf-8?B?dTY0bEpsSUpqVTdLR0ppM21yd0p5eFk4ZzFsYXl3c3NUMUplK0thdmVQRlA2?=
 =?utf-8?B?ZTV5dGZoaHVyZllaR3ZNTHRRaURVU3liWGtmanQ0RHFISyszak5KT3lTMlRB?=
 =?utf-8?B?dFNPTDBLUzVhcENKSEQvdG1OSnpsZEZ4eVN1bTJaQW9DT2FUc0V4UjI2ZDdX?=
 =?utf-8?B?WHVsMU8rcjhHa1hoTmJHRnJEbmZ6MFdtVlNrMVY1cXBDOE1hVmRUWjc3eVZx?=
 =?utf-8?B?TXhSRnlLNUhwMnpCZ20wSnlBMXpDdUVrSlROc1F4SlNPMENyOUF4Q0wvOE5y?=
 =?utf-8?B?YVhVSVFBb0tmQzd0UTRFaXgxbmduZnBuZDFaL2JQWWVEQ2k2M2U3TEZNdHRY?=
 =?utf-8?B?QnYrZGVRUXArUksyYmlIOTEwczQwd1IxVWZJczRHNjNienpBODF2aFlqY3Nm?=
 =?utf-8?B?eFZlb3RZZS9ZdDNSUzFHcUpSVXRqeUc2ZGR2b28vbGhnL3RwZng5SkE5VXVH?=
 =?utf-8?B?QzFCeUtlRVErSUlWcVVZZTR1WWhCaWRpUWJUZmNLVkRFdnFHR05STEFvVzV4?=
 =?utf-8?B?ZHo0OGxSNFVuLzBJL2hGQ2o1UVZKQzM3NnVsblIvbTdaNkVwTll6ZG1XT01x?=
 =?utf-8?B?YXJRMUdPd3B5VTAvUjMxRHVMZnFSZ2w3RTYwMm50RVlFZGhDc2tuQUlKZHE1?=
 =?utf-8?B?RXJIaHdXQlBxSUwzS2s2UT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66ef34f-adf9-49c3-8577-08dac8bfad15
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 17:18:02.7815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7461
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-08 14:52, brian m. carlson wrote:

> On 2022-11-08 at 10:50:33, M Hickford wrote:
>> Among StackOverflow users [1], git-credential-store appears several
>> times more popular than any other credential helper. Does this make
>> anyone else uneasy? The docs warn that git-credential-store "stores
>> your passwords unencrypted on disk" [2]. Are users sacrificing
>> security for convenience?
> 
> I definitely think there are better approaches.  However, none of the
> credential managers for the three major platforms work without a
> desktop environment, so if someone's logging in over SSH, then there's
> no more secure option that's going to work for them.  Taylor did
> mention GCM, but I believe it has the same problem, and even if it
> didn't, it's written in C#, which isn't portable to many Unices and
> isn't viable on servers anyway due to dependencies.

Not trying to "sell" GCM on the list, but some small corrections re GCM:
GCM today is built on .NET 6 (previously named ".NET Core".. yeah, their
naming sucks :-)) which runs on various Linux distros and FreeBSD (and
Mac and Windows). Althought admitidely not some of the more obscure Unices
like AIX or Solaris..

https://learn.microsoft.com/en-gb/dotnet/core/install/linux

GCM also supports storing credentials securely without a desktop
environment when appropriately configured. On Linux we support at-rest
encryption via GPG, compatible with the `pass` tool (alongside libsecret stores
where we have some plans to try and get working w/o a desktop environment).

https://github.com/GitCredentialManager/git-credential-manager/blob/main/docs/credstores.md#gpgpass-compatible-files
https://www.passwordstore.org/

The problem that others have aluded to with GCM and wider Linux availablity
is more a question of supportability of providing pre-built binaries from
our side, not .NET's. GCM is built to link the .NET CLR (the runtime) and is
bundled, so the required deps. are minimal; mainly: glibc, openssl, zlib.

> Even on Linux desktops, Debian and Ubuntu don't ship the libsecret
> credential helper, so users have to build it themselves.
> 
> I have written a tool that lets you access credential helpers on your
> local machine over an SSH session for trusted machines[0], but it's very
> preliminary.
> 
> In the ideal world, we'd ship an encrypted store that people could use,
> but then we have to deal with export regulations and sanctions and
> nobody wants to do that.  We'd also have to deal with multiple
> cryptographic libraries for portability and license reasons and nobody
> wants to do that, either.

One option rather than shipping (or including in contrib/) any of these
credential helpers, could we not reference several other popular helpers
in the docs, and let users make their own choice (but at least some are
then possibly more discoverable)?

>> Firstly, how grave is storing credentials in plaintext? Software
>> development guidelines such as CWE discourage storing credentials in
>> plaintext [3]. Password managers in desktop environments, mobile
>> operating systems and web browsers typically encrypt passwords on disk
>> and guard them behind a master password.
> 
> I think there's space for credential managers that operate with major
> password managers.  Unfortunately, op (the 1Password CLI) isn't open
> source, although LastPass has an open-source CLI.  If Firefox and/or
> Chromium can offer command-line functionality to access the password
> manager, those could be supported.  Such a tool would probably live
> outside of Git's codebase because I think interacting with some of those
> tools requires parsing JSON, which we won't want to do in C.
> 
>> Secondly, the docs recommend git-credential-cache [2] which ships with
>> Git and is equally easy to configure. So why isn't it more popular? My
>> hypothesis: while caching works great for passwords typed from memory,
>> the combination of caching with personal access tokens has poor
>> usability. The unmemorised token is lost when the cache expires, so
>> the user has to generate a new token every session. I suspect GitHub's
>> 2021 decision to stop accepting passwords [4] may have inadvertently
>> pushed users from 'cache' to 'store'.
> 
> That may be the case, but I'd much rather people use tokens instead of
> passwords because they're much more limited and can easily be revoked
> (or can even just expire).  We know that people are very bad about
> reusing passwords all over the place, so in the event people do
> compromise their credentials, they're substantially more limited.
> 
>> Thirdly, why doesn't everyone use SSH keys? Unlike HTTP remotes,
>> upfront set-up is necessary to clone a public repo. For users
>> unfamiliar with SSH, this set-up may be intimidating. Introducing
>> users new to Git to SSH at the same time is a significant cognitive
>> load.
> 
> SSH keys are also more difficult to make work with multiple accounts,
> and judging from my experience on StackOverflow, that's not an uncommon
> situation to be in.  I have diligently added entries in the FAQ to cover
> this, but in general people don't read it unless specifically directed
> there.
> 
> I do think SSH keys in general work well for forwarding to other
> machines, but in a decent number of corporate environments there are
> intercepting proxies so everything has to be HTTP.
> 
> [0] https://github.com/bk2204/lawn

There are also enterprises that out-right block the use of SSH (either
techically or as a policy) as they require strict continuous evaluation
of various security policies, on each token use or refresh/re-generation.

Other scenarios I've seen include *per-request/one-time-use* tokens that
are cryptographically bound to the device using hardware security modules.
Not something that SSH is suited for sadly.

Thanks,
Matthew
