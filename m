From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Shallow clone: low level machinery.
Date: Wed, 1 Feb 2006 15:33:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602011528030.28923@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net> <7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5i81e4e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601311904410.10944@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmlcz28x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 15:34:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4J3X-0006x8-6l
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 15:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWBAOd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 09:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWBAOd4
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 09:33:56 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:38573 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932449AbWBAOdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 09:33:55 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F1DF01467A1; Wed,  1 Feb 2006 15:33:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id E3257A1B;
	Wed,  1 Feb 2006 15:33:51 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C44661467A1; Wed,  1 Feb 2006 15:33:51 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmlcz28x.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15413>

Hi,

On Tue, 31 Jan 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Worse, you cannot pull from older servers into shallow repos.
> 
> "have X" means different thing if you do not have matching
> grafts information, so I suspect that is fundamentally
> unsolvable.

If the shallow-capable client could realize that the server is not 
shallow-capable *and* the local repo is shallow, and refuse to operate 
(unless called with "-f", in which case the result may or may not be a 
broken repo, which has to be fixed up manually by copying 
over ORIG_HEAD to HEAD).

Of course, the client has to know that the local repo is shallow, which it 
must not determine by looking at the grafts file.
 
> I am not sure you can convince "git-rev-list ^A" to mean "not at
> A but things before that is still interesting", especially when
> you give many other heads to start traversing from, but if you
> can, then you can do things at rev-list command line parameter
> level without doing the "exchange and use the same grafts"
> trickery.  That _might_ be easier to implement but I do not see
> an obvious correctness guarantee in the approach.

If you introduce a different "have X" -- like "have-no-parent X" -- and 
teach git-rev-list that "~A" means "traverse the tree of A, but not A's 
parents", you'd basically have everything you need, right?

> Implementation bugs aside, it is obvious the things _would_ work 
> correctly with "exchange and use the same grafts" approach.

Yes, I agree. But again, the local repo has to know which grafts were 
introduced by making the repo shallow.

Ciao,
Dscho
