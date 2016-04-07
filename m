From: David Turner <dturner@twopensource.com>
Subject: [PATCH 06/24] t1430: test for-each-ref in the presence of badly-named refs
Date: Thu,  7 Apr 2016 15:02:53 -0400
Message-ID: <1460055791-23313-7-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDL-00073u-KR
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbcDGTD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:29 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35953 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756785AbcDGTD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:28 -0400
Received: by mail-qg0-f53.google.com with SMTP id f52so71728448qga.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=83De9E3DERxkqlF1LwyOUyYg/gXmGmOyAbJ3Ua3BwPo=;
        b=kJgZwt7ffSBd82fyhSMOHg/2C5Y53N0zaxyP8/QB2neJBeTsMcqPcIBKj3schlq9uD
         T8W7vHoo3IMVXMUOMkl4bfJ9kQ0sx55WYeJSjRK3N0xfEeKbgo7efUQESVNdtauKCKDG
         upGw3IZ14gRbFcUIQBu/IszUUSvdMIHjfpVR+KDyk0BVHX7Vy4vHBgBSViNY4TX6qlX7
         +1/q3TvpFBWriPrN6Ddh/GVQWANeG27DQUZqW6U/nc7ycysj2BvIWI/BbhFJLU1CPOtA
         A58/K8KLZPDBq+5af6A0e+YCtYm0UUWzDzKe6C6cBHK6H4CZgYdOUIjhctDdX5JufVEw
         p7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=83De9E3DERxkqlF1LwyOUyYg/gXmGmOyAbJ3Ua3BwPo=;
        b=NBW+qyit2P/x0+vfS8Swy7O/UGKa8MP2vMOCGhNo6RfgEHUyZhcW8N+BiM1dWNwKYk
         CXo2FzsNX2OTpsjwGRqXbfpJExWB4QzIdnDg//2h1WJXllZdkvh5FiIQOUenJnNB1wkz
         Skb6pEt0Fmo9rYnnXiKkw0zZzz0tgqCbEyc/PWynm7qDH9YNjGNJN8oIoo4QgPUHROzF
         FfcqwibhDqRg+iwpAHXj/WWyif9Rsn3v911svprx5ADkm/IXR+NhOf2zrzXe+WPFWEB3
         ddYEI3eK6zkvFvGn5l1Yx+VgMgfP3h4u+cuVBnHEh99pWrgSBCjvTe1DvMkdM/JzrTcP
         xvug==
X-Gm-Message-State: AD7BkJJyqtwn6hIjQ8VC+npollwswaYUt1oFI2oRx4U9RmtdjjVs5oq3tE9Xol9Uq7pIEA==
X-Received: by 10.140.170.70 with SMTP id q67mr6542747qhq.8.1460055807513;
        Thu, 07 Apr 2016 12:03:27 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290956>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1430-bad-ref-name.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index a963951..612cc32 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -155,6 +155,22 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 	test_i18ngrep "ignoring dangling symref refs/tags/shadow" err
 '
 
+test_expect_success 'for-each-ref emits warnings for broken names' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	printf "ref: refs/heads/master\n" >.git/refs/heads/broken...symref &&
+	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	git for-each-ref >output 2>error &&
+	! grep -e "broken\.\.\.ref" output &&
+	! grep -e "badname" output &&
+	! grep -e "broken\.\.\.symref" output &&
+	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
+	test_i18ngrep "ignoring broken ref refs/heads/badname" error &&
+	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.symref" error
+'
+
 test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
-- 
2.4.2.767.g62658d5-twtrsrc
