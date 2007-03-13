From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 13 Mar 2007 18:43:04 +0100
Message-ID: <20070313174304.GA2540@moooo.ath.cx>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net> <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net> <7v7itx5mep.fsf@assigned-by-dhcp.cox.net> <7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 18:43:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRB2L-0002Hc-Ux
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 18:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbXCMRnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 13:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbXCMRnK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 13:43:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:53801 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752593AbXCMRnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 13:43:09 -0400
Received: (qmail invoked by alias); 13 Mar 2007 17:43:06 -0000
Received: from pD9EBB63A.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.182.58]
  by mail.gmx.net (mp018) with SMTP; 13 Mar 2007 18:43:06 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18JNqhKEUIJGm+XLg2wrcSF5LDfhQP4NpQH+SUXyy
	U/c46P6TVj7/t6
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42140>

Junio C Hamano <junkio@cox.net> wrote:
> * ml/workdir (Sun Mar 11 22:29:06 2007 +0100) 3 commits
>  - use $GIT_DIR/workdir as working directory with $GIT_DIR
>  - introduce GIT_WORK_DIR environment variable
>  - rev-parse: --is-bare-repository option
> 
> Not in 'next' yet, but I think this one is ready to be tested.
> We need testsuite for it before that happens, though.

Will you apply the git-init patch too?

I did not write any tests yet, but I can try.

Here is what I thought about:

check that --work-dir overrides $GIT_WORK_DIR and both override
$GIT_DIR/workdir.

use a correct and an invalid path for:
    $GIT_DIR/workdir:
        file containing a relative and an absolute path
        symlink pointing to an invalid path, a directory, a file
        test a symlink to something else (e.g. device, fifo, ..) too?
        directory
    $GIT_WORK_DIR: relative and absolute path
    and test what git does with git-rev-parse
            --is-bare-repository
            --show-prefix
            --show-cdup

test git rev-parse --is-inside-git-dir

A symlink pointing to an invalid path is currently handled as if there
is no $GIT_DIR/workdir at all because stat returns ENOENT.  Is this ok
or should git complain like it does for an invalid path when
$GIT_DIR/workdir is a file?  We could also decide to ignore all
invalid workdir settings and handle this the same as being outside the
workdir.
