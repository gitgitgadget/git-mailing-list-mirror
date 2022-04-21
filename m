Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D37DC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392118AbiDUT6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392109AbiDUT6G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:58:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD2275DC
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:55:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id f17so7870105edt.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XlNiqcHmzGzcPDzpDt8aDXWnmNfgEk9PEcw9FxggYww=;
        b=E5HV1tJvr7u37veca0EXIwdS5AH1XqhNKkBK/XsLzAY/RCpalPSR0YnR9yaVtNsI3k
         0mHWZ5kB9DnYbXAZ6YMwFwXDwN7+49t241mJQ5RrE6ZwFEJj5hz4J821WfZ8t2oKNaO4
         RkB055aPMOLxnXKSDR+OWJJoxMT/7rqGWYPcm5rjFnkN1tVmIeZy6KSr1AOdoCxKIaoF
         o/e2jddYkXNNtsFysHfWMhwAY3JLVWGz0RQOP5x3ThuOsmWqE6u5OA9O8Q8lgJwFfWOG
         3Vvzi3y62cdEUv6nOwKlZcfXSWTbXl0WAPOlrURS0YjIIZPB7tE18VRWXz9llOK7MbZ7
         59bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XlNiqcHmzGzcPDzpDt8aDXWnmNfgEk9PEcw9FxggYww=;
        b=TZ8yBJwROB6IrN3ftc2AERI7f5dMnz8yt3KF/LS0blYNi+EVCaBR1A1pjWaF62SnBv
         5wsqdr3k6jhMqGwVcggAGKH4kdbAD5JMEk3WQyGi73mBmHJlLV5UKmG0yOZ87YIjj8zq
         GsFtUq24dBECsmXsroN30A2IqCUd4UwdVNE1LU0RV4VIwDBiAiuKF6wXIVnCia4M3pe4
         PxokZQZG5LCiNdTTBFayQLujibgdUSWT7jT6XAtpZgRdwZONY9Pyw0JX3Q/NyLapbGwo
         Dy2y6gXkpDfe3ckewcBxnfgGXGqnMf2AseR83Ocuel9keqJDOngTxAHXr9bgO+zEdHbq
         oOYg==
X-Gm-Message-State: AOAM533dRweBqbGvhlRzLyvtQYadbU3YmaXhS+HhZQ/A5OT20acProyS
        P+Z5gb3zjNe/UhSpZr2L338=
X-Google-Smtp-Source: ABdhPJyXtPFiXzJbGVxQ47YSmhDT36vDbdCrUoX8V7pgcWvH619g1VwrQT+Jr5WY4uiaJyNybZOcIw==
X-Received: by 2002:a05:6402:f20:b0:41d:9709:f853 with SMTP id i32-20020a0564020f2000b0041d9709f853mr1226780eda.412.1650570913910;
        Thu, 21 Apr 2022 12:55:13 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906540700b006d5eca5c9cfsm3422ejo.191.2022.04.21.12.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:55:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhctU-008BJI-Qz;
        Thu, 21 Apr 2022 21:55:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v2] CI: select CC based on CC_PACKAGE (again)
Date:   Thu, 21 Apr 2022 21:52:57 +0200
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
 <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
 <xmqqzgkegspg.fsf@gitster.g> <220421.867d7i6ycr.gmgdl@evledraar.gmail.com>
 <xmqqlevygqqc.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqlevygqqc.fsf@gitster.g>
Message-ID: <220421.86y1zy5hzz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I'm happy to rephrase it however you'd like, but I'm a bit confused by
>> the "saw any mention in the proposed log message". I'm fairly sure
>> paragraph 2 onwards covers this, i.e. how linux-gcc's behavior is
>> changed (as it also regressed).
>
> Yeah, true, """Likewise for the linux-gcc job CC=3Dgcc-8 was changed
> to the implicit CC=3Dgcc, which would select GCC 9.4.0 instead of GCC
> 8.4.0.""" that you wrote is exactly about it.
>
> I was confused because immediately after that you said it was not a
> bug, so I dismissed it as not part or the real issue.  Perhaps
> striking that "not a bug" part may make it less confusing?  I dunno.

I'll rephrase it, but I probably won't get to it tonight, sorry.

What I was trying to get at is that the linux-TEST-vars job was
affected, and *does* have a CC_PACKAGE defined, but in that case (and I
was the one who split it out) the point was never to have it use its own
compiler. For any of these platform/compiler combinations it's enough if
we cover that platform/compiler verison once.

So the right thing to do with linux-TEST-vars is to just have it use
"vanilla", because it's special in other ways. So if and when it fails
we don't want to worry about untangling the two variables. I.e. is it
the special-versioned compiler, or is it (and it almost always would be)
the GIT_TEST_* variables. In that case we should only need to worry
about the latter.

>> What I suppose is left undiscussed is that jobs that don't define
>> CC_PACKAGE at all won't be impacted, is that what you wanted to be
>> explicitly mentioned?
>
> Yes, I agree that is a good idea, too.  Or you can steal the "before
> and after" table I gave you in the message you are responding to, if
> you think it helps.

*nod*
