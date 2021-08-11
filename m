Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA3C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED01260EB9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbhHKHXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:23:05 -0400
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:45152
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235109AbhHKHXE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 03:23:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwUsczu+YdzMuxA94nhBFSghLnqUTKnOr6QZDy3UVxB9LSPwzvfLo2v+A4jMh8+TOD3S3hloZ52fMNnU2sj9Z82oZ1vnXyKMRPAJMJ3/2zWVRM10eWtl7lFeEtkXETlj1JTFTGDduYJlI6WvxA5S1SuafcbRTmfJ0n2gSzCahZOxZH1rByHINRCQ/f7X++1Ll40JyqeCWZfeFdvRX9Nm1GUvrA/deBV8TLKoABd6eHI7mYInbOM6j8N9ngt9SY68mTh1j4ITNVL1XrHSGX96TV6zKF1QLqqDS0O+Fry/gBOlDoKpoSUIyJ9iqId21xwQaSc6sM399aAXnhMTr0FWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny8QfdS0766tyFAR8q79HTVY39LLV+6dXL+mjJBC/cA=;
 b=mEdKCzvs1ZDr17X5GnLjpyq7OmbqBKT1XTlLJ94GMjZxDR3lnnXD9XG1yDHvuEGzmcOCvFeXTr1xyk9obJz0RtzvqJ8fH0lv4usehXz/oKeHHtCvuNSvi6zn0CQNBCIpGMVALi92YM06SN/0khniEnEOevSLomMlniNRQ/QWdkJJrR8YHrKCQm4uyAm9lQ78/7N+Vs0h3E3ZXS7qQXXMM2+9MyvOv/L5tT9rTUJzTSTK042dDis2WJYgBFCkLLHSf05l7iD8jg5iUOGM9NYPKe+ovvGX8CCFxuk8iG4B4iiplHNhZiEN4IIeYy/O73fLA49ozBceWDPNLz8dH4WIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny8QfdS0766tyFAR8q79HTVY39LLV+6dXL+mjJBC/cA=;
 b=LhXEblfjojhajzX7UffsJn54VuX3EixuBYbG+1eKRq2sgBbOFItKZ+gBErbfbTEW2agWIhCiY0rf4/npP21Q0RRyVmx2zolbqdbeJ+Konrl0KJthEJL+7L9iNoY2tULdSPpKimpIj3vL+TiBbB3sDsT4AEmwWvvAtSZ+Y5I/Sa0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 07:22:39 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bde1:37b2:6f01:d766]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bde1:37b2:6f01:d766%7]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 07:22:39 +0000
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh7fwbx86.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <503f6c75-5b1b-c6aa-3d21-1abef887a689@gigacodes.de>
Date:   Wed, 11 Aug 2021 09:22:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqh7fwbx86.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::22) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR1P264CA0035.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Wed, 11 Aug 2021 07:22:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 361718ec-7a41-4036-fdd7-08d95c98ccd6
X-MS-TrafficTypeDiagnostic: PR3PR10MB4173:
X-Microsoft-Antispam-PRVS: <PR3PR10MB41736B51FD75AF97E69869B9B6F89@PR3PR10MB4173.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCBXKNrRQJKnpXeuLWSl3PK8zbkfzxUOCRThjk0VP9u5VKviL1Y2phXRmoNCF9fYDgi8f1vsBUNJpRsPyV4rFRlTmWXdPbvAqBf25c4WEJCqb/qdgGYYC5LJ10MZJJ99leXDFIxQo9m/AOTVh4eHloOpOjyj1NKQcVJz+CVWFBnMcUtJkGYsxH0bgME+on+tfK5mDRk/9pV/Jp6x5I0PSV0DIUHRAoMSHq8oGUwc4/R9Bki3uyuvPWKfyWPZJGqsy0fraxQtX5UrIPzJ8a/v3EyA8nM/tlsBx7Zc34qTmTI7UMw9unigd3SCBsFUWsb9pa4C4EXrTusV6UULKUrtTg0ce08hI3HVX3/U5w01410WqCQV3kfoEk5kX3caEKts7R9ZKSLhACZvPSnVwE1+/nvG/WL07HDwSpHI4xLnn7NZu1HwN6EDUrvdgGV4kCTaL50XUaqGf3o0pBSmVVKKxySFfHaljtSE8IhG9OcX+mmp7+bHqdNGK33au3i7TYHOc23chexspP4hDQ7CvrOHPxuNKoplkz4w3INspeJfqmYkLSHEzSWWk1XMIf9OqqzKIBcRXnzNUag2rGukzP1mH0U/2eq6qrxyx6Ynwbyatmsyl+QweZLAfXlJcP/w5U/HtJxbNHQeajZMywgmd6dWO1UT9drv9TypwncnuSx62grBAj+gzNsXRLEhecppPCOUA495pCMvBbbh3vaQGPgMSslR1ekiTVOv4VdRq07hb1UPQKNINnNxilxywRuKR9rPrkdls0mxjXoXTw14+1qc2/WryCXP6KcCL75kJ5tlI++Ri/WVAxQzzVu6/PjioHrv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39830400003)(376002)(396003)(136003)(31686004)(966005)(478600001)(186003)(86362001)(36756003)(316002)(2906002)(2616005)(5660300002)(8676002)(66946007)(8936002)(6486002)(52116002)(38100700002)(66476007)(83380400001)(31696002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZitCeUxhZDltb0laNEY3czVGb2lsWS9ySm9MMHg5Q0w4WklQbmxKSldFY3Jp?=
 =?utf-8?B?M1V6TlVnYTJ3cnJ5RVZqMDBZc241a2E2OUJva1RURjVLcjJCRllWTU0zVkhZ?=
 =?utf-8?B?TmVxRVVWN0xKb0pzTWN0dWVIOHk2MzFORnVVbjBFTGF3ZHlxaVl3Mm5xTDZp?=
 =?utf-8?B?cHA5WU5LWEw3cFV3YXVvMm1ZL2h2U0F0QkNWRTVLT2RVMnJKUzlKVWQ4Qzdy?=
 =?utf-8?B?bWl2T1NlV3BmTmlPaWJKZXE4S0MyNGt5dDdKVzByNmlXRk1xbXhzVFV0YVhQ?=
 =?utf-8?B?VFVvZ0NUakRhTW1EU3lJUUozaU0yOG9nc21CaWR6S2orU3BZNTh4aHU0WUhu?=
 =?utf-8?B?eFpvaTlFMmxPWmNFZ0kvT0FrMmcrUUtOMGYzNXpza3FiMHEwaDBHNG9wajRH?=
 =?utf-8?B?ZGZvMG1XNmhCQ29YdzVEY05oWFRzM2RuekdpR3NHRHRWRTBBUElGTkdNKytr?=
 =?utf-8?B?R0psbnVWZ0hWUER0UXJHakxJdFA1RzlXTTNRNVdPRjRqaTltNFMySVNKdzhZ?=
 =?utf-8?B?MUZMSjZ0bFRmRUlQNVZUY2k5YzdhcWFUdXhGNklROGpPekFtNFJ3bGduWVl2?=
 =?utf-8?B?cTVoc0pzTVBXcWU3eXROVTNKb1lrbG95K2N4T2hDRGc5VlNEcjZsa3pPZjFi?=
 =?utf-8?B?Z0Q3UGZzWk9SQkZ1SnFMa3FJcGVMYllSSWhpSmxuZXFhdlU3Z2UzUUR5MjlQ?=
 =?utf-8?B?UzVWYzJPZzRzbkdIUko1Y05sbmhYakpvajVybVBKb0FmbmU1cTlmS2NZekRo?=
 =?utf-8?B?Q1ZjNnpVSXJRZ3ZYUmhKNnlmRW45NFJ0cUNFUHF4YkFVWFpxY1NFYmpxVG1C?=
 =?utf-8?B?SmlqeTl2WXZqYXlWbjNFMGVOKzB3TjhEdTJuenZrWlVWOWsvRStWdm4wWG9H?=
 =?utf-8?B?czYxSzJDcnhXWENEd0ljS0IrRjZZWGFQUlNqeDFDd25hTVYreXNhZWZTek9C?=
 =?utf-8?B?OTA0VDgwMzB6aGFuSXRidThHWnRkUncrSVNJVHIwaUpVRVhyN1JNME5vb3dJ?=
 =?utf-8?B?R21DbXJOeUxOMXpIZ2Fia29ORFVGbVZSWUFnYWs2bmQzQk5MeXloZDJTZ3Jn?=
 =?utf-8?B?T0FxT2hCa0RGd0lJQmQ4UEpUNTBnTlJVQWJQT0JQOWYwT09PU3REdEY2eXFP?=
 =?utf-8?B?SjhPS1U1enJBWjEwV012M0NBNFlHK1BreUZhWUtpMG4zS3oyeFpPb00rWnN0?=
 =?utf-8?B?QkdzTThZTGtWZG90ZmpkUnFHWkRQWkJNb1BiNHdub2I2NVRnMXdBdzB1TU8v?=
 =?utf-8?B?cXhpT3hoZkxoV0dINTFlMXYvYitCRDZadGdvYUx6QVlKVXcyZndhazUxcUw0?=
 =?utf-8?B?eDFMMWZObWFIY0pNcGxxQ09iWEVrQWZnQmpObEdpU2tvR2VrMUJlWE8rSUJQ?=
 =?utf-8?B?T1ZoMmZNcGtjVW81VmNDMTQ3QzNmYjlKeXUxZ3E2YW9jSVJWd2RUNktwZTJS?=
 =?utf-8?B?MFVyRlZmWFVnaDBtckF6aUV6bE0yWHB1OWhkN1ZyeUszQys3Q1dTY2VVbmFr?=
 =?utf-8?B?a0Z6aWpVTFZBYS9PYW90WWNLL2dhNVFsRlNkZU9RT2VOYmhPMHd6allDUkJS?=
 =?utf-8?B?TDJ0RjQzMDVwL241cC9NRTdFZ1Y5WXRVZUF3TWRMb29vS0dld0tSYkZnUTht?=
 =?utf-8?B?cUFRY0VZMkNEWUk5Wk81Z2ZmRTVLNTE0dHNzcXpFYlc5MGpXR3VPOU1qTGJo?=
 =?utf-8?B?NERadDhNMXlJRjl1NDlDMGhJaGNtOFBYeHZtTmVncnhJVWNINVp1bDVESU56?=
 =?utf-8?B?TXYyeXRCUFVEOE0vR3h3K1hvd2VaK1hIaUN1TUlESzczUDdSZ2lvNmZEbUEz?=
 =?utf-8?B?MWpLaXRWM0dKbWxVMXU2R2FuaHlINnNsekhIekpFMzFaM2p6Um9oTDc3NFVp?=
 =?utf-8?Q?OThUU2jSZhVWm?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 361718ec-7a41-4036-fdd7-08d95c98ccd6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 07:22:39.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMaf54bMhBnZhjwUWM6kjjvxw1unfnBsWeDQ4nC0AHtwBGsNslrdbWqI3Uu0dfVCqZKxi2hY66Oc2dOSPgK9dNasxJijxnDT93JrFAluf7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4173
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11.08.21 03:12, Junio C Hamano wrote:>
> * fs/ssh-signing (2021-08-03) 9 commits
>  - ssh signing: test that gpg fails for unkown keys
>  - ssh signing: tests for logs, tags & push certs
>  - ssh signing: duplicate t7510 tests for commits
>  - ssh signing: verify signatures using ssh-keygen
>  - ssh signing: provide a textual signing_key_id
>  - ssh signing: retrieve a default key from ssh-agent
>  - ssh signing: add ssh key format and signing code
>  - ssh signing: add test prereqs
>  - ssh signing: preliminary refactoring and clean-up
> 
>  Use ssh public crypto for object and push-cert signing.
> 
>  Comments?
> 

Anything i can do to help this along?
I don't think there are any more open review issues but i'm of course
open to new ones ;)
I do have a minimal change (initially i used git_config_string instead
of _pathname for the allowedSigners and revocation files) that i could
submit in a new version to bump it up but not really anything else.

