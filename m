From: Gabriel Paubert <paubert@iram.es>
Subject: Re: Git and GCC
Date: Mon, 10 Dec 2007 10:54:26 +0100
Message-ID: <20071210095426.GA32611@iram.es>
References: <20071205.204848.227521641.davem@davemloft.net> <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> <1196918132.10408.85.camel@brick> <4aca3dc20712052117j3ef5cf99y848d4962ae8ddf33@mail.gmail.com> <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com> <20071206071503.GA19504@coredump.intra.peff.net> <alpine.LFD.0.99999.0712060915590.555@xanadu.home> <20071206173946.GA10845@sigill.intra.peff.net> <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org> <1197074839.22471.34.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 	Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>, 	Jon Smirl <jonsmirl@gmail.com>, Daniel Berlin <dberlin@dberlin.org>, 	David Miller <davem@davemloft.net>, ismail@pardus.org.tr, 	gcc@gcc.gnu.org, git@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: gcc-return-142866-gcc=m.gmane.org@gcc.gnu.org Mon Dec 10 10:55:08 2007
Return-path: <gcc-return-142866-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J1fLv-0007Sj-II
	for gcc@gmane.org; Mon, 10 Dec 2007 10:55:08 +0100
Received: (qmail 17209 invoked by alias); 10 Dec 2007 09:54:48 -0000
Received: (qmail 17087 invoked by uid 22791); 10 Dec 2007 09:54:48 -0000
X-Spam-Check-By: sourceware.org
Received: from gra-lx1.iram.es (HELO gra-lx1.iram.es) (150.214.224.41)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 10 Dec 2007 09:54:41 +0000
Received: from localhost (localhost [127.0.0.1]) 	by gra-lx1.iram.es (Postfix/MJ-1.08) with ESMTP id 81DE416514D; 	Mon, 10 Dec 2007 10:54:36 +0100 (CET)
Received: from gra-lx1.iram.es ([127.0.0.1]) 	by localhost (gra-lx1 [127.0.0.1]) (amavisd-new, port 10024) 	with SMTP id 10758-10; Mon, 10 Dec 2007 10:54:31 +0100 (CET)
Received: from gra-vd1.iram.es (gra-vd1.iram.es [150.214.224.250]) 	by gra-lx1.iram.es (Postfix/MJ-1.08) with ESMTP id C86AF1651D3; 	Mon, 10 Dec 2007 10:54:31 +0100 (CET)
Received: from gra-vd1.iram.es (localhost [127.0.0.1]) 	by gra-vd1.iram.es (8.13.8/8.13.8/Debian-3) with ESMTP id lBA9sVSr000534; 	Mon, 10 Dec 2007 10:54:31 +0100
Received: (from paubert@localhost) 	by gra-vd1.iram.es (8.13.8/8.13.8/Submit) id lBA9sQ0b000533; 	Mon, 10 Dec 2007 10:54:26 +0100
Content-Disposition: inline
In-Reply-To: <1197074839.22471.34.camel@brick>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67695>

On Fri, Dec 07, 2007 at 04:47:19PM -0800, Harvey Harrison wrote:
> Some interesting stats from the highly packed gcc repo.  The long chain
> lengths very quickly tail off.  Over 60% of the objects have a chain
> length of 20 or less.  If anyone wants the full list let me know.  I
> also have included a few other interesting points, the git default
> depth of 50, my initial guess of 100 and every 10% in the cumulative
> distribution from 60-100%.
> 
> This shows the git default of 50 really isn't that bad, and after
> about 100 it really starts to get sparse.  

Do you have a way to know which files have the longest chains?

I have a suspiscion that the ChangeLog* files are among them,
not only because they are, almost without exception, only modified
by prepending text to the previous version (and a fairly small amount
compared to the size of the file), and therefore the diff is simple
(a single hunk) so that the limit on chain depth is probably what
causes a new copy to be created. 

Besides that these files grow quite large and become some of the 
largest files in the tree, and at least one of them is changed 
for every commit. This leads again to many versions of fairly 
large files.

If this guess is right, this implies that most of the size gains
from longer chains comes from having less copies of the ChangeLog*
files. From a performance point of view, it is rather favourable
since the differences are simple. This would also explain why
the window parameter has little effect.

	Regards,
	Gabriel
