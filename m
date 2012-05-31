From: David Barr <davidbarr@google.com>
Subject: [PATCH v2 1/6] vcs-svn: fix clang-analyzer error
Date: Fri,  1 Jun 2012 00:41:25 +1000
Message-ID: <1338475290-22644-2-git-send-email-davidbarr@google.com>
References: <1338475290-22644-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 16:42:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6a8-0003gL-Nf
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072Ab2EaOmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:42:21 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50238 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab2EaOmU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:42:20 -0400
Received: by pbbrp8 with SMTP id rp8so1551829pbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LrEVfTg6Cx0DhQcMEbrEoMip53IzyDiB6xDC0KjdQNs=;
        b=cA3z+k3FCiC5pQmbR9KpMZzP7uvJyszQhW9axvzZiVEctVDPHXYW/pFhETo5OFUeko
         DIDZ4ur4oEVYCCqrQlRe5U4T3fNLWI2evWk6syUi+5XUn+Ty8XqRBHW/1ir27Rugczul
         6Kk59X34h1W9jM/sHE6vIX8KEVFskQkXWT+c9eVI7PKiZu0ATxK0+eLGWlRJ9IstNgoy
         MQBEr5vzNBgOnyXI02gq1e6BnDZfhCaTHqciRTjv8EdtJGMEWPDPszDlBG0ELK1nokZ1
         qORhj9mgii7cQqI42NchakUFOznF5w8fffGpNUCdP0rqOv1clYt6t8YW1W6wWiFz7bEJ
         gidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=LrEVfTg6Cx0DhQcMEbrEoMip53IzyDiB6xDC0KjdQNs=;
        b=JO7ObjLqcwoT22YskMTilabPrJEZ+Uy1mpHRKOEpHR4olfM3WLn8Rqixz/iKzaZ4yh
         Oqa1oRsgLE2BOEp80V+aOPgAHbAEVCo8yh3t0zQDu7Yjo3zDh0KZXMutG2KB+HO1nVTr
         WJm7MWUH1cDIZRzc8Oj8ozw/wibN96BaY8UgVHaot1FwzzFeTamgYLbIAAy5Z1Qpeinf
         tolh/I+k+b8psjam3L0aL/WuebkhICUsdZ3xEtnIXG9hFrmRNMgxHRom1PUj5cz7kzSj
         MKiS6lcCpiw834HX1PuPGKLqSQepy4YMhjzhN3B7Q7JwtyKtutvq2VkfqTLkxw3obAyU
         RJ3A==
Received: by 10.68.211.234 with SMTP id nf10mr373231pbc.121.1338475339895;
        Thu, 31 May 2012 07:42:19 -0700 (PDT)
Received: by 10.68.211.234 with SMTP id nf10mr373204pbc.121.1338475339675;
        Thu, 31 May 2012 07:42:19 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id og6sm4376720pbb.42.2012.05.31.07.42.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:42:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1338475290-22644-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQkXvgHLpyJadPuIAv6mPfCc8WNM760qNVuO4kpuIm9LQd4e8txD1dVvI+TErRj/fbNAAqErnJ3dBBOF57QrZjLCUP9xpT5cFpddBitCiv4Vlw5oEi0wdcGO4K1yXvAtfV0a1dtOMlx7Uq8Tz2N0VqQVjd3XK9AeJDeSZe7j2i/ytMUHIDA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198910>

vcs-svn/svndiff.c:298:3: warning: Assigned value is garbage or undefined
                off_t pre_off = pre_off; /* stupid GCC... */
                ^               ~~~~~~~

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/svndiff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 1647c1a..57d647d 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -295,7 +295,7 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 	if (read_magic(delta, &delta_len))
 		return -1;
 	while (delta_len) {	/* For each window: */
-		off_t pre_off = pre_off; /* stupid GCC... */
+		off_t pre_off = 0; /* stupid GCC and clang-analyzer... */
 		size_t pre_len;
 
 		if (read_offset(delta, &pre_off, &delta_len) ||
-- 
1.7.10.2
