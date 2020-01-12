Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A0C33CA7
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 01:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD922082E
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 01:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbgALB1Y convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 11 Jan 2020 20:27:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36699 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731885AbgALB1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 20:27:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so5936863wma.1
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 17:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iLSuxTr+DZ2jWvi9Itzg7uouh2uqV4xlK2YFFWl41cs=;
        b=R2fkp2/hS3PnB49IzoGYGPWQGvdehT8ydZ/RN9xoUp+Zj7xfNJTY3gqIkBm+kXd20d
         h2fny9gHG/YFjoxusi+8/VlUZbA6qm7JiFFGe8k9lcki8eixu1Fot6Q17ubX5s944d0U
         LU9JIDd7d8lXEZbwPKXkA7oQQc3DniwuPaku1jAjyVpauF+WxQgkxixRe6lNzsj3cY4J
         sNin/FDLBBAzGhjm07EYcMoEh3RFAdkBTyUNuuYSFilD7xyzzzQWatVHxLBQJI9TeFK1
         PYFxHd8rH/ovK898CLqZfOM/Y8mG62ffqFOHp6kyOlyauM39OnDczh10BLDMIjxTtjok
         T5KA==
X-Gm-Message-State: APjAAAUGUIdPjwGcM6XPABXvNi7TODl0iRg5BBuMajIYw6HJO5zLvu/n
        cKorHT0IwMzfYi6EyhtpRPknHX9PfBmfnZcK4SA2SmaC
X-Google-Smtp-Source: APXvYqw78icu1vc/g7xbUeWXkliuSyQJxGfHMAgM4Y6iRBPRpQ7Atj5+f35BAsAm9oRaMj/Dqwfic0RU5Sfvfpiz0tE=
X-Received: by 2002:a7b:c246:: with SMTP id b6mr12089427wmj.75.1578792442881;
 Sat, 11 Jan 2020 17:27:22 -0800 (PST)
MIME-Version: 1.0
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
 <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com> <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
In-Reply-To: <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Jan 2020 20:27:11 -0500
Message-ID: <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
To:     =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 11, 2020 at 9:55 AM Marc-André Lureau
<marcandre.lureau@gmail.com> wrote:
> On Sat, Jan 11, 2020 at 5:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Sat, Jan 11, 2020 at 7:36 AM <marcandre.lureau@redhat.com> wrote:
> > > +                               if (wt_status_check_rebase(NULL, &state)) {
> > > +                                       branch_name = state.branch;
> > > +                               }

Taking a deeper look at the code, I'm wondering it would make more
sense to call wt_status_get_state(), which handles 'rebase' and
'bisect'. Is there a reason that you limited this check to only
'rebase'?

> > >                 if (edit_branch_description(branch_name))
> > >                         return 1;
> > > +
> > > +               free(branch_name);
> >
> > That `return 1` just above this free() is leaking 'branch_name', isn't it?
>
> right, let's fix that too

Looking at the code itself (rather than consulting only the patch), I
see that there are a couple more early returns leaking 'branch_name',
so they need to be handled, as well.