I do have a few follow up todos that i'd like to start working on. But
i'm not sure if thats a good idea when the base functionality might
still change.

My roadmap for this feature:
 - check/fix usage of gpg-interface:check_signature. some call sites
currently ignore its exit code and unconditionally dereference signature
check results :/ - This could probably be done right now.

 - rename "gpg." options (sign. ?) and make documentation clear that
signing is no longer limited to gpg. (backwards compatible of course)

 - rename gpg-interface (signing.h|c ?) and at least some of its api
code to be less gpg specific to make developers aware that this code not
only deals with gpg anymore

 - implement ssh's new verify-time so we can verify commits in the past.
With git i only need to trust the key up to the commit timestamp. Unless
its is revoked specifically i don't mind if it expires and i don't want
to invalidate a developers commits just because they change their key.
The old commit should still verify. This is not really possible with gpg
unless people renew/extend and then distribute their existing keys.

 - Add a config option to fix the ssh signing principal to the
committers email address instead of looking it up by the signatures
public key (this is required for the next feature)

 - Allow "Trust on first use". Corporate environments and forges can
easily roll their own allowedSigners file based on the user data they
already have (and even distribute this file to their users). Other
workflows (email based patches) make this file much harder to maintain.
If we use the committers email as principal to look up their key we can
add it automatically, or ask the user similar to a first ssh connection
if we should add it to our local allowedSigners file if not found. Only
a change of keys is a problematic operation and needs to be monitored /
verified manually (not sure how we would handle this yet). Something
like this was already suggested here: https://lwn.net/Articles/803619/

 - add patch signing & verification to format-patch & am. Since ssh
signatures are rather small we could probably append them to the patches
somehow. This needs some planning since it's probably easy to break
peoples scripts/workflows if not careful.
