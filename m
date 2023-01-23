Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775CDC25B50
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 10:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjAWKDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 05:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjAWKC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 05:02:57 -0500
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2057.outbound.protection.outlook.com [40.107.127.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0BB3A95
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 02:02:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8vaEWN91DggQlSybRx0yLEdS3tAVJNQ1iRBKY3MgnGcy+Dn40tdEZ9PBv0tVRxaKzQ+b9zT0nDWmzaL5urso9S21GvGPyrvpzMBN779llYtCji8Gacqg/G8K0/1EGbjmreNnRoIsOUO2/FKj+Fmn2FGIrbB7M7WqZZZ8FPJAbJs+W0tyGjQhikU5jUY3xS9Q1NhhAeuUFbU4X+AVl5ogYovQmRsqKWzSL554UuhGf7DykyrlO4PMNh8+L/b+B8Xr7RjOR2g4gUA3nhbe4noUXiyuR/PsIV3JgwSE8PQGjPN6mOI7XwFec87F7xoiNgr0/qwK6m8Ee7HYjbt+SvgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGwgjcla8kZpUcdxCVLyDM54xAZbza9q8Qjt5nuNOKg=;
 b=ljoe2r7MdQJBI2WACtRkZppCXW2H8Udni3ALqJiZ7s0uIVLlH2pdGv5LgxhMy1gJDPPNCJE2BH8GiSpjlsnZr0l31DRv9ZEjx96epqrfLhiklNOeLgCdqn0Boub2nCT7zIlAunX5WHG7RAHyg+MHrLIl/fND15+Jp5zr0Vpy1F8MObY2WAdSw9QphQDvlfzysLqrAj8ceTEQE8QnxtHqB+WpnEoFcDdwxdwfWNgVvMrTKirGaxamGXNu59LqD6OMKl1mKLG20tAnBRtZv4qpEwEh5I77mqaYSzvpN5tjsoJP1QpGipSL7By4bhc4iGHykQQpfjrFguCZyZsNbUUjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGwgjcla8kZpUcdxCVLyDM54xAZbza9q8Qjt5nuNOKg=;
 b=d5zpDG5tn9DjvmxkJlWtRbMVZ80bcS/lok3CToppwGb/AJdfUwJxcxsulNhnkJMyHqmaSGcvWU5DUlAtec5IiKe/cCZKEEvXRV30lbCcmLscL4IfTGfZAsgv/7QzIdPSSClGRqimh2JqtR7n71s/YfABn+/VIz+CF3Mv6U2DFxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2a::12)
 by BEZP281MB3030.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 10:02:47 +0000
Received: from BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1e00:fea5:d4b2:fb05]) by BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1e00:fea5:d4b2:fb05%8]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 10:02:46 +0000
Date:   Mon, 23 Jan 2023 11:02:45 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Adam Szkoda <adaszko@gmail.com>,
        Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ssh signing: better error message when key not in agent
