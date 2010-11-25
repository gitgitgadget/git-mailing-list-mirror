From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 07/20] rebase: stricter check on arguments
Date: Thu, 25 Nov 2010 20:57:50 +0100
Message-ID: <1290715083-16919-8-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:59:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLnb1-00026e-EN
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab0KZB7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:59:01 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62199 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab0KZB6N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:13 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347969vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S81sXsb05rzt1WhwfCp7nGVk578pkRUpjdkYjYiKXoc=;
        b=S5b7da3/4LMxkHfYwaWvuV5XrTKfuwBINXJO5pS2i7v95DiwOBdw0eYS+Kf44U/VDZ
         oWfPY2oZdvaT9h0I1kJxHDVKUGdq6YUTVdkysrx1KRkOrJWEarZJ5JMd83lxO5MF6EO/
         RStaRbiq74FIQvx71JQs40qfI1I/kfCAqROxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FvrB+YWLc2oai5uCKc70Q6rfJi/YgE79fFyTGLcMeXRuUPd4XPK2h733g3f2F4HFXk
         BFUMN3l0MjSMkv9yRioq+45PytAW4wj2GMQd3pluwXBGACRc3rX4UNZ9/SeLs6SMtd2F
         4XVJsWD4gwS6iO2aZDnb/4C8yWJDFj30BMVeE=
Received: by 10.220.198.131 with SMTP id eo3mr123905vcb.11.1290736693540;
        Thu, 25 Nov 2010 17:58:13 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:13 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162175>

To align git-rebase.sh better with git-rebase--interactive.sh, be
stricter about checking that, when used, '--continue', '--skip' and
'--abort' is the only argument.

Since $strategy and $verbose are currently saved only by interactive
rebase, checking that they are not passed on the command line would
break any existing uses of 'git rebase --strategy=<x> --continue'.
Instead, relax the check and let the options be ignored by interactive
rebase once refactored (the relaxation will not be effective until
further refactoring, however).

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2358e2f..feda4be 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -317,6 +317,10 @@ test $# -gt 2 && usage
 
 if test -n "$action"
 then
+	test $# -eq 0 &&
+	test -z "$onto" &&
+	test -z "$preserve_merges" ||
+	usage
 	test -d "$merge_dir" -o -d "$apply_dir" || die "No rebase in progress?"
 else
 	# Make sure we do not have $apply_dir or $merge_dir
-- 
1.7.3.2.864.gbbb96
