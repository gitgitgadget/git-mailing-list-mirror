From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: Teach "Reread references" to reload tags
Date: Sat,  8 Sep 2012 12:03:13 -0700
Message-ID: <1347130993-69863-1-git-send-email-davvid@gmail.com>
References: <7vligmz9zc.fsf@alter.siamese.dyndns.org>
Cc: Tim McCormack <cortex@brainonfire.net>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 21:03:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAQJP-0001fu-9q
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 21:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab2IHTDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 15:03:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54220 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab2IHTDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 15:03:15 -0400
Received: by dady13 with SMTP id y13so507166dad.19
        for <git@vger.kernel.org>; Sat, 08 Sep 2012 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7qYGMbf7GidYUS9wdyd/B0sh6qEwrqMDEdvX8Gnu64E=;
        b=FfKc3/cam69lI9DiKewnX8l84xjNEI5QN10lylx09Mbko+tx9vReO9KC9bBKBotCjl
         tHi2fj4B+NWRJ+SVR0YqTmgQeYj6afv/XqYuTFMa9TB3D3dEAy2PLn8wuhsZYiLzjmhw
         WN02lyznrENiwBDF/eWAeJrjeH7SX28pZKHsoGjpsxMC1gNklpIUdqbMDVPQP8bozLHJ
         IRciDmu4reN1vTNsCLwIHTEkQmJOuNdRWZIoWmYtIp0BZfRV/TilRovoF2z27Pae44hz
         bk6ZmTDTt8VgkrY083w4qjsp7+XLwast4oBgThBfum/Jk8fWqDAv9Wdg+jX+9sDJWViv
         3uTQ==
Received: by 10.68.231.130 with SMTP id tg2mr17019134pbc.70.1347130994817;
        Sat, 08 Sep 2012 12:03:14 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id to6sm5765513pbc.12.2012.09.08.12.03.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Sep 2012 12:03:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.2.448.gee6df
In-Reply-To: <7vligmz9zc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205027>

Tag contents, once read, are forever cached in memory.
This makes gitk unable to notice when tag contents change.

Allow users to cause a reload of the tag contents by using
the "File->Reread references" action.

Reported-by: Tim McCormack <cortex@brainonfire.net>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 gitk |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 9bba9aa..a124822 100755
--- a/gitk
+++ b/gitk
@@ -10599,7 +10599,7 @@ proc movedhead {hid head} {
 }
 
 proc changedrefs {} {
-    global cached_dheads cached_dtags cached_atags
+    global cached_dheads cached_dtags cached_atags tagcontents
     global arctags archeads arcnos arcout idheads idtags
 
     foreach id [concat [array names idheads] [array names idtags]] {
@@ -10611,6 +10611,7 @@ proc changedrefs {} {
 	    }
 	}
     }
+    catch {unset tagcontents}
     catch {unset cached_dtags}
     catch {unset cached_atags}
     catch {unset cached_dheads}
-- 
1.7.7.2.448.gee6df
