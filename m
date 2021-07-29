Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F766C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 07:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1C561057
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 07:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhG2Ho6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 03:44:58 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:49870
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234524AbhG2Ho5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 03:44:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYVafunV7GJrO259SmqunzmetX1rZiRs4cfaAZQBSzaowNreVptv3ffnPuXKlYx2CJ4ElhS0lbB3g6V1z2iZRUcF9abnW3uvX6uddebRrlS3GihamUeY5y5ArVexLvnU+RyltrxEUtUHWVzPSuDGCaJXLQhRdeSRozrSmFRbdKZTd5mzOTrPxrjC69baKsOkN5/TiRp64tMGUwXqmX++ooGitNjImW5S3wEG+oVSmpPsALj+k3P12tE21W5WqinjR3gmyoW/iIT/iq9JrdifFAH1fpYGSRxMYyvKmJsLAcAUpL6GFeJvoAuLPQHf/JEFuWlNp9TEZ3Pty1DF7Im6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zuwbm+bwqmHDvmZbE8D1j/t5tMhj8s/hJTcLOqfX86Y=;
 b=XlW1w9FAL6+s2TkUFym5SyKKnezN/DQtVn51kPXnBjBsxVt1zjzHoHe5q2JP8Tg2cttKEbIZotTqoGgJu3M7I6Dap44Ta57ukZX7Ld0eaF1DvrTr6KOVjuKI3sz8/+SjaHR9MGU9zKxe4zOvRCK8/74SDt7TKshupZDmGidRE1PGEUdwiQu0ZF46ocSjH9Q/0PZueXhQvLA0WFWY2KsCEbqpOaKteEUr+TruP+xV7J/myVmK/Cn1VPEIJKSdVxn6amJhFI5RUnOKnsQyarRidJNHvKTBBFnTg1sJAil79+yTeGPLqYWC6bPJVIEJQ+1SXWguPZVKFG7bEXSKlTjcjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zuwbm+bwqmHDvmZbE8D1j/t5tMhj8s/hJTcLOqfX86Y=;
 b=CezisADGGqqNeqALnIRxn38Bj+m3AqLxzXSElkaWZ80CCZ9cipeWA+hto2t5pIeFZD21zMJZ7KEccpMlBJEMNMAMtYS1JY8KBUvHqFaI/G/IWdnwQ4gDpkBZgOzA0om/GMxOmYJsspTISHdBygGKunMG3SJMAlghBkpl+7UiutI=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
 by DB9PR10MB4489.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Thu, 29 Jul
 2021 07:44:53 +0000
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178]) by DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178%5]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 07:44:53 +0000
Subject: Re: [PATCH v6 1/9] ssh signing: preliminary refactoring and clean-up
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
References: <7c8502c65b833e7e563a833b592f6932421b1056.1627501009.git.gitgitgadget@gmail.com>
 <20210728223206.2715554-1-jonathantanmy@google.com>
 <xmqqlf5q6ils.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <6a831f56-3072-be97-8a24-023f034f597b@gigacodes.de>
