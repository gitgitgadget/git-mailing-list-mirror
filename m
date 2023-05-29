Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C5C77B7A
	for <git@archiver.kernel.org>; Mon, 29 May 2023 13:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjE2NlS convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 29 May 2023 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjE2NlR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 09:41:17 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8278E
        for <git@vger.kernel.org>; Mon, 29 May 2023 06:41:16 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34TDdotf1065017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 13:39:51 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Paul Jolly'" <paul@myitcv.io>, <git@vger.kernel.org>
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
In-Reply-To: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
Subject: RE: Automatically re-running commands during an interactive rebase or post commit
Date:   Mon, 29 May 2023 09:41:08 -0400
Organization: Nexbridge Inc.
Message-ID: <002901d99233$3d0c8b80$b725a280$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQDneTaXbkso+fEzMDaNKqU33vFREbFVc67A
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>-----Original Message-----
On Monday, May 29, 2023 9:39 AM, Paul Jolly wrote:
>I would appreciate some advice on the best way to solve the following problem.
>
>As part of my project, I have a code generation script that sha256 hashes a number of
>files to another file. This produces a deterministic "has this part of the project
>changed" indicator via the code generated file's content, that I then use in various
>cache invalidation steps.
>
>This means, however, that I need to re-run that code generation script as part of each
>commit in order to ensure that the code generated hash file is current (I have a step
>in CI that detects if it is not, which re-runs the code generation script to then see if
>the commit is "clean").
>
>As part of my development setup I do a lot of interactive rebasing to edit earlier
>commits in a branch (these "stacks" of changes are reviewed via Gerrit, which
>understands a relation chain of changes).
>Via this workflow, I often do a git rebase and edit an earlier commit in such a way
>that I need to re-run the code generation script.
>
>The challenge is that any commit in such a "stack" of commits might need me to re-
>run the code generation script. But I clearly don't want to do this manually!
>
>What I'm looking for is a way to automatically re-run this code generation script
>when I commit changes, or perform a rebase-edit step etc.
>
>I've tried to experiment with how I might do this using git commit hooks. But so far,
>my git foo is failing me. It mainly fails because when doing an edit of an earlier
>commit via an interactive rebase, later changes might well conflict (in the generated
>file) with the results of the code generator having been re-run on the edited commit.
>At this point, my git rebase --continue stops until I have fixed the conflict. But in
>almost all situations, the conflict comes in the generated hash file. Which I fix by
>simply re-running the code generation script (I could optionally fix it by doing a git
>checkout --theirs, and then re-running the code generation script).
>
>This all feels tantalisingly close to being a perfect workflow! But I can't quite figure
>out how to make the git hooks "work" in such a way that doesn't require any
>intervention from me (except in those situations where there is a conflict during the
>rebase that is _not_ in the code generated file and so does require my intervention).
>
>The code generation step is incredibly fast if there is nothing to do, and is quite fast
>even when there is something to do (in any case it can't avoid doing this work).
>
>Please can someone help nudge me in the right direction?

I wonder whether setting up a clean/smudge filter might help. You might want to look into a clean filter that runs your code generator.

--Randall

