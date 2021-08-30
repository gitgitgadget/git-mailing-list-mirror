Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F1EC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 10:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5198C610CC
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 10:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbhH3KgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 06:36:09 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:4513
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236352AbhH3KgI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 06:36:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqlHsc00e9eqyB358m+ZA5U4zmfnydMK8uWmji+M4OAM0WTfKnaTWS8j7tdypgUH9Cu9fBQDr0Bw8M6VNLKtLuxc/DvoF0oec98gseTjx6KeTm/3UoNGqFmPENO3vo9/nYlLpkvbF4KJ96evo033WJRu1P3lTwnGupHwT9V5VYaYeTXYFMOsZGCYee55lr1EPbuEIRNdP9AkkDgisIp/yZzp9I3CfL2n/zoaXy2KRJIHa0efKU4p8QAOUWF5w52Hv1qszGAfAA20p7vJ2FcqvBJHQVJLa+KM/PkJ3av//C/HnnA7jbDDvapph1fc5BuGBT7vz7alMytq6viEXxXVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mqcWgGpTaQamR28NwOcfY4MebuxwYjQ2kP8/fINfyk=;
 b=ew0oQmZ6xsTPutgkxMnaxs6Ea4G3gJRsHIpZYhqf6sXfIhCcLiHdkg/QfDJc5pS6Veu8AYVmwV0v0VF4nTStfmF0FgdTah5i7xMiWL/6n3WBG0XzfWghCTOaQETJEgoCdW/5p70OV3V3uZ6gesd3Hynp6yYpOnN0MBeXtpvicfx1G5cYX+hwCvYEd1yJiDwd5keqjJKoaSb/Nar8Gflk0VQJGPwEnsp/mxnre3YV7Z/kOrbZjDZjQzdu5ezN6iGr6cn7ucmRdjdT0lJihZ8ckrQdhd33B6X9WEbCqzNpjnI7Lko/5UUspzn92v7iVnJ3onBKZ1l7+s/iIIUCIhnoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mqcWgGpTaQamR28NwOcfY4MebuxwYjQ2kP8/fINfyk=;
 b=A4DywW1S9vDhaBv7XMpGRYabCQYiZXe2bsEOhDaHD0M/lG3xb60eu0IOgm3DuIwtWFDWk5SjBIshny9aj+G1VP2/GF84yw7ze8LnYCwARbvqpORXWPkseXuNFhnNCi52DAEZ+v2TAL+WJ0YIEgveP72Dgh+8eNW16PZKv/zgJ3s=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4688.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:155::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 10:35:12 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%5]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 10:35:12 +0000
Subject: Re: [PATCH v7 0/9] ssh signing: Add commit & tag signing/verification
 via SSH keys using ssh-keygen
To:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
 <xmqqczpv99u4.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <9075cdd1-e34d-5dcb-f2b8-69ae4abf587b@gigacodes.de>
