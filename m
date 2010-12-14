From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] difftool: provide basename to external tools
Date: Tue, 14 Dec 2010 10:18:35 +0100
Message-ID: <3a5944cb9af7b6b69dc0bdefdfd052b33fcd9a59.1292317348.git.git@drmicha.warpmail.net>
References: <4D073619.2010103@drmicha.warpmail.net>
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 10:21:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSR4P-0003yT-VO
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 10:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758152Ab0LNJVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 04:21:06 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60512 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758142Ab0LNJVE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 04:21:04 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1065CAC2;
	Tue, 14 Dec 2010 04:21:04 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 14 Dec 2010 04:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=LVbFmYB/emM/ezpLUm2A5ugT2z0=; b=ZDofVBGIRilus+4DUOc7jh2wnCQr4abKi45wic87KqF5oKY2okiBdk2EGKS5+TjS7NpkquNa/3hrI7/br3kI42MOtFhlUu16Ck1Dmno4xWq+XypyBVn4Nc3tlEMH4aiTDTqmSCCYAXC+ptV2h3Zt6F1g/raNPOvVGrkLOsth1kU=
X-Sasl-enc: 3qRdjMS+AsoYCc7pjiv+yed9ZXKJl0RanxXONRg345tM 1292318463
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 86AC3440B3E;
	Tue, 14 Dec 2010 04:21:03 -0500 (EST)
X-Mailer: git-send-email 1.7.3.3.738.g018bc
In-Reply-To: <4D073619.2010103@drmicha.warpmail.net>
In-Reply-To: <0833a4451b70db4c4e0be5753be53e262a9c5628.1292317348.git.git@drmicha.warpmail.net>
References: <0833a4451b70db4c4e0be5753be53e262a9c5628.1292317348.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163637>

Currently, only configured diff helpers get the basename of the file
being compared. Tools specified with "git difftool -x" only get the
names of temporary files for the different versions.

Export BASE so that an external tool can read the name from the
environment. Rather than using a third argument, this avoids breaking
existing scripts which may somewhat carelessly be using "$@" rather than
"$1" "$2".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-difftool.txt |    1 +
 git-difftool--helper.sh        |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 756d95d..db87f1d 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -65,6 +65,7 @@ with custom merge tool commands and has the same value as `$MERGED`.
 	Specify a custom command for viewing diffs.
 	'git-difftool' ignores the configured defaults and runs
 	`$command $LOCAL $REMOTE` when this option is specified.
+	Additionally, `$BASE` is set in the environment.
 
 -g::
 --gui::
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 524f5ea..0594bf7 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -49,6 +49,7 @@ launch_merge_tool () {
 	fi
 
 	if use_ext_cmd; then
+		export BASE
 		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
 	else
 		run_merge_tool "$merge_tool"
-- 
1.7.3.3.739.g52f77.dirty
