Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8E7C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 07:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C4560F9C
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 07:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhJYHeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:34:05 -0400
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com ([40.107.21.44]:43360
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231162AbhJYHeD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 03:34:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip2ZNYOzDEarKWz7DeRvNkNdeXCv0wmUkNdasYJ2DcyBNanm+3Y0RKEfJjinGdRIIUy9mCQrkd2YHUniN0238jjqRo8vFCEN7e3nuS5yWtUm6Nik0UeYZ2tjNnp8bFufml9rAgXhHYca4cjeLnVLstHMtxcH3rbz83TWdWGRnLrc+WwpZemSgjLeR5w9xpbKpujKR21sooYqUjmYu6Cit2QONjLSYW2pkmV2UYt0pJYrVHx6QrRL59E7XDvsxV/zsoCnzkpAMgpxBgXAbQ5GMqunLkCPdI+ut7fMSV70EZ5sk727EIrWhCykHUIoUMnapZQ+kqpGL7FEYOzprZ0qyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ9eu8p6meI5fflkS31ImNeAAftpnG2bsXPdf5fSm34=;
 b=i9fmZvAA4ljEDeWDQfhDHXQQRnHiP8EjTxHGBRdCWkdbrwxbBoqFi4sRjL8qQcpAVOcqJ1oYFdOyHJ+adO2UkwlWVdOkGcjMLDeBLi6zHvQ7tNseLa8RveM/9Rzorhm6aQOZ6LOZgR50yzDoFDMqOCclexANEXRZO8rmhTy4CafuGoTP1UucscRwb8rIhdAzQPzLfKB5CtsU6GAh8S82H72dpp8thEnCwDTxpE3dicsaUCheQSYRop3hSoWi/KxF7GY89y/a3FIt9mtnLwXrLLWpKUciNWg5zPRgKJdG9XMpiGo8nVs9FHR7GeFzE3aV8QmMMegJRw9Z0Xal2JXPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ9eu8p6meI5fflkS31ImNeAAftpnG2bsXPdf5fSm34=;
 b=FPNMeyTyXarUOfAX510Veoce4Z9/WLI38Ms+AtAn5xyL1ylt5m+PBedBcEzoTMayE7NhxaKfe5409TAwZBmsGQrafKLDd8/bgfxbT4WiHY9DUDvATk4zqSxJZPku/khidtQE9piIe1DlPi2sWfgedy6U3Jox/elKxGF00FWNwcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 07:31:38 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 07:31:38 +0000
Message-ID: <8661a491-5ef1-a469-878f-7dd81d4a1aa2@gigacodes.de>
Date:   Mon, 25 Oct 2021 09:31:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] gpg-interface: allow selecting key id with env variable
Content-Language: en-US
To:     Marco Beck <mbeck@eaddrinuse.net>, git@vger.kernel.org
References: <20211024193625.148-1-mbeck@eaddrinuse.net>
 <xmqqsfwq40w7.fsf@gitster.g> <YXXMroOBvDERXIMP@octopus.int.carobme.de>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <YXXMroOBvDERXIMP@octopus.int.carobme.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:203:2::29) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:c042:75a0:fd5e:1472] (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR0701CA0067.eurprd07.prod.outlook.com (2603:10a6:203:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.8 via Frontend Transport; Mon, 25 Oct 2021 07:31:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46a9c519-c3c8-4314-e9f1-08d997897b27
X-MS-TrafficTypeDiagnostic: PR3PR10MB4173:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4173B36CA5F8DC0B4CF0713AB6839@PR3PR10MB4173.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqog6Oigd58ir6PC0Xq6N9+hxCy4CQ018ebqeLF7m59hu87/S2WR1+VcT3jnc5r9sJtyuvX2dzFi2NghFWuRdsj307D3I4Cv9uKmqcX2bmLhHkdcSJk1NRM6kUD2NaBDTycFqBmGrwt335byuf43fbX/Bow1QfYX0W9kHnNkbu+ON89odV1MT6N6hGvriXDNfWV8srcCXsXBpWdJ+krF+alGqCLNQLvAIlEBmDfT8UZryEMkLN0E7MP9hLcb/fwTtFnrhLfLHTXkIajrewymqME4UjWnuwQAZU+p4U+aEs23H0Z3Xhv3RIrNBmFKuKWLFZHMfq81tCWhPhbRVr/fa+E535EAtCLMztdhAfdtnj8nRXYmOSLMcWN5TagIje8MOnAIgUC0ltnJktCYucPrqaJHDGOhNCKQqbUIUx3DtpBUG0o10nFjq7AaUm/5SbFrj6+blmaGqqBVTRoe8SiXap4DmBskdh89uOZ7nle5KcGOT54ry6a+twDb1KGk9MgCWuEV14v9sGVx3PqGKCnXKQx98+4MxzzP3KrsHX7Xb6u0A2ZMMoKX7/N5JhrkfzDEbSYVxuhBVaVVNIKxysLkDfh02VKUHAR709opGEym2hOl2koSh1mteh27ELBOM0NRam7TQBSscpSL0dVQEDQuBBDRtOepEDf9MwQCyp6Xu0DNz0YZ9J2jOp5X5k5JTdwovcGOXbjQyAXhbMX55JjI3KzCIwsroJaEyua5rzDmiW5aLkOZWVyXLocoAH6zZgpZBXlllUV1k39jNws/wTPbwneMdyMvUvlPaO7lJYzQhZ22YiNeGV+X7bd4/wtIerZi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(396003)(136003)(376002)(366004)(966005)(5660300002)(6666004)(83380400001)(31696002)(86362001)(53546011)(508600001)(186003)(52116002)(38100700002)(66946007)(66556008)(6486002)(31686004)(66476007)(8676002)(36756003)(2616005)(316002)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGIvSW0vOEFaaEMzOWZiVk0wVWZRc0hBWTk5MlZwYjFyak1SQUd3QmwwRi90?=
 =?utf-8?B?V0lFeGZoOHNyYnhUSks1L0E4TUx5NE84bGFQM0RXRXE1dm54Szh3aVpVa3BR?=
 =?utf-8?B?V1ZUa3hXUVYvSlZoRUN3K0tpZDI3bmFBdGtldTJMSW5yM2dOaC9TUXpuTkMx?=
 =?utf-8?B?bFFKZGc0aERTTlNyVTRjL1hrVGphMHl6YktuWUJKc2x5MHVWa0crK2FzWUlh?=
 =?utf-8?B?MWhUekpWUFZDRURwYVBlWXVxcldqMEVEMm5MNEtXaEJlN2xLZVpBVUpaMjVZ?=
 =?utf-8?B?NWkvaWhMTFgzSHVNZXR4aFllbkozQ3BUcG84bjRIU2lHb0tvclpPbGhMYUVI?=
 =?utf-8?B?RVlqcWRYU2MyOVNqYXF2MmRxUjJjTGlJWngwNzZhUE02TnEyN29pZUpXYVlV?=
 =?utf-8?B?NWV5OXdHWVRKcmRlR2RrRnZxQ0dkcm4xa2taOUVyZDFHSE5tYnk0R1FqZE5j?=
 =?utf-8?B?UkFsMERpN0tpVVRpMmNJTUNuVFphSEI1dm1EdnBlWVV2ZE5EUzJGOXpEdlAr?=
 =?utf-8?B?bTlWR2hFY3lTVEtrN0xrdDJqKzlLc1gwMjd2YU1HaVZhTk8zYkNnRndmdm5I?=
 =?utf-8?B?OHpvRW1iT3VjSE0wMGx4L3RCR1BsVmZPbzNnUzBXdE9KbWhxODNjSVVRUHhR?=
 =?utf-8?B?aFpqNHdzcVlxenptRmc4R083N0VSOUZCb3VobEdSeTdpcnRLbDYwUzNDcVBN?=
 =?utf-8?B?RnZrNDBNeVRiS3diV2ZpdUludnlHZDEyQ0h5Tk9lRmxqYUUwWThHZmhJQ1Za?=
 =?utf-8?B?TWdkUDlja1h6T1VDaXA1dHRreU54OWt5VkNJQWJVV1BRamRITXp1b1ZXT2xm?=
 =?utf-8?B?Z0Q3Q3R2V2R6U0VleGlLc2x3dVIxMWVRTENFUlp0QUF4Q2JUeG9KZ1JlYzFk?=
 =?utf-8?B?UHFxVnVrc25jU0VMZmJYTHBKVDdzRnUwb0F0WHBOQVIrbFlqRGprL29Rbm0r?=
 =?utf-8?B?VnNxajdnMXYyaFRaNURiYVBKUERzcW8rSlZTbnpTeFFIUW5EcStYNUE1dU96?=
 =?utf-8?B?cW0veGgyb2ViR212NUVIMG16Q0FseUNMQnVDNWpoc3JlVCtESDRUbEUyWlpo?=
 =?utf-8?B?YjYyRFhDNHRvQjhISlRFWE9maGJGMnlmK1lzSzJ4bEoxeGtveHAzTE1RR3o3?=
 =?utf-8?B?T2JOOFFjMTc1NmlOaG4vdVUwUW1tVnRqMU9KOFlpbmpobzlGSkhOejl5ZzE4?=
 =?utf-8?B?WTd2NEFIUkp5NGJWT1g4UlhoanZvdWRKWlQ1aVdtYllkZHU5VS9GRDE3RWRu?=
 =?utf-8?B?SlZ6MGhKQWpCMVp5bXRrbHJhcUNlVnFMelhydjdza2UzUDM5WjAxazRQaDFS?=
 =?utf-8?B?Vml6dm1IUTFOck5hbHpIQlFheUhxS0s3a016bHVNdWdOdUhyVElhUUEwOTZR?=
 =?utf-8?B?Y3hFY2VRekdXWmxmaDhTRDhJK2VBVjJKMjRkLy84RzJYMitRNitmSm1HT3c5?=
 =?utf-8?B?YWtzUUlUNnQxSHhSczNRdkRXM21SM0NxUlM3SGFWRFdzcEd0WFJKSVp0WS9h?=
 =?utf-8?B?WGwyUmpWSjZ0NnVrUDB3L29HSXV0TElIZWxUSEUwcVZzdURBY1BYT2J4Y2pP?=
 =?utf-8?B?d3FSU1pnaThNQytGRXdDUUt3Rml4QkZIMy9wSkNvLzNpaXlwSVFQTHdzZTJo?=
 =?utf-8?B?REZTbHIrb3RkdkR6d2E0NVFiVFJaNXAzd2pyMjJKSnFXMi83R0FRVmhRWVdH?=
 =?utf-8?B?WHZnMTlTa2dGZjdvN3hNUFc0Kzh1UkhXZ0pxak9vMWpMZnVNSFdZZWNoYlly?=
 =?utf-8?B?MFF3QTVwMjZ4YmZGaGhzSDNVWjlOYnRPUFZ1S0daL0IwWXh0NHlaUE1scjZP?=
 =?utf-8?B?aG5vZ3J3cWVaOWhDaEVsV0xBMWVhbzMyMmMrQ1VQYWF1a1F1UlBiSExkSlJQ?=
 =?utf-8?B?V0FJRjZydG9GNkR3ZWdzUWFhK1BOVkVjalYyRktWMlNEalU5dEptY1FNZ0hp?=
 =?utf-8?B?bmZPV0tCTFRIYWdFVk5TMjdpWktOYVBNUTBmN1I2eGpBOGtrTDN1Q2JoVk8z?=
 =?utf-8?B?UHZydDEzUkY3SHBjQTlIbWpPVzFVclNXMlRjUm56d216bHJ2SFVjeW9nVU9y?=
 =?utf-8?B?L1R1NW9CTUNreCtQbGRtMUNTYVR1UHFCWEN0U0h0dENJQTZMWDU2UXFPQk8y?=
 =?utf-8?B?bzU1em1mQUdFNEcrbGxuL1I2YzkvNFlNL01zM1c3d0hocEduUVI2OTBxMlIw?=
 =?utf-8?B?YVlWMllQWTYxUTNWSjdDNi85bEFJTjRwaVdDTWJJQ3QvdURFV0I1R2I1WWFK?=
 =?utf-8?B?SVZxSXN2TVVPampHUE9pZnNSRWxqaXJjS05OeVEzYUhRRzZkdjNwdTJzbFQ1?=
 =?utf-8?B?emdWVTRGZmpKZ243MGhzWHB2VCtScTNPbVBraGs0TDlLcVpUOSt0QT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a9c519-c3c8-4314-e9f1-08d997897b27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 07:31:38.3895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXFLgm8poYPtmKGYI56Z8gFZGglZ8u0MQeiq10b8EvddVdPe+aQ59X5xfx7YoV+tuYh1SS+xHeINtoZRPCB9a70bVxe1fYlb/7TiVLsteYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4173
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.10.21 23:14, Marco Beck wrote:
> On Sun, Oct 24, 2021 at 01:35:04PM -0700, Junio C Hamano wrote:
> 
>> Can you explain why we want to add another way to specify the key?
> 
> Motivation for that patch was that I usually use the same .gitconfig
> (all dotfiles actually) with multiple identities (e.g. company and private
> email address). It's really convenient to switch to a different identity
> for the rest of the session by just setting e.g. $GIT_AUTHOR_EMAIL and not
> needing to remember adding --author to every invocation of git-commit(1)
> etc. Thought it would be nice to have that convenience for selecting a
> signing key as well.

If you only need to rarely change the key to sign with, the commands
usually have a direct parameter to do so:
git tag -s -u <keyid>
git commit -S<keyid>

Otherwise https://git-scm.com/docs/git-config#_conditional_includes
might be useful if you can store you private & work git in separate
directories or only have a few selected repos per identity. Put all your
defaults in your .gitconfig and use sth like:

[includeIf "gitdir:~/projects/work/"]
  path = ".gitconfig.work"

to override them.


Kind regards,
Fabian