Date:   Mon, 30 Aug 2021 12:35:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqczpv99u4.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR2P264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::33) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:176:e980:2d4e:7e07:50bd:bf92] (2a02:908:176:e980:2d4e:7e07:50bd:bf92) by PR2P264CA0045.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 10:35:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 725b2c89-b323-47f8-5ed5-08d96ba1d915
X-MS-TrafficTypeDiagnostic: PAXPR10MB4688:
X-Microsoft-Antispam-PRVS: <PAXPR10MB46882D45489E339542F99745B6CB9@PAXPR10MB4688.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHr2EIHkTOONdDAAi7G057X64npmFqA+Mx8omDjVkUz8JduMixOAkbfxhgjCubqbBuE0ZLqqz6VoHXmV2MwX+STNqLPj2a1mVsrBQROXMmkJZu/behh1fe+VUpzSAQRxfdYfinmRCrKNc5jC6b2QfsibK1HiIRs0WP+S0SfJX+julzFbemSrh4/qb0OYAco7SfXFIZDSnq0jW/ouzanpX/fhCtihi/QMkwdL2sj6xTr8ALCj2YIj01TAHLqKVWv9VviVepCjwhVirF6IHG4GaMrWuw9BMl3yE+As0zOxGZ5jX6OF5ic0QskWbUbjQK8SMtVBFV7qi/RanOMVlU91jV+3cS8uZZ0v6v2t74OC+D2Oj4a5lKSg4wxgNPU1n11RgS4piT9TWpAj3mT+tknZiaFA6WwYF/fmP/IhnJIi76OmyoBLvNjaM9H7+64FJezgR+gxPfe6oKaBz35WJ7SQUT2gqq9yluLis+P1T4XCMs2XdG/9iwNyPRHjxanZH5uyJxW4vIfRW4TB0S9k21fBLSuUm4NMGBdOILjYK26O10jhUBz/rHdLK83Hd8YgPHpIILbJ99Pbko5OVaiM5TY5sRTgY02FeE9SOh6TYqBz1bhHXwCrDQa/+1mC19DMbLwl5TgQZ2tuqXK9LtwC3E4IkQaEdgCi7xSDuQaUvIHGckAaEK8LeT2/fkHIhTNEl7vt8Nb87K8Xg5B9BG8J2Au/EgxekqYZO4zjLl+ohiXhizrfSlVIs0pZiQE/OSaO/gRiSh5n6uNRaTZUbYznFFvGOLGFho2m3U1rdO3nHvyE4OoC0h5U9mw7xkAaUuVLffxw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39830400003)(110136005)(54906003)(66946007)(8676002)(186003)(83380400001)(38100700002)(66556008)(66476007)(86362001)(52116002)(15650500001)(31696002)(6486002)(5660300002)(53546011)(2906002)(966005)(316002)(6666004)(31686004)(8936002)(478600001)(36756003)(4326008)(2616005)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEwxcmZXV0JKOXdudERDSGVQRVg0U2tvUGcwY21WOWtkZmpXdW1BZjNJVDlr?=
 =?utf-8?B?Y3NvOFlkYVhranFFMWdLTy90bkI1bWRETzVNaFF3VE90MGYwS1VIbEVLb2Ja?=
 =?utf-8?B?ODRNV01jL0ZuRThwRnRJeXYrWE0zTWZGb09JR0FFcUhDaXh3SW5ScXBtZHNV?=
 =?utf-8?B?eWwrVVJVek0rQnFvZmhZYTZSYkZuTWE3bmV1Lzh0WWE3N2tNYTZHU1JMNUk2?=
 =?utf-8?B?eWJnelpiaVVpSlhJNFJiUGlQczRENTVidkw3djRaMWF5eHhmWm93SXh5U1Bi?=
 =?utf-8?B?cnhSaHNHZVpFa01Vb1JlejlINVdaUUUzdnZZYkpuRTBSN05odWM5OS9wVHNl?=
 =?utf-8?B?TDdpQ2IxNHhleFNCMEJGMzE1b2ovQldMYXFKLzg4TTR0aE1pOWE0bG1Ua3FZ?=
 =?utf-8?B?U1R6UFJtQXhPVEY3VEtEM1NYeGlaaHlRNTBQOFFQZDJDSGlBdEdneSsyOFpZ?=
 =?utf-8?B?azRJTTkySUpIR2llSXdKand4a09xY295M0dQYStnb1JsSEJPRE1yOUxORUs4?=
 =?utf-8?B?NlFaaGNKRU01M2g4ZnhZd2t0NjkvK1FUSUpZRHpqMVRNRGorb2ltN2M4VjhZ?=
 =?utf-8?B?WStMR2dPTmVVbkplOFREM3FsQTVhTlphbGNiekZPN3BEZFZjeWRmK1RlSnZy?=
 =?utf-8?B?UUtQemtKRk5mZTlvMkdMSU1vYVJhMGI3OEZSL0JsZUkyV1dvWEdaRS9Oa1dN?=
 =?utf-8?B?UCt2VjMyUENJTVNvOFpEaHU3MnVuYTk3VEpBTFhSVWNpZTRLalFDUGlaaWtm?=
 =?utf-8?B?S04vUWlWenhKd05xRkwrSzVjeDdHWWdZWHFnOTJrZThVd3FDLzFicytLNmdu?=
 =?utf-8?B?THQzR0JwMWJsU2NUa2NsMEFOMUp4RlprQTR4Q3hKcUk0VFFYOXRYRTYzejA2?=
 =?utf-8?B?dUtxZE1wbVQvb1FxcFowSzhYZHNQdUFNcVZrdndoaUF3Qzl6MjhvY0laRUov?=
 =?utf-8?B?Vnc0OW1XdGlVUklCcHpiUm1SM216ZWlybUkweGRieFE4TG11MTBacFVtRzhn?=
 =?utf-8?B?cDFJRytDRTMxOVdBSzZVUW10bVRFT2JBTGxTaHVqaVcvOEFnVEpDQ2tWanFG?=
 =?utf-8?B?R2ttUmRYZDJzbzRnZnFHZnRKcUx1cXFHcjZ2WFp0ZndyVDBtb3RBR2cwQzZG?=
 =?utf-8?B?dzBIRUhTN2lxMm1HN0NUdzkvMFdBd2drTll2dkRLKzFoamdUQW1JM004b0d3?=
 =?utf-8?B?VnNPOUEvNHBJQ2luQk1IbVZtYmV2dHRoVkJKYzhueFcvVVJVRXg5bDIwYS9T?=
 =?utf-8?B?T2Z2ZWU4VGdoUlIxL2NYU0N0dkFGVUIxZVJFbjJZNmpLSTBiQmZSeU5la3RS?=
 =?utf-8?B?amtQaDdKckZ6RVRSL0tuN1NZWEhyRlFKWXh3Tno3OEt1ekxscDU4SnVSZUNS?=
 =?utf-8?B?cGlOSkhwOGZ0MVgzYmVvTWF2VlVYYU4vK2orQWRLTlBxTFZRMXhnMnovZnlX?=
 =?utf-8?B?djZ2cVAyK1pwekxzSk9YdXM0dDc4bWYxQkFVTUN4TDNsaDZqaE1NQ2lyRk14?=
 =?utf-8?B?d0ZrdnMwUWRpK0ZvUVNLM0pGL2ZabTdQTHpQTUJobXhuTlRZOEtBcmtDY0dL?=
 =?utf-8?B?TElqajhISU1wOHY5VHdnS2VpdXlXc2Z2NEVrZCsrWmZuM0RVOHViMUdPVHNO?=
 =?utf-8?B?NFNGVGs5VUphMlZIcklnSUdydFJjTnhiQkF1dklsR0RSWHFVVHp3dVFjVkxr?=
 =?utf-8?B?dHh0QW40Q2trYm1jT3d2TG9RRGwrT3BNMy9JZ0R3aEkxU1VBQkdkaE1jOTNT?=
 =?utf-8?B?Q3loZFpNWnpxUmJtSDlRNUI2L29remQvdHpPNnFYYUJHbWxZSC94R1dEeXZG?=
 =?utf-8?B?N25NT01HT0FOd3dwQjB6S3p3eHFwZDVXRkNEN2kxNFVmckkzcWZwR1hxdytT?=
 =?utf-8?Q?5tlPx5kzI2eiO?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 725b2c89-b323-47f8-5ed5-08d96ba1d915
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 10:35:12.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGlgVIsGe6tbja+qvPSuqeq9LoVitIl59QGHv4sVNmow55NxjDyZEVpu/7JRpoZjSkrkZKnO86ZcHvLvw3q8rLmPhyH4mwre3uvPgFKkxFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4688
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.08.21 00:15, Junio C Hamano wrote:

> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> openssh 8.7 will add valid-after, valid-before options to the allowed keys
>> keyring. This allows us to pass the commit timestamp to the verification
>> call and make key rollover possible and still be able to verify older
>> commits. Set valid-after to the current date when adding your key to the
>> keyring and set valid-before to make it fail if used after a certain date.
>> Software like gitolite/github or corporate automation can do this
>> automatically when ssh push keys are addded / removed I will add this
>> feature in a follow up patch afterwards.
> Has this follow-on work happened already?
I have this prepared but not ready for submission. I wanted to wait
until openssh 8.7 is released (which happened recently) to make sure
their api for this newly added feature does not change.
I will be on vacation for the next 2 weeks but can submit it afterwards.
I have a few additional features in mind but wanted to wait for the
basic functionality to settle before piling stuff on top.
I'd like to add a "Trust on First Use" mode that will add keys to your
allowedSIgners File when encountered the first time (this could very
similar to how .ssh/known/hosts works).
The idea came from here: https://lwn.net/Articles/803619/
Also signing support for git format-patch/am would be nice (ssh
signatures are much smaller then gpg and shouldnt be too bad in emails.
Not as minimal as minisign but with easier/more established key handling)
>
> The previous rounds saw enough reviews and responses, but this round
> didn't.  Usually no response means no interest from the community,
> but let's see if somebody other than the author actually tried the
> feature, and and want to tell us about their experience, either
> positive or negative?
I will roll this out to our corporate env after my vacation but can
understand that people are hesitant to push commits with it since older
git versions will BUG() on verification of the new signatures.
But at least github handles it well ("GitHub supports GPG and S/MIME
signatures. We don’t know what type of signature this is."). I have not
tested with other Forges yet.
>
> As the basic step of the topic, possibly to be built upon laster, I
> am tempted to say that this v7 may want to be cooked in 'next' for
> wider exposure.
>
> I'll typofix the topmost commit before doing so, though.
Thanks
