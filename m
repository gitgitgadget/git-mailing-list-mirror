From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: Another bench on gitweb (also on gitweb caching)
Date: Tue, 12 Feb 2008 22:45:28 -0200
Message-ID: <20080213004528.GB31455@c3sl.ufpr.br>
References: <20080210030919.GA32733@c3sl.ufpr.br> <m363wvdmxr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 01:46:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP5lI-0005ye-9d
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 01:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760076AbYBMApf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 19:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbYBMApd
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 19:45:33 -0500
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:49297 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758770AbYBMApb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 19:45:31 -0500
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 208EF700003DE;
	Tue, 12 Feb 2008 22:45:29 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <m363wvdmxr.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73721>

On Mon, Feb 11, 2008 at 04:44:23PM -0800, Jakub Narebski wrote:
> Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:
> 
> 
> Could you please do not mix English and your native language
> (Portuguese?) in shown examples? Mixing two languages in one
> identifier name (unless it is ref in br too) is especially bad
> form... TIA.

I agree... that's not good =( i'll enforce to send everything in english.
> 
> Besides, what I'm more interested in is a script used to generate
> those 1000 projects...

So.. like I said, i made a simple test so I cloned a very small project[1]
e replicated it, just generated different owner and descriptions.


> > 
> > Running 2 dd to generate disk IO.  Here comes the results:
> > NO projects_list  projects_list
> > 7m56s55           6m11s95        cached last change, using gitweb.lastref
> > 16m30s69          15m10s74       default gitweb, using FS's owner
> > 16m07s40          15m24s34       patched to get gitweb.owner
> 
> Those are results of running gitweb as standalone script, or your
> script runing git-for-each-ref?

Runing gitweb as standalone script.

> 
> Besides, I'd rather see results of running ApacheBench. On Linux it
> usually comes with installed Apache, and it is called by runing
> 'ab'. Your tests instead of adding superficial load could try to use
> concurrent requests, and more than 1 request to get better average.

hmmm I see, but we will bench with it running with filesystem cached.
This could be a good idea if the machine runs only git!
I find interesting running with all those dds to simulate something like my
environment, which is shared with all of our mirrors. I can even run a test
inside this machine but results may be very different depending on the time
of the day.

As soon I get the machine I ran those tests available again i'll run it with
apache. If you have some ideas of which tests to run tell me =) So we don't
waste time when i get the machine.

>  
> > I found out those VERY interesting, so instead of trying to think a
> > new way to store gitweb config, we should think a way to cache those
> > information.
> 
> Below there are my thoughts about caching information for gitweb:
> 
> First, the basis of each otimisation is checking the bottlenecks.
> I think it was posted sometime there that the pages taking most load
> are projects list and feeds. 
> 
> Kernel.org even run modified version of gitweb, with some caching
> support; Cgit (git web interface in C) also has caching support.

Is this gitweb version for kernel.org available somewhere?
> 
> 
><snip> 
> The "Last Update" information is especially easy because it can be
> invalidated / update externally, by the update / post-receive hook,
> outside gitweb. So gitweb doesn't need to implement some caching
> invalidation mechanism for this.

that's what i thought.
> 
> We can store lastref / lastchange information in repository config, as
> for example "gitweb.lastref" key. We can store it in gitweb wide
> config, for example in $projectroot/gitwebconfig file, as for example
> "gitweb.<project>.lastref" key. Or we can store it as hash initializer
> in some sourced Perl file, read from gitweb_config.perl (this I think
> can be done even now without touching gitweb code at all); we can use
> Data::Dumper to save such information.
> 
> The possibilities are many.

That's right. 

Caching lastref at $projectroot/gitwebconfig might be a good idea. I think
that caching it at $GIT_DIR/config is somehow ugly, because we will have a
script modifying this file.

And having this $projectroot/gitwebconfig with lastref cached can act as a
project_list because we already all the directories we should get gitweb
confs, like gitweb.description, gitweb.url  and gitweb.owner (soon?!) and 
others that will appear.

> 
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
