From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 3/4] t5304: Ensure wanted files are not deleted
Date: Wed, 13 Jan 2016 11:07:11 -0600
Message-ID: <670a9d9268beb0d70fb877a7c62d769062babba9.1452704305.git.dougk.ff7@gmail.com>
References: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
 <cover.1452704305.git.dougk.ff7@gmail.com>
Cc: peff@peff.net, sbeller@google.com, Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 18:07:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOtW-0005AV-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbcAMRHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:07:33 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35345 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbcAMRHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:07:30 -0500
Received: by mail-oi0-f67.google.com with SMTP id e195so20083063oig.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 09:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=0aISxNq2TCqGaMJ+VstOmIHNsMO1fnVMy6b9Y1Qj+4Y=;
        b=ui9dkY2gvI9udjoNdR0hHHtMjkqY9PdtbLAnzMmy93e+EUFCUEJnbQMx5H321vZyGN
         qDkAvYGZ9BMvzsVtMSImhG9070B9M+Ti6fdV8ygE05qPD6PPrKvfLsVE5CzWoH6X389C
         SNxIMcVXOWTL3OoXdYtVLNnw6v+hwRY49+9xqppVoRLIcJRGbfADlBWfB9SkwWQzKpXP
         X5+t2KkRjF08ucEGPRQ3aW6oAXYmzDWihM++L082UMeBEY29SmIymhXWV98UQZJ+rgc0
         o0UXLXdaQr0Udtaah6P3XUV+erofW8JD8mIoXgnLT9xLlwyd0dwGjEdl8B9DiWFIeM4L
         ErxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=0aISxNq2TCqGaMJ+VstOmIHNsMO1fnVMy6b9Y1Qj+4Y=;
        b=Wk1RZi6WHhN89LP2kZhdPNVIUjmLBW/wUa0OGgPvBlkXbfAJ8YVwE3FbXYY/RJ26LZ
         dGI78DtuqLq/TfDxSI2Lu+osEzoSzxFu4GYrICLyaZoOMKoaAGtL8EvCFZ/zXUIDAvAX
         vUhcj4Hb7n008HiIDYmW3U+g+x5o7WeC0HtZCPwYG4t3TJTzqwqboKHPGBA/FTZOnWmX
         DXBSAjdLqXytJs2rUx5MFrlBZeleg0IVpl5r87g/0+WbuqoR8FfALyx/vhe0IOGdzFVS
         uAmPK3t1nc5f4zlPwFI0kNX/k8ErSS05rrgFR8p4AJ1w33JnY3hV6N3LGx84iyhj8qZj
         byBg==
X-Gm-Message-State: ALoCoQnDapHtr7Dr2FmGZxAsAU1ja6NghQQyz6pi/W0zs9kIXghLfk7xb2HgJluXmUEEg2waOay3iSl7dUrRFzovvrQTi4g9iA==
X-Received: by 10.202.201.77 with SMTP id z74mr101772579oif.24.1452704849756;
        Wed, 13 Jan 2016 09:07:29 -0800 (PST)
Received: from localhost.localdomain ([204.77.163.41])
        by smtp.gmail.com with ESMTPSA id dh8sm996371obb.2.2016.01.13.09.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 09:07:29 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <cover.1452704305.git.dougk.ff7@gmail.com>
In-Reply-To: <cover.1452704305.git.dougk.ff7@gmail.com>
References: <cover.1452704305.git.dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283938>

Explicitly test for and ensure files that may be wanted are not
deleted during a gc operation.  These include .pack without .idx
(which may be in-flight), garbage in the directory, and .keep files
the user created.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 t/t5304-prune.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 4fa6e7a..f7c380c 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -285,6 +285,23 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'ensure unknown garbage kept with gc' '
+	test_when_finished "rm -f .git/objects/pack/fake*" &&
+	test_when_finished "rm -f .git/objects/pack/foo*" &&
+	: >.git/objects/pack/foo.keep &&
+	: >.git/objects/pack/fake.pack &&
+	: >.git/objects/pack/fake2.foo &&
+	git gc &&
+	git count-objects -v 2>stderr &&
+	grep "^warning:" stderr | sort >actual &&
+	cat >expected <<\EOF &&
+warning: garbage found: .git/objects/pack/fake2.foo
+warning: no corresponding .idx or .pack: .git/objects/pack/foo.keep
+warning: no corresponding .idx: .git/objects/pack/fake.pack
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'prune .git/shallow' '
 	SHA1=`echo hi|git commit-tree HEAD^{tree}` &&
 	echo $SHA1 >.git/shallow &&
-- 
2.6.1
