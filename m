From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Pull From Mirrored Repository
Date: Mon, 19 Sep 2011 01:15:47 +1000
Message-ID: <CAH5451m1WJ0H9G8uHbCqZ5acO-xEynGKjMk=6g75buJy1S7iSw@mail.gmail.com>
References: <20110918144514.GL15295@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jean Sacren <sakiwit@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 17:16:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5J6M-0006df-Mn
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 17:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab1IRPQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 11:16:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54165 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573Ab1IRPQI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 11:16:08 -0400
Received: by fxe4 with SMTP id 4so3147420fxe.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 08:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PF6Qu1/FjdytNXB7PUxYjpfhWCpNtIQciz8BiF3Y4Q0=;
        b=fCCpT3MZLhXqLX/gW4yXAsurWBhqnFcR6eyK+mVeDpdw7Xne+pX/mf1N0yeNLLeUCa
         9Wj3CszSg5W2CbZVInNz1Izdlq8BKD8GackHSMRabU/WBAmb/063xInqlUh3kR6ghVbb
         YgUJAlEQbVm0Du8lpac+HQItcjZTwG8LN4lEc=
Received: by 10.223.95.148 with SMTP id d20mr3292500fan.59.1316358967395; Sun,
 18 Sep 2011 08:16:07 -0700 (PDT)
Received: by 10.152.37.66 with HTTP; Sun, 18 Sep 2011 08:15:47 -0700 (PDT)
In-Reply-To: <20110918144514.GL15295@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181614>

On 19 September 2011 00:45, Jean Sacren <sakiwit@gmail.com> wrote:
> After pull from a mirrored repository, git status shows
>
> # On branch master
> # Your branch is ahead of 'origin/master' by [NUMBER] commits.
> #
> nothing to commit (working directory clean)
>
>
> How to bring 'origin/master' update without syncing with the original
> repository?
>

Am I correct in thinking that you have done the following:

$ git clone original-server/repo.git
$ cd repo
$ git pull mirror-server/repo.git
$ git status
# On branch master
# Your branch is ahead of 'origin/master' by [NUMBER] commits.
#
nothing to commit (working directory clean)

and now you want the remote ref 'origin/master' to point to the same
thing as 'mirror/master' (assuming that you create the ref for the
mirror)?

This can be done (by editing the file .git/refs/remotes/origin/master
and specifying the correct sha1) however this is probably not the best
idea. It is best for git to know the actual state of the remote the
last time you synced with it so that it can act intelligently the next
time you sync with it.

If you intend to sync with the mirror, you might as well set it as the
upstream ref of you master branch. That way you will not get the 'Your
branch is ahead' message when you pull new updates (unless you have
local changes, of course).
This can be done by:
$ git checkout master
$ git branch --set-upstream mirror

This assumes that you have already added mirror as a remote ref.

Regards,
Andrew
