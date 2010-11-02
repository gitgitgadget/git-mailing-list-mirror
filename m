From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv7 0/6] Add commit message options for rebase
 --autosquash
Date: Tue, 2 Nov 2010 13:59:06 -0600
Message-ID: <1288727952-57498-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 20:59:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDN15-0007b2-6Q
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 20:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441Ab0KBT71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 15:59:27 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:39617 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab0KBT70 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 15:59:26 -0400
X-WSS-ID: 0LB9WUY-0C-060-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1086447FDC3
	for <git@vger.kernel.org>; Tue,  2 Nov 2010 13:59:22 -0600 (MDT)
Received: from [134.253.165.160] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 02 Nov 2010 13:59:13 -0600
X-Server-Uuid: AF72F651-81B1-4134-BA8C-A8E1A4E620FF
Received: from localhost.localdomain (134.253.98.198) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Tue, 2 Nov 2010 13:59:13 -0600
X-Mailer: git-send-email 1.7.3.2
X-TMWD-Spam-Summary: TS=20101102195917; ID=1; SEV=2.3.1;
 DFV=B2010110219; IFV=NA; AIF=B2010110219; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230312E34434430364439362E303044432C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010110219_5.03.0010
X-WSS-ID: 60CEB21B4KO1894680-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160544>

This patch series adds new command line options to git-commit to make
it easy to specify messages for commits correctly formatted for use
with 'rebase -i --autosquash'.

This iteration (v7) addresses criticisms about implementation details
raised against the v6 series.  For details, see

http://thread.gmane.org/gmane.comp.version-control.git/159547

The first patch introduces minor refactorings that set the stage
for subsequent patches, mostly preventing copy-n-paste coding in what
follows.

The second patch teaches format_commit_message to reencode the content
if the caller's commit object uses an encoding different from the
commit encoding.

The remaining patches add the --fixup and --squash commands to
git-commit including tests of commit, interactions with rebase and
i18n encodings.  

One issue which limits the testing (but not the implementation, I
think) is that when 'rebase --autosquash' is comparing commit subject
lines it does not first make sure that the commits use a common
encoding.  That's follow-on work.

Pat Notz (6):
  commit: helper methods to reduce redundant blocks of code
  pretty.c: teach format_commit_message() to reencode the output
  commit: --fixup option for use with rebase --autosquash
  add tests of commit --fixup
  commit: --squash option for use with rebase --autosquash
  add tests of commit --squash

 Documentation/git-commit.txt |   21 +++++++++--
 builtin/commit.c             |   81 ++++++++++++++++++++++++++++--------------
 builtin/log.c                |    3 +-
 builtin/mailinfo.c           |    2 +-
 cache.h                      |    3 ++
 commit.c                     |   13 +++++++
 commit.h                     |    4 ++
 environment.c                |   11 ++++++
 pretty.c                     |   36 ++++++++++++-------
 t/t3415-rebase-autosquash.sh |   29 ++++++++++++++-
 t/t3900-i18n-commit.sh       |   29 +++++++++++++++
 t/t7500-commit.sh            |   80 +++++++++++++++++++++++++++++++++++++++++
 t/t7500/edit-content         |    4 ++
 13 files changed, 267 insertions(+), 49 deletions(-)
 create mode 100755 t/t7500/edit-content

-- 
1.7.3.2
