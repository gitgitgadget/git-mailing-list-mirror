Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A3CC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 17:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBWRPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 12:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBWRPM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 12:15:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBAF4FABF
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 09:14:41 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso9824282pjn.4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 09:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xaiuMcgwQkdGUuPQk0mdOsYiy3jHXr8IK+jxvjuosU=;
        b=UAyJFAaAITI6xGiqcMmSzOqupQcE9gbxWSqvUfSlwdqJMpo+ACBXRx7gir9tl/uEmn
         DsMw2NBIyJeamk3+N5LuIWL9vMFWY/rwmpJZaqiXiDtZga7bi7M7JbSoFyuIfZxBrqGY
         WAUv3r6YrnRHXAPYyotHKkTCgXwUrB8q6dGMxcpLrNlpObTqOjMpv7BVNJxW0bIYPm4f
         HSHqcaLHdUh/V0KVx0pFYRbMryCgKLcCKvJ70y8Ey8EazYMrolFDJiqnUjyGS8GgJcXa
         P71JvwmlGjQdofgkduE544mxS8ad8QAQKZIojh5Lg8mPgVwE1He7Le1CLCFKESb7Ovda
         E9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+xaiuMcgwQkdGUuPQk0mdOsYiy3jHXr8IK+jxvjuosU=;
        b=3ruSmfdbaFaPRLp439+QvOL8gIfo9LRW6doj69Xw9T6vT52tMRiMKRa8ptv7wjYsiD
         m4isg7RutyKueDNUgPEBcAQmtO5tBLLXnP89YL0A6BOAqJRc0xh1zheLfhD4yFKynkbm
         dcsyiEqeegAp+RGKjvtJVajYqNF9tKvAIOLd3TinLXAIiUGZj9tw9zrGtCXHrcl0Y8e4
         PqW49krnq0dAgY9QLnYJL5u1AYZRDKA0CIaPMSlT7+rAkeIek7efWaXQFPBVxR/CqYpA
         kW3b4Q3mnssCMeV1HcwNRxGaBQOI6zYvmjdk7MzBwpsxxvojw33eeDCMz3ciTG/ZByKM
         m8rg==
X-Gm-Message-State: AO0yUKWYKb4t4UfW6/PJjBx5kCmdC3iTI2U2Mii54s81ExE2L1IA2qw4
        +++lm1pNK3MIT3xtgLHyF20G2zOEJic=
X-Google-Smtp-Source: AK7set+loeIrW02Q6OpUAYCdhh/rHHGmZSugwEAcDgb0yRjZsy6fy/KAIyYfYg8qc08E1yhMMI1BMw==
X-Received: by 2002:a17:903:2345:b0:19b:5f88:797b with SMTP id c5-20020a170903234500b0019b5f88797bmr15176567plh.28.1677172479269;
        Thu, 23 Feb 2023 09:14:39 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902bd4a00b0019c2cf12d15sm9263119plx.116.2023.02.23.09.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 09:14:38 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] update-ref: add forward command to safely fast-forward
 refs
References: <20230223011530.47477-1-ronan@rjp.ie>
Date:   Thu, 23 Feb 2023 09:14:38 -0800
In-Reply-To: <20230223011530.47477-1-ronan@rjp.ie> (Ronan Pigott's message of
        "Wed, 22 Feb 2023 18:15:30 -0700")
Message-ID: <xmqqpma09udd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ronan Pigott <ronan@rjp.ie> writes:

> forward is an update-ref command that behaves similarly to update, but
> takes an additional argument, <ancestor>, and verifies that the new
> value is a descendent of ancestor before updating. This is useful for
> fast-forwarding prefetched refs.

Why is this necessary?

 * Do you expect that you may not know the ancestry relationship
   between the <newvalue> and <ancestor> values when you need to
   compute them, in order to formulate the 'forward' command?

 * Is there a case where the relationship between <newvalue> and
   <ancestor> that was fast-forward when you formulated the
   'forward' command changes by the time the 'forward' command gets
   executed?

I do not see the reason why this new command is needed, unless one
or both of the above is what you are trying to address.

For example, existing "delete SP <ref> SP <oldvalue>" is to protect
the ref you want to delete, that used to have the oldvalue back when
you created the 'delete' command, from getting deleted when somebody
else changed it from the sidelines.  We can do

	oldvalue=$(git rev-parse refs/to/be/deleted^{object})
	echo delete refs/to/be/deleted $oldvalue | ...

and let the command notice if somebody else changed
refs/to/be/deleted in between.  It is similar to the second one
between the two I cited above, to make sure that your command does
not overwrite what somebody else did.



It may make some sense if the new <ancestor> thing is to replace the
<oldvalue> thing, though.  That is, if there were a three-commit chain

	A---B---C

where the ref you are trying to update currently points at A and you
want to update it to C.  You would observe that the current value is
A, and formulate the command line:

	update ref/to/be/updated C A

with the current system, and updating the ref is allowed only when
nobody touched the ref in the meantime.  It is _conceivable_ to say
that we are OK as long as the ref points at a decendant of A
(instead of pointing exactly at A), and is an ancestor of C (the
value we are updating to), with

	fast-forward ref/to/be/fast-forwarded C A

Then somebody else _could_ update the ref to B from the sideline,
but we notice that it is a descendant of A and an ancestor of C, and
we are still allowed to update it to C.

Even in that case, I am not sure how useful it would be, but at
least that use case I can see why it may make sense.

If you can write <newvalue> and <ancestor> on the command line, you
certainly should be able to compute "git merge-base".  And because
the commits are immutable, it won't change in the middle.

So, I am not very impressed.  Unless I am missing something, this
does not seem to be adding anything we cannot already do.

I wonder if

    git fetch . "+refs/prefetch/remotes/origin/*:refs/remotes/origin/*"

(with or without the '+' prefix, depending) what you are really
going after, though.
