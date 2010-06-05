From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with 
	gettext
Date: Sat, 5 Jun 2010 15:19:33 +0000
Message-ID: <AANLkTimHZdT3vfuUyG1cnanE3WLrhDGqqw5JyYfza6wD@mail.gmail.com>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
	<1275704035-6552-2-git-send-email-avarab@gmail.com>
	<20100605025702.GA2019@progeny.tock>
	<AANLkTil541q0RtZsEmnLOtUNxfltvcFCGxpxR-myhyDl@mail.gmail.com>
	<20100605033626.GA2252@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 17:24:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKvE9-0001FE-6p
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 17:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab0FEPTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 11:19:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55338 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255Ab0FEPTe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 11:19:34 -0400
Received: by iwn37 with SMTP id 37so2019122iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q0s2zjV/RopPdogByT0xgi0dvshNVETH1r2CemBuO0w=;
        b=XTZG4g3aZD5gipwN9v2pUqDwshPhai6kkh1IPB18H4kNulU1DkA5r6XXsyEk2X4Hjg
         OrlJNOHPSNAyYVyFvICB6kw7jW+RTI+MrxFrB+9J5WTAB/g2wCvkmXhKrJtOsBUbIedo
         z1/0op7D+zaWXhT3XsiJPM4BjFtXcYh53INds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ROb++DJ6eNqspSU6ovLF4vlWMQ0cyCl5rTVySt49aQDhC9SgyumwMFXdXkdYBiR83F
         WDlPicpPeZLyyBAOci0BS1IeBWszQtYppBcgMu9DGf684Vmw0wJlzEZ92dUdC7rH+8F+
         MhzesHIlN5RpCA7AcOg3o9egNHJeAISdBRjGM=
Received: by 10.231.124.17 with SMTP id s17mr2265021ibr.181.1275751173149; 
	Sat, 05 Jun 2010 08:19:33 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 5 Jun 2010 08:19:33 -0700 (PDT)
In-Reply-To: <20100605033626.GA2252@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148476>

On Sat, Jun 5, 2010 at 03:36, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sat, Jun 5, 2010 at 02:57, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
>>> This handles builtins. =C2=A0=E2=80=98grep PROGRAM_OBJS Makefile=E2=
=80=99 reveals nine
>>> other source files with their own main() functions.
> [...]
>> They're mostly guts, but I guess imap-send should be translated.
>
> Ok, I just wanted to make sure it was intentional.

The main motivation is just to get the majority of messages in
translatable state.

> Is the porcelain/plumbing distinction meant to be honored here?
> It is possible the right thing to do would be to have run_builtin()
> call the function that calls setlocale(), if and only if the command
> has a USE_LOCALE flag set.

I looked at some of the PROGRAM_OBJS that were omitted and all of them
have some parts where they'll die with a message to STDERR. Those
should probably be translatable.

So in the interest of completion I've patched my copy so that all the
PROGRAM_OBJS include the gettext setup function. I can include it in
my next series if this is deemed a good idea.

> The downside: this would make the handle_internal_command table even
> wider than it already is.

IMO trying to plan in advance what we should and shouldn't translate
is a bit premature.

I think it's better to just add glue so that everything can be
translated, then we can try decide later if some arbitrary subset
shouldn't have translations (even for human readable error messages)
and act appropriately.

diff --git a/daemon.c b/daemon.c
index a90ab10..7f4691c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "gettext.h"

 #include <syslog.h>

@@ -974,6 +975,8 @@ int main(int argc, char **argv)
 	gid_t gid =3D 0;
 	int i;

