Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF57C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 14:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJFOUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiJFOUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 10:20:17 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81491180B
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 07:19:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj/yKRQ5CSYDEMYtTa3QnaFxyOI4R+vKug6ejOSmXDzIcQOJAh5Bk7LETh5yyPiaZmFCKVCuDfuNZTrPGJShU4mQCiVAb+7wIZeRrvcG22s6NFIP8fjal4Px3b8eIBlS6sEPmvWKVztCPBQI0T956GM8TakMuKFxmzoPPQfjw0jC8gv4HdCHUvjo3iO36z0xCCxrTHRWxPGI2BodeiCRLLbXsSNW+cd+AOsC46jNezJ1725RV1xROY10O2H7KSzh2vaOThq0GyEg1LO39ZzZPR7hgNghdjO3Ml73vMFGTTZeQiGrlrypdv1VKiN3vg0g6oFsf5TLAPtwhnH20EgJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj+fwoqgJROJuscPoVpvnui8v2br5w9UmGZaWMvg16E=;
 b=E8DalB9ofZas/S9Ky5JTujW4ujQsJ4+g1O6cdsjwBGWhlLjQC9/GSRsy+rPv5U+cUo5dhyK4Tj4QKv5ZXwhylQkclG6deWYu41oHetEgC1Bls8KwHiXRxQ3843vz9ys4yqUdVHpr0b+mXdhQWwwu563XV4tWDK7RSSl0xIG7Z80la/GOukg6FZfkj6qveXWkOBK2W/rcmqI62wO5XJ1sPdjrYg4XPDfyqeAf/gVZnKRSqvnEOZsoL7d5N+08YoYScEwYTNBObeyG54Q4A5MbV9bWR68+l6mv+B7G4MxKktXbTg8+4hKVRlflY7dhTJla3TSk8Hz9TUe0WGhXooJXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj+fwoqgJROJuscPoVpvnui8v2br5w9UmGZaWMvg16E=;
 b=ZksxDf3BTAIpeSwwDmOEW59GLXhClBJLzxuWDuqLuJbi7lK9YKOcfKH3SyvAl/GB6b8NH1rcOWkHb2G2uFQFYxENZGSHlBe3LPZ/yI/wXAk7SnHlUYDRd5Si58JxFvcAiVgmPb7CxTYGZ2FIxObnWE/SaqxygIET+OEIeN02kNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10d::17)
 by DU0PR10MB5582.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 14:19:25 +0000
Received: from AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::545:2b60:d0bc:1402]) by AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::545:2b60:d0bc:1402%3]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 14:19:25 +0000
Date:   Thu, 6 Oct 2022 16:19:24 +0200
From:   Fabian Stelzer <fs@gigacodes.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] ssh signing: return an error when signature cannot be
 read
Message-ID: <20221006141924.7rxj3ntq24hynj5t@fs>
References: <pull.1371.git.1664789075343.gitgitgadget@gmail.com>
 <pull.1371.v2.git.1664877694430.gitgitgadget@gmail.com>
 <20221006082817.4uxywfxjokfyml6y@fs>
 <ce32d5c7-c62c-b27f-23fa-566cba65c383@dunelm.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce32d5c7-c62c-b27f-23fa-566cba65c383@dunelm.org.uk>
