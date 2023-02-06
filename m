Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA66C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 18:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBFS7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBFS7S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 13:59:18 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2093.outbound.protection.outlook.com [40.92.50.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FB13DEE
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 10:59:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bW01d0IjDaYLzdhPwXeUMkgrmp3ifAbROMJPcPpZNZj+s45B44+gqbO0oRKKM7BSLYzKhFZpnGbxEio9YBVz8AB+MyjlKJ5i3yPpLozKhLjweLVHL69zZCpLRLZlwVowPm3cJ0v8kiW38wxddE7FpP+jRikqkJ+E+e0hEjOUPesIZ1+VEIOy7nVt4rpLDtbxo0e/0dE1o5elE0x1L60yO95cxubnIGN5kh/W3Ov5bGGbPai9ec29ER8yF+wRU5vM6YCbAkRQhDQwXSQ6wChhpd7KG6kknA7KaP2i0MMhkUupcU3QstLwsDkpKgWrXZzFfJ0Vw3UNEgEwjrGQiXoHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P7aDi0tJPR6Q8kDtpV5Grn+ezD64ny4qJHVsMhbQgM=;
 b=lrW5EV0i+sM/+SlXmMNUtQ/RfIeoK28XKVNQo1lQSkm63t1QDTct7VixGkU2cXnsxWokh/vHCQMrWxXna74wf4oTsrs/rYWlgizXuwYH2bEUHRu63cYpAoZ5JVShgubkXx7nEzq79Pu/AdSED6a1CymCQiZ20io51JkMKGixFHUfuGPtUtnp0JcAXrrfWet/9G8YAWU172JqFcb/ZXILoBuY47lxPkmXimOCB4z51bEP1tTxYyRWx4IKIkXddHpxn2PfMermGI1tDfUJ+uNJMTkOnJN8wYZLYdpzV3NTawlAaZle37vDQl99iM+6NAZW3wH5KPx6JhJWlJiQ9r0QiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P7aDi0tJPR6Q8kDtpV5Grn+ezD64ny4qJHVsMhbQgM=;
 b=A844/eOxIElMrPp4GxiV9+QvYO8b9AiaqT9DKBx/IsRSgkm1QaHwIOsf2ueMG5tNTPerpjtFMbUsJL2el58hL2WvIhyqqSHHBb+z+u3mtEchpQG9wiFKtuxnN+ZexSVUVT+JJElo8dVyQ4cPAXgdK/KlyG/LDXk3VRkKzxCcBuFqDd6kIHROOx1T0YuUixfmN6MBOsUFJ8zTieevudC7HRSmtGlFRRkgURZoFUrE+SBm6npfaz4650PR7/Xvfoc9jxfQN7u963SYGROkriaEb6XvjbtKbLBY/j3NiZ3+Y0h6Imm3WrSz7RdA7cX9mAdGcZICR4chzIGbo7KQIdzShA==
Received: from DB9PR03MB9831.eurprd03.prod.outlook.com (2603:10a6:10:461::15)
 by PAWPR03MB9033.eurprd03.prod.outlook.com (2603:10a6:102:339::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Mon, 6 Feb
 2023 18:59:10 +0000
Received: from DB9PR03MB9831.eurprd03.prod.outlook.com
 ([fe80::fc02:6831:74ff:f92a]) by DB9PR03MB9831.eurprd03.prod.outlook.com
 ([fe80::fc02:6831:74ff:f92a%7]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 18:59:10 +0000
Message-ID: <DB9PR03MB9831BD6602F8B904E9D1CBE2C0DA9@DB9PR03MB9831.eurprd03.prod.outlook.com>
Date:   Mon, 6 Feb 2023 10:59:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] credential: new attribute password_expiry_utc
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Dennington <lessleydennington@gmail.com>
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
 <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
 <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net>
 <AS2PR03MB9815DDCB7B107E7FD37EC972C0D19@AS2PR03MB9815.eurprd03.prod.outlook.com>
 <CAGJzqsnKBHPwHf-RMCxSDB6ZB5UPLH+XUbY8YiJOBxOicaG4bA@mail.gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <CAGJzqsnKBHPwHf-RMCxSDB6ZB5UPLH+XUbY8YiJOBxOicaG4bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [OA9APUETqsxOqawz/6iOL6kWJxuOJSdF]
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To DB9PR03MB9831.eurprd03.prod.outlook.com
 (2603:10a6:10:461::15)
X-Microsoft-Original-Message-ID: <7ab8fa29-edec-7603-bf7b-70265514b4d3@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB9831:EE_|PAWPR03MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: e260d49d-7369-42b0-9c60-08db08743af5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoL5IyiEEKMXG3Qm6glRJHzMvIJUKr6QFsAehGEOHXdLxeVKc3IEjmsuouCEsyAXfsXZw2C5c0FIQM9kQ6XGyHxISHgQ+zE8cLBUuh6VWPOtMj17gYMq48Yz+IGn4XG654fL7tmPuRlvE9d+uc644qWz6Rf7bTJ7fZTQNkMvZsNoz//AFCe0jkedEI1uiH5gmXQh1wFMdxSfuMi4PgK6PiJCEsDInoa/N0YV3coP5LITAH7IVeSyBi01r0wyprSXKZxBf3WXttyRoxlJOnAmpb7vvqft2cosaKLKuun+HSWDJZ//7cTNZhKRAxxJaSdRFIxpuJoX9pVNBXkyLGSqHEaRct2h2OjqCxbmzd7IkbRRuHCorLl2BFrRM7rIQwg0n3q7Nr1r6+xNtzSPB+sWfa/KBE/eZ5oEPJKMW5qnOaDJTHWpswjyhAJoS5vxj5M1OJVZoe1Ki3FC2QP4/GMX2GibDX7rl0wyOxXHP73AqpCvLTGejHUVQp1GWezM03xok3xzSgYVjsRcQCZJhlkBNp8D6rkXPXKvlslddB9QksydIhWF5wyQ8zQpVDWo0jgscPCEtpIpZX0jyZ/+2bdKqL0B0c0NWr6bOW9Lr25dugxWL2G/Szf0KmoACVVg/f/W7yL+p0VQwoUmP0xpPyte/qNQ3biNwb+EbhCsBWpfu8cGALL/07mjHuZtkg4fVgEc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9KbnRPMVRwd3ZXVWEvVHZVckJ2cVYrQytyWks5U1VUMTNha3lNT01tdlpo?=
 =?utf-8?B?MmJ1a1p3U1ZIZHRtdGYxT050dlRvcGIyTFJyNnhpVTd0bmRhczlvU1M5am5n?=
 =?utf-8?B?d3ZPWndhRVBqT1Yxc3BybG5oUzNMOFA2V0I3elhGR21pQWkyZUlNVTMxR0R2?=
 =?utf-8?B?UEJsby81YmNienI4bG1aUlNkZnVtSEJrK2RBYU5FckNPbGxLemR6V2lWS29x?=
 =?utf-8?B?MC9ET2RvbFRKN1FEcmtoNDRDRGVyYmRNWGdNekQ5OXEzU0tkN0ljZWZzVFhM?=
 =?utf-8?B?UnJvbW5jdmlXM0lvU1BtQ0Jmamw1TWgyZFl4RWRZS1FOd1RFbUNudStWU2Zt?=
 =?utf-8?B?bE11MjIveXV2QkJ0SHdDWE9iVjYwSWtXbkhmKy9nVjc3YmwwdDJnQTQ3bE9t?=
 =?utf-8?B?SjRQTDN6V3pGVEd6b2tuM2ZHZ0FOOTRGQm9ObTVSNklRSFlxZjBZTW1POGV2?=
 =?utf-8?B?VVRybVVjVmkzTXYySWtzUjRSUzJiY1NRQ1g1bDN5ZTdBZTVnSHRxSGdKNlcx?=
 =?utf-8?B?dFhybU9lcWtVTmowb25xK2JrTi9tVkhZMlE1M2Z0M0NEUk92UFBYc0Z6WlVW?=
 =?utf-8?B?dW5ycHRxNENCclh2dTNEMTVDQXJZM0ZYaW1sQ3gyZHJLQTFuOXNuai9iR1Nw?=
 =?utf-8?B?YnVjZWRsMkVsTERvcnphMXZ0S0dlT1g4c0UzUkl1Q0dQLzV2RWN0SnVwMTB4?=
 =?utf-8?B?MUVhNEEydE0reWluWWxYL1RoU2ZiM3poclJDMEFCNDBFUi9qbE5FcE1wSHhs?=
 =?utf-8?B?UDZwZXdaejZ2alJkWk1jdS9HamtBOHVPcndjd2ZKUExCbmhua3llUWllVHlW?=
 =?utf-8?B?TXJxbjFrNG8ySzVZUVpzZjhMZnF0RDlxQzE3ZENtM3dlR3NHNlBlWWs3NGx5?=
 =?utf-8?B?NnVkOGxtbFRmOWVQZ3NkYkdmcDZLSlhnN3U3ZkhhM0xkQXpKT1djdnBEUEI5?=
 =?utf-8?B?RVhiSEdHdGI5bmthZGRhT3hSM2lIK1ZMVGZSaEV6cW02T2lnSHo0NDVPaXRK?=
 =?utf-8?B?Ujhhd1ZNanRpWlpFMXpMTFNTclNGaGlKUS9GcFZ6a2dZa1VCUFk0NUU2Rng0?=
 =?utf-8?B?T2w4KzZhVXNwVEtTZXJnenNzT0gyZnlHN3FPSnl3bzNnbDR4VGZOQTdFanFJ?=
 =?utf-8?B?bUdZOFhOZkR2R2dzWTNJSmdmbWxneGMyWmhHa0NMMnJ2MHBEc0x6clpFU2pB?=
 =?utf-8?B?ZFovdmpUZkI0ZWVZQWViMEs2eXRpTlViOEJxTzR6ZTdDQndNVUFscDRidE1E?=
 =?utf-8?B?TmxDTEZSbzgxa0hGL25jYUZFSFBkN084QVplR3c3cndDRjBHSEp4U3Q2aUtn?=
 =?utf-8?B?bUtKOWRvcHEvMGM1WkYzcVVDdXlUQkUrYTVYU0JZWEMzWERNQ0h6N2src0tR?=
 =?utf-8?B?bGRFRTA3RHl5TTFmUVFhenU5MWdGdXNEOVZVRjhzWmJoUERZSVluNGJLNkNw?=
 =?utf-8?B?b2hlMVZhMno5bmFyYW5tOEJuVWRKbnJuZmxkbno2UkpvTVVIbitBTUw1WjFB?=
 =?utf-8?B?WTNQQkJmR0RuUVdoRDBqRmZQWm5CbDgyNjQ3dTFKcG41bE1JdG8ydlg1QXAw?=
 =?utf-8?B?ODF1d21RMHQweHFoNWlsWlRReWxSc0FudU5YK1hMWkVYNjBQcFFaRWNadk1Y?=
 =?utf-8?B?MklaYk5zK0puQVNrVGVSU3YrWkxnZHhBUXBKQjNpTWZQKzZnU2lNZE5ZTGxm?=
 =?utf-8?B?RzI1MGo2RGpDZ3JSR0pxTDBQNzUwY3hONWNNVUVBSmwzdXlBQ1JzSmNRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e260d49d-7369-42b0-9c60-08db08743af5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB9831.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 18:59:10.7711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9033
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-04 22:45, M Hickford wrote:

> On Wed, 1 Feb 2023 at 20:02, Matthew John Cheetham
> <mjcheetham@outlook.com> wrote:
>>
>> On 2023-02-01 04:10, Jeff King wrote:
>>
>>> On Wed, Feb 01, 2023 at 09:39:51AM +0000, M Hickford via GitGitGadget wrote:
>>>
>>>> +`password_expiry_utc`::
>>>> +
>>>> +    If password is a personal access token or OAuth access token, it may have an
>>>> +    expiry date. When getting credentials from a helper, `git credential fill`
>>>> +    ignores the password attribute if the expiry date has passed. Storage
>>>> +    helpers should store this attribute if possible. Helpers should not
>>>> +    implement expiry logic themselves. Represented as Unix time UTC, seconds
>>>> +    since 1970.
>>>
>>> This "should not" seems weird to me. The logic you have here throws out
>>> entries that have expired when they pass through Git. But wouldn't
>>> helpers which store things want to know about and act on the expiration,
>>> too?
>>>
>>> For example, if Git learns about a credential that expires in 60
>>> seconds and passes it to credential-cache which is configured
>>> --timeout=300, wouldn't it want to set its internal ttl on the
>>> credential to 60, rather than 300?
>>>
>>> I think your plan here is that Git would then reject the credential if a
>>> request is made at time now+65. But the cache is holding onto it much
>>> longer than necessary.
>>>
>>> Likewise, wouldn't anything that stores credentials at least want to be
>>> able to store and regurgitate the expiration? For instance, even
>>> credential-store would want to do this. I'm OK if it doesn't, and we can
>>> consider it a quality-of-implementation issue and see if anybody cares
>>> enough to implement it. But I'd think most "real" helpers would want to
>>> do so.
>>>
>>> So it seems like helpers really do need to support this "expiration"
>>> notion. And it's actually Git itself which doesn't need to care about
>>> it, assuming the helpers are doing something sensible (though it is OK
>>> if Git _also_ throws away expired credentials to support helpers which
>>> don't).
>>
>> I have often wondered about how, and if, Git should handle expiring credentials
>> where the expiration is known. In my opinion I think Git should be doing
>> *less* decision making with credentials and authentication in general, and leave
>> that up to credential helpers.
>>
>> The original design of credential helpers from what I can see (and Peff can
>> correct me here of course!) is that they were really only thought about as
>> storage-style helpers. Helpers are consulted for a known credential, and told
>> about bad (erase) or good (store) credentials, all without any context about
>> the request or remote responses.
>>
>> If no credential helper can respond then Git itself prompts for a user/pass; so
>> Git, or rather the user, is the 'generator'.
>>
>> Of course that's not to say that credential generating helpers don't exist or
>> are wrong - Git Credential Manager being of course one example rather close to
>> home for me! However the current model, even with generating helpers, is still
>> that Git will try and make the request given the details included in the helper
>> response.
> 
> GCM would benefit from being able to store expiry too. Whenever GCM
> retrieves an OAuth credential from storage, it queries the server to
> check whether the access token has expired [1]. This would become
> unnecessary. I've added more about this in patch v3 commit message.
> 
> Further, it solves a problem if GCM is configured after another storage helper:
> 
> ```
> [credential]
>     helper = storage  # eg. osx-keychain or exotic
>     helper = manager
> ```
> 
> Currently this may return an expired credential from storage.
> 
> Background for others: GCM is typically configured as the *only*
> helper, with its own internal storage configuration [2]. These
> reimplement or wrap popular Git storage helpers [3][4][5].
> 
> ```
> [credential]
>     helper = manager
>     credentialStore = keychain
> ```


One of the things that concerns me about the credential helper system
today is the lack of 'affinity' across calls, and I think that we may
disagree on this here.

A desire I have for the future of Git auth is that helpers can negotiate
to start a more long-lived or complicated converstation, with retry and
detailed feedback on the auth responses. I'm increasingly feeling that
the get/store/erase model is not sufficient for this.

Imagine the scenario where the auth mechanism has a nonce that is
updated on each successful (or failed) response. Here we'd want the
helper that offered credentials to be told about the successful response
for book-keeping, and not have that message 'stolen' by a simpler storage
helper.

Another scenario would be multiple user accounts; a helper has credentials
that would potentially be valid for the request (same host/forge or IdP
for example), and we're wanting to avoid unnecessary user prompts as the
user has not specified explicitly the account to 'bind' to that clone or
specific remote. Why could we not return credentials to Git, also indicating
that we have an ability to retry on a 401/403?

Increasingly, modern auth schemes have credentials that are so short lived
(maybe bound to the exact specific request.. a one time use) that it really
doesn't make sense to store any credentials at all. With such one-time-use
credentials, and a simple storage helper ahead of a generating helper every
other request would fail and the user would need to retry the command.
Imagine the case that the OS/hardware security device holds the 'real'
key or credential that is used to derive a one-time-use credential.

Strong auth mechamisms often tie credential generation strongly to storage.

> [1] https://github.com/GitCredentialManager/git-credential-manager/blob/main/src/shared/GitLab/GitLabHostProvider.cs
> [2] https://github.com/GitCredentialManager/git-credential-manager/blob/main/docs/credstores.md
> [3] https://github.com/GitCredentialManager/git-credential-manager/blob/main/src/shared/Core/Interop/MacOS/MacOSKeychain.cs
> [4] https://github.com/GitCredentialManager/git-credential-manager/blob/main/src/shared/Core/Interop/Linux/SecretServiceCollection.cs
> [5] https://github.com/GitCredentialManager/git-credential-manager/blob/main/src/shared/Core/CredentialCacheStore.cs
> 
>>
>> It doesn't make sense that a generating helper that knows about expiration would
>> instead choose to respond with an expired credential rather than just try and
>> generate a new credential.
>>
>> Now in the case of a simple storage helper without such logic, after returning
>> an expired credential should Git not be calling 'erase' back to the same helper
>> to inform it that it has a stale credential and should be deleted?
>> This would also require some affinity between calls to get/erase/store.
>>
>>
>>>> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
>>>> index f3c89831d4a..338058be7f9 100644
>>>> --- a/builtin/credential-cache--daemon.c
>>>> +++ b/builtin/credential-cache--daemon.c
>>>> @@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
>>>>              if (e) {
>>>>                      fprintf(out, "username=%s\n", e->item.username);
>>>>                      fprintf(out, "password=%s\n", e->item.password);
>>>> +                    if (e->item.password_expiry_utc != TIME_MAX)
>>>> +                            fprintf(out, "password_expiry_utc=%"PRItime"\n",
>>>> +                                    e->item.password_expiry_utc);
>>>>              }
>>>
>>> Is there a particular reason to use TIME_MAX as the sentinel value here,
>>> and not just "0"? It's not that big a deal either way, but it's more
>>> usual in our code base to use "0" if there's no reason not to (and it
>>> seems like nothing should be expiring in 1970 these days).
>>>
>>>> @@ -195,15 +196,20 @@ static void credential_getpass(struct credential *c)
>>>>      if (!c->username)
>>>>              c->username = credential_ask_one("Username", c,
>>>>                                               PROMPT_ASKPASS|PROMPT_ECHO);
>>>> -    if (!c->password)
>>>> +    if (!c->password || c->password_expiry_utc < time(NULL)) {
>>>
>>> This is comparing a timestamp_t to a time_t, which may mix
>>> signed/unsigned. I can't offhand think of anything that would go too
>>> wrong there before 2038, so it's probably OK, but I wanted to call it
>>> out.
>>>
>>>> @@ -225,6 +231,7 @@ int credential_read(struct credential *c, FILE *fp)
>>>>              } else if (!strcmp(key, "password")) {
>>>>                      free(c->password);
>>>>                      c->password = xstrdup(value);
>>>> +                    password_updated = 1;
>>>>              } else if (!strcmp(key, "protocol")) {
>>>>                      free(c->protocol);
>>>>                      c->protocol = xstrdup(value);
>>>> @@ -234,6 +241,11 @@ int credential_read(struct credential *c, FILE *fp)
>>>>              } else if (!strcmp(key, "path")) {
>>>>                      free(c->path);
>>>>                      c->path = xstrdup(value);
>>>> +            } else if (!strcmp(key, "password_expiry_utc")) {
>>>> +                    this_password_expiry = parse_timestamp(value, NULL, 10);
>>>> +                    if (this_password_expiry == 0 || errno) {
>>>> +                            this_password_expiry = TIME_MAX;
>>>> +                    }
>>>>              } else if (!strcmp(key, "url")) {
>>>>                      credential_from_url(c, value);
>>>>              } else if (!strcmp(key, "quit")) {
>>>> @@ -246,6 +258,9 @@ int credential_read(struct credential *c, FILE *fp)
>>>>               */
>>>>      }
>>>>
>>>> +    if (password_updated)
>>>> +            c->password_expiry_utc = this_password_expiry;
>>>
>>> Do we need this logic? It seems weird that a helper would output an
>>> expiration but not a password in the first place. I guess ignoring the
>>> expiration is probably a reasonable outcome, but I wonder if a helper
>>> would ever want to just add an expiration to the data coming from
>>> another helper.
>>>
>>> I.e., could we just read the value directly into c->password_expiry_utc
>>> as we do with other fields?
>>>
>>> -Peff
