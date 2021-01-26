Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325E7C43603
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCF7206A4
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbhAZWEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:04:30 -0500
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:61553
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729129AbhAZUc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 15:32:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho8NEDJ7VIpY9lofuVKBYbJ6cy92sdhHfVbnKR7uqFWptPgLCrCIGPwGdIlSUahoe+vhKafIFH6nZ79AqInsfVxNIwmUhCJG+RATQppYhfyhPUgg0zyePDsIsUcjTqbPrkEqWDXQQWMhNu8gKsmfWqzkWE8+ICrJtTpUN0JCHf21WorEPlv2ZHDZTBq6Hiq+bCTM/MEWcNJ3KywKXSy4NfJv9DOtFwgmjun0rSQ6O3gP01g4MQwngi253Ll7ar7lM6ajD3eA8UYURN6aFbRb4qEonJh5MaCJhx3NeSta2Uhrp+OHRQQ8o2yRHvqH94JifiFcU+WKEb/0+tWIuyQ4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlzAUTOf8TJUeiMyZ2NjeP0BGIeJVi8XInwaKM+odIw=;
 b=eWDk6B1WjOFeeaxrY5F20j11wSupbQBUygCttTDB0/JbC5/3yUYXBBV/3SeR+hSwnOWRnwek3LDKKQ63HTGbqQAhyDyUKppz57RAmS0pvLv3o2wHnyAq14uNmGuurqeVkM8mtuDifc8X4jFSJEV8ILGALVbURslRyp13G3yFsXU9Wd4R89gfKhrOQwpPsheJ3sRU6ke85bQUBDfQjZ/4kwx5qj2XyUeqpsYAUrjNTStMLRB+X1gnlnuOy7Si3TvudTGulvg8omiogsoMWcT8YqfKpD9V6wcUUUYE6Vp4iyPw8Bi5z9B8x14ja2iuljJy8jADnFzai/GcPNhcln4lGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cedaron.com; dmarc=pass action=none header.from=cedaron.com;
 dkim=pass header.d=cedaron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CEDARON.onmicrosoft.com; s=selector2-CEDARON-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlzAUTOf8TJUeiMyZ2NjeP0BGIeJVi8XInwaKM+odIw=;
 b=AWpEIAJrKpr+EZ3eDjWErn6Yy6LOosNWZqZvN8wHcR/VUsOAwryjHxs3OtMZr1BnTwDlGNwfLw43Kt9ugb5df0Q16F5D2t8tFpCcp9zUZ44TNlnKE8t4AjFv2lr6ZQIVFMosWuXomacHnY4F7DmRXwYGZ9rYq5WIrdfCV+CG5/g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cedaron.com;
Received: from BYAPR20MB2758.namprd20.prod.outlook.com (2603:10b6:a03:fb::15)
 by BYAPR20MB2696.namprd20.prod.outlook.com (2603:10b6:a03:fb::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Tue, 26 Jan
 2021 20:31:33 +0000
Received: from BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::798f:4f9e:fcec:d323]) by BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::798f:4f9e:fcec:d323%7]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 20:31:33 +0000
To:     git@vger.kernel.org
From:   Joshua Hudson <jhudson@cedaron.com>
Subject: Null pointer dereference in error pathway on git pull
Message-ID: <1cda3398-7b02-edc5-aaab-c75191124b80@cedaron.com>
Date:   Tue, 26 Jan 2021 12:31:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [12.139.157.2]
X-ClientProxiedBy: BYAPR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::27) To BYAPR20MB2758.namprd20.prod.outlook.com
 (2603:10b6:a03:fb::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.8.74] (12.139.157.2) by BYAPR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:e0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend Transport; Tue, 26 Jan 2021 20:31:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 129bc43a-38cc-49c2-3371-08d8c2395e6e
