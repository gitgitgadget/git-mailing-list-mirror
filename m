Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE72C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA6C64FAB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhCKPYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbhCKPYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 10:24:37 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F337C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:24:37 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id t16so1812937ott.3
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiyF/PPGSu1kK3S9a1K08XZ0mLi7aBpxQ+iIveFxyl4=;
        b=areErS6garOwZE9KtHOkW3RXlLud9dAGLzk2xVRz1qR4P2asorD1lqXAiqSY5AsB0M
         Mhi93c3lc67s4Dpxr2ozPdICsi6vUt647U3vhUybZcogWQYDIqRdkGbJd+B1TthE/BbL
         KleFvHxuZO3jFPfJIdvao+0frYVEL4HUCFH+pVjsPFK0R+vzk/WwK1nx8e78hi7p3m3b
         N28jqIVAq2IuTl2Yz5wte5z8LJEaILvrJgCpakdUoB47boud0pMz9w8dI+Uiu6ggcb0Y
         BSTxgZFcuCCecOyT96D84i2Vx0JMeg6mDAgIq3gGmDN4Ad3XRslELuZcR8+n+SZv4U4O
         uk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiyF/PPGSu1kK3S9a1K08XZ0mLi7aBpxQ+iIveFxyl4=;
        b=DQCKthbioT0UTKoQKQ7YsStnO8g5B8izlkwXdftdtVnG812tkJecpmXrq0Z6pfa0gt
         uFMloufRK26ayo0C6VM0c042jrIndj8+FWMb3kulcW6MIMbyiXQV2V8CqDzo42oESAKM
         diQr0ytzhBg8eBIcExFbqbOkPidzCa36EDfByzkDxk1WC+JQjClYnc1StETM8MNkYk8N
         xvJGLe+1MrZ1T8fMMTEvxO8GkwdPFwWxKpSEqCfTu6No/wBCak4n7nlFsI1XgQme7cCr
         PkY8Ip0Y7yPs53mevLQWNdtzsr+a5AigIit7ruSyEpQdTeomf2UvpKSMV7I7xVJyOV91
         XxRA==
X-Gm-Message-State: AOAM5306K7VM29ASkeUAjC2ByAlgTlux5apDA2SVTuTNLhHdfCk0GJ7W
        WVknPu5/S5YVvdDHVErSYafHq4Dw/Z401F9/VLbHw9mtQAo=
X-Google-Smtp-Source: ABdhPJx6ID5vCipqF6NcDOXN4+qfelKvpyDb7GyMvgLAyY+CFT7GrEI0s4gTc/huLuq5UK6ULsoOzyMq1AgQQSv3TtY=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr7451348oth.184.1615476276646;
 Thu, 11 Mar 2021 07:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-7-charvi077@gmail.com>
 <CAPig+cQVqUGchmCxKkhw1Vffq8z68VcRujSn02KvBh78mBS2yQ@mail.gmail.com>
In-Reply-To: <CAPig+cQVqUGchmCxKkhw1Vffq8z68VcRujSn02KvBh78mBS2yQ@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 11 Mar 2021 20:54:25 +0530
Message-ID: <CAPSFM5d7wAdh1mHZkVeRrTY3iLEqejSVDA9V-Nxb72f+eqcOcA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree, below reworded documentation is easier to understand. I
realized I am quite poor at documenting the things (Apology for
mistakes, but I learned a lot and will try my best from next time)

I really appreciate all the suggestions and guidance.

Thanks and Regards,
Charvi


