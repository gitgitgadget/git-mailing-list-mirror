Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2993ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 15:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiIPPyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 11:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIPPyW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 11:54:22 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2110.outbound.protection.outlook.com [40.107.11.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06BB02BC
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 08:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzc1U7s0Phe3IKuEZOH9nh/UL4jvTpuENYO41RV5+TTD2eX4SDi86brn6HiOA9pz736DXhokAehDD2F92XOukogSl/n6tX/ktYrs5i/v8ooppgpyKEk8uIszHNmF6Bxiks7JKwLYgIypoc0SlVx7xJpVdlv9CQiZ/cMiTXShEO6Lw8fHXGI1wLmPsn2a9u6QgltaoYaXg1hD9gbm2EqlS8soq08OvLH1C6GW8iPTvAMfE51YFM3jPkobhHnuWu18f6Yu0W6yBnuhsGKIUfmLjyCvEjqIW0tgyvr9UAVYt8XZ+MI0SxG3WYHbjhTxNF1YYzkrfZQfrguEtQLzaQILUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aoc77tA8TtmR7AXFrkwqodTBocatTig7fk9uOjGF+VI=;
 b=BF53dsCOJnU/DD6X14O2h1z7MBr+BpHwC/cH1TOmgt6DZjHHM0RaRzBnSDlNoWwEaJ97BLlcwsStSS/eVy1aRYRaN/zXRzZXw4rOtnM9SO/CyARC6jFFQkLDT1OiSQu2vHfTaNtV5nSicS/oHW5JzhLi4uWapOsY5kmAIl4RgLVrvk9swFSy/vjhBZ8+Y21HOrFy4lnZrF5CPVMOmkQzysYn+gPmY/n85Nn4OFU5O0dkLMLJlj2JcwWCLiSEhXrs79baOXy0ws62zguDDXpuNXkh6wzX3XY+62rdPMZ8SDeGbVj1VZE8FpjOgqEz0ky+nKr/4PhVRTHP/D67dexcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adalogics.com; dmarc=pass action=none
 header.from=adalogics.com; dkim=pass header.d=adalogics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ADALogics2.onmicrosoft.com; s=selector2-ADALogics2-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aoc77tA8TtmR7AXFrkwqodTBocatTig7fk9uOjGF+VI=;
 b=CFiFBn07jleB+TbMqJ1wE2E3/E7tPqlnrUSubmUMr0a1NqcMp6K0ZGCfin6Ac5tsi2PDzhQtF19XkA3cZ/uUfTa7d1xXH51/yZ/0gyW8tQfrYs9PCMR1CjBxV/BTn0cVDkRkFib8CWuF6Nu1XbVI8jfFxyOaTbPv4Mtfbya8ra0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adalogics.com;
Received: from LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b3::6)
 by LO3P123MB3162.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 16 Sep
 2022 15:54:18 +0000
Received: from LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 ([fe80::64f3:4ca2:ba01:3688]) by LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 ([fe80::64f3:4ca2:ba01:3688%4]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 15:54:18 +0000
Message-ID: <a6308a8c-3b43-77fe-6a6d-cd9f296ec8ec@adalogics.com>
Date:   Fri, 16 Sep 2022 16:54:14 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] fuzz: add basic fuzz testing for git command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Arthur Chan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Arthur Chan <arthur.chan@adalogics.com>,
        david@adalogics.com
References: <pull.1351.git.1663078962231.gitgitgadget@gmail.com>
 <220913.864jxb6z8u.gmgdl@evledraar.gmail.com>
