From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.6.3
Date: Sun, 13 Jul 2008 20:13:05 -0700
Message-ID: <7v1w1xma4e.fsf@gitster.siamese.dyndns.org>
References: <7vy74fo9t4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 05:14:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIEW3-00048h-Pz
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 05:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbYGNDNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 23:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbYGNDNP
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 23:13:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbYGNDNO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 23:13:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C28D22A070;
	Sun, 13 Jul 2008 23:13:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E840C2A06D; Sun, 13 Jul 2008 23:13:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CBB5D3F0-5152-11DD-AE06-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88371>

The latest maintenance release GIT 1.5.6.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.6.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.5.6.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.6.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.  As the machine I cut them at kernel.org has been updated to FC9
recently, their filenames now have "fc9" in them.

  RPMS/$arch/git-*-1.5.6.3-1.fc9.$arch.rpm	(RPM)

The changes since the previous maintenance release is getting smaller.
About half the diff is in Documentation/ section.

 Documentation/RelNotes-1.5.6.3.txt     |   52 ++++++++++++++++++++++++++++++++
 Documentation/git-cvsimport.txt        |    6 ++++
 Documentation/git-cvsserver.txt        |    3 ++
 Documentation/git-mailinfo.txt         |    5 ++-
 Documentation/git-rev-parse.txt        |    4 +-
 Documentation/git.txt                  |    3 +-
 Documentation/gitattributes.txt        |   33 ++++++++++----------
 Documentation/gitcvs-migration.txt     |    5 +++
 Documentation/pretty-formats.txt       |    8 ++--
 RelNotes                               |    2 +-
 builtin-clone.c                        |    8 +++--
 builtin-commit.c                       |   11 ++----
 builtin-log.c                          |   16 ++-------
 builtin-mailinfo.c                     |    3 +-
 builtin-send-pack.c                    |    3 +-
 builtin-tag.c                          |    2 +-
 contrib/completion/git-completion.bash |   30 ++++++++++++++++++
 convert.c                              |   25 +++++----------
 diff.c                                 |    8 +----
 git-am.sh                              |    3 +-
 git-submodule.sh                       |    3 +-
 git-svn.perl                           |    2 +
 http.c                                 |   36 +++++++--------------
 path.c                                 |    2 +-
 read-cache.c                           |   16 ++++++++++
 refs.c                                 |    2 +-
 run-command.c                          |    2 +
 t/t0004-unwritable.sh                  |   19 ++++++-----
 t/t1301-shared-repo.sh                 |   23 ++++++++++++++
 t/t5404-tracking-branches.sh           |    7 ++++
 t/t5601-clone.sh                       |   20 +++++++++++-
 transport.c                            |    4 ++-
 32 files changed, 253 insertions(+), 113 deletions(-)

----------------------------------------------------------------

GIT v1.5.6.3 Release Notes
==========================

Fixes since v1.5.6.2
--------------------

* Setting core.sharerepository to traditional "true" value was supposed to make
  the repository group writable but should not affect permission for others.
  However, since 1.5.6, it was broken to drop permission for others when umask is
  022, making the repository unreadable by others.

* Setting GIT_TRACE will report spawning of external process via run_command().

* Using an object with very deep delta chain pinned memory needed for extracting
  intermediate base objects unnecessarily long, leading to excess memory usage.

* Bash completion script did not notice '--' marker on the command
  line and tried the relatively slow "ref completion" even when
  completing arguments after one.

* Registering a non-empty blob racily and then truncating the working
  tree file for it confused "racy-git avoidance" logic into thinking
  that the path is now unchanged.

* The section that describes attributes related to git-archive were placed
  in a wrong place in the gitattributes(5) manual page.

* "git am" was not helpful to the users when it detected that the committer
  information is not set up properly yet.

* "git clone" had a leftover debugging fprintf().

* "git clone -q" was not quiet enough as it used to and gave object count
  and progress reports.

* "git clone" marked downloaded packfile with .keep; this could be a
  good thing if the remote side is well packed but otherwise not,
  especially for a project that is not really big.

* "git daemon" used to call syslog() from a signal handler, which
  could raise signals of its own but generally is not reentrant.  This
  was fixed by restructuring the code to report syslog() after the handler
  returns.

* When "git push" tries to remove a remote ref, and corresponding
  tracking ref is missing, we used to report error (i.e. failure to
  remove something that does not exist).

* "git mailinfo" (hence "git am") did not handle commit log messages in a
  MIME multipart mail correctly.

Contains other various documentation fixes.
