From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 16:10:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1606141600470.1714@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr> <alpine.LFD.2.20.1606141245490.1714@knanqh.ubzr> <CsLdb3qLMBok7CsLebwX38@videotron.ca> <alpine.LFD.2.20.1606141347310.1714@knanqh.ubzr>
 <Ct7VbfLfTHEALCt7Wbh8Xs@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Tue Jun 14 22:25:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCuu2-000225-S9
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 22:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbcFNUZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 16:25:35 -0400
Received: from alt42.smtp-out.videotron.ca ([23.233.128.29]:22966 "EHLO
	alt42.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932121AbcFNUZe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 16:25:34 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jun 2016 16:25:34 EDT
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id CufMbCL9fcMN9CufPbZa6r; Tue, 14 Jun 2016 16:10:31 -0400
X-Authority-Analysis: v=2.1 cv=YqOvP9sX c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=Hj16ya2lm6gX6CesXvoA:9 a=CjuIK1q_8ugA:10
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id EF8592DA01A5;
	Tue, 14 Jun 2016 16:10:27 -0400 (EDT)
In-Reply-To: <Ct7VbfLfTHEALCt7Wbh8Xs@videotron.ca>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
X-CMAE-Envelope: MS4wfKc+aRK4NoOpOMp2XligUW1Cbw3emXfv7cag9OaLzmXnJ5CxjS2EIbR805zZ/nM+zOiG2LlXDvqSlFy59BJenq9fUycsxtyh+vitRWaOxFnI1NgqxCtI
 yEH2ZYCLVAxJeo7tFWJqiG4zUfZNuDeQZ+maALFmImMCD3dApqMSf6Hucz6Pwn5RQjWDd+7o7i0QeRi5wviIYvKaTIDYN6BLf6c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297326>

On Tue, 14 Jun 2016, Lukas Fleischer wrote:

> On Tue, 14 Jun 2016 at 19:55:06, Nicolas Pitre wrote:
> > It is not buffered as it writes to stderr. And some C libs do separate 
> > calls to write() for every string format specifier. So "%s%s%c" may end 
> > up calling write() 3 times depending on the implementation.  The example 
> > I gave in commit ed1902ef5c is real and I even observed it with strace 
> > back then.
> 
> Ah, right, it is not buffered. Forgot that we are talking about stderr.
> 
> I still do not see how that could become a real problem, though. Apart 
> from the (purely theoretical?) performance issue, the only way 
> multiple write() calls could become a problem is when a single 
> fprintf() invocation is interrupted between two write() invocations 
> and then, there is a write() call from another thread, right?

Right. More another process in this case.

> I do not know whether we print to stderr from different threads but 
> even then, each fprintf() invocation should be atomic if I do not 
> misinterpret the POSIX specification. Could you please clarify? Are 
> there separate processes involved?

Yes, the intermixed writes come from another process such as 
git-index-pack via git-fetch-pack.


Nicolas
