From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 2/7] clone: also configure url for bare clones
Date: Mon, 29 Mar 2010 11:48:24 -0500
Message-ID: <1269881309-19690-3-git-send-email-srabbelier@gmail.com>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jonathan Niede
X-From: git-owner@vger.kernel.org Mon Mar 29 18:48:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwI8x-0007Vo-P3
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901Ab0C2Qss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:48:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60022 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab0C2Qsr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:48:47 -0400
Received: by pwi5 with SMTP id 5so6755854pwi.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Tk5E9bS4NcQ92AfTwWNZOkYdKwZLNU4QXT/dzdvzyPY=;
        b=AoNxldhB23QUkyfZAn5ix6MF0B481n1oTT9fEGbgRlmH4RMHPmQtnj+mQeT8gTiHTB
         VtZtbU+7sPLEfuYmp2ilT0KdWFEYdfPy38A1lXWbB6zxaQ5HHAGGGZrOMk8YNZs9hCKv
         c2aiWa41NbXRaFJgZ3CiRh3PFEC3Jx9CKF2ic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=N185WQdeWCeOE7L2JfoXi2kEwCJ1ciTk6PQOrURZFH8eJWz46PDKDDg5GeVrN+EqHx
         xK7n9pmYEMfvM+R5mlDYA46BMTYvbbAq8cmxKRuHCZjrl742eAIqI06yCiPo4jpU+uQH
         AMb5HPQQoujkSFPmaszi2gLWivjs2tRGgDJ6w=
Received: by 10.141.23.17 with SMTP id a17mr4556071rvj.294.1269881325911;
        Mon, 29 Mar 2010 09:48:45 -0700 (PDT)
Received: from localhost.localdomain (97-114-181-145.frgo.qwest.net [97.114.181.145])
        by mx.google.com with ESMTPS id 23sm4102040iwn.10.2010.03.29.09.48.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 09:48:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.317.gbb04ec
In-Reply-To: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143493>

Without this the 'origin' remote would not be configured, so when
calling remote_get with 'origin' as argument we would get an
unconfigured remote.
---

	Turns out there was one use-case that is not exercised by the
	test suite. The remote-helper tests later in the series do
	exercised that path, but we might want a seperate test.

 builtin/clone.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 068d61f..05be999 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -495,12 +495,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			git_config_set(key.buf, "true");
 			strbuf_reset(&key);
 		}
-
-		strbuf_addf(&key, "remote.%s.url", option_origin);
-		git_config_set(key.buf, repo);
-		strbuf_reset(&key);
 	}
 
+	strbuf_addf(&key, "remote.%s.url", option_origin);
+	git_config_set(key.buf, repo);
+	strbuf_reset(&key);
+
 	if (option_reference)
 		setup_reference(git_dir);
 
-- 
1.7.0.3.317.gbb04ec
