From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git Questions
Date: Mon, 20 Aug 2007 14:53:55 +0200
Message-ID: <vpqlkc6nz8c.fsf@bauges.imag.fr>
References: <1187603749.11595.10.camel@tom-desktop>
	<87bqd2bgb0.fsf@morpheus.local>
	<1187612156.11595.17.camel@tom-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Tom Schinckel <gunny01@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 14:54:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN6mH-00056A-PM
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 14:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbXHTMyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 08:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXHTMyW
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 08:54:22 -0400
Received: from imag.imag.fr ([129.88.30.1]:49140 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbXHTMyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 08:54:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7KCruC3003525
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Aug 2007 14:53:56 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IN6lY-0004GI-0K; Mon, 20 Aug 2007 14:53:56 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IN6lX-0003uX-U0; Mon, 20 Aug 2007 14:53:55 +0200
Mail-Followup-To: Tom Schinckel <gunny01@gmail.com>, David
 =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,  git@vger.kernel.org
In-Reply-To: <1187612156.11595.17.camel@tom-desktop> (Tom Schinckel's message of "Mon\, 20 Aug 2007 21\:45\:56 +0930")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 20 Aug 2007 14:53:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56212>

Tom Schinckel <gunny01@gmail.com> writes:

> The reason I want to do that is so I can set up blind commits that I can
> add in a anacron job or something. The information about the files isn't
> really important
>
> Thanks for the help: I'm using git in a uncoventional way. 

OK. AAUI, you're abusing git as a backup system.

That's definitely not what git (and other VCS) is meant for. What git
is good at is to create clean "changesets" (i.e. _you_ tell git when
you have something worth recording in history), and merging. But since
git is fast and disk-efficient (if you run git-gc from time to time),
it can probably be a good backup tool too.

If you want to run "git commit" each time you save a file, you can
probably program your editor to do so, or use something like
fam/inotify. But it's probably not reasonable, you'll quickly end-up
with thousands of file revisions (imagine the result if you run a
script like "for i in $(whatever big thing); do echo $i >> file; done").
If I were you, I'd set up a cron job to do the commit once every (few)
minute(s). If the project is not too big, it will take less than a
second, and commit will fail silently if you have no modification to
commit.

You'll want git to automatically add any new file, so you'll run
something like

git add .

# Remove deleted files.
# There's probably a better way, but I don't find it.
git-ls-files --deleted -z | git-update-index --remove -z --stdin

git commit -m backup


I don't think your idea of taking the output of git-status as a commit
message is necessarily relevant: this information is anyway in the
commit, git-show and friends will show it. I'd say the commit message
is irrelevant, and you can provide a dummy one. Otherwise, someone
answered in the thread.

-- 
Matthieu
