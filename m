From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-tree: sometimes, d/f conflict is not an issue
Date: Sat, 07 Jul 2007 22:50:24 -0700
Message-ID: <7v644v5tr3.fsf@assigned-by-dhcp.cox.net>
References: <20070405071615.2915.6837.reportbug@acer>
	<20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
	<6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
	<20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0706131354250.4059@racer.site>
	<20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0706131543140.4059@racer.site>
	<20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0707080148370.4093@racer.site>
	<7vabu765r0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707080248320.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	=?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Vanicat <vanicat@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 07:50:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Pfc-00064y-Ql
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 07:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbXGHFuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 01:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756032AbXGHFue
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 01:50:34 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47473 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452AbXGHFu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 01:50:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708055025.WTSC3098.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 8 Jul 2007 01:50:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LtqQ1X00E1kojtg0000000; Sun, 08 Jul 2007 01:50:25 -0400
In-Reply-To: <Pine.LNX.4.64.0707080248320.4093@racer.site> (Johannes
	Schindelin's message of "Sun, 8 Jul 2007 03:00:08 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51863>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> IOW, don't make unpack-trees to make policy decisions on final 
>> resolution, unless it is operating under aggressive rule (where the 
>> caller explicitly allows it to make more than the "trivial" decisions).  
>> The caller (in this case, merge-recursive) should see A at stage #2 with 
>> A/B at stages #1 and #3 and decide what to do.
>
> Okay, so you're saying that merge-recursive should use the aggressive 
> strategy?

I do not think so.  Isn't the whole "see if there are renames" thing
depend on threeway_merge() not resolving "one side removes other
side leaves intact" case itself?  Aggressive resolves it saying
"Ok that is a remove", which risks it to miss the case in which
that the side that apparently "removed" the path in fact moved
it somewhere else.

The last time I looked at merge-recursive's D/F check, I found
that it was not quite doing things right.  I may be able to dig
up what I posted to the list...
