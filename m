Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F74C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 20:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBAUPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAUPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 15:15:31 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2048.outbound.protection.outlook.com [40.92.74.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A706A6187F
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 12:15:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nodhU+dGJ/QzHx8VTeo/jfWGTRdw1nK0fcRZZfIZOHmJxW9zRhKia4zvypVAxuJOiFyi8cRB+padjCsEoUZ5t5K8e3+TmLPxZPnWr8MKfoFQ6a9EeNzHHRnIa0SjRvBeEtddm31b3aEcNJ30Pag8PZPpwo0PDmQK4N2GX0N2u3hYxl+vGplP5ClgNFR4Spx7DhIMb7q07uGPktD1cZAjpzoIdZ430GQTaMzOS4YxrCYtX5Ka2vkF2x+Gft1nQa15Vov6weNPPSHu3k87FF1EFj3SfGFce7eJTgNJ+z3Xpv1IZAIzg3l5y+BFjpQhLZK4/uaUDYyK9+m6RWYMiVVO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo7RyfNqBb4ZkCC2PI4mLC/uc1Qf4cBzE1lfEiCf3JE=;
 b=f4Fox8VfCM65rfhK4MmHw16f1zIxTi+dPBzylIDt5ciHwxXkiNmMfkIfl+nk69qmNFKbqi19mPJ71nG281sYRxaDXU3ijSgVBeVe12an2xkTSJZVCSugtNS9FDXc7hulHJro1YY2s6wG9urwvlgogOPmS5TgWAVX1J9JIspo4dBgOhKmEXIw2lCLYr9dBbttru7jBRLLIoYHRcK1fi12nNx9LWq69FF5/2Ek3SHu2uAr8Hj/jV7xUh6BMrZoKvggA2LEcPf3yf8I46u3ev8wmGwoZx83xC2eO5b1w6EkSnG/PHb3ZSaps6lw+YF3WqluBrBAJkPU7VcHLMIl8g+lCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mo7RyfNqBb4ZkCC2PI4mLC/uc1Qf4cBzE1lfEiCf3JE=;
 b=lzbbAEZORCrNYJEmb+pYha9nBexpb0Sta2bcHB0KX6Gp3oAz1OQdjqbF0ZdfTmKMcOQMUVbI0FMnAeS5H78qwN+OUnjntfj7OWuAp6dNUuRgNorcSazfb9RmxTE5iPIlE8IksVbJgk0uheF39GXPX3N/q27l2q/vPqVmM7J75pzUMl/dKz1/W2cLDb5VFOpG6LYxhywQSOLVC600lqf3/g7viqwzTi8Rbs/T03B3uqG3BLJSE+lOwJOJQlfmvflmnNNkbDwCRNvHnjQQG/v88Qs4IJBBH/nc8hlE2v9z8xSpIEdSV7hGeCwsYRKyUIXyUIHzHHPGz1Jrkshzlo3cCw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM0PR03MB6227.eurprd03.prod.outlook.com (2603:10a6:20b:154::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 20:15:27 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::5c97:f035:18a5:ec57]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::5c97:f035:18a5:ec57%4]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 20:15:27 +0000
