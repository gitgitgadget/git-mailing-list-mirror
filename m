From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ***DONTUSE*** Re: [PATCH] Use a hashtable for objects instead
 of a sorted list
Date: Sun, 12 Feb 2006 18:26:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602121822060.21959@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87slqpg11q.fsf@wine.dyndns.org>
 <Pine.LNX.4.63.0602120254260.10235@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virrli9am.fsf@assigned-by-dhcp.cox.net> <87accwlt8k.fsf@mid.deneb.enyo.de>
 <7vlkwgdbk6.fsf_-_@assigned-by-dhcp.cox.net> <7virrkbsgp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 18:26:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Kzx-0001GQ-Sd
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 18:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWBLR0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 12:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWBLR0y
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 12:26:54 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:16591 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751292AbWBLR0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 12:26:53 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D97BF146522; Sun, 12 Feb 2006 18:26:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id CD5132CEF;
	Sun, 12 Feb 2006 18:26:50 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AF189146521; Sun, 12 Feb 2006 18:26:50 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virrkbsgp.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16001>

Hi,

On Sun, 12 Feb 2006, Junio C Hamano wrote:

> The problem does not seem to trigger with casual use, but I
> found that with a clone from my primary repository with '-l -s'
> (that is, a clone that uses alternates mechanism to borrow from
> my primary repository), fsck-objects built with the patch seems
> to report bogus things "missing".  I have not traced it fully;
> instead I ended up spending most of the night (I noticed it at
> around 01:30 and now it is 05:30 so that's about four hours)
> recovering some of my refs and double checking if my primary
> repository is not corrupt X-<.  At least, the primary repository
> looks sane now.

Could it be the shallow thing?

+
+void for_each_object(void (*fn)(struct object *))
+{
+       int i;
+       for (i = 0; i < nr_objs; i++)
+               fn(objs[i]);
+}

This will not work with the hashtable. It has to be something like


void for_each_object(void (*fn)(struct object *))
{
       int i;
       for (i = 0; i < obj_allocs; i++)
               if (objs[i])
			fn(objs[i]);
}

This error did not trigger here, since I don't use shallow clones.

Again, sorry for the inconvenience, Junio.

Hth,
Dscho
