Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67B4C25B50
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 09:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjATJDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 04:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjATJDg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 04:03:36 -0500
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2047.outbound.protection.outlook.com [40.107.127.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C01F38EAC
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 01:03:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcGEAmhaVmsOAlWAi2bIHw3aB0TTq6KZ4qtS0hPJEp9neKo/0NZDsIxYhesSCCwAlH7k7kyszhDXE4EsTwpGtoC6sJ21SiG4DpkswKTeMMg5vM2gRZbq9ZtyDF4b396gqqWjf/D2hEg0Zqg5e0YtrzdI1Qq0RbSVMkT2DSU0Ho6r7jjRyHMPkwZCngJeoIo80+jjcXaJrEnz8iUanaCPDtiWuGIIdnPv53by8f5klEljq4X0R6tUVJZ+yFsnbY9nECQDdbNrRF0RvBILxqudZuEuTWgDDEwOOsK5G3ykArO54/uzpV62y1Ysikgto0+08HDzLJ069VXBJbDySvn9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeufHxPRDnSJp9nBZAgeviansBLEItYOZxOrOyERyn8=;
 b=cXDAZDwrSZegLjuG0cIDBhO6ZPWmsZ9E0MeA+8aLytNHz9YRBwYWg5DleoM/3A8I7xfRYw7twnsYPBrBLyzGZNSnghAdBkMSYHCeHnvn7QdI3wz/mJzbEtRKhltrkf5MCxe+iahGG+MHc56Q0rviBIuu80G2Qr6Uab2k7QI4eijT/D1EdXGMcouLPqW9GbxzXIUQgAnL8TZZigVuvZxyIdGTA0mg7OQKlyZ1IdkjQ3Ae7nam58I5MUBACiG6rsxdphSyQ30m6UZTQoiI/jaDiJrXgatdsByLHN8CBj3julO2zfF2PowL1Zc+JqEc3PbmL0WBmKsEqL+++TaV9/vsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeufHxPRDnSJp9nBZAgeviansBLEItYOZxOrOyERyn8=;
 b=c2AQvxy/Y5dWGnWr+Di5D7r+giX5i2njw0JxMAZnbqz1pPouOIBDUdrA7LbdoDKjVoFijZ1FheDGJ/h0ZL6GwX29D9mDbVCcZViDp/lcwkI5ZgRcP3FioiGySHeU0Qyaas1Rw2U4HGn2YZh7UWJn9Yif8XJXLcUu7g/meeqL8tI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2a::12)
 by FR3P281MB2556.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 09:03:33 +0000
Received: from BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1e00:fea5:d4b2:fb05]) by BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1e00:fea5:d4b2:fb05%9]) with mapi id 15.20.6002.012; Fri, 20 Jan 2023
 09:03:32 +0000
Date:   Fri, 20 Jan 2023 10:03:31 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Adam Szkoda <adaszko@gmail.com>,
        Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ssh signing: better error message when key not in agent
Message-ID: <20230120090331.37dxkko6bgxbjae7@fs>
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
 <abec912c-065d-2098-962e-41f9646dd046@dunelm.org.uk>
 <8025d5c7-ab55-c533-1997-05b4c7339d61@dunelm.org.uk>
 <CAEroKagqxC86X0SD8=tK0w+yXL7QecZ+z_7sja-K6ajs0=Z=BQ@mail.gmail.com>
 <55282dec-825f-8c4b-1fb0-6e26ec326db1@dunelm.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55282dec-825f-8c4b-1fb0-6e26ec326db1@dunelm.org.uk>