On Thu, 11 Mar 2021 at 13:18, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Mar 10, 2021 at 2:45 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > ---
> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> > @@ -86,11 +86,40 @@ OPTIONS
> > +--fixup=[(amend|reword):]<commit>::
> > +       Construct a new commit for use with `rebase --autosquash`,
> > +       which fixes the specified commit. The plain form
> > +       `--fixup=<commit>` creates a "fixup!" commit, that allows
> > +       to fixup only the content of the specified commit and leave
> > +       it's commit log message untouched. When used with `amend:`
>
> s/it's/its/
>
> > +       or `reword:`, it creates "amend!" commit that is like "fixup!"
> > +       commit but it allows to fixup both the content and the commit
> > +       log message of the specified commit. The commit log message of
> > +       the specified commit is fixed implicitly by replacing it with
> > +       the "amend!" commit's message body upon `rebase --autosquash`.
>
> The first half of this description is clear. The second half gets
> bogged down and difficult to decipher. It also seems to claim that
> "reword:" can change the content of <commit>, which isn't accurate at
> the UI level (even if it happens to reflect the underlying
> implementation). I might have written the above description like this:
>
>     Create a new commit which "fixes up" `<commit>` when applied with
>     `git rebase --autosquash`. Plain `--fixup=<commit>` creates a
>     "fixup!" commit which changes the content of `<commit>` but leaves
>     its log message untouched. `--fixup=amend:<commit>` is similar but
>     creates an "amend!" commit which also replaces the log message of
>     `<commit>` with the log message of the "amend!" commit.
>     `--fixup=reword:<commit>` creates an "amend!" commit which
>     replaces the log message of `<commit>` with its own log message
>     but makes no changes to the content of `<commit>`.
>
> > +The resulting "fixup!" commit message will be the subject line
> > +from the specified commit with a prefix of "fixup!". Can be used
> > +with additional commit message option `-m`.
>
> This gives details without providing meaning. If I didn't already know
> how this all works, I think I'd probably be mystified about what it is
> trying to say. Providing context by mentioning `git rebase
> --autosquash` would help explain the significance of "fixup!".
> Similarly, it's not clear on the surface why this mentions `-m` at
> all. I might have written it like this:
>
>     The commit created by plain `--fixup=<commit>` has a subject
>     composed of "fixup!" followed by the subject line from <commit>,
>     and is recognized specially by `git rebase --autosquash`. The `-m`
>     option may be used to supplement the log message of the created
>     commit, but the additional commentary will be thrown away once the
>     "fixup!" commit is squashed into `<commit>` by `git rebase
>     --autosquash`.
>
> > +The `--fixup=amend:<commit>` form creates an "amend!" commit where
> > +its commit message subject will be the subject line from the
> > +specified commit with a prefix of "amend!" and the message body
> > +will be commit log message of the specified commit. It also invokes
> > +an editor seeded with the log message of the "amend!" commit to
> > +allow to edit further. It refuses to create "amend!" commit if it's
> > +commit message body is empty unless used with the
> > +`--allow-empty-message` option.
>
> This is reasonable, but does get into the weeds somewhat and uses
> potentially unusual terms such as "seeded". It can be tightened up a
> bit by building upon what was explained earlier for plain
> `--fixup=<commit>`. To really round it out and give proper context for
> understanding the purpose, it would also be helpful to explain how an
> "amend!" commit is handled by `git rebase --autosquash`. I might have
> written it like this:
>
>     The commit created by `--fixup=amend:<commit>` is similar but its
>     subject is instead prefixed with "amend!". The log message of
>     <commit> is copied into the log message of the "amend!" commit and
>     opened in an editor so it can be refined. When `git rebase
>     --autosquash` squashes the "amend!" commit into `<commit>`, the
>     log message of `<commit>` is replaced by the refined log message
>     from the "amend!" commit. It is an error for the "amend!" commit's
>     log message to be empty unless `--allow-empty-message` is
>     specified.
>
> > +The `--fixup=reword:<commit>` aliases `--fixup=amend:<commit> --only`
> > +and it also creates an "amend!" commit, but here it records the same
> > +tree as `HEAD`, i.e. it does not take any staged changes and only allows
> > +to fixup the commit message of the specified commit. It will reword the
> > +specified commit when it is rebased with `--autosquash`.
>
> This gets too deep into the techno-speak by talking about "tree" and
> `HEAD`. You can convey the same concept more simply by saying merely
> that it creates an empty commit. I might have written it like this:
>
>     `--fixup=reword:<commit>` is shorthand for `--fixup=amend:<commit>
>     --only`. It creates an "amend!" commit with only a log message
>     (ignoring any changes staged in the index). When squashed by `git
>     rebase --autosquash`, it replaces the log message of `<commit>`
>     without making any other changes.
>
> > +Also, after fixing the commit using `--fixup`, with or without option
> > +and rebased with `--autosquash`, the authorship of the original commit
> > +remains unchanged. See linkgit:git-rebase[1] for details.
>
> It sounds odd to start this sentence with "also". Perhaps:
>
>     Neither "fixup!" nor "amend!" commits change authorship of
>     `<commit>` when applied by `git rebase --autosquash`.
