From: Jan Wielemaker <J.Wielemaker@cs.vu.nl>
Subject: Re: subdirectory-filter does not delete files before the directory
 came into existence?
Date: Wed, 15 Dec 2010 10:50:42 +0100
Organization: VU University, Amsterdam
Message-ID: <1292406642.11607.37.camel@hppc323.few.vu.nl>
References: <1292365295.6666.22.camel@ct>
	 <201012150003.30127.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 15 11:14:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSoNC-0006Hr-VF
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 11:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab0LOKOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 05:14:09 -0500
Received: from top.few.vu.nl ([130.37.20.4]:44097 "EHLO top.few.vu.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266Ab0LOKOI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 05:14:08 -0500
X-Greylist: delayed 748 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2010 05:14:08 EST
Received: from [130.37.30.3] (hppc323.few.vu.nl [130.37.30.3])
	by top.few.vu.nl with esmtp (Smail #119)
	id m1PSoAw-00001vC; Wed, 15 Dec 2010 11:01:34 +0100
In-Reply-To: <201012150003.30127.trast@student.ethz.ch>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163751>

Dear Thomas,

On Wed, 2010-12-15 at 00:03 +0100, Thomas Rast wrote:
> Jan Wielemaker wrote:
> > I try to extract a directory.  The result is fine, but there is a lot
> > of history in the result from *before* the directory was added to the
> > project.  Why?  How can I get rid of this?
> [...]
> > Now use e.g. qgit to look at the history.  As from 03/07/2002, when
> > the packages/odbc directory was created, all looks just fine.  Before
> > though ...
> 
> That history is not connected to the filtered one.  git-filter-branch
> alerts you to it with messages like
> 
>   WARNING: Ref 'refs/tags/V5.0.4' is unchanged
>   WARNING: Ref 'refs/tags/V5.0.5' is unchanged
>   WARNING: Ref 'refs/tags/V5.0.6' is unchanged
>   WARNING: Ref 'refs/tags/V5.0.7' is unchanged

Thanks for the insight.  Catching these errors and running git tag -d on
them gets me a nice and clean history.  Only ...  It starts in
12/08/2008 instead of 03/07/2002.  This is (almost) compatible with the
filtering feedback that says it rewrote 174 commits.  The filtered and
cleaned history contains 171.

This is a bit odd.  If I open qgit on the original (before filtering)
and show the history of odbc.c, it looks like a nice and continuous
one going back to 2002.  Also

   git log --oneline packages/odbc/odbc.c

shows a history that starts with "First public version of ODBC
interface"

Of course, this is a project with a long history that was converted
from CVS, but the history looks unbroken, so why does filtering a
directory breaks it?

> I haven't made up my mind if this is a bug report or a feature
> request, but in any case you can delete all of them and the problem
> goes away.

Isn't it true that you will have info from before introducing a
directory whenever there are tags that are older than the directory?
If that is the case, it looks wrong to me.  I want to filter the 
directory, so the repository from before the existence of the 
directory is not interesting.  Of course, things change if the
directory was created by renaming files that where already in
the repository.  I don't know what one should `expect' in that
case.  Here, the directory was added from new files, so it is
quite clear what one should expect.

	Regards --- Jan
