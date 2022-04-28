Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF7C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 20:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351915AbiD1UwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiD1UwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 16:52:13 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC68C0E5D
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:48:56 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id u19so2202627uaw.11
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQc72mxWCzuFQmkzqiaYLExz0qmGH853LOevLFZoAtU=;
        b=oniHrSWIlMYWe2gsUcVBCp4fhc9weKKlC3EMCdaAxc3HndpkWxCRcS3x25pnyRyxEe
         bv8nG+ha1u74zfxyJUTgq/HTjclNun4ugbwzmLJeD2PgH8fTKaAFNw/9NNjOCW4Gzav1
         fqSsn64enkl5pJB4PUNOryAaqjhLUq2+6jGcMiiUAEhTL/aZGNHxEJCIdrlJDcEl4E+X
         OLfq+ZxZNQ38q6xE3NTVJevGXU7yycFvMCEZ3uty8xIgRwOojTrcS7tuyHGW5f5BBZX4
         Lud20qRAa2UvndC3V+pqs99eRuQZ/u3/3JBK9atuZp54zwCExpBYv+iSukqEzeXZ41qA
         16RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQc72mxWCzuFQmkzqiaYLExz0qmGH853LOevLFZoAtU=;
        b=kkyLCA58U/6AJszhN3xp1w6MPgIYoQPyi4RFfKwubK8vxSUqKMfv+eeOB9CrvRiLq/
         qdHrgsdlXA1TiakgIxfvIDlsDk7MR0aF6ColhhOLu5qeZ3ePQ1giOpyooF5C8l4POV1V
         NXKa34dbYvEL9pOvDs0sxFDprSez0FWiDrg/1Abkx8J7u37zmajKvXg5XwkV6e6YEu+6
         2aVRqOlvMrZG+IIIaMlVw0vkXVN+tqXywda7o9t1DSXo9CbQ7XMJmCQakLouVk6CUgXg
         bGPaBG9BkN2Kx6oB+PrH58idZO0C4GUMNQJS73HBvaEWxw+P/d5AZTYoKEiSgHGpQ4Pb
         m/Aw==
X-Gm-Message-State: AOAM531aqx9gOawWMnvQhgGIbAxHbTrOyp2/T279ioTxlCLod6OaBtDl
        +fkO/IKQ+vhFFUkUDgVrpIA11PGNe5VLjUxsWGQ=
X-Google-Smtp-Source: ABdhPJx/xEDl6XYeXNJVq9EhBZ9nnvYEK23HG8Aw5ydbOvZrKxq5yH6vLd62dAetFUBIntpu2eCCGHXZcVo4Jr1z78s=
X-Received: by 2002:ab0:6e8a:0:b0:362:8836:558 with SMTP id
 b10-20020ab06e8a000000b0036288360558mr8976860uav.62.1651178935902; Thu, 28
 Apr 2022 13:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220428033544.68188-1-carenas@gmail.com> <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-4-carenas@gmail.com> <xmqq7d79du6c.fsf@gitster.g>
 <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com> <xmqqbkwleypf.fsf@gitster.g>
In-Reply-To: <xmqqbkwleypf.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 28 Apr 2022 13:48:45 -0700
Message-ID: <CAPUEspgu4wNsgh_8JNENEYG9g5BWsef-5OGoSF3DQuem1BnijA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2022 at 1:32 PM Junio C Hamano <gitster@pobox.com> wrote:
> On a box I happen to be using, the grep gives me
>
>     Defaults secure_path=/usr/sbin:/usr/bin:/sbin:/bin
>
> and makes the prereq fail.  Which is sort-of expected, and I
> understand why this check is here, but I suspect that any sane and
> sensible installations would reinitialize the path to a fairly
> restricted one with the mechanism, so we wouldn't be testing this on
> majority of places, I am afraid.

our CI runs with macOS should still work, and any place that does is
better that none IMHO

> What we really care is that we use the same PATH as the test
> environment uses, including "we want to test the binary we just
> built" (or "at the specified path", when GIT_TEST_INSTALLED is in
> effect).  I wonder what the right way to carry $PATH and other
> environment variables down to whatever "sudo" in the test runs.

sadly the issue is even more insidious because the PATH is not
changed, but sudo ignores it when going to look for a binary to run

>     $ foo=foobla; export foo
>     $ sudo sh -c set | grep foo; echo $?
>     1
>
> so resetting PATH from an environment we export, e.g.
>
>     USE_THIS_PATH=$PATH sudo sh -c '
>         PATH=$USE_THIS_PATH
>         ... invoke our git normally here  ...
>         git status
>     '
>
> would not work X-<.  Worse yet, other environment variables such as
> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME that we set in our tests may
> probably be cleared before "sudo" runs any test command, so rejecting
> an installaion whose "sudo" resets PATH with the above check is probably
> insufficient to give our tests a reasonable envionment to run in.

I think we are confusing, running the whole suite with sudo vs running
a specific command inside a test with it.  We obviously will need to
adapt our suite a lot more before it will natively support sudo and
that might never happen as well, since there are conflicting
objectives there.  IMHO that doesn't mean we shouldn't try.

Maybe I should document better what I meant with "awkward", but yes I
was serious when I said "minimal support" for running things through
sudo, but I should mention the ones you provided almost worked AS-IS
so it is not that bad IMHO.

Carlo