Message-ID: <AS2PR03MB9815DEDEA3CF40F3D54624E0C0D19@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 1 Feb 2023 12:15:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
To:     M Hickford <mirth.hickford@gmail.com>, gitgitgadget@gmail.com
Cc:     avarab@gmail.com, chooglen@google.com, derrickstolee@github.com,
        git@jeffhostetler.com, git@vger.kernel.org,
        lessleydennington@gmail.com, vdye@github.com
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <20230128142827.17397-1-mirth.hickford@gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <20230128142827.17397-1-mirth.hickford@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [aGKkzCNtqQDRU4aQa2fXRPi7VafRpju/]
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <5c7b6bde-97ad-9303-90a7-e9e461c5083c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM0PR03MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c69bd5f-a49c-42dd-d83f-08db04910cff
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgTnviBPDC2uLs1+Qoh2Qt9mBHYqNL/45q1KlzUA/UT8Y6LxBlaPNW1KuqHRzn8ZGeVLhxluaz0T0/AxN3ycD+np9bkAJ99hW7OtVZmdX9wCkF+08gAUmGx+IOA2eC8qFrVBCACeYUoZIlioa1405AcWxDVCwpF4lZW9CSqwVj4E8TmEAaD68TUODXgnSKrcmAfxOfeIo9dxvhf8Gk7GopuXxENDBx2haIxnWHc26kLaZXYOUDJD86JInHILjqJbM00WJgpmX2s4UIwIBeqR8TO0MVjH8aqm+wL9DKFOJTL5ol3j0t1XSevs0YN+8lSRKOqseUqTneeO4ZzNBTF2TyzlBecarZpkpb01Fwgpu+g61IdyK/dzELdWSoR8z0KtZwRV1Dp+DlBuN2pRjJ5gxLL4g5VhmD1g6A8VQMu08+nFdiklmf4jjEIjJ1F/aE4zPpj98CGLl0UiNZ3ycBC88A33xhxnuQ8gq4w36tUiW3manS7XfBUlomVy/JbPmOg3UQOoDrVF8kXWiHSw+ry4m3dsJNXQZ2R67HQkOSmhQGyJpi0fMaKbidDKs/LFFY1O+FJOVzZ3rpvI/IrC41l8oFt6gAZKjxl1ewWSYaT5ucBk7pkUS6paopsSHWhSHsUv+t9N/VQ3bOi2PwD9ijqnp+nExOmcliJngXy+zYuWoBo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2U3eVJLaGp0T0o4Mjl6dXkvZG1SaWV4Tm9aVmU3VmVrUXJWRG9YK2cwdWE5?=
 =?utf-8?B?UjdaNjJwL2xRK1JtOXVMZ0d6eFQwM0ZlYTRPNnJVVmltbkZEU3NGQzZ4ODUv?=
 =?utf-8?B?ZldmNU5TL01hbk9ReHNRRGZiOFAzRXJUMTl6TE5SMTE2Y3kvVzNySGF0ZDJt?=
 =?utf-8?B?dEozaTFEeWZ1NDExWUlKS2hYK29rNE95Q203MzkzaFFTdlRaWEsxSUpkeTZP?=
 =?utf-8?B?a3JCMnVNSjZ2YUw1L0VtK0dxc0FjZFlYNXJHRFN3OUhPNmNlYmZGTVlXVEN2?=
 =?utf-8?B?QTd5RUpYNGI3eXJVV1ZQaktpRnd0WG01SXZ0ZUJBaDFmUVhrdXcyeFVES0Jh?=
 =?utf-8?B?bzd1bXhhcE8yNm81V0o4bjkyM0hxOXIwaTM4QklFOURUMlJkQThwNlpkbjAy?=
 =?utf-8?B?MkRvWWMrWC9ESFlzZkpwU1RvMUl1MStMaVdiVjc4U0x3bis1NmxGb0RUNVlm?=
 =?utf-8?B?M0NocE9XbDBIQXYxMHg2SFZpdUxDM2VvcGxXN282RTcwdlpRc3UvYU5yZGJL?=
 =?utf-8?B?Y1ZaV2x5Y2JxQ0MvNnhsaFZQalliQW1HL1k4MS9lcWRVNW5sVHJXR1U0OG5p?=
 =?utf-8?B?eFRGT3gwdGpBRFU2OWFRQVljY1Y1RGl1YUlFRDF4ZE50bU9Vd2kzMThtbUMw?=
 =?utf-8?B?TThpUTV5TXVteEZrL2FQS2ZjSE1Bc1NPUFhUUnVNNzVnNnRiVmRoM3pZT0NE?=
 =?utf-8?B?dGRRUXhHM3A2Q0xuampjVnpFV1YzYkxTKy9qY1ZJdlUxWHB3cEorRVJXMGwr?=
 =?utf-8?B?TkR5KzA1NnRranNqV0JrbHg2NzdTZlRrVWg4OURNdDc5VG5CQ3ZFMVE1NEFo?=
 =?utf-8?B?OVpvZkx4NERpNFF3QXNmbGM1MU1jd21wbkNyQ2NPWDAxWkhNajNaak85Ynl3?=
 =?utf-8?B?M0tMdGZhdVVrbTB2VzIwSGNLNUZuWFZuSU50V1FaRTB4TE1rQnhrR00zdG52?=
 =?utf-8?B?WWpsZll6bmZFcWFBL3lMSnYzTEdpZ3R2VkpjbFo0YUJwM2xmMFJHdGtOcnA5?=
 =?utf-8?B?ditoYTJGOWlrOXVvaHcrWlJDWkNkYmMxazJXUlNVUWdKdVlqNG1HSGsvNUky?=
 =?utf-8?B?WUZERnQ1bWlVbENOayszeWdjVEVGME4wYXhrc2MrRDB2aVRmUmIvcFArK2dL?=
 =?utf-8?B?VjlESXBNN3BNTmNhRXgxNmpEMlJuSTdjWEJ6Z3gwWmVNY2M3SUx1U3Bvdk0r?=
 =?utf-8?B?b1NIeVYwcXBOd1lWYnpPQ2M1Tm5mclRHUVprSkRNSnEzaVpQcW9vdkRteVVq?=
 =?utf-8?B?bFBlb2NGWWM1YzhaOUZOQWhyb0k3TlVEUUNxR3QyTTRPUmdnS0Y3V0kyekNQ?=
 =?utf-8?B?bDgzbUprVUplenZUT0dDM3pQREMwVEJGSUVsbzhpZXNRRHlVVzhXbXVQd29I?=
 =?utf-8?B?OVdoaDhFRXR4dExzcE9MNVA1R0NCb3NLaXBHVmRleEdvUEhuNTR1UkE1cS8y?=
 =?utf-8?B?STN0bXhUVVZwL0NxUFk5SWxyc0hWekxBL05OWWkxR21IQVFPbllVMUNtSmhQ?=
 =?utf-8?B?aVFzOTRLZU5ZMzI1V2crdGdmZDJnYVpqQXRaUzdqemJDbi9Da1ovZVRxSVM4?=
 =?utf-8?B?WGtxYTUrUVAzQkNhelhSUFlxQzRReGxVUEtkZDRzbXRuU0NzNkpkRDBpR0ly?=
 =?utf-8?B?dDIyWVFRU1o4ckhTWTdWQ2FYNU9NTXdZaWJFNm1mMWhTVzduSkJGcGV3cEQ5?=
 =?utf-8?B?Q1hLR1hHQklJMm9WOWxieXVZR1ZDalBJeW1KYUZPTG9wb0hRbENZeWtRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c69bd5f-a49c-42dd-d83f-08db04910cff
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 20:15:27.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6227
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-28 06:28, M Hickford wrote:

