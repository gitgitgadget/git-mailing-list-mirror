From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 01/10] transport-helper: add 'force' to 'export' helpers
Date: Sun, 27 Oct 2013 01:05:17 -0600
Message-ID: <1382857521-7005-7-git-send-email-felipe.contreras@gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 08:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaKWd-0006wv-4A
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 08:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab3J0HMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 03:12:30 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36681 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab3J0HMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 03:12:15 -0400
Received: by mail-ob0-f179.google.com with SMTP id uy5so2487639obc.10
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNF8O8Ly8erXrmwiRrVN4magZY7Edsy0KXJPXWdVkIE=;
        b=1DfTiwKzic27HCLjsi5bTtDlvkamubAukV5V886H6+mehxh+dWdu+VKqufV/dA0/yJ
         mQemHesQeRRjfhXX6w0wipuJWLfWOZ6MhASXQsaX/lJUGF0IF7lfJXwdvxb+FqX+RNMH
         sGrikHzm1O7F+SouauRuMxOaYeuN63KA60TdaAAGI9RszU75CcdDdcLhgNEMZIMOsNf7
         c3BH/dTUZXY4XgRfACi0o0Hri2QOAljzMyr9MStp4TKUVs/GiQ6W6wxTJTSoE9K18XgA
         1zy7tShyhUv+uPUHcKmuxIAdjWvAwFpnTaFpfQnlG6HcozuDwHhg5HRU5gzi/9Texxtv
         Xd4g==
X-Received: by 10.60.149.169 with SMTP id ub9mr9655554oeb.39.1382857935293;
        Sun, 27 Oct 2013 00:12:15 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id jz7sm22405456oeb.4.2013.10.27.00.12.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 00:12:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236788>

Otherwise they cannot know when to force the push or not (other than
hacks).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index b32e2d6..408d596 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -853,6 +853,11 @@ static int push_refs_with_export(struct transport *transport,
 			die("helper %s does not support dry-run", data->name);
 	}
 
+	if (flags & TRANSPORT_PUSH_FORCE) {
+		if (set_helper_option(transport, "force", "true") != 0)
+			die("helper %s does not support 'force'", data->name);
+	}
+
 	helper = get_helper(transport);
 
 	write_constant(helper->in, "export\n");
-- 
1.8.4-fc
