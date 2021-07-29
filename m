Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C733C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 13:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F42260F00
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 13:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbhG2Nwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 09:52:53 -0400
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:13921
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237694AbhG2Nwv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 09:52:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIPnCWhIkj6XjzeK0T64O+7m2OLnFQuAkioObW6v/pDCgE1Xv0cCWqdOelH/HHjUEjzJbGGnPoOtKHQ9GMQvHjNyGj/a1v24pokvsaUnj+/0M7OMf3kqg36+Dnf5WEjzVaJ9z32wccCEJ2zVvnjin3JFBFkXNhQ8OXpuUj00aNVJRbeuA2gDATy/tUPvewQQW9bCDb87xqQzY16475o1+eYqjRyzOJ5k+2TW3ClGQBrYbYAaGhY5UgU2QVfNXDGkMwAmGUIJDpvb9pjLrlATrGHNx3MuK1sNx77qKXvW8f9OKXmVrPvQSZ4CAdDHUzT343ocbgo6BOrer7BVhjv/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI/vJzP7wTiMF/MgE0tUY0N+DQDk6xTjO6SkTWENsO8=;
 b=i67pvZ6pEgfyVbpVskY5dtHOLLHXAvS3ltA6k2xaYatnJ9VreMNMWhEL+WqrDZ6x1873GeWkiccMAQlyWwVwZr7LrO9kg9vP8Sc0pRoRrExyzV3ECoZGtios90FybWLC+sTHXPsglWl9mP4J/fB+XVHJdzC//q4akpM2MviQQxbyFQxcx2wFaz3W74yLyjSlhH1zAx0wVE+EMi9JPnm8gRCo2mJwROr1CatSMqaimB10umKNqKgozOhH5Ac2HrAjxJmgtSWaFsIxPVbXo0z725hauGdu2nkv2VcbuTQ+pJ7sZQCpwyvNG9LCq0YWJjMAQWdIYZoZnnLdFSwzctvezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI/vJzP7wTiMF/MgE0tUY0N+DQDk6xTjO6SkTWENsO8=;
 b=SX51UuL8lQG3Fde58zVYeE1xpA5B2XgQt465z08Hptx0mDHSh2YCMNW+S7Suj0afHQIiyuVcjWascB+stO4n1VnM0EJpEznVFOvjWZ2qiNSqM0wSIvd/DAhASVgAG9/Bbb8TP6P/rhLUrPJ18Hv7EiCL3rHEIm8iYOKZW3VEsaw=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
 by DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 13:52:46 +0000
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178]) by DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178%5]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 13:52:46 +0000
Subject: Re: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify
 signatures
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
References: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>
 <20210728230452.2719333-1-jonathantanmy@google.com>
 <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de>
Message-ID: <76cc0f7d-90d9-18bf-e749-feff8e584453@gigacodes.de>
Date:   Thu, 29 Jul 2021 15:52:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12)
 To DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Thu, 29 Jul 2021 13:52:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b33caf0-c17f-4cd2-8738-08d95298250c
