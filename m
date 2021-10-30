Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29A0C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 16:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DC660F93
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 16:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhJ3Qr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 12:47:28 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:23790 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhJ3Qr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 12:47:27 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4HhQBb0Q60z5tl9;
        Sat, 30 Oct 2021 18:44:54 +0200 (CEST)
Subject: Re: Git not commiting anything if file created and "git add"ed in
 pre-commit hook is the only file in the staging area
To:     Peter Hunkeler <phunsoft@gmx.net>
References: <0165d68f-79a7-d8b7-1bba-89a1449e87a7@gmx.net>
 <YXnNvyi62j5gcxQV@camp.crustytoothpaste.net>
 <dd79e443-3bb9-8b83-746b-7db7c4997ee3@gmx.net>
 <c5507ba6-6e31-b143-9791-0bcff54acb64@gmx.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailinglist <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4c88e2ae-e42f-491a-2b97-aa1f92c392d5@kdbg.org>
Date:   Sat, 30 Oct 2021 18:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c5507ba6-6e31-b143-9791-0bcff54acb64@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.10.21 um 15:21 schrieb Peter Hunkeler:
> Pardon my ignorance, but I'm unlear as to how to proceed further with my
> issue.
> What is the proper process to report a bug, and get a consense whether
> it is accepted or rejected?

Writing a message to this mailing list is all the process that exists.
You brought forward arguments in a civil manner why you think the
current behavior is not correct. That's appreciated. However, it doesn't
automatically mean that something will be changed.

In your particular case...

> Am 28.10.2021 um 14:08 schrieb Peter Hunkeler:
>> Am 28.10.2021 um 00:07 schrieb brian m. carlson:
>>> I should point out here that it isn't intended for pre-commit hooks to
>>> be used this way; they're intended to verify that the commit meets some
>>> standards, not to modify it, although it is of course possible to do.
>>>
>> I can accept that comment. However:
>>
>> - wouldn't you agree that git should work consistently? It does not in
>> this case. If there is anything to be commited in the index, then the
>> "git add" from within the pre-commit hook *is* respected in this commit.
>> If there is *nothing* to be commited, except from what was added by the
>> pre-commit exit, then it is ignored *for this commit*, but it is added
>> and will be commited next time. This is inconsistent behaviour.
>>
>> - if the decision will be *not* to allow adding from within a pre-commit
>> hook, then the "git add" should be rejected. And the documentation
>> should say so.

... it is clearly stated (and brian repeated it) that the pre-commit
hook is intended to check the commit for "correctness" (whatever that
means for the project). `git add` is not automatically forbidden,
because it would be an unreasonable engineering effort to forbid things
that "do not merely check" the commit. (What if a user has to use `git
add` as part of some exotic check? For example, it is possible to `git
add` to some temporary throw-away index that is different from the one
that is about to be committed.)

Even though the documentation does not say explicitly that the commit
must not be changed, it is implicit in the stated intent (that the
commit is only checked). Depending on that some particular behavior
works for you sometimes is then your own business, and when it breaks
you get to keep both parts.

In conclusion, the pre-commit hook behaves as designed and nothing has
to be changed.

-- Hannes
