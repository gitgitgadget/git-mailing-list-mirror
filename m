From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit encoding: store it in commit header rather than
 mucking with NUL
Date: Mon, 25 Dec 2006 01:41:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612250134040.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612241505290.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612241643440.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3b74q1c9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 25 01:42:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gyduu-0001sf-3R
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 01:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbWLYAlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 19:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbWLYAlu
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 19:41:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:49679 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753194AbWLYAlt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 19:41:49 -0500
Received: (qmail invoked by alias); 25 Dec 2006 00:41:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp016) with SMTP; 25 Dec 2006 01:41:47 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3b74q1c9.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35378>

Hi,

On Sun, 24 Dec 2006, Junio C Hamano wrote:

> Thanks for paying a very close attention to what is in 'pu'.

You're welcome ;-)

>  - I did not want to break existing git implementations, but
>    hadn't audited the commit header parsers to see if they do
>    not get upset when they see unrecognized header fields in
>    commit objects.

I did not really audit it, but am quite sure that only parse_commit() 
really walks the buffer, and even this function just ignores what comes 
after committer. But if I read the code correctly, then the mandatory 
headers ("tree parent* author committer") have to come first, in that 
order.

>  - I was not sure if the "assume the whole commit->buffer is in
>    the local encoding and recode it into UTF-8" is correct.

For the purpose of showing it, there is no point in using two different 
encodings. I am not aware of any terminal (and do not own such a terminal 
anyway) which can display text with parts encoded differently from the 
rest.

>  - Existing Porcelains such as gitk know i18n.commitencoding is
>    a hint to them by the core, and expect the core to give them
>    output in the local encoding.  With the change, the core
>    feeds UTF-8 to the caller, unless the Porcelain gets the log
>    with plumbing "cat-file".  This means they either have to
>    lose code to do their own recoding (which is probably a good
>    thing in the long run), or we would need to have a flag for
>    them to tell the core not to do the conversion.  But a new
>    flag to ask for older behaviour is always a wrong way of
>    transitioning across backward incompatibility.
> 
>    I think the output conversion from the log should be more
>    explicitly asked for it, than just a mere configuration
>    variable that cannot be overriden by gitk and friends.

Probably a new flag "--encoding" to log, which sets git_commit_encoding. 
And the function you introduced should probably not blindly convert to 
UTF-8, but to the current git_commit_encoding.

Ciao,
Dscho
