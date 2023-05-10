Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E83CC77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 21:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjEJVyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 17:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjEJVyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 17:54:23 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A37B5263
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:54:22 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ab19cf53f7so2036118a34.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683755661; x=1686347661;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZhJ8Oybemtgz5njoRhar+b7WLF9DU200/dfdc0gje8=;
        b=IWgGf0vp6UVRmUh+vKk7yplmlL8ue+l+jxUTcJ0pfbFPa6ZETeVGi5xs/VZke7V0LD
         B+X8q4SjpQ4+t1oN/jORA8KMoPvy7DYEPMiLTyQ0ikDmaSlpHiD4sPXZzOPkhTCxRSsp
         I+NS5NQ5xx4jFpHKueaYlcMWh9PubuH6TE1NR5o8BYR6mmG208DApj+Ceu9bkDqfimiT
         ljbLajzwr2QsCpseOEfryxz+eE82gQDDRJUIt33tosmSaiMYQIoqTE237a/WyLNzRhvq
         zbK3dsteFe478+EN25iuMcTsDLqnOeeIlmaw6pEoaIyJ77NJVxusYFoozDFIGLAIjgxH
         ASCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683755661; x=1686347661;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gZhJ8Oybemtgz5njoRhar+b7WLF9DU200/dfdc0gje8=;
        b=enb/Zc9C2lOPb9UDN9KacwDNta4bJJgoKS92OA9Ui+g6UyfaPGpgiwcCAxv5wPG8+/
         vwOsftbgkFfQYPnPF8h7bnExNrf1xJivlxqFVw1MZFHr3iagi8Zy644+/S8sHYqQ9ej7
         OjvEwMHnrDVz6veukW0Sq7dQUXQaYUpHE1b/IJpoHh+JmPF6mClxfVZTWPevPG+k5reZ
         GEowrPLQVRN33BywO4xImJZeRbqlKyPyN4lW1JjKQChZalsUviyJQzOa6xugUzUNFFYr
         uatJA4XhC0fKLMy76QLZEU0kKhA+TTAFoARksdCYxicdJTISAsRKoeaHtrF5nwu4V2pE
         wODQ==
X-Gm-Message-State: AC+VfDwA3gunTis9DNqYMeAyys+jv21sQ6m6lOvXqsgMQ4+pJ30Sc6by
        g7qHkAffbn46YYcs4wfxpiI=
X-Google-Smtp-Source: ACHHUZ6c1v/vIjwQnRSn21YskkLCXa38CUSRjKIqEmhpLJ8jt3c2ZXdiSnT8B9YOVG5DOSFJcKXpnA==
X-Received: by 2002:a9d:66c8:0:b0:6ab:11a7:b8cf with SMTP id t8-20020a9d66c8000000b006ab11a7b8cfmr4217475otm.17.1683755661431;
        Wed, 10 May 2023 14:54:21 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id c14-20020a9d480e000000b0069f9203967bsm2400708otf.76.2023.05.10.14.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:54:20 -0700 (PDT)
Date:   Wed, 10 May 2023 15:54:20 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <645c128cd8e0_7b63e2941a@chronos.notmuch>
In-Reply-To: <87v8h0guks.fsf@osv.gnss.ru>
References: <20230503134118.73504-1-sorganov@gmail.com>
 <xmqqsfcdtkt0.fsf@gitster.g>
 <874jote2zl.fsf@osv.gnss.ru>
 <xmqqmt2lqofb.fsf@gitster.g>
 <xmqqttwskse5.fsf@gitster.g>
 <87o7n03qgq.fsf@osv.gnss.ru>
 <6459a33b14bd6_7c682947d@chronos.notmuch>
 <87v8h0guks.fsf@osv.gnss.ru>
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Sergey Organov wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >
> >> > When a command does not behave the way one thinks it should, being
> >> > curious is good.  Reporting it as a potential bug is also good.  But
> >> > it would help the project more if it was triaged before reporting it
> >> > as a potential bug, if the reporter is capable of doing so.  Those
> >> > who encounter behaviour unexpected to them are more numerous than
> >> > those who can report it as a potential bug (many people are not
> >> > equipped to write a good bug report), and those who can triage and
> >> > diagnose a bug report are fewer.  Those who can come up with a
> >> > solution is even more scarse.
> >>
> >> I'm afraid the solution I'd come up with won't be welcomed.
> >
> > My solutions are often not welcomed, and yet I still implement them.
> >
> > It might be a waste of time, but often I've found out that very quickly
> > after attempting to come up with a solution I realize there's a lot of
> > detail I was missing initially, so even if the solution is not welcomed,
> > it helps me to understand the problem space and be more helpful in the
> > discussion of potential solutions.
> >
> > So if I were you, I would still attempt to do it, just to gather some
> > understanding.
> 
> I sympathize, and I did recently. However, I figure I'd rather spend my
> time elsewhere, say, in the Linux kernel, where my experience is
> somewhat different, and allows me to enjoy my work.

Completely agree.

My experience in the Linux project is that of a true meritocracy: Linus
Torvalds doesn't have to like me, if the patch is good, it gets merged. Period.

> > I for one welcome any and all attempts to fix git's awful user
> > interface, regardless of the reception of the maintainer, and the "core
> > club".
> 
> For UI, the problem is that there is no core model defined, nor any
> guidelines are given, so every discussion ends-up being what "makes
> sense" and what doesn't for a user, everyone involved having his own
> preference, that often even changes over time.
> 
> In this situation attempting to fix the UI sounds like waste of efforts,
> as nobody can actually point at the state of the UI to which we are
> willing to converge, so there are no objective criteria for accepting of
> fixup patches.

It's even worse than that. There used to be objective criteria like the old Git
User's Surveys [1], but it turned out Git developers did not care about the
feedback from users, which is why there wasn't any point in continuing them.

And worse: even when all Git developers agree on a UI change, except one, it
doesn't matter, because that one has absolute veto power.

Not very hopeful prospects for Git's UI.

Cheers.

[1] https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/GitSurvey2016.html

-- 
Felipe Contreras
