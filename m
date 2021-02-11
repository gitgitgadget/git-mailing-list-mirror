Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B7CC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0779964E7E
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhBKHPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKHPI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:15:08 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C02FC061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:14:28 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id v17so1438103uat.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 23:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X7wEyJVYUzh6l9J5HdqzfABTAcXUbjQZgLZAz4Y2wJg=;
        b=CkrN1ygMibejnPsBBlepSdABcB+MIlWXSgimcVDNJ8tLe6bszNUKlTOPQN0AIlyHHG
         O/8S+UjSQi2W+YJXlbjV7m2nKW5vgcaHvyJz7EoepjLnaTZn3jFTYIIrePc2hFRJzLAf
         VnTedTKk+L8zJTF1KVpBlIiTvOGXepk+4iFv/TTCQpA9eStd4PgTNBNaJR0GOnuQzKRm
         SpFk0DxGWTnrlosVUTxUf10deKCyh0dk+bcybGhRJ3UwPpNrIme7MyprQB80M4fkzfPx
         TEecYF7iOewYxzmr0nWIILvIFrXyRdSO5PrvrULPEK63iNM4CiBekHTp/r9mgZjSMe7n
         3/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X7wEyJVYUzh6l9J5HdqzfABTAcXUbjQZgLZAz4Y2wJg=;
        b=VCmxhgTvjPzvp2GnCT9IE0103HKp6SLf/ca44T95M2VRE2GGPjvTBFOmg9npzWW1+j
         MqHgcOOCKKIS32+rxjCg+RyHXfHV3vWQQAn0tydg5nePix9QExxBMOaR59c2bSPaJaWM
         JXzsq+fTVH5Up7J7LwP02o/vTbmc89bHm4d+cZdka+aPK3NTtz7C3M/9jZXk472uGtoO
         Ihxm0a0s7GAz5qcJctRFAXOOhmYmBU5N5wh90AzIFGkBX6wBuxUTchd4ZWztYZ1DAJl4
         487rFpF68c8phTYjb6Q97qxprx8LooB9feQ7EKfXAr+voKZ3L8e6ZTUBfVi2d9lWBZuC
         PaTw==
X-Gm-Message-State: AOAM5308A4zpF3unovmJQr47XA08qDr1QC3sWBtIW57MFKX+iC/nqKRx
        GEmVI8U4EaGbOXB1VUJJRV4ACJ84w0+sDfD7U8W5lN7zA8w=
X-Google-Smtp-Source: ABdhPJzp7Llgrv1yWs5LAr/y/SzSIB9iUUfehv4iLkjZQA7QrMrxReivtsXpl9UvGUyRk68bK5EbdjqPX8sd08my3N4=
X-Received: by 2002:ab0:e11:: with SMTP id g17mr4261990uak.83.1613027667369;
 Wed, 10 Feb 2021 23:14:27 -0800 (PST)
MIME-Version: 1.0
References: <e7fde2369495f32c7aa88c7b6b74ebee1a1bed24.1613000292.git.martinvonz@google.com>
 <xmqqo8grzbjv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8grzbjv.fsf@gitster.c.googlers.com>
From:   Martin von Zweigbergk <martinvonz@google.com>
Date:   Wed, 10 Feb 2021 21:14:15 -1000
Message-ID: <CAESOdVDgpe9yacMxKLO_AjAnadcSjrik_NdwhW-4vDELf+UxPw@mail.gmail.com>
Subject: Re: [PATCH] docs: clarify that refs/notes/ do not keep the attached
 objects alive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 2:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin von Zweigbergk <martinvonz@google.com> writes:
>
> >  ... In particular, it will keep not only
> > +objects referenced by the index, remote-tracking branches, reflogs
> > +(which may reference commits in branches that were later amended or
> > +rewound), and anything else in the refs/* namespace. Notes saved by
> > +'git notes' under refs/notes/ will be kept, but the objects (typically
> > +commits) they are attached to will not be.
>
> The notes will not contribute in keeping the objects they are
> attached to.  As long as the objects have some paths from refs and
> reflog entries (reachability anchors), they will be kept.  These
> two are facts.
>
> But I am afraid that the new phrasing can be misread as saying that
> an object, if it has notes attached to it, will not be kept, period.
>
> Knowing Git, we can tell immediately that it would be a nonsense
> behaviour, but still, I think that is how it can be read, so I
> suspect that the new text would invite a misunderstanding in the
> opposite direction.
>
>     ... and anything else in the refs/* namespace.  Note that a note
>     attached to an object does not contribute in keeping the object
>     alive.
>
> would be less misinterpretation-inducing, perhaps.

Good point. You dropped the bit about the notes (texts) being kept
alive. I don't know if you did that intentionally are not. I initially
thought that we should keep that bit, but it's probably not actually
very useful information. Users probably don't have large amounts of
information stored in notes, so they probably don't care whether notes
text is kept, especially since there's no good way of pruning the
notes. So I took your proposed sentence, but I added a parenthesis to
clarify that we're talking about notes from 'git notes'.

>
> We could go further to explain by adding something like that
> immediately after "keeping the object alive" above, e.g.
>
>     ---when an object becomes unreachable (e.g. a branch gets
>     rewound, a commit gets rewritten) and eventually gets pruned, a
>     note attached to the object will become dangling (use "git notes
>     prune" to remove them).
>
> but I am not sure if that is necessary.  Pruning notes attached to
> objects that are pruned may be relevant in the context of discussing
> "git gc", I guess.

Yes, seems only tangentially related, so I'll leave it out.

I'll send a v2 in a moment.
