From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/7] Provide API to invalidate refs cache
Date: Mon, 10 Oct 2011 10:24:17 +0200
Message-ID: <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
References: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 10:24:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDBAE-0004kw-Vx
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 10:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab1JJIYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 04:24:41 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57833 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab1JJIYj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 04:24:39 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RDB4U-0004Bi-1T; Mon, 10 Oct 2011 10:18:50 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183232>

Sorry for superseding my own patch series, but I prefer this patch
series to the one that I submitted earlier today:

1. An API function deserves a more carefully-selected name:
   invalidate_ref_cache().

2. It gives me a chance to submit the first "bite" of my scalable-refs
   changes.

These patches apply on top of mh/iterate-refs, which is in next but
not in master.

This patch series provides an API for external code to invalidate the
ref cache that is used internally to refs.c.  It also allows code
*within* refs.c to invalidate only the packed or only the loose refs
for a module/submodule.

IMPORTANT:

I won't myself have time to figure out who, outside of refs.c, has to
*call* invalidate_ref_cache().  The candidates that I know off the top
of my head are git-clone, git-submodule, and git-pack-refs.  It would
be great if experts in those areas would insert calls to
invalidate_ref_cache() where needed.

Even better would be if the meddlesome code were changed to use the
refs API.  I'd be happy to help expanding the refs API if needed to
accommodate your needs.

This is why the API for invalidating only packed or loose refs is
private.  After code outside refs.c is changed to use the refs API, it
will get the optimal behavior for free (and at that time
invalidate_ref_cache() can be removed again).

Michael Haggerty (7):
  invalidate_ref_cache(): rename function from invalidate_cached_refs()
  invalidate_ref_cache(): take the submodule as parameter
  invalidate_ref_cache(): expose this function in refs API
  clear_cached_refs(): rename parameter
  clear_cached_refs(): extract two new functions
  write_ref_sha1(): only invalidate the loose ref cache
  clear_cached_refs(): inline function

 refs.c |   34 +++++++++++++++++++---------------
 refs.h |    8 ++++++++
 2 files changed, 27 insertions(+), 15 deletions(-)

-- 
1.7.7.rc2
