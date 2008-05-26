From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Ignore no-op changes in paranoid update hook
Date: Sun, 25 May 2008 22:18:05 -0400
Message-ID: <20080526021805.GC29990@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 26 04:19:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0SIk-0003RG-G6
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 04:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbYEZCSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 22:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYEZCSJ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 22:18:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52520 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbYEZCSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 22:18:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K0SHa-0001EF-Pu; Sun, 25 May 2008 22:17:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 620FC20FBAE; Sun, 25 May 2008 22:18:05 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82892>

If the hook gets invoked with identical old and new ids there
is no change taking place.  We probably should not have been
called, but instead of failing silently allow the no-op.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/hooks/update-paranoid |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index ae94822..d18b317 100644
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -259,6 +259,7 @@ deny "Refusing funny ref $ref" unless $ref =~ s,^refs/,,;
 deny "Bad old value $old" unless $old =~ /^[a-z0-9]{40}$/;
 deny "Bad new value $new" unless $new =~ /^[a-z0-9]{40}$/;
 deny "Cannot determine who you are." unless $this_user;
+grant "No change requested." if $old eq $new;
 
 $repository_name = File::Spec->rel2abs($git_dir);
 $repository_name =~ m,/([^/]+)(?:\.git|/\.git)$,;
-- 
1.5.5.1.501.gefb4
