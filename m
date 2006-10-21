From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 19:40:56 +0200
Message-ID: <20061021174056.GA29927@artax.karlin.mff.cuni.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz> <20061020225917.GA30584@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 19:41:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbKq6-00056W-MX
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 19:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423355AbWJURkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 13:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423366AbWJURkv
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 13:40:51 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:9417 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1423355AbWJURkv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 13:40:51 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 9503349B7; Sat, 21 Oct 2006 19:40:56 +0200 (CEST)
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20061020225917.GA30584@coredump.intra.peff.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29643>

On Fri, Oct 20, 2006 at 06:59:17PM -0400, Jeff King wrote:
> On Fri, Oct 20, 2006 at 08:12:10PM +0200, Jan Hudec wrote:
> 
> > At this point, I expect the tree to look like this:
> > A$ ls -R
> > .:
> > data/
> > data:
> > hello.txt
> > A$ cat data/hello.txt
> > Hello World!
> 
> Git does what you expect here.
> 
> > A$ VCT mv data greetings
> > A$ VCT commit -m "Renamed the data directory to greetings"
> > B$ echo "Goodbye World!" > data/goodbye.txt
> > B$ VCT add data/goodbye.txt
> > B$ VCT commit -m "Added goodbye message."
> > A$ VCT merge B
> > 
> > And now I expect to have tree looking like this:
> > 
> > A$ ls -R
> > .:
> > greetings/
> > greetings:
> > hello.txt
> > goodbye.txt
> 
> Git does not do what you expect here. It notes that files moved, but it
> does not have a concept of directories moving.  Git could, even without
> file-ids or special patch types, figure out what happened by noting that
> every file in data/ was renamed to its analogue in greetings/, and infer
> that previously non-existant files in data/ should also be moved to
> greetings/.
> 
> However, I'm not sure that I personally would prefer that behavior. In
> some cases you might actually WANT data/goodbye.txt, and in some other
> cases a conflict might be more appropriate. In any case, I would rather
> the SCM do the simple and predictable thing (which I consider to be
> creating data/goodbye.txt) rather than be clever and wrong (even if it's
> only wrong a small percentage of the time).
> 
> In short, git doesn't do what you expect, but I'm not convinced that
> it's a bug or lack of feature, and not simply a difference in desired
> behavior.

I still consider it a bug, but different problems of the file-id
solution have already been described in this thread that I consider bugs
as well.

Besides I start to think that it should be actually possible to solve
this case with the git-style approach. I have to state beforehand, that
I don't know how the most recent git algorithm works, but I imagine
there is some kind of 'brackets' saying the text is in a given file. Now
if those 'brackets' were not flat, but nested, ie. instead of saying
'this is in foo/bar' it would say 'this is in bar is in foo', the
difference when renaming directory would only affect the 'outer bracket'
and therefore merge correctly with adding content inside it.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
