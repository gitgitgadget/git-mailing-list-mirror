Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ADCC001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 20:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjHCUjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjHCUjC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 16:39:02 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2116.outbound.protection.outlook.com [40.107.116.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E9F30EA
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 13:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYUw2P4SEDQqAag+Jvkaw1vCYX+j8DDdkcfO52BYKlyDBSh+sOhnlvnVaglB5gUtfRYuMgG4opbj6SzqKRfxcDxBcP5WWXh9t9/i46Yk2vde104lPr4LBmmibjmGGp4gKMXmOJ4xwKB/GuPz7UtlHJ4fhKQleKZvg7QlUwuPArSz+UUycjSHww8VivBGT6VyqQMJ4acL3GvDf0+ThgNFX+TY9bfCKFSGgkC+Dfo23jNOsVtikZMASeItMKTHJ95DZojQVejjBbcNgXt3gTj3K64Xk892VJY+rQ9+qikdKO2MoBfDuPZoLPo3Y4FEjgNCogeORplSXRcoS76Bn9HYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndONv0CnbDf1tmhl8FuCab/KFueWUmWJZ1gFBdg/3z4=;
 b=U6QrXH1G+P6dlmvVO59ioi2teEJjoDv2CszV3oita1idjYU2rh+aOOfCxA+wW9X7ZDpzQgSQ+nDdb2Yja7gDH7eLBZEwgqP/ZMJWIKy33Aqymif2D6BZTHw5DMvnSc3Ye8bkj3a4+OsVBB34QoJP2Ba8FgXUoz37Zzp28EUdy8RM4ahtc5Yd00bjYUOMVC6zl6uUvfj76ymkVhuTNzCveX1tfbd2vId0I0V8JbGYkIEySz5r+D1+/NlceUlzjOJMARFISs4G/ZjHuQRPqw4Jm8FnCAhQx5abdIsTFErUVvgxm3TTyAuqnm+eKuVuRessNcB/xIzWP1YnOJxTEdBI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndONv0CnbDf1tmhl8FuCab/KFueWUmWJZ1gFBdg/3z4=;
 b=iCwBGz9woooYdFaunXv+g83NJtbE5Hw78Q2aM9ouxPWQMSV0+SLMRn7V0AF7d13Z6gv9BGJB7CJm6hG6T2IG/dRJSQMbiDzSgRo1NXkshxPDcqNEdSKqVvKUqoSYGWxyRRCH2q4wm+RW9Tg7+BE84A3fApdm4Za/GZoitCrX9WlCKK2t36B4uHvc0hRb/hZB+3i1C6L9wMwZBFbotVirsy9SsMdNAVM4HkK61kkuw8d72kiynwWOm8TQcGNgW3OMWkfPU/GZlvrtGMVD09HbwxZucSGiKMPR094w2ANTZ+hfCkf5Q5ieSVEmhYvDpHGiQ+BfWBRRQ1wqHhNKO+K0Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YT1PR01MB8683.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 20:38:59 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::eedc:def7:9e34:7ec9]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::eedc:def7:9e34:7ec9%7]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 20:38:59 +0000
Message-ID: <32c8a181-76aa-5c90-427a-53b1ccdec8a3@xiplink.com>
Date:   Thu, 3 Aug 2023 16:38:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] rebase --skip: fix commit message clean up when skipping
 squash
