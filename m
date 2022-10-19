Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47C8C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 21:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJSVPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 17:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJSVPM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 17:15:12 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBBB138BB4
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 14:15:06 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d142so15616558iof.7
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=keP/TtEydxrMfu/onnnri/Z1haFnCypB2d5j46NQbuA=;
        b=pjb3sgAG3FEfjImbETySn8y3ZxLsDdVA+O9hoyH4yXMmuWn77DFQvgzxqn0GW8D8d+
         TNfOJmExph+2Hj/axVald7p1jkGk4E6/OWXnIDfm9e8z1LmXLLw1XXSbq0TB1C3vdDw7
         TT14qEGlltEEIid9fV9M1O/5b7LiU1x1tZmt0ZSvur/cJoKcBcG4HGu3+uD/AM0a1Lx/
         WpOwBpAjq1TdIiYegee1YGQvUtryELm/4qRPVdDalV5IPpBrI0xOjaot9yCWYTWTLvKx
         FJU54ToAmIYhG7dJFtiDMLbx5kdHdjhi7WS27ZNdmzR4cYbHucQZ/300y6SBg6H9iNer
         jlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keP/TtEydxrMfu/onnnri/Z1haFnCypB2d5j46NQbuA=;
        b=m5lpBZuk382fpXvkD6PiERJZt/cI7GSa8daPvuApq79s4o4/9ryvODPevOubkbPry6
         hxXUKV2alaZQquarzDvIHZPXiz2duROR/KTJvwFTqOMK4aGJlN4eynnmyJr/CdzbuFqs
         EKdpyD5389AAI1MhyXNOjeaLIGXO/pQlgsiQvKoATf1D3MmZLgYH3+9vf44FI+sdsgyI
         t1HptiB13Tu9v8xYZSdj2HgWo5URCRd/xntqZV7JSErG7ExDTdMB5fO9v+99WEjqqwXa
         KBpPwdx3vG4tknp5ntZNlMHp49S0a2Ryr5zqR/Akvqjp8DDAjWPY61F3T+tWbVhJtSG0
         fKhQ==
X-Gm-Message-State: ACrzQf2YiGwe+wLba7r3WEbhS1Yv6gBcdkzfryvZ1+4danQWtTuAXMd5
        QOnd0cWJ83dIZ0y7dQJYggbZ0ByqhvBygRLn
X-Google-Smtp-Source: AMsMyM77lwBaAqcdePWX78DCf+R4HyTf4kpIdTF4d9bMl5dqtIMASrc0tv/vgd26fbowXZ1COOoMBg==
X-Received: by 2002:a6b:f605:0:b0:6bb:cafc:ec27 with SMTP id n5-20020a6bf605000000b006bbcafcec27mr7448093ioh.194.1666214105248;
        Wed, 19 Oct 2022 14:15:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g12-20020a056602072c00b006a514f67f38sm2650618iox.28.2022.10.19.14.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:15:04 -0700 (PDT)
Date:   Wed, 19 Oct 2022 17:15:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH v2] embargoed releases: also describe the git-security
 list and the process
Message-ID: <Y1Bo18aU7YKKX9yh@nand.local>
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
 <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[-cc git-security]

On Wed, Oct 19, 2022 at 01:16:00AM +0000, Julia Ramer via GitGitGadget wrote:

> +Audience of the `git-security` mailing list
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Anybody may contact the `git-security` mailing list by sending an email
> +to <git-security@googlegroups.com>, though the archive is closed to the
> +public and only accessible to subscribed members.
> +
> +There are a few dozen subscribed members: core Git developers who are trusted
> +with addressing vulnerabilities, and stakeholders (i.e. owners of products
> +affected by security vulnerabilities in Git).

Everything in this section looks good. Though I wonder whether readers
will wonder how one subscribes to the list. You sort of address this
earlier in the proposed document, but I think it's worth clarifying here
to indicate the differences between subscribing to a public list like
this one, and the invite-only git-security list.

Perhaps something like:

    [...] the archive is closed to the public, and only accessible to
    invited members.

    There are a few dozen such members: [...]

which is basically just s/subscribed/invited, but I think it adds some
worthwhile clarity.

