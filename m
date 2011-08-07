From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 0/5] gettext: add gettextln, eval_gettextln to encode common idiom
Date: Sun,  7 Aug 2011 21:58:12 +1000
Message-ID: <1312718297-10999-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: avarab@gmail.com, Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 13:58:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq204-0007rB-9P
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 13:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab1HGL6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 07:58:30 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33717 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab1HGL6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 07:58:30 -0400
Received: by gwaa12 with SMTP id a12so207187gwa.19
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=4W1vRTMJAnFs/Xa5/oke3rbzwNSjda5VP+AWqih+zzg=;
        b=nnLS/gT6jw2IRF2F4bsVsNgHqZuRcWN80F65AE8d1deacTnGYE4UyhNfpgeoiADaN2
         MbGDGGMRDNZHYnwmvXcMFxqXDdlm1ZOq9jo3tUKEMSpdFAPLLACg11JFk4TS1wOotMS5
         ab8dFQlOtEY02cbY4JvutYREdXhmlhWXyrHEM=
Received: by 10.143.66.17 with SMTP id t17mr4390224wfk.434.1312718308935;
        Sun, 07 Aug 2011 04:58:28 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id s7sm2183465pbj.5.2011.08.07.04.58.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 04:58:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.363.g9b380.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178902>

Currently, if you want to use gettext or eval_gettext to format a message
you may have to add a separate echo statement and a surrounding subshell
in order to interpolate the required trailing new line.

This patch introduces two new helper functions, gettextln and eval_gettextln
which append a trailing newline to the gettext output.

This allows constructions of the form:

	if test -s "$GIT_DIR/BISECT_START"
	then
		(
			gettext "You need to give me at least one good and one bad revisions.
(You can use \"git bisect bad\" and \"git bisect good\" for that.)" &&
			echo
		) >&2
	else
	...

to be expressed more concisely as:

	if test -s "$GIT_DIR/BISECT_START"
	then
		gettextln "You need to give me at least one good and one bad revisions.
(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
	else
	...

Applies cleanly to master and pu.

Revisions
=========
v2: 
	Split modifications to git-sh-i18n.sh into separate commit.
	Extended application to:
		 git-am.sh
		 git-pull.sh
		 git-stash.sh
		 git-submodule.sh
	Removed application to git-bisect.sh, pending stabilisation of this series and js/bisect-no-checkout in next or master.
	
v1: Initial RFC. Included example of application to git-bisect.sh.

Future
======
	Apply to git-bisect.sh

Jon Seymour (5):
  gettext: add gettextln, eval_gettextln to encode common idiom
  git-am: take advantage of gettextln and eval_gettextln.
  pull: take advantage of eval_gettextln
  stash: take advantage of eval_gettextln
  submodule: take advantage of gettextln and eval_gettextln.

 git-am.sh        |   31 ++++++++++++++-----------------
 git-pull.sh      |    7 ++-----
 git-sh-i18n.sh   |   19 +++++++++++++++++++
 git-stash.sh     |    9 +++------
 git-submodule.sh |   18 ++++++------------
 5 files changed, 44 insertions(+), 40 deletions(-)

-- 
1.7.6.363.g9b380.dirty
