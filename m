From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: multiple working directories for long-running builds (was:
	"git merge" merges too much!)
Date: Tue, 1 Dec 2009 16:25:26 -0600
Message-ID: <20091201222526.GB1926@unpythonic.net>
References: <m1NEaLp-000kn1C@most.weird.com> <7vskbxewti.fsf@alter.siamese.dyndns.org> <m1NFBAx-000kmgC@most.weird.com> <20091130211744.GA27278@dpotapov.dyndns.org> <m1NFGXS-000kn2C@most.weird.com> <20091201054734.GB11235@dpotapov.dyndns.org> <m1NFX19-000kn4C@most.weird.com> <20091201185114.GC11235@dpotapov.dyndns.org> <m1NFXvL-000kn2C@most.weird.com> <20091201211830.GE11235@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 23:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFbAG-0003co-WB
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 23:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbZLAWZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 17:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbZLAWZd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 17:25:33 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:57680 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753141AbZLAWZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 17:25:33 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id DE3831148EA; Tue,  1 Dec 2009 16:25:26 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20091201211830.GE11235@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134262>

On Wed, Dec 02, 2009 at 12:18:30AM +0300, Dmitry Potapov wrote:
> AFAIK, "git archive" is cheaper than git clone. I do not say it is fast
> for huge project, but if you want to run a process such as clean build
> and test that takes a long time anyway, it does not add much to the
> total time.

If you want to keep a separate copy of your source tree in order to get
consistent builds, "git archive" is not much cheaper in disk space or in
time, at least on this unix system:

$ find orig -exec md5sum {} + > /dev/null 2>&1 # ensure hot cache
$ time git clone orig temp-clone
Initialized empty Git repository in
/usr/local/jepler/src/temp-clone/.git/
0.6 real 0.3 user 0.6 system
$ time (GIT_DIR=orig/.git git archive --format tar --prefix temp-archive/ HEAD | tar xf -)
0.5 real 0.2 user 0.5 system
$ du -s orig temp-clone temp-archive
41880   orig
14640   temp-clone  # du excludes files already accounted for by 'orig'
14304   temp-archive

.. and the next run to bring temp-clone up to date can be even faster,
since it's just 'git pull' and will only touch changed files.

Jeff
