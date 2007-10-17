From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] fixing output of non-fast-forward output of post-receive-email
Date: Thu, 18 Oct 2007 00:27:51 +0200
Message-ID: <20071017222751.GC7672@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, andyparkins@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 00:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiHN4-0003cT-RD
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 00:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966AbXJQW16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 18:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756124AbXJQW16
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 18:27:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:35882 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039AbXJQW15 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 18:27:57 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1977334nfb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 15:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        bh=pmSV2MInqOvGWa2Da+/l3aidjIm0XYIHhRFDXo3z2K4=;
        b=g9+7iyVxHU6cIOKOInp0xDXk6fE+9/2/puSwhQFiwaWSvfT56YJYlS0har3lRtD4mNjA8zdo0oc8Z5Dfd7fvVYcV3uilxM+rjkRJ6LrfvPqhNPMXgni0HPBWHFnFC+SLF2xXiCQw98Kc5EGWw6q2L07XCVL0GwKVFVLS3d+3O1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=YSmqp7d+Zg+jMkKghFF/VPc3wW02X+G6kWtN2u7G4uxblET5HX1D9320eWhY5lyyx//RnkcCjsQ6HoGfjD0NkVe/YLf/KJoSBLIUIGJjrHwCYqoqxJ5VJaJivmj973e2pKI8MzBTRIXv0te7WY44mDSyiGkBTzESFr+vtndoaXY=
Received: by 10.86.86.12 with SMTP id j12mr3427326fgb.1192660075057;
        Wed, 17 Oct 2007 15:27:55 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.117.125])
        by mx.google.com with ESMTPS id 31sm156251fkt.2007.10.17.15.27.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Oct 2007 15:27:53 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id B55B1985488; Thu, 18 Oct 2007 00:27:51 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61433>

post-receive-email has one place where the variable fast_forward is not
spelled correctly.  At the same place the logic was reversed.  The
combination of both bugs made the script work correctly for fast-forward
commits but not for non-fast-forward ones.  This change fixes this to
be correct in both cases.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index cbbd02f..28a06c7 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -323,7 +323,7 @@ generate_update_branch_email()
 		echo "       via  $rev ($revtype)"
 	done
 
-	if [ -z "$fastforward" ]; then
+	if [ "$fast_forward" ]; then
 		echo "      from  $oldrev ($oldrev_type)"
 	else
 		#  1. Existing revisions were removed.  In this case newrev is a
-- 
1.5.2.4
