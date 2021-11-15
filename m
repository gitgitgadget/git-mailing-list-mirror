Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EC6C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C32619E3
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351710AbhKOUge (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:36:34 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:58531
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348687AbhKOT7I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:59:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWKGyGxzz54x6L6PtvKvdu1TD6IKuBbsgfhDaquc3tUArOv4Pm6bw8XJWN6y03vYsgaCRtim3bjtUMUy5K27n8+iGp0iO0GvrnwLCec1gWfKforxrYNavy7BCGEfH7JZbaTfjhA0nNsm7JiCFGwDZKEcHzf91Zk4kNhrwcs3aFVa2BHSqBtViGDv2V1F3sRj+TjPiY8Go61PrOhV0tgCuTqwXOuVpIZENyDRowiKYoP9d85+R9PS+hpl/aoJPm28YklFjVsSmKUxyYDLNM9p1JE6UweG7DHgKuYOA6K/GnsdyzDIkiKxJ4cc0dv7w4peVxb2+xo+IYJuBg8s4L1/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB4IS43g+16S9NbBjv8QPCT+vNJVZSii+gyn0rZFjkE=;
 b=GDWHcacUfo45aAkUXMJ7hWwClxqILsLBchNyA8CcF0SStlGVuZTfkdynfQpfpQewW/ATuxfFxpcYs1wfeHmPP5g9KBPZRUU1JOgTyVHNPvgnxqyAjQkEbXu9vzEZAmo8dsvvfv2Fo26WzfT6DDiFgNXudt4l+QuJv1v9mP2WrVoyPDZXjFDypwTeqQ6s40moNaz05iW81gcGG7v+hsqegVmdMI+jsrCKz+BHZY2SDZSA08+Mg2r8v/6pJxagnSstW/iTOP6x675T9Pv3OId7LRgih1DraZpwVy+LMMf83RExRWHzZl1ngLS6dWY7loIpCosGi33lToktH7xxgekbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB4IS43g+16S9NbBjv8QPCT+vNJVZSii+gyn0rZFjkE=;
 b=XUUeh4HqKLHfGCn4RrAH3iQhmT6J83Xivqy4a86K2nbLXLgIHT+Usl1nAOnuFc/XRGlDrQqV9WLq+Ozd+GLTFdkYpmucI74ZVxAxH30qrVmwzPsk/Rn5tfvqLBQufG1IFpRJvG8VH8b/mNm3Tt6hDaK2R7VJcogOmYzJIZ21L34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3884.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 19:56:10 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.022; Mon, 15 Nov 2021
 19:56:10 +0000
Date:   Mon, 15 Nov 2021 20:56:09 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib: show missing prereq summary
Message-ID: <20211115195609.g6vq6qfjhyootcqt@fs>
References: <20211115160750.1208940-1-fs@gigacodes.de>
 <20211115160750.1208940-2-fs@gigacodes.de>
 <211115.865ysts45o.gmgdl@evledraar.gmail.com>
 <xmqq8rxpfgqh.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8rxpfgqh.fsf@gitster.g>
X-ClientProxiedBy: AM5PR0602CA0002.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM5PR0602CA0002.eurprd06.prod.outlook.com (2603:10a6:203:a3::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 19:56:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d49dadf-752a-4a9c-1750-08d9a871f868
X-MS-TrafficTypeDiagnostic: PR3PR10MB3884:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3884552BB9166A113E3FCD6FB6989@PR3PR10MB3884.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqnKLSsWY1/+SNUVx5RQG0ru8HplqP5mjrjm+kcds/lgum3n9+H0e56msqVJ4yjUhsZ/dFfxYlCoq0VaHNGT/vqeTsVMnFjIHiG/cTxIHoRoiVS9jB0ySGEaIf5Du7MSGHi2hqTUeu0+bCuEQoCKuATeKyLdSzSDHQbDYhuwq4NfCOx3+QAa7ummMZdgcLW5GOX9wel+WVN3R9xYQS0aaUGaZSvhIlcvO0iDu3axFjGg8qy/t57BUvgf6wausbulW8cV44Cne3pZAMZWMdP11UzwWxW11UeQ4le+3eJf1Z2MrbWdvlNLBRmPE9USMg4Y22WCpT/QgRPU9pMO4mk52DA50RvDUFOqS806gW4hKAStnOP4UhimES5x+gGECAeqOzDYLxXWI+V+vXQbcUPTj37CrAAMIIs05OHgx/QqsqMKjJseMyFHZ8VoRC59+KNuxECT4ImIdrc2x8G8LpsTZKjIm/zWkVd/j1V4tXxBVzrQhGjjq1EJ6NmXbLuIN1BH05UTkqJOBpQkm1czUXpviHJgzrzmWHgjFbBDo2+/MZvJ4VizGidpLNSI68KOczTkSH1Kyc9flXiy5K4Qcy9etNa0/kjSO582jKFwQUbun8owGw33V2hv5WxJVvLsNdS4yoV8pGVvFH+TtT5M8LuPSp992Bfipe2W20+oE9P95rnAcRMFsWJEDSMpkx/zeIVoIJo/a01BZW0/miKmGeGCFzncAvDAJz7qz6lcrcVe080=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(346002)(376002)(39840400004)(396003)(366004)(6916009)(316002)(33716001)(38100700002)(508600001)(9686003)(83380400001)(186003)(1076003)(8936002)(66476007)(66556008)(53546011)(6486002)(54906003)(66946007)(6496006)(86362001)(5660300002)(2906002)(8676002)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0JOMzZtejBsTVlXZGpvRklIcFpudDFJb3VJa2J5RVdtZEhiZitXSWNObmRT?=
 =?utf-8?B?alQ4UzNEYTd3UTlqRWFyeFlaSkxIR2xxTnptcWdnUE5oUWUraHFNYjRDK3VH?=
 =?utf-8?B?bm5YOVV2WGR1MVkvTExlYU01blpub1llWVlPQ2J4cGdiTVBnK01KdlR1RG05?=
 =?utf-8?B?ZmZwd29yZnNLcUFRWENPckZJS0hrYmQ2SVZBTDNNUTBYdTlRTkhoZEdpME16?=
 =?utf-8?B?cURrQkFWRjVqaS95MVVXUkVvUkdxMUV1OW5lMUdYNzgwWFhoYWdtOXp0TXor?=
 =?utf-8?B?cUthd3RxZ20xU1p0b0Y2N0lrOWtjMGR0QVJUa2xudVVrek14MW9YWVNNQTAw?=
 =?utf-8?B?ZlpqUkJtdUVLYXVMOGpBclVGS1NMVmpqUnEyaVhXNGdJbWtxaDh2SHA2ejlT?=
 =?utf-8?B?T3VZWld5MEljeURPaWhkRkJZOW9tRHhUUTM3czdwY1BvMDJQV3hiN3FxS2NC?=
 =?utf-8?B?R1JoK0lqb1hqMDdxdkgrM0tHc0Q3QSt1WW9DS0t2UzgyYTdCaE9aTC9Ka0k1?=
 =?utf-8?B?SUhRL3VRVHFDc2FaMjhaZmRLRlJLeTE4akoyMzFXR01HZ05IVXMvL0NxNmF0?=
 =?utf-8?B?cFVVS1Nad2VCSDA5K0luNDdEOTdOMUlTcS8vUHlMKzZ0U3lsWm9UdzVUWU9q?=
 =?utf-8?B?Mm4rek9FQ1ZEcVkvSVFXQ2hDVnZKY1hjM0ZTK2VsTmJyM2FjeTQyR0NpdXF2?=
 =?utf-8?B?dHkyaG45bEFILzUzN0crMnF0RXZINDI2dWdSNG41cUsxY2NOTm04bkJGb09v?=
 =?utf-8?B?cXBJMHJrS0VwMFJyMGw5alFEYy9SNDhqaFNUMmtXMFNpWkhLL3VDWFhzc1pT?=
 =?utf-8?B?eHNsaGtDbkZnNVZmaGpKNEdxSUJvZDA5V1RRVTk2eTkxNWZib3E2MUF5a3Fh?=
 =?utf-8?B?T3U2Ym1OKy80OGNSL1JuR3k1V2NiaVpUS0syZFZxbnpyV3NJYzRaeUNvQ20w?=
 =?utf-8?B?SGNaejVQWlRGZGVpMVlsRVdUanVIRXlLdVdySTU3SXkrbGM4b3YwUnlGM1dF?=
 =?utf-8?B?NmlQUGU5Y2lKRkpUNjZzeU5VcW5neWdxK0w4RnVWOUYzWGsrcVVCQU4vTXR6?=
 =?utf-8?B?dHpyeUthTnBPZ2VwTWkwcHFTL2UyZGlBczVJSEpsV0QvemdTYVNoRUc2d3FK?=
 =?utf-8?B?Z1pXSzVqYnc1OHlTTG4rSVU3MlZCWTJxbklDQjV2KzY1b1J5ckdHaEh2K1lB?=
 =?utf-8?B?eEsvN1pIWUFzb2MvZFlKYjNzUTk2ZGI5aEtZclloT0s0YjJzSmdNZk54enln?=
 =?utf-8?B?R01yS2lSL2llTGcrSzZrdndOWjBPQy9wSlJOTXlhbTFWaytZQjFlWVVGa2RR?=
 =?utf-8?B?WTJmY29RQXdpZkJpVUZxKzRYK0I2cHNtc01relZhdVZGak1VckszTzgxZEk3?=
 =?utf-8?B?c0NYT0hmVC9GZmZZVHByM2YvRmkvc2NjZDVTa3lSU0MxWkp6TlBSMUplQWE5?=
 =?utf-8?B?bCtjTFFlWDM3RDhuS0hoOGExRnZNZ1htMjVWUERPTWRFS1BHaDhYMjJORmQw?=
 =?utf-8?B?ckNMS01JYmRuVFBqRHhnVTA0VU4wNzRMWW5YMDdTcm1oL1k4d3NUcDFha3Q2?=
 =?utf-8?B?dkdPZTUvQnF4T3plSVRlOWt5ZWx3UURlaXVXbS8vS2ExTjlnMVliZVgwUWov?=
 =?utf-8?B?N1gzSzYrOUtJWjgwbnRoT3BYakVsc1BpNGFlaUdwSmlQTzRIUkJ2eDg3d2Zr?=
 =?utf-8?B?bm44TFNGd3VyYmJoUkJzMEs3Z0NWMTVMUmpzUWpjT1poRWliWEhTWGkycXBI?=
 =?utf-8?B?dHpxYXpZVkJScVUzbjZ0WHoyV0ZMQ0dPdER5RG92UDhzcGFhVjkwUHpyZFNJ?=
 =?utf-8?B?ZjBKdXF2dDFudDZJcUdmeUExQlp3cnFVSmdublhtOUlQTUpIc2RyeHpXMlZW?=
 =?utf-8?B?eXlLdTZsS0gyd3Q3cFBITjlUeFVEcVZOU2JHRVB2NFBzRm04Q2ttVWtJTWND?=
 =?utf-8?B?cU5lZW55enkvV29tT0dSNmVSZmJ1TW1yNk04c0pLM0VqVmZ6SXgyZ0VBU3cw?=
 =?utf-8?B?YVVIb1BkMy9UZEFIRWl2bGZhdWZ0UzRPWWVjd3RhQ3g4ZjFqKzRHWk5Ud0VL?=
 =?utf-8?B?bTZuN0N4LzBsQ2d1b3ZNalNVSTQ3UXU5STNzREc1U2ZTV3JJTTBsb2ZMb1pz?=
 =?utf-8?B?TVRHMGQ5dzJPekZUNUxhMFpLODdwd3p1UStnYVVxWWhFRnJBNmFMQ2M2VEND?=
 =?utf-8?B?cmpCQUFNdU4za2pZbzV3SUJvUFJrK3JYWUdBSVZyMXlaL2VTRmlHRTF2d2FS?=
 =?utf-8?B?M1kxeFA2bmhMRlZPNWFIMjdqUVIzeks0em5XZHJESEw5T3pFblA2TUdjcVFk?=
 =?utf-8?B?QXpoSU90UW4yWHFadklLU01HWmIyVWtiYlpkOFFBN0pyejF2T3lBdz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d49dadf-752a-4a9c-1750-08d9a871f868
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 19:56:10.3451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Cf0gn0Y5Ku6r8JSCPx3QLVVrpUcohTEwPscREqsbjRacf647kEXYRhluuAa8Etw0BCjHfiYipyifrOK7zSyKuT6iW8vxoT3zy13O/i5pns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3884
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15.11.2021 09:53, Junio C Hamano wrote:
>Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> +if test -n "$missing_prereq"
>>> +then
>>> +	unique_missing_prereq=$(
>>> +		echo $missing_prereq |
>>> +		tr -s "," "\n" |
>>> +		grep -v '^$' |
>>> +		sort -u |
>>> +		paste -s -d ',')
>>
>> What is paste? Some out-of-tree debugging utility?
>
>https://pubs.opengroup.org/onlinepubs/9699919799/utilities/paste.html
>
>Don't feel bad for not knowing it.  I usually do not use cut or paste
>myself and I had to look it up the other day while reviewing the RFC
>phase of this series.
>
>I am not sure '\n' is a good idea from portability perspective.  I
>thought I wrote '\012' in the illustration in my review?

Yes, i was wondering why you did that. When i played around with your
variant i used \n since it's what i commonly use and find more readable.
And i'm by far no expert on partability. What platforms would have an
issue with \n ?

I'll take a look at Ævars generate-cmdlist code and will use \012 in a
reroll.

Thanks
