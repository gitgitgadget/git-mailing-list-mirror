From: Alexey Borzenkov <snaury@gmail.com>
Subject: [PATCH] gitk: restore wm state to normal before saving geometry 
	information
Date: Tue, 8 Sep 2009 22:44:20 +0400
Message-ID: <e2480c70909081144m7bd936fawfade280488cb0680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 20:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml5lS-0006Q5-1M
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 20:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbZIHStw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 14:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbZIHStw
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 14:49:52 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:60559 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbZIHStw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 14:49:52 -0400
Received: by fxm17 with SMTP id 17so2871053fxm.37
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=bu4Ng4U9zIK5dkhzRP/0u4md5n4Aw+u85P+F+hRgQ+g=;
        b=FHUpderPAbJ3JBoqCI5hJD1M8GNscu4SdLMjeP0ga/icJiaUl4CwSSTjoS15OoEe/J
         5HFlXxR8Khh3PUCbwsyQjL+hsCe8Z989AkMbDdNNKN+PSmP3MUGCXLfAYgAigObtPHyQ
         9hHPyeGykyT4Y07rzpSaenw8++o0f6vxv4N1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=KBV9VAbqDwfosRfesocBK67v72xuVPbK4JR13bkW5q1omHJI5x5vaBqTe4nn9tOWd/
         wgTDV6TLu06VFymMUi7yDMmYSyfBU09nEWB9yChs3yHWI/u09uAJJSxpOyguKhIdveiP
         uN0NiALuHg9NvAOzybSn30xj6GP053HDZALpQ=
Received: by 10.223.73.20 with SMTP id o20mr3201370faj.71.1252435460058; Tue, 
	08 Sep 2009 11:44:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128022>

gitk now includes patches for saving and restoring wm state, however
because it saves wm geometry when window can still be maximized the
maximize/restore button becomes useless after restarting gitk (you
will get a huge displaced window if you try to restore it). This
patch fixes this issue by storing window geometry in normal state.

Signed-off-by: Alexey Borzenkov <snaury@gmail.com>
---
 Please don't forget to cc me if you have comments/questions

 gitk |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 8c08310..fedeb88 100755
--- a/gitk
+++ b/gitk
@@ -2555,8 +2555,11 @@ proc savestuff {w} {
 	puts $f [list set extdifftool $extdifftool]
 	puts $f [list set perfile_attrs $perfile_attrs]

-	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(state) [wm state .]"
+	if {[wm state .] eq {zoomed}} {
+		wm state . normal
+	}
+	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
         puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sash
coord 0]\""
-- 
1.6.4.2