+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);

 	for (i =3D 1; i < argc; i++) {
	Modified fast-import.c
diff --git a/fast-import.c b/fast-import.c
index 129a786..6947f7a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -156,6 +156,7 @@ Format of STDIN stream:
 #include "csum-file.h"
 #include "quote.h"
 #include "exec_cmd.h"
+#include "gettext.h"

 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -2904,6 +2905,8 @@ int main(int argc, const char **argv)

 	git_extract_argv0_path(argv[0]);

+	git_setup_gettext();
+
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(fast_import_usage);

	Modified http-backend.c
diff --git a/http-backend.c b/http-backend.c
index d1e83d0..b6d9bd5 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -6,6 +6,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "string-list.h"
+#include "gettext.h"

 static const char content_type[] =3D "Content-Type";
 static const char content_length[] =3D "Content-Length";
@@ -605,6 +606,8 @@ int main(int argc, char **argv)
 	char *cmd_arg =3D NULL;
 	int i;

+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
 	set_die_routine(die_webcgi);

	Modified http-fetch.c
diff --git a/http-fetch.c b/http-fetch.c
index 762c750..b889c36 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -2,6 +2,7 @@
 #include "exec_cmd.h"
 #include "http.h"
 #include "walker.h"
+#include "gettext.h"

 static const char http_fetch_usage[] =3D "git http-fetch "
 "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
@@ -24,6 +25,8 @@ int main(int argc, const char **argv)
 	int get_verbosely =3D 0;
 	int get_recover =3D 0;

+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);

 	while (arg < argc && argv[arg][0] =3D=3D '-') {
	Modified http-push.c
diff --git a/http-push.c b/http-push.c
index 415b1ab..ba0338c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -10,6 +10,7 @@
 #include "remote.h"
 #include "list-objects.h"
 #include "sigchain.h"
+#include "gettext.h"

 #include <expat.h>

@@ -1791,6 +1792,8 @@ int main(int argc, char **argv)
 	struct remote *remote;
 	char *rewritten_url =3D NULL;

+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);

 	repo =3D xcalloc(sizeof(*repo), 1);
	Modified imap-send.c
diff --git a/imap-send.c b/imap-send.c
index 9d0097c..4f5f269 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,6 +25,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+#include "gettext.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #else
@@ -1535,6 +1536,8 @@ int main(int argc, char **argv)

 	git_extract_argv0_path(argv[0]);

+	git_setup_gettext();
+
 	if (argc !=3D 1)
 		usage(imap_send_usage);

	Modified shell.c
diff --git a/shell.c b/shell.c
index e4864e0..ba27c6b 100644
--- a/shell.c
+++ b/shell.c
@@ -2,6 +2,7 @@
 #include "quote.h"
 #include "exec_cmd.h"
 #include "strbuf.h"
+#include "gettext.h"

 static int do_generic_cmd(const char *me, char *arg)
 {
@@ -51,6 +52,8 @@ int main(int argc, char **argv)
 	struct commands *cmd;
 	int devnull_fd;

+	git_setup_gettext();
+
 	/*
 	 * Always open file descriptors 0/1/2 to avoid clobbering files
 	 * in die().  It also avoids not messing up when the pipes are
	Modified show-index.c
diff --git a/show-index.c b/show-index.c
index 4c0ac13..c2f5448 100644
--- a/show-index.c
+++ b/show-index.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "pack.h"
+#include "gettext.h"

 static const char show_index_usage[] =3D
 "git show-index < <packed archive index>";
@@ -11,6 +12,8 @@ int main(int argc, char **argv)
 	unsigned int version;
 	static unsigned int top_index[256];

+	git_setup_gettext();
+
 	if (argc !=3D 1)
 		usage(show_index_usage);
 	if (fread(top_index, 2 * 4, 1, stdin) !=3D 1)
	Modified upload-pack.c
diff --git a/upload-pack.c b/upload-pack.c
index dc464d7..ece9a4b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,6 +10,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "gettext.h"

 static const char upload_pack_usage[] =3D "git upload-pack [--strict]
[--timeout=3Dnn] <dir>";

@@ -686,6 +687,8 @@ int main(int argc, char **argv)
 	int i;
 	int strict =3D 0;

+	git_setup_gettext();
+
 	git_extract_argv0_path(argv[0]);
 	read_replace_refs =3D 0;
