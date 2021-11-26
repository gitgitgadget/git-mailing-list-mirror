Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75583C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 09:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376558AbhKZKA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 05:00:26 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:44103
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376643AbhKZJ6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 04:58:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPSFj15EtgiNcueHGRQ/LAil8ls51pbjhf6F/PT0JPB5fEvtRrc5QzGP0qAfh3ILWQ5/n4y0h2nf9cRs/f2qA6MR6AO2KsJg6QvNDIifuOYxhBileoTSr7JZL52Fgqh6/E9jH3zbe8sxyKeTmWzXWxh/79fmxvdN/73VcOp/hHXGHBIUUzVNaz3jOUXn1g3IsjkwVEQARGa1g/2JBht3fvbQSWpHPJ5qmQwWtaSfQKHcssNu9/nI0XiGxyrcAHUP7mCsiMnSO8wCk43LFLBTxf38JtVsuiX49Jpal6RwPmwThl+QUe0wNx+m+Zju3Xnh30kH7XInxU5Z99G9KQnlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qel8vxW8SPkiNfKUdIs25Ge043uhjG3AuLl3zS9to5A=;
 b=SI1gzdoX/f7JhJB+N+cCSBM0RSC+nPY6U3N0zkuEfbE1bwXjsiF+nacFjP2+PYgB/sp/nR4TjWsk9pL1OK045JxCjIIoqN1oAQ8wBHQBmXkT7i8UjZez+0f+p5DkQ67FFts/uE8I9Us4H6JyX5zMaU3z/aHSBeGpCmolLkeIelldazL+SFYWAakjc5ovGIANyWdNO+fUUMai77kVpTPLAaMzHK0OKOo8PnS0xJ6yrmzQ18EEWiXm3d3i7bqKXGpMLla7yXBRzwl+L0+atItwUxbPefAWetushb5mmY/xFzAmiaTd9Tn9jw+K+Jo1S43hUipa1Rnn5OEP28WXnJ3f0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qel8vxW8SPkiNfKUdIs25Ge043uhjG3AuLl3zS9to5A=;
 b=umJUnGuG3gLNx83bpZMmC2bGdA/itnWk2sjyLfiu0nmPXE5BOjuucNGldSaE42eUa9Tq/IPeG8VwkX01zSEZfCxGPvPIrj4pa0GNb3VDUO6h8xaX+nsJ5S5Asp68N31fUx7Hkr/JvdS9CkW7CFgteMwMSYj8BDcu+wLE9M6DCCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4112.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 26 Nov
 2021 09:55:11 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%6]) with mapi id 15.20.4734.021; Fri, 26 Nov 2021
 09:55:11 +0000
Date:   Fri, 26 Nov 2021 10:55:09 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] test-lib: make BAIL_OUT() work in tests and prereq
Message-ID: <20211126095509.weeknmg4p6sx7bdn@fs>
References: <20211117090410.8013-3-fs@gigacodes.de>
 <20211120150401.254408-1-fs@gigacodes.de>
 <20211120150401.254408-4-fs@gigacodes.de>
 <211122.86y25gz9q7.gmgdl@evledraar.gmail.com>
 <xmqqh7c4i0jh.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh7c4i0jh.fsf@gitster.g>
