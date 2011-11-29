From: Junio C Hamano <gitster@pobox.com>
Subject: Re: support gnupg-2.x in git.
Date: Tue, 29 Nov 2011 12:29:29 -0800
Message-ID: <7vborusmdy.fsf@alter.siamese.dyndns.org>
References: <201111291937.34324.pawel.sikora@agmk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Pawe=C5=82?= Sikora <pawel.sikora@agmk.net>
X-From: git-owner@vger.kernel.org Tue Nov 29 21:29:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVUJ9-0003vU-TX
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 21:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab1K2U3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 15:29:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756785Ab1K2U3c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 15:29:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D12B9514D;
	Tue, 29 Nov 2011 15:29:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5ZqjXKxJeeW5
	kXdxQX2Ksp0tGG0=; b=Ooi4NL+ZMiuB9lcXGvsmavXai7FbljFhFn9OamZVMMTZ
	mVd9CmXA/mf+YU5vf9f3Z9+PEaFHesPE+p+ybVTldfApy+vgjfmfigBmZyqdFfiZ
	nAXmjX7FMNs5jv3WAFM3ofY9soys7WQuvT2AeEm32XJNaeV/Z7XS9GTRvz9HL7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BChDvR
	PS8P5Kwqhmny/nDwowYYhGSKEy7Lycuaef6OvVGaDn6pwzDiPLgtJuw4SI9T0KnB
	SMzjV/hMkGde2WkRgO4T8uNiuhpRrhESIB6yVCSeZWYF1sXFrArdvHZoSFyDYtWQ
	4kPRvNBKgcu0OyzvKA8I1Hopj/OJApIoG5WwU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7DD5514C;
	Tue, 29 Nov 2011 15:29:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEED5514B; Tue, 29 Nov 2011
 15:29:30 -0500 (EST)
In-Reply-To: <201111291937.34324.pawel.sikora@agmk.net> (=?utf-8?Q?=22Pawe?=
 =?utf-8?Q?=C5=82?= Sikora"'s message of "Tue, 29 Nov 2011 19:37:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D78C1AFC-1AC8-11E1-89A0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186081>

Pawe=C5=82 Sikora <pawel.sikora@agmk.net> writes:

> i'm using a gnupg-2.0.18 and currently i'm not able to use git tag/ve=
rify
> due to hadcoded "gpg" literals in builtin/{tag,verifiy-tag}.c.

Stating the obvious...

  $ ln -s /usr/local/not/on/my/path/bin/gnupg-2.0.18 $HOME/bin/gpg
  $ PATH=3D$HOME/bin:$PATH

Or this untested patch, which applies on top of jc/signed-commit, as th=
e
GnuPG interface is in the process of getting heavily refactored.

-- >8 --
Subject: gpg-interface: allow use of a custom GPG binary

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt  |   11 +++++++++++
 Documentation/git-tag.txt |    8 +++++---
 gpg-interface.c           |   11 ++++++++---
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b30c7e6..094c1c9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1094,6 +1094,17 @@ grep.lineNumber::
 grep.extendedRegexp::
 	If set to true, enable '--extended-regexp' option by default.
=20
+gpg.program::
+	Use this custom program instead of "gpg" found on $PATH when
+	making or verifying a PGP signature. The program must support the
+	same command line interface as GPG, namely, to verify a detached
+	signature, "gpg --verify $file - <$signature" is run, and the
+	program is expected to signal a good signature by exiting with
+	code 0, and to generate an ascii-armored detached signature, the
+	standard input of "gpg -bsau $key" is fed with the contents to be
+	signed, and the program is expected to send the result to its
+	standard output.
+
 gui.commitmsgwidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c83cb13..74fc7e0 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -38,7 +38,9 @@ created (i.e. a lightweight tag).
 A GnuPG signed tag object will be created when `-s` or `-u
 <key-id>` is used.  When `-u <key-id>` is not used, the
 committer identity for the current user is used to find the
-GnuPG key for signing.
+GnuPG key for signing. 	The configuration variable `gpg.program`
+is used to specify custom GnuPG binary.
+
=20
 OPTIONS
 -------
@@ -48,11 +50,11 @@ OPTIONS
=20
 -s::
 --sign::
-	Make a GPG-signed tag, using the default e-mail address's key
+	Make a GPG-signed tag, using the default e-mail address's key.
=20
 -u <key-id>::
 --local-user=3D<key-id>::
-	Make a GPG-signed tag, using the given key
+	Make a GPG-signed tag, using the given key.
=20
 -f::
 --force::
diff --git a/gpg-interface.c b/gpg-interface.c
index ff232c8..18630ff 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -5,6 +5,7 @@
 #include "sigchain.h"
=20
 static char *configured_signing_key;
+static const char *gpg_program =3D "gpg";
=20
 void set_signing_key(const char *key)
 {
@@ -15,9 +16,12 @@ void set_signing_key(const char *key)
 int git_gpg_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "user.signingkey")) {
+		set_signing_key(value);
+	}
+	if (!strcmp(var, "gpg.program")) {
 		if (!value)
 			return config_error_nonbool(var);
-		set_signing_key(value);
+		gpg_program =3D xstrdup(value);
 	}
 	return 0;
 }
@@ -46,7 +50,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf =
*signature, const char *sig
 	gpg.argv =3D args;
 	gpg.in =3D -1;
 	gpg.out =3D -1;
-	args[0] =3D "gpg";
+	args[0] =3D gpg_program;
 	args[1] =3D "-bsau";
 	args[2] =3D signing_key;
 	args[3] =3D NULL;
@@ -101,10 +105,11 @@ int verify_signed_buffer(const char *payload, siz=
e_t payload_size,
 			 struct strbuf *gpg_output)
 {
 	struct child_process gpg;
-	const char *args_gpg[] =3D {"gpg", "--verify", "FILE", "-", NULL};
+	const char *args_gpg[] =3D {NULL, "--verify", "FILE", "-", NULL};
 	char path[PATH_MAX];
 	int fd, ret;
=20
+	args_gpg[0] =3D gpg_program;
 	fd =3D git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
 		return error("could not create temporary file '%s': %s",
