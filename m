From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 12:41:16 -0700
Message-ID: <7vejj1v92b.fsf@assigned-by-dhcp.cox.net>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
	<200707210951.00210.stimming@tuhh.de>
	<20070721080338.GT32566@spearce.org>
	<200707211433.29318.stimming@tuhh.de>
	<Pine.LNX.4.64.0707211427190.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 21:41:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICKpg-0002CM-AN
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 21:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759092AbXGUTlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 15:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759158AbXGUTlW
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 15:41:22 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48240 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760723AbXGUTlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 15:41:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070721194117.BGDM1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Jul 2007 15:41:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SKhH1X0011kojtg0000000; Sat, 21 Jul 2007 15:41:17 -0400
In-Reply-To: <Pine.LNX.4.64.0707211427190.14781@racer.site> (Johannes
	Schindelin's message of "Sat, 21 Jul 2007 15:22:16 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53182>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ...
> - Make the current revision my new 'master'.  That branch already exists, 
>   and I am on 'christian-new', though.  No problem:
>
> 	$ git branch -M christian-new master
>
>   (But if you do that with "-M", which means _force_ rename, make sure 
>   twice that this is really what you want.)
>
> - Push it.
>
> 	$ git push origin +master
> 	...
> 	refs/heads/master: da7b699[...] -> cc2b761b[...]
>
>   The "+" is necessary, since I rebased it...
>
>   If there were more pushers than just me, I'd verify that da7b699 is 
>   indeed the old state of my master:
>
> 	$ git reflog
> 	...
> 	d36cd96... HEAD@{20}: checkout: moving from master to christian-new
> 	da7b699... HEAD@{21}: commit [...]
>
>   Yep.
>
> Good.  Happy.

Two questions and a half.

 - The above means git-gui-i18n.git's master is rebased.  Is
   that the intention?  IOW, people are supposed to work on it
   with fetch+rebase, not fetch+merge (= pull)?

 - It seems that the tip of 'mob' now is out of sync wrt
   'master'.  What's the plan to update it with framework
   changes made in 'master' (e.g. addition of po/glossary.csv)?

While I think keeping a reference for consistent translation
(within one language's *.po file) is a useful practice,
the po/glossary.csv file on 'master' seems a way suboptimal
solution.  Currently it is:

        $ file po/glossary.csv
        po/glossary.csv: ISO-8859 text

        $ head -n 1 po/glossary.csv
        "English Term"  "de translation"

which implies that other languages will be added at the end
separated with <TAB>?

There are two HUGE problems with that.

 * Supporting many languages means looooong lines in that file.
   Translators for languages later on the line would have hard
   time updating or looking at that file.

 * Mixed encodings.  What if next language wants its strings in
   UTF-8?  How would you have that and ISO-8859 on a same line?

I would suggest having one glossary file per language.
