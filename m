Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD625C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 16:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjAWQDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjAWQDo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 11:03:44 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CE9EF8F
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 08:03:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjQPBXIkyMi6dDZTqaucakGXIKgX6Zl3LPHVWWuHJN/33xBiUTLmAY1FMgUtO0f2lCfrpoU5/4VW7aoaEG4d0+o8HR69HwyDUP1q4fL9FdYl9YuDzEXvciQfE775YJ3LvILBVVUMP6WwVqf68/TkAtgSi5erJezd8qaasQk5dcVl2+8Ta1uiEM6uEIdsBptJNS4ZL5fWO0TLG1km6+Zg1UWxR4xdK3answbOOyHlQef/wlRFpeEwva8fi4YxiONC2PtqqlmfnMw884XW98HhxunHhR5P9obcNtbo+MjMcxj6o2HunW6l2zwp8CfLLoft4VS469d4Vk0I5EN5gAFxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWJA2SddFgkY6WU8qNpnkXKu4rWwTaPokCeI41gfMSE=;
 b=khjmNiDaa/MeCWyD5RhJoBZSo7MHhQWMJpv6gKQkXkSf4aR83ugJCmzdEbpZ5o3zLOlRvH/ybN+cja8AWGZP9aWuJiRfHFv8ki4RMBKKujqoXBDl13Ft3VOW1UNBy+PaAwj8YtcAKfLPRIm13vnPvaMFyi+0SbLm/m0oZop4ejENfBklOX1nv3XEwbpo7MF/kSkJ3eM2I5Dz4057hTFzeNfMu49g8KnHkLvLJ4Gmd3kcIjvzuDsYYqKC8eeTZeukZUJQyop4WRUpSalzJ6/i25ESMr5rfa6o30M+lE8mwMNHSSBx+VclT3+6yT7aRtfk6aL5c+ojWZfpt6S5h45NHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWJA2SddFgkY6WU8qNpnkXKu4rWwTaPokCeI41gfMSE=;
 b=KxyId01z/mtn7jS53fWBoHbxg2Eh/WarM8eQuOvQ/xypFr8ALYLw6USGUUKo9uuHVjRoXT1uR63ltZMylkEZjUJprdnlj6QJhjq2PcsghJ8jifjqrw1OMv9DXg/ZkN9X+GIhhLBBVkoqIXtDbY33q4ufoI6F9Pm+J/Pwl6Pd60c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Mon, 23 Jan 2023 16:03:40 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 16:03:40 +0000
