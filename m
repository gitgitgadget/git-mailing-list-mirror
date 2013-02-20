From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC] Provide a mechanism to turn off symlink resolution in ceiling paths
Date: Wed, 20 Feb 2013 10:09:24 +0100
Message-ID: <1361351364-15479-1-git-send-email-mhagger@alum.mit.edu>
References: <7vmwuzzd76.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@MIT.EDU>, David Aguilar <davvid@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 10:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U85hB-0005oe-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 10:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933224Ab3BTJKG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Feb 2013 04:10:06 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:48774 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751280Ab3BTJJ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2013 04:09:59 -0500
X-AuditID: 1207440c-b7fa46d0000024d7-7f-512492e6e113
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 92.B8.09431.6E294215; Wed, 20 Feb 2013 04:09:58 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r1K99oYi005517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 20 Feb 2013 04:09:55 -0500
X-Mailer: git-send-email 1.8.1.1
In-Reply-To: <7vmwuzzd76.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqPtskkqgwZppxhZn+sItNixdw2xx
	5M0TZouuK91MFg29V5gtnsy9y2zxbPJGdoujpyws2qZuYbG4vWI+s8WPlh5mi/XvrjI78Hj8
	ff+ByaO1v5vN4017L6PHzll32T0evupi92g6c5TZ41nvHkaPC9tPMntcvKTs8XmTXABXFLdN
	UmJJWXBmep6+XQJ3xuyFyQX/dCvmzXzL2MB4RrWLkZNDQsBEYvqHl4wQtpjEhXvr2boYuTiE
	BC4zSkw9v4cZwjnDJHHi+VImkCo2AV2JRT3NYLaIgLjE2+Mz2UGKmAVOMUusnvGFHSQhLBAk
	sePacaCxHBwsAqoSu/4XgIR5BVwkLm1qZoXYpiCx8GkbM4jNKWAmcWTzFEaIGkGJkzOfsIC0
	MguoS6yfJwQSZhaQl2jeOpt5AiP/LCRVsxCqZiGpWsDIvIpRLjGnNFc3NzEzpzg1Wbc4OTEv
	L7VI11AvN7NELzWldBMjJHZ4djB+WydziFGAg1GJh1dnvnKgEGtiWXFl7iFGSQ4mJVHexAkq
	gUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeH92AOV4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNL
	UrNTUwtSi2CyMhwcShK80yYCNQoWpaanVqRl5pQgpJk4OEEEF8gGHqANu0AKeYsLEnOLM9Mh
	ik4xKkqJ8y4GSQiAJDJK8+AGwJLcK0ZxoH+EefeAVPEAEyRc9yugwUxAg9cuVwYZXJKIkJJq
	YJz+2jPw5/TLBlsUv1rVRLjUcnLVvRf8s7d7t9a9jpS7jOUvjD8EfgmY/3mfjRJb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216698>

Commit 1b77d83cab 'setup_git_directory_gently_1(): resolve symlinks in
ceiling paths' changed the setup code to resolve symlinks in the
entries in GIT_CEILING_DIRECTORIES.  Because those entries are
compared textually to the symlink-resolved current directory, an entry
in GIT_CEILING_DIRECTORIES that contained a symlink would have no
effect.  It was known that this could cause performance problems if
the symlink resolution *itself* touched slow filesystems, but it was
thought that such use cases would be unlikely.

After this change was released, Anders Kaseorg <andersk@mit.edu>
reported:

> [...] my computer has been acting so slow when I=E2=80=99m not connec=
ted to
> the network.  I put various network filesystem paths in
> $GIT_CEILING_DIRECTORIES, such as
> /afs/athena.mit.edu/user/a/n/andersk (to avoid hitting its parents
> /afs/athena.mit.edu, /afs/athena.mit.edu/user/a, and
> /afs/athena.mit.edu/user/a/n which all live in different AFS
> volumes).  Now when I=E2=80=99m not connected to the network, every
> invocation of Git, including the __git_ps1 in my shell prompt, waits
> for AFS to timeout.

So provide the following mechanism to turn off symlink resolution in
GIT_CEILING_DIRECTORIES entries: if that environment variable contains
an empty entry (e.g., GIT_CEILING_DIRECTORIES=3D:/foo/bar:/xyzzy or
GIT_CEILING_DIRECTORIES=3D/foo/bar::/xyzzy), then do not resolve
symlinks in paths that follow the empty entry.

