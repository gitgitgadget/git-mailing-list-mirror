From: Thomas Rast <trast@student.ethz.ch>
Subject: Submodules or similar for exercise/exam management
Date: Thu, 18 Nov 2010 11:09:08 +0100
Message-ID: <201011181109.08345.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 18 11:09:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ1Qb-0000ar-DG
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 11:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab0KRKJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 05:09:12 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:53783 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755759Ab0KRKJL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 05:09:11 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 18 Nov
 2010 11:09:09 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 18 Nov
 2010 11:09:08 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-93-desktop; KDE/4.5.3; x86_64; ; )
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161658>

Hi all

[Jens, I was hoping you'd have some insight, but of course everyone is
welcome to join in.  I honestly never thought I'd get into the
submodule business so shortly after gittogether...]


Out of $DAYJOB issues with tracking exercises and exams, I had a
little brainstorming session with a fellow assistant yesterday.  It
seems none of this has been done before?  Is anyone else interested
(mainly in getting the requirements right so that the next poor soul
won't have to roll their own)?

The scenario is that we have a bunch of exercise questions stored in
one or several files, each living in a directory.  Then, we assemble
those into exercise sheets (super-repos) spanning a group of questions
(submodules).  We would like to track this in such a way that changes
to the questions propagate to other sheets (possibly in other
lectures) that use them.

Training everyone in full git usage is probably not an option, so any
solution would have to have some frontend that can be explained
easily.

The requirements we came up with are roughly:

1) commit across all sub-repos at the same time (atomicity nice but
   optional)

  1b) tag across all sub-repos

2) do recursive clone/update of one super-repo easily

3) never need to be aware of repo boundaries or manipulate sub-repo

4) sanely cope with branches etc. in case the user wants them

A sample workflow might be:

  foo clone git@example.com/some/super/repo
  # time passes
  cd repo
  foo update
  # work
  foo status
  foo diff
  foo commit -m 'one message fits all'
  # possibly, but this could also be commit --no-push instead
  foo push

Merges are expected to be rare but would happen every so often.

It seems repo can do (2) and (4) but violates (3) [requires use of
git-commit and others in the sub-repo].  git-subtree can do (1) and
(2) but probably violates (3) [need to rebase changes to sub-repo
branch] and (4).  Submodules can do (2) and (4) but violate (3) and
currently have no support for (1).  I think svn externals could do
(1)-(3) but violate (4) and probably (1b).

Has this been done before?  Or do we need to hack up a new wrapper
around submodules?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
