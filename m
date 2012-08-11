From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/5] git p4: fix branch detection with --use-client-spec
Date: Sat, 11 Aug 2012 12:51:43 -0400
Message-ID: <20120811165143.GA2004@padd.com>
References: <CANWnr5aqswATTM9_Zyw=w_x01=e8CqoCsn0Ybee0XvGSJ3F_yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Korich <matthew@korich.net>
X-From: git-owner@vger.kernel.org Sat Aug 11 18:51:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Eur-0002jm-I8
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 18:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951Ab2HKQvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 12:51:47 -0400
Received: from honk.padd.com ([74.3.171.149]:38338 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583Ab2HKQvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 12:51:46 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id E87EBD27;
	Sat, 11 Aug 2012 09:51:45 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 470895A90C; Sat, 11 Aug 2012 12:51:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CANWnr5aqswATTM9_Zyw=w_x01=e8CqoCsn0Ybee0XvGSJ3F_yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203289>

matthew@korich.net wrote on Fri, 10 Aug 2012 12:14 -0700:
> Using git p4 on git version 1.7.12.rc2 has path issues. Standard
> clone/sync ops apparently place detected master and branches on
> independent and parallel directory structures instead of git branches.
> See http://stackoverflow.com/q/11893688/1588831 for a full demo of the problem.

Thank you for the detailed report.  It is a bug in 1.7.12-rc2.
This series fixes it, on top of origin/master.

The crux of the matter is that files are mapped into the wrong
locations in git when both --use-client-spec and --branch-detection
are enabled.

Pete Wyckoff (5):
  git p4 test: move client_view() function to library
  git p4 test: add broken --use-client-spec --detect-branches tests
  git p4: set self.branchPrefixes in initialization
  git p4: do wildcard decoding in stripRepoPath
  git p4: make branch detection work with --use-client-spec

 git-p4.py                     | 75 +++++++++++++++++++++++++++--------------
 t/lib-git-p4.sh               | 18 ++++++++++
 t/t9801-git-p4-branch.sh      | 77 +++++++++++++++++++++++++++++++++++++++++++
 t/t9809-git-p4-client-view.sh | 17 ----------
 4 files changed, 146 insertions(+), 41 deletions(-)

-- 
1.7.12.rc2.24.gc304662
