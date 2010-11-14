From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/4] builtin: use builtin.h for all builtin commands
Date: Sun, 14 Nov 2010 14:44:17 +0000
Message-ID: <1289745857-16704-5-git-send-email-avarab@gmail.com>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 15:45:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHdq4-0003gO-Ek
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 15:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942Ab0KNOpe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 09:45:34 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45426 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab0KNOpc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 09:45:32 -0500
Received: by wwb29 with SMTP id 29so485167wwb.1
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 06:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ldYgJHHg51LA9hCgyXMkcV6ZOaE0bmHZvc8biLa/OfQ=;
        b=U1SbT/lXTYTKC/8bBkC2IXEZqKUaxbt1KfVV1jmJ6/zu5cfqW4qPDtJBEwYcdz8+d1
         2POTOIu3r/IC7eoehKX0Gli+fp7d/1qDLspFq63Zp2pfcQGzf6Mok8iaxawVJuSEj2/g
         PelVYzebm/uuUMoNTVoXOXtSiv6vAKo5+85y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SqsVzGbAuXB7fE4oC6q3t3DpFcmb9lP4pYG7DlSjpENIQNvaqHgdHjyVyt7mW4CfRM
         JGvH3hldg/nZB6vSxR8eixjRR3tyDdLrV2L62qbOcPxltPT9MPSokXE19NwBe8FfCc+k
         rGYXCtfyOB9mJ3QXZlNs2iueybpQT1PaXi7+8=
Received: by 10.216.158.140 with SMTP id q12mr5767839wek.14.1289745931265;
        Sun, 14 Nov 2010 06:45:31 -0800 (PST)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id y15sm3208613weq.6.2010.11.14.06.45.30
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 06:45:30 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.326.g36065a
In-Reply-To: <1289745857-16704-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161414>

Change the builtin/*.c files and wt-status.c files which weren't using
builtin.h to use it, also remove any git-compat-util.h, strbuf.h and
cache.h from those files. We can trust on builtin.h including them.

builtin.h also includes commit.h and notes.h. But I haven't removed
these includes. They're redundant now, but we may want to remove them
from builtin.h in the future.

This impeded my efforts to gettextize git, since I'd otherwise have to
add gettext.h to all of these. Using builtin.h is a good idea in any
case, since it's defining the prototypes for the cmd_* functions that
these files define.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clone.c           |    3 +--
 builtin/fetch-pack.c      |    2 +-
 builtin/hash-object.c     |    2 +-
 builtin/index-pack.c      |    2 +-
 builtin/merge-index.c     |    2 +-
 builtin/merge-recursive.c |    2 +-
 builtin/merge-tree.c      |    2 +-
 builtin/mktag.c           |    2 +-
 builtin/pack-redundant.c  |    2 +-
 builtin/pack-refs.c       |    2 +-
 builtin/patch-id.c        |    2 +-
 builtin/receive-pack.c    |    2 +-
 builtin/remote.c          |    3 +--
 builtin/reset.c           |    2 +-
 builtin/send-pack.c       |    2 +-
 builtin/unpack-file.c     |    2 +-
 builtin/var.c             |    2 +-
 wt-status.c               |    2 +-
 18 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 19ed640..994d527 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -8,7 +8,7 @@
  * Clone a repository into a different directory that does not yet exi=
st.
  */
=20
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "fetch-pack.h"
 #include "refs.h"
@@ -16,7 +16,6 @@
 #include "tree-walk.h"
 #include "unpack-trees.h"
 #include "transport.h"
-#include "strbuf.h"
 #include "dir.h"
 #include "pack-refs.h"
 #include "sigchain.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..fd70b4c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "commit.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 080af1a..8a5670f 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -4,7 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  * Copyright (C) Junio C Hamano, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8dc5c0b..8d1af06 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 2c4cf5e..adc2a6d 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "run-command.h"
 #include "exec_cmd.h"
=20
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index c33091b..3a64f5d 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "commit.h"
 #include "tag.h"
 #include "merge-recursive.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 9b25ddc..1991742 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "blob.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 1cb0f3f..9148cc0 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "tag.h"
 #include "exec_cmd.h"
=20
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 41e1615..a15e366 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -6,7 +6,7 @@
 *
 */
=20
-#include "cache.h"
+#include "builtin.h"
 #include "exec_cmd.h"
=20
 #define BLKSIZE 512
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 091860b..39a9d89 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "pack-refs.h"
=20
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 5125300..33e9725 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "exec_cmd.h"
=20
 static void flush_current_id(int patchlen, unsigned char *id, git_SHA_=
CTX *c)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 760817d..f64b79c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "pack.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index e9a6e09..37c3595 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,9 +1,8 @@
-#include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "transport.h"
 #include "remote.h"
 #include "string-list.h"
-#include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
=20
diff --git a/builtin/reset.c b/builtin/reset.c
index 0037be4..c198b8e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
  */
-#include "cache.h"
+#include "builtin.h"
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..a55a517 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "commit.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 608590a..c905d80 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "blob.h"
 #include "exec_cmd.h"
=20
diff --git a/builtin/var.c b/builtin/var.c
index 0744bb8..1787771 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Eric Biederman, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "exec_cmd.h"
=20
 static const char var_usage[] =3D "git var (-l | <variable>)";
diff --git a/wt-status.c b/wt-status.c
index fc2438f..bfc97fb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "wt-status.h"
 #include "object.h"
 #include "dir.h"
--=20
1.7.2.3
