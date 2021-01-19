Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FF3C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5023C2310C
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391978AbhASRyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:54:44 -0500
Received: from mail-eopbgr670099.outbound.protection.outlook.com ([40.107.67.99]:42091
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387661AbhASOic (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 09:38:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3gVSzaXnq2fvfP3vpzZh0ydUdla6A5M0beSc0IpkRyG1vwt4RH8w4sTauQ2eZ7RbHvDuDOxgaL/Yid8FYXc0KDYkYyg1Gx5xZggtru/tQiFdnONjXvL24cMGFuQxOo1tnLbez5Gn+vMZIC/7sUGqp3aPpoRsxjq7X36guBakJwBy0Jim0d3/PNHOzFwH0WHlAauqnOoITGNx6MX453PwW3M3AKBKnFMkAN2Wljt2sEGAKwcq5qsTIlHOMqIvp+p3IjCP1c+7Sj9nrDI3ZC/wkNdo511s3GOt+QFwI2O/geXaiS2l7J/+1wwLWLX+WJrS9qTT4EiuIEMtAidN4hrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx/oI0pbnRR1geC9wLCUiS+kLYDibf15v7n/XjXlEhQ=;
 b=cB1oAa4bpCSBg5bwbkZ8oCffwRIG6GGwseYbHvBUnJwP3Xr9DqYq5ODPsdXOrorveqsfKRWtG6AR8O0g7fRUC2j5+SeB7Loz88PBzpfHZzmBmOErFIVP2Y+hinVtXHv5dPNexhEujtoXjOpciJs3NRuF/PaNLgcoSXUB3lcOn3OJijWCXFsfCBZYvCmlZ4O9HS9yQK4oy6/LN9ZXuib4lXCffVgs3sNLwbF1G0pMzUl0ZSMm85Y7HCqhxUc+jt/snEMTikDcIoDEnk9bUhttEvij92YKJiMKlggw7yDSaxNaqlwPY1TPmp5wxPRkAutmUxfLni6pR5PUO7wbZIwsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yx/oI0pbnRR1geC9wLCUiS+kLYDibf15v7n/XjXlEhQ=;
 b=SH0DAVPn4Tg7MSl7m1v02eXFc8OATIpFggrcPUhJy6GhktNyyS3XfHzYDGDlXKMnQ5CiyxlQnlyVqKxAOVAhqfSFUScL6EfXev4t0dktkmxY5I/LZ+8VH4UxyBzjuQiJ2NGqD+hoQPRCxintvc/RNA1rjqU9zFGfiHyksCYpy8y4qH5xs9NQFoykDDLUe+WVzvu5YGhqYc4y+KJu00V1k5sz/b6e19tCCAZRDKImix4871TJvDhi93deWnauw/4IBkd+WUt4oJTZ+eGoaxMgO9i/fsi2MAgYD1T7+aTxxJaL0PBR6KfE5gYdHkCG0fW5L/M2KC3d9uZMBo1E64/bUw==
Authentication-Results: xiplink.com; dkim=none (message not signed)
 header.d=none;xiplink.com; dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YQBPR0101MB0754.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:12::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Tue, 19 Jan
 2021 14:37:49 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::41ff:ba06:e488:bae5]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::41ff:ba06:e488:bae5%7]) with mapi id 15.20.3763.015; Tue, 19 Jan 2021
 14:37:49 +0000
