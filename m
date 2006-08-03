From: Blu Corater <blu@daga.cl>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 3 Aug 2006 15:21:52 -0400
Message-ID: <20060803192152.GT7533@daga.cl>
References: <20060803075403.GA5238@buici.com> <20060803155603.GS7533@daga.cl> <20060803162241.GB1287@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 03 21:22:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8ilb-00083Z-FU
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 21:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWHCTV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 15:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWHCTV4
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 15:21:56 -0400
Received: from [201.215.212.46] ([201.215.212.46]:54490 "EHLO daga.cl")
	by vger.kernel.org with ESMTP id S932440AbWHCTVz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 15:21:55 -0400
Received: from blu by daga.cl with local (Exim 4.62)
	(envelope-from <blu@daga.cl>)
	id 1G8ilU-00053s-O2
	for git@vger.kernel.org; Thu, 03 Aug 2006 15:21:52 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060803162241.GB1287@buici.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24748>

On Thu, Aug 03, 2006 at 09:22:41AM -0700, Marc Singer wrote:
> On Thu, Aug 03, 2006 at 11:56:03AM -0400, Blu Corater wrote:
> > On Thu, Aug 03, 2006 at 12:54:03AM -0700, Marc Singer wrote:
> > > I would like to use gitweb with the Cherokee web server because the
> > > host that I have on hand has very limited RAM, 32MiB.  Neither the
> > > version of gitweb available on Debian (v264) nor the latest in the git
> > > repo works.
> > > 
> > > I did some debugging on the latest repo version.  The lines
> > > 
> > >   our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
> > >   if (defined $project) {
> > >      ...
> > > 
> > > are being executed even though the url is
> > > 
> > >   http://server/git
> > > 
> > > I think that the problem is that Cherokee translates the request URL
> > > into
> > > 
> > >   http://server/git/
> > > 
> > > which means that the $ENV{'PATH_INFO'} is the string "/" insted of
> > > being undefined.
> > > 
> > > The error I'm seeing is that the request path is forbidden, but I
> > > suspect that this is some sort of misunderstanding between the web
> > > server and the script.
> > 
> > I am using Cherokee+GitWeb and the behaviour observed is that
> > http://server/git will return the default Cherokee index page, but
> > http://server/git/, with a slash at the end, works. 
> 
> Will you share your Cherokee configuration script?
> 
> The links look like this:
> 
>   http://scarlet/g?p=bsp.git;a=summary
> 
> even when I start with 
> 
>   http://scarlet/g
> 
> or
> 
>   http://scarlet/g/
> 
> So, I'm not sure I understand what you are saying.

Here is the interesting part of my cherokee.conf

------------------------------------------
UserDir public_html {
    Directory / {
       Handler common
    }

    Directory /scm/ {
        Handler cgi {
                ScriptAlias /home/blu/bin/gitweb.cgi
        }
    }
}
-----------------------------------------

So, I have the gitweb.cgi executable in a bin directory on my home and I
am telling Cherokee that when it sees the url http://server/~blu/scm/, it
should execute /home/blu/bin/gitweb.cgi

If I request http://server/~blu/scm, Cherokee returns Cherokee's default
index page. Only if I request http://server/~blu/scm/, Cherokee returns
the expected output from gitweb.

Now, if I add 

    Directory /test/ {
	Handler cgi
    }

And copy gitweb.cgi to ~/public_html/test/, it seems there is no problem.

I can request http://server/~blu/test/gitweb.cgi or
http://server/~blu/test/gitweb.cgi/ and get the expected gitweb output.

It looks more like a Cherokee problem to me, but I don't have time to
investigate further right now.

-- 
Blu.
