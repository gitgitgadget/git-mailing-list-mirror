Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACBDC2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C76C2071E
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBdgNm9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfL3TzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:55:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43643 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfL3TzI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 14:55:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so18478376pga.10
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 11:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dhScR8twEWCbz4fdioa+HiIuZQF4q2/XxNvsvIiHtw=;
        b=OBdgNm9by6y1BMvRI9JMvrYTVbCKaRdcCxObnomJrG7AzXFvzT3W6QWvkaw/QlzTYG
         Hq+iwZ5d95kYxExFJ4k46QCQ7/Xrjr0czptSVN7w/fTCz7S2hQBkmx9aXLBQB54VmOAk
         pySRbowa15wmP6PR26UrM7eSU0dGOuiahXebcYqlMlcKWGQoSzUnw8jY7PGiUIZz0eJC
         5xTaEur9spXugOP+CsQ4NbqmqgU/KboDwL139eSCxRMGUIDzpm3CzeTXIGyX7VHMkEAX
         3BQUHIWGvL1JZAfMSya/GWeAZ1QP+QmQZDOO7zdB0gF+ptDK6LEHCsWLXUZ2kJ+jPFkA
         MuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dhScR8twEWCbz4fdioa+HiIuZQF4q2/XxNvsvIiHtw=;
        b=O2Xl/uVRD9NnqsnRpuhaKE60gxHrLX2QIWg4/jsfkcVyxbb0E2bA6o9YoKIV8Hq5sJ
         JEYb8I21v8bQEvWTCrQcmN8zJ4DJ8XI12f4hG7JlbkcG4DlJ54mbo8/V/qIYkw8AxSxG
         OQcDHG8rHno1c9hszhpUq7/IG7DfDSkiFk6lE7JB6IqfZy80p8uxOaSxyDbjYVaCpo3U
         n3tL6R3Omhd/0aRejUFwj/5P74WpLcR9+1xfAZr0ZdPDahlvAUQg8srveRBe/NRetMUs
         y/SBMSm/3jg/wAcQ33zMhg14S8y6P413mI8hcT1I9dqMqxv7JoEs4ZSubSn0HRoIkgvm
         S2uQ==
X-Gm-Message-State: APjAAAVdax1Ckfl7F1Sc1Jwh5I/wId0KIWqxc0UjJFZLrVmzOoXfzdwY
        x2hj3myDO9auJHMVJlX7txki8VTC
X-Google-Smtp-Source: APXvYqzxrniVV/5lYWjvGpTJEJ+YQpc6TCCcErwsQXry7I2QiyXb7/Vl1b4iR5gzLToGa809dx4C5w==
X-Received: by 2002:a63:dc0d:: with SMTP id s13mr71273385pgg.129.1577735707750;
        Mon, 30 Dec 2019 11:55:07 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b19sm37589201pfo.56.2019.12.30.11.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:55:07 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:55:05 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Gal Paikin <paiking@google.com>
Cc:     git@vger.kernel.org, repo-discuss@googlegroups.com, ajp@google.com
Subject: Re: Updating the commit message for reverts
Message-ID: <20191230195505.GD57251@google.com>
References: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(also cc-ing the Gerrit list. The git mailing list requires plain-text
 email and prefers bottom-posting; there shouldn't be any other
 gotchas if you reply-all)
Hi Gal,

Gal Paikin wrote:

> I work on the Gerrit team and I would like to change the default
> behavior for suggested commit messages for Reverts.

Thanks for writing.  I like it when tools behave consistently with one
another, so I'm glad you brought it up here.

> Currently, if the user is trying a change called '"Revert "change X"',
> the suggested commit message would be 'Revert "Revert "Change X""'
> which is silly, since sometimes users want to revert the same change
> many times.

For context, [1] is where this was discussed previously on the Gerrit
mailing list.  Do you have more context?  For example, have there been
reports from users requesting this kind of change?

For a bit of precedent, the Chromium project has some custom logic[2]
that rewrites a revert of a revert to "Reland".  I kind of like that,
since it makes the intention behind the revert-of-revert a little
clearer.

If both reverts are clean, then the typical use case I can think of is
that a prerequisite was missing, hence the revert; after all the
prerequisites were in place, it was then safe to roll forward, hence
the reland.  I would hope that the full commit messages for these
revert commits would provide this context since without that kind of
communication from the people involved, a reader is lost.

> The suggestion is to change the behavior to "Revert^N" instead of
> multiple Reverts one after another.

This would be replacing one kind of jargon with another, so it's not
clear to me that it would improve matters.

With Revert / Reland, we can forget the N altogether:

 1. 'Do some great thing'
 2. 'Revert "Do some great thing"'
 3. 'Reland "Do some great thing"'
 4. 'Revert "Do some great thing"'
 5. (etc)

For the reader of the shortlog, it's not too important how long the
edit war has gone.  The single word makes it clear what the commit
is going to do.

In the full commit message, I would hope that people put in some
explanation of the story so far to explain why they have gone
back-and-forth all these times.

Thanks and hope that helps,
Jonathan

[1] https://groups.google.com/d/msg/repo-discuss/edl43LcyEKE/f9Q65kOcBgAJ
[2] https://chromium-review.googlesource.com/c/infra/gerrit-plugins/chromium-behavior/+/757684
