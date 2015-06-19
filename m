From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] mergetool-lib: fix default tool selection
Date: Fri, 19 Jun 2015 11:30:55 +0200
Message-ID: <a9844fc48424d5caf27cc2189af3d9d867d01833.1434706187.git.git@drmicha.warpmail.net>
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 11:31:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5sdt-0007cN-D3
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 11:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbbFSJbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 05:31:11 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41105 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752606AbbFSJbI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 05:31:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 1D7752099F
	for <git@vger.kernel.org>; Fri, 19 Jun 2015 05:30:57 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 19 Jun 2015 05:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=
	mesmtp; bh=YgLwSwwr5Dct5Abs/ng8MYDqnQc=; b=rRVbJl4fKAAILSIoPLhE0
	T+LJVlcXDN0qY1vGkYPVcg5vr4Ts5OQcSv/Q+8p/POHWIRSVwSSZUf6Tab3dpDoN
	sEUQLMpvLAW9qH0pmMnwaKHJtlZ/LwMF8/XS7IdqYajK05vl+fw2C7rLuGP/8o78
	59CBLoTZi9yjLWlQSw21TM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=YgLwSwwr5Dct5Abs/ng8MYDqnQ
	c=; b=Pb37SqK6s5Ed9E7Vrh15wl/646GObiBYMjN0MtI3f1N9N/pw42IAQS2d2d
	a83vMEpZ8YMVjX8PdOV58tA5RX6rDOqrCsLYhozNyEWYf2Z6OqEp1A6d7xOJF0zQ
	zsk1NmWVJHE9Aesq6IE4Sa/4vcCq1Qew/kF3Nv9Mgr1UWgwfE=
X-Sasl-enc: ZZSTA4ih3NkWcXHRqaZPuhksNOpt5mUb7RDfa9D9QUgo 1434706256
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AC8D4680120;
	Fri, 19 Jun 2015 05:30:56 -0400 (EDT)
X-Mailer: git-send-email 2.4.4.610.gea30ab1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272112>

When no diff nor merge tool is specified (config, option), mergetool-lib
is supposed to choose a default tool from a set of tools. That set is
constructed dynamically depending on the environment (graphical, editor
setting) as a space separated string of tool names.

719518f (mergetool--lib: set IFS for difftool and mergetool, 2015-05-20)
introduced a newline as IFS which breaks the parsing of the space
separated list into items, resulting in a failed search for an available
tool.

Set IFS to a space locally for the tool search.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-mergetool--lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 14b039d..54ac8e4 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -305,6 +305,7 @@ guess_merge_tool () {
 	EOF
 
 	# Loop over each candidate and stop when a valid merge tool is found.
+	IFS=' '
 	for tool in $tools
 	do
 		is_available "$tool" && echo "$tool" && return 0
-- 
2.4.4.610.gea30ab1.dirty
