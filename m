Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF1FC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 17:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjC0RtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 13:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjC0RtE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 13:49:04 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8DE40DE
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 10:48:49 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id z14-20020a170903018e00b001a1a2bee58dso6160500plg.3
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679939329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=itf5BGtTPFFms1WcsB1+1tzEkyqyRG+Ndyc8KLdmkxg=;
        b=Qyk9cvB30StBTrxxHcQcTJqgfACbaTwKSh44170spPROINsdHzCEEXn6BtvIWafe6Z
         Yu3oImG5db/Bv/juejQvuWzwNf8Gi0T4OAjFbHyoBNSBqH6obl4yYxzeJE2oGgEhtQAe
         0Ehrm4GVVqKKbJGqdVlkOSz335xKG5BBWgOs7opJJdPCSs7zt5QwwF2MdWY2Myf1polh
         ozsP9Bejy4mmVZbNQzBntiwxH/NodJRWPNDy1HpFpS46i6kmvbuxZtvOcDIpBFf6Xc0o
         FGKbmiPtkUv0ks2FOl1Li90SFD+HHzBtX8Y2x2w4JnQdUcYgq4FUAdB7wJ/hq314jhTm
         pu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679939329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itf5BGtTPFFms1WcsB1+1tzEkyqyRG+Ndyc8KLdmkxg=;
        b=DDRZR/uMUZUJh3xiZUe/E8Uh75YAGOoydHOg1bYnx/LiibMelKSyD2a77ZWYbDteWU
         isrnzpyW2ei33r+dOH7MtapLB1EcAg1vWhmcoH21ZFGirt8X53R/gJTIDsUF1+zeaDa6
         WXhCY74ZDFrbYQaH2C05MGKKr5nupnLbxbqpEiDqRAyjITD/M9iFNryVygBJ4UUz35GO
         fcao+QVeNKhimW7fUI0VKFNajKQrCkuLFZEhwzkmhG4V1Wcy6oqZDxzGUDkczxigQwhD
         AOZes3i4c6le7GSWT7z8bC8jcV70lj9vVC6EcfOsPMlBwedmVCBipyAPnQ/5ElNiibma
         WFtg==
X-Gm-Message-State: AAQBX9e12r+EoaS3BfgHJ+fW5KL0cYSm+JysNlvwpWZSZ99kzzzVj+/G
        Xm671INvw7/cmQ7vfPe/vOTJqNkknPIT2g==
X-Google-Smtp-Source: AKy350bx2oI1gYOGQ9IDDDLNcABvem//lsESsO79p7eiPCuNw4HedreQZ4TJ78dOU7Nh2wWRUzptId1XADrZBA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:228a:b0:1a2:1674:3902 with SMTP
 id b10-20020a170903228a00b001a216743902mr4608647plh.10.1679939329219; Mon, 27
 Mar 2023 10:48:49 -0700 (PDT)
Date:   Mon, 27 Mar 2023 10:48:47 -0700
In-Reply-To: <xmqqsfdwbeh0.fsf@gitster.g>
Mime-Version: 1.0
References: <20230322173421.2243947-1-jonathantanmy@google.com> <xmqqsfdwbeh0.fsf@gitster.g>
Message-ID: <kl6lzg7yccg0.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH] bugreport: also print value of no_proxy envvar
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Taking off the author's hat and putting on the reviewer's hat, I'm
>> not so sure if this is the right approach, since $no_proxy might have
>> information that the user doesn't want to share (especially since it
>> could be used beyond the current repository, and even beyond Git), the
>> user being informed that they can delete any lines notwithstanding.
>
> [...]
>
> Or other environment variables like http_proxy may be causing harm
> to the user's use of Git, and inspecting no_proxy alone may not give
> you anything useful.  With devil's advocate hat on, I am tempted to
> suggest another approach at the the total opposite of the spectrum:
> dump everything in **environ and let the user edit out what ought to
> be private.  Intelligent ones may even notice a fishy setting they
> forgot about while trying to cull the report of these environment
> variables ;-)

For this series, I think the natural extension would be to grow the list
of environment variables to include everything that might affect Git?
I don't know how possible or sustainable that is, so Junio's idea (or
Junio's devil's advocate idea?) makes some sense from that perspective.
However, oversharing by default sounds far too unsafe to me.

Also, I suspect that dumping all of the environment variables might
sometimes be a hindrance. e.g. I can imagine a conservative user
removing $no_proxy. Then, on the other side, the report reader sees the
list of environment variables, assumes that since $no_proxy is unset
because it's absent from the report, and goes on a wild goose chase.

I wonder if it would be helpful to know that $no_proxy is set, even if
the report doesn't say what the value is. If so, an okay-ish middle
ground might be to dump all of the environment variables but redact them
by default (maybe something like git bugreport
--dump-envvars=[redact|no-redact]). I don't know how well this will work
in practice though. Personally, I'd still lean towards trimming down the
list of environment variables, even if the values are redacted.
