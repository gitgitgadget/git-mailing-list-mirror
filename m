From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v8 5/7] fast-import: test the new option command
Date: Fri,  4 Dec 2009 18:06:58 +0100
Message-ID: <1259946420-8845-6-git-send-email-srabbelier@gmail.com>
References: <1259946420-8845-1-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-2-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-3-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-4-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-5-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	<vcs-fast-import-devs@l
X-From: git-owner@vger.kernel.org Fri Dec 04 18:14:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbdF-000621-RI
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbZLDRH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbZLDRH1
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:07:27 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:49611 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbZLDRHR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:07:17 -0500
Received: by ey-out-2122.google.com with SMTP id d26so643444eyd.19
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uAhXStXJo4eGyjnJvv0YD16W6QU4rXAX/kSW7yVgW6E=;
        b=HEY1/jUtZ58bn3Y0PvVVBacjoWfL/Dg61HM9ZzQlVB6eN2/2JDoJb7PPBfhoq9FbR+
         /93qiQSLohKgeljWBIQDW0CTZcyMLuQwrVw7APl+TbfhpCfcMfb3EU7LWvjdJcJShyMi
         myAm2+3wkSuHPP/2BsmHrmpKuzJmSegsve1AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EjlE0i0Y/dS6cK5qSUJ1BXvhbUqyGNenI1JTjSGomGTLl6wUzRuIWiAaopjqm5uxzQ
         tQyR57CYPwIW3T3vPReyMCD122d4pBjUVZsucJxw3BJWgXiI/B1mUxNZ8UUiFPtWKKI3
         KMkHK0G1dAS/4s8SDkYJuqZgFrekLwxUnob4w=
Received: by 10.213.96.229 with SMTP id i37mr3485611ebn.45.1259946443728;
        Fri, 04 Dec 2009 09:07:23 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1980184ewy.14.2009.12.04.09.07.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 09:07:22 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1259946420-8845-5-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134542>

Test the quiet option and verify that the commandline options
override it.

Also make sure that an unknown option command is rejected and that
non-git options are ignored.

Lastly, show that unknown options are rejected when parsed on the
commandline.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Tests updated to match the new behavior.

 t/t9300-fast-import.sh |   37 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index b2c521f..74dff11 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1255,7 +1255,7 @@ test_expect_success \
 	'git cat-file blob refs/notes/foobar:$commit3 >actual && test_cmp expect actual'
 
 ###
-### series R (feature)
+### series R (feature and option)
 ###
 
 cat >input <<EOF
@@ -1324,4 +1324,39 @@ test_expect_success \
     'cat input | git fast-import --import-marks=marks.out &&
     test_cmp marks.out marks.new'
 
+cat >input << EOF
+option git quiet
+blob
+data 3
+hi
+
+EOF
+
+touch empty
+
+test_expect_success 'R: quiet option results in no stats being output' '
+    cat input | git fast-import 2> output &&
+    test_cmp empty output
+'
+
+cat >input <<EOF
+option git non-existing-option
+EOF
+
+test_expect_success 'R: die on unknown option' '
+    test_must_fail git fast-import <input
+'
+
+test_expect_success 'R: unknown commandline options are rejected' '\
+    test_must_fail git fast-import --non-existing-option < /dev/null
+'
+
+cat >input <<EOF
+option non-existing-vcs non-existing-option
+EOF
+
+test_expect_success 'R: ignore non-git options' '
+    git fast-import <input
+'
+
 test_done
-- 
1.6.5.3.164.g07b0c
