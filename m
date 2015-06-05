From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/4] Fix file locking with retry and timeout on Windows
Date: Fri,  5 Jun 2015 21:45:03 +0200
Message-ID: <cover.1433532967.git.j6t@kdbg.org>
References: <55700F10.8030806@kdbg.org>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:46:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xYo-0007ni-NA
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbbFETpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:45:42 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:12338 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751444AbbFETpl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:45:41 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3m3Dwf3nV4z5tlD;
	Fri,  5 Jun 2015 21:45:38 +0200 (CEST)
Received: from dx.lan (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id E37BB1D0;
	Fri,  5 Jun 2015 21:45:37 +0200 (CEST)
X-Mailer: git-send-email 2.3.2.245.gb5bf9d3
In-Reply-To: <55700F10.8030806@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270881>

The first patch is the same that I posted earlier. It fixes a build
failure on Windows on master due to missing random/srandom.

The remaining 3 patches replace the select() invocation that waits
for a short time period by the version with poll() that we already
use in help.c. This is necessary because a select() call where all
three sets of file descriptors are empty is not supported on Windows.

Johannes Sixt (4):
  lockfile: replace random() by rand()
  help.c: wrap wait-only poll() invocation in sleep_millisec()
  lockfile: convert retry timeout computations to millisecond
  lockfile: wait using sleep_millisec() instead of select()

 cache.h    |  1 +
 help.c     |  2 +-
 lockfile.c | 31 +++++++++----------------------
 wrapper.c  |  5 +++++
 4 files changed, 16 insertions(+), 23 deletions(-)

-- 
2.3.2.245.gb5bf9d3