Message-ID: <20230123100245.3qbscxkgvbnh7ilt@fs>
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
 <abec912c-065d-2098-962e-41f9646dd046@dunelm.org.uk>
 <8025d5c7-ab55-c533-1997-05b4c7339d61@dunelm.org.uk>
 <CAEroKagqxC86X0SD8=tK0w+yXL7QecZ+z_7sja-K6ajs0=Z=BQ@mail.gmail.com>
 <55282dec-825f-8c4b-1fb0-6e26ec326db1@dunelm.org.uk>
 <20230120090331.37dxkko6bgxbjae7@fs>
 <6e57bef8-7387-3341-5ed5-4bcfa7ded7a0@dunelm.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e57bef8-7387-3341-5ed5-4bcfa7ded7a0@dunelm.org.uk>
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2549:EE_|BEZP281MB3030:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a154f0-0279-4284-14fa-08dafd28fa59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSzxKxGtURbBuNWBQhU9clL6O2Ho0uLw3e9+zFLcx6259BYzLcYHryM3pYFPrvvLt8/YFklR0KvB59EzXrIwY0O4C1T+7/AXW4yv6lrKgrBPEPeuEdCcp8BoOP1/uCx5ouQdoXbFwFP9qXyv4Xa2poolqYhwWUjjVGePRPQpl9CyxLGycJAZhxisgVsd5iAU+SVCI1zYTDrszY12cBPsoLCuaheTQcUAJNDX3KsZRyjWAwPl1YDnLJrCVEHLZD2ke+LLD/vR4kkzDF3dxU4Km8PjSb6jwn3+uCU2H0D8fAjrkLTAwlIaH8iBVh7a6ZxlfqTwb67pbSi1ZytWe8GXgwiPSCwSRq0WBtoilUVHVpPaOak0miHRfdvF6kbghzl2/nCvSLUidTOKkFafxrBzdj80mCDTZnZLpJucP2u3LwZjAt5BCxGHlzUy0waf4I1AEmsVyvcYhY4EfHpyVBSz0LQNOO4t3NB2D0k6q/BV1hz2l0E7R2eJDq5LB9a/+9AV4mIBgx3Aq3bNuxU7SHpG/L3/bdCSDEMa/+6gbmTbPtlOvIxFWtxPsrw+GIZd4Xe0k+0p6/rTojM9XUWXWSyxKe1NwiXKUnUPpq7d5AbK5wFaAIRe2jsRHoEZ4tAMoN82CTp0Wae/7A8FRBQsKu/ftg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(39850400004)(366004)(346002)(376002)(136003)(451199015)(83380400001)(38100700002)(86362001)(41300700001)(2906002)(15650500001)(4326008)(5660300002)(8936002)(33716001)(6916009)(8676002)(26005)(9686003)(53546011)(6506007)(186003)(6512007)(66476007)(316002)(1076003)(66946007)(54906003)(66556008)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1hvUVhMU0I5TTFONFdrQTdtQ1hFNk1MeEdtdlBGaks1QW1uRXBmSjVFdkxj?=
 =?utf-8?B?QVQwUmlaSUJSUk1kYjJYb3VLZ1E3NHdJUzhWMUNhanBrWDM5NnJLME04bEpR?=
 =?utf-8?B?K0dVM0RxWmowZUFDdVJSMzFNVFZrYWk5TFBlNmdad0ROSHUxQ0Uzd29XQ2dy?=
 =?utf-8?B?dmZSQlF2Vk9tMUExeTRRSHNrS2xHTWlkNmkyaWlqTVZ6ZTBDb2g5OG16RytJ?=
 =?utf-8?B?eVBONUhNNk1JS1RZSHVYcnlkWVJOdmdqcWJhdTFXakNVdGRyWkc2bVAyMit1?=
 =?utf-8?B?YVhkbnBIZEt4UFlXaHJNeDZyNnBXa2hiU2ZOWm0wSGJzMXdRZWF1T2JGK1ly?=
 =?utf-8?B?dCt5UEVaYVM5NFVob1MwU0lRb2wvVTF0OXg0VmU4ck9iN1RnSlFOaUhoNS9S?=
 =?utf-8?B?RHlWc2VjQS9JcDQzSWluMWlVTzAycFJOMVFiR1VhaVBra3JReHFIZVUyZTVJ?=
 =?utf-8?B?T3cvTGlnQlcwL1BoU05OUFpiV0JpMjdPdE9USDFvNGRIRzV2QlJMYlZBMTd4?=
 =?utf-8?B?eEcwaUlKRUZqV0wyV3VjaHJIbFlRanl2VURycWdZeEI1VytsSDBkRG9tejZR?=
 =?utf-8?B?VTBMMlZ1QytTcTBscXVJY1FnTHJVUlRwSm16S2VpQmIrS0pnam5JV2R6T2hI?=
 =?utf-8?B?MzBZR2ZFY1pLeGRNMWRSWmtCWWZhbkRlckJFSjEwNHpraEpQRFNsdkJCTGlE?=
 =?utf-8?B?VE5GZHFyZWlYMG5ZY2RIZUNhT1RQdTdReE5Ielo1VWYzZGJkSVZIdDMvdndt?=
 =?utf-8?B?bkY3QmFxamJVcmVZb1BabHh2c3JaZlMxSUVoeXRsL2dBaUFjQjg0aW9nQzIy?=
 =?utf-8?B?NHJUNWhHWjNqamtnREdMZ3ZpMVMwc252VnZvWDhDbWs2Y3VBdE5qOG1UVVNx?=
 =?utf-8?B?czVqM2FGL0JXS1hpOGpKRS9iSDJVNzl5Nm9GVjFDZU5hSjNMSWFHL2ZkdVFu?=
 =?utf-8?B?NkpUNktaRGJrNWR4VEhOZVNyTTY4N1lFM093amRHWmxncEhsS3UyZWI4YVls?=
 =?utf-8?B?dlZKV0IrbkJaTloyWXQvVFo5Wm5PaHpMQlpzZ0JlZGVaYVdsYUt0Rmw2czh2?=
 =?utf-8?B?UGxTZUZkc21NRHNRQXpwNGlnbWt6bmNXcGt5Z1ZCTmgrTFQ2enkxc3JwdzEz?=
 =?utf-8?B?N0N2S2NORk9mMzVUbjRNSDBMcGgyWFFJTGdIZmUwWjNhK000aEw0LzVrNVVY?=
 =?utf-8?B?YjVYTzI3cHpzUjUxN0wxc3V2S25xVzBLWVFxZTVPdFV6ajhXaWtJUi8yUFl6?=
 =?utf-8?B?STd4ZjRVOU5lSUJwaFM1WkdycEFqZU1haE44RDlQeWI4bWdUeFZzUkt0MEF6?=
 =?utf-8?B?RFlDSHdNTGJ0RXRtUTVoWHIreko5MXVuODh2Vkp1eHQ2dFA4djlWU3NhelVZ?=
 =?utf-8?B?UldXK2VWT2hXSGhTbnlYWmd6Njdnb2F4SmtKOUxzdzBobzhydFdZZlJPL1oz?=
 =?utf-8?B?QUlMTHpsaHdCektHQkNoNkxFZ3A5dDFKelFVV25ZbzRnampYb0grWDBpN0pu?=
 =?utf-8?B?b3F6emYrWmtKLzhYaUhLazBpeVdCcktKaG5WVXBaZnh6MDZmYmdxZ3pQUHBW?=
 =?utf-8?B?eEh4c2Y4SWRYd2drUEE0WjN0VEJvbUJGaFRkSFpxVEdmb01sOFpMSWQramZW?=
 =?utf-8?B?b3p2NUt4Rk9XZ0ZlemtjUE03eSsvVjBGbjlPcFZuZDdvdUgvbkpSRGlJbXUw?=
 =?utf-8?B?dEpYWGZ0Qm14YmNoVUZEdXlsVDJteWhnYnlSWEdZQXl5bFYvdGRpQWhjaU05?=
 =?utf-8?B?WCt2akVtT1NSdkRRelc5WmlrSXZtdkJtN25hTnF2RkthaXJpaDg1bXRWd2dk?=
 =?utf-8?B?Qk5PR2FTMzFMUVdnSlhmR1ZtMUo2QmVKblJNZFJ6ZisxL3Qyd0VtT0V0YWN5?=
 =?utf-8?B?d0FVcDVNZGhGR0MrMUlYcEhVb2VIOE55N0pFV2RVZTRnVnpQdUhOb3JyOWV4?=
 =?utf-8?B?Kzh6ZmNnMzFROStKcnY4N0FVMWM2Y2szUlNaclNNdmZDM2Nvc3ZUUER5RXVu?=
 =?utf-8?B?VXkwSnJ3aXgxSVN3am04Q0tiQUhrUE5oOWtSYW5sT0dKOXIxYldaWFh5WGlZ?=
 =?utf-8?B?YWdiMkNzNlRhcnhIN1FyQXMrclI1SWROcE5TMVVCeDBTWkdIUXJ6eXJFRXNC?=
 =?utf-8?B?dEF2SFQ5L2hmQ1NRVnhxWVdqa2dXZEVMWUVVZ0duUXpGT2ppRzY5Q2c0bGQy?=
 =?utf-8?Q?AMf6znrMB1onLcpiOfG3bCg=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a154f0-0279-4284-14fa-08dafd28fa59
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 10:02:46.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeY5VouG9CKB8jMKEbQRtfLw13rc6/dy5FgYCeKU7hPJznfJQmF53kuXCVcbJ5t3VlPjGuphuGMlJRfjWBRgT9T1U26nczwWBt3qzRLYdwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3030
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.01.2023 09:33, Phillip Wood wrote:
>On 20/01/2023 09:03, Fabian Stelzer wrote:
>>On 18.01.2023 16:29, Phillip Wood wrote:
>>>Hi Adam
>>>
>>>I've cc'd Fabian who knows more about the ssh signing code that I do.
>>>
>>>On 18/01/2023 15:28, Adam Szkoda wrote:
>>>>Hi Phillip,
>>>>
>>>>Good point!  My first thought is to try doing a stat() syscall on the
>>>>path from 'user.signingKey' to see if it exists and if not, treat it
>>>>as a public key (and pass the -U option).  If that sounds reasonable,
>>>>I can update the patch.
>>>
>>>My reading of the documentation is that user.signingKey may point 
>>>to a public or private key so I'm not sure how stat()ing would 
>>>help. Looking at the code in sign_buffer_ssh() we have a function 
>>>is_literal_ssh_key() that checks if the config value is a public 
>>>key. When the user passes the path to a key we could read the file 
>>>check use is_literal_ssh_key() to check if it is a public key (or 
>>>possibly just check if the file begins with "ssh-"). Fabian - does 
>>>that sound reasonable?
>>
>>Hi,
>>I have encountered the mentioned problem before as well and tried to 
>>fix it but did not find a good / reasonable way to do so. Git just 
>>passes the user.signingKey to ssh-keygen which states:
>>`The key used for signing is specified using the -f option and may 
>>refer to either a private key, or a public key with the private half 
>>available via ssh-agent(1)`
>>
>>I don't think it's a good idea for git to parse the key and try to 
>>determine if it's public or private. The fix should probably be in 
>>openssh (different error message) but when looking into it last time 
>>i remember that the logic for using the key is quite deeply embedded 
>>into the ssh code and not easily adjusted for the signing use case. 
>>At the moment I don't have the time to look into it but the openssh 
>>code for signing is quite readable so feel free to give it a try. 
>>Maybe you find a good way.
>
>Thanks Fabian, perhaps the easiest way forward is for us to only pass 
>"-U" when we have a literal key in user.signingKey as we know it must 
>a be public key in that case.

