Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F320C77B78
	for <git@archiver.kernel.org>; Thu,  4 May 2023 15:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjEDPub (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjEDPu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 11:50:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191161FD9
        for <git@vger.kernel.org>; Thu,  4 May 2023 08:50:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24e1d272b09so553489a91.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683215427; x=1685807427;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtXszEfa+eyMpVr2U3oskChTavrgzbkhFpTEdsvG8hQ=;
        b=SeZPDlTVnJN4b5eVm9oLNFDeePQSSMgarAHrREuxOPqy8C4AZBL9I87xq87WdThRqt
         AO1M9KAqgV9LOkBKYCpIPyRpCdIAr+yOyH/GjQN/KBuCwkCpEWdHiR3FwaQR7iSn1R51
         IdP1fYyr3X041IKKFtIRKRe4fiatmWLcebyE7jijK7DqwuC7Lq1O/wJCXs8rjYUgP5y2
         xslL2/xI/Di8avPenp7FkpbD4UVWb5e1Jy4Hg9uU/vdAg48slpT01OW3g8vmGoYRbLRf
         MX+4KqO5hM5Pngm2v85v3sMV00VUVoJETmxP0Y0oLQgV/5NTFOg6hUsRZZ52Tq7UvfNk
         /MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215427; x=1685807427;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WtXszEfa+eyMpVr2U3oskChTavrgzbkhFpTEdsvG8hQ=;
        b=fFztkir+m5/Ojqcsqgdje4iXQtrlgZQxyZp6c1TEZXPh46d4FCQFPxSyy2MIV7wVxF
         9yPsUAesyYXDdPWoPF6VaDyphsdknVi/tEYmXAWuanm8ofklzGXF2Rdv/mrm58HHsVYd
         L1Ya03LdIR3X45dqzcVB3t7UJ009pKiunZl9WXZDNtFFW9Ow36WKTTObrxrA+1kLnL2W
         3/DfcvNDTtPoGdpT/eBUwFe/D+XPdWlVewmmzQnoCm53d/EOWcQ6J9nFuaMcfL1R6N/o
         EJ3VnFZhns0t2NUXrLLqOVlriBUN+C2BcfkfjLuXHE0X7R/edjL4BHiL3THZG2B14nYz
         ORUw==
X-Gm-Message-State: AC+VfDy1jLpwBSSzkATUREZlJYGwUq4JvMNC2rCCwR9i5RYve8lbaPaH
        vKWIFlPWkvN7ReWXq6l6S14=
X-Google-Smtp-Source: ACHHUZ4c/vVZpoVKsKaHndy9oC6R+WlIO0eVlVPfmCwuFgj7Rm2KgXIubXrueBasCs9JoEnP0RrRnA==
X-Received: by 2002:a17:90a:fd81:b0:24e:3206:7ca9 with SMTP id cx1-20020a17090afd8100b0024e32067ca9mr2613398pjb.46.1683215427479;
        Thu, 04 May 2023 08:50:27 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090ac08f00b0024b79a69361sm3277939pjs.32.2023.05.04.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 08:50:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g>
Date:   Thu, 04 May 2023 08:50:26 -0700
In-Reply-To: <xmqqmt2lqofb.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        03 May 2023 11:07:20 -0700")
Message-ID: <xmqqttwskse5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> No problem from my side, but are you sure?
>
> Absolutely.
>
> I've seen people just say "we document a failed one" and leave it at
> that, without attempting to fix.  I am trying to see if pushing back
> at first would serve as a good way to encourage these known failure
> to be fixed, without accumulating too many expect_failure in our
> test suite, which will waste cycles at CI runs (which do not need to
> be reminded something is known to be broken).  I will try not to do
> this when I do not positively know the author of such a patch is
> capable enough to provide a fix, though, and you are unlucky enough
> to have shown your abilities in the past ;-)

I ended up spending some time digging history and remembered that
"--no-patch" was added as a synonym to "-s" by d09cd15d (diff: allow
--no-patch as synonym for -s, 2013-07-16).  These

    git diff -p --stat --no-patch HEAD^ HEAD
    git diff -p --raw --no-patch HEAD^ HEAD

would show no output from the diff machinery, patches, diffstats,
raw object names, etc.

And this turns out to be a prime example why the approach to ask
contributors do more, would help the project overall.  What I should
have done, instead of asking for the test with its expect_failure
turned into expect_success *and* a fix to the code to make the new
test work, was to ask to see if it is really a bug in the behaviour
or if the documentation is wrong.  Then your reaction wouldn't have
been "are you sure?".  It hopefully would have been "ah, the intent
is not documented correctly, and here is a documentation patch to
fix it."

When a command does not behave the way one thinks it should, being
curious is good.  Reporting it as a potential bug is also good.  But
it would help the project more if it was triaged before reporting it
as a potential bug, if the reporter is capable of doing so.  Those
who encounter behaviour unexpected to them are more numerous than
those who can report it as a potential bug (many people are not
equipped to write a good bug report), and those who can triage and
diagnose a bug report are fewer.  Those who can come up with a
solution is even more scarse.

Thanks.
