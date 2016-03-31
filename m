From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/5] recursive submodules: test for relative paths
Date: Thu, 31 Mar 2016 14:04:36 -0700
Message-ID: <1459458280-17619-2-git-send-email-sbeller@google.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
Cc: sunshine@sunshineco.com, jacob.keller@gmail.com,
	norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 23:05:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljm7-00007s-SJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 23:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933087AbcCaVFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 17:05:00 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34655 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933072AbcCaVEp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 17:04:45 -0400
Received: by mail-pf0-f171.google.com with SMTP id x3so77615664pfb.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oT5CQsJ1PNN0r9VERCtzpIPQb3WF5V0bLaNATleiFFA=;
        b=ESUgssoFowDW7pCbKyNZyecCiacrxk5DiJYvig3azMkj6bB0Jb3pAnVqbtlVYMbL+5
         DWsTwUG08DKZ5TSO75WEpiZjZSn5Qlac6RfsY+vCUFEyFNzhEGAUYSxuc4Sqi8mgGc8X
         1cnK0FTnHmtwRNLzfjXo3ULA30lloPuKOg0IZRRfMpvwgXjrGBGvSIppktQTpy7j69Se
         y/mkbKtvD76dLc4x1J6zBrZtWOrdLFRgP5KKP1KGEwB+mkQ765VYhUY/YM63Mnks7bM+
         9F4YxmKBc68DjDIWHLYmJO9sl48SZq6jAFAsmByVNqyes/bCi9igEk4baH9uXjyc69b0
         nYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oT5CQsJ1PNN0r9VERCtzpIPQb3WF5V0bLaNATleiFFA=;
        b=S2BeOwtfYLTPovY9zgvDdrZvBsvOGgrEyXyZWZIm66+ddzPDJtPrD7uaJIvVsACdsS
         j7GkeoGFQ+mAlHeCEM4PUs1gMeGZ19HxvmMGYC9USU5PjUPhBzlOPlQqBfBeeIT+iB6Q
         lh3j+lndvZKXjYHHz2crJc0bCB1Gx//X2GlSImSkikesNsDteQFpFPcksQ0yV1e5Soo7
         Tbj77HzszxfPnC2yMLWDF5j3qN4/vhnLMMJaZWwSNqCSislJ1Mi7tNpo347zk4Ynhou6
         iJXIB6Ju+o1/vCDmTq1MuNL5lfolFxkXiwjTd/iLF8wVkTa+OTRfYiwegN5R2cICw/im
         xK1w==
X-Gm-Message-State: AD7BkJLdbZLSDkpPM7DPdScuGi6RJLbkajyXE/tzo7LerSTbgnT22k1CeGoFHcYNRTqdxKPg
X-Received: by 10.98.18.71 with SMTP id a68mr25152115pfj.41.1459458284592;
        Thu, 31 Mar 2016 14:04:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id l81sm15493522pfj.21.2016.03.31.14.04.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 14:04:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g39f00fe
In-Reply-To: <1459458280-17619-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290472>

"git submodule update --init --recursive" uses full path to refer to
the true location of the repository in the "gitdir:" pointer for
nested submodules; the command used to use relative paths.

This was reported by Norio Nomura in $gmane/290280.

The root cause for that bug is in using recursive submodules as
their relative path handling was broken in ee8838d (2015-09-08,
submodule: rewrite `module_clone` shell function in C).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7400-submodule-basic.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 540771c..fc11809 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -818,6 +818,47 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
 	)
 '
 
+test_expect_failure 'recursive relative submodules stay relative' '
+	test_when_finished "rm -rf super clone2 subsub sub3" &&
+	mkdir subsub &&
+	(
+		cd subsub &&
+		git init &&
+		>t &&
+		git add t &&
+		git commit -m "initial commit"
+	) &&
+	mkdir sub3 &&
+	(
+		cd sub3 &&
+		git init &&
+		>t &&
+		git add t &&
+		git commit -m "initial commit" &&
+		git submodule add ../subsub dirdir/subsub &&
+		git commit -m "add submodule subsub"
+	) &&
+	mkdir super &&
+	(
+		cd super &&
+		git init &&
+		>t &&
+		git add t &&
+		git commit -m "initial commit" &&
+		git submodule add ../sub3 &&
+		git commit -m "add submodule sub"
+	) &&
+	git clone super clone2 &&
+	(
+		cd clone2 &&
+		git submodule update --init --recursive &&
+		echo "gitdir: ../.git/modules/sub3" >./sub3/.git_expect &&
+		echo "gitdir: ../../../.git/modules/sub3/modules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
+	) &&
+	test_cmp clone2/sub3/.git_expect clone2/sub3/.git &&
+	test_cmp clone2/sub3/dirdir/subsub/.git_expect clone2/sub3/dirdir/subsub/.git
+'
+
 test_expect_success 'submodule add with an existing name fails unless forced' '
 	(
 		cd addtest2 &&
-- 
2.5.0.264.g39f00fe
