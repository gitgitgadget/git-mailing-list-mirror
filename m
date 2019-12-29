Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EF7C2D0C0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 23:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807ED20748
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 23:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfL2Xy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 18:54:59 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44217 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfL2Xy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 18:54:58 -0500
Received: by mail-wr1-f46.google.com with SMTP id q10so31337111wrm.11
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 15:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtICyXCSl0o5Dws6MXCyddB7/9b89IAKu0PnL5o1xfo=;
        b=X5gSEYnJ2MldZwEm9dFzWMFyRIQKKagukQgrdOt6XLCVA+uomk9byMXXBWrwYWYd6l
         o7MDqPplzd/xJOFRg6GtCgkyGWNtVCFN2pQpEq5B5Zt1jBmm+tX+/JMk69u7A17gnKwY
         +2en8JQfFYTHRrY3yZFKfnaMWGU75LSK3mawx0VikOAtWPYmGf7ongT5XaQkNbaRG9je
         OeG6eP9/sSgPL/t12ub6/gdBvsEt9Lo+Oq0ZtY4ILTQhYuM1uM7KRD95JdxtN9a50ru/
         nxPaQOk2cKFH4+24agvmaLQFl/jS1ip4Dj80Qr7y4cn3NNd1SGeVN9QEDDdS5qigrQw+
         UB3Q==
X-Gm-Message-State: APjAAAXvuYOyzWW2rg7VlBE7lDGms3KmzlfAaPt2Pinhpo5nCWBQnvyG
        AweZyoUQx1dpaIyAXoB9efLThhWlApHVrv9qu0E=
X-Google-Smtp-Source: APXvYqynunw3ebGOSzi8474ytaNk/npEVH3OIrAidY3EZrIynDGhsFEf4puXWlC8F6r2n9gEEUN9l4SXh6qLP544lDY=
X-Received: by 2002:adf:db84:: with SMTP id u4mr64714625wri.317.1577663696614;
 Sun, 29 Dec 2019 15:54:56 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8kwsnnvmo2Oyx-NDN17KGWTgDB+_CwNqsqJQWWe47sf3Q@mail.gmail.com>
 <xmqq4kxiiuba.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4kxiiuba.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Dec 2019 18:54:45 -0500
Message-ID: <CAPig+cRCRP3n8C3e7LGWdGWPzfgsxx0D0ZFiVqJRs4dtHVUFoA@mail.gmail.com>
Subject: Re: Autotools version
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 29, 2019 at 6:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> Jeffrey Walton <noloader@gmail.com> writes:
> > I'm trying to build 2.24.1 from sources. It is failing on an old
> > Fedora machine with the error:
> >     Autoconf 2.59 or higher is required
> > Would it be possible to drop the Autotools version back to earlier
> > versions of Git?
>
> Hmph, because the primary way to use our build procedure is to tweak
> with either command line or config.mak file without using configure
> at all, and because I don't use ./configure at all, I didn't even
> know that our release procedure was adding ./configure to the tarball.
>
> I wonder if it would help for me to stop shipping the file so that
> anybody who wants to use 'configure' can do so using their own
> version of autoconf?  That way, there won't be an issue like this
> that may come from autoconf & autotools versions, I guess.

Dropping 'configure' from the tarball would be a step backward, and it
wouldn't help in Jeffrey's particular case. The whole point of
distributing 'configure' in the tarball is so that people can still
build Git itself (via the familiar "./configure && make && make
install") even when they don't have autotools installed or when they
simply can't install a sufficiently recent autotools version. Years
back, I was often in situations building software for old operating
systems for which it was extremely difficult or impossible to get
autotools installed, so having 'configure' packaged in the tarball was
a lifesaver (because, although autotools itself may require a
sufficiently recent development platform, the generated configure
script doesn't).

Also, simply removing the Autoconf 2.59 requirement likely wouldn't
solve Jeffrey's problem since (presumably) the person who set that
version prerequisite did so because Git's configure.ac actually
requires features of Autoconf 2.59 and wouldn't work correctly with an
earlier version. By the way, Autoconf 2.59 was released in 2003, two
years before Git itself, so by restricting ourselves to 2.59 features,
we're already being quite build-friendly to old platforms.

A few options for Jeffery:

If you're not trying to track the bleeding-edge, build Git from the
tarball Junio releases.

If you're trying to follow the bleeding-edge, then grab 'configure'
from the latest tarball release and use it when building git.git.
(This may not be perfect, but configure.ac changes so infrequently
that it may be "good enough".)

Install Autoconf 2.59 rather than relying on the version supplied by
that old Fedora. (This is sometimes a necessary "evil" when building
modern software on old platforms.)

You could also try locally removing the Autoconf 2.59 prerequisite
from configure.ac and see if you get a working 'configure' script out
of it -- but I would be hesitant to accept such a change back into
git.git unless a thorough audit shows that Git's configure.ac doesn't
require any 2.59 features, and even then I would be hesitant because
it would restrict us from taking advantage of 2.59 features (and my
recollection was that 2.59 had a plenty useful enhancements that
earlier versions lacked).
