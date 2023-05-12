Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECE6C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 20:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbjELUaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 16:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjELU3z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 16:29:55 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE6E6A59
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:29:24 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-19290ad942aso7999161fac.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683923296; x=1686515296;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKwSsp2TiMJttvgEPvsTjWVXgnlMxiTieENBeQssdZA=;
        b=VhZYK/BA37ee3GLs1f/p0ApN8HNroT9wcamz6DNMm0DJFyiwtdDqp6kuo4+qJZZt8P
         cE/CDd7jLYZBdxGiT4h9T/C7WbS424zPcFfdYlgI+rgNPm9SuKov1Lp/+F3ey5NtmB7I
         jGFeuJdXvjvjfOoKbOtaLJjjTPkqtJrQhgBX2ifjdl22CTkpcv9jVSEMzohdooU0YF2H
         SBXLaK4xPBqTEComMrhdlAGFWfYTsA9naL3Ug27sFKwwHYDHGlZ/wplPTWVC5hNI84nX
         2/3ksvS8VafK/BvxCzsQwiuFDfeRC0ztfGhgeTWprUW6MVysSp5HY5cqzmNbEczRPwwP
         SOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683923296; x=1686515296;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aKwSsp2TiMJttvgEPvsTjWVXgnlMxiTieENBeQssdZA=;
        b=RkvGaSgZAHsIOeLOinrjPutAFtzWK63Y0CNf5lCNUmHd1FH5Jm0jMfS5OmnUTgkDsP
         /bOJfdjRcQ/kCrXrZRtx9zoHmcBPLdMuRtOG9EMUbTkLVNcfYE0LaIsFAwsFkNHKzijg
         fuzz7OUP+9SkCd14RGYSA5HXthnrkRNKhFuHZFnNhaZgGWB5CLb6xd/kNP049cj13+zf
         om0pUuIm6mkqDsvSz1bAuWZ9QMD6cw69SC/uCSZvfnARwuRRHaBkvkz09br+ftxbedJx
         dLNi8AZVuIq1VS3XuX39Mn8J+E0pfEDIOLYaCmJZgaPTqOJEG6+d8uZcMgJQ3vcBwh0s
         WteQ==
X-Gm-Message-State: AC+VfDzSwqAo38bfn4aKMTkwPAIYbHLUaxcEUWDKH1G74ji4vGs5Hidp
        oDlXOUCM6mIOeZSgWF6I8oy/g4Qgk8A=
X-Google-Smtp-Source: ACHHUZ4FdN2ita7EMUtgXiKpsvo7vbapmwwhxqudizkIPz3PZ/tEzH5j/WKq5iTpQ+CpYJhkSsfR/Q==
X-Received: by 2002:a05:6870:6186:b0:192:a274:3280 with SMTP id a6-20020a056870618600b00192a2743280mr13088861oah.24.1683923296143;
        Fri, 12 May 2023 13:28:16 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id dt12-20020a0568705a8c00b00195e943f958sm6880669oab.1.2023.05.12.13.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 13:28:15 -0700 (PDT)
Date:   Fri, 12 May 2023 14:28:14 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <645ea15eca6fa_21989f294f5@chronos.notmuch>
In-Reply-To: <xmqqv8gxpd8r.fsf@gitster.g>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
 <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
 <xmqqo7mpqy6g.fsf@gitster.g>
 <87h6shif6q.fsf@osv.gnss.ru>
 <xmqqv8gxpd8r.fsf@gitster.g>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Sergey Organov <sorganov@gmail.com> writes:
> 
> > --patch. Thus, making --no-patch a synonym for -s was a mistake in the
> > first place that leaked through review process at that time, and
> >
> >    git show --format="%ad" --no-patch
> >
> > will still work the same way even if we fix --no-patch to disable
> > --patch only.
> 
> Not so fast.  I have a show.outputFormat configuration variable to
> teach builtin/log.c::show_setup_revisions_tweak() to tweak the
> hardcoded default from DIFF_FORMAT_PATCH to others (primarily
> because I often find myself doing "git show -p --stat").  Changing
> "--no-patch" to toggle only "--patch" away will close the door for
> future improvement like that, and "will still work" is an illusion.

So your rationale to reject a perfectly logical behavior that *everyone* agrees
with is that it might break a hypothetical patch?

Just do `--silent` instead.

> The user needs to be told that "--no-patch" no longer means "-s" and
> somebody needs to apologize to them that we are deliberately
> breaking their reliance they held for 10 years,

Nothing is broken.

And we never apologized for choosing the wrong default in `git pull`, did we?

> based on what we documented and prepare a smooth transition for them.

The transition is easy: just use `--silent` instead of `--no-patch`.

We could add a warning that these semantics will change in the future, instead
of just changing it right away.

But I bet very few people will see that warning (if any), because it makes
little sense to use `--no-patch` to turn off something other than `--patch`.

> Until the time when nobody uses "--no-patch" as a synonym for "-s" any
> longer, such a future improvement would be blocked.  And that is another
> reason why I want to be much more careful about "should --no-patch be changed
> to mean something other than -s" than "should -s be fixed not to be sticky
> for some but not all options".

> The latter is not a documented "feature" and it clearly was a bug that "-s
> --raw" did not honor "--raw".

Users can rely on what you call "bugs".

It's still a backwards-incompatible change for which you did not provide a
transitioning plan in [1].

Or is it a backwards-incompatible change *only* if the person proposing the
patch is somebody else other than the maintainer?

[1] https://lore.kernel.org/git/20230505165952.335256-1-gitster@pobox.com/

-- 
Felipe Contreras
