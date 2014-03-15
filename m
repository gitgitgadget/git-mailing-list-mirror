From: Justin Lebar <jlebar@google.com>
Subject: [PATCH 2/6] contrib: Fix misuses of "nor"
Date: Sat, 15 Mar 2014 01:41:58 -0700
Message-ID: <1394872922-2000-3-git-send-email-jlebar@google.com>
References: <1394872922-2000-1-git-send-email-jlebar@google.com>
Cc: Justin Lebar <jlebar@google.com>, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 09:43:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOkBt-0006av-Um
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 09:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbaCOInD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 04:43:03 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:39891 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbaCOImp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 04:42:45 -0400
Received: by mail-ve0-f201.google.com with SMTP id cz12so440518veb.4
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zuj+2A/FgYo8JfcXhLuOkYXZM0mggSHS4gqsElLbWU=;
        b=Y37ZDMzfVt5Fiu5Bn4lnZoeYZCJTkU/f1i+GvSdZkpZ0hc6X4Woa0TtXk9Z1kQrG7h
         cTe5yFr1kEkieubJqf0OK6a0V+s7ECdneaRIAkbCDoQZV+bPpwVU/HsaS4EQ6jggHlZC
         6TQIkS9ERZmkvhF0kQirZp9isY5nC2WR0wlAltriJtO30GrUoMjlAd3JLOd3/563qmn8
         gX1kX+dRPhjDDA3A4gPrHKhHK8LlsyATShQgx6i5MJC+BnYWzz25Pz+N5pt1Sv8r3yd/
         kItl8MKb+enjhXHeIIaDBuarkxVqgLpeNA0561hiyPN0ZTXi/kKb7demn4oTHTSWfj0x
         8kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zuj+2A/FgYo8JfcXhLuOkYXZM0mggSHS4gqsElLbWU=;
        b=bNDitdHHexVxMq3bSXp15M+Bvph+21am38CBn2u36hSvkaTceWZFzLHXzdAu/H5HkG
         xeNawtDCswD4Ll7s3b776xFljY6udEhL1oSkXBhfdjs6SLsVkO57ZN6EJXl940Iwai+I
         tZFWg/MufK+G6xtabhRXUxcmadkkRSLBF/a7Bk4NoaFcbTSzI+aUaSFJObPyPS9AgrZK
         HcyzPZJV3c44+uM3Z77pnEe4ak5UP29rUT2fjfUVFw+Qb5KqzrdozG8qdL06gUrFMNoL
         M1w1nmXsGnngvsgerD8K7MVlBFnEoOjgbZ4h1fA/vA7SzT9TsGUdaf3WgD225MV92P22
         A9Ig==
X-Gm-Message-State: ALoCoQnanGAJP5h0JFzipQbEaNyl0+eaCCH9KxuszOTJ89d6SCYwY4655Mev8gKmKCdHYtFOSS5/PBOT1Cmxw9zc0TYjbUGapKPxyofS+b3xQmCPuqAVeXXw7xQ5J1ghJldJT16pZBO+yLEl5sRY4pCq8gzZEfR9b6WJ8bDz4/TYaraiCFmCMSdPfpCLpIPn1RWRVPdNhKgu
X-Received: by 10.52.236.231 with SMTP id ux7mr4327556vdc.7.1394872964628;
        Sat, 15 Mar 2014 01:42:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c9si320602yhm.7.2014.03.15.01.42.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Mar 2014 01:42:44 -0700 (PDT)
Received: from jlebar0.mtv.corp.google.com (jlebar0.mtv.corp.google.com [172.17.132.58])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 770C75A4241;
	Sat, 15 Mar 2014 01:42:44 -0700 (PDT)
Received: by jlebar0.mtv.corp.google.com (Postfix, from userid 214119)
	id 340FB1A0889; Sat, 15 Mar 2014 01:42:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.279.gdc9e3eb
In-Reply-To: <1394872922-2000-1-git-send-email-jlebar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244147>

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
1.9.0.279.gdc9e3eb
