From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv6 0/6] Add commit message options for rebase
 --autosquash
Date: Thu, 21 Oct 2010 13:33:51 -0600
Message-ID: <1287689637-95301-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 21:34:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90u4-0002WW-DA
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469Ab0JUTeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 15:34:14 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:58709 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab0JUTeM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 15:34:12 -0400
X-WSS-ID: 0LANNOU-0C-20F-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 15CA14DDD2A
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:34:06 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 21 Oct 2010 13:33:56 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o9LJXiYs018943 for
 <git@vger.kernel.org>; Thu, 21 Oct 2010 13:33:47 -0600
Received: from sacv8030mq.sandia.gov (134.253.116.124) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 21 Oct 2010 13:33:54 -0600
X-Mailer: git-send-email 1.7.3.1
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.10.21.192418
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_2000_2999 0,
 BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DATE_TZ_NA 0, __CT 0,
 __CT_TEXT_PLAIN 0, __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0,
 __FROM_GMAIL 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0,
 __TO_MALFORMED_2 0, __TO_NO_NAME 0'
X-TMWD-Spam-Summary: TS=20101021193400; ID=1; SEV=2.3.1;
 DFV=B2010102119; IFV=NA; AIF=B2010102119; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230392E34434330393541392E303038313A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010102119_5.03.0010
X-WSS-ID: 60DE4A2E3KK1094503-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159547>

This patch series adds new command line options to git-commit to make
it easy to specify messages for commits correctly formatted for use
wit 'rebase -i --autosquash'.

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

 Documentation/git-commit.txt |   21 ++++++++--
 archive.c                    |    2 +-
 builtin/commit.c             |   86 +++++++++++++++++++++++++++--------------
 builtin/fmt-merge-msg.c      |    2 +-
 builtin/log.c                |    3 +-
 builtin/mailinfo.c           |    2 +-
 cache.h                      |    3 +
 commit.c                     |   13 ++++++
 commit.h                     |    6 ++-
 environment.c                |   11 +++++
 log-tree.c                   |    2 +-
 notes-cache.c                |    2 +-
 pretty.c                     |   39 ++++++++++++-------
 submodule.c                  |    4 +-
 t/t3415-rebase-autosquash.sh |   29 +++++++++++++-
 t/t3900-i18n-commit.sh       |   29 ++++++++++++++
 t/t7500-commit.sh            |   80 +++++++++++++++++++++++++++++++++++++++
 t/t7500/edit-content         |    4 ++
 18 files changed, 277 insertions(+), 61 deletions(-)
 create mode 100755 t/t7500/edit-content

-- 
1.7.3.1
