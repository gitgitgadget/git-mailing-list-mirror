From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [patch 04/16] Without this patch at least IBM VisualAge C 5.0
 (I have 5.0.2) on AIX 5.1 fails to compile git.
Date: Tue, 27 Apr 2010 18:08:58 +0200
Message-ID: <4BD70C1A.80709@spacetec.no>
References: <20100427135708.258636000@mlists.thewrittenword.com> <20100427135823.017417000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 18:09:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6nLS-0005Ms-Sc
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 18:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab0D0QJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 12:09:04 -0400
Received: from puck.spacetec.no ([192.51.5.29]:44625 "HELO puck.spacetec.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755609Ab0D0QJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 12:09:01 -0400
Received: (qmail 27588 invoked from network); 27 Apr 2010 16:08:58 -0000
Received: from ringworld4.spacetec.no (HELO ?10.10.1.233?) (tor@10.10.1.233)
  by puck.spacetec.no with ESMTPA; 27 Apr 2010 16:08:58 -0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100411 Iceowl/1.0b1 Icedove/3.0.4
In-Reply-To: <20100427135823.017417000@mlists.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145928>

On Tue, Apr 27, 2010 at 15:57, Gary V. Vaughan <git@mlists.thewrittenword.com> wrote:
> enum style is inconsistent already, with some enums declared on one
> line, some over 3 lines with the enum values all on the middle line,
> sometimes with 1 enum value per line... and independently of that the
> trailing comma is sometimes present and other times absent, often
> mixing with/without trailing comma styles in a single file, and
> sometimes in consecutive enum declarations.
>
> Clearly, omitting the comma is the more portable style, and this patch
> changes all enum declarations to use the portable omitted dangling
> comma style consistently.
> ---
>  attr.h                 |    2 +-
>  builtin/apply.c        |    4 ++--
>  builtin/branch.c       |    4 ++--
>  builtin/commit.c       |    6 +++---
>  builtin/help.c         |    2 +-
>  builtin/mailinfo.c     |    4 ++--
>  builtin/receive-pack.c |    2 +-
>  builtin/remote.c       |    2 +-
>  cache.h                |   16 ++++++++--------
>  commit.h               |    2 +-
>  connect.c              |    2 +-
>  ctype.c                |    2 +-
>  diff.h                 |    2 +-
>  dir.c                  |    6 +++---
>  fast-import.c          |    2 +-
>  grep.h                 |    8 ++++----
>  http-push.c            |    2 +-
>  http-walker.c          |    2 +-
>  imap-send.c            |    2 +-
>  merge-recursive.h      |    2 +-
>  parse-options.h        |    6 +++---
>  pretty.c               |    2 +-
>  remote.h               |    2 +-
>  rerere.c               |    2 +-
>  revision.c             |    2 +-
>  wt-status.h            |    2 +-
>  26 files changed, 45 insertions(+), 45 deletions(-)

The patch is against master. Are we supposed to make patches against master or maint? (I thought I saw the latter somewhere. I'm pretty new in here though..)

I can confirm that master doesn't compile on AIX 5.1 with the IBM VisualAge compiler V5 (V5.0.2) without the patch above, and it does compile with the patch:

Tested-by: Tor Arntsen <tor@spacetec.no>

but with the following caveats:

1: With the patch, it'll build with configure (and only configure), run like so:

./configure --enable-pthreads=-lpthread CFLAGS=-Dinline=''

In other words, this system would also need an AIX version of the 'no-inline' patch you did for HP-UX.

And without the --enable-pthreads=-lpthread above it'll try to link with -pthread, which won't work for this system.

The const-expr patch is also useful for AIX-5.1 / XlC V5.0.2. It does build without, but with warnings.

2: The compiler cannot build on AIX 5.1 without the following additional patch (against master. maint has similar problems but files have been moved):

>From a8989213b4c8baa53c14c1f227b916910265c517 Mon Sep 17 00:00:00 2001
From: Tor Arntsen <tor@spacetec.no>
Date: Tue, 27 Apr 2010 16:05:12 +0000
Subject: [PATCH 2/2] C99 comments changed to old-style C comments

Signed-off-by: Tor Arntsen <tor@spacetec.no>
---
 builtin/blame.c        |    2 +-
 builtin/for-each-ref.c |    4 ++--
 remote.c               |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index fc15863..4dd4c3f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1589,7 +1589,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
 	printf("%s%c%d %d %d\n",
 	       hex,
-	       ent->guilty ? ' ' : '*', // purely for debugging
+	       ent->guilty ? ' ' : '*', /* purely for debugging */
 	       ent->s_lno + 1,
 	       ent->lno + 1,
 	       ent->num_lines);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 62be1bb..7f5011f 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -549,10 +549,10 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 		grab_person("committer", val, deref, obj, buf, sz);
 		break;
 	case OBJ_TREE:
-		// grab_tree_values(val, deref, obj, buf, sz);
+		/* grab_tree_values(val, deref, obj, buf, sz); */
 		break;
 	case OBJ_BLOB:
-		// grab_blob_values(val, deref, obj, buf, sz);
+		/* grab_blob_values(val, deref, obj, buf, sz); */
 		break;
 	default:
 		die("Eh?  Object of type %d?", obj->type);
diff --git a/remote.c b/remote.c
index c70181c..26ce560 100644
--- a/remote.c
+++ b/remote.c
@@ -476,7 +476,7 @@ static void read_config(void)
 	unsigned char sha1[20];
 	const char *head_ref;
 	int flag;
-	if (default_remote_name) // did this already
+	if (default_remote_name) /* did this already */
 		return;
 	default_remote_name = xstrdup("origin");
 	current_branch = NULL;
-- 
1.7.1.rc1.GIT
