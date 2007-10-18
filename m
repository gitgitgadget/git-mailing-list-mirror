From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 20:13:23 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org>
References: <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <20071018003256.GA5062@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org>
 <20071018024553.GA5186@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Luke Lu <git@vicaya.com>, Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 05:13:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiLpU-0004IR-UP
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 05:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352AbXJRDNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 23:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbXJRDNg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 23:13:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56410 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752516AbXJRDNf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 23:13:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9I3DRHV015436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 20:13:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9I3DNXW021818;
	Wed, 17 Oct 2007 20:13:25 -0700
In-Reply-To: <20071018024553.GA5186@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.418 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_12
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61456>



On Wed, 17 Oct 2007, Jeff King wrote:
> 
> You have made this claim several times, and I really don't understand
> it. If I have 8 spaces, then a diff line will have either " ", "+", or
> "-" followed by 8 spaces. If I use a hard tab, then the tab will end up
> only taking up 7 spaces because of the nature of tabs.
> 
> This might matter if I'm comparing non-diff code to diff code. But in a
> diff, _everything_ is indented by exactly one space, so it all lines up.
> Is there something I'm missing?

Yes. 

You're missing the fact that some people have problems with editors.

So they add a line, and they add *that* line with the wrong kind of 
indentation. And it shows up among the other lines like this (here the 
whole patch is indented):

	diff --git a/kernel/sched.c b/kernel/sched.c
	index 92721d1..1ecb164 100644
	--- a/kernel/sched.c
	+++ b/kernel/sched.c
	@@ -127,6 +127,7 @@ static inline u32 sg_div_cpu_power(const struct sched_group *sg, u32 load)
	 static inline void sg_inc_cpu_power(struct sched_group *sg, u32 val)
	 {
	 	sg->__cpu_power += val;
	+        wrong indentation here.
	 	sg->reciprocal_cpu_power = reciprocal_value(sg->__cpu_power);
	 }
	 #endif

and so you see the fact that somebody messed up in the patch itself.

It actually more often goes the other way: somebody may have messed up 
earlier, but did so *consistently* so it wasn't obvious when looking at 
the patch. And then somebody fixes one line, and now that one fixed line 
is indented correctly but differently.

When it gets *too* bad, we just reindent the whole file, but more 
commonly when I notice it in a diff, I just edit that particular region 
or even just the diff itself in-place.

Generally, it seldom comes to even that. Doing a

	git grep '        ' -- '*.c'

(that's now eight spaces) returns quite a lot of lines, and it's generally 
not worth worrying about (not all of them are indentation - people do use 
spaces for lining things up etc - but a lot of it really is just indents 
done against the coding style).

> I was about to tell you that you're full of it, but there really is a
> slowdown:
>  [ ... ]
> It's actually about 16%.

I didn't even time it, and I called it at 20% without even counting any 
tabs. Why? Because it's inevitable!

It so happens that "grep" has a lot of really clever heuristics, so that 
it is actually better at passing over characters that it knows cannot 
start the pattern you are searching for, so timing "grep" is actually 
quite complex in the general case. So I bet that if you had grepped for 
something that started with a space, you'd probably have found a bigger 
slowdown. 

But ignore all that complexity, and it really boils down to a really 
simple principle: bigger data sets are more expensive, and "linear 
slowdown" is actually almost the best possible case. Quite often, a bigger 
data set causes *worse* than a linear slowdown.

It's very seldom the case that you grow some problem space and performance 
stays the same.

> Gah, I can't believe I've not only been sucked into a tab vs spaces
> discussion, but now I've actually wasted time doing a performance
> comparison on it.

Well, performance analysis isn't exactly a "waste". That "git grep" was 
something we spent some time trying to go fast (for example, doing the 
whole external grep tool thing because that thing is usually optimized to 
h*ll and back - so the execve() overhead is more than worth it).

And it's a real workload. Maybe others don't use "git grep" quite as much 
as I do, but I do it *all* the time. Some other people probably use ctags 
or something, I personally prefer just a fast git grep.

But the *exact* same issues will show up for "simple" things like "git 
bisect". One of the biggest costs of git bisect is actually checking out 
the source tree. If the source tree is on the order of 20% larger, what 
does that mean? 

So it doesn't matter if you have a terabyte disk. Source code size *still* 
matters.

And 20% (or 16%) is more than a lot of other optimizations can help you 
save!

> As an aside, that commit was enough to trigger a "git-gc --auto", which
> was my first experience with it. It's actually kind of annoying
> (especially since I was about to repack -a -d).

Yeah, I don't think it's wonderful, but it might even be a good thing as a 
"hey, at least you are aware of the notion of GC now" kind of introduction 
to people (who then hopefully realize that they don't actually want 
automatic GC, but rather do it once a week or something).

		Linus
