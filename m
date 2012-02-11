From: mhagger@alum.mit.edu
Subject: [PATCH 0/7] Make alternates affect fetch behavior
Date: Sat, 11 Feb 2012 07:20:54 +0100
Message-ID: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 07:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw6L7-0001rt-BA
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 07:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab2BKGVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 01:21:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50474 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2BKGVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 01:21:23 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED675.dip.t-dialin.net [84.190.214.117])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B6L6CA019131;
	Sat, 11 Feb 2012 07:21:06 +0100
X-Mailer: git-send-email 1.7.9
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190488>

From: Michael Haggerty <mhagger@alum.mit.edu>

It used to be that alternate references were not considered "complete"
when fetching via fetch-pack.  This failure was not so obvious because
the big benefit of alternates is seen when cloning, and clone used a
different data path: it put the alternate references into extra refs
(which makes them look like references within the local repository).

This patch series teaches fetch-pack to treat objects that are
available via alternates as "complete".

Once that is fixed, clone doesn't need to use the special extra_refs
kludge, so change that.

And once that is changed, the extra_refs API is no longer needed at
all, so remove it.

Michael Haggerty (7):
  t5700: document a failure of alternates to affect fetch
  clone.c: move more code into the "if (refs)" conditional
  fetch-pack.c: rename some parameters from "path" to "refname"
  fetch-pack.c: inline insert_alternate_refs()
  everything_local(): mark alternate refs as complete
  clone: do not add alternate references to extra_refs
  refs: remove the extra_refs API

 builtin/clone.c            |   51 +++++++++++++++++--------------------------
 builtin/fetch-pack.c       |   23 ++++++++++---------
 refs.c                     |   23 +-------------------
 refs.h                     |    8 -------
 t/t5700-clone-reference.sh |   34 ++++++++++++++++++++++++++--
 5 files changed, 64 insertions(+), 75 deletions(-)

-- 
1.7.9
