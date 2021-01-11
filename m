Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED8C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 16:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0224822ADF
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 16:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbhAKQ35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 11:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731400AbhAKQ34 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 11:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610382509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q7D4OwRHK0QBOhqWUCccVv5qiY5YleHdi0GWDfbQu4w=;
        b=cPoNWvcb2zDNGv8LpyE4GvqaXbmt5xutX3rvveplfe7Oq21xZjjr2bKrCM//c+HNpXFBGl
        2wwDRXWDETJaoCNlrkUogkJMaIYiMfTa1vuYc8f81wsT7nNfDnGZRwWo0tAZQ+AecmPVwq
        kg11MffFVHXBdEHPZ+n80cI+CV6yezs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-aaNCDAuGMwOUURrqsrbbYQ-1; Mon, 11 Jan 2021 11:28:27 -0500
X-MC-Unique: aaNCDAuGMwOUURrqsrbbYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87CBB18C8C04;
        Mon, 11 Jan 2021 16:28:26 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-114.ams2.redhat.com [10.36.112.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43CA0100164C;
        Mon, 11 Jan 2021 16:28:25 +0000 (UTC)
Subject: Re: [RFC PATCH] gitk: Activate --find-copies-harder
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Robert Pollak <robert.pollak@posteo.net>,
        Paul Mackerras <paulus@ozlabs.org>, git@vger.kernel.org
References: <b12574f0-3ebc-95c0-9def-555150257e46@posteo.net>
 <46693c60-98ee-b6c9-df8e-12216622ddf9@redhat.com>
 <b0c0a630-25a9-8ef8-2270-fa40404c2897@posteo.net>
 <23445a9c-46b2-0232-845b-c8d5fe36d506@redhat.com>
 <87mtxfwt3e.fsf@yadavpratyush.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <d1f1691b-2fdc-1e6e-b346-31afb6aa5532@redhat.com>
Date:   Mon, 11 Jan 2021 17:28:24 +0100
MIME-Version: 1.0
In-Reply-To: <87mtxfwt3e.fsf@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/11/21 13:33, Pratyush Yadav wrote:
> On Mon, Jan 11 2021, Laszlo Ersek wrote:
> 
>> On 01/10/21 13:59, Robert Pollak wrote:
>>> On 2021-01-06 16:58, Laszlo Ersek wrote:
>>>> On 01/04/21 20:54, Robert Pollak wrote:
>>> [...]
>>>>> I see the following problems with my patch:
>>>>>
>>>>> 1) It is totally untested with all the other args that are collected in
>>>>> diffargs, like e.g. "-O<orderfile>", since I didn't need them yet.
>>>>
>>>> It would be really great if gitk supported both "-O<orderfile>" and
>>>> --find-copies-harder!
>>>
>>> Can you please test these options with my patch and report back?
>>>
>>> -- Robert
>>>
>>
>> The patch doesn't apply with git-am (I'm trying on top of 72c4083ddf91):
>>
>>> Applying: gitk: Activate --find-copies-harder
>>> error: corrupt patch at line 100
>>> Patch failed at 0001 gitk: Activate --find-copies-harder
>>> hint: Use 'git am --show-current-patch' to see the failed patch
>>> When you have resolved this problem, run "git am --continue".
>>> If you prefer to skip this patch, run "git am --skip" instead.
>>> To restore the original branch and stop patching, run "git am --abort".
>>
>> One problem could be the embedded diff in the notes section (I guess it
>> could confuse git-am).
>>
>> Also, "gitk" has existed at "gitk-git/gitk" since commit 62ba5143ec2a
>> ("Move gitk to its own subdirectory", 2007-11-18), so the pathname
>> headers in the patch look wrong.
> 
> gitk is maintained as a separate repo by Paul Mackerras at
> git://ozlabs.org/~paulus/gitk, and then is pulled into the main Git repo
> from time to time using a subtree merge. That's how gitk changes end up
> in gitk-git/. Patches for gitk should be based on the gitk repo to make
> it easier for Paul to apply them.

Thank you for explaining!

(I guess I'm more familiar with submodules than the subtree merge
strategy in general; I've had to look up the latter on the web now.)

> In short, the paths are fine.

I tried applying the patch again, now on top of 6cd80496e9d3 ("gitk:
Resize panes correctly when reducing window size", 2020-10-03) -- it
turns out I'd actually had a clone of the stand-alone gitk repo you
mention, I just needed to pull.

But: git-am fails the same way.

Thanks
Laszlo

