From: David Michael <fedora.dm0@gmail.com>
Subject: [PATCH] git-compat-util.h: Provide missing netdb.h definitions
Date: Mon, 25 Feb 2013 14:30:19 -0500
Message-ID: <CAEvUa7n_EsKnKQNuyvSiZW8s_rZv4oQrFNDX9wa_JSr_REj89w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:30:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3l7-0005Qx-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759475Ab3BYTaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 14:30:20 -0500
Received: from mail-ve0-f170.google.com ([209.85.128.170]:54532 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759188Ab3BYTaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:30:20 -0500
Received: by mail-ve0-f170.google.com with SMTP id 14so2552828vea.1
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 11:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=wNpxGkuDSpS1kKYhnv0UjOnaVdTqSgfbF0LQmQAZNhM=;
        b=RaapSEyC2lU/WpCdgzZeXF6G92cNko9UyMRcAHSIMwApXhov+GwgjpRryNIwlyrVIR
         DXfBL1jmk/nNVt777qLImb/eKHPupKU8gthdAOiOU7XAIAMLSY60D+6hin2yqvqOTLP+
         JB5mX3SLQNSwmu/EFvtRwg1otobWEs2ooDVzFCh6lAKjMUr7TKw0ucL2m8bxmK5RZnIS
         Fsf0YFBMKnmzvzFhthUt/aWo8qHCCPLdK4VMyyd1AH0D9VfAtbTKxwo8xUZezygb2vlq
         9YDj0vdPF+odVl2AVWjAGZbAjgn/Gpfq4aUdA7vNUTKox7wpy4OxqG8ZyVVuODl9hqW7
         8asg==
X-Received: by 10.52.69.232 with SMTP id h8mr9291468vdu.26.1361820619142; Mon,
 25 Feb 2013 11:30:19 -0800 (PST)
Received: by 10.58.45.3 with HTTP; Mon, 25 Feb 2013 11:30:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217092>

Some platforms may lack the NI_MAXHOST and NI_MAXSERV values in their
system headers, so ensure they are available.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---

NI_MAXHOST is missing from my platform, and it has no compatibility
definition anywhere.

    $ grep -FIR NI_MAXHOST
    imap-send.c:            char addr[NI_MAXHOST];
    connect.c:    static char addr[NI_MAXHOST];

I've been defining it in CFLAGS, but I noticed there is precedence for
this type of definition in git-compat-util.h.  This patch adds a
definition for compatibility.

In addition, all the documentation I've seen mentions NI_MAXHOST and
NI_MAXSERV together, so this also moves the NI_MAXSERV definition to
git-compat-util.h for consistency.

 daemon.c          |  4 ----
 git-compat-util.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4602b46..df8c0ab 100644
--- a/daemon.c
+++ b/daemon.c
@@ -9,10 +9,6 @@
 #define HOST_NAME_MAX 256
 #endif

-#ifndef NI_MAXSERV
-#define NI_MAXSERV 32
-#endif
-
 #ifdef NO_INITGROUPS
 #define initgroups(x, y) (0) /* nothing */
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index b7eaaa9..2580c6b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -213,6 +213,17 @@ extern char *gitbasename(char *);
 #include <openssl/err.h>
 #endif

+/* On most systems <netdb.h> would have given us this, but
+ * not on some systems (e.g. z/OS).
+ */
+#ifndef NI_MAXHOST
+#define NI_MAXHOST 1025
+#endif
+
+#ifndef NI_MAXSERV
+#define NI_MAXSERV 32
+#endif
+
 /* On most systems <limits.h> would have given us this, but
  * not on some systems (e.g. GNU/Hurd).
  */
--
1.8.1.2
