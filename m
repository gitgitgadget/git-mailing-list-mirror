From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [RFD} Use regex's in :/ revision naming machinery
Date: Tue, 06 Apr 2010 09:02:00 +0200
Organization: Bertin Technologies
Message-ID: <20100406090200.46a7c66b@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ydirson@free.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 09:13:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz2yL-0007gP-Ii
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 09:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357Ab0DFHNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 03:13:13 -0400
Received: from blois.bertin.fr ([212.234.8.70]:58817 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab0DFHNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 03:13:11 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2010 03:13:11 EDT
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 2B1885450F
	for <git@vger.kernel.org>; Tue,  6 Apr 2010 09:04:33 +0200 (CEST)
Received: from YPORT1 (unknown [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 085725435E
	for <git@vger.kernel.org>; Tue,  6 Apr 2010 09:03:58 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.3.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0L0G001PC0YLDF10@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Tue, 06 Apr 2010 09:03:58 +0200 (CEST)
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.12.12; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8146-6.0.0.1038-17302.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144109>

Let's step in as a user of the feature :)

I started to use :/ very recently, and found it very convenient for my
particular use.  I'm running a script which takes a treeish as
argument, which I regularly run on a dev branch on which I am editing
the commits regularly - that is, the commit message rarely change, but
the sha1's do.  Then once I have a working :/ expr, I can just reuse
the line from shell history, saving typing.

Also, for composing the :/ expression, I make use of "git slog|head"
(slog being an alias of mostly "git log --pretty=oneline"), which helps
figuring out a prefix string that does not require too much
keystrokes.  There again, it is a gain compared to grabbing the mouse
to cut+paste a sha1.

Junio wrote:
>I also happen to think that the current ':/' is more or less useless
>because you cannot tell it to start digging from only these branches,
>and it becomes dice-throwing which commit it would find.

Now what I found really strange, is that the ":" in :/ would not act as
it does in the [<treeish>]:<file> syntax.  Allowing to use
[<treeish>]:/<regexp> would not only make it more useful, but also more
consistent with that other syntax.


>A related but a larger issue is that I suspect this "two-dot" would not
>work, as the syntax looks for "Merge branch 'slabh'.." (two-dot taken
>literally).

Right there is a problem here - even if it works when you mean ".." as
the range separator, it makes it hard to specify a ".." search pattern.

What about using ":/pattern/" as a syntax instead ?  That would also be
close to other familiar stuff - although it would now require quoting
a "/" to include it in the search pattern...

Another issue would be to (de)activate regexp processing (as compared
to just substring or leading-substring behaviour).  Maybe we could use
sed-like trailing modifiers for this - eg. if regexp is made the
default, ":/obj.c/f" would not match "object".  This would also give us
provision to add classical pattern modifiers like /i, and at 1st sight
would still be unambiguous wrt the .. separator.

Does that make sense ?
-- 
Yann