Message-ID: <5758ffc7-eb8c-4c16-d226-dd882cb2406b@amd.com>
Date:   Mon, 23 Jan 2023 11:03:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20230120012459.920932-1-michael.strawbridge@amd.com>
 <230123.86wn5ds602.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <230123.86wn5ds602.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::15) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: e86c7b67-d1dd-4131-af14-08dafd5b64bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbxAlJyPxGRg3SZDJQVQQV4edOgvz3j+BZw+KoBbm3oSn2VRmekOOLye5SO2IgPiCFfW64FKj5Dx2u0s9YZyMMdRDt8dlxMYcIvpE4ME4rkRghpJwtUkLHWkLcfz0nNhAMDPGVcBB5cnDhtfrzXifWFAK9UMbzvZrgKkxx0CSTnHuOna7VmxI9kdb/MUkBG1UUtPBKu3j/JUmmrhUivR5wU5FXaQlDu2TP9dXT9BroRo2s/NV0xrMgXG6fhBtGbfil1zXePnXU/wLpiH8w5t/ZaccUCHoMNca202IqL9GtGhtPoeGAAketUmYSUCI9eDPQOxWNdRSuNOirufZO9+JHO6OGMuLTYzgkrK9jK8527XIPAwTkBA47dfogPYpvv6JI73ywfZJXO/5F2RvGtrMy81F/fX6Q9NG2ZouEkeK9vfDb7GVyjS6+iuE9mh2Mp5VbiN9ZvjdDAlOfVZr2NylzpN3fsBD/DK15RlURw+0TQ9rHY+gnr/EYO0lcHaXuAj7AntXhmJyY9HlH0raNJmC0aqZxxFo1Bv7ASIDfJDw7M2xcXqkTDcNt8vsJjucyw/4IvX/nOXVBCJUgvZ12mFvcgwKdmbx1GOkBr5rL8vIeKdH8UuKxlFxIWX6duu3+DfaoCmYIQIDUZF7lnhXBUVkHkLkVIa6GbjzDOtEYKGruqkIIcRPNtQBj6gh3a+Wil9zsG7jHRCRlVArtoJQWqfZ8NcLcYgF5tcjOzC/R0BD431Ojkr4CQKAA6js+wmNOsWY5GEOpxrz2VMqbdBo8Tndw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(36756003)(31696002)(41300700001)(86362001)(5660300002)(8936002)(4326008)(2906002)(44832011)(4001150100001)(15650500001)(83380400001)(38100700002)(966005)(478600001)(6486002)(31686004)(6916009)(26005)(8676002)(53546011)(186003)(6512007)(6506007)(316002)(2616005)(66946007)(6666004)(66476007)(66556008)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0dodHpId29KSy90YjdpQmpTVWNyREdmSTZ5eWxoemJZQlNucEg1c2tFSUZD?=
 =?utf-8?B?TXZjU2VqdFFVMGdPZEZWblJZVWNQYzJtbXBKVmlCY28rTHpNRkMxZ2JzeFJY?=
 =?utf-8?B?Q0d2cXNKNWhxaXFHQnNES2NJRUg4c0psTis1TVZnMTVpdzRXYk1KNlJ1KzJv?=
 =?utf-8?B?Rk1WWHRIWGhxL1ViOVNGRGhackcwRHZ3UmhBcjF6bEd1dzNKUUtOcmhGV0pz?=
 =?utf-8?B?dW9UemNpdjF6RGVodzlLT0NSNkQ3bTlLaHdtU1k1OGNaS2lLak9ZK1NRT0Uy?=
 =?utf-8?B?UlhCYk1QTytscm1jL1BDNXpwbVAyYWg5NHR2eUFxRFZvdkZSR1JvWjBUeDNU?=
 =?utf-8?B?NVhXalpVZ1lMYWtNN0NRVjg1VFVFLytLajNYWmc1MkUvMml4M0dOcDJXbHhl?=
 =?utf-8?B?OEZ1ZWVxb2VoTEJzemRYNjVIKy9Ja1VpeXorekUreVZmenh0K3lRR1RXQUFi?=
 =?utf-8?B?TCtJV2h0Z0NzaU80WGVMNG9QM04xWGpyWGM1ak1ySktoQkRpbzdRcytTM3lQ?=
 =?utf-8?B?THR2Rnk1R05oYjZUK0w2NjFpaUIwd3VReDIxU2RyZGh2Y2k5eWduRXV5cTVj?=
 =?utf-8?B?b3J3dmltWjZnVGZ3M0k1a3dZdnRnQ0hkK3pyRTNyU2p2bzVldFBSU2VCZlNY?=
 =?utf-8?B?cnQyQmZKSGF4U0pUdEtyaUppNFRyTmM5VS9tMUVidnlvcFNUN3JkRUtSTzNi?=
 =?utf-8?B?TzdrdU52VzVRSFdYajBYZnh4TTFSUWh2MVVJdHMvZ2Z4T1kvT3JsMDZiRUp0?=
 =?utf-8?B?N0JCeDN2WjVmKytLdkNZdXc2U1dIbzcyQ0xoaStRKzJYbHloZTNaOVEwYTd3?=
 =?utf-8?B?aERRUG5lRTVveS9BTm5kamtjNmthQUJYRFRVZFoxRnUxcWdGQW1mcE9Eek9X?=
 =?utf-8?B?QWpJSXRheHhtbGJJbS9YT21qSWhXa2VjbnNtTTdPb29DS2dMTk1TTVB0WTBl?=
 =?utf-8?B?ejlvSWNaRUtDTUo0TVI2K2xFMzZHZ0pzQ2Y3VlJpSCs0cXhkd1JQNzU4dS9L?=
 =?utf-8?B?cXZwVHdROHJJOFBQSGxrbEVTdEdUWVBsSDFPNDgvVkRpUEJRczhVZTBOT1R3?=
 =?utf-8?B?T2QvRERpL0dOQXlaZDh0S0d2cmk5cTNNVjdIRGVFZldHNmxaNUhGbFhqaVA0?=
 =?utf-8?B?cXFUTVozT242bkhheHlaTzlTeHhtYjZPTzNQcXBOaElxbzBSUnZFMktWczgw?=
 =?utf-8?B?TEQwNVQzMmJmeVJoUFUrRytXbkEzYlhUV0QrdkwvOVlwdnZDTzhWMVNXcy8y?=
 =?utf-8?B?VUJKZkZac0RaWTB1QVUzQmQ1SjVFNkZSbmF1VW5oSXpFRVJJMDRrUnNHN1J1?=
 =?utf-8?B?aUt2QnVjWC9CYmtscVVKUm9UdytSSVcwdjVUTzY4WE5kYisyTmZaNEhybjhI?=
 =?utf-8?B?ZDBOUjhNSDZ3TGtPWGtKUFVocklRclhWRS9Ba3IrcTdxaFpZR0l3cnhyYWVp?=
 =?utf-8?B?djRmQyt4Y3JUbXQ0SkxPc3ZyTzJYQUxPZVMyVHFNdmZWVy9UWkNHTFZwK2Zx?=
 =?utf-8?B?c3ZwU2tXUW84M0ZlVDdjUE1HOGJPaWxBRjA1Y2gzUzFrN3dtV3ZJM2VNdzZ4?=
 =?utf-8?B?cmF6Z0JWWmhCSzNlZys2NWN5OXB4QnZnc0UvUzdVVUxFOXNBU2pjK1B0dUkr?=
 =?utf-8?B?bFljbUZ0TEJPQTNIYndXRHJUYndSSlFncDkvRkpabFFMVEdtMmhGa1NPYkpq?=
 =?utf-8?B?NmFsejVHNjNGcFJPdGxpT1drV0JrTGtQZnZlVkhjVXdtTU5mYlBNOWxhTHFU?=
 =?utf-8?B?VWxFK3dzaEhQMCt2Nmc3bVptNnlHMUowZnVKZnlpbTU1Z0JyelN6OGExTnpI?=
 =?utf-8?B?YnAxVW5odVpCdjJPYVRjZjFIZnRob0w1NzVOZ0taUDFvL0dicllTSGdyWXM3?=
 =?utf-8?B?ZFVLdVJ5eXZONkpkRFZuQ1MxSTRuVlYwS1VsS0kvTkJod3l4QXM1YURSVWUv?=
 =?utf-8?B?U2dMbGVzUDVKbjlLbXFhS1M0U0t6ZHpxWWI0WUtwYitCVzN4Qkpoem9pZFdO?=
 =?utf-8?B?d3R5YkNpQW54UjNLR1BDUDhWUUcySEZ4d1RYVTg0ZXRaUHA3TjhOejZWbHdi?=
 =?utf-8?B?b3dJd3VEMmlDbVNZZG1OV3l5MGJpVGZjZVZmR0JXNC9JbmNrQmYya2F1R2d6?=
 =?utf-8?Q?SNeouz0WxghKkGWqLonKmIfAL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86c7b67-d1dd-4131-af14-08dafd5b64bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 16:03:40.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxA5fgFUL/zGYyKggEClluleTZLh9ED5iHz90uddxwxV/iIdy6HnkSB4VdxRirebddsNo4eygCQa5AUo3XmDCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2023-01-23 08:51, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jan 19 2023, Michael Strawbridge wrote:
>
>> Thanks to Ævar for an idea to simplify these patches further.
>>
>> Michael Strawbridge (2):
>>   send-email: refactor header generation functions
>>   send-email: expose header information to git-send-email's
>>     sendemail-validate hook
>>
>>  Documentation/githooks.txt | 27 +++++++++--
>>  git-send-email.perl        | 95 +++++++++++++++++++++++---------------
>>  t/t9001-send-email.sh      | 27 ++++++++++-
>>  3 files changed, 106 insertions(+), 43 deletions(-)
> Thanks for the update. Aside from any quibbles, I still have some
> fundimental concerns about the implementation here:
>
>  * Other hooks take stdin, not this sort of file argument.
>
>    We discussed that ending in
>    https://public-inbox.org/git/20230117215811.78313-1-michael.strawbridge@amd.com/;
>    but I probably shouldn't have mentioned "git hook" at all.
>
>    I do think though that we shouldn't expose a UX discrepancy like this
>    forever, but the ways forward out of that would seem to be to either
>    to revert a7555304546 (send-email: use 'git hook run' for
>    'sendemail-validate', 2021-12-22) & move forward from there, or to
>    wait for those patches (which I'm currentnly CI-ing).

Ok.  If we are at the point where the change is just trying to pass CI
but the main logic is there I am willing to wait some time.

>
>  * Aside from that, shouldn't we have a new "validate-headers" or
>    whatever hook, instead of assuming that we can add another argument
>    to existing users?...

While it's true we could (and I don't have a super strong opinion here),
I suppose I was foreseeing the potential that a user may want to have
logic that requires both the email headers and contents.  For example,
only checking contents for a specific mailing list.  If we split the
hooks, a user would then need to figure out how to have them coordinate.

>
>  * ...except can we do it safely? Now, it seems to me like you have
>    potential correctness issues here. We call format_2822_time() to make
>    the headers, but that's based on "$time", which we save away earlier.
>
>    But for the rest (e.g. "Message-Id" are we sure that we're giving the
>    hook the same headers as the one we actually end up sending?
>
>    But regardless of that, something that would bypass this entire
>    stdin/potential correctness etc. problem is if we just pass an offset
>    to the the, i.e. currently we have a "validate" which gets the
>    contents, if we had a "validate-raw" or whatever we could just pass:

I think there might be a part missing here: "problem is if we just pass
an offset to the ___."  So there's a chance I may not fully grasp your
suggestion.

> 	<headers>
> 	\n\n
> 	<content>
>
>    Where the current "validate" just gets "content", no? We could then
>    either pass the offset to the "\n\n", or just trust that such a hook
>    knows to find the "\n\n".
>
>    I also think that would be more generally usable, as the tiny
>    addition of some exit code interpretation would allow us to say "I
>    got this, and consider this sent", which would also satisfy some who
>    have wanted e.g. a way to intrecept it before it invokes "sendmail"
>    (I remember a recent thread about that in relation to using "mutt" to
>    send it directly)
>
>    

Are you suggesting to simply add the header to the current
sendemail-validate hook?

I appreciate the feedback.