X-ClientProxiedBy: AM6P194CA0063.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::40) To AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:10d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3271:EE_|DU0PR10MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b3fbfd-90f4-437a-6488-08daa7a5c5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2/FTgUaWqQgXqQYyZvJ3fRtwUwUOwmGBFfhV5f77+fPP4slVoQRwlcaL1tSx4+jKyFKFnia2PTEvndWo1V+VYzXX1474r/WFlyrjZf4cPwVgC2PRnIHfxMTarsob1iv0qT/eUtUlopFY3vjr6wkzUgTSIQo1B+EV8KI64w8ghbXha3VSL0q1e1kOue5lb7qhltf9Q4hwcDtLNJWIuZsceqRU3czNPBKVPuAqWUbQVDEW45DllCg3iG+UGO0PyitHDdkQISY8s/PmW3fQSMmzz0YUWxP4Rn/m6yRcZCtA9FV1xiy2MCr4PBDP4SLGQ8ffmPiaAOpgceFlFAlYI3Zth7g2ewobv7+XdZE978ohtoVfoFUIjyhUMaTA1nqJFxOUGYZjqrUyR9ijI/CjCZvrlOgloUUYhBskr36SuFbJ1zBASCkRgiJQAWlwojL/h4QwslsesgNA5d0neaJto1lZWj6TX4n3270Ew0kOxe+QAcUYdlOWXy98CF44cU9DBX+jeLcpzt25pIngvfzmZ+UtPtG35DjxuPwOxH6rU5e7+vu++SKB1vaKd54Vo9caVe2PoCgRySpFq2xLKEsUDhWTabQUNcAdl2JqrJ/EXiVWSWTK7ZHsZC1x6oSY1xWV208ZHzR6YOwYnIJaSVAy6RX8+KeNcJLAx1ciEgnFOQxCg+NkUcuqXUqIRHE+3biFCE7EGGRfCAgd8vBY5QiqXVGMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(376002)(39840400004)(366004)(136003)(396003)(451199015)(1076003)(8936002)(5660300002)(83380400001)(186003)(6506007)(4326008)(6486002)(66946007)(33716001)(26005)(9686003)(41300700001)(66556008)(8676002)(53546011)(66476007)(478600001)(38100700002)(6916009)(316002)(2906002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmY5MU9oUmZEcTdQdWhjeE13LytZbG1IeC9IMFFQeVp1bFFEbFo5am1IMnQw?=
 =?utf-8?B?L3lKTWF3SlI4RDhycm9EajlxNlhKQjQxQktMOGhZMnk1MWFaMStJQXhja2xR?=
 =?utf-8?B?WnFGYUtBNWpFQWlwblNJeHArMUlLdlJDZGNvRTRDTnVKL3BwRmhJRkdhNnJC?=
 =?utf-8?B?QUVMeUtkWVQyWEx4ZGhhOFlVU3k3MzdRem9ZYmdubmpMS0ZJaTF2aXlzcEJQ?=
 =?utf-8?B?N1R1d2Zqdzd2ZFhHWXdWc2VoUUdRTURSYnQvdFZBSnZUeGRVbHdYa0dMWTdh?=
 =?utf-8?B?bXc2MTU4b3FBV3pBOVRXV0lnRnhZcGZwaFhISGhzZUl5aDFRTEswYURoa2Va?=
 =?utf-8?B?QVI1dlRnS2ZqWW1qakZnTGw0WCtGR1FYOUJZbHRJM0dqT0oySSs4L29yd2Vh?=
 =?utf-8?B?U1JNRTcyYTE4TGlXbFExTXZqYXFlVXljaFA1OHhRc3RYVWtIbkVNMGtSUzVK?=
 =?utf-8?B?cTBhaytoM0lXWTI5TFNXTDdKTVJ1Qkc5UHNZVHVVVXZTaTRzWDI4a1ZETlgw?=
 =?utf-8?B?Tk5VcHhSbVhXZDhJMmVzZGczOTFCUGpTbC9zUmdQOXg4UE9FY1dKL3pZWmNF?=
 =?utf-8?B?YXFoOU4xN29kWjYvMEFKOFpZMmx5dTdBdDRQZnBnSnIyV2QvcEQrYmtHYzZI?=
 =?utf-8?B?K3Y2MTJCNFlVY1hMeUo5ejNOQUF4ajBFeU5BN1E3dTRDWEEzdlBoS3V1eFFH?=
 =?utf-8?B?OU9HaXFYRXJiam9WUFBsNDBKSWFEK3pzV2hOVGNqU1hxK01zdzNxR2VEOWpM?=
 =?utf-8?B?dkVGWXFUWUJOWWpqc2ZwNlZId2RIa1l0R2p2WjU2UGFkWnpUZFhqRG5oZSs0?=
 =?utf-8?B?cXJtbldCZ05RUVBFWkwvRHZSL0YxK3pBTnBSWmlTeXJNcS9UY3JWVFhMMTZL?=
 =?utf-8?B?dEY3Z1k0bVVRWUlHNjR0N05ZNGNoV001cWY1UGpTMTFOUlNuZUF0bVBES3R6?=
 =?utf-8?B?SkhNbG0vT1d6WW9heGlvY1ZXc0hnTlUvNUFYNElQZ3JlZDYzdHhNakZiYjdE?=
 =?utf-8?B?OGh4eHVobDRpZ3N3T2xwK3RGQjVMb1p0WVFaeTdFaWd2UWtGZkFXRThSRnMx?=
 =?utf-8?B?NlIxbWpEajh6M1AvblVJSE1IcFJVdzZnUVNRaUhrUHBlcVlRY1drQzZ0ci9y?=
 =?utf-8?B?SzRDV0lpODhzQkMwU1orTVc3OTBjTCtDNy81V2l4bXBTYTFwa1l6WXIyOVdq?=
 =?utf-8?B?QzN4YzdBbXpMcGwxTFZ5bis5VkE4RzJKdFU1UmZNeVZiS1ZIRThYYWUwQ2Np?=
 =?utf-8?B?M2NTWmgwOENYUGxkS1ZXY0k4V0t3WDErS2ZPdDliYzNGT2JNUk5CZTFqdzlq?=
 =?utf-8?B?MVY5ek0vZjR2M3BTMDlsOVNIMFl4V0xDa3dPVE81RjRjbnJSeW5yVUwzUjlu?=
 =?utf-8?B?VTNJSE83N1VWU2U4ZjNGcmFybE9uVWpiUklKSGViV0x1M3ZEK3h4c3VyZTM5?=
 =?utf-8?B?bjZKdWhQeFBZTGY1NzhPdDE4bXphTWc1amhnaGpaaHBtWGUzM21wb0ozcE5M?=
 =?utf-8?B?QWN6bWR1SUpzSk1Sb2Rwa1RPVU9qcnVqL0RCL1pyai9ieHpyYjdidENJU2RF?=
 =?utf-8?B?dllkb3J1Q3JBVUpzKytaeUtIQzRnNU5teE1yeThmNVZkNkljckRTVDVaYmtF?=
 =?utf-8?B?NC9PUkc4c1lQTHBjS1ZGWjFQMFRYVHR2WmFGdFFFWFY3MnBZU1oyQ0xiakhi?=
 =?utf-8?B?eXBJREtxa3FFNU9vSE8xQWxZYnlORXBIYWxudG55RS9ZZFRjWVFsQ2FWSjQv?=
 =?utf-8?B?Vzh5OHdpLzNHTFV0azFTK0orUWdVcDlhQ09qUmpLeXV3U3ViTFpWOEJrWHZQ?=
 =?utf-8?B?NWJvSU96MUUyb0lsT28wdEMvNEtZZHpyT1QwZEJFNGgvblVITXoxS3pNclR3?=
 =?utf-8?B?VTBCbm5hNEJVS3NWS2U4UHcyR2dCcFpoUnN0eFhFcmEvN3JMcnVIclhPeVpr?=
 =?utf-8?B?dW94cDRYNGY2bHpHdGp0dmdCZXF5bEZpU1k5UElWSFhSaXJXSk10NVJqWVIv?=
 =?utf-8?B?bWh1SzNsNmhXU3k2ZkJSTFZZaUxVRzlBT1kycEc3blJhSXNBNk5VWGtoNVBK?=
 =?utf-8?B?UnRFSG80SEtzV21XK2hqbjU4MWNUUStmU0puMEhKTjdxTlg4emJLeHlHejNP?=
 =?utf-8?B?SnZkVzljbUpEVDgxeUhEVFFIK1QxZ29QVlpqc3gvRDlNSmxhY3NiVUlhb3Rs?=
 =?utf-8?Q?Hi0s6Ob6W+7EivaUR+7MWZo=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b3fbfd-90f4-437a-6488-08daa7a5c5d2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 14:19:25.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Stmmg5S+o6VOtYYtFw5afe+tSTsFUtK03ws3WQwht2PwQO+Aj836zhW8HPfQKZ48DTWvELzntkM36/iEKc09aU1QJSKovvG++PaqDd5oonk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5582
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.10.2022 14:05, Phillip Wood wrote:
>Hi Fabian
>
>On 06/10/2022 09:28, Fabian Stelzer wrote:
>>On 04.10.2022 10:01, Phillip Wood via GitGitGadget wrote:
>>>From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>   This patch is based on maint. In the longer term the code could be
>>>   simplified by using pipes rather than tempfiles as we do for gpg.
>>>   ssh-keygen has supported reading the data to be signed from stdin and
>>>   writing the signature to stdout since it introduced signing.
>>
>>The ssh-keygen call is already using stdin for the content to sign 
>>or verify. The signature and the signing key need to be files passed 
>>as parameters to ssh-keygen. I'm not aware of any other option of 
>>providing them to it.
>
>We use stdin for the content when verifying but not when signing
>
>	strvec_pushl(&signer.args, use_format->program,
>		     "-Y", "sign",
>		     "-n", "git",
>		     "-f", ssh_signing_key_file,
>		     buffer_file->filename.buf,
>		     NULL);
>
>	sigchain_push(SIGPIPE, SIG_IGN);
>	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
>	sigchain_pop(SIGPIPE);
>
>Note that when verifying with -Y check-novalidate there is a missing 
>call to sigchain_push(SIGPIPE, SIG_IGN) as we are passing data over 
>stdin so need to ignore SIGPIPE.
>

Hm, true. I was kinda sure it both used stdin/out. I'm short on time at the 
moment and can't really work on git stuff. But I hope i can at the end of 
the year. There's a few more todos on my list.

Cheers,
Fabian

