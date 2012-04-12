From: Christopher Tiwald <christiwald@gmail.com>
Subject: [PATCH] Fix httpd tests that broke when non-ff push advice changed
Date: Thu, 12 Apr 2012 13:56:28 -0400
Message-ID: <20120412175628.GH367@gmail.com>
References: <9F768A58-DEB0-43E1-8AE4-B2A5C4E6CDE9@silverinsanity.com>
 <20120412133701.GA367@gmail.com>
 <20120412140049.GB367@gmail.com>
 <7v8vi1gdzk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 19:56:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIOG6-0007Qj-4L
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 19:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933008Ab2DLR4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 13:56:33 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50469 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab2DLR4c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 13:56:32 -0400
Received: by qcro28 with SMTP id o28so1394496qcr.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Iw0pgmiRwR9G/I+hJ3j6YOcu3NiYxX65BmNSBJX7E+0=;
        b=HqkYc3iqdEIV3WIxxwKlvZx1+1E3KRznwrHveo1IwYQL/czIBjLg0mZIjExvxaIaz0
         Rufua7Nv3NaQ0BWiUHt21xDxVmtyvbCMY3HKO7nTGu2K3LmFyyke6iwafVYcTFPOJzms
         il/9dZNkPcKVom05h0EqiCgxvKrnpBoJ5uC3b+2H8ArVCc2zj3qghzYPpbl2xebQ9BjA
         SHU/YhZmlKmXVYXQs47LKe543hWpbDvys50wvNf0l1QxVKsH29EJGeEzaoNoNC6qifvL
         pu3fuBRe48qt0psocYdK+AGexCYx+cDRCwA0uDbzBRr9IC1JRFPhBN4LhmrbUiyRdi3K
         CXLg==
Received: by 10.224.105.65 with SMTP id s1mr5175460qao.75.1334253391748;
        Thu, 12 Apr 2012 10:56:31 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id 1sm12910061qac.3.2012.04.12.10.56.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 10:56:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8vi1gdzk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195351>

On Thu, Apr 12, 2012 at 08:35:11AM -0700, Junio C Hamano wrote:
> Please do so.  I assume that the test vectors were expecting specific
> error/advice messages that need to be updated?

Looks to be the case. The below fixes the tests on my machine. It might
be worth adding tests to check the specific advice messages, but that's a
different topic and regardless wouldn't belong in the http-push series.

---- >8 ----
Signed-off-by: Christopher Tiwald <christiwald@gmail.com>
---
 t/lib-httpd.sh       |    2 +-
 t/t5541-http-push.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index f7dc078..094d490 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -160,6 +160,6 @@ test_http_push_nonff() {
 	'
 
 	test_expect_success 'non-fast-forward push shows help message' '
-		test_i18ngrep "To prevent you from losing history, non-fast-forward updates were rejected" output
+		test_i18ngrep "Updates were rejected because" output
 	'
 }
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index cc6f081..57c3e48 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -167,7 +167,7 @@ test_expect_success 'push fails for non-fast-forward refs unmatched by remote he
 '
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper: our output' '
-	test_i18ngrep "To prevent you from losing history, non-fast-forward updates were rejected" \
+	test_i18ngrep "Updates were rejected because" \
 		output
 '
 
-- 
1.7.10.167.gf245c

--
Christopher Tiwald
