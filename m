From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 23/32] prune: strategies for linked checkouts
Date: Sun, 21 Sep 2014 09:54:20 +0700
Message-ID: <CACsJy8BLEfB6RQZTxqF82-tJmKQgnNC12QvKu8KZq=Vr059s3g@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com> <1410388928-32265-24-git-send-email-pclouds@gmail.com>
 <5411C16C.9010406@xiplink.com> <CAPig+cQGeEzrx9N1Rrxhf--gphWSam88BV06AJTA=6-YZvQ4Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 04:55:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVXIm-000695-Ra
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 04:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbaIUCyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 22:54:51 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35915 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbaIUCyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 22:54:51 -0400
Received: by mail-ig0-f172.google.com with SMTP id a13so1058854igq.5
        for <git@vger.kernel.org>; Sat, 20 Sep 2014 19:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AFfxr2MThqys0LZZWzbN2nH2cpg2vEO4fZxGGjBRj70=;
        b=q1X0lvGviOXZuqoDIncN8Z+6q2Eh0W1OWaCt2XNFA3JvklUR+3VV+fZZSg6Bwgzplg
         z/unYrlzphU6d4vgBEJqdq/QdULrhiPYvRTsURtw9ameQA2Kwy2YmOrZGJptkvZS4Tk5
         Zm80jFkLwXyxCyjxyb3f8skPNIWs55wvhfbZ4NUjXy4yaNB6YO+UcCHI1U8S81izVAIt
         UCE7QEIHB9/qLAjLzZOHxyisIxNWPKI9/jesnUWcDMgIMgxnJJGZUUzE8M8SM/G99nsZ
         wKNmM+y6Q52d5kHVNs652J+pWUoIICpOgCWPBei1XRqlbgC6xQJL4Yb6yveN0QNvSdNl
         cMSg==
X-Received: by 10.42.61.146 with SMTP id u18mr9062478ich.1.1411268090341; Sat,
 20 Sep 2014 19:54:50 -0700 (PDT)
Received: by 10.107.131.150 with HTTP; Sat, 20 Sep 2014 19:54:20 -0700 (PDT)
In-Reply-To: <CAPig+cQGeEzrx9N1Rrxhf--gphWSam88BV06AJTA=6-YZvQ4Tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257335>

On Fri, Sep 12, 2014 at 10:06 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> One minor addition for clarification would be to mention that the 'git
> prune --worktrees' invocation applies to the main worktree:
>
>     When you are done with a linked working tree, you can simply delete
>     it. You can clean up any stale $GIT_DIR/worktrees entries via
>     `git prune --worktrees` in the main worktree.


The command should work from any worktree (of course not the worktree
that you just deleted). I try to make all operations work on all
worktrees. How should I write this?

>>> +To stop `git prune --worktrees` from deleting a specific working
>>> +directory (e.g. because it's on a portable device), you could add the
>>> +file 'locked' to $GIT_DIR/worktrees. For example, if `.git` file of
>>> +the new working directory points to `/path/main/worktrees/test-next`,
>>> +the full path of the 'locked' file would be
>>> +`/path/main/worktrees/test-next/locked`. See
>>> +linkgit:gitrepository-layout[5] for details.
>>
>> Sorry, I can't help rewriting this one too:
>>
>>         To prevent `git prune --worktrees` from deleting a
>>         $GIT_DIR/worktrees entry (which can be useful in some situations,
>>         such as when the entry's working tree is stored on a portable
>>         device), add a file named 'locked' to the entry's directory.  For
>>         example, if a linked working tree's `.git` file points to
>>         `/path/main/.git/worktrees/test-next` then a file named
>>         `/path/main/.git/worktrees/test-next/locked` will prevent the
>>         `test-next` entry from being pruned.  See
>>         linkgit:gitrepository-layout[5] for details.
>
> Each time I read this (or Duy's original), the first question that
> pops into my head is "should 'locked' be empty or have content, and if
> content, what content?" gitrepository-layout.txt does explain the
> content (if the reader bothers to chase the link), but perhaps it is
> worth an explanatory sentence here?

Will do.
-- 
Duy
