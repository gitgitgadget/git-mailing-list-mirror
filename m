From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/19] Add --all option to git-check-attr
Date: Thu, 28 Jul 2011 06:46:39 +0200
Message-ID: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 28 06:47:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIVI-0005XC-NY
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab1G1ErU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:47:20 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57244 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab1G1ErT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:47:19 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmIT5-000889-Vw; Thu, 28 Jul 2011 06:45:07 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178015>

This version of the patch series fixes a formatting problem found by
Junio and mentions in the documentation that "-a" means the same as
"--all".

Currently it is possible to inquire the values of particular
attributes on particular files, using either the API function
git_checkattr() or the command "git check-attr".  But it is not
possible to ask for *all* attributes that are associated with a
particular file.  This patch series adds that functionality:

* A new API call git_allattr()

* A new option "git check-attr --all -- pathnames"

Along the way, several small cleanups are made in the general
neighborhood, including:

* Disallow the empty string as an attribute name

* Provide access to the name attribute of git_attr

* Fail with an error message if no pathnames are provided on the
  command line (and --stdin is not used)

* If --stdin is used, interpret all command-line arguments as
  attribute names

* Rename struct git_attr_check to git_attr_value

Most of the patches are hopefully self-explanatory; see the individual
patch emails for discussion of changes that might potentially be
controversial.

Michael Haggerty (19):
  doc: Add a link from gitattributes(5) to git-check-attr(1)
  doc: Correct git_attr() calls in example code
  Remove anachronism from comment
  Disallow the empty string as an attribute name
  git-check-attr: Add missing "&&"
  git-check-attr: Add tests of command-line parsing
  Provide access to the name attribute of git_attr
  git-check-attr: Use git_attr_name()
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
  Rename struct git_attr_check to git_attr_value

 Documentation/git-check-attr.txt              |   23 ++++-
 Documentation/gitattributes.txt               |    3 +
 Documentation/technical/api-gitattributes.txt |   66 +++++++++-----
 archive.c                                     |    4 +-
 attr.c                                        |   62 +++++++++++--
 attr.h                                        |   24 ++++-
 builtin/check-attr.c                          |  123 ++++++++++++++++--------
 builtin/pack-objects.c                        |    4 +-
 convert.c                                     |   10 +-
 ll-merge.c                                    |    6 +-
 t/t0003-attributes.sh                         |   61 +++++++++----
 userdiff.c                                    |    2 +-
 ws.c                                          |    4 +-
 13 files changed, 279 insertions(+), 113 deletions(-)

-- 
1.7.6.8.gd2879
