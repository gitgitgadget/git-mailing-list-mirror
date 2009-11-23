From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: OS X and umlauts in file names
Date: Mon, 23 Nov 2009 15:26:31 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911231403100.14365@iabervon.org>
References: <4B0ABA42.1060103@syntevo.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-669169681-1259006590=:14365"
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 21:26:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCfUc-000299-Au
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 21:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756426AbZKWU00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 15:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756279AbZKWU00
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 15:26:26 -0500
Received: from iabervon.org ([66.92.72.58]:49656 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756101AbZKWU00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 15:26:26 -0500
Received: (qmail 31545 invoked by uid 1000); 23 Nov 2009 20:26:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Nov 2009 20:26:31 -0000
In-Reply-To: <4B0ABA42.1060103@syntevo.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Content-ID: <alpine.LNX.2.00.0911231503210.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133532>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-669169681-1259006590=:14365
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0911231503211.14365@iabervon.org>

On Mon, 23 Nov 2009, Thomas Singer wrote:

> I'm on an English OS X 10.6.2 and I created a sample file with umlauts in
> its name (Überlänge.txt). When I try to stage the file in the terminal, I
> can't complete the file name by typing the Ü and hitting the tab key, but I
> can complete it by typing an U and hitting the tab key.

You've already got a bug before involving git at all. You create a 
file "Überlänge.txt", but OS X writes "U:berla:nge.txt" (typing the 
combining character umlaut as : so that you can see the difference), and 
the directory listing doesn't contain any files that start with Ü, so the 
terminal already can't find the file you created. Obviously, git is going 
to have all the problems that the OS-provided readline library has, and 
you're not going to be able to get predictable results in any case where 
user-supplied filenames are compared with directory listings.

Part of the problem is that OS X does a canonicalization that is not what 
anybody else does, so you hit the problem every single time, but the 
fundamental issue is that there isn't any way to tell, when you create a 
file, what name that file will be listed under.

Note that this isn't a matter of characters to byte sequences. OS X 
actually uses different characters for the filename in its listings than 
you've used.

If there's a difference between German and English versions, I suspect 
that it's actually that you're not using a German keyboard with a key 
that, under OS X, produces the two-character sequence U:, but using some 
method that produces the single character Ü. I'd guess that your SmartGit 
problem is that Java is converting the U: that the user typed into Ü, and 
passing it to the OS, which turns it back into U: and then doesn't list 
the file that Java thinks the user asked for.

	-Daniel
*This .sig left intentionally blank*
--1547844168-669169681-1259006590=:14365--
