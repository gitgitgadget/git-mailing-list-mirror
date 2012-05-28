From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: =?UTF-8?Q?Re=3A_Git_hangs_at_=E2=80=9CWriting_objects=3A_11%=E2=80=9D?=
Date: Mon, 28 May 2012 22:36:44 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1205282225590.31146@cone.martin.st>
References: <EF4D4C5F-2D6B-46F2-B5A4-9DB1BA55BB6B@att.net> <20120525005156.GC11300@sigill.intra.peff.net> <033AF49C-4CB3-4412-8845-0246D356358C@att.net> <2DE05B0B-1D7E-451F-9151-B01CDDF4593E@att.net> <201205270312.q4R3Chef014187@no.baka.org>
 <3BBC77C3-B747-4F68-A135-954C3C00ECBA@att.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Seth Robertson <in-gitvger@baka.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Timothy Normand Miller <theosib@att.net>
X-From: git-owner@vger.kernel.org Mon May 28 21:43:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ5qr-0003jM-EA
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 21:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab2E1Tmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 15:42:55 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:41739 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867Ab2E1Tmy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 15:42:54 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 May 2012 15:42:54 EDT
Received: from cone.home.martin.st (84.250.16.54) by jenni2.inet.fi (8.5.140.02)
        id 4FBB425E0044B1AC; Mon, 28 May 2012 22:36:47 +0300
In-Reply-To: <3BBC77C3-B747-4F68-A135-954C3C00ECBA@att.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198717>

On Mon, 28 May 2012, Timothy Normand Miller wrote:

> I tried uploading a file via sftp, and it stalls out at 160K.  So this 
> is the cause of the problem.  SSH is broken.  Unfortunately, googling 
> for ssh and stall isn't getting me anywhere.

Not sure if this is the same issue you're seeing or not, but I ran into 
something similar a while ago - when connected from less reliable 
networks, connections (especially rsync or scp) over SSH stalled after a 
short while - interactive sessions worked fine.

In my case, the issue was a too pedantic iptables configuration. When 
communicating with the server from a less reliable network, packets could 
arrive out of order. If the server received packets that 
iptables/conntrack didn't think belonged to the session, my config sent 
ICMP unreachable packets as response (-j REJECT), basically terminating 
the connection.

I fixed it by adjusting the iptables config to not send ICMP unreachable 
for this case. An alternative solution was to set sysctl 
"net.netfilter.nf_conntrack_tcp_be_liberal = 1" - this made the out of 
order packets still be counted as part of the session, not triggering the 
bad behaviour of my iptables config.

Again, not sure if this is related to your issue or not, but it at least a 
similar symptom.

// Martin
