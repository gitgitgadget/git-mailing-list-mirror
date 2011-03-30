From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/2] git-gui: support for underline styles
Date: Wed, 30 Mar 2011 08:44:09 +0200
Message-ID: <2cd6fc8a8da65dc6c2e420d150429b59fdbb3386.1301467146.git.bert.wesarg@googlemail.com>
References: <AANLkTimnX-OJYzSvot-yUMGKXmqJw9deTGS-6mzywoEe@mail.gmail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 08:44:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4p8g-0003ic-BL
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 08:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab1C3GoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 02:44:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42720 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab1C3GoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 02:44:16 -0400
Received: by fxm17 with SMTP id 17so800830fxm.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 23:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=pZust0hSlTXm21i855xXwm8ozt4KsK3LKvNK9gokeuY=;
        b=kp5S3Xi0YP2zQdBJhkN4owvisSFWUKphSGdQZglGxLMBdiX3JwIBe52Ynkk4pjCHLM
         DWnoAYwBexLt2Kkov9ySVyM+XiZNhbZ/38D0mO4d5pJTF7l1wdzk8jVcM8M/pJ0Ag099
         KRBX70ZhBIIs/gcHeUKuLuFerATdzOdzwD41A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I8ccuHhCLP4wVKGTUq5Ljguj5Xmyc/Qvuikq0PH4zg/Hducu2d2ymhCuUPp172yTbu
         LxiB9AmG5e6x00+TtTtm9RgiWhu0TWuWTbMrDz4mWL9VDLwV9C2MDAhTQMimBgQ8iTvO
         v8rtBUZZpkKKMLe6XMv5weJfTqAkAApu+nyPg=
Received: by 10.223.26.205 with SMTP id f13mr792862fac.49.1301467454919;
        Tue, 29 Mar 2011 23:44:14 -0700 (PDT)
Received: from localhost ([141.76.90.212])
        by mx.google.com with ESMTPS id n15sm241096fam.12.2011.03.29.23.44.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 23:44:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.1319.ga04f7.dirty
In-Reply-To: <AANLkTimnX-OJYzSvot-yUMGKXmqJw9deTGS-6mzywoEe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170357>

From: Pat Thoyts <patthoyts@users.sourceforge.net>

From: Pat Thoyts <patthoyts@users.sourceforge.net>

Suggested-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

I left underline out because I reckon it would just make text harder to
read on a gui display. It seems like the option would only be useful on
monochrome terminals.

If we do want to support underlines in the diff view window then we can
have a different tag rather than replicating each color to get a
underlined version of the same color.
Something like the following should do it:
---
 git-gui.sh   |    1 +
 lib/diff.tcl |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index fd6a43d..d5c1535 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3361,6 +3361,7 @@ foreach {n c} {0 black 1 red4 2 green4 3 yellow4 4 blue4 5 magenta4 6 cyan4 7 gr
 	$ui_diff tag configure clri3$n -background $c
 }
 $ui_diff tag configure clr1 -font font_diffbold
+$ui_diff tag configure clr4 -underline 1
 
 $ui_diff tag conf d_info -foreground blue -font font_diffbold
 
diff --git a/lib/diff.tcl b/lib/diff.tcl
index cf8a95e..39e4d90 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -504,7 +504,7 @@ proc read_diff {fd conflict_size cont_info} {
 			set prefix clr
 			foreach style [split $colbegin ";"] {
 				if {$style eq "7"} {append prefix i; continue}
-				if {$style < 30 || $style > 47} {continue}
+				if {$style != 4 && ($style < 30 || $style > 47)} {continue}
 				set a "$mark linestart + $posbegin chars"
 				set b "$mark linestart + $posend chars"
 				catch {$ui_diff tag add $prefix$style $a $b}
-- 
1.7.4.1.1319.ga04f7.dirty