Subject: Re: [PATCH v2 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Charvi Mendiratta <charvi077@gmail.com>, git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        me@ttaylorr.com, gitster@pobox.com
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210119074102.21598-10-charvi077@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Organization: XipLink
Message-ID: <8fd2b72c-d1d0-98be-e6a5-fb7dc699d5d5@xiplink.com>
Date:   Tue, 19 Jan 2021 09:37:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20210119074102.21598-10-charvi077@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.222.183.158]
X-ClientProxiedBy: YQBPR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::44) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.222.18] (192.222.183.158) by YQBPR01CA0108.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend Transport; Tue, 19 Jan 2021 14:37:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3360160-ab19-4ef0-d623-08d8bc87cb71
X-MS-TrafficTypeDiagnostic: YQBPR0101MB0754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQBPR0101MB07547DDF6914181C9CFE5984D7A30@YQBPR0101MB0754.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLMF3GetCDNYvkMmvu+lmzC3zlmXyYYi5He0t9ZKbs4a9Grgzg3su4Y2GTk55ww/rQO1FZFUtBn2CSg34RJqsGy2bJOpLgpbTpZJSSMIMJYn0VI5EXivzhkvfWexR4EYmrH/mPjcwD+EguC+MKQA+49edPWnJDGPM6VoURND/kLir3UVYKwj0vfTgGw9072iZoIYAbxMAagMw2PV2WLoCX8vNCgU1xcI8piqaqjWfUNx3LIdYNuvE4q0TGF1MoTVVFONuvt1Hvf48FDilqhKPJzDShtA7F8pPg2VpkWCbPjRG04SrBJXPfaajpfk2tcC2gs0iGKQ2JAJfv/I1E0Ofwc4F8Je02dvJRfvoAwd4t6SRdntE1UTlS/p2wsWdTyETzJVDNOL9lNbx252v5gx9ND+hc+fPQCrrXb3NrwWlXQO4Wp+BtFrrqzfpzy921SEbAqcBPVgXQ1Hz/lUmywdKuKwjEYGcaUNusvkN7/AJKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(346002)(136003)(39830400003)(316002)(31686004)(52116002)(86362001)(53546011)(83380400001)(36916002)(8936002)(31696002)(6486002)(26005)(16576012)(36756003)(186003)(16526019)(2906002)(478600001)(66556008)(66476007)(8676002)(956004)(2616005)(66946007)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: f+00cprAQU/1zIJr2WvifGiS5xgYF08CCeZT2hEDsUmdXgKp6xZOW5M+lLQmiIgdVCKjzodiYGuWYNpRj8dnShVT4K3mAt9SvvlELQyxMlWRghY7RfRuhevdRuXHD5y4qKCxQ0r7WqSFHlyQy94giSAbwGfT7A9u9eVCGXG/DD02CeGiUFbGtkgqfTlH4WgKQ5xOO5syEk2NVe6xQlArMcqnCC+rY7qirxcVXuhDKHOxoWWkw2F5Nxt6vwMhMctyxuiklUMz9IJKWxgymBM+bNOhUNlyBEIX958l5AqGNVL/G7VQ+7tAbTbME7VjM7N9g8YpV9lIomXWbycsv3tWA4KVaSj/rXNSFGt57hDMgRDWQ6idkUzKbIQvP4tA+GHHcPwieoLha4ftB567OQJeNKUsVm6ZBEmNI/aSw2S5LPCKi5/x2s6R7V2iLNtZFas2n3ZUlLcWwCTFGkZu+Rq2g/znw4NTikW00WPe06jmghSMXy/2M6lzFnTGU8GynhF0didUJEzMdyGfYQqG7uJFsClgW/AN3nKIPgc0IfwLdK639K45rkDYEs+fJfWsV4InbvW9SBV1XqEnOWQrL/dMVsUA8+9HREa1jjEj3fR+yjKkXR6JpsMYekv0nhteeN/JhRGHA0UcEK9CbHrailJRXQNGioJFohXspxNh9SuJH5rojXGpY1Dml/avx2n57jbjhXHTVbcRA2TbNQ6oaLeA+0MKxZbOidAZAz9O0ULRWmILeEYPXyR05kTkYK9ngAizGFQOCF6pA3Qvhdjw47BqEUqh6gJJO1Ut1UM4M087zkW3PIEDj9kbzeuqyKF0oWGJnkIlBMZECWfI/GwElNkJD82Ig8SDnDMg7Ne00midxM44Vue8fsjO2DTZDbfUk5Q2
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3360160-ab19-4ef0-d623-08d8bc87cb71
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 14:37:49.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eSMejK52TQYmyPDI6K57GyfDfWPuFgGbbyN04veg8z9fJ7bzQTn/zmR7b4GUr8uO0kB+d9qoWU/iQZjwxRAOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB0754
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

On 2021-01-19 2:41 a.m., Charvi Mendiratta wrote:
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
>   Documentation/git-rebase.txt | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index a0487b5cc5..776507e0cc 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -887,9 +887,15 @@ If you want to fold two or more commits into one, replace the command
>   "pick" for the second and subsequent commits with "squash" or "fixup".
>   If the commits had different authors, the folded commit will be
>   attributed to the author of the first commit.  The suggested commit
> -message for the folded commit is the concatenation of the commit
> -messages of the first commit and of those with the "squash" command,
> -but omits the commit messages of commits with the "fixup" command.
> +message for the folded commit is created as follows:
> +
> + - It is made using the commit message of a commit with the "fixup -C"
> +   or "fixup -c" command. In the later case an editor is opened to edit
> +   the commit message.

s/later/latter/

What happens if there is more than one "fixup -C/-c" command?

Thanks for this work!

		M.

> + - Otherwise it's the concatenation of the commit messages of the first
> +   commit and of those with the "squash" command.
> + - It omits the commit messages of commits with the "fixup"
> +   (without -C or -c) command.
>   
>   'git rebase' will stop when "pick" has been replaced with "edit" or
>   when a command fails due to merge errors. When you are done editing
> 
