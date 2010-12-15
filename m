From: Jan Wielemaker <J.Wielemaker@cs.vu.nl>
Subject: Re: subdirectory-filter does not delete files before the directory
 came into existence?
Date: Wed, 15 Dec 2010 13:22:13 +0100
Organization: VU University, Amsterdam
Message-ID: <1292415733.11607.51.camel@hppc323.few.vu.nl>
References: <1292365295.6666.22.camel@ct>
	 <201012150003.30127.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 15 13:33:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSqXl-00059t-D8
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 13:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab0LOMdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 07:33:11 -0500
Received: from top.few.vu.nl ([130.37.20.4]:51830 "EHLO top.few.vu.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152Ab0LOMdK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 07:33:10 -0500
Received: from [130.37.30.3] (hppc323.few.vu.nl [130.37.30.3])
	by top.few.vu.nl with esmtp (Smail #119)
	id m1PSqXb-000019C; Wed, 15 Dec 2010 13:33:07 +0100
In-Reply-To: <201012150003.30127.trast@student.ethz.ch>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163753>

The reported problems also apply to the next module.  What appears to
work is this:

  * Walk through the history, finding the commit where the directory
  is created.
  * use git tag -l --contains <commit that created dir> to get the 
  tags we want to keep.
  * get all tags, use comm and delete the tags not in the `contained'
  set above.

Not very friendly and I'm (with Thomas) about the status of these
findings.  I like to thank Thomas for giving me the right clue.

	Regards --- Jan

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
> 
> I haven't made up my mind if this is a bug report or a feature
> request, but in any case you can delete all of them and the problem
> goes away.
> 
