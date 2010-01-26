From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] t5541-http-push: make grep expression check for one line only
Date: Tue, 26 Jan 2010 09:37:25 +0800
Message-ID: <1264469845-980-1-git-send-email-rctay89@gmail.com>
References: <be6fef0d1001251733o57042a99q9f1f8b6e849187ee@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 02:37:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZaNF-00047Y-W3
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 02:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab0AZBhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 20:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338Ab0AZBhm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 20:37:42 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:56978 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0AZBhl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 20:37:41 -0500
Received: by ewy19 with SMTP id 19so453795ewy.21
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 17:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qsDYplmZ6TPFEqoNRDcWrCDvDdj0v1Rkc/aS9DKcU5E=;
        b=Givvwz1IUMzNo1NGX+mY2BAMbirdRdoRLKBov64+lPtZy7lUeg3MNHZPpK5Fzk0Vb0
         t6UkDWXtlHmv9YjHFkX4tkw5xhLJAQzN8xkuzGy6rAUrUUYcVRJJt4AdqoHphIpNMbbu
         gtWW2CgljzhHmBHOqZCyDIpdxNf5/kZa2s5Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IDe6MoVU7P3rwvcMkqV2/sA/kAsZXs14UzqvOPyeM5KsirBIpofRTZC1STQEqSaJED
         NIuCNLu1WgjlhhMjf9+Ir8lSuXdwcPktpW1a2MCAT9bJ9x7+4t8ik4mqy7U+1RPDMWB5
         tV7YKU4n7qQZifGBA6UCxnKRNob0DE4Z8aJv4=
Received: by 10.213.109.88 with SMTP id i24mr4550411ebp.22.1264469860434;
        Mon, 25 Jan 2010 17:37:40 -0800 (PST)
Received: from localhost.localdomain (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 15sm255558ewy.12.2010.01.25.17.37.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 17:37:39 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.436.gaba7d
In-Reply-To: <be6fef0d1001251733o57042a99q9f1f8b6e849187ee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138020>

Don't feed multiple-line pattern to grep and expect them to match with
lines in order.

Simplify the grep expressions in the non-fast-forward tests to check
only for the first line of the non-fast-forward warning - having that
line should be enough assurance that the full warning is printed.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5541-http-push.sh |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 83a8e14..53f54a2 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -105,10 +105,8 @@ test_expect_success 'non-fast-forward push show ref status' '
 '
 
 test_expect_success 'non-fast-forward push shows help message' '
-	grep \
-"To prevent you from losing history, non-fast-forward updates were rejected
-Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
-section of '"'git push --help'"' for details." output
+	grep "To prevent you from losing history, non-fast-forward updates were rejected" \
+		output
 '
 
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper' '
@@ -126,10 +124,8 @@ test_expect_success 'push fails for non-fast-forward refs unmatched by remote he
 	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *master -> master (forced update)$" output &&
 	grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output &&
 
-	grep \
-"To prevent you from losing history, non-fast-forward updates were rejected
-Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
-section of '"'git push --help'"' for details." output
+	grep "To prevent you from losing history, non-fast-forward updates were rejected" \
+		output
 '
 
 stop_httpd
-- 
1.6.6.1.436.gaba7d
