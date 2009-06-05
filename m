From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 01/23] t5540-http-push: test fetching of loose objects
Date: Sat, 6 Jun 2009 00:00:28 +0800
Message-ID: <20090606000028.3cc038b4.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbz8-00053w-Hu
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbZFEQIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbZFEQII
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:08 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43072 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbZFEQIG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:06 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so944213pzk.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=2hUFi1R6ogGDYUHfUX9U2b3WwN74O8hyAv4meMeIHY8=;
        b=bs+Vf65FMJYouBQ/tavXvmZYKZy4qe5v/kr/Itj3+8gt7+qiY8tKaBN0A7iviqa33b
         AZhpedE8iQw8koIf9V0H4lzuwJr/rpLajVJ4QFi6FWG84u5vKPCwuf0G3T4IyHzedLpb
         f2IswTU1U7u+X+SDeItDFWXlKgeV2Mp3DXT7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ZDr9w2te1YceqvC7i3Mj+CbP91sFDUv6Xk/J6fdkk8YfPyITBjNdWAGUyNxy+XWwSO
         kvBU1F2LbcYJImZ7vuNpfCi1DwRiz9GEob5VwM+RDj2/nXKGDGkWtVkYorn6R2CCNwWr
         l+IG0YEAOOVnMFj+QNgAWxXRnuSQOGzH8K06k=
Received: by 10.142.214.5 with SMTP id m5mr1242946wfg.37.1244218089298;
        Fri, 05 Jun 2009 09:08:09 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 30sm438322wff.9.2009.06.05.09.08.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:08 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120782>


Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5540-http-push.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 5fe479e..65a41db 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -67,6 +67,22 @@ test_expect_success ' push to remote repository with unpacked refs' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '

+test_expect_failure 'http-push fetches unpacked objects' '
+	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
+		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_unpacked.git &&
+
+	git clone $HTTPD_URL/test_repo_unpacked.git \
+		"$ROOT_PATH"/fetch_unpacked &&
+
+	# By reset, we force git to retrieve the object
+	(cd "$ROOT_PATH"/fetch_unpacked &&
+	 git reset --hard HEAD^ &&
+	 git remote rm origin &&
+	 git reflog expire --expire=0 --all &&
+	 git prune &&
+	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master)
+'
+
 test_expect_success 'create and delete remote branch' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout -b dev &&
--
1.6.3.1
