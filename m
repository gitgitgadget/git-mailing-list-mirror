From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv5 0/8] Add commit message options for rebase
 --autosquash
Date: Thu, 7 Oct 2010 13:10:49 -0600
Message-ID: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 21:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vsF-0005gv-EE
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab0JGTLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 15:11:19 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:35368 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab0JGTLP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 15:11:15 -0400
X-WSS-ID: 0L9XPAM-0C-C7B-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1F2CE532768
	for <git@vger.kernel.org>; Thu,  7 Oct 2010 13:11:10 -0600 (MDT)
Received: from [134.253.165.160] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 07 Oct 2010 13:10:59 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from sacv8030nk.sandia.gov (134.253.116.144) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 7 Oct 2010 13:10:58 -0600
X-Mailer: git-send-email 1.7.3.1
X-TMWD-Spam-Summary: TS=20101007191103; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230332E34434145314234362E303046352C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 60B0C4C92JS4401078-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158438>

This patch series adds new command line options to git-commit to make
it easy to specify messages for commits correctly formatted for use
wit 'rebase -i --autosquash'.

The first three patches introduce minor refactorings that set the stage
for subsequent patches.

The fourth patch teaches format_commit_message to reencode the content
if the caller's commit object uses an encoding different from the
commit encoding.

The remaining patches add the --fixup and --squash commands to
git-commit including tests of commit, interactions with rebase and
i18n encodings.  

One issue which limits the testing (but not the implementation, I
think) is that when 'rebase --autosquash' is comparing commit subject
lines it does not first make sure that the commits use a common
encoding.  That's follow-on work.

Pat Notz (8):
  commit.c: prefer get_header() to manual searching
  commit.c: new function for looking up a comit by name
  pretty.c: helper methods for getting output encodings
  pretty.c: teach format_commit_message() to reencode the output
  commit: --fixup option for use with rebase --autosquash
  add tests of commit --fixup
  commit: --squash option for use with rebase --autosquash
  add tests of commit --squash

 Documentation/git-commit.txt |   21 +++++++++--
 archive.c                    |    2 +-
 builtin/commit.c             |   76 +++++++++++++++++++++++++++------------
 builtin/fmt-merge-msg.c      |    2 +-
 cache.h                      |    3 ++
 commit.c                     |   13 +++++++
 commit.h                     |    5 ++-
 environment.c                |   11 ++++++
 log-tree.c                   |    2 +-
 notes-cache.c                |    2 +-
 pretty.c                     |   47 +++++++++++++++++++-----
 submodule.c                  |    4 +-
 t/t3415-rebase-autosquash.sh |   29 ++++++++++++++-
 t/t3900-i18n-commit.sh       |   28 +++++++++++++++
 t/t7500-commit.sh            |   80 ++++++++++++++++++++++++++++++++++++++++++
 t/t7500/edit-content         |    4 ++
 16 files changed, 283 insertions(+), 46 deletions(-)
 create mode 100755 t/t7500/edit-content

-- 
1.7.3.1
