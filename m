Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD8CC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjBFTSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjBFTS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:18:26 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2056.outbound.protection.outlook.com [40.92.75.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B48159D8
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:18:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdUuu2qfGXIkCV94KizL+Z9Or0km2BahaZaheDaVMBYh1uvu46wuXZU3yQUs+g/o5tQpKH2HizobGLOtIWhIdEY+anuUw8eVz70Zysll0FZUV2x0TyNLnqJ0DfzArtVwTO00cXjBZrmeXIhvWUqtBqR4z5XAAZVW7d7yAsgDohD6tXoADq1JPs8DNclP8PnhaJ1N/4gYODrUr7K2RSW2z2ajT7ToBpzrAX7lgUO37uqLr1pts0Eh/INzz3E8JIq7S2bwdDTr8vznTEUZgYu8tWEnsMIuyGDfh9Yldx3+60v5HXCwRZeyR1spFfEVxOtkRmoCHtd4tvdGileLSDkoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ypv8n+aLZc/Ux6NG1tfLl7jpQD6x1han1V9f8hq+OVg=;
 b=P8aDZWkPc/7DXTCTg5klITAIuXtcG9BIgMi3JPIA+a59v+6353hIdf+O4f25aKdwZvfulCNyico0lGOEbP31jQzm8aP5uHgNUQOtFQsaClX6xSDHjT5cEU6LIZOkFMwRqSEAdiHOdbfQf4onn2dFw655YwewHgA6cv6yFKR2iUANgnjdenROhn2n34gcyc/Rkdm6xODJPhPmdMScIacTy7+5i0tUNI/WT3ktb28RkF+iz23NKuRszU0g4FN21JK/c8pquXjRGNF5c7koa+9weRw/1Cw27c+wrVYyIRZdIxuK3UcUQbR1SXO8K9Ve1vRJSDVzmqiDkJy3jsVGZpelBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ypv8n+aLZc/Ux6NG1tfLl7jpQD6x1han1V9f8hq+OVg=;
 b=X8hk7RtBsIAfdIaz6kfgy/+/nBTv3O6bgb7Ri24qywAn7+GjyU2SfBH+j9Ir4DOTNxzxmJKQD/MEkjL8k8LP3hw5q4ewWxgpKcciKzEju5TriWRvWWf8/+hNp3me2KjWeQEK/zEchSLZvJbAaS/5smFw2WTfrmJ6c0MFEdrrFyd6aiCdKeNphcvMA5X2+ienoqHIcPKC+LzPaZXP7H4f6EEFZEggjKTCljENurG9VpD6oloylAyrmMGyyZWgBWqjKbuFEE6I6SeBJWJmTw+dVPBVSnVclgV4NI0G0MQkMuYZjAFRzJx+nAgljdusXFmmsLDN9BU6/BSNgruIUNaWBQ==
Received: from DB9PR03MB9831.eurprd03.prod.outlook.com (2603:10a6:10:461::15)
 by DBAPR03MB6534.eurprd03.prod.outlook.com (2603:10a6:10:19b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Mon, 6 Feb
 2023 19:18:11 +0000
Received: from DB9PR03MB9831.eurprd03.prod.outlook.com
 ([fe80::fc02:6831:74ff:f92a]) by DB9PR03MB9831.eurprd03.prod.outlook.com
 ([fe80::fc02:6831:74ff:f92a%7]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 19:18:11 +0000
Message-ID: <DB9PR03MB9831A708EA98E198591F6632C0DA9@DB9PR03MB9831.eurprd03.prod.outlook.com>
Date:   Mon, 6 Feb 2023 11:18:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 12/12] credential: add WWW-Authenticate header to cred
 requests
To:     Jeff King <peff@peff.net>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <09164f77d56e8efd1450091cf1b12af2bc6cf2f5.1674252531.git.gitgitgadget@gmail.com>
 <Y9JjRfhl1H4Julv3@coredump.intra.peff.net>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <Y9JjRfhl1H4Julv3@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [3ekRw2CtXDWSqjWRcBACrMzZVQZG5yBN]
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To DB9PR03MB9831.eurprd03.prod.outlook.com
 (2603:10a6:10:461::15)
X-Microsoft-Original-Message-ID: <b8e38784-ce41-05bf-7212-73180b763358@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB9831:EE_|DBAPR03MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a14defb-d926-4947-baf5-08db0876e277
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOwqfL2dUUwKpuWL3Jqqjhgf5uiVFDWTw120sQ2KfzybsSz7EBTjekVhUmXZCOKa14k+co4+Qwd7hcIcY8PG7bR5dvTmUe+ug5aZp66UzKzaf07asU0gxjdZCdry9ALTMnulfIv/qMsAksYIUfbZhfGUjsZEoKi0Y7SGYJ/HVrLSoiuWmctSrC8jcdKPw3L60n7kJnUAwhxOeNy6WM3248B4YwyjqhH7K7pPsWWd3L70EcUbSKhVlFxkZQCjw/5hEXtEiZFeP9p8jRpjp4PY+7+Zt6WnkuCSJ+6aoG2cqzPErpqgdIc1IgKUTIXG1qTp7uLXfuDnBOU0J/7IPoNaoH01uhNogSE3njyGe4xlA83LS3FX0ZwWEC0PxgyXdQYFfhLn6kQ1BQdppicRTI9QuCuNiKgSt75CJ2XG3stRAXtQSVJg9Le8lS6HKVGGsicgL1/qPg4iaVzscU5u2rU2Oszqym+AUkxOi4pKTZg0Gi08oIKZ235YvcMxi2EocNibkqQwzuYlrFWwDyjMskahzREtAU8s0/AyEPJ2H5vpeRGUvD0lY8kr8hZ/OCqEqJfX5rXo4CnnB3zf299GoWpD34slEoQLliK7YcJtmeTQ819+51cfyNCYDKjPH+iR1eRgffF+IyCbaUYpptcZ3uavXA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3FoeUk0QW8yOFBLSUFKRXJPNG1rRzk5MVR1VWFvWWdJMDF0SjZuWGplcytp?=
 =?utf-8?B?ZVpKRU95blBVMWhSUGVyTGRwcHJ5dkRURGtlNEFXOUt5YnNYcFpqWGxuSkla?=
 =?utf-8?B?eXVmZU5jLzJLbDkxUVlpSDZEWWJ5U25sZ01hNkhpODlBS0FDQ3JIaUhiKzE3?=
 =?utf-8?B?dlYvM1p5MFBBUjV4YStZa3BDQU9zbi9xTWJMYzg3Yk1VNUlNY1RxeUZqSUo1?=
 =?utf-8?B?bnpNN3hKbE1EZmRZYkEvTFY3YWxpT2tvL3hrQW9zc00rUmVzUE13UHhTaS93?=
 =?utf-8?B?WWZ6YTFONnBCTmlMSGNHOWQ3N1FtVzZZYklXNm9sZ1BTSzN3eGR0Qm9DT1Vj?=
 =?utf-8?B?eUR0N05DU3k3Z1I3NW5IUUFJdmE4S0w5ejFOYWw1dWI1V3kwMy81UXBpYjRa?=
 =?utf-8?B?UENOa3VzZHhnL2lDSDBqdXQyM0k3YW83dWtnbDFITHBzdkk4eVRDTi9ianRp?=
 =?utf-8?B?dUNUNXkrYTZRWVJYRCtnV2kzeVFyaFVZQytDV055bFNFWi9XWHlhYUJmUEoy?=
 =?utf-8?B?ZmRGeG9iTFFCSWVuRW9vSGJDV0lGbHVUdEsxdUh5R0pjR2VyakplRGZLZXJl?=
 =?utf-8?B?QzQyeU12WXRlSUlUR25QeFJ0TDVpK1l0WmVJU0Z0dzFlTGJCTWU4bVY5TFJP?=
 =?utf-8?B?SkJqQndlKzY3S3hITnFUd3o2ejJ5cis0VzQvVmpkU2YvWjZMdHhkOVB6a2pQ?=
 =?utf-8?B?cENyT2JCbGlQUDdnQXJwTXIxeU9aSEh4dUtnRVBVcTF4aVFIalJJUlNxNEdS?=
 =?utf-8?B?Sm95YjEzZ09XQ2hjVHdmUjBpQVRmUnFZUEVsNVkzb040aWZNQ2hTQzIwVWJO?=
 =?utf-8?B?M1B3a2ZuQ2NiWVZoZDNtOGlGS1U0NDBtdFVjc1I4VUJmNEFMZ0dnSGoxaDQ3?=
 =?utf-8?B?dDdHcElrWlpGOXBGQ0lpbXFPVk4vSVFSVHV4RnRsTnowOFBkQk5SdkM0R3JO?=
 =?utf-8?B?SmJGYUJKQTNXQVhVMXp1TW1QeDhGcEwwWDJ0cmorUDdzTk1CUWxqZS9zNUsy?=
 =?utf-8?B?cDA5V1p6Q1FEbUozQXNhejFlbFMxNUMreXlDK0MwaEdsYTE4V1A4N3hoTVlV?=
 =?utf-8?B?dmQ2RXRPZW42MzJCWGJYaTl5YUVLcTVTNW5wN0NqMWk4NkFsZ3JQUjFsRnRN?=
 =?utf-8?B?K1VhcC9pU0psbWRUbEFEL3NzSUhWNkQ1Q1RuUG5lZFQyOVRaclJRWFA5cnhK?=
 =?utf-8?B?RHhVSDdDT2dzMXZDWHZrdFl5RkRBMGNFSDBTQXY1blNOaUZKSW5VcHBzVG9y?=
 =?utf-8?B?dUlzY2dRV0pESDhVVTdGb3dQNmlleWtmbEU0ZXFTdkRXOEltNTBrRVpya2sz?=
 =?utf-8?B?TVFRK2xpcTFTeXNxMzBISXh0L3BOZzlkL3NScmc0N2FmeUNyNGtySWFza3BP?=
 =?utf-8?B?S0w3aE5BWUhNVHY5YkVJYlFJOWxtelkvQ1NxZG1xekRGY0Q2V1U4Sys2MHln?=
 =?utf-8?B?TmtjUGFZT1U2eTNnYytzekV1Rk9BazR0b051ZUFlZ0U2N01jOUN4RnZhQVVC?=
 =?utf-8?B?UlV3dHhFUzljeEdNK01jVlo5MnU0WCtwUFV2OXY4S0d2WUdHN2VBcURFNzFo?=
 =?utf-8?B?VnpKT0xZUHdHYyt0NE4vVUFKeng3ZmhHdDJZaFdUaDFwUzVPWkluVXpsVG9p?=
 =?utf-8?B?UUxaYkZjZ3E4akw0akRoa0x5c3grcG1BbFQ4RWs5UXA0R3F4WlJIdjYvRlVP?=
 =?utf-8?B?dXBLS05TVGZaV1ZiQWhyZ0k5VERhbTNyZitGRzc0N09SNmI4ZTBjOGhnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a14defb-d926-4947-baf5-08db0876e277
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB9831.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:18:11.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6534
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-26 03:25, Jeff King wrote:

> On Fri, Jan 20, 2023 at 10:08:50PM +0000, Matthew John Cheetham via GitGitGadget wrote:
> 
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Add the value of the WWW-Authenticate response header to credential
>> requests. Credential helpers that understand and support HTTP
>> authentication and authorization can use this standard header (RFC 2616
>> Section 14.47 [1]) to generate valid credentials.
>>
>> WWW-Authenticate headers can contain information pertaining to the
>> authority, authentication mechanism, or extra parameters/scopes that are
>> required.
> 
> I'm definitely on board with sending these to the helpers. It does feel
> a bit weird that we don't parse them at all, and just foist that on the
> helpers.
> 
> If I understand the RFC correctly, you can have multiple challenges per
> header, but also multiple headers. So:
> 
>   WWW-Authenticate: Basic realm="foo", OtherAuth realm="bar"
>   WWW-Authenticate: YetAnotherScheme some-token

That is correct. It would be strange that server would respond with a mix
of styles, but I guess it's not forbidden.

> could be normalized as:
> 
>   www-auth-challenge=Basic realm="foo"
>   www-auth-challenge=OtherAuth realm="bar"
>   www-auth-challenge=YetAnotherScheme some-token
> 
> which saves each helper from having to do the same work. Likewise, we
> can do a _little_ more parsing to get:
> 
>   www-auth-basic=realm="foo"
>   www-auth-otherauth=realm="bar"
>   www-auth-yetanotherscheme=some-token
> 
> I don't think we can go beyond there, though, without understanding the
> syntax of individual schemes. Which is a shame, as one of the goals of
> the credential format was to let the helpers do as little as possible
> (so they can't get it wrong!). But helpers are stuck doing things like
> handling backslashed double-quotes, soaking up extra whitespace, etc.

This key format wouldn't make it obviously easier for simple helpers to
understand. Now they no longer have well-known keys but a key prefix.

My overall goal here is to have Git know less about auth, so it treats
all values as totally opaque. The only logic added is around reconstructing
folded headers, which is just HTTP and not auth specific.

> I'm not really sure what we expect to see in the real world. I guess for
> your purposes, you are working on an already-big helper that is happy to
> just get the raw values and process them according to the rfc. I'm just
> wondering if there are use cases where somebody might want to do
> something with this header, but in a quick shell script kind of way. For
> example, my credential config is still:
> 
>   [credential "https://github.com"]
>   username = peff
>   helper = "!f() { test $1 = get && echo password=$(pass ...); }; f"
> 
> That's an extreme example, but I'm wondering if there's _anything_
> useful somebody would want to do in a similar quick-and-dirty kind of
> way. For example, deciding which cred to use based on basic realm, like:
> 
>   realm=foo
>   while read line; do
>     case "$line" in
>     www-auth-basic=)
>         value=${line#*=}
> 	# oops, we're just assuming it's realm= here, and we're
> 	# not handling quotes at all. I think it could technically be
> 	# realm=foo or realm="foo"
> 	realm=${value#realm=}
> 	;;
>     esac
>   done
>   echo password=$(pass "pats-by-realm/$realm")
> 
> which could be made a lot easier if we did more parsing (e.g.,
> www-auth-basic-realm or something). I dunno. Maybe that is just opening
> up a can of worms, as we're stuffing structured data into a linearized
> key-value list. The nice thing about your proposal is that Git does not
> even have to know anything about these schemes; it's all the problem of
> the helper. My biggest fear is just that we'll want to shift that later,
> and we'll be stuck with this microformat forever.

I'm not sure there's such a continuous scale between simple and 'complex'
helpers that would mean there'd be a simple shell script generating
OAuth or DPoP credentials instead of a helper written in a higher-level
language where parsing the headers is one of the simpler challenges faced.

>> The current I/O format for credential helpers only allows for unique
>> names for properties/attributes, so in order to transmit multiple header
>> values (with a specific order) we introduce a new convention whereby a
>> C-style array syntax is used in the property name to denote multiple
>> ordered values for the same property.
> 
> I don't know if this is strictly necessary. The semantics of duplicate
> keys are not really defined anywhere, and just because the
> implementations of current readers happen to replace duplicates for the
> current set of keys doesn't mean everything has to. So you could just
> define "wwwauth" to behave differently. But I don't mind having a
> syntactic marker to indicate this new type.

I had considered another model whereby we forgo the key=value line model,
and hide another format behind the 'final' terminating new-line. However
I thought this would be even more distuptive.

> If you're at all convinced by what I said above, then we also might be
> able to get away with having unique keys anyway.
> 
>>  Documentation/git-credential.txt |  19 ++-
>>  credential.c                     |  11 ++
>>  t/lib-credential-helper.sh       |  27 ++++
>>  t/t5556-http-auth.sh             | 242 +++++++++++++++++++++++++++++++
>>  4 files changed, 298 insertions(+), 1 deletion(-)
>>  create mode 100644 t/lib-credential-helper.sh
> 
> The patch itself looks pretty reasonable to me.
> 
> One small thing I noticed:
> 
>> +	git -c "credential.helper=!\"$CREDENTIAL_HELPER\"" ls-remote $ORIGIN_URL &&
> 
> As you undoubtedly figured out, the helper path is fed to the shell, so
> spaces in the trash directory are a problem. You've solved it here by
> adding a layer of double quotes, which handles spaces. But you'd run
> into problems if the absolute path that somebody is using for the test
> suite has a backslash or a double quote in it.
> 
> I don't know how careful we want to be here (or how careful we already
> are[1]), but one simple-ish solution is:
> 
>   export CREDENTIAL_HELPER
>   git -c "credential.helper=!\"\$CREDENTIAL_HELPER\"" ...
> 
> I.e., letting the inner shell expand the variable itself. Another option
> is to put the helper into $TRASH_DIRECTORY/bin and add that to the
> $PATH.
> 
> I also wondered if it was worth having setup_credential_helper() just
> stick it in $TRASH_DIRECTORY/.gitconfig so that individual tests don't
> have to keep doing that ugly "-c" invocation. Or if you really want to
> have each test enable it, perhaps have set_credential_reply() turn it on
> via test_config (which will auto-remove it at the end of the test).

Good ideas! I shall try those.

> -Peff
> 
> [1] Curious, I tried cloning git into this directory:
> 
>       mkdir '/tmp/foo/"horrible \"path\"'
> 
>     and we do indeed already fail. The first breakage I saw was recent,
>     but going further back, it looks like bin-wrappers don't correctly
>     handle this case anyway. So maybe that's evidence that nobody would
>     do something so ridiculous in practice.
