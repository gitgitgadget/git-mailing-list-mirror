Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEB3C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 14:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4B022AAD
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 14:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbhAEOWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 09:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAEOWX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 09:22:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35359C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 06:21:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id dk8so37159edb.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 06:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K690TIt91VlQx3CFA6BhpWUEKSEsmUWwKvS7jLtAy+I=;
        b=rGb2Nxygn/La9txW1R1psz4GHJ/GhHGenGe6O/K6SDjmEk1DwyO0jwAdQEi1yLrs6E
         FV9KdyzBZ2h6avbGK5GI3CIciWU/GV7DLb7sRPE6zYb2I4J+9XeZUzD+BjOZzCgLiDYU
         oDzfOitX7lRVNNZtAKNSUq+nUhOoHIAByQgdBc2ATub+qnGqUffWvY5XFhqa4l9ywjLQ
         JLyhj8yQvnHRx+0P0qvUThLzm2P7dSIcG/xyzt1N85QBvO4ffqHocv0x3QpScLdVi2Bs
         edZGUqg0vIv6M95GQdkTK4dsJ5gt/ZmH1rg+qScj78HxQSyWi1IZRJkgeZt/8uX3ARf4
         jgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=K690TIt91VlQx3CFA6BhpWUEKSEsmUWwKvS7jLtAy+I=;
        b=WUTtmuy4CVEdDhT5Tb8bgeKUC0rInGbkTJ9M1QgusOQNO8MKVRB7hZSEzd0ruwmUjl
         x8tEowGyMt+RhPBnB1po3t11fI94YQezN446YDYDiIuFAW+EaV43/2OEjWGsLh7fhUea
         A5jF8gFa//TTSTBnk9Y6QhfNISTw/Nhvru8MCZ/6qUOqS2z5ZsY5pWtHNfABePVgQteK
         mLkWublY6SIbq6kVEtvHQg6V0+ykWRS/HqA2oWBEWMn+RQf9FooTS0Ew6LUjDIxi8P65
         1szOIGMTYNfbDt+NDHhs6qPg/Cj/oLSvw8CgLfZOongGe+An4cHEWGJ+ziGpoJZtzB1e
         4mqQ==
X-Gm-Message-State: AOAM530oUfd9qNvybY65HcsansLKIka5uNs+yNVR6Ode5riKibn2VysN
        xrtvmWI8lXhg6JVBWt+LhINXN90Q2LX3Bw==
X-Google-Smtp-Source: ABdhPJytWvJhhNbBAIyrhxFLsjUUIlnnW7ANQR7CvobcOT99g5qPhAYdugOpvOHicV8XiXb7/gqT0Q==
X-Received: by 2002:a05:6402:94c:: with SMTP id h12mr76187082edz.268.1609856501831;
        Tue, 05 Jan 2021 06:21:41 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id pk19sm24804551ejb.32.2021.01.05.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 06:21:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/5] mailmap: support hashed entries in mailmaps
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
 <20210103211849.2691287-6-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20210103211849.2691287-6-sandals@crustytoothpaste.net>
Date:   Tue, 05 Jan 2021 15:21:40 +0100
Message-ID: <875z4bsbuz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 03 2021, brian m. carlson wrote:

I think it makes sense to split up 1-4/5 here from 5/5 in this series
since they're really unrelated changes, although due to the changes in
1-4 they'll conflict.

> Many people, through the course of their lives, will change either a
> name or an email address.  For this reason, we have the mailmap, to map
> from a user's former name or email address to their current, canonical
> forms.  Normally, this works well as it is.
>
> However, sometimes people change a name or an email address and wish to
> wholly disassociate themselves from that former name or email address.
> For example, a person may transition from one gender to another,
> changing their name, or they may have changed their name to disassociate
> themselves from an abusive family or partner.  In such a case, using the
> former name or address in any way may be undesirable and the person may
> wish to replace it as completely as possible.

The cover letter noted "As mentioned in the original thread, I think a
hash rather than an encoding is the right choice here.". Reading the v1
I think you're referring to
https://lore.kernel.org/git/X9wUGaR3IXcpV0nT@camp.crustytoothpaste.net/

In v1 I pointed out you needed to read some combination of the cover
letter & the patch to see what this was intended for (see [1]). I think
for v3 the commit itself should summarize the trade-offs & design
choices.

> For projects which wish to support this, introduce hashed forms into the
> mailmap.  These forms, which start with "@sha256:" followed by a SHA-256
> hash of the entry, can be used in place of the form used in the commit
> field.  This form is intentionally designed to be unlikely to conflict
> with legitimate use cases.  For example, this is not a valid email
> address according to RFC 5322.  In the unlikely event that a user has
> put such a form into the actual commit as their name, we will accept it.

We'll emit the commit author information as-is in that case under "git
show", or run the mapping and map it via mailmap? Anyway, it seems
there's a test for this. Probably better to just point to it.

> While the form of the data is designed to accept multiple hash
> algorithms, we intentionally do not support SHA-1.  There is little
> reason to support such a weak algorithm in new use cases and no
> backwards compatibility to consider.  Moreover, SHA-256 is faster than
> the SHA1DC implementation we use, so this not only improves performance,
> but simplifies the current implementation somewhat as well.

I agree with most of this aside from the "weak algorithm" part. That
seems like an irrelevant aside for this specific use of a hashing
algorithm, no? We could even use MD5 here, so SHA256-only is just
setting is up for not needing to deal with SHA1 forever in this one
place in some SHA256 future repo.

