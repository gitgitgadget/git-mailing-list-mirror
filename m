From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 18/19] vcs-svn/svndump: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:37 -0700
Message-ID: <1ec2ae837728a223871090fe386bdfc99da84aba.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7wg-0001GZ-7j
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbaFIWVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:21:34 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:64947 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:21:32 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so5422702pbc.26
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HstYzyR4fT2ZW8oSuSotmZRli6kxtkVLvvQdmQeaWh0=;
        b=LnNK35hWRDPVtaLDoSdLmlcuXBUzdCttWtMANHFL1GuPl6dM8/g4Mw669AiMeSriir
         gpvpQPFyGQVQsNxhsKbj9idwginRJ4gqZPhRmLHpgGXqa4S9p4HFVEyPNlv1XMrfj8Ig
         corfDHlHGd5tp7EmFKRNNebr3kcbU7jjspQiI/GYZfyfiR9bcYu92hblrU3hApar8K+N
         eKJST4c4WNrN1Fz1Q9g9/bLTJMh+kPluoDREV/tFXRE9uxuhRF7GZ7bJSkc3MNnuTcML
         3zwI3UfwR0VZYO2s3IEs69eWWVC4tiO7y2+qrejjZjYO07b4OfJiM8AhyK87OZqueN51
         a0mQ==
X-Received: by 10.68.135.100 with SMTP id pr4mr7511402pbb.46.1402352492529;
        Mon, 09 Jun 2014 15:21:32 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id bu3sm2704151pac.28.2014.06.09.15.21.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:21:31 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:21:28 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251126>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 vcs-svn/svndump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 31d1d83..7fbf5d8 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -352,8 +352,7 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 		case sizeof("UUID"):
 			if (constcmp(t, "UUID"))
 				continue;
-			strbuf_reset(&dump_ctx.uuid);
-			strbuf_addstr(&dump_ctx.uuid, val);
+			strbuf_setstr(&dump_ctx.uuid, val);
 			break;
 		case sizeof("Revision-number"):
 			if (constcmp(t, "Revision-number"))
-- 
2.0.0.592.gf55b190
