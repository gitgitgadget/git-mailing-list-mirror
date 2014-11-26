From: Stefan Beller <sbeller@google.com>
Subject: Re: RCS Keywords in Git done right
Date: Wed, 26 Nov 2014 10:10:16 -0800
Message-ID: <CAGZ79kZz4_q+p91e7fn8uS--DRqEUPj_eeQPf2WPOWEk=R8fkw@mail.gmail.com>
References: <CAMsgyKbTRY5=cHj8Ar8zHDd5WdbcNwZC5caGV-snvZU4aek=YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Derek Moore <derek.p.moore@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:10:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xth2m-0003Sy-TB
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 19:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbaKZSKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 13:10:19 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:61293 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbaKZSKR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 13:10:17 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so3028965igb.17
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 10:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ID1Tv2p44CEgLZrRHgN5UlNDby1h+JQt0ZXT+PV54cs=;
        b=GbSDPjVeLC6wEsC/2a9YE+mXQ39t/X8zXJ8fqGZ32sEV4l6WgvAFGKPf2GuhJPxY+i
         eAPRTV/Lyx9uuHZ55PToiwTedF1bpARicUi72AFW7xoefLKckaOnpGR41E0gGw2+7GAV
         uBgqAC1yJ5zSe+scNEBAh/Tol7BUVft3TtmdcsbAMHSOsU3YDLoiSI0l7SXFZsMGCzOA
         IG53jnjaqfM88r49wksoVzdPfdIB1f0qZuAA+5LnRHPOm0+b5tTTGYOI68jL24FTibiJ
         T1WtEQ9+8yrURp3pjhLxCUWKP7RxDnXyqmvYYLDNGmwVUrZdwSXZ8ouaaQ9KLVqhcwg0
         8tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ID1Tv2p44CEgLZrRHgN5UlNDby1h+JQt0ZXT+PV54cs=;
        b=JASR9y1EA6hi68B/s8Y68vlmPViWVjsCOFNMH9/F2fbVEBd6I+D5eAlL9HHbPJAc28
         gaRYsPqAVYt+/L6eLS5dQAehXd6uSvNdswMjZ/mzru38hNBYfo3WK+4a/nvipHSiBomy
         ZQvpDeR9/Y9PYg9B+s1UnCIdkzD6wqFmPkQO1TSfskvqhj/5nj0hUAmNlGI9bferV2rR
         W4pXbPHBbkD4Jq1OcK4uWYtrAxR2oXiaTcUtBYWUbkzgCfMboMQdnzNdUvHPDhI1dxu4
         2zwz5Lpr2cREwmaTC7oI+ZKgqOTQXnrgbPETtdRMfRLQrxk9lrucIYKXVXgy3HPk5Rxs
         6Y7w==
X-Gm-Message-State: ALoCoQmrpgm1yqYHclF4yzrK/i+hC99NBXFQvjFILAY/Aebi6zUQe/VOSMuIrDma/zj2/zrGmvzh
X-Received: by 10.50.82.102 with SMTP id h6mr24469532igy.25.1417025416399;
 Wed, 26 Nov 2014 10:10:16 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Wed, 26 Nov 2014 10:10:16 -0800 (PST)
In-Reply-To: <CAMsgyKbTRY5=cHj8Ar8zHDd5WdbcNwZC5caGV-snvZU4aek=YQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260287>

On Wed, Nov 26, 2014 at 8:44 AM, Derek Moore <derek.p.moore@gmail.com> wrote:
> Junio, et al.,
>
> I've completed my first pass at RCS Keywords in Git. I believe I've
> come up with a solution that is accurate, performant and complete (but
> I have not tested it on big repos yet, I'm doing that today...).
>
> https://github.com/derekm/git-keywords
>
> This work basically takes advantage of all the state-machine
> transitions in git to surgically perform "git update-index $(git
> archive $(git log -1 --format=%H @ -- $path) -- $path | tar vx)"
> overwrites in the work tree. (It also exposes some state transitions
> that are entirely absent from git, creating a few edge cases, but they
> are relatively unimportant edge cases if your deployed git repos will
> be managed by an automated system [humans doing development workflows
> can trigger the edge cases when cancelling certain operations, all
> edge cases just leave you with un-substituted files, which will become
> substituted again after checkouts, commits, merges, rewrites, etc.].)

Now knowing the edge cases won't work, I did not get an idea about the
standard case of what should work with this. Would you mind to write
a more detailed example or a more advertising paragraph of what this can do?
Not getting the big picture may be related to me having not worked with RCS yet.

Thanks,
Stefan

> Only $Author$, $Date$ and $Revision$ can be emulated presently. $Id$
> and other tags requiring filename paths or basenames are possible, but
> would require changes internal to git allowing "pretty format" codes
> inside a file to triangulate filenames from blob hash and commit hash
> pairs.
>
> I believe this work fundamentally proves that the theory of RCS
> keywords is sound in the context of Git, and that full support in
> git-core is entirely achievable in short order. In fact, other areas
> in git would become improved for several reasons if git devs ingested
> some of the results of this work.
>
> There is a lot of gainsaying and kneejerk reaction to the idea of
> keywords under the assumption of distributed development because of
> the fallacy of thinking in terms of shared/universal linear history
> instead of in terms of relative spacetime events.
>
> Keyword substitution can be done accurately relative to the history of
> the possessor of that history. Last edit timestamps and last authors
> and revision IDs are important to many workflows inside and outside
> development.
>
> Of the keywords emulated, the only thing I couldn't achieve
> (obviously) were monotonically increasing revision numbers, instead I
> went with the file's most recent commit short hash (which is more
> proper for git anyway).
>
> To test it out...
>
> 1) clone the repo:
>
> git clone https://github.com/derekm/git-keywords
>
> 2) cd into the repo and setup the hooks:
>
> ln -sf ../../post-checkout-filter.pl .git/hooks/post-checkout
> ln -sf ../../pre-commit-check.pl .git/hooks/pre-commit
> ln -sf ../../post-commit-filter.pl .git/hooks/post-commit
> ln -sf ../../post-merge-filter.pl .git/hooks/post-merge
> ln -sf ../../post-rewrite-filter.pl .git/hooks/post-rewrite
>
> 3) edit .git/config and setup the filters:
>
> [filter "keywords"]
>         smudge = ./keyword-smudge.pl %f
>         clean = ./keyword-clean.pl
>
> 4) inspect the lack of substitutions:
>
> head -4 *
>
> 5) initialize the repo with first substitutions:
>
> for i in $(git ls-tree --name-only @); do
>  git update-index \
>   $(git archive \
>    $(git log -1 --format=%H @ -- $i) -- $i | tar vx)
> done
>
> 6) inspect the presence of substitutions:
>
> head -4 *
>
> 7) ??? (start hacking, try to break it, etc.)
>
> 8) PROFIT!
>
> PS: I may consider rewriting the hooks in Bash, but I need to audit
> what commands are available under msys-git.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
