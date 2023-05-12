Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121B1C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 19:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbjELTrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbjELTrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 15:47:42 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857366A76
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:47:40 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1967cd396a1so1679359fac.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683920860; x=1686512860;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN1mKvkqSq4Pz8RuMdyQ//ThwTuV4m69YLTSn9+W6Vc=;
        b=sYRWhzGB4EEgiuAbmOIi87U6VlBXFaxRJEL2Yr+0II+QGAe0JDmetuUc8flD3ymku8
         GWfibkGKkoe+WS+c4+iiK5gZlfVC6jQCQAyaz1zKzLCeymiUpjTQvSFu1JqRtFk6iA2A
         aeBhnq7Kjx59nbyECtoaWLwa2hZ+qI3/oZOBpkMyo2kXkQS5kRrkTgJWMPH2p/WB0n/6
         1oqaKlJFgdCIL/8qizjJV0dxBcQlc8tLQMU+2/dnWDLINJrUQkVO0WHKYRv7jrM8K0fe
         L4j6gqoSrJXLuMYpjjZ/XaKTqWPbeoyYPt/byVOBnPMZPNw4dnvNwW1X1EqQvMjIAINe
         FnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920860; x=1686512860;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pN1mKvkqSq4Pz8RuMdyQ//ThwTuV4m69YLTSn9+W6Vc=;
        b=Y+afAQ6WL9ll+c+bIUJMMsstXEFoO/BbFVZhdIaZNVK05EFxTRdrcKofB3AtgqUA7K
         Isj0/9CPKbUxUWAn0L9Dzj9XttESbhlRmYp0zSi3+tzj0c/SrM+LTSwm86ceDbKDuL7T
         z/TMYtSiuYpwKoW0cG8jvbqoirfeSBqjBLxZs+IooKHpdYhtRo+7GlKe3dlbHTo1/8dM
         XWPHVjvWE+4rXhGxFisCKe7L5cBIXlxhFmlJvoSI0cMgqxCyXudpi59jLrpZEtcnjqTn
         2Lmz7qi90PtL054VKQu75Gejwzz/PNRv5zhxAU+EnzLLgxOv+M0foBRs+Gw3XIZQxdIK
         O7fw==
X-Gm-Message-State: AC+VfDxgEmN7N9sbiyVkQodgj+v63WO2B64fo+thIoNsjB7cUFrhcHKa
        0NDZgPxW5fJJaAkquzwU3Nd+PgNiMjk=
X-Google-Smtp-Source: ACHHUZ4GXgzpWYIi1v3Y1/nGmQt0lNa2Le4l7R4nxOzcvlQwrscAOnostWViIekIfKYi4qablHTq8g==
X-Received: by 2002:a05:6870:b7b1:b0:196:87c4:295 with SMTP id ed49-20020a056870b7b100b0019687c40295mr2852549oab.47.1683920859728;
        Fri, 12 May 2023 12:47:39 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u1-20020a05687004c100b00192843c21b9sm9447001oam.25.2023.05.12.12.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:47:39 -0700 (PDT)
Date:   Fri, 12 May 2023 13:47:38 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <645e97da9d11e_21989f2945d@chronos.notmuch>
In-Reply-To: <87h6shif6q.fsf@osv.gnss.ru>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
 <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
 <xmqqo7mpqy6g.fsf@gitster.g>
 <87h6shif6q.fsf@osv.gnss.ru>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:
> >
> >> https://public-inbox.org/git/51E3DC47.70107@googlemail.com/
> >>
> >> Essentially, Stefan Beller was using 'git show --format="%ad"' and
> >> expecting it to show only the author date, and for merge commits it
> >> also showed the patch (--cc). I suggested -s and noticed that the
> >> option wasn't easily discoverable, hence the patch series to better
> >> document it and add --no-patch as a synonym.
> >>
> >> Probably I did not get all the subtleties of the different kinds of
> >> outputs. I guess I considered the output of diff to be the one
> >> specified by --format plus the patch (not considering --raw, --stat &
> >> friends), hence "get only the output specified by --format" and
> >> "disable the patch" were synonym to me.
> 
> So --no-patch, if it were made to disable only --patch from the
> beginning, would still serve the purpose of solving of the original
> problem, right? Please notice that --cc produces no output without
> --patch. Thus, making --no-patch a synonym for -s was a mistake in the
> first place that leaked through review process at that time, and
> 
>    git show --format="%ad" --no-patch
> 
> will still work the same way even if we fix --no-patch to disable
> --patch only.

Indeed.

> > Thanks for double checking.  It matches my recollection that we (you
> > the author and other reviewers as well) added "--no-patch" back then
> > to mean "no output from diff machinery, exactly the same as '-s' but
> > use a name that is more discoverable".
> >
> >> Looking more closely, it's
> >> rather clear to me they are not, and that
> >>
> >>   git show --raw --patch --no-patch
> >>
> >> should be equivalent to
> >>
> >>   git show --raw
> >
> > Yeah.  If this were 10 years ago and we were designing from scratch,
> > the "no output from diff machinery, more discoverable alias for
> > '-s'" would have been "--silent" or "--squelch" and we would made
> > any "--no-<format>" to defeat only "--<format>".
> >
> > It is a different matter if we can safely change what "--no-patch"
> > means _now_.  Given that "--no-patch" was introduced for the
> > explicit purpose of giving "-s" a name that is easier to remember,
> > and given that in the 10 years since we did so, we may have acquired
> > at least a few more end users of Git than we used to have, hopefully
> > your change have helped them discover and learn to use "--no-patch"
> > to defeat any "--<format>" they gave earlier as initial options in
> > their script, which will be broken and need to be updated to use a
> > much less discoverable "-s".
> 
> Fortunately, whoever used --no-patch are very unlikely to actually rely
> on it being a synonym for "-s", as it was always enough for them that
> --no-patch disables --patch, that will still hold after the fix.

That's right.

And let's be realistic for a moment: nobody actually does `git diff-files
--raw`, as that's essentially the same as `cat /dev/null`: a no-op.

The reason `--no-patch` was added was to silenced the diff output of commands
that show a diff *in addition* to something else by default, like `git show`,
and `git show --no-patch` will keep working fine.

Why would anybody do `git show --raw --no-patch` when they can do
`git show --no-patch`?

Yet once again we are doing premature defense for a set of users that probably
don't even exist.

> Finally, this safety concern is even less attractive provided recent
> "-s" fix changed behavior more aggressively yet gets no such resistance.

Exactly.

---

And this is yet another example of why git's UI is stuck and cannot (and
probably will never) be fixed.

Cheers.

-- 
Felipe Contreras