> +Most of the discussions revolve around assessing the severity of the reported
> +bugs (including the decision whether the report is security-relevant or can be
> +redirected to the public mailing list), how to remediate the bug, determining
> +the timeline of the disclosure as well as aligning priorities and
> +requirements.

Looks good, though I am unsure what "priorities and requirements" refers
to specifically. Could you elaborate?

> +A bug's life: Typical timeline
> +------------------------------
> +
> +- A bug is reported to the `git-security` mailing list.
> +
> +- Within a couple of days, someone from the core Git team responds with an
> +  initial assessment of the bug’s severity.

A few nitpicks on this and the above bullet point:

  - The git-security list isn't for bug reports, though there can be a
    security component to something that looks like a bug report.

    Perhaps to be clearer we should swap "bug" for "potential
    vulnerability"?

  - On "within a couple of days", I think that this is aspirationally
    true, though not always the case. Perhaps, "as soon as possible"
    instead? That's vague enough that I wouldn't worry about somebody
    reading this document >2 days after submitting a potential
    vulnerability wondering why nobody has gotten back to them ;-).

  - Finally, consider replacing "core Git team" with "member of the
    git-security list".

> +- Depending on the preferences of the involved contributors and reviewers, code
> +  review then happens either on the `git-security` mailing list or in a private
> +  fork associated with the draft security advisory.

There's a third option, too, which is using the private git/cabal
repository. Anybody who is a member of the @git/security team on GitHub
has access to this repository. And it is often a convenient option for
coordinating releases that contain fixes for more than one
vulnerability.

There aren't any hard and fast rules for which approach should be used
in a given circumstance, but I think it's worth mentioning it as another
option.

For my own $.02, I often find it useful to *start* by sending patches to
the git-security list inline with the thread so that the original
reporter (who is more often than not *not* a member of the @git/security
team) can participate in review (or at least look at the patches).

The private forks tied to a security advisory are often convenient
(assuming that the reporter has a GitHub account) since they provide a
shared workspace. But I think we usually avoid them when working on
preparing a release for more than one vulnerability.

> +- Once the review has settled and everyone involved in the review agrees that
> +  the patches are ready, the Git maintainer, and others determine a release date
> +  as well as the release trains that are serviced. The decision regarding which
> +  versions need a backported fix is based on input from the reporter, the
> +  contributor who worked on the patches, and from stakeholders (e.g. operators
> +  of hosting sites who may want to analyze whether the given bug is exploited
> +  via any of the repositories they host).
> +
> +- While the Git community does its best to accommodate the specific timeline
> +  requests of the various binary packagers, the nature of the issue may preclude
> +  a prolonged release schedule. For fixes deemed urgent, it may be in the best
> +  interest of the Git users community to shorten the disclosure and release
> +  timeline, and packagers may need to adapt accordingly.

I strongly agree with the above two points.

> +- Public communication is then prepared in advance of the release date. This
> +  includes blog posts and mails to the Git and Git for Windows mailing lists.

For what it's worth, GitHub does usually prepare a public blog post, but
I don't think we've typically shared them with the git-security list
ahead of time. Not because there's anything sensitive in there (I
personally would have no problem sharing them with git-security ahead of
time if there was interest), but just because nobody has asked. It may
be worth clarifying which communications we expect to have reviewed by
the git-security list during this period and which we do not.

> +The first step is to https://github.com/git/git/security/advisories/new[open
> +an advisory]. Technically, this is not necessary. However, it is the most
> +convenient way to obtain the CVE number and it give us a private repository
> +associated with it that can be used to collaborate on a fix.

This is all good. I would add some of the things we need to figure out
before opening a security advisory, too. By the time we want to open a
security advisory, we need to have the following information decided
upon:

  - Affected version(s)
  - Patched version(s)
  - Impact
  - Potential workaround(s), if any
  - Credit for finding and fixing the vulnerability

Determining which versions to patch is more-or-less up to the person
preparing those patches. Affected versions is usually "everything", or
"everything since xyz patch was merged". Impact is up for debate, though
usually whoever opens the security advisory writes this, and then
discussion occurs on the git-security as to its accuracy ;-).

Obtaining permission to give credit to the original reporter (and
anybody that they wish to include who was also involved in the
discovery) is important to do at this step, too.

Thanks,
Taylor
