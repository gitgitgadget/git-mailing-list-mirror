From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v5] generalizing sorted-array handling
Date: Sun,  5 Dec 2010 11:34:01 +0100
Message-ID: <1291545247-4151-1-git-send-email-ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 05 11:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPBvb-0002k7-GE
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 11:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab0LEKeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 05:34:25 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:40097 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab0LEKeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 05:34:24 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 991ACD4812B
	for <git@vger.kernel.org>; Sun,  5 Dec 2010 11:34:19 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PPBv8-00015t-E6
	for git@vger.kernel.org; Sun, 05 Dec 2010 11:34:18 +0100
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162935>

Changes from v4:

* better API documentation (was previously lacking or plain obsolete)
* added one more wrapper (used by yet-to-be-resent bulk-* series

Notes on current API:

* The macro names are a bit heavy-weight.  Better ideas welcome.

* This API is very verbose, and I'm not happy with that aspect.

It could be made less so, eg. causing insert wrappers to auto-declare
the required generic insert func, and causing the latter auto-declare
the required generic search func.  That would cause duplication of the
generic search func in many cases.

The duplication problem would not be an issue if we add an automatic
call to declare_gen_sorted_insert() in declare_sorted_array_insert_*,
but we would loose the symetry with the search API.

Adding "simple" API variants that would call all the necessary stuff
would help code readability, but adding yet more entry points seems a
dubious approach.

Or is that just the "use cpp for templating" just inadequate here ?

* could gain a dealloc API, to minimize the explicit use of the _nr
  and _alloc vars


The following binary-search occurences were not converted:

* read-cache.c::index_name_pos has widely-used API with 2 low-coupled
  cmp/init params: sorted-array could be generalized at the cost of
  using stdarg, but is it worth it ?

* pack-revindex.c::find_pack_revindex is a bit special and needs more
  thought

* cache-tree.c::subtree_pos and sha1_file::find_pack_entry_one too

* sha1_lookup.c stuff probably too special
