From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v4] generalizing sorted-array handling
Date: Mon, 29 Nov 2010 23:57:15 +0100
Message-ID: <1291071441-11808-1-git-send-email-ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 23:57:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCfI-0001U5-GE
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab0K2W5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:57:38 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:33195 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166Ab0K2W5h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 17:57:37 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 739ECD480C9
	for <git@vger.kernel.org>; Mon, 29 Nov 2010 23:57:32 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PNCf5-000354-8c
	for git@vger.kernel.org; Mon, 29 Nov 2010 23:57:31 +0100
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162441>

Changes from v3:

* this is a major rewrite, which allows the API to be used in some
  more places than the previous version.  It does not cover all
  binary-search uses, however, but it's not clear to me that trying to
  get any further would be a good use of my time (see last section
  below for details).

* based the API and implementation on the most widely used
  binary-search implementation found in the current tree, and on the
  must flexible API (the "return -lo - 1" one)

* given full control of generated function names to caller

* completely separated sorted-array typedecl from generic search/insert
  implementations, allowing several search/insert functions with
  different cmp/init callbacks

* provided several convenience wrappers around the generic
  search/insert implementations, depending on the needs of surrounding
  code

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


TODO? list:

* take binsearch desc from sha1_lookup.c

* dealloc API

* read-cache.c::index_name_pos has widely-used API with 2 low-coupled
  cmp/init params: sorted-array could be generalized at the cost of
  using stdarg, but is it worth it ?

* pack-revindex.c::find_pack_revindex is a bit special and needs more
  thought

* cache-tree.c::subtree_pos and sha1_file::find_pack_entry_one too

* sha1_lookup.c stuff probably too special
