From: John Koleszar <john.koleszar@on2.com>
Subject: Re: git-svn: importing internal externals
Date: Fri, 29 May 2009 17:05:19 -0400
Organization: On2 Technologies
Message-ID: <1243631119.6276.46.camel@cp-jk-linux.corp.on2.com>
References: <1243443089.3192.43.camel@cp-jk-linux.corp.on2.com>
	 <20090528112542.GA24403@nan92-1-81-57-214-146.fbx.proxad.net>
Reply-To: john.koleszar@on2.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri May 29 23:05:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA9Gt-0004bz-7X
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 23:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbZE2VFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 17:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbZE2VFh
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 17:05:37 -0400
Received: from mail.on2.com ([66.162.65.131]:53516 "EHLO on2.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751346AbZE2VFh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 17:05:37 -0400
In-Reply-To: <20090528112542.GA24403@nan92-1-81-57-214-146.fbx.proxad.net>
X-Mailer: Evolution 2.24.5 
X-On2-MailScanner-i: Found to be clean
X-On2-MailScanner-From: john.koleszar@on2.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120316>

On Thu, 2009-05-28 at 07:25 -0400, Yann Dirson wrote:
> On Wed, May 27, 2009 at 12:51:29PM -0400, John Koleszar wrote:
> > Hi,
> > 
> > I'm working on a one-off import of an SVN repo that makes use of
> > "internal" svn:externals; i.e. all URLs refer to different spots in the
> > same repo, potentially with peg revisions. The SVN repo holds a number
> > of projects, and my plan is to import them into individual git repos,
> > incorporating the history from any svn:external linked sub-projects.
> 
[...]
> It can be a good idea to share your script nevertheless :)
> 

I hacked on this some more and got something pretty usable (for me). It
operates on a git-svn clone of the whole repository, propagates commits
to different paths if referenced by an external, rearranges the tree to
isolate each svn branch on its own head, reparents the branches to their
proper branch points, and converts any tags branches to real git tags.

Don't know what the netequitte is on this list regarding attachments for
this sort of thing, so I posted it here:
http://github.com/jkoleszar/git-svn-internal-externals/tree/master

It's not as fast as I'd like, but it's workable, at least for small
repositories. Bottleneck seems to be git-update-index (100s of ms/call)
but I haven't looked into it too much. I'm sure I could be smarter in
some of my pipelines too. Some numbers (2246 revisions, ~15k files,
Core2 6600 @ 2.4GHz, tmpfs):

git-svn fetch:
197.03user 174.63system 22:36.59elapsed 27%CPU (0avgtext+0avgdata
0maxresident)k 0inputs+0outputs (0major+35448577minor)pagefaults 0swaps

propagating externals:
1381.29user 744.42system 34:28.67elapsed 102%CPU (0avgtext+0avgdata
0maxresident)k 0inputs+0outputs (2major+305234667minor)pagefaults 0swaps

rearranging heads:
46.13user 64.23system 1:52.42elapsed 98%CPU (0avgtext+0avgdata
0maxresident)k 0inputs+0outputs (4major+28752709minor)pagefaults 0swaps

reparenting branches:
151.52user 263.50system 6:19.54elapsed 109%CPU (0avgtext+0avgdata
0maxresident)k 0inputs+0outputs (2major+135830914minor)pagefaults 0swaps

Hope this is useful for someone!

John