From:   Arthur Chan <arthur.chan@adalogics.com>
In-Reply-To: <220913.864jxb6z8u.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::12) To LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2b3::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6615:EE_|LO3P123MB3162:EE_
X-MS-Office365-Filtering-Correlation-Id: be0ef307-1be6-4d1b-b7e4-08da97fbb68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpANGYxvjBVqmYQDFNOot0qNwAdr57CoVdm8bTkF72sW6CQ1cUfhqYeNxPYjd3SpKYSvOFN2C4etveiRFdvBKhmRz3qevpOL7JUaj49Jz/Aj4zDW20LLDpDmk2qklB6eQL69DDoYKEx0Ln2qJdSx0PLSrCbxbMzjT+9ZepKx4pOKV5Bt/8WHVlID4a0k0ZCtl1XvXnpmCavHUG12Uac4FZIOXatKmWXRzT2Jfswc7NpZSR8fjj7rkTjhS1wFf/5xt0QnVdM6huv9zD0CwqJBeix02I6/zihUAvxPqgtJ+Hvgy1+Z/v0XRiHpYT6huwSV+Qm9+JgEnqR9mu51YPG64BfyqQ2/6BHNJOvVnt/T6x9ixiH+iKAT2wczbmzzfn46I59cnjkeKynRWYhDw2iKOZ5oQUZ9vZfbv4KKa7vgiBiy1hBAq7txtmfzAzq3dPNJ8WNRVgkTepQcdfMS6sRENA8ygJBIxUYy8Ct3EwrotgehtMG8nySqVznnsBeZo1j7C3cJ1avGaQa0CbkQw8DZYg2ghR3R7k7CQczmzL6uFu2894swyjygAZmOheHQkSyPs/mCLYMK9OQOPN/uYjfdfNlC8VSgFGTuLkt3hdGTyqr+hAXXHRIe5z7XnJyWJZ8uv7LDMf1OizN80hEA4EjpMDogwtzLBw6lM2r5Z7EPOYD5XoOrr8k5fG/7srQyLtpSH1tcf9N6iNL2pmj6t+x0aYyvqPk3BWkzKeFOsquzHJ2Dk9mfzQDT6TdO5mxNsnHi1PcTecUovO8bhR4NA+34WqT3RW8MdlxqnadrACUPWpnSqwUQdQHQTlWlNSrPoJ39
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(346002)(39830400003)(451199015)(6486002)(2616005)(66476007)(6506007)(31686004)(2906002)(6512007)(53546011)(31696002)(186003)(110136005)(52116002)(38100700002)(86362001)(38350700002)(6666004)(8936002)(44832011)(8676002)(66556008)(5660300002)(316002)(107886003)(478600001)(66946007)(26005)(41300700001)(36756003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJCM2UzUWp4ZXdMaS82TFVDelhSdlVlclRZRzVXek9jY3NHK3dUNllmTWU0?=
 =?utf-8?B?a3Y1U2hmb3FGOC82VXFSclh3UnErTHRxMGkvOERmajFMQk43eC93eDMrbGFh?=
 =?utf-8?B?RlFXQnAvZTBCRnE0QmxoTEt5RkJSZnVGVXZiU1ZtUGl0M2xjR0ZIL3ViQUJZ?=
 =?utf-8?B?c3E3eUh2VWdRMXVPRzFxQlJXdGx1cndqdEdqdmdCVk0xd3pLYWc5MGg0VUk2?=
 =?utf-8?B?Z1BSZkkzZ1lQVHd4VmVKZ0hIUU9DVDR4dmFHSjhJR0d3Y21iSGlLNU9sS095?=
 =?utf-8?B?TzN4WW94ZEJTNU8wUEpuckkrK2JRK0Vmc3BXdzh1cHVoU05ja0MwcmRhT1dG?=
 =?utf-8?B?RnhTbUg4U1I1ZlZFWlQ0SnB2WndNSTFyMnVTcWpNd2E1anpqUjNtMHc3Tkkz?=
 =?utf-8?B?ZXVuVUZWRUhLMyt4R1QwYnE2TTNpNFhmcEN2M2xRem4vV1JrQjR2R2cxYlNu?=
 =?utf-8?B?dzNpekIyU3o5ZWJWTGRGWTlaKyt3NjU1eEVlQmxod0pOU3h1SUpHZnlRTHBN?=
 =?utf-8?B?MHRYMUVXVTladlFSdFBEQXpVbERvYjZESDBSOEUzTW1FU3p0dDhCMmNiVE9n?=
 =?utf-8?B?bUFabXV1ZkRjUm4wMzRlWlJuamo3MmR0bzJLVmhwcEMxbmE4V25YRDMrdXQ5?=
 =?utf-8?B?M2dSaWZ1MlJkR3B1Wll3MTlYc3FRaDdCNGZKamo2L2lxdUtwYzNjUFRSSkxL?=
 =?utf-8?B?aWdrc1lsMmt4Z0MrZVRwckVDYWM4ekhQRHhUWlRxQjU4S0hLY290KzU4dXlx?=
 =?utf-8?B?aWo2M09oMm10M3ViRVNZYmo5YkMzNDlCUDVWOFpLRXJJdTJtMUd2MjhEQ24z?=
 =?utf-8?B?QUNnWjlnNFhJUE9KeWx1N2x5NzgxRE15c1Y1b0w5UDJZd3dwajYwNjNXZTJL?=
 =?utf-8?B?aUVLTk5BYldEY0t6SVprVEMzYWhsdytqcm1janQ2RHJ4WjdCd2RsWmp0V2RU?=
 =?utf-8?B?cEFxc3Z3dDNpdEpKVk9JYnUwZkJJdHRiQXphQnc3SkVNblIyREVza2RCSGxt?=
 =?utf-8?B?MUlKN0UrWXIwcHVQT1grdkZNK3dUV054RVhrVWN0cHZXS0xlaDFnTjgzWklF?=
 =?utf-8?B?T1NCR3RZeEwrWlBtYkZvQ2ZkcXoxRHpHUTI1WGZiZ2NOdm4wNzNxZVZpRm1y?=
 =?utf-8?B?RWUzcWlOYVY0dW4vVnZialI5eEg0U1cybmMyTVBOcFRwS0NLUUNrVkdGYjhZ?=
 =?utf-8?B?U1BKeERZY21GeVpjMmFjZTZLMC9OV3I1ZXErM2dDQnpzSlJoMWZuQjBnVTEy?=
 =?utf-8?B?YVhqQU1GZlZYMDEyRC9NbmNEeldScUZ2d1dXOWZpRUJ0amUxYXdYUlg0OFBR?=
 =?utf-8?B?SUs5Z0d4RFFGRm5qTDBXTmVYU2pzVUMrYWd6d2VkOXlOOFFxcGJjTzRPaG8w?=
 =?utf-8?B?dVg2Tk96SUpSaTJNSDFadkNHVW9BVHVPMkhEVi9FTlFKWmNjeDk0S2NyRUdo?=
 =?utf-8?B?dFJ3M0V6WStRaDh4UHVYWmxtd2RLZ2tkQkJKaWpYdGR0cW9VUFA4Vnc5TEZR?=
 =?utf-8?B?cGRycG1WNkZaT0dYbDBETWg5Rkt3NUc4T0dYeGJqN0UyN1ZEa1FlMHIvdWpj?=
 =?utf-8?B?Nk9TVi9JWVg3ellvZ2lJZVp0a3c0N0c1VFhwcXI4VzYwZ3N1ZTk3VTZ6WXN0?=
 =?utf-8?B?OGJwRWtuVmIwcGY0elVQTUFWN05NQ3p0Ukx4UFpJSzNzN3pKR0NaUnNxeGZT?=
 =?utf-8?B?NUxGWlRjNHFKWGRRKytNWHk4MWx0aXkxalRXelFxZm1OaGsvN0wrUVNUTUJX?=
 =?utf-8?B?TlhxR0xsMWNHWHlwckQ4VzNuVkJBYTNBQ215K0xmZ3FBTGt4V2lmekwvTGFl?=
 =?utf-8?B?OW1qZXdQVkE5cVJDdVk1cmpGcDRUdTZZWUdOR1h5Sng2Y056MkpyRVowMHM5?=
 =?utf-8?B?TGJwN1NzeW5zeXR4YnlacXVnYWhlRng2SHVURTZVczc0S2JrMTV0b0Ryckx2?=
 =?utf-8?B?aXMyVmh1U2M0MHJpSUVNSThaNHlwamxUdnBwZ3NWc3NXd2dwdXkrT1ljSEdX?=
 =?utf-8?B?Wmp0U1NaTFpxZFpFMzRpNHFYeWFPT0ZjSWhJWSs4cHhKTnBnV2FLRjE1MUpV?=
 =?utf-8?B?LzdPelFFOXBzRENuMmpGS1NJd0xicVNsUzJwc2lmRVozMm56WUExWEhFU3VX?=
 =?utf-8?B?dTlaZm16Q1BlM1BWMlFqRzdLaUFNRnpTOGh3amtwN1F2M1dQRy80b0R2RmNm?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: Adalogics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0ef307-1be6-4d1b-b7e4-08da97fbb68b
X-MS-Exchange-CrossTenant-AuthSource: LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:54:18.2322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4a262c48-49eb-487e-893b-c5902e6682ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKB2Uk+DWRGIP+cgb5CW98kV5NC2RFnooG2x/E7qLSfaAdiEfZrsRlKDA0dLbON9F+dcN2E2aCOtTU5Us/o3KxfOn46CC2h/QuSJ1KS1rdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3162
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the styling suggestions. I have review my patch and change
most of the styling accordingly. And I am just a little bit confused
with two of the suggestions.

1) I am really sorry that I did not find any similar API for generate
random files for fuzzing, which not only required random file names, but
also random content that is purposely generated by the fuzzing engine.
Could you kindly suggest which existing APIs I could use for this
purpose? Thanks.

