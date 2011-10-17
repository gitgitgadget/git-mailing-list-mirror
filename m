From: mhagger@alum.mit.edu
Subject: [PATCH v2 00/14] Tidying up references code
Date: Mon, 17 Oct 2011 09:39:09 +0200
Message-ID: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:39:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhnW-0007hN-NX
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913Ab1JQHjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:39:41 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33560 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab1JQHji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:39:38 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhR-0000eM-4P; Mon, 17 Oct 2011 09:33:29 +0200
X-Mailer: git-send-email 1.7.7.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183774>

From: Michael Haggerty <mhagger@alum.mit.edu>

Patch series re-rolled against v4 of "Provide API to invalidate refs
cache", with the following additional changes to address Junio's
comments (thanks!):

* Tweaked the comments for git_path() and git_path_submodule().

* Several (clerical!) fixes to comments and log messages that still
  referred to "ref_list".

* Clarified log message for patch "refs: rename parameters result ->
  sha1".

* Improved comment for resolve_gitlink_ref().

I also moved patch "resolve_gitlink_ref(): improve docstring" later in
the patch series to put it closer to other changes to that area of the
code.

BTW, whenever I add comments to existing code, it is just an attempt
to record information that I have inferred from reverse-engineering.
My belief is that even a phenomenological description of the behavior
of a function is usually better than nothing (which is often the
status quo).  But I will be delighted if somebody improves/rewrites
the comments to be more insightful or simply more consistent with the
terminology used elsewhere.

Original description of patch series:

This is the next installment of the reference changes that I have been
working on.  This batch includes a lot of tidying up in preparation
for the real changes.

The last few patches have a little bit of meat on them.  They start
changing the innards of refs.c to work less with strings and more with
objects.  This work will continue in later patches with the ultimate
goal of swapping the data structure used to store cached references
out from under the module--changing it from a sorted array of pointers
into a hierarchical tree shaped like the reference namespace
tree.

Michael Haggerty (14):
  cache.h: add comments for git_path() and git_path_submodule()
  struct ref_entry: document name member
  refs: rename "refname" variables
  refs: rename parameters result -> sha1
  clear_ref_array(): rename from free_ref_array()
  is_refname_available(): remove the "quiet" argument
  parse_ref_line(): add docstring
  add_ref(): add docstring
  is_dup_ref(): extract function from sort_ref_array()
  refs: change signatures of get_packed_refs() and get_loose_refs()
  get_ref_dir(): change signature
  resolve_gitlink_ref(): improve docstring
  Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
  resolve_gitlink_ref_recursive(): change to work with struct ref_cache

 cache.h |   18 +++
 refs.c  |  416 +++++++++++++++++++++++++++++++++-----------------------------
 refs.h  |   34 +++--
 3 files changed, 260 insertions(+), 208 deletions(-)

-- 
1.7.7.rc2
