From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Don't load missing ACL files in paranoid update hook
Date: Sun, 25 May 2008 22:18:01 -0400
Message-ID: <20080526021801.GB29990@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 26 04:19:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0SIj-0003RG-SD
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 04:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbYEZCSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 22:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbYEZCSG
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 22:18:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52497 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbYEZCSF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 22:18:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K0SHX-0001Dy-3O; Sun, 25 May 2008 22:17:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BBEB520FBAE; Sun, 25 May 2008 22:18:01 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82891>

If a user or group ACL file does not exist in the current tip
revision of the acl repository we will get an error from cat-file
when we ask for that blob as it cannot be resolved.  A quick look
at the history by rev-list can tell us if there is a path there
or not.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/hooks/update-paranoid |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index 6e0d97c..ae94822 100644
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -136,6 +136,7 @@ sub parse_config ($$$$) {
 	local $ENV{GIT_DIR} = shift;
 	my $br = shift;
 	my $fn = shift;
+	return unless git_value('rev-list','--max-count=1',$br,'--',$fn);
 	info "Loading $br:$fn";
 	open(I,'-|','git','cat-file','blob',"$br:$fn");
 	my $section = '';
-- 
1.5.5.1.501.gefb4