X-MS-TrafficTypeDiagnostic: DBAPR10MB4187:
X-Microsoft-Antispam-PRVS: <DBAPR10MB41876A435223A64B278DF951B6EB9@DBAPR10MB4187.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pl8D0FzQ9j5hrIIolXcJwDzq34nqpfpB3Q7eqm3ugD54UCW0sIeqC36uNilNrnSgXSA+iFDDF/00AQkUEZAA2HL630rEKRlt/ITAU7PnSaPbg+AneMiO9GflYef2uY+R6A4PgWno/s9hiI2p2dMaY/BIDnZMaozkvrGpK1FwezbdZWHPkTCy1PRNk+Vn21PcZPNH2SyLc/3SORRarqnyh+L8xT7HYUhyws9ABmw0Am8lceYzTOJLtYb+lRJdn/QKiGXNMLBdxHBjuxSfC8o2j9t8Fvu/8PGsm9aauwu1aUnEJEGqYvj1W/NKfhUt9s/NDvsh8zziooIHpkVRchvJ7sC9u+Ou2XVVt24W7M9GeaN7zoo+xUQRIGPVSmJb5SmjNyw0dc7pKHEKqXv2P1+rQfGeJK4CMvSy5JLw3tZuZiC/rbbRhR3JVKPXVohEpK5nqDsprLvaqeP8YiNrr9XKFp/eF2D1HuAHSrkIZZZy5f+pSm5pBVSPh/VKI83S/kGUc4qXbV30cqaePp7dlGjUur/o4c71r5BC8QiSFk5iw/zxL1BHb7fAmv1KGMc08Nrv/cKELPajK4mRaCtR9kWNiiwAOUrrDS4j8kt4BadgSJQgk/gm51aKs9swVt6KEwQhflL5s0J/XnbirW/t7vmqwbJOLPdeFilQKfT6Qlj1HWNlC/GRHbU3JVTwRJimowymYxhwsEDpy9yIMZ3zD8fAGqyq1oqo/zErE6LEi8vKbhdoYYZqlZ0ekOi+CW3w4cqS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39840400004)(346002)(396003)(36756003)(478600001)(316002)(7416002)(83380400001)(8936002)(2616005)(86362001)(31696002)(15650500001)(66556008)(38100700002)(8676002)(6486002)(4326008)(53546011)(66476007)(186003)(31686004)(5660300002)(66946007)(52116002)(2906002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFPZ0kvZ1Y0VUVtQ3JpMHNPNWZ3NDNkamFGVDk4VVk2cklpT3F5VUwwakJm?=
 =?utf-8?B?NmxmQ1B2UkUxV1E2b0lrdGx6SkJFNWhaRHlwM1VDSUZmZ2pycThPQ0gvV3NV?=
 =?utf-8?B?UHJOT25aY2RrR3lOSVZ3UDNEUHNETnB0eVM4MFlONnpCWXZLazU0QVdmeGNS?=
 =?utf-8?B?bTV1a3lHbzNEM0ROY29WSkwvY3NLbmxleXBESEt2NzZ0Q2hieG0vb1U0akc4?=
 =?utf-8?B?dDhGTXdxb0txTGJOeVNIT0JhUVRwY21rQ2dBZG04VGlwT1hFL1VuZ0RHWXM5?=
 =?utf-8?B?T1NtMEZ6ayt2YndleVBxb0RoMEl4L1lUZUxpb0kvbHNyOGVONnd6QkJETzht?=
 =?utf-8?B?UGlXUFNNb3RIWU8zODUvUVFWeXhuMlZJampidW4vYzdRRnA2UUVCUmlJenk3?=
 =?utf-8?B?MVczN3Zwc0FkcnArSWRDKzlEdXNyVCtZT2J2b2owc3dFWjJPYVM0SXJSVVNI?=
 =?utf-8?B?UDZSR0dCc2E0MDU1ZGY3NWRwYlFuQWphNHEvMDljWjNkMVl0d3JvSm9pRTNV?=
 =?utf-8?B?N282bW1pckp1NGExbXVlQU5PUE1IRkQ5dEpWSTh1bE52dVZPZ2N4dHl6T2FH?=
 =?utf-8?B?M1JQSGNTaTk0dzNHMVdLd1BMUHVDMXpsdjBQVzJ4ZkZpNkRKK2tPeDZTT3Vz?=
 =?utf-8?B?dkVJQjdqSllBVXFmeUp0SEFMNE1hSU9PR0c0S3pSdDQ3Q254azlHaTE0RFUz?=
 =?utf-8?B?TjduR1RwMlpWT3NadkhKeU53TkVJRldiS2NBdG5OM2hrMUM4L3pGR1R2Qm9H?=
 =?utf-8?B?aXRWV2ZkdHpyU3ltSjQrZzg2WnNxK0xpR005VEorT0d1dllFYkZDSlp3YUFw?=
 =?utf-8?B?QUs2bnZqZXVZUjBYTGNORURDcDhIMzBMeTRuZmVrU2VXWk5vUm5ONFJGQjEz?=
 =?utf-8?B?OWMxeFVkcmlmVHNwbXAzSzBUMisyd1NNcUY3Yi9Oc1Z0WmhyMjBmWGN0K3Vh?=
 =?utf-8?B?OHhIRkRFUW1QVUVoYkJUS2ZST2dEWVhvMGVnTEdWYXUrNlhmZFIrU25iSFZG?=
 =?utf-8?B?czRoS3BvbDRyTmd5RUFBRGplOGlpV1ZyWEdBZXI4bWYwWStXQmdCcHFuVXpS?=
 =?utf-8?B?R2RuVzQwVC91bnlNeVl6bE5zeHBPVEh5UE9oYWQwMTFrbFVZUlRmR29nQ25I?=
 =?utf-8?B?NzM4MzJMUEdKSXFLb2FSaUxpRW1EeWdOWlhnV3JleGhqMnVSUmJwSUtBLzVn?=
 =?utf-8?B?Q2QxUFo2dGpWTy9QZlZOeGZiWGh3SzdBMkk5Vy91blRFeWtxcy9BWTFLcitj?=
 =?utf-8?B?dWtDaEtpOUZ2OU1Dd1Bzb2NhY25hOTNVZWorSXR4VFdEMjhKWUNMaGhETFBD?=
 =?utf-8?B?OU8wUndCSFIwanZQd2NDQmpjVENLeklOcUtURW03Rys5UGxTUFZkeTFycE1l?=
 =?utf-8?B?aklVSEZRZlBPcWNnT0RjSU1aaStkMlczbnBDWm5oV08wQ3QwL1pKNEZTV3Ux?=
 =?utf-8?B?S2VIVktzdjhORjgvQ3d3OG10ZHg2WVdRVHRUbzZrdHlDWGlrY3ViY2Qrck5O?=
 =?utf-8?B?TlFRNE9odU9peVpWbUIyVFlxVnFYUCtRV1JQM1VEUE56NXdsRDhjTXkzbzcy?=
 =?utf-8?B?VVg0Ym9tTGg0b3h0K1BNeXVwSmNWRlJrY3lTN0JaTFZRRjBYblBQZG81RklJ?=
 =?utf-8?B?c004aHRZc1NyWSt4YTlMYmpHUTdlZi9NcFNzdm9TWVV1ZGlxME9EL1liTHMz?=
 =?utf-8?B?V1hhYVR5OXRzNC9GV000b3lHMXA1alpPWDZCcWlWQWo1cWJBSzhwa3QxRVZk?=
 =?utf-8?B?ZCtpcjJLYndwK2hZUko3dkd5NjNtUitGSXBRaUI3NDFiaGpyeTNoNXRlWXAr?=
 =?utf-8?B?Q1NycHNTOTk5UXZlUVI1aElxbFhIRjl3VFNtc1o4bDNVWVRNb3lXaXdlZFZF?=
 =?utf-8?Q?h6IKTkZhwCZaW?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b33caf0-c17f-4cd2-8738-08d95298250c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 13:52:46.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V90jNwqMB/u2LyPgsfB5GC+X06pmJcVK8k3kgnOB264NJXnEisPIO78fNWQ7zwZT/ihO0OUl8exkmLamcNi5oc7kHzQCT/xfFsIq2o5l8R4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4187
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 11:48, Fabian Stelzer wrote:
> On 29.07.21 01:04, Jonathan Tan wrote:
>>> to verify a ssh signature we first call ssh-keygen -Y find-principal to
>>> look up the signing principal by their public key from the
>>> allowedSignersFile. If the key is found then we do a verify. Otherwise
>>> we only validate the signature but can not verify the signers identity.
>>
>> Is this the same behavior as GPG signing in Git?
> 
> Not quite. GPG requires every signers public key to be in the keyring. 
> But even then, the "UNDEFINED" Trust level is enough to be valid for 
> commits (but not for merges).
> For SSH i did set the unknown keys to UNDEFINED as well and they will 
> show up as valid but not have a principal to identify them.
> This way a project can decide wether to accept unknown keys by setting 
> the gpg.mintrustlevel. So the default behaviour is different.
> The alternative would be to treat unknown keys always as invalid.
> 

I thought a bit more about this and my approach is indeed problematic 
especially when a repo has both gpg and ssh signatures. The trust level 
setting can then not behave differently for both.

My intention of still showing valid but unknown signatures in the log as 
ok (but unknown) was to encourage users to always sign their work even 
if they are not (yet) trusted in the allowedSignersFile.

I think the way forward should be to treat unknown singing keys as not 
verified like gpg does.

If a ssh key is verified and in the allowedSignersFile i would still set 
its trust level to "FULLY".
