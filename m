From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule deinit test: fix broken && chain in subshell
Date: Fri, 29 Apr 2016 16:51:26 -0700
Message-ID: <1461973886-24438-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:51:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIC6-0008HS-Iu
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbcD2Xvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:51:31 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36327 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbcD2Xva (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:51:30 -0400
Received: by mail-pf0-f181.google.com with SMTP id c189so55153257pfb.3
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=42kXXGxQeISZWnPCj/Elud4yxfx6HqYOQeExf57f8h4=;
        b=BVcyGXB61gI+z1psQ72FZhWH93HxSO2j16Ofpy324KOdd2+MABOX42vSfoFqgtog8L
         kculA98Ha5H2/6lXP/Q8qqbfO5wJnqj6K3173SkkFunYvMKeDJs6G6WmxkZYIDpffzrO
         GDWeRZD79KicUIyrj2CCxX5mbuiOMMl3QflQPRdJkrgrB8L5WYm+Mm9NTj+cAxHyI+Gi
         4RthK0Xnrjgpv4bc1B4j7ld+n8O5JAFmL7QD4XGTlmSnrwgPvQ1pOkasZoIwUl0sehuM
         v2EJbymwUXIXUKiPwryQl665HyMhwy65G5DlrU7iUqyWuVsBP6iE/HZaA1WrAZhpcjgc
         R9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=42kXXGxQeISZWnPCj/Elud4yxfx6HqYOQeExf57f8h4=;
        b=RN7mvnZWTXbWCeKt/7eHliqCKZ8RjWkjABwhOVHytDiYgY8NbFMrVUj9jJR8Bw8yiG
         UO+RIeXCQCAJ7ioN0q4cNKasBX4cdlfcvPnmSIFCHb3bt+XFvaFv//01nIGXeoMvFxKl
         aD9ZTmszPsdFjdCDDSCX9w9nkyNMm/L6fH2pq/8gWNgcSmA4TVCYaY4pQgESBIbiTohr
         LfS7NXW0mmYf/tUeLuOr8b6culZZkf7ABdpwZQup7SQ1Ntrb82iZgPBlPA5U9K/vOMiS
         IN8p7hUU59YH3UJGvELRPCYBovIajCSeMiB1LZ7B/C2EpTManycNPsrzrGOPMuKvy3HZ
         IM8Q==
X-Gm-Message-State: AOPr4FUk7B1BZGobxy7KQlGYi5IQXeDojLCSAj5vfIcx/quCu+7r5dPHEKw5oQVGdy/uxxMt
X-Received: by 10.98.7.135 with SMTP id 7mr32836139pfh.124.1461973889537;
        Fri, 29 Apr 2016 16:51:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id 76sm26274341pfz.44.2016.04.29.16.51.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:51:28 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293085>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This was missed in 84ba959bbd, submodule: fix regression for deinit
 without submodules, 2016-03-22
 
 Thanks,
 Stefan
  
  
 t/t7400-submodule-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 814ee63..90d80d3 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -914,7 +914,7 @@ test_expect_success 'submodule deinit works on repository without submodules' '
 		git init &&
 		>file &&
 		git add file &&
-		git commit -m "repo should not be empty"
+		git commit -m "repo should not be empty" &&
 		git submodule deinit .
 	)
 '
-- 
2.8.0.32.g71f8beb.dirty
