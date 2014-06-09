From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 15/19] remote-curl: simplify via strbuf_set()
Date: Mon,  9 Jun 2014 15:19:34 -0700
Message-ID: <f455f552910af710f2766d272db61ae62e4a7b8f.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:21:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7wV-00016T-3j
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbaFIWVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:21:22 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:56128 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWVV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:21:21 -0400
Received: by mail-pd0-f171.google.com with SMTP id ft15so99437pdb.2
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sai7ocmgcn+2PnaJGbu4wyEr6VoCfV6VF4QrZBU/gTc=;
        b=Ft1yJobEQ9MAnxXfsehgUpT/Fu2MTVNNqjBFws1e78mkw8CFbpsnG88rE6x92Kjqye
         JtdEpJEiy39GxZ4TeTDH07S6rz34i+IvS37vzNCbZt2g65aHNK+Ba2e1pgLsdtG19ver
         2XdPIEm/MKEY5lTWOiUFxvtCNqfcLawHVFg49zYqT2NnyekMpRRrJ3ccf1OU6RgdkAsR
         Qa3MgsKD9hHHUuOYB5+IurhGAQUlsh6OrZ1WC855Zk8fbCJtDJIEvUJNoiXMLAEu56ik
         LMp9jtnb5i3zuiRg3484x3qJ99WiLyQEYeXbxfX+EbVSUcV/uO5DLokwVBPEQNfbKh61
         easA==
X-Received: by 10.66.66.108 with SMTP id e12mr1116003pat.35.1402352480845;
        Mon, 09 Jun 2014 15:21:20 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id fe2sm65778783pbc.68.2014.06.09.15.21.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:21:19 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:21:16 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251123>

Simplify cases where a strbuf_reset is immediately followed by a
strbuf_add by using strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 remote-curl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 4493b38..49d27f5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -288,8 +288,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 		 */
 		line = packet_read_line_buf(&last->buf, &last->len, NULL);
 
-		strbuf_reset(&exp);
-		strbuf_addf(&exp, "# service=%s", service);
+		strbuf_setf(&exp, "# service=%s", service);
 		if (strcmp(line, exp.buf))
 			die("invalid server response; got '%s'", line);
 		strbuf_release(&exp);
-- 
2.0.0.592.gf55b190
