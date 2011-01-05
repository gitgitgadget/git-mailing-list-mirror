From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: False positives in git diff-index
Date: Wed, 5 Jan 2011 07:46:19 +0000
Message-ID: <AANLkTimFbodDe=DMj5kkR749sG8bDTxyjDCtOEvmDkRd@mail.gmail.com>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
 <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
 <20110105054825.GC5884@sigill.intra.peff.net> <AANLkTimQCMr+emw=rXdBKKnD_W9G981zCkboKgiDWxPF@mail.gmail.com>
 <20110105061515.GA12163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 05 08:46:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaO4z-0008Ox-Pf
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 08:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab1AEHql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 02:46:41 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48485 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab1AEHqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 02:46:40 -0500
Received: by qyj19 with SMTP id 19so17896605qyj.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 23:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=TFXqHN2xqs83jxqDgkMMY1mJehMSXCuSwzkggWpvR3w=;
        b=SWCAce6ICK72oPqCgPStQtl0rvrwjh5KJ9pOQGpamCN94zQ3Gk4QvGE9+kFohvLoEg
         3JiQ2Um5eaLqYlfY8iTqIWOBnuhbw5sQV9QAC2/JVaJOH2Rngh7yGY7N3Bv7SgWGymNu
         7hpsJluFiEb8TfQn3muBNxzwyy9fIOpj9jsP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tHW1wZhdKPluifuijWQFOZOvzUKkyAumQUw7Amqi0X0cn+PIJMQdlpgX6Xh5dTcnCZ
         xBqbhr5p8QDBcAkzHL5GLg951CQnEsz/yhz2XUJTHK2rr5tAuKEyeu5VjkmpL7Sxpuxk
         RBIaC0kEZ0HtvtEivBmONL6FiLkSyNgY+wmak=
Received: by 10.229.110.8 with SMTP id l8mr19918883qcp.205.1294213599825; Tue,
 04 Jan 2011 23:46:39 -0800 (PST)
Received: by 10.229.48.5 with HTTP; Tue, 4 Jan 2011 23:46:19 -0800 (PST)
In-Reply-To: <20110105061515.GA12163@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164555>

On Wed, Jan 5, 2011 at 06:15, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 05, 2011 at 06:07:35AM +0000, Alexander Gladysh wrote:

>> > But using that script, I can't replicate your problem. Can you try
>> > running it on the same box you're having trouble with? That might at
>> > least tell us if it's your environment or something more complex going
>> > on.

>> Thank you. I tried it, and, unfortunately, it does not reproduce the
>> problem.

> Oh well, thanks for trying.

> Going back to your original reproduction recipe, can you change the
> "diff-index" line to actually report on what it thinks is different?
> That is, drop the "--quiet" and have it actually produce a patch?

----> Rebuilding manifest...
Making manifest for .
Generating index.html for .
:100644 100644 483a7292436daecc9bea0ab265ee19d587b14298
0000000000000000000000000000000000000000
M	cluster/localhost-ag/rocks/index.html
:100644 100644 fcb9ff896fd1a1bd15663fa9be19b250789d4a25
0000000000000000000000000000000000000000
M	cluster/localhost-ag/rocks/manifest

These are the two files, which are overridden with identical content.
(See below, looks like I realized who to blame.)

If I read this correctly, Git tells me that the files are deleted. No?

Anyway, I checked, looks like that files are overridden (by
fopen("name", "w")), never explicitly deleted. If it is important, I
will checkout strace.

Contunuing with the script:

----> Comitting changed manifest...
2edcbfabc11f9bbab4fc8c059490cba9ae196d27
# On branch ag/git-debugging
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	typechange: cluster/localhost-ag/versions/versions-current.lua
#
no changes added to commit (use "git add" and/or "git commit -a")

Suddenly: no changes.

> It would be interesting to see what is different, and how that compares
> with the "git status" you run just prior to it (and whether it matches
> the file you "git add"ed just above).

Git status before:

$ git status
# On branch ag/git-debugging
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	typechange: cluster/localhost-ag/versions/versions-current.lua
#
no changes added to commit (use "git add" and/or "git commit -a")

> You haven't told us much about your build process. Are you absolutely
> sure that there couldn't be another process on the system manipulating
> the files between the various runs?

No other process. But see below.

> Are you running on top of any special filesystem that might not meet the
> consistency guarantees we expect (though in that case, I would assume my
> trivial script would have reproduced).

And here I have to say "Oops".

My apologies, I should have realized this before: my project is
mounted on VMWare's HGFS.

(That is: VMWare Fusion Ubuntu Guest -> HGFS -> OS X 10.6 Host files.)

The problem is not reproduced if I copy the project to the native fs
in the guest machine.

But the problem is also not reproduced if I execute your script on the HGFS.

So, does that mean that HGFS violates consistency guarantees?

Alexander.
