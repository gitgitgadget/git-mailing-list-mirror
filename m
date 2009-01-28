From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3 1/2] git-am: emit usage when called w/o arguments and w/o patch on stdin
Date: Wed, 28 Jan 2009 10:03:09 -0500
Message-ID: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com,
	sverre@rabbelier.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 16:04:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSByB-0004CO-AS
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 16:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbZA1PDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 10:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbZA1PDR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 10:03:17 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:44383 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbZA1PDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 10:03:16 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3395011qwe.37
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=iW5ThPz+lLqxRFXPajybOK4pmHtVLX7WqLma4XWFlGc=;
        b=RqKNtU8dKxLPLzq4N24jYAAuV66xzPuNqueyPW4n5fHbOal+Z09QT+bHWYE1wDMiiV
         NlJgD+jxTnAfOfvlGzCaFg72FMGGBQ8yrylgZyD3Q3vJTvCc8eRqvrgRbIG0iPQgbNX/
         nmGOAXR5pjSRDmTHjOzEZmWUBxLpqzpf3jD50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=SEqYjhucqUSgQkBZLPuSfTeJ2cFeX73z6BeJIWzzhoDkEw/AxXr+6ZgMctM/s/Vuxv
         UB8GtrZDpWGn2RzRsclas2bEImnWSgwXnOJgUPtCGIh5XrjLuyWGQNI5+4tOyewZPxuL
         QcrbRrhvIPa0ZCMH/QG/uKo+IyTRBOFiee5sg=
Received: by 10.214.43.7 with SMTP id q7mr443751qaq.33.1233154994651;
        Wed, 28 Jan 2009 07:03:14 -0800 (PST)
Received: from localhost (cpe-075-189-159-045.nc.res.rr.com [75.189.159.45])
        by mx.google.com with ESMTPS id 6sm2800258ywp.38.2009.01.28.07.03.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jan 2009 07:03:13 -0800 (PST)
X-Mailer: git-send-email 1.6.1.224.gb56c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107540>

When git am is called w/o arguments, w/o a patch on stdin and the user hits
ctrl-c, it leaves behind a partially populated $dotest directory. After this
commit, it emits usage when called w/o arguments and w/o a patch on stdin.

Noticed by Sverre Rabbelier

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Change from v2: make Junio happy by no longer removing $dotest if git-am is
interupted while mailsplit is running.

 git-am.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b1c05c9..92a64b2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -254,6 +254,7 @@ else
 		done
 		shift
 	fi
+	test $# = 0 && test -t 0 && usage
 	git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
 		rm -fr "$dotest"
 		exit 1
-- 
1.6.1.224.gb56c
