Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7824EFA373E
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 20:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiJYUuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 16:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiJYUuI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 16:50:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2061.outbound.protection.outlook.com [40.92.89.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E577220D4
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 13:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9MnZ2Acsf/uJ3+ZuhBaOPssP3UmnhFdSoCDyWygvqBpB6wu1Xg28kSoVRFQkaau5zxd5T/GPbRoH75D5dqrHv9yAiT4ut10Yefuo7hveAca80PX3apsUZynugYzglDYHqfssQ/gE6TuQIYPnHtVUGGW98cbAeY4rAdCsHYxUKN81ZlxosyjwdIPSGrXXik04M6W71DNYwVBi+o3V7IH7hJaOF15jVAeIA+Nt+L3vWQC25v79QlQh4QwqzmgKfeQ8Is40yAYXKhU/w1aUnu4e0JpyNiduIx4fy4N0wCCAYIkjH2XRnyzFRNkJT9l7k9Sa4flpzFymmRgg6tpMUTkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo8KOX/6MRr9gPQ7EHwElSBQ5e5abUqd003XeyQYiSk=;
 b=BHk4RMO4aGdz46AZ7ddhIt9R8lNm5eTaHEgfZqDQyyu/dPsh9eK+kx/u0AMVD8vEsbfsAfchDNbtcUV+O8BvDOsfgq+ZKjK1bkKqVcDMZ0XRI8WJS7sL0iSgb2cjyS39BBoTaohDFUK/7+VdJzA7yKJkqTPSUag7y7j0ugpaNJ7I1jlKDYgOsVb8nkpSLe5DPtFePH0Zl8Zv69c0/2ddZdsJM6Ql1m2V0CVEFe4AY+n+LSB97sAbhVR9Lq2D4878qzoK8IfYfNrYmwdED220U5xeeJvnEPwNlT4Pma2Q7d9r6Nk4LP7Fvudqq1cRlT2totQ+20nyz8QfE27GHZuOFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo8KOX/6MRr9gPQ7EHwElSBQ5e5abUqd003XeyQYiSk=;
 b=WI95mv4FPXzCCKGxYYbQ+vfVYpAPCrTBldhVpo40pdoORurbkvQoH8PY1vAw64PJOOpzbwdRs0xum52ywVfHnXmI6A0b9ryNTO/m17HnYM9E8A6ORqGvzG8uLmXZdtvMbETsAGOmxj3CM5uZJptV0u6ptzhKfu8qm/5U/TK1VSnu93u3kq1OneP9YoO9MlPaFEyMTBTQsCTsjYhX4ma1mbgi+OCIY50hy/HC8ycLAGAI9dD4pmSZn52pULVj9gn/pgXcx6P3M+8tmXaLhPoatjcodI0VLGw1v3JfRPd9VFVcIzGSLZIlC167pA3h7rZTAkQ6ksQeg411L8gKlfQexw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by GV2PR03MB8680.eurprd03.prod.outlook.com (2603:10a6:150:78::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Tue, 25 Oct
 2022 20:50:03 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::a3b1:6b8c:97ce:8e66]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::a3b1:6b8c:97ce:8e66%3]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 20:50:03 +0000
