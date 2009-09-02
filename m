From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v6 6/6] fast-import: test the new option command
Date: Wed,  2 Sep 2009 19:57:03 +0200
Message-ID: <1251914223-31435-7-git-send-email-srabbelier@gmail.com>
References: <1251914223-31435-1-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-2-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-3-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-4-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-5-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-6-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Wed Sep 02 19:58:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miu6H-0007Zr-Lu
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbZIBR5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbZIBR5t
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:57:49 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48496 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbZIBR5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 13:57:47 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so909246bwz.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Jo3zpqeNsccRmi1//jucXUiCaXKivFJmDpmXKev9/7o=;
        b=l1L/qVPjoavr8i9SZ2igNWgFHIPfe4dGtXmnZRTccVcw4A/RaVyAwdCQ3wpEX6UxZA
         BxIMdDzoqcH5dIt6HkMsED2VucS9Q1TAe0FvoYdSD8DQ0N8Dyk6p5AfT0l+opurny3no
         BmmirMv7MaQvCym3McKZa15MM8GlQpUZka47o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mwADr+TtWPHuPc7Bcupg0OmhzLf3OhPQfeuOUL+poMnEbHqSHHXmsa0iFxvHq/+msd
         U7ayW661F/TmplKNbt90gQzlUlGt+161H9sc0VCpoIxjjr4619K0DAWsZDNVW+/lpCO4
         P4rNKQd4xwThSSGAKwf0k9eLtHLKHfjycJp/Q=
Received: by 10.204.156.28 with SMTP id u28mr2401554bkw.74.1251914270011;
        Wed, 02 Sep 2009 10:57:50 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 21sm325505fks.9.2009.09.02.10.57.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 10:57:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1251914223-31435-6-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127620>

Test three options (quiet and import/export-marks) and verify that the
commandline options override these.

Also make sure that a option command without a preceeding feature
git-options command is rejected and that non-git options are ignored.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Tests updated to match the new 'option git' syntax. Also added a
  test to ensure that an option command without a preceeding 'feature
  git-options' is rejected and that non-git options are ignored.

 t/t9300-fast-import.sh |   84 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 83 insertions(+), 1 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 564ed6b..fb795bb 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1089,7 +1089,7 @@ test_expect_success 'P: fail on blob mark in gitlink' '
     test_must_fail git fast-import <input'
 
 ###
-### series R (feature)
+### series R (feature and option)
 ###
 
 cat >input <<EOF
@@ -1108,4 +1108,86 @@ test_expect_success 'R: supported feature is accepted' '
 	git fast-import <input
 '
 
+cat >input << EOF
+feature git-options
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
+cat >input << EOF
+feature git-options
+option git export-marks=git.marks
+blob
+mark :1
+data 3
+hi
+
+EOF
+
+test_expect_success \
+    'R: export-marks option results in a marks file being created' \
+    'cat input | git fast-import &&
+    grep :1 git.marks'
+
+test_expect_success \
+    'R: export-marks options can be overriden by commandline options' \
+    'cat input | git fast-import --export-marks=other.marks &&
+    grep :1 other.marks'
+
+cat >input << EOF
+feature git-options
+option git import-marks=marks.out
+option git export-marks=marks.new
+EOF
+
+test_expect_success \
+    'R: import to output marks works without any content' \
+    'cat input | git fast-import &&
+    test_cmp marks.out marks.new'
+
+cat >input <<EOF
+feature git-options
+option git import-marks=nonexistant.marks
+option git export-marks=marks.new
+EOF
+
+test_expect_success \
+    'R: import marks uses the commandline marks file when the stream specifies one' \
+    'cat input | git fast-import --import-marks=marks.out &&
+    test_cmp marks.out marks.new'
+
+cat >input <<EOF
+feature git-options
+EOF
+
+test_expect_success 'R: feature option is accepted' '
+	  git fast-import <input
+'
+
+cat >input <<EOF
+option git quiet
+EOF
+
+test_expect_success \
+    'R: option without preceeding feature command is rejected' \
+    'test_must_fail git fast-import <input'
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
1.6.4.16.g72c66.dirty
