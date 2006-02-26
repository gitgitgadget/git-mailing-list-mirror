From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Use setenv(), fix warnings
Date: Sun, 26 Feb 2006 11:38:30 -0800
Message-ID: <15703.1140982710@lotus.CS.Berkeley.EDU>
References: <20060226203756.05dcfb26.tihirvon@gmail.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 20:38:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDRj1-00085z-S1
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 20:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWBZTic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 14:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWBZTic
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 14:38:32 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:27819 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751360AbWBZTic (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 14:38:32 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1QJcVxZ015705;
	Sun, 26 Feb 2006 11:38:31 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1QJcUY0015704;
	Sun, 26 Feb 2006 11:38:31 -0800 (PST)
To: Timo Hirvonen <tihirvon@gmail.com>
In-reply-to: <20060226203756.05dcfb26.tihirvon@gmail.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16788>

And Timo Hirvonen writes:
 - It appears that statically allocated strings are accepted but 
 - _automatic_ variables aren't.

The putenv()-ed string has to exist as long as the environment
does.  You can twiddle the environment just by twiddling the
string you registered.  What fun!

 - I noticed setenv is now in compat/ so I though it was good idea
 - to use it.

All uses of putenv() originally were setenv().  I finally realized
a compat/setenv.c was better than playing whack-a-setenv on every
release...  (Ah, hindsight.)

Note that the current compat/setenv.c _LEAKS MEMORY_ on purpose.  
Because putenv() requires the string to stay around, we can't
ever free it.  I hope any library implementing bits of git
(libgitbit?) avoids setting environment variables.

 - So the variable is emptied, not removed.  But usually empty environment
 - variables are treated as if they didn't exist...

More specifically, git treats both "" and NULL as empty, or at 
least it did last time I checked.

Jason
