From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: file disappears after git rebase (missing one commit)
Date: Sat, 18 Aug 2007 22:29:52 +0200
Message-ID: <e7bda7770708181329i7a64e613y88187a608c323a07@mail.gmail.com>
References: <e7bda7770708181237u34253bf1h7c3fe0987d13d3b3@mail.gmail.com>
	 <alpine.LFD.0.999.0708181247330.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 22:30:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMUw5-0006Nj-Jb
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 22:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbXHRU3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXHRU3x
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 16:29:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:10259 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXHRU3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 16:29:53 -0400
Received: by wa-out-1112.google.com with SMTP id j4so302094wah
        for <git@vger.kernel.org>; Sat, 18 Aug 2007 13:29:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EP1ItkSvLQkCXBKEUyPTYLdlUimtBDEqv1Fx+8JSBE3tZIO1VMmk5AE5oRLNPkpvWLrtqiYpbjBGvJYK5sRJM51iEeWAvsvESumeUZC5oUIw5gMl/IDWfsNoSUr90yngbD+0OMCsUcbZVwqrlssOGctTVVc3W3CBq5dtzgGhlBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s2ELUbw+NvjYCV+gZT2fxCEihR1ZEqp/dKq92lY9nKTaLrxh13e/FJpG1zfyx3+RC26o4PYaaGfjJdfvapEsof6w7jE+E/+NWG4ATI+CZbsFE0JXPYfij+YzLIWLDzmFuz2cIXvm9DiasBfaXCh6+Idt9ZpeLIMmVsE8mOW2AoU=
Received: by 10.115.54.1 with SMTP id g1mr1910535wak.1187468992688;
        Sat, 18 Aug 2007 13:29:52 -0700 (PDT)
Received: by 10.114.180.20 with HTTP; Sat, 18 Aug 2007 13:29:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708181247330.30176@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56111>

On 8/18/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> The reason, I think, is that I suspect that the newly added file is a
> binary file, no?

Yes, that's correct.


> That, in turn, will mean that the *patch* will have no
> patch ID (or rather, it will have an empty patch ID) - which in turn will
> make it invisible to "--ignore-if-in-upstream" if there are already some
> *other* patches that also just adds a binary file (which I think there is:
> I think upstream has "Add disk summarize tool (du.exe)" which I assume has
> exactly the same patch fingerprint).

The "du.exe" is only in the devel branch but there is five other
patches that meets your criteria.


> In other words, "git rebase" really is just a series of cherry-picks, but
> it avoids patches that have the same patch ID as something that is already
> upstream. That helps *enormously*, but it so happens that the patch ID's
> don't work really well for binary diffs.

Git cherry-pick seems to work on that particular patch:

$ git cherry-pick b11cf4ce6262a7c3b243e3cfdc70e6b44682cb59
Finished one cherry-pick.
Created commit 92a58d3: Added msmtp.exe SMTP client
 1 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 bin/msmtp.exe


> Try this patch - see if it helps. Totally untested! It will enable patch
> ID's on binary diffs too, which should avoid this issue.

That didn't help. Same symptom.

//Torgil
