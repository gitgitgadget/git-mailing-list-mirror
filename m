From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn {show,create}-ignore chokes upon subdirs
Date: Wed, 28 May 2008 20:34:23 +1200
Message-ID: <483D190F.4030101@vilain.net>
References: <20080527162002.GA21855@penelope.zusammrottung.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org, microschulz@web.de
X-From: git-owner@vger.kernel.org Wed May 28 10:31:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1H3p-0002Nd-6o
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 10:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbYE1IaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 04:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbYE1IaM
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 04:30:12 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:55094 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbYE1IaL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 04:30:11 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 0CD9921C85C; Wed, 28 May 2008 20:30:09 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=AWL,BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.3
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 53FC321C853;
	Wed, 28 May 2008 20:29:52 +1200 (NZST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080527162002.GA21855@penelope.zusammrottung.local>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83077>

Nikolaus Schulz wrote:
> Hi, 
> 
> when importing subversion repositories into git, git-svn show-ignore and
> create-ignore choke when scanning project subdirectories.  For example,
> with the sequence
> 
>  git-svn init -s http://svn.red-bean.com/repos/producingoss producingoss-git-svn
>  cd producingoss-git-svn
>  git-svn fetch
>  git-svn create-ignore 
> 
> the last command prints this: 
> 
>  HTTP Path Not Found: PROPFIND request failed on '/repos/producingoss/!svn/bc/1465/ca': '/repos/producingoss/!svn/bc/1465/ca' path not found at /home/nikolaus/nfs/nsbp/git/git/git-svn line 1897
> 
> Revision 1465 is the latest subversion revision of the project.  git-svn
> create-ignore stages a correct .gitignore in the top level directory, then
> aborts with the same error.  I have tested this with two svn projects, the
> result is identical.  Bisecting suggested that this is broken since commit
> 01bdab84e31763a98206c31cf99b9dc3cb221356.

It helps to include the breaking change's details in the message in
reports like this.  Here it is:

From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: git-svn: add a generic tree traversal to fetch SVN properties

    * git-svn.perl (&traverse_ignore): Remove.
    (&prop_walk): New.
    (&cmd_show_ignore): Use prop_walk.

[ew: This will ease the implementation of the `create-ignore',
     `propget', and `proplist' commands]

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
Acked-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

As a side note, "svn:mergeinfo" is rapidly becoming an 'interesting'
property and should probably be added to the list.  However, I think it
probably needs to go somewhere like do_fetch; I'll follow-up separately
about that.

Sam.