> Note that it is, of course, possible to perform a lookup on all commit
> objects to determine the actual entry which matches the hashed form of
> the data.  However, this is an improvement over the status quo.
>
> The performance of this patch with no hashed entries is very similar to
> the performance without this patch.  Considering a git log command to
> look up author and committer information on 981,680 commits in the Linux
> kernel history, either with an unhashed mailmap or a mailmap with all
> old values hashed:
>
>                                    Shortest  Longest  Average  Change
>   Git 2.30                         7.876     8.297    8.143
>   This patch, unhashed             7.923     8.484    8.237    + 1.15%
>   This patch, hashed               14.510    14.783   14.672   +80.17%
>   This patch, hashed, unoptimized  15.425    16.318   15.901   +95.27%
>
> Thus, the average performance after this patch is within normal
> variation of the pre-patch performance.  It's unlikely that users will
> notice the difference in practice, even on much larger
> repositories, unless they're using the new feature.

Am I reading this right that if there's a single hashed entry in
.mailmap anything using %aE or %aN is around 2x as slow?

Your v1 mentioned that a project might "insert entries for many
contributors in order to make discovery of "interesting" entries
significantly less convenient." which is gone in the v2 patch. As noted
in [1] I don't see how it helps the obscurity much, but if that's still
the intended use we'd expect to get more slowdowns in the wild if users
intend to convert their whole mailmap to this form if they want a single
entry to use the form.

Anyway, as you might have guessed I'm still not a fan of this direction.

But most of it is because I honestly don't get why this specific
approach is required to achieve the stated aims, there's a few of them,
so here's an attempt to break them down:

1. User changed their name and doesn't want themselves or others to see
  their old name

For the case where Joe Developer is now known as Jane Doe in most cases
you don't need to put the old name at all into the .mailmap. E.g. for
git.git this patch to our .mailmap produces the same output for `log
--all --pretty=3D"%h %an%ae%aN%aE"`:
=20=20=20=20
     brian m. carlson <sandals@crustytoothpaste.net>
    -brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpa=
ste.ath.cx>
    -brian m. carlson <sandals@crustytoothpaste.net> <bk2204@github.com>
    +<sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
    +<sandals@crustytoothpaste.net> <bk2204@github.com>

So the new->name/email mapping (as opposed to new->email) is really only
needed for some really obscure cases where two people shared an E-Mail
or something.

So we're talking about hiding the old E-Mail, presumably because it was
joe@ intsead of jane@, so in that case we could just support URI
encoding:

    Jane Doe <jane@example.com>
    <jane@example.com> <%6A%6F%65@%64%65%76%65%6C%6F%70%65%72.%63%6F%6D>

Made via:

    $ perl -MURI::Escape=3Duri_escape -wE 'say uri_escape q[joe@developer.c=
om], "^@."'
    %6A%6F%65@%64%65%76%65%6C%6F%70%65%72.%63%6F%6D

Which also has the nice attribute that people can make it obvious what
part they want to hide, since this is really a feature to enable social
politeness & consideration:

    Jane Doe <jane@example.com>
    # I don't want to be known by my old name, thanks
    <jane@example.com> <%6A%6F%65@developer.com>

2. Hiding from your enemies

For the other use-case of "abusive family or partner" I had the comment
in v1 of "but not so much that you'd still take the risk of submitting a
patch to .mailmap?".

Now that's obviously phrased in an off-the-cuff manner, but I'm
serious.

I think it is important that the non-security of this feature obviously
looks like some trivial encoding, because that's what it is. People get
lulled into a false sense of security with these things all the time
(e.g. thinking their "Authorization" HTTP header is safe to post on a
public pastebin). So we should as much as possible make this look like
the non-security it is.

3. Enabling people not to treat .mailmap as binary or a multi-encoding
file.

I mentioned this in my [1]. Your implementation doesn't do this, but
e.g. it would be very nice for a project that switched from latin-1 to
utf-8 to be able to do, in some cases:

    # Made with: perl -MURI::Escape=3Duri_escape -wE 'say uri_escape "@ARGV=
", "^a-z@. "' $(echo =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason | iconv -f utf-=
8 -t iso-8859-1)
    #

    =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> %C6var %41rnf=
j%F6r%F0 %42jarmason <avarab@gmail.com>

Or some combination thereof, so e.g. previously Big5/latin1 who migrated
to UTF-8 don't need to have non-valid UTF-8 in .mailmap

4. Spam

You mentioned this in your [2] (but not as a use-case in the v2
re-rolled commit message):

    And we know that spammers and recruiters (which, in this case, are
    also spammers) do indeed scrape repositories via the repository web
    interfaces.

Surely these people are most interested in the current E-Mail addresses,
which if they're scraping the common web interfaces (e.g. Github,
GitLab) are easily accessible there. It doesn't seem very plausible that
someone would care enough to scrape .mailmap for old addresses but not
just update their scraper to clone & run "git log" for the purposes of
e.g. their recruitment E-Mails.

5. Interaction with other systems

Something I mentioned in the last 3 paragraphs of my [1]. I think you're
only considering the cases where git itself does the mailmap
translation, but we have 3rd party systems that make use of the format
in good ways (also doing the Joe->Jane mapping). Making it a hassle for
those systems makes it more likely that Jane doesn't get the mapping she
wants.


1. https://lore.kernel.org/git/87eejswql6.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/X9wUGaR3IXcpV0nT@camp.crustytoothpaste.net/
