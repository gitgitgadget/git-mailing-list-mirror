From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: add pf= to limit project list to a subdirectory
Date: Sat, 28 Jan 2012 17:03:06 +0100
Message-ID: <201201281703.07313.jnareb@gmail.com>
References: <20120126144517.GA4229@server.brlink.eu> <201201281553.29387.jnareb@gmail.com> <20120128153750.GB3397@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+list+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Sat Jan 28 18:40:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrCFY-0000o9-8g
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 18:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab2A1QCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 11:02:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52941 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab2A1QCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 11:02:37 -0500
Received: by eaal13 with SMTP id l13so586415eaa.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 08:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Z+qh5nNjAgnBH1wD8y1dfG3FH5dMkZi2k91ckSGocsU=;
        b=qPa1F/dmg4CRMa55meAJtxjWWkhRDKeo1/aQ/7MDKd16e8Zm8+6A/WpwJ7UC1cDzgg
         RmzBLzvQ/cqEwh+SxO8nGoKB1c9Dcm/Pj0DV9iTzt+ifvx0RL1WdyKwkd1Ow2fMCbUm6
         n9WoYdwM9HI1jtYtzmoWp6pxyyGw+DbCPln1M=
Received: by 10.213.26.14 with SMTP id b14mr1807210ebc.3.1327766555945;
        Sat, 28 Jan 2012 08:02:35 -0800 (PST)
Received: from [192.168.1.13] (abvp249.neoplus.adsl.tpnet.pl. [83.8.213.249])
        by mx.google.com with ESMTPS id x4sm45403248eeb.4.2012.01.28.08.02.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jan 2012 08:02:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120128153750.GB3397@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189256>

On Sat, 28 Jan 2012, Bernhard R. Link wrote:
> * Jakub Narebski <jnareb@gmail.com> [120128 15:53]:
> > On Sat, 28 Jan 2012, Bernhard R. Link wrote:

> > > The project list takes often a very long time and searching in that list
> > > takes the same time (and would also show projects not starting with the
> > > text).
> >
> > There are at least two ways to speed up getting projects list page.
> 
> There are other ways, but they are both limited and quite backward:
> Instead of showing me the information I want (what is in that
> directory), I guess to search in the larger pool of information needing
> all sort of half-working tricks causing all kinds of other problems
> working around the issue that much more information never used must be
> collected first.
> 
> Subversion's ViewVC for example only shows what is in some directory
> directory and available subdirectories. (That of course has the
> disadvantage to make it harder to find a project one does not know
> the subdirectory it is in, but why shouldn't gitweb offer the best of
> both worlds?)

Well, ViewVC follows Subversion concepts... including broken-by-design
branching by copying ;-)


Anyway, I think I am getting convinced that supporting project filtering
by subdirectory, in a way similar to existing support for forks (and reusing
it implementation) could be a good idea.  

The one serious disadvantage of "pf=" is that it is not solution for a
faster gitweb homepage.  It works _only_ when you have pf=subdirectory/
link.

And I'd rather it worked with strict export, correctly and safely,
if "pf=" is to be included in gitweb.
 
> > First is to limit number of projects shown, like e.g. http://repo.or.cz
> > which shows only search form and tag cloud, but no projects, or at least
> > paginate (divide into pages of e.g. 100 projects) list of projects.
> 
> But a page showing all projects (as long as it is possible) is something
> I'd quite miss if it is gone. What I want is some way to have that and
> to also be able to look at some subset interesting to me directly in an
> effective way.

The http://repo.or.cz homepage has 'Show all projects' link, but it is
at explicit request. 

> > Second solution would be to finally add caching support to gitweb,
> 
> But caching also means new projects or changes will take some time to
> show up. And again it would not be a solution to by original problem.
> (Showing effectively what is in some directory).

Well, it would solve "The project list takes often a very long time"
part of your problem.  Though very large list of projects can cause
performance problems rendering on client side, I guess...
 
> > > I'd for example like to be able to place a link to all projects shown
> > > at http://anonscm.debian.org/gitweb/ which are below mirrorer/ and get
> > > a not having to wait for description information being extracted for all
> > > the other projects.
> >
> > I would prefer instead of introducing yet another arbitrary parameter
> > extend project searching, so that you can specify that you want to
> > search project names only (IIRC I have a patch for that, or beginnings
> > of one, in my StGit stack), and use prefix search by the way of regexp
> > search.
> >
> > So
> >
> >   pf=mirrorer/
> >
> > would be
> >
> >   s=^mirrorer/;sr=1;st=project_name
> 
> That might be a workaround, but still need to look at quite some amount
> of unecessary data (i.e. it would need to run at least as long as a
> http://anonscm.debian.org/gitweb/?a=project_index would not to load,
> wouldn't it?)

Not with 'gitweb: Faster project search' from this series of commits

  # gitweb: Allow underscore in $searchtype ('st')
  # gitweb: Improve projects search form
  # gitweb: Option for filling only specified info in fill_project_list_info
  # gitweb: Faster project search
  # gitweb: Highlight matched part of project name when searching projects
  # gitweb: Highlight matched part of project description when searching projects

which does not search for description nor check for latest changes in
repository for repositories it doesn't show.

-- 
Jakub Narebski
Poland
