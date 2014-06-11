From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Confusing error message in rebase when commit becomes empty
Date: Wed, 11 Jun 2014 11:44:17 -0400
Message-ID: <CABURp0rC3yktDiRVQwo9E+x5_wKLnLVRx87ej+m+TyUdBkMpOA@mail.gmail.com>
References: <alpine.DEB.2.00.1406111321090.6307@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Jun 11 17:44:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wukhf-00051V-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 17:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbaFKPok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 11:44:40 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:61221 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816AbaFKPoi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 11:44:38 -0400
Received: by mail-ve0-f178.google.com with SMTP id jx11so442366veb.23
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ArJ5RK2ZbAxR+nMtQB9xpwo1KP2y5GpdPsZ1WZq7vxk=;
        b=dj3uxpy390E0LUPTEH79CICjWxItxdWOKB9Fqzc+huyzZSWvhMh/aduKXVAf/hkTY8
         e+BmAPH0St1oKWWrg/EjnDA6Lw1VOwAbp0LFrZ0rcbqa2zFr20aZ6wUqzJ/lNOx67zOC
         3aJYHSenzp039QOY+IZ8cvqNb6IlMe5dHss/FtLpwpM28+VIvy8jmAtiOzzWmXfX3NwX
         FfYLj3GQvrKQF3VisvIu6MT91U4EqFTAOkFb99zgaaAC2O/WqyoE28uCMcq7tt1uFkOt
         zYbNDpICFX0E43PGge3GTQ+nbSh1VrwAB5l9r26XwL7Bp9LtnR/Kgusa+ToRSNzPCaS0
         yGwQ==
X-Received: by 10.58.132.41 with SMTP id or9mr39875770veb.5.1402501477403;
 Wed, 11 Jun 2014 08:44:37 -0700 (PDT)
Received: by 10.58.67.168 with HTTP; Wed, 11 Jun 2014 08:44:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1406111321090.6307@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251372>

On Wed, Jun 11, 2014 at 8:49 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> I am rebasing a branch to combine a couple of commits. One is a revert of a previous commit. Since there are commits in-between, I do "squash" to make sure I get everything, and then add the actual change on top of that. The problem is that rebase stops with a confusing error message (from commit, presumably):
>
>   $ git rebase --interactive
>   [...]
>   You asked to amend the most recent commit, but doing so would make
>   it empty. You can repeat your command with --allow-empty, or you can
>   remove the commit entirely with "git reset HEAD^".
>   rebase in progress; onto 342b22f
>   You are currently rebasing branch 'mybranch' on '342b22f'.
>
>   No changes
>
>   Could not apply 4682a1f20f6ac29546536921bc6ea0386441e23e... Revert "something"
>
> OK, so I should retry the command with --allow-empty, then:
>
>   $ git rebase --interactive --allow-empty
>   error: unknown option `allow-empty'
>
> Nope, that's not quite right.


The correct switch for rebase is --keep-empty, but it is too late to
choose it once the interactive rebase is underway.  I think the
correct advice might be something like this:

  You asked to squash this commit and its parent, but doing so would make
  it empty. You can drop this empty commit with "git reset HEAD^" , or you can
  keep it with "git commit --amend --allow-empty".

But I have not tested this.


> Running "git rebase --continue" does work as expected, but perhaps it just shouldn't stop in this case?


What does it mean when you say it worked as expected?  Did it leave
the empty commit, omit the empty commit, or leave some un-squashed
commit?  It's not clear to me what --continue _should_ do in this
case, but it does seem like the two options here should be

 1. keep the empty commit
 2. drop the empty commit

I would expect "git rebase --skip" to drop the empty commit, but maybe
it will "skip" the squash instead.  I don't know.  Better advice here
is certainly needed.