Date:   Thu, 29 Jul 2021 09:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqlf5q6ils.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:259::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.9 via Frontend Transport; Thu, 29 Jul 2021 07:44:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9513dd2d-11d2-4010-50ba-08d95264c057
X-MS-TrafficTypeDiagnostic: DB9PR10MB4489:
X-Microsoft-Antispam-PRVS: <DB9PR10MB4489F6A111CEA91B2015B731B6EB9@DB9PR10MB4489.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQ7HSTdIKN+kvSu3D6uUUGThiJ9J5LHaYlBjRJjUvWhCtNGM5srGcVn8taxOSoAMt7onA4FXH6v6dc92m21nl6jP6GiwnmsRLtOsF3Nru/defvFbTbYFxzoanWQQV/oDS62RjHxg3wjtElhINP4h5lP+ZOk/DgYLmCuM4RpLaXsBl67pk5yqi78W8d7qAGV5pzoTlB03gmR1Z3LFIkvbLsrhDcRVukcYYpgQ7ipFnvKKZ1rtooFCrg4+HOcjD7W2IZeDGl+YEddjeVIXqPnZY/5LMM8TwImm0WFufiZhRt2vce8siTEBhoz8Gp9Uhvcg+gZBhajzMnQZ/sShiFr0fqTjz0hDJdW5pOg8WJ4G7K8SD3d6a69BTCG1NdDcBrZ8Wuy+y8nueazcIvQw793RRz5+iOKIxewK9h5+IaAcfms7Dkknk2WZ9CPsgxWJ25TNkPKL/u4yOFcJDdBz9sjxio8abfCi0fTsDmm168vf42AhTAi/+JKHmc5t+776b3HJtubF+EgnD3Zvk97X5+Hk5nqmp9bHDGVYPhH/Tna5mRmfmA4pIy+BVlBGoxn4YHKAkcA/jBYsfxeN95hvSp7JqnQNwOP5wXj7kcqPnv0Kj8UBJgsNCbRLQu0TvDXrcCFpmYBKKnh8mKrfs9/7KxmWzTReO0XpuTU8wUW2oIfK9E02Ae2uAUxwyZ1VBMsHnD5clGACVp/eTqfsLyrXKjSHkNiJwKdOGEisnoHYE/oSkLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(136003)(396003)(376002)(366004)(346002)(2906002)(7416002)(52116002)(6486002)(8936002)(5660300002)(478600001)(8676002)(83380400001)(53546011)(38100700002)(86362001)(66946007)(316002)(110136005)(36756003)(66556008)(6666004)(66476007)(186003)(4326008)(31696002)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2RqaWhreUZIeS84RDRTdEh3dURhTWRJd2dJZ21ZODVNQjhEMmt6dXdCNFpN?=
 =?utf-8?B?a2lXZ2owNkdRdXhkUnlxNllHM1lPdXZlS0t1NCtLQ3JFU1QwQnptMFo3MUxx?=
 =?utf-8?B?Ti9zZ0ROanJDUHVXSjF0OFJFSVViblNaeWlXNkcyVWlQVlhDR21oRklROGw5?=
 =?utf-8?B?NGRadXdJYVJkbjRGU2VUVTZnSWI3WWJYNFpDK3Rqekg3bmRPN1ZzMm9VK2dr?=
 =?utf-8?B?WEdISzNkckdkQVdVWWJuVExhdkdNeVVpV3lMOVFrbnpFdFM3TmJTZ3lMd2Zi?=
 =?utf-8?B?UEdQSElZWE1WMnpFbEFrZm1UQ3lGS0NLTEtnZTRNak9Mb1MxQ041QnYva29n?=
 =?utf-8?B?ZURMeGlmbVcxQVRZS3Y3cmJ5ZkhlMnVqeUc1YlM4cUptWVNQR3hpeHF6R3ZN?=
 =?utf-8?B?MVlKQk1JbHhkYXkwb3BzNGdjK0FDa1VuVkRabGYrOWZ3b08wTHZIN3MzTlVa?=
 =?utf-8?B?ZEl0QkdwTEV4cHE1TkpTRk8yc3pnYWllRkxGM203SDZ5Uk1aMmkyUzFYTXg3?=
 =?utf-8?B?ZlVsZTNYVFhVTDh4dDVyK20xakFWTFVJWnNkT3dLNk9wLzJ2UUxEWkIvUlFx?=
 =?utf-8?B?NE96TFp1bHpFS0swQmxQVzZQN25McFAvUXgyam9vR2M3a3RqMUQ4c3g0UUFy?=
 =?utf-8?B?eEMzbVU2bE9TZ3Zqei95eWpmRzNJOTFWZHlVSzJaNElWVytFQU9oRXMwWVhu?=
 =?utf-8?B?Y0Y3MkE3SUYzTExoelNDYUZ5dE9QN3dFUHIwNUFmZ3oxSUw1cktSdkRUTEZE?=
 =?utf-8?B?S3pXdGVScWtUQVFlUmxXcVhiMk5QT3NkQmJ3bGE1NWtVRHFoNkJMSzU5YUhL?=
 =?utf-8?B?amQ3Z0Y3Mzc0VCtMWjRlRXk3OXNoZ2l1VVpCRmtHcGpoTTNSM2xoTmhQWWRP?=
 =?utf-8?B?VksrTWZkc1pEeXJrTG1hRHVQZTBNV212RzgzMk5ZN2NFUVRKVFFHQlp4RGNK?=
 =?utf-8?B?ZHRqWEZmcnI2TVNyUmFjRnNJRTFPY0FsSnVGZ3BFbnMrdTEybVg2QkZvb1VB?=
 =?utf-8?B?MDR3WUJwRVUwY3Q4UitLdGVPVlpndDVHR1VMcmdSbEFQc0ZLRkU2U252UUxH?=
 =?utf-8?B?bkRXdjF0aU5Xb3J0SXNPaHJhTWNyY0IzdGducGZkWHdab2wzZ1VVbDVHVDdu?=
 =?utf-8?B?bWZHWEhYL1o1MVp1Tjl4U2pCdkNGQ3VyYzZPRHFKMy8yWlNQN0tKckVSTXN6?=
 =?utf-8?B?dUlKejBaR3d2eUp2eTlYUHVnd001aGw5WVdoK21QUkh0dVg0b1FiL1llVVIv?=
 =?utf-8?B?UlhMbDZURlZUZzRESThUYml3VXdaWEt3S0NaOUh2VjJ5UXlxWjhxVVJJQWkr?=
 =?utf-8?B?K1ZjbCtOdXcveDg3ZmJPVTB2YXJDaklFK1Y4eEVjL0ZaUWdYSTZpMVRmeGZx?=
 =?utf-8?B?N2pnZ0JOcjFUaGFhcGdnVGI1dmJmRUFXSXNjRDBON1lpYzQySDlQU01tYVk5?=
 =?utf-8?B?L3JjWlh4SE51clJPQW9NdEdwNXRVUzl5ZDk4c0xQSkt5SlYyZnQvMHFXOE93?=
 =?utf-8?B?TVkrSUxjWTRpTEJ1Z0JNbU5CdGZHQ2FaajZKQ2U3Mkxla1l4MzR3d1FKSS8z?=
 =?utf-8?B?bDMxdmkzbXBCU0lwN3FzbWFSTk00VXBvRGwySjNqb1FpeEJHeVpGNFNOUEF4?=
 =?utf-8?B?Y0lTcm9QWGJVNlhKMklhQTRyK1lmaWxBR1RoOG1ZUzlkQ3cvelhSMHZPZlha?=
 =?utf-8?B?V1V1YUlVYXE2d1FzZW1wZEhoZVlhN2dSdENleGZXRWtsQUUweFEwaEgwRG50?=
 =?utf-8?B?L2Z3YWhRT2t5WnZKZFRMcUVXUmo5SlM2djQ2bmNWSXppTHB5OHdnYk5FdWtH?=
 =?utf-8?B?Y010dE42cUkwUEJuQ3BGSzNyYmE5akFKdUNKenROZU41L1M3VUFoSFhUOVFx?=
 =?utf-8?Q?aZT7dNF/Ao9oA?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9513dd2d-11d2-4010-50ba-08d95264c057
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 07:44:52.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbzEznfhpboVOB/X1K8vPYWiGT8mVPZkg1RUhR5T30bTcEe6xms0ixGnSz4C51UqShExbN3vyY/Jts22PeBKnv8nNQlHB9ejXo3G4JxIoPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4489
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 02:58, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>>> -	fmt = get_format_by_sig(signature);
>>> -	if (!fmt)
>>> -		BUG("bad signature '%s'", signature);
>>
>> Here is the difference in functionality that I spotted. Here, lack of
>> fmt is fatal...
>>
>>> +	fmt = get_format_by_sig(signature);
>>> +	if (!fmt)
>>> +		return error(_("bad/incompatible signature '%s'"), signature);
>>
>> ...but here it is not.
> 
> While I was reviewing this step, I was assumign that the callers
> would respond to this error return appropriately.  If it is not the
> case, then we do have to fix that.
> 
> The original's use of BUG() is wrong in any case, I woud think.  The
> "signature" there is an external input, so we were reporting a data
> error (it should have been die()), not a program logic error.
> 
> Thanks.
> 

My intention was to actually change this behavior (i should have made 
that clear in the commit message). When the current git version 
encounters an unknown signature format it will BUG() and leave the user 
with a coredump.
I assume that some repos will have multiple different signature formats 
in their history in the future and the effect i would have liked was to 
only mark the commits with unknown signatures as bad/unknown when using 
git log --show-signature for example.
I have checked all the calls to check_signature and unfortunately the 
result check is really inconsistent. Some ignore it completely, others 
check but still then dereference fields from the sigcheck struct.
So for now a die() is probably the correct way to go.

In the future we might want to differentiate between verifying a single 
commit (in which case we can die()) and a list of commits. Or fix all 
the calls to check_signature to check the return code.

Thanks
