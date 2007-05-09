From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Wed, 09 May 2007 02:02:28 -0700
Message-ID: <46418E24.9020309@midwinter.com>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>	<11786309073709-git-send-email-tytso@mit.edu>	<11786309072612-git-send-email-tytso@mit.edu>	<11786309071033-git-send-email-tytso@mit.edu>	<Pine.LNX.4.64.0705090056231.18541@iabervon.org> <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 11:02:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hli3m-0007r0-Kn
	for gcvg-git@gmane.org; Wed, 09 May 2007 11:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbXEIJCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 05:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbXEIJCF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 05:02:05 -0400
Received: from tater.midwinter.com ([216.32.86.90]:54072 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754388AbXEIJCE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 05:02:04 -0400
Received: (qmail 19842 invoked from network); 9 May 2007 09:02:03 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 9 May 2007 09:02:02 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46685>

Junio C Hamano wrote:
> I think that sounds saner and more user friendly than specific
> knob to tune "window", "depth" and friends which are too
> technical.  It has an added attraction that we can redefine what
> exactly "hard" means later.
>   

On that note, has any thought been given to looking at other compression 
algorithms? Gzip is a great high-speed compressor, but there are others 
out there (some a bit slower, some much slower at both compression and 
decompression) that produce substantially smaller output.

One could even, if one were in a particularly twisted state of mind, 
envision using CPU-intensive compression for less frequently-accessed 
objects and using gzip for active ones, on the theory that the best 
time/space tradeoff is not uniform across all the objects in a git 
repository. Presumably most of us never actually unpack the vast 
majority of objects in a git repository of reasonable age, so the fact 
that it'd take a little longer if we *did* want to unpack them isn't 
much of a downside compared to the upside of reclaiming disk space. That 
would mitigate the impact of using an algorithm that's slow at 
decompression.

I think it'd be kind of neat to have my .git directory shrink by another 
20+%. That's conservative; on maximumcompression.com's test of a mix of 
different file types including images, gzip compresses 64% and the 
best-scoring one does 80%. On English text gzip does 71% and the top 
scorer does 89%. Most of the top-tier compressors are proprietary, but 
there are some open-source ones that do pretty well.

Maybe not worth the added complexity, but I thought I'd toss it out 
there. It probably makes more sense (if it makes any at all) after 
Linus's suggestion to not unpack after cloning is in place. Once the 
upstream has gone to the trouble of CPU-intensive compressing, you 
certainly don't want to force clones to have to spend the time repeating 
the same work.

-Steve (who suspects this is a "yes, we talked this over early in git's 
history" question, but what the heck)
