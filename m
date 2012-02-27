From: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>
Subject: [PATCH 2/2] builtin/symbolic-ref.c: add option to output shortened ref
Date: Mon, 27 Feb 2012 23:10:38 +0100
Message-ID: <1330380638-9738-1-git-send-email-jk@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 23:10:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S28mN-0001B4-Qe
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 23:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788Ab2B0WKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 17:10:43 -0500
Received: from zoidberg.org ([88.198.6.61]:42869 "EHLO heapsort.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237Ab2B0WKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 17:10:43 -0500
Received: from perceptron.heapsort.bogus (xdsl-89-0-11-50.netcologne.de [::ffff:89.0.11.50])
  (AUTH: PLAIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu with esmtp; Mon, 27 Feb 2012 23:10:40 +0100
  id 00400F65.4F4BFF61.000034AA
X-Mailer: git-send-email 1.7.9.2.302.g3724c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191683>

In scripts meant to generate user-consumable output, it can be helpful
to resolve a symbolic ref and output the result in a shortened form,
such as for use in shell prompts. Add a new -s option to allow this.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 Documentation/git-symbolic-ref.txt |    6 +++++-
 builtin/symbolic-ref.c             |    5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-sym=
bolic-ref.txt
index a05819b..7f108ce 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -8,7 +8,7 @@ git-symbolic-ref - Read and modify symbolic refs
 SYNOPSIS
 --------
 [verse]
-'git symbolic-ref' [-q] [-f] [-m <reason>] <name> [<ref>]
+'git symbolic-ref' [-q] [-f] [-s] [-m <reason>] <name> [<ref>]
=20
 DESCRIPTION
 -----------
@@ -38,6 +38,10 @@ OPTIONS
 	not a symbolic ref; instead output the SHA1 value referenced by
 	<name>.
=20
+-s::
+	When showing the value of <name> as a symbolic ref, try to shorten th=
e
+	value, e.g. from `refs/heads/master` to `master`.
+
 -m::
 	Update the reflog for <name> with <reason>.  This is valid only
 	when creating or updating a symbolic ref.
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 2e0a86f..df8da11 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -9,6 +9,7 @@ static const char * const git_symbolic_ref_usage[] =3D =
{
 };
=20
 static int fallback_regular_ref;
+static int shorten;
=20
 static void check_symref(const char *HEAD, int quiet)
 {
@@ -32,6 +33,9 @@ static void check_symref(const char *HEAD, int quiet)
 			exit(1);
 		}
 	}
+	if (shorten)
+		refs_heads_master =3D shorten_unambiguous_ref(
+			refs_heads_master, 0);
 	puts(refs_heads_master);
 }
=20
@@ -44,6 +48,7 @@ int cmd_symbolic_ref(int argc, const char **argv, con=
st char *prefix)
 			"suppress error message for non-symbolic (detached) refs"),
 		OPT_BOOLEAN('f', NULL, &fallback_regular_ref,
 					"fall back to showing as a regular ref"),
+		OPT_BOOLEAN('s', NULL, &shorten, "shorten ref output"),
 		OPT_STRING('m', NULL, &msg, "reason", "reason of the update"),
 		OPT_END(),
 	};
--=20
1.7.9.2.302.g3724c.dirty
