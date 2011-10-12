From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/7] Provide API to invalidate refs cache
Date: Wed, 12 Oct 2011 20:44:20 +0200
Message-ID: <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:50:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3sU-0006Yt-3F
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab1JLStl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:49:41 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:58194 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980Ab1JLStj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:49:39 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RE3mL-0008JO-Me; Wed, 12 Oct 2011 20:43:45 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183394>

These patches are re-rolled onto master.

This patch series provides an API for external code to invalidate the
ref cache that is used internally to refs.c.  It also allows code
*within* refs.c to invalidate only the packed or only the loose refs
for a module/submodule.

IMPORTANT:

I won't myself have time to figure out who, outside of refs.c, has to
*call* invalidate_ref_cache().  The candidates that I know off the top
of my head are git-clone, git-submodule [1], and git-pack-refs.  It
would be great if experts in those areas would insert calls to
invalidate_ref_cache() where needed.

Even better would be if the meddlesome code were changed to use the
refs API.  I'd be happy to help expanding the refs API if needed to
accommodate your needs.

This is why the API for invalidating only packed or loose refs is
private.  After code outside refs.c is changed to use the refs API, it
will get the optimal behavior for free (and at that time
invalidate_ref_cache() can be removed again).

[1] http://marc.info/?l=git&m=131827641227965&w=2
    In this mailing list thread, Heiko Voigt stated that git-submodule
    does not modify any references, so it should not have to use the
    API.

Michael Haggerty (7):
  invalidate_ref_cache(): rename function from invalidate_cached_refs()
  invalidate_ref_cache(): take the submodule as parameter
  invalidate_ref_cache(): expose this function in refs API
  clear_cached_refs(): rename parameter
  clear_cached_refs(): extract two new functions
  write_ref_sha1(): only invalidate the loose ref cache
  clear_cached_refs(): inline function

 refs.c |   31 +++++++++++++++++--------------
 refs.h |    8 ++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)

-- 
1.7.7.rc2