X-ClientProxiedBy: FR2P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::19) To BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2549:EE_|FR3P281MB2556:EE_
X-MS-Office365-Filtering-Correlation-Id: 423d3fad-bc96-4831-8367-08dafac534cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4BfqOJsFxPMdFEbmLe2TwajxPXXFNMwMHaudDvJar15T1Q+zrfIfiuYICu0gTPkLtjBcyDOEJNL7KMpjJR+5co/j2VOo2V3mA4uszGkoaag9wZ3aQPvg9U2tq+JqwLAPmlJnklkRcTF3RR2/VpHxE2OFxixIWKsDpUONXw9Et0O8w+dP34mNht8ZqGj3bhc3L/Oeb384JorX3QbKmjruvPUQR5avZ7jmdze83o5ZaSJw35/6kWfiiW0Im0dGUqaULTN2SweY/IEOQxjJJIVAVbO8iTEOVgC9X96NxWi7Pi7cow4GCgOq4tPoJh45/X5/T5trXGNHKRuMgzK+Eish6AMtS6v5GFocml6byvtm7pYJFS7NgV+NjUxDeZ17iLvuP4pZ4gngGFhaeCqZq/tFgotDDbDPjG3NlQ5DV0x6W6Yx1rd1GPmLf5sQkYQH/prrMLRssPThH3dj0FWAjeFurS3dShlPeRB4gvijYSXh4mBEcZM1R/IiPJS80FXw1/OHAG/cjInXoN2BMUvwKG0Ml89dCVhCiBurIDc/QaXvcf6CfscHgH4zEkBjf9Z9p6JDVSfLZi6walYNxk7xJf/yqKK6tXcrmRBgBcuyhjrSV4OthG5stz1C7sHw2bBt23SkS7NQkBiUs9UryUJBILe7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(346002)(136003)(366004)(39850400004)(396003)(451199015)(6506007)(478600001)(54906003)(53546011)(6486002)(4326008)(66556008)(66476007)(66946007)(8676002)(316002)(186003)(9686003)(6512007)(5660300002)(1076003)(8936002)(41300700001)(6916009)(83380400001)(86362001)(15650500001)(2906002)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0JPY3RaR0R6eU9RYVorQ1c5RE1TVms0ZitZcnZYQWlvYkdoa055eVNVTnpO?=
 =?utf-8?B?WVFyd2dEVTUyQVlZSVJiREpJV3M3R0ljRzNvMTdpSG9aTE03WXYvQThGYkNL?=
 =?utf-8?B?STNTWkhaZG1tVEVhcDdpZVVSUUw0aGFXMDIxa3dwMDVLL2k1aEtBK21zZnZG?=
 =?utf-8?B?VkJqQWZrMnhPSUdRaVU0TVEySjBldGFkdVFOenZ4djVOUEhORlBJYVNobnNo?=
 =?utf-8?B?K0FVcmJXNGxtRENJaGZVaDFTNkg2YXZvQ2QxcGVNT2ZuV3JiNVVVSytPYnZj?=
 =?utf-8?B?VjJSMU1aOEtrUDVZUUFpYVdDTmp5bEovOHJsUzZ1dWxKcHVGYkYxOEY0ZkJp?=
 =?utf-8?B?Z0pUQzdXbkJPQlFnbkk0Z2FzeWllcDIvU2QveVdMcFkxVlU4L3Q5eHhJZThs?=
 =?utf-8?B?bmNRWmNaT29oclRDbXNKK0dmRmQ4UmJTOVZPQkZ0ZVh1WkNSYXJrZEtlVVh5?=
 =?utf-8?B?MzIwVW9ta25oem8wS2s4M1NtWE1oU3piK3RMREFMZGZZaStRdUZEaFAvcFFl?=
 =?utf-8?B?OEt2ZXhZQVM0NU5mNjBZVi9oblRYem5xcUc1VHJ2eVFVZmtSb2dBVXJMbnVj?=
 =?utf-8?B?eGdoMXJXQjZsMlJVVytZRVZKNXNPb3hSYkQ1T1g1OWttWVZ2cUJ6Z0V5MVRn?=
 =?utf-8?B?VFo3T1Z5SzZMa1UxZStCWC9SZnlyZGphOEVnQlRkQndFN1dIczhOSzRwMHpE?=
 =?utf-8?B?L2xYM05SZnB5dE5WeEd1RDVoSEUwd1U2N3dNR2kvSC9wOVZTcy9NZkZpbTFF?=
 =?utf-8?B?blRuUEVraHFmZCt6R3k0OVM2Zi9ENld3Rk9DcWVQZW1wRHdFRUxNTlhiRzB4?=
 =?utf-8?B?dGFybm81L0ZUYUNYU0tsdFhoNEVqSy9oNEs4ZzhEQ0w0Q29VR2FtU2p3Qmgz?=
 =?utf-8?B?Y05IRHBScHZycjIwMVhqSlNQVlJjUm1vYm9ndjFlM1o3MEk2enRxbVQwanJP?=
 =?utf-8?B?TnpwdGlWNytDSDZrNDNDRVZFSlVtMDRTbEthVk5iOGw4Y0QvcEp4N3MxS1RY?=
 =?utf-8?B?WlMyYU15QmFnNzZJaGtweEltTkVtNFM0ZTZhZWpBWG9wdzdJZW1wMTdYTFF5?=
 =?utf-8?B?WHdzbFNJZmFoWDNMVlpVOUtUZ3hndEFGeDBJWW90ZlpuTGEraUxtcFdPYUlB?=
 =?utf-8?B?TGxmL3l1bmFrbVkzTVZicUdETEJwVmd1RStMOHd5bjhnTFFRK0gyaFRzZE4r?=
 =?utf-8?B?NDZSNTl4ekpoWEtqcmIzRnFXSnhRWUFCNGZxcFdFeW1FWUp3ZDhqU1NpMkM1?=
 =?utf-8?B?K2puQm1KQ1d1aklNQnFaN3EyektKRHVTTVF5VksrcXViNmlUSWV2SGx3YTkx?=
 =?utf-8?B?dmRjejNnOXZnclhyYk1aaXBoTUN1Y3NGcnF6cEY5QXYxMStJMVgxWUhWWTRU?=
 =?utf-8?B?bU91Z1duVXVEQ0E2RXZ5NVdkVzZ5QUdWUkZhamRLNGxIdkpBTzV4M2kwSEpC?=
 =?utf-8?B?VGZiUlZrV294ZXFubHNNc0pkWDk3R2lFZ0REdUNOOGZucUZrNTZjcVR6bGt1?=
 =?utf-8?B?S2xXTG5zNXh2T2VQOWJndDFQWmJycTBYcmVqN2crQ1piMitwOG1LMjFjUzFV?=
 =?utf-8?B?Sk1IbUtrN3RPdzBhbk5TQ0RTZGRPS3BDVFVEVEp4clRxdEFGMnl0a2lCcnEz?=
 =?utf-8?B?Wm9QOG1TbTRRSWM1NXJlemhSV3IxaFhCZkg5OThMTTVZZnpPcTVmR3gzb0I4?=
 =?utf-8?B?UlYzZ2Q0bHNRSlhLWE50dWZpT3BXb0xzZVU2Zk1NKytTZG9tamN1c2JBRmdE?=
 =?utf-8?B?RUkxQjFiMjgrRVFxeitoVk5FMkxrKzJnUWlCNkFUZGxiVGs0MkdzY2pLZ1VM?=
 =?utf-8?B?Zm9HcjBKUzZKeCtneFNuLzVySmhnVzh0NWsrcktPSEdFZUVYdlNwM0dnMGF5?=
 =?utf-8?B?K1pld0lxODJPaUVKZERFUm12ZkhtV1hxc2hKblRLSC9KeTVKaFB2N1JoTS9S?=
 =?utf-8?B?bkpEV0FlMUduWmYwMHVGY25WZFpORHp0eWVXaUVBN0FNNWltUlVTbUhpSmsy?=
 =?utf-8?B?RjU1TUFUV0ZwMDdLb1VxejVNTC9SVlVlYlFWRU5yZGd5MENJekNVZkdRb0xK?=
 =?utf-8?B?UHgwRzFxWWFRU3JiQjBiTjJIY1pGcFd1WlcwZWl3M05lRnRmb1hDMlEvNCtm?=
 =?utf-8?B?RXdXZldEanhlQ2luNmVFNS9kdm00RFZqaDFvbUVFYjYwellVK0pXY0xMaUNp?=
 =?utf-8?Q?IhArP0nEGDZGhWOusX4YnGYWAAavj4uy5wG3AyqKzZsO?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 423d3fad-bc96-4831-8367-08dafac534cb
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2549.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 09:03:32.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHiCYI1N9gcc/GSWv3Dhd6Qdy/prx3w/rs+oIGY8mjYUu1f7gM47/R9gqlfAFYxi6K6gGvPdp+PYDu3Flx/0cf001GZjrAanQLXWNS2Toq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2556
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.01.2023 16:29, Phillip Wood wrote:
>Hi Adam
>
>I've cc'd Fabian who knows more about the ssh signing code that I do.
>
>On 18/01/2023 15:28, Adam Szkoda wrote:
>>Hi Phillip,
>>
>>Good point!  My first thought is to try doing a stat() syscall on the
>>path from 'user.signingKey' to see if it exists and if not, treat it
>>as a public key (and pass the -U option).  If that sounds reasonable,
>>I can update the patch.
>
>My reading of the documentation is that user.signingKey may point to a 
>public or private key so I'm not sure how stat()ing would help. 
>Looking at the code in sign_buffer_ssh() we have a function 
>is_literal_ssh_key() that checks if the config value is a public key. 
>When the user passes the path to a key we could read the file check 
>use is_literal_ssh_key() to check if it is a public key (or possibly 
>just check if the file begins with "ssh-"). Fabian - does that sound 
>reasonable?