X-MS-TrafficTypeDiagnostic: BYAPR20MB2696:
X-Microsoft-Antispam-PRVS: <BYAPR20MB2696A345F22ED449882F89ACA4BC9@BYAPR20MB2696.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Q2VGPpO1MvR2XNsgv+HSH6E/IrncA7wfJkrJag9r0Ha5v9z3UTTqfKiU2V+aTL7cjBvMaN46zJC2PNrp8cQ0o0BnLa0wKEptkJPwQDoB1Dv2zRnIiHEk66Lo1j095jahEkqNZI7WmrH1Hdw7Uk3DeQE8yNCYljvX3EEly0NkC4+tfSPG0ItoUrvZS+t5L34U6mpBSu57YzkbnQ8D8VzZTdHRqDTRmpe7dV4wZRaaMA3d/q7gBdnauA3OeBg8/2OL1UxQlDVD5cffqgkMFo83l6ebS4fS/6+qervZ2m/xJRLho7qCca9KCenTfSrmfCU9zqzo+LJkSmiCRhDGxgunMcbcdtDo/3jwL63fVxZkMgXQbElspIf0nZPgN0q9guf0uHiJeUkasztIR21ZMrFECo9xVb9e7lY9xUpg9EN19TAYVGvWJlL/YPQdlNnGjX+/pyNQNJE3wu6GHMYbOJeMIV0OBulE91QReK92nFlmec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2758.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39840400004)(316002)(26005)(16526019)(8676002)(31686004)(36756003)(186003)(8936002)(4744005)(66946007)(16576012)(83380400001)(2616005)(31696002)(6916009)(66476007)(6486002)(52116002)(478600001)(2906002)(956004)(5660300002)(66556008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGVDTHo5em1zOEVONXViWVdJYkVJaHFSMWxTTWRGQlFtQmEwYlNMeE9ONWRa?=
 =?utf-8?B?dzJFTEhJQUtFcGQ2bWk1ajVvU1B5VnYvMmRBREl3MWVxK3BCbGR0blpNdE9B?=
 =?utf-8?B?TFJMU2lic0ZYVVVpc3NpQ2EvYzh6aEs0NEI0eURpdTVkMm02VktjT1Y2bVpX?=
 =?utf-8?B?N3NPYUxqNjFyTkxoZzJ1bXVVcXNKUElUdDhlSzVlRlpTa2k5TWNTL1ZjLzlM?=
 =?utf-8?B?SkJnbmt4T0NIVGVSaHFmdUNScDlaS0kwa1NnQURnOU9Sd0VIN0EzTWFpQ21X?=
 =?utf-8?B?K3FpWEdyLzZhVTlxa09HZTlSUU9UeG9DRWVidHJ6VlF1d1pRZjc3eXBQNEJk?=
 =?utf-8?B?NnYwYXNwNjB4L2tKeDI1K3JZcGRQblA1WG1sS1RmRUJmeEtUeENveCsyejVa?=
 =?utf-8?B?OTg0YTdydnhIN0ovZlMzUXR2R21xMDhyZWlnV1ZhaXZYMDR3dm4vR3lCOU5t?=
 =?utf-8?B?MVlQZmlQMElEaFI4QU1BNk9KbGNhcTlNcFBUekZyQW9WS0JGOFZWQzcycXZD?=
 =?utf-8?B?MUlDcnRhSXcwUkwzQzVDRGJ4QXU1Zndyb0wyN0hMUzdyZDdobDBtWFJPMlpN?=
 =?utf-8?B?VDA0Si95YlpBZ21pQzcydGRFVytYTDJjZVgya3MrTkVKM2p0NWU5R2owbEw0?=
 =?utf-8?B?UjFQV1hqRGhxMmVscHhvREJHbk5OUHpGMjFsMjJiTmFweHBkR29ZNzhIR0pM?=
 =?utf-8?B?OERsZm95T0FEeHJEcUFEZzk5UzFuV0c2OGhjc050cE1DcHJqUWlKQ0JkU1BN?=
 =?utf-8?B?V1lpY1llWWlXK0xoYWUxKy9GcEMxeWUwdWphYmtJSGJKV0hQUU5NVHZESjg2?=
 =?utf-8?B?dm9pT0xyQUFzNjVYQmFJVEUwZTlIVEs1RGpjVUhZc3QyZDl5UVlOZ295bW43?=
 =?utf-8?B?L1pjdHhCSkMvTVZSS3hKMzdSaUhKblpBZjBuWUNoMFBHZlZTYVR6S2Q2Qms4?=
 =?utf-8?B?M2tuOW01UHNDNjFyWG5YSEE5dHJ0dGUwT0JDazlJRHZUSmZIYWcrWmNaVlUy?=
 =?utf-8?B?UUkzSnZ4VWRqNWZRUlI3KzVpU2ZHU3JIbDRCL2FBWUZ6MEdFbjN0K1FRcm1s?=
 =?utf-8?B?Uy82eDZCNmdHcGdzZEF0N1Z0WkgrZXA4ZmRYUjFRbGNYakJUQ0sweGkrZUxX?=
 =?utf-8?B?bDVCNzNFOVJYQXNxb1VweGdCZ3Q2V0F6NG8xRklxWDVyU1FRVEdHR2w3MkhS?=
 =?utf-8?B?VW9ZcEpkdGhMVjlna2cwN043Z1UvVURNdTRPdEJSczFrMzhvU3NaS3gyaEJy?=
 =?utf-8?B?V1dDdE1WK2JTZ2huM1Z2OTlzaWxRVWRqSUc0dHlGL0F6a0lUZTI3T1FiWVBM?=
 =?utf-8?B?bkhxaDJkVmNiUzlZd2RwNkRQZCtwd3ZWSXRmbi9RMTMwb3dpd0xtanZnbjk3?=
 =?utf-8?B?UEJYTW1kRm9VMVVhUmppNFVldVI2N2RvUEdMSllnU1IxYVpJL2VhQkFRUmtF?=
 =?utf-8?Q?nZHTxD7k?=
X-OriginatorOrg: cedaron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129bc43a-38cc-49c2-3371-08d8c2395e6e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2758.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 20:31:33.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a1e0d90e-c09b-4bb6-9534-4bb03188f5a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aed/zyqrU931zMTjRTrizUOKWb6uWIneNySMx2PitCp7N+a2QXegmwgr+kr4uns29AdgJmZvqZC2BKaU/+MGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR20MB2696
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>git pull
remote: Azure Repos
remote: Found 452 objects to send. (157 ms)
Rfatal: the remote end hung up unexpectedly
fatal: early EOFs:  81% (367/452)
fatal: index-pack failed
warning: unable to unlink '(NULL)': Invalid argument


So it hits some kind of error (looks like network disconnect) and tries
to back out; passed a NULL pointer to unlink().

Apologies if this has been submitted before. A search didn't find it.