Message-ID: <AS2PR03MB9815DEC9CE65268675A3A68BC0319@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Tue, 25 Oct 2022 13:49:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: git-credential.txt
To:     M Hickford <mirth.hickford@gmail.com>, gitgitgadget@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org,
        lessleydennington@gmail.com, mjcheetham@github.com
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <20221025022623.5449-1-mirth.hickford@gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <20221025022623.5449-1-mirth.hickford@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [viTClCasTR/BNaiGCHQ1C7JHFrAiv/EDIB3UHB/iNcE4oBjzEu6I33UALe9MT6iZ]
X-ClientProxiedBy: BYAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::17) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <21993240-4db8-6f7e-e302-7d10cb513a7b@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|GV2PR03MB8680:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf4c3ee-5da0-4b80-abfb-08dab6ca7d76
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojTyBVYw+fyMAplOg8BuSLjjdCdNAj8NrSaqU5CNiOmulYBYfHLK/JcYXPzq4wyViuD1pUu56qMPrM8Dctb0dXEv3R7tsRBfXboP0/oedVH8geStX7D4iyoucWLc/Xt2nZsK23Ww+wMucPml1/fWJCDiNfCSX4FSUo+4D/NUNmEA9yGrDCAV1UeX3HG3PSdUYV5kjTkwCW9cOCs1BoahdyU1m01eiuBtBwwK747XlcmKnuItfiBI7h8baZVvGSxcm1v4iD/nPI2nn+wmTTn1DzC0CRzQ/08INjWpvFP09saPFl/nid+WvORtK70K/94lX4aJ5ac/3WOcqAoHJqPaHkRB22C7WXDVFr8nfHkBgLEjSXEPcZYK39JSY611mW9/26JYN5MUQz8ziuAHEKQsO2oxOd+ZsujxmbwBia4nyqS7CXQpFGn0p/gUrGgVX0YiRx1F8qpaGa2FKy6ZCBCm4dw1qq9GhE0W7kk+6DDBU5vEsPAS/BN/uOWXXUlye8F7bHzqNinEiyloCP2GVl79/4wzVbPIGomSuMYV95cyfcch/5rzUmewSzTP8hS13wZDaOeDYfBwn5Jkum0JmcSc6K+9O2ron1QJMxQ94QGfwfxJN1clPFdRrSPv5EMXlCfrFFGR59SXZmonfIFXzHfI6PzoE3UHOtlrmghU/rIYKV+pBjOavBkEmRErIRi3CIuu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnkxTkU1bC9NQkd6MmUydWE0b1RremVjcFEybjVSSGRWZ2lWNXNlcXVpVHBj?=
 =?utf-8?B?N3hPclMwUmtVQ1hsVnQ0UlR1QWtDSmdoY1JpTnl5bVlxWCtjMUphd2ZuYnM0?=
 =?utf-8?B?UFFIeDdPTXQ2S0YzUmg4MmpuaWRiT1h1a2ZhUzVIdUZyc3c5WUJUeUI1MlpW?=
 =?utf-8?B?YStCRVE3cVBEaWFXNEQrellMRkVWc0VOalFEdzVVTjNZa253TCtzTVhPc09V?=
 =?utf-8?B?S1VRQ1dxV2x3bkViVExkckZHdGFMOUFta3FnaDRGVlc5LzVMakxnaFlnTTZu?=
 =?utf-8?B?TU5qcjVHMFFiVE1EU3JPYUNjV3FrZFhEOFNCSVFTUE13UzRRbnZ0cEs1VEtP?=
 =?utf-8?B?bVRpWGgwalVaTzJsK2Y5SldXRUxMRUFuaEJtV0JRQ0pHNXIveGJra2lucW5J?=
 =?utf-8?B?YU8vN0FNczdHVW9Nek5CN3haNEtncGNMYXVaRlUrOENBYUZybXNWTUFTZ2FP?=
 =?utf-8?B?RU10c0NEejRSR0FHRTYzU1g2bm5ZZVEwczZOUGo3eERoTTIwSlUwSXNpSE5N?=
 =?utf-8?B?UE15aTVYZUhlQ01vV1Mvclp5S0YwWER2aDR1WlhMT2hmaHBRS3EzcytqcjJZ?=
 =?utf-8?B?M0VJSloyQk15UDE2RlBxdmdmMitkTnRmUGJJTW5Vajl4bS9nN1RraUQ1OWJi?=
 =?utf-8?B?Umw3cFBvNkJYejNRVGNTZElJTHN6UkpuK0NYMnFhWnZFZldhdEVUZ2FSYkpC?=
 =?utf-8?B?OVlxS3hZNURIenRWRjhzRlBEa0dJNE9SUDErNk5Ud3pJK1d6WU1wblkwSnFM?=
 =?utf-8?B?OWdJWGU0N2dMR3lxclJCdGhCTm5PZ0VKM2U0S2dSWFozMzA3aGJSQ3ZTT3ZZ?=
 =?utf-8?B?WHphZklHNFR5ODdrRWhWNDkxekhBUEsyOTFxMVNPc0x1NjI0ZUpPS0VmZFpw?=
 =?utf-8?B?NzZXQ3BONnl0a3lLY2JIbzlCTnd1VktEeEZEUVJRTGtXb0RRYnlUZFZ6c3Jo?=
 =?utf-8?B?U2J0UmFhSExuRTY5YW5WV0NzK1BoSU9SMjdrQ2dtd1dycTIzZEFSWGwzdy9w?=
 =?utf-8?B?V0M2aUYxVnFTZkoxT29CYWoyZVluamdFRCtONDNGNDZvM2J4MUJHS3JVTlhh?=
 =?utf-8?B?RGs5ZGRhTXB6Y2tNbzhiK0RJOStCWUdEY3ZJK1BBYmY4QnJSdHZrZDlJc05Q?=
 =?utf-8?B?cUxxRlA4emJKSUR4NzBCVEQ4N2IwdjFXL0NESURBcHVCa3Y4WDRZM25yd0No?=
 =?utf-8?B?M3dmSnlpYStiaDZvUERiWXd5V2FrSWlJMHo3dThVNE84bEdBS1JqUEt5WElk?=
 =?utf-8?B?T21kekxBT3l5VWpEWUF3cDdLcW5STURtZHNwY0l1ODVLSmtYYnVnL2NKaENB?=
 =?utf-8?B?S1p2UjFrM0cyTzUrTXNRcVhBMFVjVU5QcGJSQ08xQjhmMjZsY2JRNjRHUlpt?=
 =?utf-8?B?dk5DdmhEdjVYR2R3U0hod2Z4TXVvL2F5SEJ1REZWUGp3NGxNNmZoaW54bGpk?=
 =?utf-8?B?Ny9HZkpVNDNSeFdRajh4UzBtajVyelhxaWpsMkw4THJpTjlTelNER2pwK3Aw?=
 =?utf-8?B?QmI5L0ZqSWk2VDJyVGVxOWk4c2J6Q3VCWjYySzZBWkxWR3FuNThJOG1TUjRE?=
 =?utf-8?B?UU9iMmU1aVNQdkh3S0cvalVYYzRpQjF3WEJ1ZkRXa2dQREc2c3VBdExYQ1Y0?=
 =?utf-8?B?OWZ6R0NqT0ltTGpsaThjaWxhUTIwUDE5TDQ5TzRyMUVqY21tb2lQVCtIeERl?=
 =?utf-8?B?dlEzejlEWDVMdUZlVjJlYnZNNWQ4SnlsemFhZ0RRcHpFOWhuZnlFTkZxaFBN?=
 =?utf-8?B?YWs2eHFONFc2N1I1bXpEMUZna0RTN2Z5VVZjVTYxRDF3MXVaSDAzSklxS3p6?=
 =?utf-8?B?cWMxdis1R2tvNERvN3h2QT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf4c3ee-5da0-4b80-abfb-08dab6ca7d76
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 20:50:03.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8680
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-10-24 19:26, M Hickford wrote:
> Reading git-credential.txt, I'm not quite clear:
> 
> 1. Are the new wwwauth[] and authtype attributes populated by Git and passed to helpers? Or vice versa?

The wwwauth[] attribute is from Git -> helper, and the authtype attribute is
from helper -> Git. I can update the doc to make this more explicit.

> 2. Should a storage helper store these attributes? If so, must the values be treated as confidential?

Good question. A simple credential helper may wish to inspect these headers only
to differentiate the different authentication schemes available (basic, bearer,
etc) and return a credential of the correct/available type (and include an
`authtype` attribute in the response).

However it's unlikely such a helper would need to store the wwwauth[] values
as verbatim unless it can directly understand the parameters of the challenges.
The addition of this attribute is for credential helpers to gain more context
about the auth challenge from the remote.

For example, a helper may receive a bearer challenge including minimum required
OAuth scopes and an authentication authority:

wwwauth[]=Bearer authority=login.example.com/oauth scopes="code_rw userinfo_read"

Using these extra parameters the helper can try and locate an existing stored
credential that satisfies the request.

Such an enlightened helper would need to query stored credentials looking for
matching metadata including the authority, and a bearer token that has at least
the minimum required scopes (but could have a superset).

Thanks,
Matthew
