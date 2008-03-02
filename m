From: Jeff King <peff@peff.net>
Subject: Re: git-rebase dirty index and email address bug?
Date: Sun, 2 Mar 2008 02:26:22 -0500
Message-ID: <20080302072622.GB3935@coredump.intra.peff.net>
References: <slrnfsjfpo.3fl.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 08:27:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVib7-0000Ir-Up
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbYCBH00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbYCBH0Z
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:26:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2856 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbYCBH0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:26:25 -0500
Received: (qmail 4125 invoked by uid 111); 2 Mar 2008 07:26:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Mar 2008 02:26:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Mar 2008 02:26:22 -0500
Content-Disposition: inline
In-Reply-To: <slrnfsjfpo.3fl.jgoerzen@katherina.lan.complete.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75737>

On Sat, Mar 01, 2008 at 02:40:24PM -0600, John Goerzen wrote:

> odd.  Today I git fetched the remote, and then I tried to git rebase
> upstream/master.  I had committed all outstanding changes first.  My
> index was clean.  It displayed:
> 
> First, rewinding head to replay your work on top of it...
> HEAD is now at 77f1a60... Merge branch 'trunk'
> Dirty index: cannot apply patches (dirty: public/dispatch.fcgi)

That seems quite strange, since git-rebase did a "git-reset --hard",
which should have cleared your index anyway. And then it runs "git
format-patch | git am", and "am" is responsible for the "Dirty index"
message. So perhaps there is something in your commit that is triggering
a bug when piped in this way.

I tried cloning the "mainline.git" repository you mentioned and doing a
few simple tests, but was unable to reproduce. Can you make available
the commits that you are trying to rebase?

> So I tried the git reset command on public/dispatch.fcgi, and also
> then deleted that file.  I then tried git-rebase --continue, which
> displayed:
> 
> sed: can't read .dotest/info: No such file or directory
> sed: can't read .dotest/info: No such file or directory
> sed: can't read .dotest/info: No such file or directory
> Patch does not have a valid e-mail address.

Hrm. I don't think it has anything to do with your email address being
invalid, but rather that we somehow failed to create the 'info' file
containing information about the commit.

> converted from an svn repo using, presumably, git-svn or
> git-svnimport.  It lies at
> git://gitorious.org/redmine-git/mainline.git
> 
> Most patches have an author like this:
> 
> Author: jplang <jplang@e93f8b46-1217-0410-a6f0-8f06a7374b81>
> 
> Could one of the git tools be trying to parse this for some odd
> reason?

No, that should parse fine. I think there is something more fundamental
going wrong.

-Peff
