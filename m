From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 00/21] completion: __gitdir()-related improvements
Date: Thu, 25 Feb 2016 23:50:29 +0100
Message-ID: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:51:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4kq-0005RC-Cl
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbcBYWvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:51:24 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35703 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcBYWvX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:51:23 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4kb-0007uU-Fi; Thu, 25 Feb 2016 23:51:19 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440679.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287449>

Hi,

here is a big mixed bag of bugfixes, cleanups and optimizations mostly
related to how we find out the path to the repository and how we use
that path.

Noteworthier changes are the following:

  - Patch 18 shuts up error messages from git commands.  This is the
    one I mentioned some days ago[1].

  - Patches 13-16 make 'git -C <path> <cmd> <TAB>' work as it should,
    with the help of a new 'git rev-parse' option.

  - Patches 17, 19-21 get rid of a few fork()s and exec()s.
    Funfact: I submitted initial versions of patches 20-21 already in
    2012 ;) [2]

Tests pass with all 3.x and 4.x Bash versions[3].

This series is also available from:

  https://github.com/szeder/git completion-gitdir-improvements


Best,
G=C3=A1bor


[1] - http://thread.gmane.org/gmane.comp.version-control.git/286074/foc=
us=3D286078
[2] - http://thread.gmane.org/gmane.comp.version-control.git/197432/foc=
us=3D197438
[3] - In case somebody feels interested, a little proof of concept
      (with Travis CI integration!):

        https://github.com/szeder/git completion-test-multiple-bash-ver=
sions


SZEDER G=C3=A1bor (21):
  completion: improve __git_refs()'s in-code documentation
  completion tests: don't add test cruft to the test repository
  completion tests: make the $cur variable local to the test helper
    functions
  completion tests: consolidate getting path of current working
    directory
  completion tests: check __gitdir()'s output in the error cases
  completion tests: add tests for the __git_refs() helper function
  completion: ensure that the repository path given on the command line
    exists
  completion: fix most spots not respecting 'git --git-dir=3D<path>'
  completion: respect 'git --git-dir=3D<path>' when listing remote refs
  completion: list refs from remote when remote's name matches a
    directory
  completion: don't list 'HEAD' when trying refs completion outside of =
a
    repo
  completion: list short refs from a remote given as a URL
  rev-parse: add '--absolute-git-dir' option
  completion: don't offer commands when 'git --opt' needs an argument
  completion: fix completion after 'git -C <path>'
  completion: respect 'git -C <path>'
  completion: don't use __gitdir() for git commands
  completion: consolidate silencing errors from git commands
  completion: don't guard git executions with __gitdir()
  completion: extract repository discovery from __gitdir()
  completion: cache the path to the repository

 Documentation/git-rev-parse.txt        |   4 +
 builtin/rev-parse.c                    |  29 +-
 contrib/completion/git-completion.bash | 248 ++++++++++-----
 t/t1500-rev-parse.sh                   |  17 +-
 t/t9902-completion.sh                  | 560 +++++++++++++++++++++++++=
+++-----
 5 files changed, 682 insertions(+), 176 deletions(-)

--=20
2.7.2.410.g92cb358
