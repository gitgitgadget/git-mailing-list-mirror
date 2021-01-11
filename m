Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E76C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32023224F9
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 09:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbhAKJW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 04:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727741AbhAKJW5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 04:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610356891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKj8CkNmhNtH4P0o8EgrRyku2myKnzsLLRq1YvTI7TI=;
        b=QSELU4PkADSIzu0aUU8w3oRtufoFsg4zIzOKHygyUIoyVKUah+8Mv52FXBqGWXPCITdOPb
        NUtxpLw/F+48GALyCGc2HcgNotNkxzJHY5m0ee4iFtRNQhuiBSoCOpnn37mT/i1oMeWemG
        GpLPGIU6hhIRP0DtY96TSo1bKRbnJ4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-O5d-NREePBO7YsppxMssig-1; Mon, 11 Jan 2021 04:21:29 -0500
X-MC-Unique: O5d-NREePBO7YsppxMssig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA55E10082E3;
        Mon, 11 Jan 2021 09:21:27 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-91.ams2.redhat.com [10.36.113.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA9DA19813;
        Mon, 11 Jan 2021 09:21:26 +0000 (UTC)
Subject: Re: [RFC PATCH] gitk: Activate --find-copies-harder
To:     Robert Pollak <robert.pollak@posteo.net>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
References: <b12574f0-3ebc-95c0-9def-555150257e46@posteo.net>
 <46693c60-98ee-b6c9-df8e-12216622ddf9@redhat.com>
 <b0c0a630-25a9-8ef8-2270-fa40404c2897@posteo.net>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <23445a9c-46b2-0232-845b-c8d5fe36d506@redhat.com>
Date:   Mon, 11 Jan 2021 10:21:25 +0100
MIME-Version: 1.0
In-Reply-To: <b0c0a630-25a9-8ef8-2270-fa40404c2897@posteo.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/10/21 13:59, Robert Pollak wrote:
> On 2021-01-06 16:58, Laszlo Ersek wrote:
>> On 01/04/21 20:54, Robert Pollak wrote:
> [...]
>>> I see the following problems with my patch:
>>>
>>> 1) It is totally untested with all the other args that are collected in
>>> diffargs, like e.g. "-O<orderfile>", since I didn't need them yet.
>>
>> It would be really great if gitk supported both "-O<orderfile>" and
>> --find-copies-harder!
>
> Can you please test these options with my patch and report back?
>
> -- Robert
>

The patch doesn't apply with git-am (I'm trying on top of 72c4083ddf91):

> Applying: gitk: Activate --find-copies-harder
> error: corrupt patch at line 100
> Patch failed at 0001 gitk: Activate --find-copies-harder
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".

One problem could be the embedded diff in the notes section (I guess it
could confuse git-am).

Also, "gitk" has existed at "gitk-git/gitk" since commit 62ba5143ec2a
("Move gitk to its own subdirectory", 2007-11-18), so the pathname
headers in the patch look wrong.

Thanks
Laszlo

