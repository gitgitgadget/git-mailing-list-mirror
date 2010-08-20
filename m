From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 1/5] parse-options: Allow PARSE_OPT_NOARG in integer arguments
Date: Sat, 21 Aug 2010 00:44:58 +0530
Message-ID: <1282331702-5115-2-git-send-email-artagnon@gmail.com>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 21:17:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmX5n-0006w7-3k
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 21:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab0HTTRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 15:17:23 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56173 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0HTTRV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 15:17:21 -0400
Received: by pzk26 with SMTP id 26so1348587pzk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ey0kKOFXrjWALj1RO9Wq1WCy1M4GXTU/pyixhJQzMsg=;
        b=Nzwg4o/ZZgbhW9Fjwl5IQulGGgMYxp7g2yYpT0M6jy21w5P4SfElhM49vY/DBEX6QN
         YkW72QLdglDft43fl6+wv8oI4vi6+v8rdehelaC4LYAhfZnqDGzF9g91yTsfCDbLJ474
         BdVRm29DfZt0PlMMpjquShaKe41dnR2VaJwes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nRkz5ol7qodyVzP+QdSUaSSffjI1jQfikBzcB8h8EIRMd/EMXy/8Z654BCZ2Zot9xh
         b0jfaYQgbUZ9KRFZrDM+Guap5kJiQfQb9FfhQNi5qYUEMA0xbcjbTdpjGSYMZ5UtqS6j
         a7Cbp7nj6QvsdaQa7LgPiOyX6puvSUy+uBnD0=
Received: by 10.142.135.9 with SMTP id i9mr1314021wfd.336.1282331840973;
        Fri, 20 Aug 2010 12:17:20 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm3610572wff.7.2010.08.20.12.17.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 12:17:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154070>

When the option parser encounters an OPTION_INTEGER argument,
PARSE_OPT_NOARG should imply that the default value should be used.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
---
 parse-options.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e0c3641..7ec9886 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -138,6 +138,9 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(int *)opt->value = 0;
 			return 0;
 		}
+		if (opt->flags & PARSE_OPT_NOARG)
+			*(int *)opt->value = opt->defval;
+			return 0;
 		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
 			*(int *)opt->value = opt->defval;
 			return 0;
-- 
1.7.2.2.409.gdbb11.dirty
