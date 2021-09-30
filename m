Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D919C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876DB617E6
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347332AbhI3RFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346099AbhI3RFs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 13:05:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309F2C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:04:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v10so25022626edj.10
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GbqvdAwX1n18VIwe1tYudC9A0zNP6omj0M+/xO4HabU=;
        b=mM7wwy4QzFEphXAyeLHzoDtvcBmhQ1f69EhsO+Qk6tXL5oKJst4iAB2hN7291/jH4D
         wEpblCpWOOU0++cX017eoB/zWJCfS2wJ1MtHOn1zMjjRJBt525eqtWCQ9dcp0nD7W3Ma
         44NhUBRuPKA91Izobu6w1kv/NsYIEfgjD682eS1Z4dVSWQxpOyD4e++NFwHI++RzZtfj
         ukvYj45PcLNfUQECXJ+EU5ZaUL6GMqZFC+/aAHNTnhPt3I4EUmoiiBmqL/u86gCa0uYl
         2Qx3nPSL3ojZGG98UtrD3uUvEPhXJr6OVNrPkuj76yVOVjriF95fd6gQr3FmEVZRrGqY
         Sk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GbqvdAwX1n18VIwe1tYudC9A0zNP6omj0M+/xO4HabU=;
        b=GjxHpyDz89KB+2YRBmJNGAHfekYtRAfUo3hl0ru6aumvI4jHEvPZa/T82eFw581A4s
         LRWR2GDGQsGmT7MfTW0DKAi4i02oUHMLRJ4QO8wR8qcYEMqO2ENYIxry3HtgYj7PiyoC
         xnacGp54P6IWfUQTGq6rChLAbypyYQoyhDX4EkXvEbPftLaZpD9MAXo4DmY422OVIpXr
         fGrSaqlHKdl54d9/aCdFHHmapBYY/uYJRdqslm8p0V83ycPpw+i7vJzCLVv/We60fpXu
         7wCnJozFAJ3AW9XXYW+fymmtnu5O99XwzguCXBdN965cG6ryERsByuo8+jiTY0imAG2s
         kwHQ==
X-Gm-Message-State: AOAM533HDY5eKhMrwDT2AVImKs+wwIxrdA4mLBDNjmY4lrDlfCP1NKLD
        G80qvGKpQGT/DQsftXWUKfNRhHMfp1ZDGJYbak0=
X-Google-Smtp-Source: ABdhPJym844kBO8bB73rjH0acBRfO8wy6UNTGCI63+VxZSBm7YkbRzx3Wf3RY3YuafnBAQinvlH0Oa27/ZaIzESfTVY=
X-Received: by 2002:a17:906:1c0e:: with SMTP id k14mr371418ejg.286.1633021443577;
 Thu, 30 Sep 2021 10:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210923041252.52596-1-davvid@gmail.com> <20210923041252.52596-2-davvid@gmail.com>
 <xmqqv92rx8wa.fsf@gitster.g>
In-Reply-To: <xmqqv92rx8wa.fsf@gitster.g>
From:   David Aguilar <davvid@gmail.com>
Date:   Thu, 30 Sep 2021 10:03:27 -0700
Message-ID: <CAJDDKr5QkUgHJVrij8bN-o0eNWr=eg7yHhHK0J8MxTALV0wr3Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] difftool: fix symlink-file writing in dir-diff mode
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 2:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> David Aguilar <davvid@gmail.com> writes:
>
> > diff --git a/builtin/difftool.c b/builtin/difftool.c
> > index bb9fe7245a..21e055d13a 100644
> > --- a/builtin/difftool.c
> > +++ b/builtin/difftool.c
> > @@ -557,11 +557,13 @@ static int run_dir_diff(const char *extcmd, int s=
ymlinks, const char *prefix,
> >               if (*entry->left) {
> >                       add_path(&ldir, ldir_len, entry->path);
> >                       ensure_leading_directories(ldir.buf);
> > +                     unlink(ldir.buf);
> >                       write_file(ldir.buf, "%s", entry->left);
> >               }
> >               if (*entry->right) {
> >                       add_path(&rdir, rdir_len, entry->path);
> >                       ensure_leading_directories(rdir.buf);
> > +                     unlink(rdir.buf);
> >                       write_file(rdir.buf, "%s", entry->right);
> >               }
> >       }
>
> Curiously, this pattern repeats twice in the vicinity of the code.
> We cannot see it because it is out of pre-context, but the above is
> a body of a loop that iterates over "symlinks2" hashmap.  There is
> another identical loop that iterates over "submodules", and we are
> not protecting ourselves from following a stray/leftover symbolic
> link in the loop.

I don't think the submodules loop ever runs into a scenario where the
unlink would be relevant but it certainly wouldn't hurt from a defensive
perspective.

>
> I wonder if we should do the same to be defensive?  I also wondered
> if write_file() should be the one that may want to be doing the
> unlink(), but I ran out of time before I finished reading all the
> callers to see if that is even a correct thing to do (meaning: some
> caller may want to truly overwrite an existing file, and follow
> symlinks if there already is, and I didn't audit all callers to see
> if there is no such caller).

From my reading of write_file() usage it seems like we're better
off dealing with this just in difftool only. We'd be doing a wasteful
unlink() in most situations if we handled the unlinks in write_file().


> The two identical looking loops also look like an accident waiting
> to happen---a patch like this that wants to touch only one of them
> would risk application to the other, wrong, loop if the patch gets
> old enough and patch offset grows larger ;-).

Indeed. Lifting this pattern out into a common helper would
help reduce this risk here.

I have a follow-up patch that addresses this and the edge cases
that =C3=86var pointed out about the exit codes that was just submitted.

They are incremental patches on top of these patches but I resent the
entire series for convenience.
--
David
