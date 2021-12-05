Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E6C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 10:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhLEK6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 05:58:13 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:19970
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233007AbhLEK6M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 05:58:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3dBMtgwceLr0pz5I1ZzOmR+PGEEEM96HibxkrCWfDjOAxC7o3pMEKFupQ1uTLp4X63l669uLmOXfD9EQaPUfUlXzayhFWukaB/EHAiOnzg/l7kJlNq/wHz1WfkkmC0zSbilGL/ZnUupQFv1nwmn74liWdwGp1C8qa0BwUGcMfyvsUNlO0R7xu+mGP5FARjKJFy2TlGoJihax1EU1Qwg10B8I4EDm6Q8o0FVAXaU4nprSWdt/XQ81+ZFgyxS1PZOseibHovgcg9WlvxxOq5/Dcaa8vyanIxzQjGBlABYULqajbHKhsur3M/KLZFTvEnQT03GOf5gN47AEJPJFsIyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVEELwKmiLjHNN3UdF3gjWsoBbNHGlq963Rq9dDM3/k=;
 b=bF7IGKI00Sx2X5APAm+kKQ4ta6nSaeq1uy7KPXJOme+hC4jEo30zCEpxAh3cAQhGaXBhMB40ntv+4DWZDQjbcJm/ZVtgqDao5f0AxmFDybp69ck0la0jDGvbSIlBI/Er7Y8duOpv+1Xttdh8CU9H6HcCd2d0myvmenIKLDHj15R91NWwb5mcRNdhcCnDeMTF56f5B4lS38GX8YP/jYe+dKPFxioZAtiL+GsFqgWsuwFIMUN9bXduwdmfq31FeevaxyU9rp2tqwbNeRiq4RAneBZ3DanPVICKml4CxAqk34K42WH9D0pLB8jJHtgDW2FqKbwlSu4njC/SC2/eKdbOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVEELwKmiLjHNN3UdF3gjWsoBbNHGlq963Rq9dDM3/k=;
 b=jbcN5hDV4d1U2F/J6G4HCuASLGSLOjJwVVja7HRScJKWJyjY1rjf4rdMkua3aQe4AGMH8m95c3TKYZy/hxs1tCSpcMLg29xS7wj+oR35IAbJALkMVnVxSwMWKrz5iso/BmFGAVeQKXxMi5Xz0dDVu5JFe2papYAyzN999PqS37M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4702.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Sun, 5 Dec
 2021 10:54:43 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Sun, 5 Dec 2021
 10:54:42 +0000
Date:   Sun, 5 Dec 2021 11:54:41 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Mahdi Hosseinzadeh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
Subject: Re: [PATCH] githubci: add a workflow for creating GitHub release
 notes
Message-ID: <20211205105441.vsgyef3njcggbzku@fs>
References: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com>
 <AM0PR04MB60196EFE984652ECCBD591A8A5629@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <nycvar.QRO.7.76.6.2111261455590.63@tvgsbejvaqbjf.bet>
 <AM0PR04MB601972377B5CC2E24B6BA1DFA5639@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <211129.86k0grf7lj.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2111301239480.63@tvgsbejvaqbjf.bet>
 <xmqqy252u8t7.fsf@gitster.g>
 <20211203083334.tziwuhbg2u4lsslt@fs>
 <xmqqo85vonba.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqo85vonba.fsf@gitster.g>
