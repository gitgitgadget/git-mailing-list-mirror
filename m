Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1080DC282DD
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 14:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CC320848
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 14:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2g5B4de"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgAKOyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 09:54:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33600 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbgAKOyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 09:54:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so6416584wmd.0
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=97jqAWENHwMBCPXrtaMxil+cDVcS8zSIRDc9x61p0ms=;
        b=M2g5B4detm1vinTn/gtWq3b5PYVRmRVGKo9WdeO/0m2/LRvO7ZZCziKkAGEzcgV+HY
         waTeTIeVkZitU5ZZXiIv6R3Akxji+nMMVk/ZB3EkgZxuAgtefze1RmUe9PleXkXept1+
         rw1wA1/bXgPYbBG+Xzrj0XNWUufGjmnus84q2FhijwjSOOY94wnTbK8Zu7Ylm08in3Rp
         qiXbgYiOuCsLA+VoKGsrsZV6F0g9BPDK+VzBNoyVsHhwRcfHSmrIAZN/hlXdHySQD7z0
         Fwqqu8bSfiOBeOqYZmoj8xZa7zSXSzqN28kFCP40fSdNoLu9l280GswsttSYxgksOn9x
         g4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=97jqAWENHwMBCPXrtaMxil+cDVcS8zSIRDc9x61p0ms=;
        b=QoOwyjpOHx71gEB6GQI4M1YJ92CwnYJT3La9UY+0zP7MD9VrpzJJ1WZCc0uk42Gauz
         sKKKKUhnuT3EcKLj31Z3q4guKfA7HWzaX0kTRw+K7FehclUnUGDCLNicVj5lyxLP9fCG
         PcynRDb18PEgdbhN7Lr9ykju07PvbWfOifCnzPNmvfQr74XLQdAbVM3Q5TKFC6pvy/QQ
         N477O5VYafDEfBv4fvRCYfl6s6EtR5F8JO3cWnq/CluW/Xn5cY2t+sUIyPPs7HnwMsP+
         vMXU2EpvrLR65CjsFEOyBkjrjKaQlC3ybJwsmNqSygsvjWtVqfB0YpMxufIcvqmPuMSX
         G/LQ==
X-Gm-Message-State: APjAAAX2vMdf09gk5E76gGfd2p60sN++FZbfXWmc/bnKafwXb2EPr4qO
        yXwOJDFbJTvGR/gh9vBJ3oNJGw0UNyFvhwVBGbMgCZQH
X-Google-Smtp-Source: APXvYqz9BqACA1EYFZ2pEqcEGdloJuU972Jyp5M3SoM4Kltfrg/sge81v9JHbs1bUAxSSAnMlbNMyBqZIfm4MWP+IcU=
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr11236024wmk.42.1578754473115;
 Sat, 11 Jan 2020 06:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com> <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
In-Reply-To: <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date:   Sat, 11 Jan 2020 18:54:21 +0400
Message-ID: <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Sat, Jan 11, 2020 at 5:28 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Sat, Jan 11, 2020 at 7:36 AM <marcandre.lureau@redhat.com> wrote:
> > Defaulting to editing the description of the rebased branch without an
> > explicit branchname argument would be useful.  Even the git bash prompt
> > shows the name of the rebased branch, and then
> >
> >   ~/src/git (mybranch|REBASE-i 1/2)$ git branch --edit-description
> >   fatal: Cannot give description to detached HEAD
> >
> > looks quite unhelpful.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > @@ -745,15 +745,27 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
> >                 if (!argc) {
> > -                       if (filter.detached)
> > -                               die(_("Cannot give description to detac=
hed HEAD"));
> > -                       branch_name =3D head;
> > +                       if (filter.detached) {
> > +                               struct wt_status_state state;
> > +
> > +                               memset(&state, 0, sizeof(state));
> > +
> > +                               if (wt_status_check_rebase(NULL, &state=
)) {
> > +                                       branch_name =3D state.branch;
> > +                               }
>
> Style: drop unneeded braces.

ok

>
> > +
> > +                               if (!branch_name)
> > +                                       die(_("Cannot give description =
to detached HEAD"));
> > +
> > +                               free(state.onto);
>
> Also, no need for all the blank lines which eat up valuable vertical
> screen real-estate without making the code clearer.

ok

>
> > +                       } else
> > +                               branch_name =3D xstrdup(head);
>
> It would be easier to see what happens in the common case (when not
> rebasing) if you invert the condition to `if (!filter.detached)` and
> turn this one-line 'else' branch into the 'if' branch.

indeed

>
> > @@ -772,6 +784,8 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
> >                 if (edit_branch_description(branch_name))
> >                         return 1;
> > +
> > +               free(branch_name);
>
> That `return 1` just above this free() is leaking 'branch_name', isn't it=
?

right, let's fix that too

>
> > diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> > @@ -1260,6 +1260,25 @@ test_expect_success 'use --edit-description' '
> > +test_expect_success 'use --edit-description during rebase' '
> > +       write_script editor <<-\EOF &&
> > +               echo "Rebase contents" >"$1"
> > +       EOF
> > +       (
> > +               set_fake_editor &&
> > +               FAKE_LINES=3D"break 1" git rebase -i HEAD^ &&
> > +               EDITOR=3D./editor git branch --edit-description &&
> > +               git rebase --continue
> > +       ) &&
> > +       write_script editor <<-\EOF &&
> > +               git stripspace -s <"$1" >"EDITOR_OUTPUT"
> > +       EOF
> > +       EDITOR=3D./editor git branch --edit-description &&
> > +       echo "Rebase contents" >expect &&
> > +       test_cmp expect EDITOR_OUTPUT
> > +'
> > +test_done
>
> Strange place for a test_done() invocation considering that existing
> tests follow the new one added by this patch.

doh, sorry
thanks for the review!

>
> >  test_expect_success 'detect typo in branch name when using --edit-desc=
ription' '
> >         write_script editor <<-\EOF &&
> >                 echo "New contents" >"$1"



--=20
Marc-Andr=C3=A9 Lureau
