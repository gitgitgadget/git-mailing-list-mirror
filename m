From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 4/7] t5540-http-push: expect success when pushing without
 arguments
Date: Sun, 25 Oct 2009 23:21:42 +0800
Message-ID: <20091025232142.6558d9e4.rctay89@gmail.com>
References: <20091025232044.06d7ce5c.rctay89@gmail.com>
 <20091025231932.be9a6dfa.rctay89@gmail.com>
 <20091025231809.15b470fa.rctay89@gmail.com>
 <20091025231651.18c75559.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:21:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N24un-0001pn-VD
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbZJYPVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbZJYPVn
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:21:43 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:43359 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbZJYPVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:21:43 -0400
Received: by yxe17 with SMTP id 17so9152843yxe.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=xXUJEGspwlSEYYN/U5k1SXFfmcIMeCLqPL/ZvaSOiPM=;
        b=KhV6w6QffcPmGH35ieuNUmIVbWMg1m1TCaXRqr7TYNEewpfRixpIPv+iUQE6LiVSD5
         KXMYZxbc8f31I6ViSd3hrzyLAYIYID3VydfiCwjT+AXGPlmUrBwCQUBdqr0Sz3L207bF
         R8Y2jmPZt+loQFXbxYcIDdA/VTL2fqdFiGzvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=lEg0GDh81LOdThYC0Yf9s+rA6vqsDlvpwQq3LEoedKKAteKqtKBbZgBTIzOwmqf9bo
         2km5v8YNS9/3uLcxRxbN5cSFUec62Hgqm7sRzLXSollKRCywh+Zt8PBSML6eaIPFOoX3
         f0y4ebylp9nG6ljdw7KqqQB4RP+37TkyMPjGA=
Received: by 10.101.28.5 with SMTP id f5mr1650591anj.97.1256484107825;
        Sun, 25 Oct 2009 08:21:47 -0700 (PDT)
Received: from your-cukc5e3z5n (cm73.zeta152.maxonline.com.sg [116.87.152.73])
        by mx.google.com with ESMTPS id 6sm895248yxg.12.2009.10.25.08.21.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:21:47 -0700 (PDT)
In-Reply-To: <20091025232044.06d7ce5c.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131211>

Remove mention of packed refs from the test description, and expect
success.

The dumb http push mechanism used to learn about the refs on the remote
repository by recursing through the /refs directory in the repository.
This meant that it was unaware of packed refs, since it did not read
/packed-refs. Thus the push failed, as no remote refs were found.

But after c6aa27e (Move WebDAV HTTP push under remote-curl, Wed Oct
14), the dumb http mechanism additionally learns about the refs through
/info/refs (via remote-curl.c::get_refs), so it is aware of packed
refs, even though it still doesn't read /packed-refs (assuming /info/
refs is up-to-date). Thus the push now succeeds.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5540-http-push.sh |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index f4a2cf6..c7b8a40 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -45,7 +45,7 @@ test_expect_success 'clone remote repository' '
 	git clone $HTTPD_URL/test_repo.git test_repo_clone
 '

-test_expect_failure 'push to remote repository with packed refs' '
+test_expect_success 'push to remote repository' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
@@ -57,16 +57,6 @@ test_expect_failure 'push to remote repository with packed refs' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '

-test_expect_success ' push to remote repository with unpacked refs' '
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-	 rm packed-refs &&
-	 git update-ref refs/heads/master \
-		0c973ae9bd51902a28466f3850b543fa66a6aaf4) &&
-	git push &&
-	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
-	 test $HEAD = $(git rev-parse --verify HEAD))
-'
-
 test_expect_success 'http-push fetches unpacked objects' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_unpacked.git &&
--
1.6.4.4
