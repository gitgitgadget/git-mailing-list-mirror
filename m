Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7DAC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 17:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbiC2R1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiC2R1o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 13:27:44 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130085.outbound.protection.outlook.com [40.107.13.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A2718DAA0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vpmt/mG3V2noL8AbgNJdEBC0W6UrdHZjOuhgiSy0eQnwH6O068bJQ3PuNmJdCMSCr1BrHE9S+rxB8xctVPA6OP0mtUJMXMBkFsztUVtauTGnRJdGdUYhapkVXMViru1zIP20uVTWO4cM6XvekvGdr2LgrbyrotNS7gxAQQPMSTLwMnQFKm7fPV1N/g5cOdJl/8tyqFEpn+sMgjKCH9uOSYhk985g0ZMp/mfCiCSSUc20FdX/OylIJmea43VI7MdsK9sLhWrzl56Hr33DKcd2d4r31W+1VoPWk+s0+EAc3LchBmxobYBlbaFvVx6xC3mu4Bn0Lx5RVhIuA3BasHFSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPCOwCmhYCnht/A27Y2hBArg/B+eeEy7Sy2Uoi7rpY0=;
 b=cryxlLP9cAqGrlwbaIqUQCCgNAuLfNkfj7JXpy/Z7FX3XIC/G0HNfq1B8nzm2oFiXUo1uOwIj66tQPSCKGGJUSyuttqJVA5KfKXvqo4HK9wvamYL6mmDBCNn/fU6hvYsKEVtii2OUp+YkPtG/kFakfnEarlrYk7hdWlA4kZLQSZnhHbaD25B9NWgQ5Mt/8sZM4svKG+iaV87xYJolaarWJnNaUg556RCebXhqF1TTVWkQNenvCaLLgT1nQAG+/0LIzFDGI8ogrxe2IqO1DJjddq6o0GvX3gRy6BaGLvUCh4ZEWMTTATQUI/wQg4CkbcbcRygFqqhbtDyx4fUsF/sAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPCOwCmhYCnht/A27Y2hBArg/B+eeEy7Sy2Uoi7rpY0=;
 b=L6Dw0GL6ek8GuNrA66RHz+7Tb/HFwloyp6VKNUtet9RXSb5JVCwLvJ9HVXPany4dJf9OKmxM6U+eW98pYlenpJ4HGNwXZTBC+Ctb0eVPE65NdqhtXEz95Vw8xYXlxyrYZ3OSkcNq9JNzWdx9Z5lItyybKOgYmK0ZkRPACguLjMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 17:25:57 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::79cf:e98:548a:e1f]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::79cf:e98:548a:e1f%9]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 17:25:57 +0000
Date:   Tue, 29 Mar 2022 19:25:55 +0200
From:   'Fabian Stelzer' <fs@gigacodes.de>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: [RFE] Signing using SSL
Message-ID: <20220329172555.wzmhplni3w2guvo5@fs>
References: <036701d83942$e6963ca0$b3c2b5e0$@nexbridge.com>
 <20220316162711.wfcavqpg2w4u7fat@fs>
 <00b801d84383$d85b0490$89110db0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <00b801d84383$d85b0490$89110db0$@nexbridge.com>
