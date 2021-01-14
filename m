Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1CC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938E1233FD
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 08:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhANIM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 03:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbhANIM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 03:12:58 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8BEC061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:12:17 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j12so4466388ota.7
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 00:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfbzTs4B27Ef+ZO8HYg2bCa5LoMG/57tYV6yvGXQi/Y=;
        b=hDMwTye3eFV6M0HwpD2cxyHglN+gHexh17plcN67PiCQ1cCJP//UYXjmwADmzjzJxu
         6SF8uj5PvEi2k51CWj3lYj4LGXTnXzp9isoZwu/4OgGjExStCTXYOPdCFDnzQyzCXPsM
         1o/F7X8ikV28x1+RdvXe6eJ4v++idlDL9OMGrLqZ7rfe6WfvKYFJrLlB1SeIYXSh/2fz
         VXZGmRtQfU/krgRXhOtSzCmwYbiqQxWnWWc7eayL8ojdn2XEQQISTrxdpiVm8acd2VCj
         oQAQG7/923ddvydX3GICRE9ZLqAQFntL05AH93iE1syiZWSCPuX3IvbAUuAWWE3ptdzq
         H5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfbzTs4B27Ef+ZO8HYg2bCa5LoMG/57tYV6yvGXQi/Y=;
        b=P1XRIxQqgMe5idgvGhaNh7euL+1udgM+7cz6U8nLtSDHJYqXxAABY3QKdYsZ7iSH04
         thc7OrP+Nm2M5aD1hojAxFu82Cxg98nek3Ag+Jhei0dmm723/gNYpHx2CVZaninh60Ll
         geqlHsHKPnjNm6UKPojJQaeWZcQgxPu8Jc9QYuXiwRBbGcBErMhfTtOVspNtGf95GnAD
         ygXaNbYMg1cL86RvYJkbKE9CAdaGE2hKUQUHfbru+FOR3bWiCTJQ7ikvX6X15T6zeqMY
         6uoxpRWHlqCzFxhcaaxkxg4ZKWJW4DgdaPy5S0HXpfDsmqYr7NnEylZ4r8ImCLPpTbbb
         i5ug==
X-Gm-Message-State: AOAM531zcvGlyyqixnH+aPPJ0mZKq9OdmNqt9gzFfe0QIxSPOCYCp/KI
        OQB1I8ZP96VpgRnKb9lBbTIiSPh8KCy470ivOfjBqGK4uYU=
X-Google-Smtp-Source: ABdhPJwcWxpjX8AoCgmFuewtxkviHlsmKWrIGHHi2yTyz14lkqb4xY3BTgAxHBl7tG5Or0UMLNpjmWLpbw7lMyMbX3s=
X-Received: by 2002:a05:6830:1c34:: with SMTP id f20mr3792632ote.147.1610611937136;
 Thu, 14 Jan 2021 00:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-2-charvi077@gmail.com>
 <X/8/WassxF7ujqjX@nand.local>
In-Reply-To: <X/8/WassxF7ujqjX@nand.local>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 14 Jan 2021 13:42:06 +0530
Message-ID: <CAPSFM5ew583ZPZO9XUWxskQPsdSv520gKCM30GH2huhdTDxb2A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] rebase -i: only write fixup-message when it's needed
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 14 Jan 2021 at 00:13, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Jan 08, 2021 at 02:53:39PM +0530, Charvi Mendiratta wrote:
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > The file "$GIT_DIR/rebase-merge/fixup-message" is only used for fixup
> > commands, there's no point in writing it for squash commands as it is
> > immediately deleted.
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
> >  sequencer.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 8909a46770..f888a7ed3b 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1757,11 +1757,13 @@ static int update_squash_messages(struct repository *r,
> >                       return error(_("could not read HEAD's commit message"));
> >
> >               find_commit_subject(head_message, &body);
> > -             if (write_message(body, strlen(body),
> > -                               rebase_path_fixup_msg(), 0)) {
> > -                     unuse_commit_buffer(head_commit, head_message);
> > -                     return error(_("cannot write '%s'"),
> > -                                  rebase_path_fixup_msg());
> > +             if (command == TODO_FIXUP) {
> > +                     if (write_message(body, strlen(body),
> > +                                       rebase_path_fixup_msg(), 0)) {
> > +                             unuse_commit_buffer(head_commit, head_message);
> > +                             return error(_("cannot write '%s'"),
> > +                                          rebase_path_fixup_msg());
> > +                     }
>
> I'm nit-picking here, but would this be clearer instead as:
>
>     if (command == TODO_FIXUP && write_message(...) < 0) {
>       unuse_commit_buffer(...);
>       // ...
>     }
>
> There are two changes there. One is two squash the two if-statements
> together, and the latter is to add a check that 'write_message()'
> returns an error. This explicit '< 0' checking was discussed recently in
> another thread[1], and I think makes the conditional here read more
> clearly.
>

Okay, I got this and will change it.

Thanks and Regards,
Charvi

> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/xmqqlfcz8ggj.fsf@gitster.c.googlers.com/
