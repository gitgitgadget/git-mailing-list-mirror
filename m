Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4C8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 08:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhLIIjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 03:39:52 -0500
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:14177
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230330AbhLIIjv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 03:39:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfA7DKyweJN3OSZrYHYczml7ew0dXDNxpB1CgDbAnTlU49Na/btnXuBbwIckWHAjQXjecRr9I6C8cUu2Dy3rLSQ8sB75vHs3kJdaIXCBjO8Ypo7bi23bEC9Gw60OQAUKXnE+cTbOP0yPBdo75L07juFbHmFkT81lUCVt+NvbPTo53qqLANE0S211UGJ59SeP60q33NMcBxmjlyBnl/mw1wxhOvsq2CZQ13gJgOcb9XL/vwCNN7MiV4YX8jYiIc9b3o/jGqsXO3oYJ7xGO4tmLBESUYC4IFwfTa97amOzH+Tf7WQh15iKvHL6fJ1UfVSiAADUInmP6H7422KHYBg+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EN+Ynm6kXM32nMzdoUtp/et6bXY0um7deUaE0ZXZn0=;
 b=GKbVj5u7dI+iU/dcrZba1fex8WlgcZRpHclRG2rtx0HwI55wW8oeW5BHvDwF+fU2JNXbEtQCO9DclYWvpcJCraGUxBSvMfGojSultBaZ/Ei7tgNY2bCYZa5lvz9CeyRJvacUKxjOwHheIF5iSvBYFpPPSw4/czba/hNgykgGVdRrc3uaYFGqEyMyl1YAUulQK9rgWYZHI2SoftmkiP8cz7un/lfP1EeFuQvSDiXM9+Smto/lz/P1pj9gIDMhFHEk8FJQO52Z0/vesPENHcrHv/4LrSfY4biO2O+hArXO3m2D3AO4onCeymFI6QikpvXQmQa0veIAD9+Ejzb8uXHQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EN+Ynm6kXM32nMzdoUtp/et6bXY0um7deUaE0ZXZn0=;
 b=lGq6L3ppTkGPKNaDFT3g7Z8N4f0zAp2brxJXCJu3qWI7Q/NZWEe/5dQwTLPiiZApKtu/IiyxBOyqzmF8lEXQj23SYA9lr3qUgJR88mXDyHGnksYJQH6MVxz3eV9wjZE5wioXAyAlIQbMZg7ZehjXkRj+GhxmmR+nwggTlNLvdR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.24; Thu, 9 Dec
 2021 08:36:17 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 08:36:16 +0000
Date:   Thu, 9 Dec 2021 09:36:15 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 8/8] t/fmt-merge-msg: make gpg/ssh tests more specific
Message-ID: <20211209083615.nozxvqt5rvblyz34@fs>
References: <20211130141112.78193-1-fs@gigacodes.de>
 <20211208163335.1231795-1-fs@gigacodes.de>
 <20211208163335.1231795-9-fs@gigacodes.de>
 <xmqqsfv2wuo1.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqsfv2wuo1.fsf@gitster.g>
