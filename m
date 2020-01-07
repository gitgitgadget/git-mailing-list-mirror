Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5DBC33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB65207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="hHBSao96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgAGEJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:09:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36722 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgAGEJX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:09:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so27938636pfb.3
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=1jx+ONNh6e+NHnT6RSDWN6Ki/aDSwB5fC7dBVgEuJJM=;
        b=hHBSao96IgeRgt38YD9T5MezoypD0JRJ39p4LmFHDy54QNLEh3Z5iKWPd+jvJYIS8/
         MQWX3bs+OXfR++LpA9SZke3tEz3+7mgV+gBEmuNeQ6hxh4ol+Q/ns9sdBR1aneQTMq9B
         qxVfK9WPIMaNECYcMr7baPNWUiVwVcSlRJmU7NO79X132sx69ll6xt29xWbzuY4Rm3Fv
         7NwJij9p3WpV8T+z5g6pz57y65OdB8ctxKOzkfSVyUX9ctJppvZquorXXgFymIet1Jor
         HYIJG1ptle0YZWer+CENgVQuvi5q1DJBMEzjg0Ejpfbr33eAxChPJuJFXuX1idzTlhpA
         PK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1jx+ONNh6e+NHnT6RSDWN6Ki/aDSwB5fC7dBVgEuJJM=;
        b=FnlBu98VlQqjCs9pCN/1ThctI7ndpNmUIZ13+dFl+0V8gzaIYz9k7Wfus2d+DX8tJS
         7e7drNCvo5h49m/AzffqnOhGk/ZZveockkHKQKGfwJMKtoekKR1W08ISlaXJjDGQbHTC
         NOJw57E8UqDQ9L55XeHPqqoNgP/XsNoLNq3y7a+Yc3kF0H3wRMPYn3b1vxx36O5EBFI5
         xB4lt6RMZLCps9K1ysvk0Dkg7BeAt/Rn00KXT/nBO1rSQ7UUAh76dJX1EFJrUIR+KTQx
         NHEUNXyiEQ3Pbn0lXbO0ZfAGd267bMEP27LlWXao2J/D03O5wEOgptDJ6yvbZFhQqvDj
         5xAg==
X-Gm-Message-State: APjAAAVVKvlQxPjV1jQ/1I2SPj0Ldih3HxeDCEgszhsOF1AmAoHlcPDa
        pmS+Nf8AOhAGRYzTk4Yr0rM+SA==
X-Google-Smtp-Source: APXvYqwwR1C13wmm5MOatMpZ12366ePo0FwzwZ5pnSqozazDFiOQ2yC0ho/f/jxSvkG4Ui6pU8Ve6g==
X-Received: by 2002:a63:510e:: with SMTP id f14mr115524225pgb.35.1578370162558;
        Mon, 06 Jan 2020 20:09:22 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id b42sm26425900pjc.27.2020.01.06.20.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:09:22 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] refactor gpg-interface and add gpg verification for clones
In-Reply-To: <xmqq36ctbis8.fsf@gitster-ct.c.googlers.com>
References: <20200105135616.19102-1-hji@dyntopia.com> <xmqq36ctbis8.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 07 Jan 2020 04:06:11 +0000
Message-ID: <87lfqjnc5o.hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 05 2020, Junio C Hamano wrote:
> Hans Jerry Illikainen <hji@dyntopia.com> writes:
>
>> And finally, signature verification is added to the clone builtin.  It
>> obeys --(no-)verify-signatures, clone.verifySignatures and
>> gpg.verifySignatures (in decreasing order of significance).
>
> I am not sure what it should mean to verify signature on clone.  I'd
> assume that our threat model and verification policy are consistent
> with what we use for a merge/pull, in that we trust all history
> behind a commit that has a trusted signature, so it is clear that
> you would want the tip commit of the default branch (or if you are
> naming a single branch to clone, then the tip of that branch) to
> carry a trusted signature.

Yes, that's how it's implemented in v0 -- the tip of the branch/tag that
is to be checked out is verified.


> But what about the commits that are reachable from other branches and
> tags that are *not* contained in the branch that is initially checked
> out?

I thought about that and figured that adding signature verification for
the checkout builtin would be the next step after this series.  That
thought should probably have been mentioned in the cover letter for
criticism -- because now I'm not sure if that's a reasonable approach
anymore.