2) The existence of those system command in the code because the fuzzer
needed to reset the git repository on each round of fuzzing and it is
integrated inside the LLVM oss-fuzz library, thus it is necessary to
increase such resetting logic within the code.

Thanks again for your helpful comments and hope to hear back from you.

On 13/9/2022 4:57 pm, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Sep 13 2022, Arthur Chan via GitGitGadget wrote:
>
>> From: Arthur Chan <arthur.chan@adalogics.com>
>> [...]
> Just a quick comment. The coding style of this project is to:
>
>> +void randomize_git_files(char *dir, char *name_set[], int files_count, =
char *data, int size) {
> ...try to wrap at 79 columns.
>
>> +   int data_size =3D size / files_count;
> ...and to use \t for indentation, not spaces.
>
>> +   for(int i=3D0; i<files_count; i++) {
> ...and e.g. to use "for (", not "for(", spaces around "<" etc. We also
> tend to pre-declare "int" instead of putting it in "for" etc.
>
>> +void generate_random_file(char *data, int size) {
> Can we really not use the APIs we have already for this (maybe not due
> to the fuzz testing aspect of this...)
>
>> +   ret +=3D system("git add TEMP-*-TEMP");
>> +   ret +=3D system("git commit -m\"New Commit\"");
> (I have not looked deeply). We usually write *.sh tests in t/*.sh, can
> this really not be driven by that sort of infrastructure?
ADA Logics Ltd is registered in England. No: 11624074.
Registered office: 266 Banbury Road, Post Box 292,
OX2 7DL, Oxford, Oxfordshire , United Kingdom
