Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AD2C433FE
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 05:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJWF5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Oct 2022 01:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJWF5O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2022 01:57:14 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F54F642FB
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 22:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666504621; bh=T4C6GvoOjYjdQeL4iWE8sUJ+QjitkdCPQvr15hJ8WCE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BAYHXvn4cbrHwiMs2ASWxBXRb8WBG/0zLygBnvY/q3m+/2UxBvirBbmyAKgxTFxSc
         9vk3F51mXMgTHCOZsw4KAG4eYWihvp/zFWpte7Pk/PJu9lTzhFG9+zEG0mBm27Q5FJ
         6bX2gx9uFfeRUgnAr+bHw3PaSsfnlPPIJgtxYvtJ9+emf4xeX0tod5bdBgS7EiioqT
         LolCurARprzXgaIJNPLUcLQlWOwtSIeyWpgXpZ1gUc8glIMXi8smW8qeE+XbZ0GzoL
         HSGsYasoRqtSs6zYUBjeoJ+omYHHLrJ5fTS+a8EFYr76AmZYeQj0KppzHsbx6Bw4Xv
         P764F4mwT8FQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28WJ-1ooxsq2oLx-002Nvc; Sun, 23
 Oct 2022 07:57:01 +0200
Message-ID: <c24c3ac9-0de6-62f6-607f-2d8f69ca9fa8@web.de>
Date:   Sun, 23 Oct 2022 07:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 3/3] git_parse_signed(): avoid integer overflow
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <f058f391c3821b341a15fda9ae9fd20dda6a0494.1666359915.git.gitgitgadget@gmail.com>
 <xmqqpmeljae9.fsf@gitster.g> <80fe7c62-2c59-a715-3a8b-2dc2331d8e37@web.de>
 <xmqqv8obhkeb.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqv8obhkeb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zLDpvjUQeiKP6ZMrHsZJZhMPikOuiI3e3ARtWwNfRdT5cAF/e/4
 8miRdtEg3bT7XQTj35/texmKbT1PF6xkLjjA43grf9iq6eIMv72s2Hd84D6q7rrGmhn6NGU
 AsdO1O7lyOmI2DoKyw3NBJcUnsg/cVy6zc7bkTWHKV3vx2RqJppbHugXCYqdCNjQPMqJwj/
 OTvqNbNxQf9D6KdJlCcBQ==
UI-OutboundReport: notjunk:1;M01:P0:F3EwmAYmWRk=;tajrCLi/FQVRDE8stPnd78ZDAFz
 UaXK0N0dbpxxij0LPck0sEUdQkl8Y6XlclrZmpcHebRa6BrCWxYUnivGwvKM2DLJSbnFNiYI8
 aPUmrfxfNSb/LLmjS2FkX1fEDlAH7SCaBOzoMkTr5XWgXxaelLVD8rlYcTl3oCShgqmWA/F2/
 uAqoLgqrDvi5SrXxRadc+nl8qFwWKALXhrbO0OeSkaketiSekea32XAxPqZxMVxf5FDTNq9EB
 o3pHfUPIWC7V9dbD4IT0bWSK5fvyjLzGQIrqilX/z6LUcN62D/KYwwRJLfC+oJpoTSfs4c0pl
 CUGTVDBr+lYvqHMHlRxhX9P8ZL7CevLEQG2TbzvnGNNN1oKN5LQDZNqmglU0n2QJBmksIxMM9
 L31htR1BvJIA9mPNZt8whI7W3YEmT5iIND70psQSpU5rlBx3RBHa7U0T7FPtjHATHFdyno+ga
 PVJHNwaH1oT50/Np4GmEs8mOjnZA8YqPR5HdUIoWbR2ucmN8EUezGDG4BF+SR7sQ9IgUdJMiU
 DhVZ1uRoCJEUzFanXZGIMJUYMSTGfUKsDjkUxErWMaZp3eKi4w3vDgylwiG0B+Z3XKYxYMhHj
 A7fygSeAPxu/i7sXUY1pAXOosC4Z0JALFjlz5tXxIB+YviZLv70snmFPCFq9O/7e9LEtIK2rC
 XbD8eHoe+g33Vu6Z3lslQ8KPDEoR3raJ2cxNqw/LF+J3G4UHYrqIvmsDopu0PgKpIBcjURjbG
 9cW8KeK4SfMtjLL3qgQArXZ5QZSeHkuaJ/yXkZFJe08FehePb0tGHSf6NDo6EIGxx0znneXjQ
 8XFbtQPatzgyYZQcUnGy2XAQZCsqNJEWO4dbqVKXjX4ShVdgxhi0phc4g3enUrfiLQZSIw0ct
 Ugi2ZN+nCLLO26VU7vUv00su/cqKUbvgyKUulxcdiddv37AJgkB6d59WgmcrdO56AUVZKyYcx
 mYCPDU4LHZSRG6SIg0nCOpmjor8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.10.22 um 18:51 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>>> +		if (max < 0)
>>>> +			BUG("max must be a positive integer");
>>>
>>> In parse_signed(), would we expect to accept end-user input that is
>>> a negative integer?  We must.  Otherwise we would not be calling a
>>> "signed" parser.  Now, are there cases where the valid value range
>>> is bounded by a negative integer at the top?  No current callers may
>>> pass such a value, but is it reasonable to add such a new constraints
>>> to an existing API function?
>>
>> Hmm, if minimum and maximum are not symmetric, then we need to supply
>> both, don't we?
>
> Ah, thanks for injecting doze of sanity---I totally missed that the
> bound was about the absolute value, so we can say "this is signed,
> and the allowed values are (-3, -2, -1, 0, 1, 2, 3).  If so, then the
> "reject negative max" in the posted patch is not a problem as I said
> above.  I somehow thought that giving -1 as "max" would allow callers
> to say "non-negative numbers are not allowed".  But that is not what
> is going on.

Right, currently the value of `max` is used to check the absolute value,
i.e. it imposes a limit in both the positive and negative direction.

> Allowing callers to specify both lower and uppoer bounds so that
> they can say "the allowed values are (-1, 0, 1, 2, 3)", while it
> might make it more useful, is a separate new feature development and
> outside the scope of "let's tighten the parsing of end user input"
> Phillip has here.

Allowing arbitrary limits in both directions might be a new feature, but
it's required if we want to support the full range of values.  E.g. on
my system INT_MAX is 2147483647 and INT_MIN is -2147483647-1.  Currently
git_parse_int() rejects INT_MIN as out of range.

In my eyes the assumption that a single limit can be used to check both
directions of the signed number line is flawed and caused the undefined
behavior.  Dropping it avoids tricky calculations that try to infer the
lower limit somehow and opens the full range of values to us.

That said, I'm not sure how useful the values INT_MIN, INT64_MIN and
SSIZE_MIN (which unlike SSIZE_MAX is not defined by POSIX [*]) actually
are. But doing the checks properly requires separate min and max values.

Ren=C3=A9


[*] Perhaps git_parse_ssize_t() should reject values less than -1; only
that single negative number is needed to represent errors or unlimited.