---

This is a possible implementation (untested!) of Junio's suggestion,
with the slight twist that the empty entry can appear anywhere in
GIT_CEILING_DIRECTORIES and only turns off symlink expansion for
subsequent entries.  (The original suggestion would be similarly easy
to implement if it is preferred.)

Unfortunately I am swamped with other work right now so I don't have
time to test the code and might not be able to respond promptly to
feedback.

Another alternative (not implemented here) would be to support a
second environment variable with an ugly name like
GIT_CEILING_DIRECTORIES_NO_SYMLINKS which, when set, tells Git not to
resolve symlinks in GIT_CEILING_DIRECTORIES.  Hopefully the variable
name itself would warn the user that symlinks are an issue.

The ugliness of the situation unfortunately seems to preclude a
non-ugly solution of one form or another.

 Documentation/git.txt | 18 ++++++++++++------
 setup.c               | 32 ++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index da0115f..35c0517 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -674,12 +674,18 @@ git so take care if using Cogito etc.
 	The '--namespace' command-line option also sets this value.
=20
 'GIT_CEILING_DIRECTORIES'::
-	This should be a colon-separated list of absolute paths.
-	If set, it is a list of directories that git should not chdir
-	up into while looking for a repository directory.
-	It will not exclude the current working directory or
-	a GIT_DIR set on the command line or in the environment.
-	(Useful for excluding slow-loading network directories.)
+	This should be a colon-separated list of absolute paths.  If
+	set, it is a list of directories that git should not chdir up
+	into while looking for a repository directory (useful for
+	excluding slow-loading network directories).  It will not
+	exclude the current working directory or a GIT_DIR set on the
+	command line or in the environment.  Normally, Git has to read
+	the entries in this list are read to resolve any symlinks that
+	might be present.  However, if even this access is slow, you
+	can add an empty entry to the list to tell Git that the
+	subsequent entries are not symlinks and needn't be resolved;
+	e.g.,
+	'GIT_CEILING_DIRECTORIES=3D/maybe/symlink::/very/slow/non/symlink'.
=20
 'GIT_DISCOVERY_ACROSS_FILESYSTEM'::
 	When run in a directory that does not have ".git" repository
diff --git a/setup.c b/setup.c
index f108c4b..1b12017 100644
--- a/setup.c
+++ b/setup.c
@@ -624,22 +624,32 @@ static dev_t get_device_or_die(const char *path, =
const char *prefix, int prefix_
 /*
  * A "string_list_each_func_t" function that canonicalizes an entry
  * from GIT_CEILING_DIRECTORIES using real_path_if_valid(), or
- * discards it if unusable.
+ * discards it if unusable.  The presence of an empty entry in
+ * GIT_CEILING_DIRECTORIES turns off canonicalization for all
+ * subsequent entries.
  */
 static int canonicalize_ceiling_entry(struct string_list_item *item,
-				      void *unused)
+				      void *cb_data)
 {
+	int *empty_entry_found =3D cb_data;
 	char *ceil =3D item->string;
-	const char *real_path;
=20
-	if (!*ceil || !is_absolute_path(ceil))
+	if (!*ceil) {
+		*empty_entry_found =3D 1;
 		return 0;
-	real_path =3D real_path_if_valid(ceil);
-	if (!real_path)
+	} else if (!is_absolute_path(ceil)) {
 		return 0;
-	free(item->string);
-	item->string =3D xstrdup(real_path);
-	return 1;
+	} else if (*empty_entry_found) {
+		/* Keep entry but do not canonicalize it */
+		return 1;
+	} else {
+		const char *real_path =3D real_path_if_valid(ceil);
+		if (!real_path)
+			return 0;
+		free(item->string);
+		item->string =3D xstrdup(real_path);
+		return 1;
+	}
 }
=20
 /*
@@ -679,9 +689,11 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok)
 		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
=20
 	if (env_ceiling_dirs) {
+		int empty_entry_found =3D 0;
+
 		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
 		filter_string_list(&ceiling_dirs, 0,
-				   canonicalize_ceiling_entry, NULL);
+				   canonicalize_ceiling_entry, &empty_entry_found);
 		ceil_offset =3D longest_ancestor_length(cwd, &ceiling_dirs);
 		string_list_clear(&ceiling_dirs, 0);
 	}
--=20
1.8.1.1
