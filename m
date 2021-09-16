Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41C1C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B271E611CA
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbhIPWnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbhIPWnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:43:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CC7C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 15:41:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq5so24792640lfb.9
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HuV4QuDws3vx7pMhEBc+AYPU1Lwm/1j/RmYl/+qUBks=;
        b=LoE9FqcON13gK3PS1YveNcrF0eeBgiN3smQhkEaETUwcZMC/K9Ef+CTdYjF9unBx73
         D/KOu3bcE1OMzMqUZnHSNvPZ0xAnFnHp3YF+aGi6daQPSczRSrPBBs1ogKWDcmSjszQ4
         N+CNGKSDapxIc9xpfjxheBhSCxAYyIaXRMOs+KbAfkKJeUwKcE1ti+9MjYikfL3tDYle
         EWhtvOt3Y73V4kR3vjCI5rB9AZjU7EPiCnZE0cE3zwu/dp5hEvx8S7NT5uVNjaMPK8yT
         oEMkb6kdCDjM8lwWqOxxnENQEilwKyt83saNXWPP+Dydgn88/iHMurq0PK59b+k0qBEK
         /DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=HuV4QuDws3vx7pMhEBc+AYPU1Lwm/1j/RmYl/+qUBks=;
        b=OmTJXB1/vPAg/WzNiY2L23nc2B3LhrR+/T49lvSXpQXWRhXHuHXFGWo/da8J7aQWLz
         ZulIDaAFUrJjpiZkbGtidVEQ9t3Q+3/idJZvofgr5NVzBurJTmMZoAPCAikq8SAzMDYp
         6unSuBy6JmMpCerypGe7HZ5qWCQ+X8TbBHSWfuDvAV0ypqUkPPzbA7bMMknZHSBqj8sz
         BQOz7akeKgJVtDnuL4uArS3k2ddw7su7GLzNLazWyL8+pxMfnJq4QcZj+MD51lCjAvYI
         ZGGi3yIH/aqDpoCg60FBc2YyPaQd62dUy7VYdAMkTMwfHFM1rgXwEO5KU4WYYY9h/xZ6
         sncg==
X-Gm-Message-State: AOAM532abfa254Ykwuuyi8zliyHI/vhCVS01x1N3iMgHqLk1H/l6okpH
        vjyn0KUkqrEE5Yz7f/oyCduO34juRuU=
X-Google-Smtp-Source: ABdhPJxr0c56VZB9j00bUwIbMV46FjTd0fi+I+y+cB5QncjbCvoBM9Of83qmr4XEAYWRQ1hMpD8bgA==
X-Received: by 2002:a05:651c:1190:: with SMTP id w16mr6769682ljo.327.1631832106367;
        Thu, 16 Sep 2021 15:41:46 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k19sm491223lji.3.2021.09.16.15.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:41:45 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru> <87sfy497ed.fsf@osv.gnss.ru>
        <xmqqy27wrzmj.fsf@gitster.g>
Date:   Fri, 17 Sep 2021 01:41:44 +0300
In-Reply-To: <xmqqy27wrzmj.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        16 Sep 2021 14:15:16 -0700")
Message-ID: <874kaki1nb.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I'm afraid this issue is left up in the air after application of the
>> fix-up patch, as usage of --cc in the diff-index is still undocumented.
>
> Yeah, I do think documentation update is needed, but being buried by
> other topics I haven't had a chance to revisit the way how --cc is
> described in the wider context in order to make an intellgent
> suggestion on how to present it in the context of "diff-index".

I tend to believe yet another description of --cc is needed for
diff-index, separate from the current one. Just saying.

>
>> I.e., the fix-up just restores the historical status quo that has a
>> problem by itself.
>
> I do agree "show -p" on merge is an oddball that trips new people,
> because it does not imply the "do present the changes for merges"
> bit unlike "show -c/--cc" do, and from that point of view, the
> generalization --diff-merges tried to bring us was a good thing.

I'm not sure I follow. What "show -p" has to do with "diff-index --cc"?

My only point here is that usage of *--cc* in *diff-index* is entirely
undocumneted, and that needs to be somehow resolved.

>
> But "-c/--cc" are explicit enough in what they want to do.  It does
> want to present the changes to compare a single end state with
> possibly more than one starting state (e.g. a merge) and not
> requiring an explicit "-m" is quite natural.

Doesn't seem to be relevant for "diff-index --cc" lacking documentation,
but -m and -c and --cc are rather *mutually exclusive*. I.e., they all
set different formats for output of diffs for merges, so "--cc -m" ==
"-m", and "-m --cc" == "--cc", i.e., the latest overrides the format to
be used. Therefore "requiring explicit -m for -cc" simply doesn't make
sense.

> Even more, when it compares the end state with only one starting state
> (e.g. showing a single parent commit), there is only one pairwise
> result to "combine", so it is also natural that it ends up showing the
> same output as "-p". So I do not quite see the behaviour of
> "diff*/show --cc" as a problem, though.

I don't see it as a problem as well, so whom you are arguing with?

The only problem in this particular case I see is that "diff-index --cc"
is undocumented (and untested), and this has nothing to do with
log/diff/show, unless I miss your point.

> IOW, the use pattern in gitk is more than just "historical status
> quo", but is quite sensible, I would have to say.

"diff-index --cc" in gitk is a bug, as according to Git documentation
"diff-index" does not accept "--cc", period.

gitk trying to make sense of what is neither documented, nor tested, nor
guaranteed is the problem, but I was talking even not about that
problem, but rather about the cause of this: some undocumented
processing of "git diff-index --cc".

Thanks,
-- Sergey Organov