X-ClientProxiedBy: AS8PR04CA0178.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::33) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AS8PR04CA0178.eurprd04.prod.outlook.com (2603:10a6:20b:331::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Fri, 26 Nov 2021 09:55:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aca5f44-6a50-424b-3ad9-08d9b0c2d5f1
X-MS-TrafficTypeDiagnostic: PR3PR10MB4112:
X-Microsoft-Antispam-PRVS: <PR3PR10MB411232B82F4045A10A28C5FAB6639@PR3PR10MB4112.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijYIcHZYSxauMZ0g+UWJ5ngxTmt9gXS1sDfJoqvJVeMIOyOw4SLJkv8acE02yNrTww2AP8EKujj+ScjpJVhELuyE4eOR17fgA+d+R/Fylq7QO0BrpPuzTyvKYmzy7pq8ILNNXnq1bMgEhr5lN2giEL1l6TOI0YdDJrvJ1cLgrOFcuO92735MvE7cnAd9geMpShcftYW5gc5O2QDxJzHge8GtjFGvkXK59V+FtzaceLWxC56QqtQeF/nWRTmH2jmGpqHqRf5NS3yorgbllwKdsmi8VcDk9G4P0s/yK84I9TyeHobUWVQon0b+IjAHJQkmwWuwEXgiyI5aocIwZoWOwzUIR5neKyWPbcFlHHY/2C8YldxmmWbPvYlK4uyA0Z6Ix3f3vLQXT7/9Hnbh1j+sl8aXTn6nyFfv0yrGKY3YEWU/bFnQNOVSYU8DGPcYgvwBItAg2Ar8D8/kyJtztMnBDA9ZGNjMY4p1M5H7GHbMPYktymDz8k5MHlIr5mXl1JB/Qy6ubYvdBm4iAW5XUUj8Mq5+kQ9GL13QjodBNncseihEUSqgiyXT9UkpJCrH8PXYBmLVJkpiaXA8fr7KjaTujDwTjJi5HBC+E4kN584y3DABn5xzIq0AcpgeRBMMGoZdpVKWp8sSYFJi/8FUZdw9WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(396003)(39840400004)(366004)(136003)(346002)(2906002)(38100700002)(8936002)(5660300002)(83380400001)(54906003)(52116002)(9686003)(6496006)(1076003)(4326008)(186003)(66556008)(33716001)(66946007)(86362001)(6486002)(8676002)(6916009)(316002)(53546011)(66476007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRhQkpvWStNQlQvMUk5cHhnNG9jYWN5Rjg0MEprSERBc3AvV0Yvd29wU2M3?=
 =?utf-8?B?SEw1eURQWWV5YXhZOGFHMlRKZTdhRldYY0xuTWJYRGtIV0VEeGI4UkpWdFYr?=
 =?utf-8?B?RE9uNU1BcmpEdm9TRm9jdlVvQ3F3WVBVMDg4TWtmaVNXOSszL1MzU2xHK2Nn?=
 =?utf-8?B?eGhkVW5BeWZGWVBzN2c4dmtESGl2ejJmeFQxRHpTblptWDRPL0hUREcxaTEx?=
 =?utf-8?B?S2ZSLzVsQ05qYW9yRWh3MWxWZkNEek85ZTBKK01hdlNZSXZUeG5vTlZER2VP?=
 =?utf-8?B?WHNibzJKK2xVM1ZxSGNhMlp1cG96RXYxUGVxWVFFOHlyS0QwSFBxU09yWlUx?=
 =?utf-8?B?S3Mrc3pVeE9YeTN5dXMrRjA5Z3hqdDdLb0VRYm12eFY4T3VKVWJKZHJVTzA5?=
 =?utf-8?B?bEhDVEZpY1YyS2pTdXRuMURhQjluVXU4alpaVUc4aTdYaVdLUEpSWkIrRjdY?=
 =?utf-8?B?eHBJSUc4dHFXbmxoVksxdGpxTnhYOWhoQ2NHYzNsVDNMUUJpNVc4ZENPcFJW?=
 =?utf-8?B?aW16U0NxSlRjTHA5WHZIUjBobGlwNk5IZkFkRDhQMzdOenRQTTZiQWJMdHRo?=
 =?utf-8?B?UUtLV096Y3NtRUVVYnpBN2RvdERuR3JCMjdNNW1NV0NlRHhFOWRyaldFYVpX?=
 =?utf-8?B?eUhCTjk5dmRGWFFzenJpWFlhTWFtVUF6T1lITEMrRTRsK2JaSWpkbkVoekZ5?=
 =?utf-8?B?SnZuNzc5dFI1MTZ3anZjUDVxaXNSSjF3L2tqQ2NDMDJFQnlueWhpVGduQUo5?=
 =?utf-8?B?VkVyQTlLVUQ2UHZWNG1NT2wvdko0eEc0V1FSZklTSFJHdHoxUkp2V3hYUy9E?=
 =?utf-8?B?R094ekRXV3B1UkJkbmJscFVKSDA0S0RmcldZdXZNb3ZDM1o1NUNpeFFWTSsy?=
 =?utf-8?B?R1VnRSt2RG5WdmVoUVJyeVd1bTRWd3dpUTl6d2lLZUZCNjIwL1VDTy8vZWMr?=
 =?utf-8?B?cGFacmFoWTNRQXp3c29lNTl6Zjk3ekNLRy93UG44VENUTTVWcVNFc0o0emV5?=
 =?utf-8?B?WHJwVHhLS1BhclM4dUVYR2kyeDNyeUdKMG00UEZMRnM1a3lLeVBjMVFjb2Y0?=
 =?utf-8?B?WVpkYnN6RktLYlVLUHdwQSttd3kza2JjZzAxZTRSVUFWUlZmYVNaTU91clZL?=
 =?utf-8?B?bllvbjBtaDFOaWlBN3VRU1JWenFXNTQwa2hSazVVbzZWMEc2M2FxcThUcnlU?=
 =?utf-8?B?dnlmM1lYQXF5SlovUUlRUC9oNmtnbVNWL3A2TFhlekZ1NUx2YnZVMTNoZ0pP?=
 =?utf-8?B?T0ZIWEpHU2NHL3drYUh5ZUlsQ2d2czdIK1AzSG44VExCL2Z6SVluRUpxMEVS?=
 =?utf-8?B?cC9OYzRsUklzMEc5cXB3cnRjVUxaREtkb1laM2hvOW5zUnhUclI1S2RjYnFH?=
 =?utf-8?B?WTd2SnZwaWJEV2xHQkNaWDhwVW1UVnV6VVg4YWRXRk4wZGpncnpKbjlhZEVi?=
 =?utf-8?B?MXQ1RFRBczhwbG5aQ29TN29qdFZqV1ArWG9BclpxMXd0U0xLK1JKcUlpK1FG?=
 =?utf-8?B?cGRuUkg1THplRG1RbjYwSnZPK2NldDdxMXcyVVc2MUhWZlNkS0pycDA0U1pU?=
 =?utf-8?B?SjhDaTJkMlZQbUl2RENHWXJPdDU1dS8yeXJtWFgyTHdycU4xQnBWdEVWT1pl?=
 =?utf-8?B?aEFZdEI3YlM2VUEyYnZSaHdKRU9tY1VwZzNVZk1FQWx2WHZwMVk0MVNQYjNY?=
 =?utf-8?B?dlJEeHZ1b2ZqeG82ZU80dHdDbXZVK0ZJY0o1RHozemI2QjBxZVpwZ2VFUE1p?=
 =?utf-8?B?TGJ4SjJhT1I0LzJ2Sk5naGREVmg5clBkOE95RHI1SThrY28vZ3FGVlduVjM0?=
 =?utf-8?B?bUVsSUtrZEdaSXR0aXlNdXVkZklYQUJWT0dvQVRYM1NRL2dNVHh3b1pNZE9k?=
 =?utf-8?B?U0ZKSG5ydzlCQnd6QThCWWV0VFZ3U0E1TnJudmhVbm00YStpemg5a29WUjJE?=
 =?utf-8?B?MjJqY0xrNXlNUTZUSHYzRkRxc2tCdDgwWUVKMTRxcnFleDRaQkFkaVV6NFJa?=
 =?utf-8?B?UHR2S2dieVpqTDlWNHlFTi95QTlKWnhndW1vc1IwK0ViSDRLYlJJWFhKSnZv?=
 =?utf-8?B?alp4UjFRbmVYeStWZU1ZRnlhK2lydythbUJ4MkRLZDhtV3A4bVp6ZXpEbTFB?=
 =?utf-8?B?U3JFdXpKaHVtanBYRHYzRDVwMWpUY2xwWDZrekU1TWZBQVZoUlFWdTZOVDBZ?=
 =?utf-8?B?elRpYWw4TjhuRE5kamNUbE5kc2JuZDFLVjZKUHdUMlM2Ky9Dc1Z5eEdGck9o?=
 =?utf-8?B?QnhyNlgxeVkvQXgrN0ZITFRZdnUxdjdoV2xBZlJFOXJJNWh2emdkeUZVTWoz?=
 =?utf-8?B?RmVsSWlaUWhVZGJUTkxtZjBHUDAvRUZraXVDOFk4Z1N1UVBtNmxzUT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aca5f44-6a50-424b-3ad9-08d9b0c2d5f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 09:55:11.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOSxGoZdNcdpxfD5j1FN+i6tih9Lkip9XDCTrmqn3l6ZktD2+IwE5D2N6jBZ/sS4Myfw3gItZeRc2+uJUQflDpOYSkPmcjOAjecqdu8zNhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4112
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.11.2021 09:05, Junio C Hamano wrote:
>Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> -exec 5>&1
>>> -exec 6<&0
>>> -exec 7>&2
>>
>> This doesn't break (I think) with your change here because you only
>> manipulate >&5, but I think the post-image would be lot clearer if...
>>
>>>  if test "$verbose_log" = "t"
>>>  then
>>>  	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
>>
>> ...this bit of code were moved up along with the "exec". They're
>> currently intentionally snuggled together as we conditionally set the
>> 3rd and 4th fd depending on verbose/tee settings right after the setup
>> of 5/6/7, keeping them grouped in the post-image makes more sense than
>> splitting them up here.
>
>I actually have to wonder if the handling of 3 and 4 should be moved
>down, not up like you suggest, so that they are grouped together
>with the maybe_teardown_verbose and the maybe_setup_verbose helper
>functions.  The lines we see here are the file descriptors that are
>always redirected, which is a bit different.  Raising all of them up
>to group them together is also fine.

Since there is lots of other things happening in between i'd rather
leave 3 & 4 where they are for now. I'm having a hard time grasping what
test-lib.sh does when / where since there is lots of intermingled
function definition / executed code. It could probably benefit from a
new include to move functions to (and wrap some code into new ones). At
the moment i'm a bit swamped with other work though :/

>
>In any case, the comment in front of the block of exec wants to
>become a bit more detailed than just "# Set up additional fds", with
>an explanation about which FD is used for what.
>

How about:

# Set up additional fds to allow i/o with the surrounding test
# harness when redirecting individual test i/o in test_eval_
# fd 5 -> stdout
# fd 6 <- stdin
# fd 7 -> stderr

exec 5>&1
exec 6<&0
exec 7>&2