Content-Language: en-US
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1558.git.git.1691068176051.gitgitgadget@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <pull.1558.git.git.1691068176051.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::16) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YT1PR01MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b6af5d-4b7d-4243-2d0c-08db9461a9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muKTooQzJuPH2C+UuIMZJbYtLvqdA9H6laGm0rIkYFoMYaRLUiAxrLQayYbnJne7T41YYoHFDWNyMomOft7iH11MLrME88qOtyOf1qOCbrAN4zaLKKc7Q2ko2Lu75m83CPCBmT/qtepbcm6X9Q7d0d86GOEsrwOYPdGMKgeN9SLCyaSC3GJ4LoZ+MgRFuw4WmJzooLZXzLxVLrGuWv/yiwsciX01zW24IbdxhIkAHyKoF8YGkAzQpKfGB7blMSxxz1H/ph/sW1ihdiOJSGpCMKje8ioY9Q1p/jRYQ2DoB7wGEnxZBRfDKO7D9FAoTXMAUaiCmgBG/7EZzM/BnpmmAP4XZyquXSJfdD0q3LpAGfC9QBpahPwzNfo/IQu+HpSasK6JvnNB3AeVh/EBQDBzwYzsVcEQahi7B36H0oB6tgfJ9bn0OKNYc9FhEc3KfxMrVYOa+e5rErlRyH/F+7sSutcY9Ii/1nEpnHMZxhiamyDPhXz3gLH2BkjigMpnAux7IO3fea07jLa1ufyRlYRSKgnHHN3OlTdoeSWwkcZfpDSzsn/iewzcXMSHCGES0b26lNXizRK3CAEHIl23pdDbax1LUMQSDHAiI2b3O1l74GbJg1tV2x9LBBwfYjiPAsWhdylcbSVKbR9ZI5TVuQ/Gvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(376002)(136003)(396003)(346002)(451199021)(2616005)(53546011)(6506007)(186003)(8676002)(83380400001)(26005)(66476007)(2906002)(316002)(66556008)(4326008)(66946007)(5660300002)(8936002)(41300700001)(15650500001)(6486002)(6512007)(54906003)(478600001)(38100700002)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1paaStHUk5ITGo4UHRLZXlSZVZJWlNadmNDNTRDM3lXazN6b3dZU3FLb3NZ?=
 =?utf-8?B?UURqbmxtRFpBd1U5TDAyY1ZiRk8zRFkvb1lDTXR5ZHF4RzEyWlNlUmozeXFL?=
 =?utf-8?B?MUtLTlViWFFnd3lWQzVyUHQ0MnlOMStzQXFFQytUQjdIN2dOSWJIcFFjdW9E?=
 =?utf-8?B?TmhhM20rR3NTNzFNODZFQUhDZmZ6WmZCanBERzJGaWQ1Z0x3d3JxbDE1Kytu?=
 =?utf-8?B?eVFFUitzM0QxRWVvblFxQUIza21Rc3h3cEFpWEdBbUdMSm1vQzNzWEcrUkh2?=
 =?utf-8?B?VWJpemRLTVpWNWVESDRTTnNTN1NGMW1iL25tbjdOZWUrTkxQZ1VsT0lCYTho?=
 =?utf-8?B?S0hjMUV3R3VqVTk5T3NQQ2dDa1BXRlZxTTIycE9qbmVNS2FCWDcxRVFlS2U0?=
 =?utf-8?B?VHc4SjB0TkxlM2xwN1BCTlBKRVBXN05GcnRGWlJmaXpMa1ZjT3Ywamc0aExZ?=
 =?utf-8?B?cVNuOEVzL29vUnhLYzNSbncrNWpvNDcvQ0tvazN3eVpGZy8ydzh3VVNpREpM?=
 =?utf-8?B?R2RJdmRQeGtseVdiaEhHL09pdG94aEsxUWpXWko3Wmh1Zi9HTXZUeDErY3hm?=
 =?utf-8?B?M2pmV3d5WTAzSlpUbm95eGNHc2ZFT0NJR2VCSEpmdWUxZFBVdnk5MmZkek1k?=
 =?utf-8?B?SER2ZVluZGJYbzBSVEdRS0JXdHV0MG9TNnNMQjNqNDYrZE04eHlDUHI2c05N?=
 =?utf-8?B?SS9YOUxITW84OExOeVRCcmxaTFRsMDFSSzVMWW9IRGVFckMvenlOQjBBOVox?=
 =?utf-8?B?SlNSeWl2ZzRUZkxXV01CUlpuejdPMWdkdm9qS01DOXdKMjRvVElucm9kQUds?=
 =?utf-8?B?QzkyZ25FWFl3SVVLbkNrSERMamJTNWMyaTFyMm9wc2NBSExoUjFnS1c1TEJu?=
 =?utf-8?B?akJ3WUYyUDlhTUIvVlMrVVhXQk1YVHhoUVZqMi9NVEdzQ3hFV2Z1NkVaVTdB?=
 =?utf-8?B?Z1ZpejZBS3V0bzdrT3JRVGxzVjV5SWJrS2RPSW5YVDlqNHlsSy9VWnZxdE1t?=
 =?utf-8?B?OFJUMkNEUk5weFhZMWtWdEZGNm5xMzh1SlUxd29hMld1TVBZckxiK0trWmFh?=
 =?utf-8?B?aFdPZTROdmE3LzBHUlRxT1RyZmtJakJGdFBaNW9tU1FENzkzeDdwcDBEaUFa?=
 =?utf-8?B?WHhYaXBOU2d1WFVtbTFqdDRwYUs2bU15VzV0MTFGZ29va3BiVGRCZG5hR2Np?=
 =?utf-8?B?NVhrc2NxQ3FzZGYvRWY4Y1JucEljV2RBdXpmQUk1YXFrSlJyQU1CL1hqcjFV?=
 =?utf-8?B?a2JuUmM4eURtM3dpS0lqaVNGM1pyUWllcXNyOHRqTWMvR3NyWWNKWFZNM01T?=
 =?utf-8?B?cE9MS21NWUFaZDVDUmFXcFI0SzhVRnJBV3pGUlFOaVZBS1BpdEZ3R2NML0hB?=
 =?utf-8?B?VHd2L09QK3N5THdJb3pQTlo0TWxKZmtIZ0VuMnRDWTB3RmZ0RHc1S01YMkE4?=
 =?utf-8?B?OWh1UUcvTzB6NkVvRlBHTDBKWGpVdW8xdW5yVHpkT3p6cWRKclBsU3RYWE9U?=
 =?utf-8?B?c1IvREVtNHNDN1RyRE12U3p1OEIzdGNieEpjRTVKYzZEanhHdzdwMHNVZ0Qy?=
 =?utf-8?B?M0Z3N1AxV1U3a05ha3BHSmtvME91aEVpQjRRSjE5V2l6cmFkaCtnSURWOUdp?=
 =?utf-8?B?Wmg2clBUeGxmRlBiZ3lVcjIwUkdsRm5QTlAvb0tmQW9EUzRiWXQ2MzcxQTBy?=
 =?utf-8?B?U0lxb1YyeDI1Nis2WFllL2ZuYzNjTVYzeWQ1YVlvNlZYSmIvL0tXWWZIRFFu?=
 =?utf-8?B?VUFmbE1Sdzk1SWMyS2N4L1BTQjEwNmd2eUJTLzg4N1lEcW5qZEJ4KzN3cUZn?=
 =?utf-8?B?MmExdDJWS01JM0xWa3ltSEx6NUw5NDJmSkpHSFBiQzUrdzg0U2xQaDRyN0tT?=
 =?utf-8?B?Q3ZWRHp6YjNCb1R1MGFqM2pjY3Y4S2I4YUtNQ3NMUk14UGZ0S3RtMnlWMmcx?=
 =?utf-8?B?Mk9oTm0zVWl3SEFPVXNHbUlFR21vRnkrQkNVdEc3azVROXh2bGpERk9oOW1v?=
 =?utf-8?B?NFZwMVJ6cEFpalpheDg0OGxvUkFBREpUZkN3RXJwREliMHRWeklZSUpsRkZk?=
 =?utf-8?B?UHZlc0pVeGszSnpHeEE4enBFaDkyMHI0empMQT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b6af5d-4b7d-4243-2d0c-08db9461a9fc
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 20:38:59.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 837Owg+dhb9aaG9EVbDFQ3YnGRqxd3Bap24n2SQj7xDv0XdzR/lcFD0Y2+oa9VBxojM8wYaL+6obp8sIvOqv7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8683
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-08-03 09:09, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> During a series of "fixup" and/or "squash" commands, the interactive
> rebase accumulates a commit message from all the commits that are being
> squashed together. If one of the commits has conflicts when it is picked
> and the user chooses to skip that commit then we need to remove that
> commit's message from accumulated messages.  To do this 15ef69314d5
> (rebase --skip: clean up commit message after a failed fixup/squash,
> 2018-04-27) updated commit_staged_changes() to reset the accumulated
> message to the commit message of HEAD (which does not contain the
> message from the skipped commit) when the last command was "fixup" or
> "squash" and there are no staged changes. Unfortunately the code to do
> this contains two bugs.
> 
> (1) If parse_head() fails we pass an invalid pointer to
>      unuse_commit_buffer().
> 
> (2) The reconstructed message uses the entire commit buffer from HEAD
>      including the headers, rather than just the commit message.
> 
> The fist issue is fixed by splitting up the "if" condition into several

s/fist/first/

(I'm not qualified to review anything else about this patch, but I like 
its intention...  :D )

		M.
