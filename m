From: Justin Lebar <jlebar@google.com>
Subject: [PATCH v5 2/4] contrib: Fix misuses of "nor"
Date: Mon, 31 Mar 2014 15:11:45 -0700
Message-ID: <1396303907-23291-2-git-send-email-jlebar@google.com>
References: <1396303907-23291-1-git-send-email-jlebar@google.com>
Cc: Justin Lebar <jlebar@google.com>, Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 00:14:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkQy-0007Ny-Jf
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbaCaWL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:11:56 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:34443 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbaCaWLy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:11:54 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so1744938iec.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KXG5A3MG/Ya5jwEakeTa9oFySxDcRix4jKr+6r/MFtw=;
        b=OwGwNC+biawrBi7uWwuQecsCGaAmfAY01ttWNWAeNX8TnEpJJza6MlsF1v75WTh9hZ
         Dl0e+ONCF2LErV3I+heh46g2PNJSxmr070BOP4DBpJ0+boROOSDPyBcaT+qyV4jYOn6W
         gGvLwoNAMM9nqW3iiGeCDwBz6Y3gHLmk5p9CGnWXTCvi6vfN9nRHNu52Pohu+gztWxRd
         A0x5zs3aDnxj67zDPYUoB5dfhG3x2K7aYMfBjbtpUXIBgWqzI+Mpg5nBJJjuPu5Z8RO2
         +qaVcbchbTfGiPk2BM80Kz+Imxu5VsCQlWV+38mxNXUQxZd06mcfFq+mI/gvM8xHhTc/
         FF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KXG5A3MG/Ya5jwEakeTa9oFySxDcRix4jKr+6r/MFtw=;
        b=aEOT5sB+GRqDlx4Wh30rsJkLNxSTUMlWS0hDIq4gkzJo6vpUdfzhTmKWJTZ1Du77In
         CaboL8ExKZBojmO5H730A1ZsQn+zPyUt3zqT3a6XyNTIH7EKKIlX9ygk1Cg6lr0m2br3
         YGTZJDWvX4fqFdcFuhS6fltUmnRorStKhnZMJudIKcVhz9wCIJ2DE9KUly4c1bgHQuRP
         Aae4Vw4TClpawnVz+uBJWbhUYK6qhB+feSpRR3O9ebnfUz4jglxNJI1SzP4FwGNIRsYg
         JaWPoPlos6RoWkOccd/KOla2qz13TaxBcRVRMbZvJeOpoY5isFwMabBKK4Lux6ubrLxh
         tS1w==
X-Gm-Message-State: ALoCoQmb5J/wzN49sB+B1LppWcGRO3TapEoVKqpD76tHjSpjtVTm5GE4jRLKHjJOMe9UVXShLUp6iIXS+Tvpk+jbgHTa11jnBlSmalZlV1k1sqzns6JDYUKvX81CnKX2mJHfZpFcja4X2EF0EFuS0dVzwRXoWHrCbdRZbrkRM1cKAH0yA7VOStY5vvJFOsV1tVZDbacZjXNS
X-Received: by 10.182.230.168 with SMTP id sz8mr11344817obc.9.1396303913451;
        Mon, 31 Mar 2014 15:11:53 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id g21si2917288yhe.3.2014.03.31.15.11.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Mar 2014 15:11:53 -0700 (PDT)
Received: from jlebar0.mtv.corp.google.com (jlebar0.mtv.corp.google.com [172.17.132.58])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4C66A5A4226;
	Mon, 31 Mar 2014 15:11:53 -0700 (PDT)
Received: by jlebar0.mtv.corp.google.com (Postfix, from userid 214119)
	id 117651A08FA; Mon, 31 Mar 2014 15:11:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
In-Reply-To: <1396303907-23291-1-git-send-email-jlebar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245553>

Signed-off-by: Justin Lebar <jlebar@google.com>
---
 contrib/examples/git-commit.sh | 2 +-
 contrib/svn-fe/svn-fe.txt      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-commit.sh
index 23ffb02..4aab1a6 100755
--- a/contrib/examples/git-commit.sh
+++ b/contrib/examples/git-commit.sh
@@ -280,7 +280,7 @@ case "$#,$also,$only,$amend" in
 0,,,*)
 	;;
 *,,,*)
-	only_include_assumed="# Explicit paths specified without -i nor -o; assuming --only paths..."
+	only_include_assumed="# Explicit paths specified without -i or -o; assuming --only paths..."
 	also=
 	;;
 esac
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 1128ab2..a3425f4 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -40,8 +40,8 @@ manual page.
 NOTES
 -----
 Subversion dumps do not record a separate author and committer for
-each revision, nor a separate display name and email address for
-each author.  Like git-svn(1), 'svn-fe' will use the name
+each revision, nor do they record a separate display name and email
+address for each author.  Like git-svn(1), 'svn-fe' will use the name
 
 ---------
 user <user@UUID>
-- 
1.9.1.423.g4596e3a