Yes, i think that's a good idea as long as the `-U` flag is ignored in older 
ssh versions and shouldn't be too hard to implement. And it should work just 
as well when using `defaultKeyCommand`.

Best,
Fabian

>
>Best Wishes
>
>Phillip
>
>>Best regards,
>>Fabian
>>
>>>
>>>Best Wishes
>>>
>>>Phillip
>>>
>>>>Best
>>>>— Adam
>>>>
>>>>
>>>>On Wed, Jan 18, 2023 at 3:34 PM Phillip Wood 
>>>><phillip.wood123@gmail.com> wrote:
>>>>>
>>>>>On 18/01/2023 11:10, Phillip Wood wrote:
>>>>>>>the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. All
>>>>>>>that
>>>>>>>needs to be done is to pass an additional backward-compatible option
>>>>>>>-U to
>>>>>>>'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interprets
>>>>>>>the file
>>>>>>>as public key and expects to find the private key in the agent.
>>>>>>
>>>>>>The documentation for user.signingKey says
>>>>>>
>>>>>>  If gpg.format is set to ssh this can contain the path to either your
>>>>>>private ssh key or the public key when ssh-agent is used.
>>>>>>
>>>>>>If I've understood correctly passing -U will prevent users 
>>>>>>from setting
>>>>>>this to a private key.
>>>>>
>>>>>If there is an easy way to tell if the user has given us a public key
>>>>>then we could pass "-U" in that case.
>>>>>
>>>>>Best Wishes
>>>>>
>>>>>Phillip
