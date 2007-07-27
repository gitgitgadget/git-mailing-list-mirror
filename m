From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] Clean up work-tree handling
Date: Fri, 27 Jul 2007 11:50:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271146290.14781@racer.site>
References: <Pine.LNX.4.64.0707260729150.14781@racer.site>
 <20070726220949.GA4420@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 27 12:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IENPn-0000xo-M4
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 12:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764518AbXG0KvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 06:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762368AbXG0KvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 06:51:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:41377 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760376AbXG0KvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 06:51:07 -0400
Received: (qmail invoked by alias); 27 Jul 2007 10:51:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 27 Jul 2007 12:51:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ksoIa134k8kZ4Pbm0hXkJEIDIxAcmJUcrB6qih1
	uDOtk1I2lL5pRQ
X-X-Sender: gene099@racer.site
In-Reply-To: <20070726220949.GA4420@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53914>

Hi,

On Fri, 27 Jul 2007, Matthias Lederhofer wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > +const char *get_git_work_tree(void)
> > +{
> > +	static int initialized = 0;
> > +	if (!initialized) {
> > +		work_tree = getenv(GIT_WORK_TREE_ENVIRONMENT);
> > +		if (!work_tree) {
> > +			work_tree = git_work_tree_cfg;
> > +			if (work_tree && !is_absolute_path(work_tree))
> > +			work_tree = git_path(work_tree);
> 
> A tab is missing here.

Right.  And as Junio pointed out, an xstrdup().

> > -				fprintf(stderr, "No directory given for --work-tree.\n" );
> > +				error("No directory given for --work-tree.\n");
> 
> There should probably be no '\n' at the end when the 'error' function
> is used.  There are two other calls to fprintf(stderr, <error message>)
> next to the one you changed, why did you change this one but not the
> other ones?

Well, that is a left over of some unrelated editing.

The patch series that I sent out was deficient in many ways, but I was 
tired, and wanted to show where I am heading.

ATM I am trying to finish up this series, with quite a few changes to the 
code I sent out.

But there is a fundamental question I have to ask: Is there any reason why 

	$ git --git-dir=/some/where/else.git bla

should pretend that the repo is bare if core.bare == 1?  I mean, we are 
implicitely setting the work tree to the cwd, no?

IOW I see the merits of "core.bare = false" (to prevent harm when calling 
git inside the git directory), but I cannot see the merits of "core.bare = 
true".  Someone enlighten me?

Ciao,
Dscho
