Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651D9C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 12:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400AD61212
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 12:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhKEMQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 08:16:06 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:35528
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhKEMQF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 08:16:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss271qDedo2hsCkhGvj/fCvanCDO7Z4JSndMRVFcLoNqZFl46t2kiOuSaFAiZP1N9BfVr9i6fxLKNI9vzWmAECSJGbnlc1hjG9cQbMHpE7g9ftava1XQCn7AAwHnVZ4/6sLDpHcgpbyI8kQJot6b+8AcJt5n5a3W/nWlnNl98qv+ZnRSK8/aKrprpRhxsgLnXzd5kPgqvGIvsj6mmpBXACnPxbGGROIB+vbL0upRvJl6kJfzmrljxZfXkLxyqbQs6SGMjeaqk1le1Jpv74JX9/pXCCHtZa/ncjPWj8dm6M6A3NJJUacp/0fK+JgAd5no0IjHZq08FdcuLdeuvqNxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW1m2NWbFc1Mctp7csoj2MoeMdBy9SAh7UiRlVIggCc=;
 b=FXUC3XfjFInpzW4vrEkNjquax4g3SA10GoWIM5dV2G3Qv7LJ9qlOZ0sSDxy1CyPUbzY57aY0qqPSNgSylMD4MTFLkzZQ0j1bxDwpp8j1NbdP2t0H+jicJw8sEno7n8A9czAbYvixwiTGpk/PAJO3WdhEqm+P8+bdPjyj+p9fQVjGTwi8JPWuuCRd3LvdIXzWnGCPzu3OQQsnAlJrKAABhSj1kmumd33Acik0lqN7i/LbnFrX9lOswKD/Vw9gYjQXlKjWOAs+QSCukFI1/A+y3KmYRJPpzrlA3KAoj/Rg8W3PvdgwPzxWH3IXXuPstJ6Qdvv2vG9rR9c7gLtRr8swlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW1m2NWbFc1Mctp7csoj2MoeMdBy9SAh7UiRlVIggCc=;
 b=KUMlyQx8fgi019pob6a+qtDycMrujwJ8nQfTjFS8ky2ZV5J+WbO6wSTAxt+aFv3PSh88yBYn+iPRsJZ0dBGwuVeOpRnTcMZCN9i8n4WKD4BL3UsiM6j3aldzsMB5hweRrlHBfJQwqdIgakXlswmx4qd4jp4HkD8GKAzobj/lguk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4446.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 12:13:24 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 12:13:24 +0000
Date:   Fri, 5 Nov 2021 13:13:23 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Jeff King <peff@peff.net>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
Message-ID: <20211105121323.6fbyxoibaeyeshtw@fs>
References: <20211104192533.2520-1-adam@dinwoodie.org>
 <xmqq7ddn3dlt.fsf@gitster.g>
 <20211105112525.GA25887@dinwoodie.org>
 <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
