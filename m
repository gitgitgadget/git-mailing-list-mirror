From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v6] generalizing sorted-array handling
Date: Wed,  8 Dec 2010 23:51:29 +0100
Message-ID: <1291848695-24601-1-git-send-email-ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 23:51:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQSrU-0002uD-QK
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100Ab0LHWvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 17:51:46 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:49422 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087Ab0LHWvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 17:51:45 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 216F5D48028
	for <git@vger.kernel.org>; Wed,  8 Dec 2010 23:51:39 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PQSrK-0006Pg-Tv
	for git@vger.kernel.org; Wed, 08 Dec 2010 23:51:38 +0100
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163231>

I hope the improvements to the usage syntax in this version would help
to get more feedback.  I don't plan to do much more structural work on
this, unless reviewers complain.  I want to get my focus back to
bulk-rename/builk-rm patches, which will make heavy use of this API.

Changes from v5:

* moved doc to Documentation/api-sorted-array.txt as suggested by
  Jonathan Nieder, made it a bit more comprehensive as well.

* changed API with:
  * renamed low-level wrapper-decl macros with a leading underscore
  * provide high-level wrapper-decl macros for everyday use, which
    declare the required generic funcs for use (as static funcs)

Those high-level macros make the entry points more numerousas
previously noted, but we gain much in usage clarity, as well as
consistent API (no more argument differences between macros of a
single level)

By using those macros we lose the control we had on all the
intermediate funcs, but that should not be much of a problem.


Notes on current API:

* The macro names are a bit heavy-weight.  Better ideas welcome.

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
