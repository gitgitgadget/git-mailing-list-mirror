Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF76C46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbjAKWGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjAKWGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:06:16 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2064.outbound.protection.outlook.com [40.92.64.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B93125F8
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:06:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tt6gl2kO91/HTrdfd7TUGDKPA2X+54VYoO+fonXnnjTXB3sm6TIV/T7sqxKsXqdZbq9hTXGyoom7YfdzKsHB2kkxY+5hgNUm4vTVNhXvsobLuT7ncrXApUsg9TlUHVbXkRmlFCQNYZRD/zEpA/NkapUnD5n0M6bWAwwGGQ7Pwx86jGOTZ69Y1ZTPEbdKPrT/Dl4kxMbOYQXMoWjhCXDc0A0DA2tR992oNOj5IjFUbzCPgQU4rwAZwV2WomrdiVNSC8DtS2ppTE/h64F/xI9rGSSbA0mjb76MEGlLyH69xlH+31TbCKH9u79zgin7n3sCmZItXm3FVi6w0kVhasrqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2px4lsZloNHl+zck7xkh3kmFLWUgU724Wv8Wr3yIhY=;
 b=nmVASTjZ7GbkxQdFi8YUhiOo+tvZrCYHt7iDHq7W5zp8W4V1TaH86tL1ej4T+ay5PeknR6pJgb468KJV1obPGGwy6nlltfKldWXaXDfbWm/SeQiJXlkRT2QT82aUAdaiQiBZZVZh0N4iGRlipsr/cvHrc6vUJq/58x/uP56r1E0DLg3RhAHpMZKxL79jQnsFaikCCxTlkifo7Z4bs884Jc5cj8RhuV2K27y6zUDs/LgELJfIn9kYm5/Ci3X+tqD0YRpkcv4vu+MK+PpcrNmpkpnDeVHy/kuaYufYpvaYHf8YgLKa7/qdv5uP45Iwd0lA+tNJH9HQ34prFP65LmJm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2px4lsZloNHl+zck7xkh3kmFLWUgU724Wv8Wr3yIhY=;
 b=CkL5IhAPRgda6MYcWZxaOWNLQR8v1j83uhPhKA06uIWORyUUmVxNIsAgvvbGeJN4Kfp/7aKWjjri+ZATB2juUpBUbFYskmFvxXSUDycMYU+0mmT/pJkTEmD3oXdlF97cQNs4oRoRwqNwsgPSl0b+dBr5eHAC2DWGmQ4YUKjjM3bv9tG1oxUus2ur87V31D6JgYZ/2wS9II8vMs0z4na7FfAT6dpI0DDzmOoQWGeCuO8PvDF/GgR9dDxNMVcRhv2izqW80IaC+Gi/i/FBk2EvsyaP18ob8gMR6Ich8WlQCkddQb0we70WYkUyFBbHap+zUckMACyU4jcXRjkAIr8FWA==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AM9PR03MB7868.eurprd03.prod.outlook.com (2603:10a6:20b:433::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 22:06:02 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::8428:153c:704f:4519%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 22:06:02 +0000
Message-ID: <AS2PR03MB98153051196418108D6CCAEFC0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Wed, 11 Jan 2023 14:05:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 8/8] t5556: add HTTP authentication tests
To:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <8ecf63835229676677e3f7e33f634eb5d3a568b7.1670880984.git.gitgitgadget@gmail.com>
 <1dc44716-2550-47de-e666-9972b102905d@github.com>
 <xmqqpmcltt36.fsf@gitster.g>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <xmqqpmcltt36.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [ph9it+n+cmYkMv1XtrAoWeeoqqPYTtOD]
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <9a0623f1-4ed0-6955-8bcc-bc6a352f4c54@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AM9PR03MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b8f846-3a88-4b30-9109-08daf4200720
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ARu8nXA8WjRiMtLRnkN7rXJ/zIgkQPZ+V4QBQjHH+8C1rMSFCRqqArsDZHbTKJCPTR1f3WXeK2ti9gGcuxKFrYq5RfbMA2ZxZnVb1BsQm7+vMFZu0t+WGdS8riBQygmHor+4tCI7hiR5qIswFNzKDqi6hsP5WWxCVEHKhI1VUF35crDUhBNjuTlsYoHEt2dUo0G3NH9oUJpXscsWRiGETMb6hhbk+W0WjtFpu29h1AZX+gPTK6psWyal/siWsKM/rhyl1bkX+ly05RlnmHHpy1/TNGBMrHzhacjppK3oAvUBkOMg+L4g33LUW8cZX5WNT4I3dH6tCHY1yOyXYSlSoH3lPfm7Y60av1l5exIZ98zwYT78axBJ+qnMxEQwTBMYkQ370y+MeDgMoyB1lZT/vxVIKwKAB4u/EPWcqoYwAXUyYRUK51fz08kudc5PP/5+iWKHoIrnUCo5m6FyMwK1625R4FjJUnmarNV5NQha4fcem8hwXazNlodxJh8Z2nrkV23hM+JRisRtNipFhwG9JRkqPFzd9Ab4s28bhu1jcyRjgiZWe8nUFMDbMzOy2WApu2/jL5qNCcv3ufUd2ZskUN4mvuw1lDGMhr7DYAOcgcavEu20jX58oQvu4HCiLoQzssIq7n4mEpEeA6EM9o6AlDg51AVIp4KCXkOmLIqSzU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDhQN1ByYlF4cjhwY0ZSM3NTcHBlM2RFRzk5MjVVZkx5enRkOTR5bXcyTnhC?=
 =?utf-8?B?NVkyalplVzZwZVlEV1JsWlNBc2lnR2xDRlNGbHlHVHBrZVA3cjVTbUFKK2NE?=
 =?utf-8?B?cVBwNDlFa2ROVG9HODh6TG1mTTE2QnZpd0RFTUhmZ3hoek1aM3FvVVk5eWha?=
 =?utf-8?B?aWZubnlIOTV1TDgxRHc3YjhXaHU2QldndHU2UklxMGM0RmFLMGdLcGZwUW11?=
 =?utf-8?B?YkVJcGdHWVMwbkFsaHR2WXJxRWtyMEd4K292VGhjYlJVaUp5QVZ2dXNhN2Nq?=
 =?utf-8?B?SVIrMTZYalo1YUQ5OUdnd3diaVdNYUlFeWwxb1JiY01WY05SU0dQZW5RMGRC?=
 =?utf-8?B?Q2hUenlybXVSYlFsZFVWc3hNcHFsQlpRRTNEb0tHMVZ0VjRHNy9iZloyc3h6?=
 =?utf-8?B?Vy9jaDJVSUN1UTdFTE1FWTVTNllhS0FnRDFEVzNqTlRpOC9VOENNNC9GYnln?=
 =?utf-8?B?TnR3RHNVbjE2T2Rza2hKUnFENkJRYitRV1JUNmRucU5YL3oxWURXTDNCN2N2?=
 =?utf-8?B?bmd3aHM0cmdHbEx2ZXpFdkZ4dWJwOEtJSWpLcXc0Z1h2STY2YjJFZXp0cGVT?=
 =?utf-8?B?RExhdXpBTCsxUkNTS0tuUWJZdHJuVlFFTnFJODZGeDdTTDEvNjNFcHpjOEYx?=
 =?utf-8?B?aVk2TVRHTllBRWd4SndpYjlpQktxZzFMZURXcHhHMjNPNVQ0V1hnaWlNYjh3?=
 =?utf-8?B?K2Y2Ymt2Umg2VGluT2xHK1Vid0VPeTRLMFc5MnBaQ2htb2ltWEpOR2NmK0ZJ?=
 =?utf-8?B?UFpXWmt0cHZPNkt2cWw4TjU5a2RRcDE4V203alNlTXBWeVFoVCtCSE1zWnZr?=
 =?utf-8?B?NUhyL2RkaE1EQkV1NTFTWitDY0tlOWpRYitNU1ZnZmxGeklBdXE0VE1sa2Yz?=
 =?utf-8?B?L0t6UFJidW92OExTeEU5L1hYaW1sbm5IWlg0cm04eThRdFVlMlRiMmZFMHNo?=
 =?utf-8?B?NUVla3pBZTdzd0NWSmxFSkpUbUVwaEx0aGJWdTFzLzRGM09oUkdIZFF6RVND?=
 =?utf-8?B?c3pGaUl6eHpjUFZqWFJ6UlpQWk12U0tsanpXRnQwNFBHazlKMk5XSHVXOXlL?=
 =?utf-8?B?U3ZldVhidHVqK2tkNUM5Z1lYVlVpbW5EbmhWaVdpMlhtR1F0aVYybzhFRERs?=
 =?utf-8?B?NVN6RHB2YVQxRmFocnhic21MMXhhU3hBaVc4Vmo5bUVHS0pUd1RQRThCQyth?=
 =?utf-8?B?VjBqckg2NVNVUzBZUXpYR2FZNUFUUVZvdXBzdWROSE9TeVI5UXE3SjdoSDZw?=
 =?utf-8?B?WGlPdDhRa3gyVjh3NzdDaVpBSEdoeEhGU0xLUTNmUTRHV3B3UlNoajl0eWRo?=
 =?utf-8?B?eUxXNmVLUjErU1o0NmNFTDcvU29qRzc2V1lvRFNNNFpyeFhsYmJxWHprKy83?=
 =?utf-8?B?Z21nOHJnNmpVZFRQb2Q1aU82ZWpRUGJmQjZ2cmkySk1KL2ZtVC9WZ01mT1pJ?=
 =?utf-8?B?djFHNUNLVnQveDdvazNmdFhqNWlsaVlvOVRKMHlZSXZUaitqdlJyK1JuSitW?=
 =?utf-8?B?V2NsZUR6cngwWEl4SlNmdmw0UVdMWTNCbEgvKzltMjlOdFZuelFkK2I4UWpq?=
 =?utf-8?B?MHd6Skp2elU2bDYxK3F2U3pXOWM1ZXRRVkd6bGtkbllsRWE3WDlhOEw0MHR3?=
 =?utf-8?B?eTRkU0ZmNmhIbHlPTVo5emhQdUhrb0JCZGJ0R0xpMzJsdGJYZnMxMGVISTVn?=
 =?utf-8?B?WkZpZ3F5SzQ3a0d0eTdoTlREVitvQTJyUzg5cjYwZUlBU1ZFdUE4VlFBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b8f846-3a88-4b30-9109-08daf4200720
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 22:06:02.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7868
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-14 16:21, Junio C Hamano wrote:

> Victoria Dye <vdye@github.com> writes:
> 
>> A general comment about this series - the way you have the patches organized
>> means that the "feature" content you're trying to integrate (the first two
>> patches) is contextually separated from these tests. For people that
>> learn/understand code via examples in tests, this makes it really difficult
>> to understand what's going on. To avoid that, I think you could rearrange
>> the patches pretty easily:
>> ...
> 
> Thanks for a thorough review of the entire series, with concrete
> suggestions for improvements with encouragements sprinkled in.
> 
> Very much appreciated.
> 

Yes! Thank you Victoria for the detailed and thorough review.
I also too very much appreciate it :-)

Thanks,
Matthew
