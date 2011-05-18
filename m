From: Gustav Munkby <grddev@gmail.com>
Subject: [PATCH] git-svn: enable platform-specific authentication
Date: Wed, 18 May 2011 10:45:20 +0200
Message-ID: <1305708320-8614-1-git-send-email-grddev@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>, Gustav Munkby <grddev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 10:46:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMcP2-0005fi-5C
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 10:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529Ab1ERIqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 04:46:43 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37334 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1ERIqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 04:46:42 -0400
Received: by ewy4 with SMTP id 4so370288ewy.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=1IXyVZ58fq1F3byy9bXDx9eUGvozLE+/4h5EDRiwIzo=;
        b=tA8Pr83b3k7UObnRwsmZyJ0HwDqJKi7ZLaijBvdHUNJlrrQk9I2/z8CvTVlgxCoPI5
         jSGg6r+3IPtxMJSSTGFnoput9q9Lj6yvXqn4gi+D2GfF9oPhGQM847K41iTfVWHRq481
         ODsHhibBYhWp4p8G1I3aZvtqpW/VKyCeJptY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=rTXd+jlCXtxMRs8s2QzkNTuaykAhteCxu/uSRhwDhEOZ89CKaB3msZiiMeShbbAdWO
         8eakIXGWmwvwNUM8cfTZ9ssk04a0fhne9d5lTRbqxm4tRSSH3qoJERIkect/2zu4x4fv
         RF/0BLturf4yY73/2qMUSuvCnWeTDI67FFPnE=
Received: by 10.14.11.5 with SMTP id 5mr522664eew.92.1305708401252;
        Wed, 18 May 2011 01:46:41 -0700 (PDT)
Received: from localhost.localdomain (h85-30-59-231.static.se.alltele.net [85.30.59.231])
        by mx.google.com with ESMTPS id y10sm981624eeh.17.2011.05.18.01.46.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 May 2011 01:46:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173862>

Use the platform-specific authentication providers that are
exposed to subversion bindings starting with subversion 1.6.

Signed-off-by: Gustav Munkby <grddev@gmail.com>
---
 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0fd2fd2..3f7c3c8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4930,6 +4930,9 @@ BEGIN {
 
 sub _auth_providers () {
 	[
+	  $SVN::Core::VERSION lt '1.6' ? () :
+	    @{SVN::Core::auth_get_platform_specific_client_providers(
+	      undef,undef)},
 	  SVN::Client::get_simple_provider(),
 	  SVN::Client::get_ssl_server_trust_file_provider(),
 	  SVN::Client::get_simple_prompt_provider(
-- 
1.7.5.1
