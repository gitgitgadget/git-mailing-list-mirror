From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: `git stash pop` UX Problem
Date: Mon, 24 Feb 2014 17:21:40 +0100
Message-ID: <vpqlhx0a3cb.fsf@anie.imag.fr>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Omar Othman <omar.othman@booking.com>, git@vger.kernel.org
To: Brandon McCaig <bamccaig@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:22:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyIb-0004bE-Kr
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbaBXQWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:22:04 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55981 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbaBXQVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:47 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1OGLchi022136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Feb 2014 17:21:38 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1OGLeqb021482;
	Mon, 24 Feb 2014 17:21:40 +0100
In-Reply-To: <CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	(Brandon McCaig's message of "Mon, 24 Feb 2014 11:04:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 24 Feb 2014 17:21:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1OGLchi022136
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1393863699.35423@DdF9v5I2BW6B1jUAXp5Z3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242608>

Brandon McCaig <bamccaig@gmail.com> writes:

> Unlike a merge, when you pop a stash that history is lost. If you
> screw up the merge and the stash is dropped then there's generally no
> reliable way to get it back. I think that it's correct behavior for
> the stash to not be dropped if the merge conflicts.

Agreed.

> If there's any change that should be made it should be purely
> providing more detailed instructions to the user about how to deal
> with it.

Yes, there may be room for improvement, but that does not seem so easy.
Today, we have:

$ git stash pop
Auto-merging foo.txt
CONFLICT (content): Merge conflict in foo.txt

$ git status
On branch master
Unmerged paths:
  (use "git reset HEAD <file>..." to unstage)
  (use "git add <file>..." to mark resolution)

        both modified:      foo.txt

=> The advices shown here are OK. Then:

$ git add foo.txt 
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        modified:   foo.txt

=> here, "git status" could have hinted the user "you may now run 'git
stash drop' if you are satisfied with your merge".

An obvious issue is that at this point Git has no way to know that you
just did a "git stash pop". But that could be solved by leaving a file
around like .git/stash-pop-ongoing.

Now, the real question is: when would Git stop showing this advice. I
don't see a real way to answer this, and I'd rather avoid doing just a
guess.

One easy thing to do OTOH would be to show a hint at the end of "git
stash pop"'s output, like

$ git stash pop
Auto-merging foo.txt
CONFLICT (content): Merge conflict in foo.txt
'stash pop' failed. Please, resolve the conflicts manually. The stash
was not dropped in case you need to restart the operation. When you are
done resolving the merge, you may run the following to drop the stash:

  git stash drop


or so (I couldn't find a concise yet accurate wording).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
