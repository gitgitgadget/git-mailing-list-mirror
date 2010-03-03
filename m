From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/2] git-svn: req_svn when needed
Date: Wed,  3 Mar 2010 21:34:31 +0100
Message-ID: <53df75af0e7fa5a456b326652147840b07f0d53a.1267647872.git.git@drmicha.warpmail.net>
References: <d16ad252f24db9274bc9a5bcab959524eab823ed.1267636051.git.git@drmicha.warpmail.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 21:34:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmvGv-000239-7M
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174Ab0CCUeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:34:18 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37609 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752335Ab0CCUeQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Mar 2010 15:34:16 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 78B95E2F5C;
	Wed,  3 Mar 2010 15:34:16 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 03 Mar 2010 15:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=9BEN/tSjbs+nuJ9/lUurPcRVe1A=; b=GHGM7o7Pj/YBLBw1z5YbLaOMXSIWEU16f6StU2xcRpoYgzxSXo8Bu3hDnWrEWWdrsNMpkX/KNiTRZZlFz6Zxjs2LAFwSBQ48XIcOzfjJuCRQ4Ofzf+7F805qgsqHAncMnQOUYE3HCtOtu28rYhIckB5i8P+zawrcXG39w60thdY=
X-Sasl-enc: HwiMCVDSwLeRmw844RTp1MxGAOVvgC9CNkSyen+N2ZJL 1267648455
Received: from localhost (p3EE2AD69.dip0.t-ipconnect.de [62.226.173.105])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BF55449FEE8;
	Wed,  3 Mar 2010 15:34:15 -0500 (EST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
In-Reply-To: <d16ad252f24db9274bc9a5bcab959524eab823ed.1267636051.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1267647872.git.git@drmicha.warpmail.net>
References: <cover.1267647872.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141475>

The delayed loading of SVN missed a place where SVN::Core is used. Make
sure to load the package before trying to use it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b7c03b6..bae7231 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1102,6 +1102,7 @@ sub cmd_info {
 	if ($@) {
 		$result .= "Repository Root: (offline)\n";
 	}
+	::_req_svn();
 	$result .= "Repository UUID: $uuid\n" unless $diff_status eq "A" &&
 		($SVN::Core::VERSION le '1.5.4' || $file_type ne "dir");
 	$result .= "Revision: " . ($diff_status eq "A" ? 0 : $rev) . "\n";
-- 
1.7.0.1.241.g6604f
