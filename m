From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Wed, 23 May 2012 08:37:42 -0700
Message-ID: <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com>
References: <4FBAA33D.1080703@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed May 23 17:38:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXDdS-00083B-Di
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 17:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312Ab2EWPhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 11:37:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34157 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965301Ab2EWPho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 11:37:44 -0400
Received: by pbbrp8 with SMTP id rp8so10040822pbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KEozifdEEpFJhj6qpuMckfKzD5qSM4e2eUaPn3cjOdM=;
        b=TtYWShExeuu2P3MXoXq7TQ8AtpAnQJudyvFuwt+IyMr9k8pb8SWHdy5RqRTEWY7ifH
         C5LyyVW8rj7/hK/l6JS8SZf+0st1nwUou6b5W83djl1pKBmWvHlwTaSmz+oahTyGk74q
         amYvHZmYfloK4vXOfYAsPM+EMZ8P/5EBTty3qMAhqPXFdH7Y/wVNpWfVkk4qKYH31vYH
         cCbAJYFJoSsrg78G3/stwnuRLZyM091fm8waw9jKBwCDJZwdKfIrv/Tf0RYn2Mi0Jg2l
         ImeQn/63OkNBfiW0NcnN/soBeJCkAAj4AkOOadk83sjtOQpGm1MmNZpRgXmu9JdrnSAQ
         hIgA==
Received: by 10.68.132.101 with SMTP id ot5mr11700815pbb.91.1337787463866;
 Wed, 23 May 2012 08:37:43 -0700 (PDT)
Received: by 10.68.51.130 with HTTP; Wed, 23 May 2012 08:37:42 -0700 (PDT)
In-Reply-To: <4FBAA33D.1080703@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198297>

On Mon, May 21, 2012 at 1:19 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Replace the 'git merge' by a cherry-pick that picks the changes that the
> merge introduces with respect to the first parent.

Just a reminder of what I said in [1] (the same thread that you referenced):

I think this will break "git rebase -p --onto g b f" on  the below history.

          .-e-.
         /     \
      .-c---d---f
     /
a---b---g

Even if this wasn't the intended use case, git currently supports it
and I would personally be a little surprised if no one has gotten used
to it working. So should we at least check for this case and handle it
with "git merge" as usual? Or stop supporting it and error out instead
(and mention in release notes?)?

Btw, with a history without "internal" merges, but where the merge
commit was generated "backwards" so the first parent is not in the
to-be-rebased history, am I correct in thinking that the "git
cherry-pick -m 1" will fail? Do you think we should consider this case
or do we consider that too broken to care about?


Martin

 [1] http://thread.gmane.org/gmane.comp.version-control.git/194434/focus=194786
