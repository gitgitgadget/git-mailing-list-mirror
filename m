From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 17:57:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708091754150.25146@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
 <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
 <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
 <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
 <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net> <7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
 <7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 03:03:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJIuc-0000D7-5E
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 03:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933051AbXHJBDY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 21:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932839AbXHJBDX
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 21:03:23 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54556 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932806AbXHJBDW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 21:03:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7A0vo6S003046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Aug 2007 17:57:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7A0vjSJ027955;
	Thu, 9 Aug 2007 17:57:45 -0700
In-Reply-To: <7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55495>



On Thu, 9 Aug 2007, Junio C Hamano wrote:
> 
> Heh, that makes the two of us.  I have been wanting to revamp or
> kill off unpack-trees for quite some time, and after all the
> patch you are responding to might be a small first step in the
> right direction ;-).

Well, the patch you sent out was not only hacky, it was kind of pointless.

Without the "-m" handling, it means that most users of git-read-tree won't 
ever see the improvement. The merge with the old index is absolutely 
critical for things like switching branches, for example. And I think you 
probably screwed up performance with your change to git-commit to simply 
not use it, because now the resulting index will be totally stale, and 
while the *commit* may be fast as a result, the subsequent operations 
might be horrible.

(I didn't test it, though, maybe I missed something).

So I do think that things like "git checkout <otherbranch>" need to have a 
fully working (and fast) unpack-trees, and your hack doesn't really help 
except for a pretty uninteresting special case.

		Linus