X-ClientProxiedBy: AS9PR05CA0055.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::6) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR05CA0055.eurprd05.prod.outlook.com (2603:10a6:20b:489::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 12:13:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17c70c33-339a-4228-2052-08d9a055aa55
X-MS-TrafficTypeDiagnostic: PA4PR10MB4446:
X-Microsoft-Antispam-PRVS: <PA4PR10MB44463A24EAE71E4697A2707EB68E9@PA4PR10MB4446.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iheAcf2+0a1BkNVpCriw8xmoHWk9l6Q1ajzn9aWNM9+yhJxWHLUj7sURjDuVovPqUhquc32BorWdMIpNJUjd+HbAubs7ZtRnef5CC8jqQgZWb0O7fAsgIWptMh6AZGj0Et7on47ItDBZkHcYPndQVUcm6l5tFIxCoW9sevyocJXp3ggzpeaaLjLuPeF3qcTSZdYNQQC6NJxtkayuMkQ+ntE6EXNZSheMf7VZD9qrSqifrq3kiLA5k/+77A658B0wtp5NU8TS1sRAIh572B4kzWoB9OjQaDg/FHbADRLu+FJ7WSUALcbnU9JWofbA9lmMuPAw2udjtXg6+SekDdA1qndSPTc1Azro6igF3d3yXwO5Lcs/HaQDX2mj73WUJq2jTs/Fz1cjB522tCe6o2Jj6dEGUHDRBvGp1GFlyCwK8QtJlK25HOiuXSGPorxhpL0Z3BfmLFDlvJoBNQsoWFg7bz2JmhAntclXUYuB69vyZzblAHYW+oGwlRbOMe1OiBlBR7FJgxYRg9C8463/pYJQiNeJyOlnpacUZTbddvheedIZZ58tOguzGI4aPgVbK5RMfsNeutjM1bOv7FxbGS8EanZeaqwwEKrAh7Il+QPtH1WZcZ1RAT6QIlqIXZ7amKFStveMHemnKJSxaSLiVdVsDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(366004)(376002)(396003)(346002)(39840400004)(66946007)(86362001)(186003)(9686003)(66556008)(66476007)(8936002)(1076003)(5660300002)(2906002)(4326008)(33716001)(6916009)(6486002)(53546011)(6496006)(38100700002)(316002)(8676002)(508600001)(54906003)(83380400001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFFjbHdxNExOYkpvaVhFYzJjcXJ4eFlrQUgwT2x4WGhVQVkxVERHbURDL1Jj?=
 =?utf-8?B?YjhqYzhrMDZ4dncyc09mVU1MMXpGbUYvRXhtMkFpK1hMalJtUUhEV1ZuT09L?=
 =?utf-8?B?UHd4U1luelJTWjIrTTJRbVFRQzQ5dW9Wdi9pTHBSRUlncnBhVUMwM0JuZWVY?=
 =?utf-8?B?K0pJL1pRbXdSaVp2ckpsU3VrMzdBeGV1YS9WRzJVNXJzYWlLSjN3OGs5aG8v?=
 =?utf-8?B?eHNlNm11YmcrVmIvVlJjeWdvVDhMSEdzV0IvMUtVSEhJbUUwaVhMY21PUkI0?=
 =?utf-8?B?RHNXRjRsWjFIZk9KL20vWlAyd0lyc3hyOStYdVUzM3E4RDMwY2lqSlVvMnpi?=
 =?utf-8?B?OHc2alhkRGhKT2lRUHdqQjg0MURFb3F5d1FURGxmaXMxck56eTkwNU8relA4?=
 =?utf-8?B?V0NjdnNkTmtWZXd2b2t4SzNxbmRjVDdIQ3JqSUVwbG1pVWREb3NTWDFUYjVi?=
 =?utf-8?B?M0NCZHM3YngyVmdNTUJ2T2liamowOGkrZ2t5MjZKa0QyV0RycXRLVTNNYjVV?=
 =?utf-8?B?MXMyQ0ZGSVlOZ25XT21MSFRZTHdLbmN6TGVTLzF5VjlYQndlT1FSUHNpTHRK?=
 =?utf-8?B?eHBrZnlnSEdpaTYyOFZiVkpJRS9ySk1yLytqMXFHb0ZyUDJCaCtienZxNUVC?=
 =?utf-8?B?YW5rZ04vUzV4TXY3d3NBUXFHWEdqL1V6Slh6VFZadnVvSXRST1BpZGUxU2pM?=
 =?utf-8?B?ZkJxSjB4azBjR1E0SjhKRzdMTEFhcFpmbEFVUTFNeU1CSUpqUDBxcmFnTXVK?=
 =?utf-8?B?cjBtUGdscHhTdGhHNHNMYlNRTmlUWHlNTWRLWkFpelFZMm10SW9lTk81azI1?=
 =?utf-8?B?c3N2RzNPMWFBQWxrRWFzWUoyTmVSTUgxd1k4U2N5L2g5V01jMjFvdkNBbzdv?=
 =?utf-8?B?QXRjWllHQXpZak5yYWZ5c1ZGbHp5SDBVRWJma3JHaHM5QzltUzBIYVVJMXVl?=
 =?utf-8?B?eFRRbDhYQ2pQOUpaM0pMZm10UEJpMFBpS0lFaDY2cWtoVWErU211YlJFa1J4?=
 =?utf-8?B?NkNJMmU2aUVBVERuYXZsaEd3ZUZjdnhlbWNuZ21KVThMTlB3bGpkZWRyTFR4?=
 =?utf-8?B?Zm80YXNhdFozeWlDUi9sWUFWSFpRTE9GUUpTbWRTZk1SL012Y1dCb1YweDRV?=
 =?utf-8?B?OW41Ynh6d1lCR1VGb1lxNmk2ZFJxaDBSZ2dvb2kyRGJBbWFGRTRMSXFNTjlx?=
 =?utf-8?B?QTVOaHVsdUwrc25qOU51b0h1eWExQVJ4VDI0QTlOcnFzbDJkMXVDa2RQUnJH?=
 =?utf-8?B?aDJwZkpldWNtYWQ5U0pKd2tOeXVublc5WU1GdmVLOUpHaDR2S3ZFOEpVVksz?=
 =?utf-8?B?U2drTHJTbDcxdjJjaldESU1VNEREblVLT2UwT0MxVGo1dzJGTEl4QTF1Rzk2?=
 =?utf-8?B?OW4xa1FwRmdjcUQraUtjc2ZXMFVOeGE4VndaNzJoMmxtdmRjdXI0bkZPbFNB?=
 =?utf-8?B?T1FaRUZNL1EvU2d6ZGlja1BWYStVemkwWmU1UnVnU1FLWWtiRWJlVTEvZ3o4?=
 =?utf-8?B?Q1VIWm9UNEw2d3RlbzlRRlVoWEVQblZTS0RQelowSERrcU9Lc1lwS2dOTjdk?=
 =?utf-8?B?UXVyYXFhcGpaRE94b1JMUWlJby9vWDhZTStOTURRQlJDRHQ1aERiUlllREYy?=
 =?utf-8?B?WkQyUldVRVQ1QzhWaVlyQ1VIUTJHL3czOTE5S2JkVFBkWFRHaFZwU3MyU1NI?=
 =?utf-8?B?bzYrWDFLRlptYXlMb0xnQTJ3dE1raHVjaVJxbW1nNDF5L0dSa2xlWmVSRGkx?=
 =?utf-8?B?cEMwTFNhZnRyZHVVTG5XY2VKNTloSVVKcCtxeGVpTmlvZkJMK2JCeStNQVBK?=
 =?utf-8?B?VHJTTXh6YlJ5bVRxeGVPdXlTdHY2a01YbjJtOTdRUGRsYWJDa2ZMS0dORHZK?=
 =?utf-8?B?aFJCNHoxZElMbnZRbG5aL1l6TjkvQlBXc0VlcDd1MjkyMjZ5YXFvNkNzREpx?=
 =?utf-8?B?eHViOXI2ZFlvMTBVeXZnb3NBNHlqYWRUYXB0TkFUaldsWE1SYkl5OE1uOS9K?=
 =?utf-8?B?S1pIVUVBcHdMYUtyVWpwcGhIY2ZlTnh1VnEza0NkQVBzczVtM0doN29uN2ox?=
 =?utf-8?B?ZEFFa2ZsV21abzd2NjQ3TWtFdWR1RFFraWRTUjdsRHMxdWRmS2kyZEo2OTV2?=
 =?utf-8?B?OG9DM2ZuZkN4bGExOElieDdvTTY4Y29welFvYitvUVRUUXNnYmtyaDlZdWE2?=
 =?utf-8?B?bEczREZYYS9xSUFQeHQyYzgwUXcwcnZ4S0xDbGFic2tsYTc0OTMvdlRBVlgy?=
 =?utf-8?B?Y2Q2QUpyemtmMWpCaUYyZUxlQWlaK24rNlRLUllZV1dRRnZyTTdNdHltUW5M?=
 =?utf-8?B?MkRjV1JGc0RiQmxBWVRGY0gwbTQ3bTJzK1VDSHpMbE9pUXhsT3lTZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c70c33-339a-4228-2052-08d9a055aa55
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 12:13:24.0981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mONzkaGLLrC5DjGP29zhsGaXuxAZzNXb1Yds+9th/FphCFY9wEzOcfdINsCUbmDzndVbhjqD1LYIymmUssCrot1OXd8DxNpPBBLOV38nyek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4446
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.11.2021 08:06, Jeff King wrote:
>On Fri, Nov 05, 2021 at 11:25:25AM +0000, Adam Dinwoodie wrote:
>
>> > ... I am not quite sure how this explains "tests relating to ssh
>> > signing failing on Cygwin".  After all, this piece of code is
>> > lazy_prereq, which means that ssh-keygen in this block that fails
>> > (due to a less restrictive permissions) would merely mean that tests
>> > that are protected with GPGSSH prerequisite will be skipped without
>> > causing test failures.  After all that is the whole point of
>> > computing prereq on the fly.
>>
>> The issue is that the prerequisite check isn't _just_ checking a
>> prerequisite: it's also creating an SSH key that's used without further
>> modification by the tests.
>
>This is sort of a side note to your main issue, but I think that relying
>on a lazy_prereq for side effects is an anti-pattern. We make no
>promises about when or how often the prereqs might be run, and we try to
>insulate them from the main tests (by putting them in a subshell and
>switching their cwd).
>
>It does happen to work here because the prereq script writes directly to
>$GNUPGHOME, and we run the lazy prereqs about when you'd expect. So I
>don't think it's really in any danger of breaking, but it is definitely
>not using the feature as it was intended. :)
>
>I think the more usual way would be to have an actual
>test_expect_success block that creates the keys as a setup step
>(possibly triggered by a function, since it's included via lib-gpg.sh).
>If we don't want to decide whether we have the GPGSSH prereq until then,
>then that test can call test_set_prereq. See the LONG_REF case in t1401
>for an example.

I was not aware of this. I assumed prereq not just meant checking for
pre requisites but also setting them up. Since i still have a follow up
patch series in progress i will keep that in mind and move the actual
setup code into a function in lib-gpg. There are gpg ssh tests in
multiple different test files so i didn't want to create keys for each
of them repeatedly. And i'm not a fan of checking in those file (like
the gpg keyring for testing) since it also needs documentation on how it
was generated that is not quaranteed to match how it was done.

We still could add the actual sign test into the prereq for now.
A `echo "test" | ssh-keygen -Y sign -f $GPGSSHKEY_PRIMARY -n "git"`
will make sure that the keys actually work.

>
>Again, that's mostly a tangent to your issue, and maybe not worth
>futzing with at this point in the release cycle. I'm mostly just
>registering my surprise. ;)
>
>> There are three cases to consider:
>>
>> - On systems where this prerequisite check fails, a key may or may not
>>   be created, but the tests that rely on the key won't be run, so it
>>   doesn't matter either way.
>>
>> - On (clearly the mainline) systems where this check passes and there
>>   are no ACL problems, the key that's generated is stored with
>>   sufficiently restrictive permissions that the tests that rely on the
>>   key can pass.
>>
>> - On my system, where ACLs are a problem, the prerequisite check passes,
>>   and a key is created, but it has permissions that are too permissive.
>>   As a result, when a test calls OpenSSH to use that key, OpenSSH
>>   refuses due to the permissions, and the test fails.
>
>FWIW, that explanation makes perfect sense to me (and your patch seems
>like the right thing to do).
>


>-Peff
