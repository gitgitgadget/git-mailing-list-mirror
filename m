From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CR codes from git commands
Date: Fri, 23 Jan 2009 19:41:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901231747340.21467@intel-tinevez-2-302>
References: <18805.64312.289059.660023@hungover.brentg.com> <alpine.LNX.1.00.0901212319310.19665@iabervon.org> <e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com> <alpine.LNX.1.00.0901220238380.19665@iabervon.org> <7vbptzahra.fsf@gitster.siamese.dyndns.org>
 <e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com> <18808.39712.351656.138702@hungover.brentg.com> <alpine.LNX.1.00.0901221117110.19665@iabervon.org> <alpine.DEB.1.00.0901221751320.3586@pacific.mpi-cbg.de>
 <18809.60512.654436.59819@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQQzs-00005m-5x
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 19:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbZAWSll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 13:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbZAWSlk
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 13:41:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:59391 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750974AbZAWSlj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 13:41:39 -0500
Received: (qmail invoked by alias); 23 Jan 2009 18:41:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 23 Jan 2009 19:41:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5O+Z6dEP5P0u4zBkkUXaj2gXXM9yt51ifDbKNZG
	l5r9SPvgRN8HVH
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <18809.60512.654436.59819@hungover.brentg.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106902>

Hi,

On Fri, 23 Jan 2009, Brent Goodrick wrote:

>  - Bare minimum: Add a new --no-cr option

I do not see any value of this over "--progress | tr '\r' '\n'".  (The 
--progress option being the natural counterpart to --no-progress, 
_forcing_ the display of the progress.)

And I disagree that --no-progress would be hard to implement.  Just have a 
look at 7d1864c(Introduce is_bare_repository() and core.bare configuration 
variable).

Basically, you'll have to

- introduce a global variable to both environment.c and cache.h,

- set it to -1 by default,

- handle a "--progress" and "--no-progress" option in git.c, setting the 
  global variable git_show_progress to 1 or 0, respectively,

- teach start_progress_delay() to return NULL if git_show_progress == 0,

- modify all users of start_progress*() to respect git_show_progress == 1,
  which probably means to look for "isatty" in builtin-pack-objects.c and 
  builtin-unpack-objects.c

- add documentation to Documentation/git.txt what --progress and 
  --no-progress do,

- add a simple test script to t/ (maybe t/t0005-progress.sh) that tests 
  that --progress works -- maybe you find a clever way to test 
  --no-progress, too, but that would be harder, as the progress is turned 
  off by default for the scripts anyway...)

Hth,
Dscho
