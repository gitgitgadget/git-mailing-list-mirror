Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07C8B1F4DD
	for <e@80x24.org>; Sat, 26 Aug 2017 14:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbdHZOrf (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 10:47:35 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37315 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbdHZOre (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2017 10:47:34 -0400
Received: by mail-qt0-f172.google.com with SMTP id d15so10155038qta.4
        for <git@vger.kernel.org>; Sat, 26 Aug 2017 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4onfwn3CKwHnzETUDrvpSRYf1ar074kuew+QwBfaryc=;
        b=X8m1O66FwNiS1znakRdnnNjtjpZvxUuRHIodxCxmaPxrfvSBjmg9I6TRUJ3dN7lpEr
         CXCNbv2Cu6xEcl0kN1bY6JeE0thFdcJI2iTbfFNlYslpXf7nCvxXHomO8KkVouBE+t9K
         wxCl7gQSulvK4D1bWBa5Akm/NMUpStXvLngBWJAUuyNTIyhaVGklctGAGyMc2GGfhUdE
         Vwi1l8TAMjU4d7jnn/1mKhowCPeqZTLHR40CvofICX7GX3L0D+jRAt2QTB2Tfb9jkvd9
         f4ky/4FZgIE0UNElDuFlf3nudO56+aRacMUP4v7fi40QOiVdpZFCo6vrztjyG6Q5sfFk
         AmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4onfwn3CKwHnzETUDrvpSRYf1ar074kuew+QwBfaryc=;
        b=rVJpnGTdV7NNNlncnWwv1Vf5/+vQWzE/6TA00+LRFwQb+lx3Zvjs89GIQ/opep1bew
         Ugwq7LiAFMd9MC0T8FbfqeLbKs0o/jjJCPi5rjD4/66bZfNRcNL/NPp2smJ1PSRUfmEU
         /ofvDeLt73nr+XroPpKZ9tLMHVzpDpeSPIFg50bp85MQyWCHXrmJXu27FJ42gtStcKwF
         im7cDxP6jpHwN7EUlS71sEE+9/gQD0X1Gb6YfTdWx7bcwqDICjkuqvtr0X0bXFcBO9xj
         WTJKBWHazuMZhnmE/3qwaNDdhYiLhBm+RRvhJZS1XdMe5sOFdgm8Zx6on7LoCc1/GOzH
         pBCw==
X-Gm-Message-State: AHYfb5i/tS3oVhz8c6xY1sAHTUj0Y6z9SyC8egkaDl7RyQX6hfdvYK/Z
        5+u9Eafs7l/1CqSnj5NQl6JJfRk58Y32SrI=
X-Received: by 10.237.57.106 with SMTP id l97mr2604553qte.128.1503758853213;
 Sat, 26 Aug 2017 07:47:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.45.117 with HTTP; Sat, 26 Aug 2017 07:47:17 -0700 (PDT)
From:   =?UTF-8?Q?K=C3=A9vin_Le_Gouguec?= <kevin.legouguec@gmail.com>
Date:   Sat, 26 Aug 2017 16:47:17 +0200
Message-ID: <CAOAAw7WsiwzQYhiU9xxcoteaEWgaXRQkiVb0Xa2WckR4=m-bFw@mail.gmail.com>
Subject: git describe and "the smallest number of commits possible"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've asked this question on the git-users Google Groups list[1], and
while the answers there were interesting, I still cannot figure
whether my problem comes from an actual bug, a misleading manpage, my
inability to understand the code and/or the manpage, or a combination
of the three.

I noticed this problem on 2.1.4 (Debian oldstable); I can reproduce it
on next (7ef03bb281b2220d0f2414365e4949beb2337042). Quoting
git-describe(1)'s SEARCH STRATEGY section:

> If multiple tags were found during the walk then the tag which has
> the fewest commits different from the input commit-ish will be
> selected and output. Here fewest commits different is defined as the
> number of commits which would be shown by `git log tag..input` will
> be the smallest number of commits possible.

To put it shortly, after cloning GNU Emacs's repository[2]:

    $ git describe --tags
    emacs-25.1-129847-gdcc3ef3ee7
    $ git log --oneline emacs-25.1.. | wc -l
    5126
    $ git log --oneline emacs-25.2.. | wc -l
    4793

If I am reading it correctly, the manpage suggests that emacs-25.2
should be picked in this situation ("log emacs-25.2.." shows fewer
commits than "log emacs-25.1..").

Once more with --debug:

    $ git describe --debug --tags
    searching to describe HEAD
     lightweight   129847 emacs-25.1
     lightweight     4086 emacs-25.1-rc2
     lightweight     4126 emacs-25.1-rc1
     annotated       4185 emacs-25.2
     annotated       4220 emacs-25.2-rc2
     lightweight     4226 emacs-25.0.95
     annotated       4236 emacs-25.2-rc1
     annotated       4280 emacs-25.1.91
     lightweight     4305 emacs-25.0.94
     lightweight     4329 emacs-25.1.90
    traversed 130257 commits
    more than 10 tags found; listed 10 most recent
    gave up search at 5c587fdff164e8b90beb47f6da64b4884290e40a
    emacs-25.1-129847-gdcc3ef3ee7

I tried to get a sense of what builtin/describe.c is doing (see [1]
for some debug printfs); to summarize what I figured:

- When QSORT() is called in describe(), emacs-25.1's depth is smaller
  than emacs-25.2's.

- finish_depth_computation() updates the best candidate's depth; AFAIU
  this update's only purpose is to make the displayed suffix more
  accurate.

That is all I have right now. I apologize for failing to come up with
a simpler test case (I tried to make toy repositories with a similar
topology to reproduce the issue, to no avail). To conclude, as far as
I can tell, one of the following holds:

- something about this repository[3] causes git-describe(1) to not
  work as advertised;

- I fail at reading manuals.



[1]: https://groups.google.com/forum/?fromgroups#!topic/git-users/tSnX-O-3aNI

[2]: https://git.savannah.gnu.org/git/emacs.git

[3]: The project's workflow sounds straightforward:

- development happens mainly on the master branch;
- the emacs-25 branch receives maintenance fixes and release tags; it
  is periodically merged back into master;
- experimental work can happen on scratch branches; these may
  eventually be merged back into master.

There are some complications (e.g. pull-induced merges) but if
I --simplify-by-decoration I find that the repository's topology
matches this description.