X-ClientProxiedBy: AM5PR0601CA0028.eurprd06.prod.outlook.com
 (2603:10a6:203:68::14) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:1f30:d184:2751:e10d) by AM5PR0601CA0028.eurprd06.prod.outlook.com (2603:10a6:203:68::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Sun, 5 Dec 2021 10:54:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79b41491-e109-4717-b590-08d9b7dda48d
X-MS-TrafficTypeDiagnostic: PAXPR10MB4702:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4702835A857B24FEF4F0A9C5B66C9@PAXPR10MB4702.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFW2zrkgUYGGAUOZ3KhKIvkXsXY9idgi1/KUVwfV4Zm22NvMvPu7x/0R5Bg4Ou/qFH839/jBokdjibzFYpsMQP/h06i+uylIt3sIiWBMfWuH9C8gPuB5eoQ3EsmtQcr/QldM8YL7XpMW3r9AMJQpm1gL6nI+f23xAsUHi+Hd/DB8hSNe0Ec1UQYJF60YQJ9UItb+IIm+gCx+Hd8aTkGMyK4KGUCrGLTuNbVl2BhONgIUvK772Y8aJDzKXkyEqtaE3FymGND2exmPy27DZd5a0Prgx76HEAy5FaKKcZ5RAYmwjOjabgezB4EcOqM1/8IsI3d9sr3TEhmd/B4MYcKTKAYk+bftbrK53/saMYcw9aby14PPtTKWFkMLhIHQ6GOSQ3OJBB7fhFCP0yQUqzeCtLK5XffgnScoYtJ51VI0LgcLujpFC+3qRMgxmnse0BlORGniMojvEVkaB02dh/InkG3SLWyBD7HlV2aguWR60PFp6XEroHNtNgJNbhvuagKL5qYuRpN+WqqJi2CH40onWPRs1b6dTEklesOysLBNCW71JfQ16WFhrIvcE6eSDSdllkE68llRiuD1ZVizdQhyQ13oEnEctEqyBhKdjfqb9UlLZFZDFJyI45xI9N4d0+iKmHy7x3xAihymkXgrvwzg7xx7lmPmBvhwcQTc+Iq+egLW0AAB8BAOUvVByqHeKTIoD+EcC85S025l0f6pxVlbrwOUrKiFywMomqhJ323RC6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(396003)(39830400003)(376002)(136003)(346002)(38100700002)(8936002)(54906003)(86362001)(1076003)(2906002)(33716001)(5660300002)(8676002)(316002)(66476007)(508600001)(6496006)(6916009)(186003)(4326008)(966005)(6486002)(66556008)(83380400001)(66946007)(9686003)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnQ4cll4ZzJYamxnTmRVdjVvK29reGpSOUtpOVdtMXdWcXFOMGwwL1k0NzNj?=
 =?utf-8?B?YjRhTmlneVpabFBnWitwR05YWHhmRk4wVUN2QjVQV0V0SEU0TkZCMkcvZS9M?=
 =?utf-8?B?YTRLeDhST1JWRTV5NjRHeC9CTFp1UlkraUQ3MkFkRk5jRm1PYzR5V3BsZ0RD?=
 =?utf-8?B?OVF5aCtzZWdTeXYrYkVkMHRaY0tVa0g0TFdIWjZ4aTdsWEQxOFo5SGUzVCtO?=
 =?utf-8?B?SitPMGVJZW9qbnpVcHAyejRXZnZQRW16ZUZNUUIrOFV5Wk9VWDNtTXpLampX?=
 =?utf-8?B?dVo1OGU2ZFZla0lxeWNsblBwYTRvbHVEcThyc1VmNWYrZE81bVQ2dU0zNVlN?=
 =?utf-8?B?aDZLcTFOMW45azBKMGx4WTh0MkNzZ09pU3p4UE95SkthUGsvaytJOWdneXFS?=
 =?utf-8?B?dE5wZlZiQmQvQWRJNHJHc2o0cnRCcmdOSWtWM0Vad3pReHg1RlBsY3h1R1RJ?=
 =?utf-8?B?MFBxK0FObmZRRVBWTWlMNjdXSktBUUlnV1hJWTBlUlF4dDR2U2NHT0dEeFJH?=
 =?utf-8?B?UEFYK2g2djRSR0p0TGVPY01wM25vbHBVSEdZWnU4MlpQanRzSGM5Z21OSnhr?=
 =?utf-8?B?SE9MZWowTW1pN0lBNFYxMVRSeHRQWSt4YlZwbkRlSXpJUGllZStIY05QUzJ6?=
 =?utf-8?B?R3l4a2tZdGFjOHRuVDhhWXhEMk1OUWkvay83SEZPa1lMR0ZKc0pLcnh2RUQ5?=
 =?utf-8?B?bzJxZ0h4dDY4UHVvUmpPNCtSWFhiOHp2ZXpCdnhBSTZhbGJjc2RpMVJkQUow?=
 =?utf-8?B?NTRJMm02NmtEb09MQnFEWEdRY05aMjlqejdxNUFMaVRnbS9QUm9kYXB1ZEpu?=
 =?utf-8?B?aXM5VmNLQjNWRC9OVzBFQ25SL21QMXRmV21QK1M1MzNnZnlGbGtsVjRWWmE1?=
 =?utf-8?B?SHI1ZFlaY0FjZE9CTDJTbUo3alZzT1ZRbTAwSXpJNi95cTM4U3BITWVpYnEx?=
 =?utf-8?B?WEZMaGE5SC9nZjBGV0lNdStFTGJ1Z2MwL2dId3Y0QlA1aFVBTjNqU3Qxd3Fn?=
 =?utf-8?B?bU1tbCtGa29CVUt6alltYWVkeXRscy9oRlREMG82RHRZQm52RDVRSTRUR1dK?=
 =?utf-8?B?NVFzbkt0WkRrT051ci92KzdqeVJmU0pNOGVXQ0xKZ3NDVGdSWVNmRGZQUXJV?=
 =?utf-8?B?YWtZK3FZVWs5aVkrNGVNS0dHeitCTVJ0NlJOaGE3aWdOZ0dMV0laeVg4Rklp?=
 =?utf-8?B?T3ltSGhYczUyTVpLY2V4ZUtkUDRDZGZIMVhWeHFpNFlRSjRpVEI1Zzc3bkl1?=
 =?utf-8?B?ajJNYW5Cd1hYVTIrL2Z1ZmRkLzlIMG5VZjdteG1meHRCRFhDeldHUFpoOUg3?=
 =?utf-8?B?bnIvQTg2eElNckpxOG5BazVzeEd6RDFUQm1EdEJDazZDamtkM093OWs3UWVH?=
 =?utf-8?B?bzd2SVc1TzZWek16VXl1MERhM09DaEE3enoyUk5jalFrWU5BUmNudC9RRTlW?=
 =?utf-8?B?cWp3YWlnUU1OK3pqU2RuSS9sc1BnT2VKWFNNdml4c2x3K1Z6Z3E1bTNRSnZQ?=
 =?utf-8?B?Vzk1dGw0by9Jc0pRM2xhcXdZb3hYQkZiMzFZL2VHQ2EycXJhRFFZa25TL3l5?=
 =?utf-8?B?aGhSaGsvaVNPUFNSZ1F3UTY3dDVCT0R1SmFVODVFNjlmaUhxNkJWd1VhN2pQ?=
 =?utf-8?B?R21jbmcrd3FCNVRWb2dHSWVxSHl3Nk5EWi9TRjFXMlphYVQ1VFNCVkpiVE5p?=
 =?utf-8?B?VmtwU2NaQUIwNUZheDdzVExOQzIwV1R5bWkxcHppYUNjZkJwakFGNngwTEg0?=
 =?utf-8?B?WTZqMVJLYW8wWGkrTldUcStNczdRWUVJN3J5VmJUMWRzOTVYcE5CTWl2a084?=
 =?utf-8?B?ODVDSUsvM0dNWE5nM3hFYm9hYmQ2eE1zVkZicGRyWHNUOERGSVVCVEZQUGhr?=
 =?utf-8?B?S0NKazh0RlVIblRzMU1iU2RUS1FpSERsZ21DeE9qOUFQTGVXS2lqVTVsMlp0?=
 =?utf-8?B?YlhNekJOdzRsVCtSaWMzYVhhUlJJT2NNTkJVc0tSeS9GTmtablQrdUJVMzRm?=
 =?utf-8?B?dm1mZDRQdVloSnNxOTVTUG8rblJXOFhCbjZRR1drVEYwcE1LWHQ2OXhtRThU?=
 =?utf-8?B?RW9NWVZCWlZBZSthcitrK043L1ZxSXM5UWxobXo5Y0lrWUxLeXF6TFU5eDcy?=
 =?utf-8?B?ZzFyLzNRQUlIemovVW5kZHJzZ0VpekNabzFPYWpkV0hta2NXaS9UODZSZFU0?=
 =?utf-8?B?K0JEYnFDY1hCeTM0NlA4bnYyV3Bxb05vR1FVYWNVWEJXVkVFNUY1akNEMVlu?=
 =?utf-8?B?TC90bFc4TVUzWWdmc29pRTdiSEJNMUM4NlRSbFV4UzZUNEQzRTJiNzJQZUFo?=
 =?utf-8?B?dkRKZ2lLU2tyUm9YQTBLUEVWU1BzcE5NV2hPWWczTU5BUHNLeDZaZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b41491-e109-4717-b590-08d9b7dda48d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2021 10:54:42.7405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlm4lyvrCkpfwjwhgmaBXGQ9SrBmSde16Mkp8erOMaCDSe+TD6qICPH2xJ9ISm3mzeFIUqpYvdOWKOTtbw162HSIZ+88ri47Bicm+CpT0i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4702
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04.12.2021 17:25, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> One benefit that I see is that github offers APIs & Notifications
>> around releases and lots of CI integration already exist for it. If my
>> (non github) CI includes building the git source then i can easily
>> trigger when upstream releases a new version. Just pulling the repo
>> and watching for the tag works just as well of course.
>
>Ahh, thanks.
>
>If some sort of "push" notification is available only for "there is
>a new release" but not for "there is a new tag", then I can sort of
>see why having a "release" would be nice.  Listening to notifications
>and acting on them is more pleasant than having to poll.
>
>Do I understand what you said correctly?
>

Yes, thats correct. 

Github has a webhook for releases:
https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads#release

Getting tags means listening to every push and filtering yourself:
https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads#push

Still, if this gets added to git/git I think the risk of users considering 
the github release to be the primary source is quite high since lots of 
tools and CI integrations use them. I'm not a fan of depending on github for 
everything, but as long as the kernel.org releases don't go away I don't 
think this is a big deal.
