From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/7] [GSoC2009] Revision cache / git-daemon caching plan
Date: Fri, 05 Jun 2009 16:58:36 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906051628530.3906@xanadu.home>
References: <cover.1244125127.git.sam@vilain.net>
 <m34ouu7h70.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org,
	Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:58:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCgV2-0003EV-KB
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbZFEU6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZFEU6n
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:58:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52412 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbZFEU6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:58:42 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKS00H9BA9OBJ90@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 05 Jun 2009 16:58:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m34ouu7h70.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120837>

On Fri, 5 Jun 2009, Jakub Narebski wrote:

> I like this sharing not only completed code, but plans, designs (and
> status reports) with Git Development Community (i.e. git mailing
> list).  I like this very much.
> 
> 
> I'd like to ask if there any results of profiling git server
> (git-daemon) code: how much is spend on object enumeration this GSoC
> project tries to make faster by the means of caching?

The git daemon only forks and execs other processes.  It is hardly using 
any measurable CPU itself.

If you want to profile or simply have a good feel for what happens 
during a clone and clearly see what phase is problematic for the server 
then do this:

 1) cd to a local repository of your choice.  The bigger the better, 
    meaning that git itself is probably too small.  Try the linux 
    kernel, or a gcc mirror, or even better yet the gentoo repository.

 2) run this:

	git pack-objects --all-progress --revs --all --stdout \
		< /dev/null > /dev/null

 3) Sit and watch.  And for extra fun you may even measure the time 
    spent in each of the "counting objects", "compressing objects" and
    "writing objects" phases and compare them.


Nicolas
