From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH 3/3] fast-import: test the new option command
Date: Sat,  1 Aug 2009 22:06:10 -0700
Message-ID: <1249189570-26576-4-git-send-email-srabbelier@gmail.com>
References: <fabb9a1e0908011829j3843c132ka5081d994aad973f@mail.gmail.com>
 <1249189570-26576-1-git-send-email-srabbelier@gmail.com>
 <1249189570-26576-2-git-send-email-srabbelier@gmail.com>
 <1249189570-26576-3-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 02 07:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXTHw-0001YW-I1
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 07:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbZHBFHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 01:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbZHBFHF
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 01:07:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:52835 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbZHBFHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 01:07:03 -0400
Received: by rv-out-0506.google.com with SMTP id f6so836613rvb.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 22:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JcTuruTjYMtNM8+O9TOv3MPuK6xxXmgzNiwlskqb10M=;
        b=MIjRyKoMNAXJV9i3OL4Mn71QjiINRWVXGTX5ZbghB9ciR40Mh9lDrFmV49nahX6InW
         ErFMC9bX4+qMjPUoRc2Hzgy/oCC0hczeM7j4K+A5iwfbxn3DTd/u5O19hi+22b4J5Jcd
         UATHD+YtXy7pYXg3rIHR9mjGtAefDWcQEw8Mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AQQK1ElznWR7uEa9vN5s5orv60EgB4kSOxzwGTsTHuIhwSprVjGS0PpITwMkgpMj57
         8r1+4gYHZuHUjZY1O1v2mP3mTcQoJTVT5lLC7sCL97yI8k4N5kCU7c0oAgpDQnIqipHW
         QHCRw0BTf548F0+fvY5AzjTXyifXlGrjOHke8=
Received: by 10.140.142.11 with SMTP id p11mr2896917rvd.191.1249189624230;
        Sat, 01 Aug 2009 22:07:04 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm27870127rvb.40.2009.08.01.22.07.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 22:07:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.15.g8b2be
In-Reply-To: <1249189570-26576-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124665>

Test the new 'option' command to fast-import to make sure that they
indeed affect the behavior in the same way as the commandline
options.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

    Since the option code is now very similar, I feel confident that
    it works after testing two random [0] options.

    [0] where with random I mean 'easy to test'

 t/t9300-fast-import.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 821be7c..a5afe9a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1088,4 +1088,37 @@ INPUT_END
 test_expect_success 'P: fail on blob mark in gitlink' '
     test_must_fail git fast-import <input'
 
+###
+### series Q (options)
+###
+
+cat >input << EOF
+option quiet
+blob
+data 3
+hi
+
+EOF
+
+touch empty
+
+test_expect_success 'Q: quiet option results in no stats being output' '
+    cat input | git fast-import 2> output &&
+    test_cmp empty output
+'
+
+cat >input << EOF
+option export-marks git.marks
+blob
+mark :1
+data 3
+hi
+
+EOF
+
+test_expect_success \
+    'Q: export-marks option results in a marks file being created' \
+    'cat input | git fast-import 2> output &&
+    grep :1 git.marks'
+
 test_done
-- 
1.6.4.15.g8b2be
