From: David Turner <dturner@twopensource.com>
Subject: [PATCH 05/24] t1430: don't rely on symbolic-ref for creating broken symrefs
Date: Thu,  7 Apr 2016 15:02:52 -0400
Message-ID: <1460055791-23313-6-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEc-0007wR-VY
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381AbcDGTEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:04:43 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34911 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756866AbcDGTD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:27 -0400
Received: by mail-qg0-f49.google.com with SMTP id f105so47941332qge.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=qVPUoVf9IXhcefJHtTfHYEsImr9pcHYF6kD0WC/C7c8=;
        b=QBI8gvw27FaxZlCd8lJAkmtoiQijscHQpZAavZI3mJE5KqHS3/QjMJPwjPjTH6jwUR
         fbACBHaDkg5Xd6gS7JtIJxMOhoEGdN7aiAd0tLoXetaPMidHF3TpBs2sNlAg2sRLlEKt
         wXwM2Rpg9O2H+3fXwRJcBZ23u2OGFd5G5V7A2czEeZSgAJdmusLLvq+2S7WoAkvN8X1D
         Ra7gZdNIJDe58WqK68Zb8X4PD57YRRVc5YNBAPJeefNE9XcrplCsVOJ0EybxGKnEMrYa
         Vpsx16MWrwRL2W1o+2MrJlNVGt2ZXNJe2eOwOzwNRxU073Xq5GQdT/MTp5tOoKpjsMIl
         D5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=qVPUoVf9IXhcefJHtTfHYEsImr9pcHYF6kD0WC/C7c8=;
        b=W79awXgqgJarNGJus5F9yLbsMc8vbMWnWW4HAXu/14NANftf+CGPj9hWSCEgQyx9ZW
         9gwwCuu+JUHjAbzCXZL71MjGqwy9P+18zoh7eoW72oIfOMMZCWPyXQad3W1mftnc2AB5
         yqlLek77TZLaJo82+CW2Df6DseKH+JPP1jBGmf0ZvD3Cq6iGfDE1LR6ua6Fi6vwD91m1
         Ia8sTVLgkoPoSOtdcDIBoepO4BuGvLrIlKx1ceMMkEKhTyq2pY5gPdqp3+XZ5nvolwx4
         zlIyrn9zwGrglV5uXbOx56fD4E1k1gmE8JfWrjCnTr8GpR5Q+l0alTKDRQM8HMFjiUOs
         CsxQ==
X-Gm-Message-State: AD7BkJJLrEXkIqI7nRW8ut3yNaaZADLTz5QarWHU5VWlFDS+Ug/jtABABJkoGZznSvumKg==
X-Received: by 10.140.152.78 with SMTP id 75mr6156437qhy.22.1460055806510;
        Thu, 07 Apr 2016 12:03:26 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290970>

From: Michael Haggerty <mhagger@alum.mit.edu>

It's questionable whether it should even work.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1430-bad-ref-name.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index cb815ab..a963951 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -147,7 +147,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	git branch shadow one &&
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
-	git symbolic-ref refs/tags/shadow refs/heads/broken...ref &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
 	test_when_finished "rm -f .git/refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
@@ -156,7 +156,7 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 '
 
 test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
-	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	test_path_is_file .git/refs/heads/badname &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
-- 
2.4.2.767.g62658d5-twtrsrc
