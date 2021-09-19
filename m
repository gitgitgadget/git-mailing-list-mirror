Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A8DC433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 18:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EC560FC0
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 18:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhISSP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhISSP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 14:15:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0AC061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 11:14:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id n10so50953865eda.10
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U80il5oDBJ2LD34TfTV3wFkqpOeF27JxLrwPgfBHHYw=;
        b=eVslhpLbMcrwC99h/5K7Futrue1bzHtcQ0f/4O7iYh9JLzmFqIFMdRYkE3tAfhYEBM
         ZZGdJ8ST4vM2phyOkzH10CZpiyi0GiJoF9pJM0mJjQZrCjm5X7zUq30o0Kez8u/vcbnZ
         I4VngnOchaHh6YbYPCSM6ufeEAEasr1XZ+pjXoI791y0gz8T0eNJnK0GPNzsjh4O2hJE
         GVnMPDsw6YqzQB9t3xgLBV07pVxc9OnuRuSomfjpYxm9hHclaIMaRK+54j51JeEHAtsX
         yHfzHFOQqZ3EfAewEupxqva8zsuaO1hCUI+QOuvvzY57x1ViRlgNGhUWuVYiVBo7XYnR
         dBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U80il5oDBJ2LD34TfTV3wFkqpOeF27JxLrwPgfBHHYw=;
        b=q2y8t2m9ROQPQ792fS3UIovy42zlxiErWm0wPhRlf17KRpvltx+8WwFCpoy/fXnTdE
         SYu95zZJlu/RHXkWDTepAGq7bH3AwI0eDtDpvfXIfQzZDsIT5/gp7s58Yv3FkObDKnm+
         MQD+QfBk0mKhjB1hTAejVW4a0DurIWkexP/0EonBvGeEjI3PYFuR4JqRZpmYoI4muI1O
         vkY1XJmS61QUq4G2N/ftZ2WZhLRu4+83h7sakuUQYH5IsZUDkjS2DBNO2XrKZJeyzziC
         t9V5/SWPfUhZMtbf179bqXKkxWyl5r773zsg+wLIEisw8FWWqb8X+73/pRQfAk/DSL8L
         tqpA==
X-Gm-Message-State: AOAM5327ETcQfZ4cEPcXx7Kp+Aq0RMLaiJXdy0ngdWiLANEY8Z05iGQh
        luOgrLlXfPljK0oLnlYPdDDEN8SoK6BT8e/iKMfWXELCWms=
X-Google-Smtp-Source: ABdhPJxlDmzF+wYdkSWuTGLuG2ifjsnDANPCEIF20MHaRAcw3cNxOSgWKORQTm+/BRbKILDuW4mbQKCyhrbIjGSt0fE=
X-Received: by 2002:a17:906:2a0d:: with SMTP id j13mr23425151eje.545.1632075240386;
 Sun, 19 Sep 2021 11:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210919015729.98323-1-davvid@gmail.com> <20210919015729.98323-3-davvid@gmail.com>
 <8dfd0683-e019-a45c-30a4-d49ea627e36d@kdbg.org>
In-Reply-To: <8dfd0683-e019-a45c-30a4-d49ea627e36d@kdbg.org>
From:   David Aguilar <davvid@gmail.com>
Date:   Sun, 19 Sep 2021 11:13:24 -0700
Message-ID: <CAJDDKr6AM0YZ-5GmXHz=2VbRKOusjQ-OAP2ng8GpBDb0x1pPRg@mail.gmail.com>
Subject: Re: [PATCH 3/4] difftool: use a strbuf to create the tmpdir path
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 2:00 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 19.09.21 um 03:57 schrieb David Aguilar:
> > Use a strbuf to create the buffer used for the dir-diff tmpdir.
> > Strip trailing slashes "/" from the value read from TMPDIR to avoid
> > double-slashes in the calculated paths.
> >
> > Add a unit test to ensure that double-slashes are not present.
>
> I wonder why it is necessary to strip trailing slashes? You even go so
> far as to add a test case, but then bury the change in a commit with a
> title that is about a completely different topic.
>
> So, which one of the two changes is the "while at it, do that, too" chang=
e?

A better title might be:

    difftool: use a strbuf to generate a tmpdir path without double-slashes

The double-slashes are the point. This patch is a minor cleanup that I
found on the path towards fixing the data loss bug in patch 4.

Thanks for the heads-up about the confusion ~ I'll reword in the next
submission to make this point clearer.

=C3=86var (cc'd) also asked why we have a patch that deletes the temporary
repositories used by the tests. It sounds like it's best to leave
those in place so the next submission will also drop that patch and
will adjust patch 4/4 (now 3/3) so that it also does not remove the
temporary repo used by its new test.


> > @@ -360,11 +359,17 @@ static int run_dir_diff(const char *extcmd, int s=
ymlinks, const char *prefix,
> >
> >       /* Setup temp directories */
> >       tmp =3D getenv("TMPDIR");
> > -     xsnprintf(tmpdir, sizeof(tmpdir), "%s/git-difftool.XXXXXX", tmp ?=
 tmp : "/tmp");
> > -     if (!mkdtemp(tmpdir))
> > -             return error("could not create '%s'", tmpdir);
> > -     strbuf_addf(&ldir, "%s/left/", tmpdir);
> > -     strbuf_addf(&rdir, "%s/right/", tmpdir);
> > +     strbuf_add_absolute_path(&tmpdir, tmp ? tmp : "/tmp");
> > +     /* Remove trailing slashes when $TMPDIR ends in '/'. */
> > +     while (tmpdir.len > 0 && tmpdir.buf[tmpdir.len - 1] =3D=3D '/') {
>
> This should most likely be is_dir_sep(tmpdir.buf[tmpdir.len - 1]).

Indeed. Peff also suggested strbuf_strip_trailing_dir_sep(&tmpdir)
which is what we have in patch v2. That uses is_dir_sep().

This commit will be reworded, patch 1/4 "t7800-difftool: cleanup
temporary repositories" will be dropped, and the final patch will be
adjusted to not cleanup its temporary test repository.

I'll resend all 3 patches later with these suggestions as "v4".

cheers,
--=20
David