>> Future work
>> ===========
>>
>> In the future we can further expand the protocol to allow credential helpers
>> decide the best authentication scheme. Today credential helpers are still
>> only expected to return a username/password pair to Git, meaning the other
>> authentication schemes that may be offered still need challenge responses
>> sent via a Basic Authorization header. The changes outlined above still
>> permit helpers to select and configure an available authentication mode, but
>> require the remote for example to unpack a bearer token from a basic
>> challenge.
>>
>> More careful consideration is required in the handling of custom
>> authentication schemes which may not have a username, or may require
>> arbitrary additional request header values be set.
>>
>> For example imagine a new "FooBar" authentication scheme that is surfaced in
>> the following response:
>>
>> HTTP/1.1 401 Unauthorized
>> WWW-Authenticate: FooBar realm="login.example", algs="ES256 PS256"
>>
>>
>> With support for arbitrary authentication schemes, Git would call credential
>> helpers with the following over standard input:
>>
>> protocol=https
>> host=example.com
>> wwwauth[]=FooBar realm="login.example", algs="ES256 PS256", nonce="abc123"
>>
>>
>> And then an enlightened credential helper could return over standard output:
>>
>> protocol=https
>> host=example.com
>> authtype=FooBar
>> username=bob@id.example.com
>> password=<FooBar credential>
>> header[]=X-FooBar: 12345
>> header[]=X-FooBar-Alt: ABCDEF
>>
>>
>> Git would be expected to attach this authorization header to the next
>> request:
>>
>> GET /info/refs?service=git-upload-pack HTTP/1.1
>> Host: git.example
>> Git-Protocol: version=2
>> Authorization: FooBar <FooBar credential>
>> X-FooBar: 12345
>> X-FooBar-Alt: ABCDEF
> 
> Interesting! Can you tell us more about how you hope to use this at GitHub? Could this be used for OAuth 2.0 Demonstrating Proof-of-Possession at the Application Layer (DPoP)? https://datatracker.ietf.org/doc/html/draft-ietf-oauth-dpop (some of the fields in your example look familiar). 

This would be exactly the sort of thing that this would enable. DPoP is one
example where the correct auth response requires more than just a username/
password pair in the Authorization header. We should also be returning
standard headers like 'Authenticate-Info' on 200 OK responses along side the
'store' calls to helpers; they could contain nonces or other important auth
information.

My end goal here is to extend the credential helper protocol such that that
helpers can see more of the initial request challenge, and then modify the
subsequent request directly, or configure and let curl handle it (the latter
part not present in this iteration).

One thing not called out in this doc is really the need for some capability
advertisement between Git and helpers - for example if the curl version in
use supports CURLOPT_XOAUTH2_BEARER for bearer tokens.

> Challenge responses are typically short lived [1]. What happens if a storage helper is configured before a challenge-response helper? We want to maintain composability of helpers.
> 
> [credential]
>     helper = storage  # eg. cache or osxkeychain
>     helper = challenge-response  # eg. oauth-dpop

I think really this sort of thing is where the credential helper protocol
isn't designed for credential-generating helpers in mind, but only simple
storage-only helpers. There is no affinity between get/erase/store commands
meaning one helper may return a credential for another helper to store it.
Not sure if this was ever the intention, over just the need to consult a
list of helpers for a stored credential.

> Storage may return an expired challenge response stored earlier. This could be avoided by introducing an expiry attribute to the credential protocol. https://lore.kernel.org/git/pull.1443.git.git.1674914650588.gitgitgadget@gmail.com/T/#u
> 
> A monolithic helper configured alone doesn't have this problem -- it knows which parts of its output to store or discard.
> 
> Declaration of interest: I maintain a credential-generating OAuth helper composable with any storage helper. https://github.com/hickford/git-credential-oauth
> 
> [1] https://datatracker.ietf.org/doc/html/draft-ietf-oauth-dpop#section-8
