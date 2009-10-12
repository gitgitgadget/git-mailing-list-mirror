From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Merge (or maybe rebase) question
Date: Mon, 12 Oct 2009 20:13:12 +0200
Message-ID: <81b0412b0910121113l7d084618o6d34fb4a0389421c@mail.gmail.com>
References: <26ae428a0910120455k7ab5aa5ag8d701050e7acec5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Mon Oct 12 20:16:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPR6-0007Z0-RL
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbZJLSNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 14:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756452AbZJLSNv
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:13:51 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:59871 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756062AbZJLSNu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 14:13:50 -0400
Received: by bwz6 with SMTP id 6so3315543bwz.37
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=QtvAEscj9FqsDNXimYLBIlQJoiMCPNfm5SyTxQqvr5I=;
        b=THstHUdvSDGxIin9+HKI3wzTDdcSE9ZSoWDjb1ogtFTbHFhqNvyvoodm5L/AumYpUE
         97TR+yAJSmr+oOoslXijkTce2MONb3rzYhDxmNGG/rPYNx1di2/UWqPa+qSZhU32EOeh
         jIMate1hdYKyWwhCfhwKIQ9gwtOc1gLzh3AYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TO89e/Q4t5UclZPwXjs/wcCaf6n/oDzoWuqx1gUoC3mAfjni7C13OnnkTbRGs7jkTR
         /4wB11SdItfdY7JF++xVGKimXTB91hd5TG2LtAsx/xiyu2f7Z21go82/xz/IR9ZJ0HdQ
         fhrxJcWixWXOnoObE9IWSAml2MFVW4cQ/P3MA=
Received: by 10.204.153.220 with SMTP id l28mr5364184bkw.86.1255371192770; 
	Mon, 12 Oct 2009 11:13:12 -0700 (PDT)
In-Reply-To: <26ae428a0910120455k7ab5aa5ag8d701050e7acec5f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130040>

On Mon, Oct 12, 2009 at 13:55, Howard Miller <howard@e-learndesign.co.uk> wrote:
> Another how best to do this.
>
> - I have my project all nicely in git with all the different releases
> and versions in there going back years. Happy :-)
>
> - I have a customer who has heaviliy modified an oldish version of the
> software.
>
> - I have identified the version that they modified and created a
> branch in my git repo based on that version (i.e. what they would have
> started with before modifying it)

That's the branch where you should apply their changes. Let name it "theirs".
And I assume your normal branch is called master.

> - Their changes where applied to a simple download - no version
> control, no nothing.
>
> I now need to update them to the latest version of the software - can
> git help me here or is it all a disaster?

You can have it with both merge and rebase.
Merge:

   $ git checkout master
   $ git merge theirs

Now your master contains a tree where their and your changes
are mixed. Exactly how they are mixed (IOW, how you resolved
conflicts, what exactly have you taken from their tree, etc) is
recorded in the merge commit. You can't export this information out
of Git repo (so it is readily and simply usable without Git, that is).
That's usually not a problem.

Rebase:

   $ git checkout theirs^0
   $ git rebase master

The rebase can cause conflicts.

   $ git branch new-theirs
   $ git checkout new-theirs

Now you are on a branch which contains their changes on top of your
current development branch. The software as "they" had it is in "theirs".
You can export their changes to your *current* tree to anyone as patches.
No one can tell anything about where the changes were created in the
first place (the "base"), though. That's the major downside of the approach.

> PS. To make matters worse - their original is full of expanced CVS
> $Id:$ tags so it will look to git like every single file has changed.

You can filter them out using you favorite editor or scripting language
and commit the filtered tree. Gits merge considers only the final
states of the branches it merges.