X-ClientProxiedBy: FR3P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 907216d0-b4f0-4076-a8d0-08da11a92f62
X-MS-TrafficTypeDiagnostic: PAXPR10MB4890:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB4890D29AD50775AFF47F46FAB61E9@PAXPR10MB4890.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVL6Exrc8dWR11zC7JaZVhRyO2MsrAWlDep8NV768GPKPcxtccZovKqMVo9aCR7KjvCdd4pvO+QSMAAPzzOVRnS/ugcwb5Xo9FQy6BH4/UlpTq3/d0DVwHQc0Uyrz1Cz01zRh2PDZ6mhK1OQsDme/W5uwM+dL77+ijIGeO/yva1BkaQBc0bvl4a5J5rX8QxM+2ffR4YplUycbhT2TOeCEQEufzmnYTzFOQ1DKmxGQiEd+XvZv6ZOJ/ClQXkImn+bq4IvudkFY9azWW4Iw8z9hd4QqPndg6/4CrfiDrrgqa3rmzOmjHDgm/q0aeb0ddB1yQn0supI2zLLYx+x8H4kUoQrkxlmX87jJluITX0mo4uEekU+WJ04PsQg9nLeb9xMzc1TjJriXt9n+mSgS++g2pH63bYlikJwThkkcspcuG6kQQaEKsAo9HTEzvCqXwM45a20Xe2ydXaDdp7Yzk2Sj+Yqj9hSn2weOZqyjT0mv2fQhlqT5v7sGG1TNjHsz/inB0pua33TWpmwlpaVkUUBnyj4Y16Ef454uRI+x08dxUo2V2s1GdDxUENDl0dALA8YFf60Kft/KajsVXCeAoHxYp/b2oPUe3WYrRnCVWqAn58AU82srDszTPvNqD6sp5V7uzy3FK67HbstugITdJdLxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(346002)(396003)(366004)(376002)(39830400003)(136003)(2906002)(8676002)(66556008)(4326008)(66476007)(66946007)(26005)(86362001)(508600001)(316002)(38100700002)(8936002)(186003)(33716001)(6506007)(83380400001)(1076003)(6916009)(9686003)(6486002)(6512007)(53546011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRVQ3o3NzV5THBWeXJOVVBBMkt4cSsrOGxlK2FYY2ZWSVkrZ2ovN3FCR3RM?=
 =?utf-8?B?MjJjQ2FrKyt4azZBOHFPMmJUK0JSVnhsSUxqczVOeEdpcHNnY2VvWWE0MXRx?=
 =?utf-8?B?dS9CQ3V1MWpuRi9xclpSUEd1VENadlNDcVB5SzQ4aHpxZW9uZHdBQ2ZYMnBG?=
 =?utf-8?B?UkkzdGlySDhrNHZ4aWt6dXRqUjQrTDhNc3Y0Yis3b0pPTCthNjJWcnYwVzNJ?=
 =?utf-8?B?bFd2ZUxUNXhNdTJNS0hvcW5KS2xvZ2grenFpVGo2ZGpyd0NabHYxNmMwcWdL?=
 =?utf-8?B?YlVObHFHNUdYSFJqV25CWHpEVTZ3a3ZaUVdld3JKNy91dEIxdDBEb0loLzNz?=
 =?utf-8?B?K1dUTkp3QUh4MlJncjlSa1pXdkZlNzFycVZnVWt2MmRKRWFZMVVxQkJINzUx?=
 =?utf-8?B?SjR2Zm82eFNueTNjZnN2dHhvME1CTVcwUEsvN2NlZHZ6YTArNWpXVWdGSjl2?=
 =?utf-8?B?dTBGUDh4WVZVSnBJSG0yZUpKVlZOa3NldWkva0ZMZjRHZGhmTW4zaTVKdmdZ?=
 =?utf-8?B?T01NWnNySk5GVVplUklUdEJXeXNpeDM1ZytrbXczWWxocGtsa3JXT2NCeG5k?=
 =?utf-8?B?TWlLcTFPWFprRnkwSXhYRXdRTmlUY0JWSUsvQmZ3TlVycU5LVjB1YkFoS1Nz?=
 =?utf-8?B?cTFWUlI1TVdXeU5qUkFvS0NJbmdab0V0R1B3MEYrd0JncFo5QnpwOXJMZVF1?=
 =?utf-8?B?eUN2T3FKV2ZHU1VKNVc5WUdaaGFCMDFkbm5wTUhrRlZJZjJRWVN3MU04WHpH?=
 =?utf-8?B?Z21QUmNZMVhjWWZYdGlGNlVHRWRkQkU5WDN6NG9zUmdrYUJEbldpa0xNUHAr?=
 =?utf-8?B?U3FGRFQ1M3IrazFXd044Y0JhMFBTSjduMjc0a0V0VDZyKzdMRVF0dXN4SU1U?=
 =?utf-8?B?VUNMb2JvR3J0SCt5SEM4YzlqUWRRaDdpUkZmTGV2ejQ3cUx1UkxFYnVLUUlU?=
 =?utf-8?B?dzdFcDJIeDRVQ1BTd2tJQ1lKTE4rREk2V0U0WTBDZXBVMDFkMis1WWd3SW14?=
 =?utf-8?B?N1MrQXZoSkZHVDN4d3cyTmloK1RhdXNxNmpHWjBUWEh6ME9xVjVXUHRlYmVq?=
 =?utf-8?B?Wi9HVkd2TmptS21FaURrVytZekNoSjJIRFRwelZJRVJHU1RQbGMxRCtLSTlW?=
 =?utf-8?B?b0hGZWpBV1g5RE5qRU9GclhHaG5tNnl1MWw1VGRnR0ZqcXlQbHZQeXMyYTh0?=
 =?utf-8?B?S3c3SDFJTkFLNDN1OEk0YktQQXpLamM0bWUrK21pcXh4ME1oVndrTm1Mang1?=
 =?utf-8?B?Q1Q1aStvVnZMWUhhMDJGQk9EVVdiQm44UzhCTmN1d1d5L1JMdUdFTkszeVUz?=
 =?utf-8?B?SitBQ0VxMW9XTHZyUlYzbUZGLzVuSXV2NDRGUTU4V2ovaDBUMk9GNnRzRDhO?=
 =?utf-8?B?Q3FBcU5YTmh1RDNtdVFTUVh0S3FqeUVuSlk0ZUcrTWdrSGJLazA0Z2JFMi90?=
 =?utf-8?B?VWt4R3BFTzNzbTFndEVlWERINlVaTVJMblozd2dtQzEwSjNzYnJVVTA2MW03?=
 =?utf-8?B?cXBtMUZTdnM2ZCs4Ty96VVVCbkkzR1QrUDFzQmsrWmtyTjQzYnlhdStaT2NV?=
 =?utf-8?B?QVVFQlBtelNMb2xOZXBmVDlia3lWYllvR3g5cTVEU1lVT3kzaG9PNHZ1cDJ2?=
 =?utf-8?B?UGFrZTJZNmF2VHV6akJkbHFBUXFZQ1QreUtjNENVWDlNQzFQZ1E5WEhxRFNO?=
 =?utf-8?B?UDZyWXgrOUcvL3Q5YnVQOVNyWE1TREorZHRqUy82aVRmVUJHTnAza2UzeVk0?=
 =?utf-8?B?dGRHaytYUEFkZTZSZUdYaG1xVjVHMWtuZDAvUjgzS04vbHl4ZnhmT2ZSRVZN?=
 =?utf-8?B?TGdUOWhvL0t0aWVNY2sxSE85SFF4N2grRTdMNW10Umd0OGEvclJKOElnMCtD?=
 =?utf-8?B?WlZUblBTeFY2RmlEWHRxTWNoN1VZdjkxUHJoZlc2aFhERHRIZUZmM1dEKzBJ?=
 =?utf-8?B?RHMwNXFwL0NFZ3h5dlpjM3IxbGlqVXkrZGx3aUYyVXBpSWhMVW13bVdQN0Ju?=
 =?utf-8?B?SEhnUllkVEFvekY0cWFPa3QxMUlJUXVVMjI4bTY4NDc5UUVlT2lsSWIxb2J2?=
 =?utf-8?B?UjRONTdYeFo0NHRCS2VSa1dXeTMzSHhsV2lIY0hiajBaYWZYcDhhY2w4N2pM?=
 =?utf-8?B?QU1MVUtEMWF0MVduWGJUTmd3eEZjSWFWZmdIYmtuMkpyZnZKN3M1UkdXbDZG?=
 =?utf-8?B?UWFVOWM4Nml2WWpua1JBREkwYWdvU3U0Qnp0NlUwZUpiQU16NmRMbU8rYXZk?=
 =?utf-8?B?ajhaa0tTM1FndythSlFoeHVVYkpEcUNoUzJzTEZNL3RvK24rN0VYQ0ltcjJM?=
 =?utf-8?B?VHBFYXB2VFhhcDMyUVo4YTRlRVovTkxBTEpEb1pPaFZ3SEZYOU1DcHF5c29T?=
 =?utf-8?Q?/8IQsnFIr5S5pPWI=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 907216d0-b4f0-4076-a8d0-08da11a92f62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 17:25:57.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEzwwMbFkgJ8tNfqaBbtEXcIWTibrjdcx+n3DzdYr8dLINMMKqhPqj6HqEkV+aEKCiOAMCDhsC7Md0oWRcTH2Bjd8u7myU988kcndIrkY14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4890
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.03.2022 11:44, rsbecker@nexbridge.com wrote:
>On March 16, 2022 12:45 PM, I wrote:
>>On March 16, 2022 12:27 PM, Fabian Stelzer wrote:
>>>On 16.03.2022 10:34, rsbecker@nexbridge.com wrote:
>>>>Following up on our IRC discussion on Monday, I have had a request to
>>>>support signing git commits and tags with SSL certificates instead of
>>>>SSH/GPG. The organization is heavily invested in SSL infrastructure,
>>>>so they want to go down that path.
>>>>
>>>>The basic technique for doing this is, for example:
>>>>
>>>>openssl dgst -sha256 -sign key -out content.sha256 signature.txt
>>>>-passin passphrase
>>>>
>>>>There is a pre-step to compute the sha256, in this example, into a
>>>>file provided to openssl. We could use openssl to compute the hash also.
>>>>
>>>>Verification is a bit different than what SSH or GPG does:
>>>>
>>>>openssl dgst -sha256 -verify  <(openssl x509 -in certificate -pubkey
>>>>-noout) -signature sign.txt.sha256 signature.txt
>>>>
>>>>and reports either
>>>>
>>>>Verified OK
>>>>Or
>>>>Verification Failure
>>>>
>>>>It does not look like completion codes are consistently involved.
>>>>
>>>>This also does look structurally different than both GPG and SSH and
>>>>more work to set up. It may be possible to provide wrappers and
>>>>pretend we are in SSH, but I'm not sure that is the right path to take.
>>>>
>>>>Any pointers on how this might be done in existing git infrastructure,
>>>>or should I look into making this work in code? Sorry to say that the
>>>>documentation is not that clear on this.
>>>
>>>Why not gpgsm? It can deal with x509 certs and is already supported. I
>>>am using this to do s/mime signing/encryption with an yubikey hardware
>>>token but static certs/keys should be even simpler. However I'm not
>>>sure how good this works on other platforms.
>>>
>>>Take a look into the GPGSM prereq in t/lib-gpg.sh for a few hints on
>>>how to set this up.
>>
>>Good idea but this is a non-starter. I have a limit of GPG 1.4, which only has the
>>single legacy object. GPG added a dependency to mmap, which is not available on
>>any of my platforms. That was one reason we were so happy to have SSH support.
>
>I have been investigating this capability in more depth. After discussing with OpenSSL, explicitly adding SSL signing to git would introduce CVE-2022-0778 into git and allow a hostile upstream repo to introduce a deliberately defective key that could trigger this CVE unless customers have patched OpenSSL. Given the lack of broad-based adoption of the fixes to this point, I am reluctant to pursue this capability at this time. (Actually referencing my own advice in Git Rev News 82). The impact on git would be looping processes when signatures are evaluated. This would break workflows that depend on signed content and have downloaded keys with the CVE attributes.
>
>Does anyone agree/disagree with me on delaying this?
>--Randall
>

Do you actually need SSL Signing so you can verify commits with a single CA 
key? Or do you have all the certs public keys anyway?

I know quite a few setups where every employee is issued an x509 cert (often 
PIV Certs, preferably on a smartcard/token) and a central ldap is available 
with all issued certs. This is usually used for authentication and s/mime.

However this can easily be used with ssh signing as well. I do so myself.  I 
use my own s/mime cert loaded into an ssh-agent (pkcs11 smartcard) to sign 
commits and generate an allowed signers file with all the pubkeys extracted 
from the certs i get from the PKIs ldap server.

