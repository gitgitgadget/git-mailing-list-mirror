From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/23] Add --all option to git-check-attr
Date: Thu,  4 Aug 2011 06:36:10 +0200
Message-ID: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:36:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopfx-0005B2-96
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837Ab1HDEgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:36:49 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39612 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1HDEgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:36:48 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHe029203;
	Thu, 4 Aug 2011 06:36:42 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178669>

This re-roll differs in the following ways from v2:

* The following series of refactoring patches were inserted:

      Teach prepare_attr_stack() to figure out dirlen itself
      Extract a function collect_all_attrs()
      Remove redundant call to bootstrap_attr_stack()
      Remove redundant check

  This change, in turn, simplifies patch

      Allow querying all attributes on a file

* The new API function is named git_all_attrs() instead of
  git_allattrs().

* Additionally, git_checkattr() is renamed to git_check_attr() at the
  suggestion of Junio.

* The renaming of struct git_attr_check to git_attr_value is no longer
  part of the patch series.

Thanks to Junio for the great feedback.  I believe that I have
addressed all of your comments.

Michael Haggerty (23):
  doc: Add a link from gitattributes(5) to git-check-attr(1)
  doc: Correct git_attr() calls in example code
  Remove anachronism from comment
  Disallow the empty string as an attribute name
  git-check-attr: Add missing "&&"
  git-check-attr: Add tests of command-line parsing
  Provide access to the name attribute of git_attr
  git-check-attr: Use git_attr_name()
  Teach prepare_attr_stack() to figure out dirlen itself
  Extract a function collect_all_attrs()
  Remove redundant call to bootstrap_attr_stack()
  Remove redundant check
  Allow querying all attributes on a file
  git-check-attr: Extract a function output_attr()
  git-check-attr: Introduce a new variable
  git-check-attr: Extract a function error_with_usage()
  git-check-attr: Handle each error separately
  git-check-attr: Process command-line args more systematically
  git-check-attr: Error out if no pathnames are specified
  git-check-attr: Add an --all option to show all attributes
  git-check-attr: Drive two tests using the same raw data
  git-check-attr: Fix command-line handling to match docs
  Rename git_checkattr() to git_check_attr()

 Documentation/git-check-attr.txt              |   23 ++++-
 Documentation/gitattributes.txt               |    3 +
 Documentation/technical/api-gitattributes.txt |   63 +++++++++-----
 archive.c                                     |    2 +-
 attr.c                                        |   79 ++++++++++++----
 attr.h                                        |   20 ++++-
 builtin/check-attr.c                          |  121 +++++++++++++++++--------
 builtin/pack-objects.c                        |    2 +-
 convert.c                                     |    2 +-
 ll-merge.c                                    |    4 +-
 t/t0003-attributes.sh                         |   61 +++++++++----
 userdiff.c                                    |    2 +-
 ws.c                                          |    2 +-
 13 files changed, 272 insertions(+), 112 deletions(-)

-- 
1.7.6.8.gd2879
