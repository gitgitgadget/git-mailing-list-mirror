From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 0/7] rebase.autostash completed
Date: Mon, 13 May 2013 13:29:29 +0530
Message-ID: <CALkWK0mWRC9_QVYAu9Q4iAoVTpfkf9xkc9apjrdv6SyEiCq+hA@mail.gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com> <7vy5bjqxxa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 10:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbngA-00079n-4u
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab3EMIAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:00:11 -0400
Received: from mail-bk0-f53.google.com ([209.85.214.53]:46831 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232Ab3EMIAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 04:00:10 -0400
Received: by mail-bk0-f53.google.com with SMTP id mx1so61977bkb.26
        for <git@vger.kernel.org>; Mon, 13 May 2013 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dxjrAO/TrqKsZo7eD/ofwn1mTF4ElotbHlbwkvcSGsE=;
        b=vQN/MlUbwYpO14sAepAYUM9BzQanrNkO9SvJGYfzq+7ERd5vIzdvhK7ZgDuw7z22wp
         fr4lvO4DW+a4301uXjh3e3hr6il0sVkRbAMapPfne+EYffNPQ5txpuSYmwVw48yPauSQ
         9pbH2CHMhXv7UEB3NR6S7WjCYT1oWy+xMYPuHV4oc5pt+0g+OIEzRVu+LvZ7E35Y6OIa
         nwsC/U7/ljLHJrGJm8F2LKlKE9x9SxwcjSDpycJm1m5gUmJfGvf2alujqdf4roW/mobG
         aFrlugLdGppLnQcrTZADZWyxeEtNnBTopfm5EtFC+8UtMm4CFmbULo2GOurFGDBVjxHT
         2ZEw==
X-Received: by 10.205.104.138 with SMTP id dm10mr5345423bkc.51.1368432009535;
 Mon, 13 May 2013 01:00:09 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Mon, 13 May 2013 00:59:29 -0700 (PDT)
In-Reply-To: <7vy5bjqxxa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224105>

Junio C Hamano wrote:
> Especially I did not check if there are
> still undesirable data loss behaviour in corner cases that people
> were worried about in the discussion.

Check the tests.  What am I missing?

>    In the longer term, it is unmaintainable to make such users (like
>    this new code) of the stash mechanism manually do so, and we may
>    want to add a "git stash __store" subcommand, not meant for the
>    interactive use of end users.  The implementation of the stash
>    can later be changed without affecting such users by doing so.

Yes, a "store" that stores a commit created with "create" would be
nice.  Why the horrible double-underscore though?  "git stash create"
is not meant for interactive use of end users either.

>    Perhaps "rebase" can be taught to be more careful when checking
>    if local changes may overlap with the changes being replayed.

Frankly, I don't know if it's worth the effort.  It might be a nice
theoretical exercise, but what tangible benefit do I get as the end
user (now that I have rebase.autostash)?  In fact, I'll probably be
slowing down the interactive rebase noticeably by executing a
diff-tree at every step.  And for what?

> Those who still want to use stash would benefit from having an
> autostash, but at that point, there is no reason to single out
> "rebase" for the autostash feature.  Those who want to stash
> immediately before a "merge" that is known to conflict can use the
> same autostash and may want to do so for exactly the same reason
> they may want to use it for "rebase".

Each command that wants to have autostash will have to implement it
independently.  You argued that an implicit merge.autostash may be
harmful earlier: maybe an explicit --autostash; but at this point, the
returns are diminishing: what is the great advantage of --autostash
over a quick manual g ss, g sp (git stash save, git stash pop)?  I
don't know what problem you're trying to solve anymore.
