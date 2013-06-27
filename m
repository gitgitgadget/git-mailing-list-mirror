From: benoit.person@ensimag.fr
Subject: [PATCH v6 0/5] git-remote-mediawiki: new tool to preview local changes without pushing
Date: Thu, 27 Jun 2013 19:37:27 +0200
Message-ID: <1372354652-4147-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 27 19:38:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsG8x-0007Gx-9l
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660Ab3F0Rhw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 13:37:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37293 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367Ab3F0Rht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 13:37:49 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5RHbeSM004142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Jun 2013 19:37:40 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5RHbgkx013088;
	Thu, 27 Jun 2013 19:37:42 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5RHbgW0007347;
	Thu, 27 Jun 2013 19:37:42 +0200
X-Mailer: git-send-email 1.8.3.GIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 27 Jun 2013 19:37:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229128>

=46rom: Benoit Person <benoit.person@ensimag.fr>

The #7 issue on git-mediawiki's issue tracker [1] states that the abili=
ty to
preview content without pushing would be a nice thing to have.

changes from v5:
  - Move git bin-wrapper 'git' into bin-wrapper/
  - Updates its GIT_ROOT_DIR accordingly
  - Updates the Makefile to use that new path in the comments

changes from v4:
  - Rebase on latest master
  - Typos in commits messages and code
  - Comments in Makefile
  - Factoring the conversion from relatives links to absolute ones in
    `git mw preview`
  - Updating that "conversion" mechanism to not convert links with an
    anchor '#'.
  - git-mw should be executable now.

changes from v3:
  - Rewrite all commit messages.
  - No more "\ No newline at end of file".
  - Rename GitMediawiki.pm into Git::Mediawiki.pm (so it moves GitMedaw=
iki.pm
    into Git/Mediawiki.pm).
  - Remove from the Makefile the copy_pm target (see below 'Add a bin-w=
rapper').
  - Use of 'install' insted of 'cp' in the Makefile.
  - Comment on the install_pm target in the Makefile.
  - Add a bin-wrapper for git to test scripts without 'make install'-in=
g them.
  - Move verbose option handling from previous v3-4/4 (introduction of =
preview
  	tool) into v4-4/5 (introduction of git-mw).
  - Refactor some code into subroutines to clean the global 'preview'
    subroutine.
  - Rewrite some error messages to make them more concise while still g=
iving
    the same amount of information.
  - Use 'remote.${remote_name}.mwIDcontent' instead of 'mediawiki.IDCon=
tent'
    as config item for the lookup ID used to combine template + new con=
tent.
  - Remove comments about what's going on in the preview subroutine.
  - Use 'clean_filename' (and not 'smudge_filename') in the preview too=
l to find
    the correct mediawiki page name based on a filename.
  - Remove space/tab mixup in the 'help' subroutine.

changes from v2:
  - Add a way to test, without installation, code that uses GitMediawik=
i.pm.
  - Move more constants to GitMediawiki.pm
  - Remove the encapsulation of Git::config calls into a git_cmd_try on=
e.
  - Remove the --blob option, distinction between files and blobs is no=
w=20
    automatic.
  - Add a --verbose option to output more information on what's going o=
n.
  - Rewrote the doc and the commit message.
  - Rewrote of the template retrieving code (see 'get_template' sub).
  - Use a configuration variable to define the content ID search in the
    template. Default value set as 'bodyContent' since it seems more st=
andard
    than 'mw-content-text'.
  - Final content is now saved as utf-8 to solve encoding issues.
  - Perlcritic changes:=20
    - Update for loops style to a more perlish one.
    - All 'print's specify their output streams.
    --> Same useless warnings left in git-remote-mediawiki.perl after c=
=C3=A9lestin's=20
        work and git-mw.perl after this patch :) .

changes from v1:
  - add new package GitMediawiki
    - move some of git-remote-mediawiki functions into the package
    - update git-remote-mediawiki to use those "moved" functions
    - add a hacky-way to install it in the Makefile
    - use it in the new git mw tool
  - add a way to give to the preview tool blobs as argument
  - add a fallback when the upstream's branch remote is not a mediawiki=
 remote
  - update the `autoload` option to use `git web--browse` and not `xdg-=
open`
  - update the way we find the upstream's branch remote name

This serie is based on the 'master' branch merged with c=C3=A9lestin's =
patch series.

[1] https://github.com/moy/Git-Mediawiki/issues/7

Benoit Person (5):
  git-remote-mediawiki: Introduction of Git::Mediawiki.pm
  git-remote-mediawiki: new git bin-wrapper for developement
  git-remote-mediawiki: factoring code between git-remote-mediawiki and
    Git::Mediawiki
  git-remote-mediawiki: Adding git-mw command
  git-remote-mediawiki: Add preview subcommand into git mw.

 contrib/mw-to-git/Git/Mediawiki.pm          | 100 ++++++++
 contrib/mw-to-git/Makefile                  |  33 ++-
 contrib/mw-to-git/bin-wrapper/git           |  27 ++
 contrib/mw-to-git/git-mw.perl               | 368 ++++++++++++++++++++=
++++++++
 contrib/mw-to-git/git-remote-mediawiki.perl |  85 +------
 5 files changed, 537 insertions(+), 76 deletions(-)
 create mode 100644 contrib/mw-to-git/Git/Mediawiki.pm
 create mode 100755 contrib/mw-to-git/bin-wrapper/git
 create mode 100755 contrib/mw-to-git/git-mw.perl

--=20
1.8.3.GIT
