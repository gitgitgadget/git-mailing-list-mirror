From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv3=5D=20clone=3A=20fix=20refspec=20on=20=22--single-branch=22=20option?=
Date: Fri, 14 Sep 2012 23:13:48 +0200
Message-ID: <1347657228-16404-1-git-send-email-ralf.thielow@gmail.com>
References: <7vd31o4dfu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 14 23:14:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCdDA-0006E5-Cr
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 23:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab2INVN4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2012 17:13:56 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48983 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab2INVNy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 17:13:54 -0400
Received: by wibhi8 with SMTP id hi8so302964wib.1
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 14:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kkFjRzklM/AzvnQQrSmNgA919GxuDcbHjXIDWZlMhXs=;
        b=dldZFF2Z0EsXOC1CROWtESL/g/pDTa5T3K2T/UDcV6nj0j1Cf14k1HT3iE8fpVG9SU
         DQhoP6u2HRIFFn27DW0gIATx4oi93kAJG1UV1VSWM4N1u7Zmefv1AEaleWFrgzTut+Fg
         k2ElFbtj/RqepS7aHbg/Pt6Sf4gtKykErG3aKRoWQE0F450/A+zhRbAtOmKtPHO1Etfw
         cymM1hpywzNXILsSvsjXOGG2g9Lc/XSWozOXSAHrVXCRerREkIVOmbbQXqADK3bouzYO
         /dH+aWRMPwpoEqeQ+OWte3Ks1Tx4o/zAAtosRp5XlA+mVsFv6JSn7qe+QwbyDBt+6SGq
         xf8A==
Received: by 10.216.140.104 with SMTP id d82mr2315023wej.130.1347657233533;
        Fri, 14 Sep 2012 14:13:53 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id q4sm846296wix.9.2012.09.14.14.13.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 14:13:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.396.g3cff853.dirty
In-Reply-To: <7vd31o4dfu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205532>

After a repo was cloned with the "--single-branch"
option, the configured refspec looks like
"+refs/heads/*:refs/remotes/origin/*".
After fetching from this repo again, it'll receive
all refs instead of just the ref from the single
branch. Fixing this by configure exactly the ref
of the branch the user specified in the "git clone"
command.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
> As refspec maps names that appear on the source side to names that
> appear on the destination side, and for fetch, the "soruce side"
> is the remote, using "our_head_points_at" on the source side makes
> it look very fishy (even though it may be a name derived from
> remote_head_points_at and has the correct and appropriate value).
>
> "prettify" also is very questionable.  It is meant to strip commonly
> known prefix to make it easier to read by humans, and we can change
> its result based solely on aesthetics in the future.  It is not
> suitable for coming up with a value for configuration in the longer
> term.
>

Thanks. I've fixed.

> Can we make the part you moved de-dented a bit, perhaps by making it
> into a small helper function or something?  It is extremely hard to
> read with overly looooooong lines.
>

Would be nice but the list of arguments will become too long.
I did a bit of reformating and think it now looks a bit nicer.

 builtin/clone.c | 43 +++++++++++++++++++++++++++++--------------
 1 Datei ge=C3=A4ndert, 29 Zeilen hinzugef=C3=BCgt(+), 14 Zeilen entfer=
nt(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5e8f3ba..06e3d3a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -755,20 +755,6 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
-
-	if (option_mirror || !option_bare) {
-		/* Configure the remote */
-		strbuf_addf(&key, "remote.%s.fetch", option_origin);
-		git_config_set_multivar(key.buf, value.buf, "^$", 0);
-		strbuf_reset(&key);
-
-		if (option_mirror) {
-			strbuf_addf(&key, "remote.%s.mirror", option_origin);
-			git_config_set(key.buf, "true");
-			strbuf_reset(&key);
-		}
-	}
-
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -853,6 +839,35 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 					      "refs/heads/master");
 	}
=20
+	if (option_mirror || !option_bare) {
+		strbuf_reset(&value);
+		if (option_single_branch) {
+			if (option_branch)
+				strbuf_addf(&value, "+%s%s:%s%s",
+						src_ref_prefix, option_branch,
+						branch_top.buf, option_branch);
+			else if (remote_head_points_at)
+				strbuf_addf(&value, "+%s:%s%s",
+						remote_head_points_at->name, branch_top.buf,
+						skip_prefix(remote_head_points_at->name, "refs/heads/"));
+		} else {
+			strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+		}
+		/* Configure the remote */
+		if (value.len) {
+			strbuf_reset(&key);
+			strbuf_addf(&key, "remote.%s.fetch", option_origin);
+			git_config_set_multivar(key.buf, value.buf, "^$", 0);
+			strbuf_reset(&key);
+
+			if (option_mirror) {
+				strbuf_addf(&key, "remote.%s.mirror", option_origin);
+				git_config_set(key.buf, "true");
+				strbuf_reset(&key);
+			}
+		}
+	}
+
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
--=20
1.7.12.396.g3cff853.dirty