X-ClientProxiedBy: AM6PR08CA0044.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::32) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6PR08CA0044.eurprd08.prod.outlook.com (2603:10a6:20b:c0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 08:36:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d64166-6733-4a31-b7e7-08d9baeef74c
X-MS-TrafficTypeDiagnostic: PR3PR10MB3897:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB38970064784649C4724AFA4AB6709@PR3PR10MB3897.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjV3qeTPlnjqJDyN10JMhi0aiUzlU1ucxpfLfhnaI4SFEHyO88wJ3eHLtTn/lWg9XZn5DF95zbeQ4liFJ3DeYtJ4z5avjJymy1kGmOV++hKrfyOqy8kL7v7vqFhrbm1kveUCmF3sn8IRO1nQPednmVYlA9emEBj3c8OQs8hHM+y3bEai+evDnadpsdKNVY+d8xJI2VHC4RFqdqxEFFtExZVBRNuBVNjgT7U0c9rkZbxyk+1+hO8/o5J25UmEMdDFNUTovmMeWvOnLJoUEhH1btPnd050qSeb1h2YnuGcS5wnAsEsJtBHiY5S/mgAY4tLHWUCpn3PuRe88irJlOoQwrSGFOp+WJ+CextmeyWL7waxsSGuyBSCED6SpjLbogtHdBYhpJQxY75mDYJNMfNejjRpWBmRo2ddPaAyjWaQyjfFP2rflr/wXIYPyaDfRnRtnFpv3Az/FckvH8Ds2jqtVBTSzwZFhfTw/TcYA3xKa4qErW5uD9mw+4qdBwKhQbE367POAOr9H7xxdBTwNczVcWX2uVc2QHUCBZdQHndRMGxIVXgB6l98NW1haFgH2bzA9K56c9aFW2x3dgszmXiPqCGU0CPobsw0KR+X/qRCxB7StpqS6XW4eCUlwwWHC9/iWNko3psTv7PrRUeW8TQnnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(136003)(39840400004)(366004)(346002)(376002)(83380400001)(1076003)(53546011)(2906002)(508600001)(6486002)(8936002)(86362001)(38100700002)(5660300002)(66946007)(316002)(4326008)(33716001)(186003)(66556008)(66476007)(54906003)(6916009)(9686003)(8676002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RURHY2FxaGtmaWtJeURXRUpSZ251VnNwZnhkQ3pTQ2FRUVpudzQ1UkgvUS84?=
 =?utf-8?B?aCtubXhHcm5HemJlT2toQ2swL0hRWG1DVk8rVXhMUXVFUGIyMDdwZXlQejc5?=
 =?utf-8?B?akRXa1o0WVFlS1pER2RESjV3QTdVTWFqanY5akVIbnJHOWhmRitFdlp6Zmhm?=
 =?utf-8?B?eFVRQTdDdDJrZENJZ3ZOdTZ2YW11TWVOeFN0MVhSakV1Z0FPY0RvZUcwUGlw?=
 =?utf-8?B?WEFDby9wS0V5NDJaT05MUXdVemNNWld4dGFnaElrRUhhYlJvUnFqVEQzUVdh?=
 =?utf-8?B?YWlhMTBVcDVMSjJ5YUw2eXVGMmJ2cjZONFNyaFV5T3BIZ25PWCtMT0pVakR5?=
 =?utf-8?B?Lyt0NFpuU01qM1lCazBSSGdhaFQvSlJSUk1URTZ4Z2RTVXlGNml0TStEV3lY?=
 =?utf-8?B?WVVlcHI0UzBTMWk4VFp3TGsxYjl3Y2Vlai95WmVEWG11V3NBS1VwZmx1TG03?=
 =?utf-8?B?TmlGK0pkdUJCUmw2R1NhV3Ywbk5NeXJsb2ZBemQ3Ykp0VEhMS3VZYlJLYjJi?=
 =?utf-8?B?bmpMVkx1L2t5SUt1UStJUU9EL1liV0wrR053Wms5SHRyY2l5UUk1V3dWMDlr?=
 =?utf-8?B?VTZQWjUxSHJJUVpKam9lNjdWaFBnK1ZzV3VkUXh4c1Jyc29oVTVkTkJUNWVN?=
 =?utf-8?B?eUlvN0kxSytIeG1qTXd4MFh1WjM2L3NrM3QvYkJFa1BsNHB2VnJYQll1ems5?=
 =?utf-8?B?VW81eTN4Smp2bFVFUi8zK1BiQldKaCtOakdmRnZ1M0oyMjQrU2ducTdaZnhG?=
 =?utf-8?B?TmNhZmVvTXQ1cThDdzJ5R3RYc25WdTJhb3pkeXlLcWFXL3JIbUhIVFlLNDNE?=
 =?utf-8?B?aEhVVmFrMmhjclVKMVNIZUV5YjlJTU9QOHRsQ2wxZWpKaHFUTXdLazJhaE4z?=
 =?utf-8?B?T1NvOEh4Q1F5ZUdIRi9LemdOYzVPL3I4bGVUR001a20yeGdWOWRzZ28yTEts?=
 =?utf-8?B?K0YybTN1cXh2cVRMQWtQSDdtU0FCL1BIaEsxQnZvMW9MUm5zZ2tpWE9wcWpu?=
 =?utf-8?B?QkpLb2Rmbm5kK25IOER3RjFiL2pUajBlcXJWVEZUbnlDR0pBNHVwOWVFMkF6?=
 =?utf-8?B?NlBGbjc3bmZGSGR3ay9FV0pCc0x5c2c0dndvbEtwUEY4eHgyM0RmdFhoWGNo?=
 =?utf-8?B?dHNveU5XOTh1K2kyLzZLVkRueUsvbnMybGpsV2xhUTNHVmVxYVBhN0Rrb3dW?=
 =?utf-8?B?SXYyQ3IxSCs1bjB3andzT2dPMFBuc1FEMDVzd1BlNEQvVUdxSjQzSGVLSHhw?=
 =?utf-8?B?N2ZpbDNkR1Z1ak9uY241OXdxQkZleGU4L2VuMGVmcGxyb082dW1aVktERkI1?=
 =?utf-8?B?cjdUL0xtd2xLQ1M5UlY4QTU1WHp0Q0M1ei94NXVlQmJGQ1hSYk84RkRsS3Vr?=
 =?utf-8?B?eHlDSWp2YnIxNFQrTysxdXJRRzZ0Y0dPUmg2Y0pra3VuNXZzODZ3NFFmdnEz?=
 =?utf-8?B?QkE2dXNha1lSQVJIRUdsY2xNM2ZZdDNrOWFLdWlnNHZTK3p5bDBUU2krWkZq?=
 =?utf-8?B?U1JaZGpEWEJ2RjNwendVcmM3c0k3enJVZmZrTUtLVnJCWHZEQ09PWXhDb280?=
 =?utf-8?B?M25QeXYySWxGd3AxdnNzZThoZkFpL2ZxZXVvbXpUbmtzNk5IZ1N0a1BKdjdZ?=
 =?utf-8?B?cEs5UFNWdzF2WUxwQzRhSGoxalQ2WTNrdWYxZjZ1TTg3UUQ3NjNuUXI4RTli?=
 =?utf-8?B?YnV3aE9tdEVPaDVKT1B4UkEzTTEwVm45YVpRKzkzNU8vbFpjNjBtVEFDT3Iy?=
 =?utf-8?B?MS9MWFZmZWxPMFFIeHNXWm4rZ0VlZHVHQUNWZ1FNeFNjR05EeTB1QWNJZUtt?=
 =?utf-8?B?QzVRMFNlbEF5dDFTYklSY2E2eGFBWEhGR0huaDJHVWtjZGtEUUJTVGRDZ3N6?=
 =?utf-8?B?RWxLc0kwdmV5Zlh4ZEZ4eVdzNjlxK1pBdUpVTlZESGFWS1YvMm9FTnZwZFh1?=
 =?utf-8?B?b0xkU2VsTHZyYlJrQW13NEhTbnVMMTk2QTJqUWlrOEpDUmUxcWNxUVlkNXNX?=
 =?utf-8?B?cjdlL0FMZWplWG1YQkZLQzl6dUl5OWVJWGJKVFdOUVZxQnFMbm0wRjVpdUlO?=
 =?utf-8?B?NklQYkZLVWk3WFB4NE9namdGa1BQWHJvNmgwd0RMd2tlVUp4YyszTmhTbk45?=
 =?utf-8?B?NVpTUjl4UzNjYUd6c3FZZVRQejBHalBlaWlLcGRSTTFPUlFkaEEwWk5YMkhB?=
 =?utf-8?B?SXRLVUZRWUJmUThVenBHRGRoLzJrQ2gySk5yYXBSck1lR2NpM0FkK0x2M1FN?=
 =?utf-8?B?bmhqMFNyMUNLWXZrdXZmalhXZUQ1cW9KMHhSUjR1ZjFQREJoRWE4a0xac09l?=
 =?utf-8?B?QzJHcDlUMkNINHJHTmxwYlVhNTRzNVZQU2lxZ2pjeEM3OEhxaGFOUT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d64166-6733-4a31-b7e7-08d9baeef74c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:36:16.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNnex3ct/ZVA5v75ytMHnlj98isyoCCW9tvMX5X12hCzkFQAAWZIzC2yFX+qELtDFYM888UUo3sRvv/VIEidfZQjprhdIVXCO40MzW79PDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3897
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.12.2021 15:20, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> All the GPG, GPGSSH and the new GPGSSH_VERIFYTIME tests are redirecing
>> stdout as well as stderr to `actual` and grep for success/failure over
>> the resulting flie. However, no output is printed on stderr and we do
>> not need to include it in the grep. The newer SSH signing based tests
>> are also missing a grep for the merged tag to make sure the merge
>> message is correct.
>>
>> - remove unneccessary 2>&1 redirects
>> - add grep for merged tag to gpgssh* tests
>>
>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>> ---
>>  t/t6200-fmt-merge-msg.sh | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>
>The 4 hunks at the beginning seems to be a clean-up of the existing
>issue, but aren't hunks -162,7, -170,7, -178,7, 187,7 "oops, we
>screwed up in [6/8], and we patch up after the fact"?
>
>For a new topic not yet in 'next', we'd prefer to pretend to be more
>perfect humans by not deliberatly keeping mistakes made in an
>earlier step, only to be corrected in a later step.
>
>While there may not be any difference in the end-result, it would be
>cleaner and less sloppy to have the 4 hunks to fix the ones before
>the series as a preliminary clean-up step, and the other hunks
>folded into the step that introduced the problem, no?
>

Ok, i will send a new version with the fixes for the earlier tests in extra 
commits.  Your 5.1 includes a +"grep "^Merge tag 
${apos}signed-untrusted-ssh-tag${apos}" actual &&" fix for a preexisting 
test in the first patch which now claims to only remove the stderr redirects 
though.  Also another grep for the merged tag for an earlier test got lost 
somewhere. I'll send a 5.2

Thanks

