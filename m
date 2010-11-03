From: martin.von.zweigbergk@gmail.com
Subject: [PATCH 5/5] rebase: read state explicitly in '--abort'
Date: Wed,  3 Nov 2010 22:09:40 +0100
Message-ID: <1288818580-7576-6-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 04 04:10:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDqDt-00024F-C5
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 04:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab0KDDKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 23:10:18 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43895 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab0KDDKP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 23:10:15 -0400
Received: by mail-qw0-f46.google.com with SMTP id 7so831106qwf.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OIELp8WaS5EnWKwx1ra1xVpvOke3EB1X2TSI/Y6Jzbg=;
        b=rBV5A+yFwzp6FGoqo+emuwKejClOzuZOw9JCxT/PC5p1lDuFxS1TUe2o1ZXY5URim/
         NN5Xy/tGc78cuGRQ7ptshya73xIyH5uHwZpOA9h6m7eKJkYzftN07mpQaejTrGIOPN0C
         8HcH/uIkHtpKWFZh8l/xd11I6xCQ4Z1DURDmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A2IAiXfvK2vQzIN/oGJGdgnl6BhyMetHsEBE8dfoTVTzvPMfPASpit7z631qcNEVD5
         6YSeKheVyNAZKAF208pgqrY3ISgNJiNNkVmWh6sL/WmvWVbl910SEJDrJk1CxlVV41zd
         paImUI1A9vS9XrOi3HbYCmB2eQGWyHVi/ILAo=
Received: by 10.224.217.193 with SMTP id hn1mr107550qab.128.1288840215153;
        Wed, 03 Nov 2010 20:10:15 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u2sm7746119qcq.31.2010.11.03.20.10.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 20:10:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.4.g5879b6
In-Reply-To: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160686>

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

The only place where the state was not already read when
move_to_original_branch was called was in the '--abort' case. Read the
state explicitly there and remove it from move_to_original_branch.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index a7428ea..847555c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -147,7 +147,6 @@ call_merge () {
 }
 
 move_to_original_branch () {
-	test -z "$head_name" && read_state
 	case "$head_name" in
 	refs/*)
 		message="rebase finished: $head_name onto $onto"
@@ -266,6 +265,7 @@ do
 			die "No rebase in progress?"
 
 		git rerere clear
+		read_state
 		move_to_original_branch
 		git reset --hard $orig_head
 		rm -r "$state_dir"
-- 
1.7.3.rc1.4.g5879b6
