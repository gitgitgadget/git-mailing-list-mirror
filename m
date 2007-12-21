From: Gerrit Pape <pape@smarden.org>
Subject: Re: unexpected git-cherry-pick conflict
Date: Fri, 21 Dec 2007 10:37:43 +0000
Message-ID: <20071221103743.2210.qmail@80f7ec9d6d380d.315fe32.mid.smarden.org>
References: <20070405071615.2915.6837.reportbug@acer> <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org> <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com> <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org> <Pine.LNX.4.64.0706131354250.4059@racer.site> <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org> <Pine.LNX.4.64.0706131543140.4059@racer.site> <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org> <Pine.LNX.4.64.0707071949440.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 21 11:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5fGH-0005hD-PG
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 11:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbXLUKh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 05:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbXLUKh0
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 05:37:26 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:59523 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750920AbXLUKh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 05:37:26 -0500
Received: (qmail 2211 invoked by uid 1000); 21 Dec 2007 10:37:43 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707071949440.4093@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69052>

On Sat, Jul 07, 2007 at 09:58:08PM +0100, Johannes Schindelin wrote:
> On Mon, 25 Jun 2007, Gerrit Pape wrote:
> > Hi, did you get to this yet?, not to stress you, just to make sure we 
> > don't forget about it.
> 
> Okay. Since now both you and Junio asked for it, and I made today a Git 
> day for me, I looked into this.

Hi, the discussion on this topic unfortunately didn't result in a patch.
The problem is still true with current master, here's again how to
reproduce it

 $ mkdir repo && cd repo
 $ git init
 Initialized empty Git repository in .git/
 $ echo foo >file
 $ ln -s dangling link
 $ git add .
 $ git commit -mfoo
 Created initial commit c6a9189: foo
  2 files changed, 2 insertions(+), 0 deletions(-)
  create mode 100644 file
  create mode 120000 link
 $ git checkout -b branch
 Switched to a new branch "branch"
 $ git rm link
 rm 'link'
 $ git commit -mremovelink
 Created commit 2c60f15: removelink
  1 files changed, 0 insertions(+), 1 deletions(-)
  delete mode 120000 link
 $ mkdir link
 $ echo bar >link/file
 $ git add link
 $ git commit -m adddir
 Created commit d3b30b5: adddir
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 link/file
 $ echo bar >>file
 $ git commit -mfile file
 Created commit 8ddc4d5: file
  1 files changed, 1 insertions(+), 0 deletions(-)
 $ git checkout master
 Switched to branch "master"
 $ git cherry-pick 8ddc4d5
 CONFLICT (file/directory): There is a directory with name link in
 8ddc4d5... file. Added link as link~HEAD
 Automatic cherry-pick failed.  After resolving the conflicts,
 mark the corrected paths with 'git-add <paths>'
 and commit the result.
 When commiting, use the option '-c 8ddc4d5' to retain authorship and
 message.
 $ 

Thanks, Gerrit.
