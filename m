From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 10/16] When debug==1, start fast-import with "--stats" instead of "--quiet".
Date: Mon, 30 Jul 2012 16:31:17 +0200
Message-ID: <1343658683-10713-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:39:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr8P-00086y-J8
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab2G3Oj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:29 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53245 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab2G3Oj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:28 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859181bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2HjI6bwfqbJ+nPKlDNuBmSiR7ygcPPDNYRkmKUnM/w8=;
        b=XZlBhT4pxQD5qCwrwqK87Zofc0rg46FjlBEDYW/BT1AIU/xmtdykLzxi15PB1FZFY7
         XaDN6NjdPWFmE745PK1JdYp+jUqIyTFMUdNOdEAFHqWOwH1f6njyEWnKokmrzoh7cm4o
         l93/pgVpUxXNWUQn6FghDvc+Dhmrx6f1v5P1ik4gXcxSHzEJp1G7kBnT5xMj/lH4w8nV
         3Cq325y67rA7HxLRAdnjbflSv1hFMLhqJD5mJHkz6CE43VwKtbtrwqx2DF0Jga5xi6vI
         Zqpy4L2FEpoS8SpU5D9uBeRlfO+F3TnAyyh8WumRCCZaH3/FbLRVhzp3HWMqcGBhIUOM
         /IoQ==
Received: by 10.204.128.196 with SMTP id l4mr4156643bks.21.1343659167670;
        Mon, 30 Jul 2012 07:39:27 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.26
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202552>

fast-import prints statistics that could be interesting to the
developer of remote helpers.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 616db91..d6daad5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -392,7 +392,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	memset(fastimport, 0, sizeof(*fastimport));
 	fastimport->in = helper->out;
 	argv_array_push(argv, "fast-import");
-	argv_array_push(argv, "--quiet");
+	argv_array_push(argv, debug ? "--stats" : "--quiet");
 	argv_array_pushf(argv, "--cat-blob-pipe=%s", data->report_fifo);
 	fastimport->argv = argv->argv;
 	fastimport->git_cmd = 1;
-- 
1.7.9.5
