From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Makefile: minor improvements for Mac OS X (Darwin)
Date: Thu,  5 Feb 2009 01:09:08 -0500
Message-ID: <1233814148-67700-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com,
	benny.kra@googlemail.com, nanako3@lavabit.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 07:15:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUxWg-00028m-DN
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 07:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbZBEGJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 01:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530AbZBEGJN
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 01:09:13 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:58865 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbZBEGJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 01:09:13 -0500
Received: by qyk4 with SMTP id 4so112221qyk.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 22:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=2L8bvlT4V6rDYL84H0hMRMLY255a53t+u9jyYeik2I8=;
        b=dho0meUcKSgzyMPsm1EEf4Iio0Wqq6JU7mzKkvrldCfqdwg8+7N0FOxjJxZDBgqS++
         8RIfJ9Q8KAdOP+KHrCFG25WmjDeIcT+Vem+sagXPXQSXb7MmnumVMounfi6GoncHtobx
         W2KpkzZ0qSF9dwNYhfVltC4Ye6FDedAj4Qlj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=HuW+c95VGebExkOPV7ldNNfJf20+vOS5sDbCBnEzFzpoFp5Wu3aoKAPL5lCl/7oYHb
         zZlnLclPpay5YBZafvsYax9UsEn06qbJUoFePO02vK5kF5pApqVHLyAdclBERmwYx6KQ
         xXzdp00L+54rDYfn2OMRRp1Q3oed48LEkVec4=
Received: by 10.214.218.16 with SMTP id q16mr182112qag.78.1233814151421;
        Wed, 04 Feb 2009 22:09:11 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 6sm150756ywi.26.2009.02.04.22.09.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 22:09:10 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.331.g6c1bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108501>

1) Instead of requesting OLD_ICONV on all Mac OS X versions except for 10.5
(which will break when 10.6 is released), exlicitly request it for versions
older than 10.5.

2) NO_STRLCPY is not needed since Mac OS X 10.2. Noticed by Benjamin Kramer.

Note that uname -r returns the underlying Darwin version, which can be mapped
to Mac OS X version at http://www.opensource.apple.com/darwinsource/

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This patch incorporates gmane 106991. Hopefully it was okay to squash in the
other minor change as well.

 Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 830143e..77f1083 100644
--- a/Makefile
+++ b/Makefile
@@ -652,10 +652,12 @@ endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
-	ifneq ($(shell expr "$(uname_R)" : '9\.'),2)
+	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
 		OLD_ICONV = UnfortunatelyYes
 	endif
-	NO_STRLCPY = YesPlease
+	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
+		NO_STRLCPY = YesPlease
+	endif
 	NO_MEMMEM = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 endif
-- 
1.6.1.2.331.g6c1bc
