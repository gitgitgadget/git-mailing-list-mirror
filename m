Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553ABC282D0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1648820706
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391141AbhASRYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:24:37 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40492 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbhASRYP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 12:24:15 -0500
Received: by mail-ed1-f48.google.com with SMTP id h16so22466586edt.7
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 09:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZoa+dQ2ZMswtTMzrwHJn/0rzofqvtoHIQIDSp9h9nA=;
        b=YV8wDYTcY/cY0IYrbR+Vl+VY9N5ner2BNBo+uUnHtbClFGCFBaTYC+Wbhl7FV+54MI
         Ln41cTxJyry0VUVlWEbg5zRGCgt3E8h+DssYrzAE/Incr3sEkiS6f5os9NouSb/0YwB9
         0MARR1Z8DCMU21GFO2Au7gQSkEjTuQXhw+DWhdlxFZO2xP57L0ZmxzoOmaGdfe6F86vT
         qcnIL48JjW/pIm22ROonufGARdoibfUVpeE3BE0G+I9El6UER9WxOkc5kjgWiogcpjc/
         /WlGXn5G6TUrOGleWru4uFws1AD41QETfTdNU8nMKf+RWbymm4Q+NLJArzi0MuGVYQ2+
         uOwQ==
X-Gm-Message-State: AOAM533+25xHYLP+90z+OmJR7rbT+jc3VJOrHGDhF86xSKdE9vJIYBU0
        4iNN+IsR4YPbprUM51N/oYw3ipXanJe+uUFlbEo=
X-Google-Smtp-Source: ABdhPJzX8m9ospdftxWa3lbwP9IgIu9CLkxEfSfxpq2WeNyvndrxtZVsZlYd08ZpdWrMfiEncydzf9j0q0W3PDXjGZk=
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr4241323edz.89.1611077012754;
 Tue, 19 Jan 2021 09:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com> <20210117234244.95106-6-rafaeloliveira.cs@gmail.com>
 <CAPig+cRUrN62CDT+e+q02-S_sCD1Qvi5XtgU3D1dr9fXt--YJA@mail.gmail.com> <gohp6kpn216x51.fsf@gmail.com>
In-Reply-To: <gohp6kpn216x51.fsf@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Jan 2021 12:23:22 -0500
Message-ID: <CAPig+cQE+U9C5LnnchXRjABVv5t4vDBQWW4i9PmksHhDLu6w4g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] worktree: teach `list` to annotate prunable worktree
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 5:26 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Eric Sunshine writes:
> > On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
> > <rafaeloliveira.cs@gmail.com> wrote:
> >> +       reason = worktree_prune_reason(wt, expire);
> >> +       if (reason)
> >> +               strbuf_addstr(&sb, " prunable");
> >
> > Looking at this also makes me wonder if patches [5/6] and [6/6] should
> > be swapped since it's not clear to the reader why you're adding the
> > `reason` variable in this patch when the same could be accomplished
> > more simply:
> >
> >     if (worktree_prune_reason(wt, expire))
> >         strbuf_addstr(&sb, " prunable");
> >
> > If you swap the patches and add --verbose mode first which requires
> > this new `reason` variable, then the mystery goes away, and the use of
> > `reason` is obvious when `prunable` annotation is added in the
> > subsequent patch.
>
> That's a good point. I'm inclined to leave the [5/6] with the following:
>
>     if (worktree_prune_reason(wt, expire))
>         strbuf_addstr(&sb, " prunable");
>
> And move up the changes that includes the `reason` into the [5/6]
> patches that introduces the --verbose option. This line seems easier to
> follow when the reader is looking on this patch alone and only care
> about a reason when the --verbose comes into play in the next patch
> [6/6].

I considered this, as well, but figured that it would make patch [6/6]
even noiser, and that swapping the patches would keep the noise level
down. But, I haven't actually tried it myself, so I could be wrong
about the assumption, and maybe the noisiness wouldn't be a problem in
practice or would be so stylized that it wouldn't matter.
