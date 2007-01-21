From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] show_date(): fix relative dates
Date: Sun, 21 Jan 2007 02:34:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701210219400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701202203260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3b656vq5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 02:34:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8RbQ-0004P7-4V
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 02:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbXAUBeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 20:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbXAUBeY
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 20:34:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:38623 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750979AbXAUBeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 20:34:23 -0500
Received: (qmail invoked by alias); 21 Jan 2007 01:34:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 21 Jan 2007 02:34:22 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3b656vq5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37301>

Hi,

On Sat, 20 Jan 2007, Junio C Hamano wrote:

> I noticed this and have a different solution in the show-branch
> --reflog code (it does not pass tz).

Actually, you do pass tz, but with a fixed value of 0. But this is only a 
workaround.

The thing is, if you pass the same timestamp with a different timezone, 
absolute (non-relative) date will show the same time, i.e. 22:24 +0000 
is the same as 23:24 +0100.

Now I expect the same of relative mode, only that the timezone does not 
matter for relative mode _at all_.

As you can see in my patch for --walk-reflogs (to honour --relative-date), 
it can make sense to pass make the choice whether to show a relative or an 
absolute date a runtime option (where you don't want to set tz to 0 
depending on relativa_date).

I guess nobody realized that "git log --relative-date" does not work 
correctly (for all commits which were not committed in tz +0000), is due 
to its narrowspread use, or that it is not all that obviously wrong.

However, I was very surprised when "git log --walk-reflogs 
--relative-date" showed me "in the future" for my last commits.

If you don't want to think it through, please just verify my reasoning by 
compiling the script I gave with the patch both before and after applying 
the patch. The absolute dates _and_ the relative dates should be all the 
same, but the relative date with non-zero timezone is displayed as "in the 
future" withouth the patch.

Ciao,
Dscho
