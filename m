Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E208FC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 20:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C600561206
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 20:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhJRUK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:10:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61112 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRUK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 16:10:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2429F1BDC;
        Mon, 18 Oct 2021 16:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=phKE71qB5YtgCm48CZ6ZDVjepu0JislgV0N9tj
        5EwZ8=; b=ZxWXL93oVUtyJ9Zwi6f37Yvf/z2UXBef8pukRZ7woevYWiXvXzJbm5
        j97+GuZx0uDzYKWP/gvWpPVqthrTnOP7aKJQqOnEdOFgtpookRpsMrnW/vrAu0hB
        omOrLtO7S/MX1bYfw+j8JSt0756U5GYYd6G+AGZL7mZa+SHEaqsJs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA980F1BDB;
        Mon, 18 Oct 2021 16:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58792F1BD8;
        Mon, 18 Oct 2021 16:08:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re* [PATCH v3] Documentation: specify base point when generating
 MyFirstContribution patchset
References: <20211018124106.542050-1-bagasdotme@gmail.com>
        <xmqqzgr6w97p.fsf@gitster.g>
        <kl6lzgr6z1a1.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 18 Oct 2021 13:08:44 -0700
In-Reply-To: <kl6lzgr6z1a1.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 18 Oct 2021 10:32:54 -0700")
Message-ID: <xmqqwnmaumcz.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32C2116E-304F-11EC-8766-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> But that does not mean master would always be the right base, does
>> it?  What if you had a work totally unrelated to the contents of
>> this tutorial on the 'master' front?  The person on the receiving
>> end may not even know what object it refers to until you pushed your
>> 'master' branch out.
>
> This is the crux of the problem, which is that the contributor's base is
> actually their private 'master' branch, but their patches go to the
> upstream 'master' branch. Does it even matter that the patches were
> originally authored on a private 'master'?

No, and that is why I suggested to update the example to take
advantage of the fact that we forked out of origin/master, not
private master, in my review of the second round.

And telling what the value of origin/master is, or letting
--base=auto to compute the merge base between origin/master and the
branch you are sending out (as origin/master may have advanced since
you forked), which is even better, helps the recipient quite a lot.

Being on the receiving end all the time, I should know ;-).

> As you mentioned in the v2 thread:
>
>   Actually it is up to contributors whether they want to include `--base` 
>   or not.
>
> This is a level of discretion that we shouldn't be leaving to first
> timers (as a very recent first timer, I would not appreciate this
> ambiguity).

Exactly.  The document is about contributing to _this_ project, and
we can and should be more explicit to say what we prefer to see.

Going back and forth is often a good way to figure out what kinks to
iron out and make progress, and in this particular case, it seems it
have already consumed enough bandwidth to make as much progress as we
can make in this approach, so let's start concluding by suggesting a
much simpler rewrite.

How about doing the following and call it done?

----- >8 --------- >8 --------- >8 --------- >8 ----
Subject: [PATCH] MyFirstContribution: teach to use "format-patch --base=auto"

Let's encourage first-time contributors to tell us what commit they
based their work with the format-patch invocation.  As the example
already forks from origin/master and by branch.autosetupmerge by
default records the upstream when the psuh branch was created, we
can use --base=auto for this.  Also, mention the readers that the
range of commits can simply be given with `@{u}` if they are on the
`psuh` branch already.

As we are getting one more option on the command line, and spending
one paragraph each to explain them, let's reformat that part of the
description as a bulletted list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Fell out as an alternative approach during a review by Bagas
   Sanjaya https://lore.kernel.org/git/xmqqo87q6whk.fsf@gitster.g/

 Documentation/MyFirstContribution.txt | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git c/Documentation/MyFirstContribution.txt w/Documentation/MyFirstContribution.txt
index b20bc8e914..e505a7ec87 100644
--- c/Documentation/MyFirstContribution.txt
+++ w/Documentation/MyFirstContribution.txt
@@ -905,19 +905,31 @@ Sending emails with Git is a two-part process; before you can prepare the emails
 themselves, you'll need to prepare the patches. Luckily, this is pretty simple:
 
 ----
-$ git format-patch --cover-letter -o psuh/ master..psuh
+$ git format-patch --cover-letter -o psuh/ --base=auto psuh@{u}..psuh
 ----
 
-The `--cover-letter` parameter tells `format-patch` to create a cover letter
-template for you. You will need to fill in the template before you're ready
-to send - but for now, the template will be next to your other patches.
+ . The `--cover-letter` option tells `format-patch` to create a
+   cover letter template for you. You will need to fill in the
+   template before you're ready to send - but for now, the template
+   will be next to your other patches.
 
-The `-o psuh/` parameter tells `format-patch` to place the patch files into a
-directory. This is useful because `git send-email` can take a directory and
-send out all the patches from there.
+ . The `-o psuh/` option tells `format-patch` to place the patch
+   files into a directory. This is useful because `git send-email`
+   can take a directory and send out all the patches from there.
 
-`master..psuh` tells `format-patch` to generate patches for the difference
-between `master` and `psuh`. It will make one patch file per commit. After you
+ . The `--base=auto` option tells the command to record the "base
+   commit", on which the recipient is expected to apply the patch
+   series.
+
+ . The `psuh@{u}..psuh` option tells `format-patch` to generate
+   patches for the commits you created on the `psuh` branch since it
+   forked from its upstream (which is `origin/master` if you
+   followed the example in the "Set up your workspace" section).  If
+   you are already on the `psuh` branch, you can just say `@{u}`,
+   which means "commits on the current branch since it forked from
+   its upstream", which is the same thing.
+
+The command will make one patch file per commit. After you
 run, you can go have a look at each of the patches with your favorite text
 editor and make sure everything looks alright; however, it's not recommended to
 make code fixups via the patch file. It's a better idea to make the change the