> Later in the proposed log message of 5/5 you allude to risk of
> merely checking out a potentially untrustworthy contents to the
> working tree.  This is far stricter than the usual threat model we
> tend to think about as the developers of source code management
> system, where checking out is perfectly OK but running "make" or its
> equivalent is the first contact between the victim's system with
> malicious contents.

Modern desktop environments perform enough magic that I think it makes
sense to assume that simply having malicious content on disk is enough
for a compromise -- even though no explicit user interaction takes place
with that content.  The NSF bug in GStreamer that made headlines a few
years back is a good example of that [1].  And the numerous AV bugs
published by taviso [2].


> Verifying the tip of the default/sole branch upon cloning before the
> tree of the commit is checked out certainly would cover that single
> case (i.e. the initial checkout after cloning), but I am not sure if
> it is the best way, and I am reasonably certain it is insufficient
> against your threat model.  After such a clone is made, when the
> user checks out another branch obtained from the "origin" remote,
> there is no mechanism that protects the user from the same risk you
> just covered with the new signature verification mechanism upon
> cloning, without validating the tip of that other branch, somewhere
> between the time the clone is made and that other branch gets
> checked out.

I agree.  Again, I should have mentioned my thoughts on adding signature
verification to the checkout builtin in the cover letter.


> It almost makes me suspect that what you are trying to do with the
> "verification upon cloning" may be much better done as a "verify the
> tree for trustworthyness before checking it out to the working tree"
> mechanism, where the trustworthyness of a tree-ish object may be
> defined (and possibly made customizable by the policy of the project
> the user is working on) like so:
>
>  - A tree is trustworthy if it is the tree of a trustworthy commit.
>
>  - A commit is trustworthy if
>
>    . it carries a trusted signature, or
>    . it is pointed by a tag that carries a trusted signature, or
>    . it is reachable from a trustworthy commit.
>
> Now, it is prohibitively expensive to compute the trusttworthiness
> of a tree, defined like the above, when checking it out, UNLESS you
> force each and every commit to carry a trusted signature, which is
> not necessarily practical in the real world.

Even though you mention that it's computationally expensive, I kind of
like this approach.  It seems generalized enough that it doesn't need to
be tied to a single operation like 'clone'.


> Another approach to ensure that any and all checkout would work only
> on a trustworthy tree might be to make sure that tips of *all* the
> refs are trustworthy commits immediately after cloning (instead of
> verifying only the branch you are going to checkout, which is what
> your patch does IIUC).  That way, any subsequent checkout in the
> repository would either be checking out a commit that was
>
>  - originally cloned from the remote, and is reachable from some ref
>    that was validated back when the repository was cloned, or
>
>  - created locally in this repository, which we trust, or
>
>  - fetched from somewhere else, and is reachable from the commit
>    that was validated back when "git pull" validated what was about
>    to be integrated into the history of *this* repository.

Wouldn't that still forgo signature verification when doing something
like:

    $ git fetch
    $ git checkout -b foo origin/branch-with-previously-unseen-commits

unless either fetch or checkout is equipped with signature verification?

Also, in case of a revoked key, this approach would require that tags
signed with that key be deleted on origin.  Maybe that's to be
considered best practice anyway, but distro maintainers might not
appreciate disappearing release tags.

Also, an interesting observation (but probably a "not our problem" as
far as Git is concerned) -- I have noticed that certain git forges might
create branches unexpectedly.  A few of my repos has dependabot/...
branches created by a GitHub bot that is enabled by default:

"""
Automated security updates are opened by Dependabot on behalf of
GitHub. The Dependabot GitHub App is automatically installed on every
repository where automated security updates are enabled.
"""

I can foresee a scenario where validating the tip of every ref on a
fresh clone would result in a DoS for lot of automated CI/CD-type
workflows when bots on GitHub (and other hosts) creates unexpected
branches in the users repos.

    $ git branch -r
      origin/HEAD -> origin/master
      origin/dependabot/pip/requirements/typed-ast-1.3.2
      origin/master


> Hmm?

I appreciate you taking the time to write your thoughts!  Unfortunately
there doesn't seem to be an obvious approach that is significantly
preferable to the alternatives.  I will experiment with the ideas you
mentioned above and see if I can come up with something that makes
sense.

Would you prefer that I break off the series before 5/5 in a new series
to fix the comments you made on the other patches that seem
almost-mergeable?

Thanks!


[1] https://scarybeastsecurity.blogspot.com/2016/11/0day-exploit-compromising-linux-desktop.html
[2] https://bugs.chromium.org/p/project-zero/issues/detail?id=769

-- 
hji