Hi,
I have encountered the mentioned problem before as well and tried to fix it 
but did not find a good / reasonable way to do so. Git just passes the 
user.signingKey to ssh-keygen which states:
`The key used for signing is specified using the -f option and may refer to 
either a private key, or a public key with the private half available via 
ssh-agent(1)`

I don't think it's a good idea for git to parse the key and try to determine 
if it's public or private. The fix should probably be in openssh (different 
error message) but when looking into it last time i remember that the logic 
for using the key is quite deeply embedded into the ssh code and not easily 
adjusted for the signing use case. At the moment I don't have the time to 
look into it but the openssh code for signing is quite readable so feel free 
to give it a try. Maybe you find a good way.

Best regards,
Fabian

>
>Best Wishes
>
>Phillip
>
>>Best
>>— Adam
>>
>>
>>On Wed, Jan 18, 2023 at 3:34 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>>On 18/01/2023 11:10, Phillip Wood wrote:
>>>>>the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. All
>>>>>that
>>>>>needs to be done is to pass an additional backward-compatible option
>>>>>-U to
>>>>>'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interprets
>>>>>the file
>>>>>as public key and expects to find the private key in the agent.
>>>>
>>>>The documentation for user.signingKey says
>>>>
>>>>   If gpg.format is set to ssh this can contain the path to either your
>>>>private ssh key or the public key when ssh-agent is used.
>>>>
>>>>If I've understood correctly passing -U will prevent users from setting
>>>>this to a private key.
>>>
>>>If there is an easy way to tell if the user has given us a public key
>>>then we could pass "-U" in that case.
>>>
>>>Best Wishes
>>>
>>>Phillip
