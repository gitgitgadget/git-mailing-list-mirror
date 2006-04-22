From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 08:35:14 -0400
Message-ID: <6794F5B2-A277-4CD9-9BA8-509F86378E68@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <Pine.LNX.4.64.0604212308080.2215@localhost.localdomain> <A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com> <7v7j5hkglq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 22:11:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXOSQ-0008H3-NI
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWDVULv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 16:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDVULu
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:11:50 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18633 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751121AbWDVULt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 16:11:49 -0400
Received: from nile.gnat.com (nile.gnat.com [205.232.38.5])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MCZlRG030890
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 12:35:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 6B9FE48CEEA;
	Sat, 22 Apr 2006 08:35:17 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 25174-01-2; Sat, 22 Apr 2006 08:35:17 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 21DBD48CEE4;
	Sat, 22 Apr 2006 08:35:17 -0400 (EDT)
In-Reply-To: <7v7j5hkglq.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.749.3)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19050>


On Apr 22, 2006, at 07:13, Junio C Hamano wrote:
> (Please line-wrap sensibly).
Apologies. I'm using a broken mailer, which insists
on breaking longish lines. I'll try to avoid this.

> I think we tried that with Nico/Davide's delta already, and IIRC
> we had mixed results.
>
> It really depends on how big an index for a source is.  Keep
> in mind that we keep --window (default=10) of the source
> text in-core, and you are suggesting to keep index in-core
> as well, so we need to take memory pressure into account.
The point is that if we do the following comparisons:

   diff A B
   diff A C
   diff A D

then we should keep A and its index in core for all
three comparisons. Discarding and recreating can never
be better :)
> Having said that, the initial number you posted suggests the
> algorithm is very fast, in which case reusing index may not
> matter.  We will see ;-).

BTW, after applying the obvious fixes, I get the following
message:
potomac%./git-pack-objects --no-reuse-delta --stdout <lst
Generating pack...
Done counting 16984 objects.
Deltifying 16984 objects.
100% (16984/16984) done
fatal: delta size changed

Is this expected now I have a different algorithm?

   -Geert
