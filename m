From: David Turner <dturner@twopensource.com>
Subject: [PATCH 07/24] t1430: improve test coverage of deletion of badly-named refs
Date: Thu,  7 Apr 2016 15:02:54 -0400
Message-ID: <1460055791-23313-8-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDM-00073u-60
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbcDGTDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:31 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35976 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbcDGTD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:29 -0400
Received: by mail-qg0-f46.google.com with SMTP id f52so71729081qga.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=dbAaNR7o2Mn7f/gy9tpXQ5QI76I4C/0dap0P7b+NwNk=;
        b=XbhGiDvpR4sIQHcsDrJbxDoDqLvAumeLNmhgpoZBejWiefxTojt+BmHhwUqh2rmukN
         3To7xenihrC3WMHEM4761/noqFXfZWCVa1WW5b91IquMYH5s/I/0Q23YKFNk+yqd0U2b
         Au4K6LmF9uaX6DSSOc20t9tS1zBMNDi6nLiz0XvVb0k3Z62lidTsfIoTxpmjzkb8NWky
         0MjgjJvjOi9jFCAJgXHWFlVysIGE674m4lp1X8JdaJgUXRAM7km33UsHqZrMzVm4OfwD
         GFCZd6bqH5MmtIjF/UWQh4jkHWu9HRnHg9BDqpADzyasCtTszicoDl4DzEACwuePorIO
         +rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=dbAaNR7o2Mn7f/gy9tpXQ5QI76I4C/0dap0P7b+NwNk=;
        b=eYqP7kxLKR6KjF50Bpd/6tu9bg/LAUlfOACj/u1souCv0No7KcSEPSlWJgcFkz6es1
         JlbPGIwzBdS9ZoiwVJ4FrDzIpgb0YaU3JJkkrIXuXExxsvsKUUFilQINn6rKG7z4J73y
         oliVMQ/5bDABIVWU/29qAvIpOtAO0uLY+jd0QnRu6YXin3kbDdEatzotS3QKdlSksaki
         1uvQ37CCsKqnPvoddhbDQMOd7xKpgy4G5ykceu2/gk/b2k380sYZ/fG5NlXPeXdrPP/S
         1STi9fe5WEfqmnN3NU024pbnqoDscv9ZWtIcRtvr7iAHzamg817zzEphAyXhn7xy2zWN
         tOTw==
X-Gm-Message-State: AD7BkJIB8gmM+8jiDLb2IjuAat4K7EDhY1IIIEr6NuFQz09IJeLLV4nP6+uaB3ci6+7uRw==
X-Received: by 10.140.168.85 with SMTP id o82mr6242328qho.16.1460055808829;
        Thu, 07 Apr 2016 12:03:28 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290957>

From: Michael Haggerty <mhagger@alum.mit.edu>

Check "branch -d broken...ref"

Check various combinations of

* Deleting using "update-ref -d"
* Deleting using "update-ref --no-deref -d"
* Deleting using "branch -d"

in the following combinations of symref -> ref:

* badname -> broken...ref
* badname -> broken...ref (dangling)
* broken...symref -> master
* broken...symref -> idonotexist (dangling)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1430-bad-ref-name.sh | 104 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 8 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 612cc32..25ddab4 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -171,25 +171,113 @@ test_expect_success 'for-each-ref emits warnings for broken names' '
 	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.symref" error
 '
 
-test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
+test_expect_success 'update-ref -d can delete broken name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git update-ref -d refs/heads/broken...ref >output 2>error &&
+	test_must_be_empty output &&
+	test_must_be_empty error &&
+	git branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'branch -d can delete broken name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -d broken...ref >output 2>error &&
+	test_i18ngrep "Deleted branch broken...ref (was broken)" output &&
+	test_must_be_empty error &&
+	git branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'update-ref --no-deref -d can delete symref to broken name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
-	test_path_is_file .git/refs/heads/badname &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
 	test_must_be_empty output &&
 	test_must_be_empty error
 '
 
-test_expect_success 'update-ref -d can delete broken name' '
+test_expect_success 'branch -d can delete symref to broken name' '
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-	git update-ref -d refs/heads/broken...ref >output 2>error &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	git branch -d badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/badname &&
+	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'update-ref --no-deref -d can delete dangling symref to broken name' '
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/badname &&
 	test_must_be_empty output &&
-	test_must_be_empty error &&
-	git branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error &&
-	! grep -e "broken\.\.\.ref" output
+	test_must_be_empty error
+'
+
+test_expect_success 'branch -d can delete dangling symref to broken name' '
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	git branch -d badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/badname &&
+	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'update-ref -d can delete broken name through symref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	git update-ref -d refs/heads/badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/broken...ref &&
+	test_must_be_empty output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'update-ref --no-deref -d can delete symref with broken name' '
+	printf "ref: refs/heads/master\n" >.git/refs/heads/broken...symref &&
+	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
+	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_must_be_empty output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'branch -d can delete symref with broken name' '
+	printf "ref: refs/heads/master\n" >.git/refs/heads/broken...symref &&
+	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	git branch -d broken...symref >output 2>error &&
+	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_i18ngrep "Deleted branch broken...symref (was refs/heads/master)" output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'update-ref --no-deref -d can delete dangling symref with broken name' '
+	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
+	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
+	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_must_be_empty output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'branch -d can delete dangling symref with broken name' '
+	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
+	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	git branch -d broken...symref >output 2>error &&
+	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_i18ngrep "Deleted branch broken...symref (was refs/heads/idonotexist)" output &&
+	test_must_be_empty error
 '
 
 test_expect_success 'update-ref -d cannot delete non-ref in .git dir' '
-- 
2.4.2.767.g62658d5-twtrsrc
