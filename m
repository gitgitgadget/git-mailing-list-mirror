Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0373D1FE4E
	for <e@80x24.org>; Tue, 21 Jun 2016 03:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbcFUD7X (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 23:59:23 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34622 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbcFUD7W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 23:59:22 -0400
Received: by mail-vk0-f48.google.com with SMTP id t129so5018539vka.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 20:58:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=FhW8Z7qkOOUDLGu278sphoIpGAi58329wcHfRhh2AGA=;
        b=D7dyu31VEPVzwQBx0rST+TEDFiaAnH1Y9zOCpe5arp0G2ZRpkW39+hqssw14qlmDuz
         L5po9vn5VlVVs7kZLaseHVZ+IZPt068sDqy48r6qgSp+Wl4bCXF0Smo2KA8DWawcT0OV
         LV7ypI96GwxspVE8B1pYd0mbnm9iukXxZO8wp3LBaMwLxheqUAzcBsEv35eY8kGZI2iQ
         iV+hFk16xHGpVLd+sznFLOm1nUc1SfUdq38kn+m/U3XG08YqULr1mB8x4jmH9v+gv6PD
         e0/UNry5m1IqNBq6DZvy9TO/EIPIsQD2RU4R3uiXSKPVl0ttmdjXnWYPCl58M1ZPSakR
         BKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FhW8Z7qkOOUDLGu278sphoIpGAi58329wcHfRhh2AGA=;
        b=OsqlaJO1Xi6g7IzR6Btw65sZr4+pGEP/CtF6q+TFj7N19vLhcYXGehj4LdWDlQmDM1
         IpryPPAyap3yPfG55v0lj1XXBfSQWceEGzppNEShqK161ZI1NxWvq3Ved41yjqWPGysK
         G7Ev+E93mJH7NVy3ONcvJkTnWZ5jEIu76UxGzWphGJeuJiGlaLbFjkbpCQ42hX980aAQ
         AWHjlfaxWLIxnKqbo8dna7XpbAkk25rQvnIBnDIKk+6dyCFHVQXM2NA/h3Rp3sWtx8eM
         /0qZvdhm8K/2aUDi45Z6BKTnSandKqOhKfOERr2H88hNekATv0S0Bh3FIHO2i1FJ14BQ
         yftg==
X-Gm-Message-State: ALyK8tKiePfmc8aqNOw1RXQ0MdhtnR7h2J4kDcwkIeueThbGCQD9HIMsoitHv5Dbw8I3MflN/jUnZwo8DePulw==
X-Received: by 10.31.188.80 with SMTP id m77mr8377251vkf.30.1466481501192;
 Mon, 20 Jun 2016 20:58:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.2.70 with HTTP; Mon, 20 Jun 2016 20:58:20 -0700 (PDT)
From:	David Lightle <dlightle@gmail.com>
Date:	Mon, 20 Jun 2016 22:58:20 -0500
Message-ID: <CAP4gbxqjHzqHhPuNK8UOwPMa46g2=vcNSk1AvGjxN8s+ou-0Dw@mail.gmail.com>
Subject: Fast-forward able commit, otherwise fail
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

I am trying to build a git workflow in our enterprise and am almost
evenly torn between a "rebase workflow" and git-flow (which uses merge
instead of rebase, obviously).  We are using Bitbucket for pull
requests as code reviews (right or wrong).

I apologize if my inexperience with git shows through, but I'm wanting
to achieve the following --

Maintain two long-running branches (develop as a stable pre-release,
master as a deployed version), with short-term feature branches off of
develop and short-term release branches that are based on develop and
merge into master eventually (ie. a lightweight git-flow).

However, as part of this, I would prefer to require/ensure that each
feature branch is up-to-date and otherwise able to be fast-forwarded;
we currently have this with the bitbucket server setting requiring
--ff-only.

The other half of what I would prefer is to still perform the merge
commit, though, to ensure separate tracking of the feature branches
(ie. --no-ff).

I know that I have read that --ff-only and --no-ff are contradictory,
but I believe that is somewhat ambiguously correct -- I believe the
two flags contradict in the sense of "what to do with the merge
commit", but not necessarily on the "when it can be done".

I read an ancient post about on this list (which predates the
tri-state of fast-forward) that I believe could have allowed this to
work.

I have also read a few articles and posts that achieve this more as a
matter of practice than a workflow enforcement via git flags; for this
to be something to potentially get absorbed into a Bitbucket workflow,
I suspect it would need to a git flag (they now support merging via
--ff, --no-ff, --ff-only, --squash, and --squash-ff-only for their
hosted solution, for example).

Here are a few articles that say they prefer this approach (rebase and
then merge --no-ff):
https://walkingthestack.blogspot.com/2012/05/why-you-should-use-git-merge-no-ff-when.html
http://blog.differential.com/best-way-to-merge-a-github-pull-request/
http://victorlin.me/tags/rebase

Can anyone share their thoughts on workflows that might achieve what
I'm looking at here or opinions on adding the functionality I'm
describing?

Thanks!
