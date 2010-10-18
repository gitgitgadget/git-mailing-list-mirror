From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v4 15/15] daemon: opt-out on features that require posix
Date: Mon, 18 Oct 2010 14:05:09 +0200
Message-ID: <AANLkTim0KeW3eDHAsxrxMCvBUD_15R3VSrHSzOFq38A1@mail.gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-16-git-send-email-kusmabite@gmail.com> <7vhbgphf25.fsf@alter.siamese.dyndns.org>
 <AANLkTi=N+4QokkiGmN+S17=7=QsgKWUXrsF0vZ_6Zt2H@mail.gmail.com> <7vbp6vduly.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 14:05:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7oTC-0006K2-8w
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 14:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab0JRMFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 08:05:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48936 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab0JRMFb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 08:05:31 -0400
Received: by fxm4 with SMTP id 4so527994fxm.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=ZScuym2lNBKuglGUaADmPbebyFv4dAKxopAvAzRQ65M=;
        b=HFGlhSesUMn+hPuPyYIsjz2C9sPXxpFtPv9C8eMGsdlPWztlAv5TulHDvoEHHlc/eT
         WBPa+eDsL1dSGEiEke831d4ILUPHLE/1as7ljBWd8X3T9hZ7AvjOMPJ+aCbOzoPf+6GL
         TiGf8xa9A6DEij4yP6M4iXxp6D9/YcnSXQvgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=m3m7L0bYPK1luASbUpQufJE8owMGTKIlX6cOSOhH7cjQZTc6Zc9LpvaMjun902I1SB
         xN4qOrASdqhkeaod5i4Syeun4n4cxOXDzz5itVUcg+UHFiVdgzf/oMBbAt2P0l7veIZx
         7pZLCpP8NAK7SeLi8IddZJw6FeUF5Ns9fsjHI=
Received: by 10.103.182.19 with SMTP id j19mr1924012mup.107.1287403529487;
 Mon, 18 Oct 2010 05:05:29 -0700 (PDT)
Received: by 10.223.112.146 with HTTP; Mon, 18 Oct 2010 05:05:09 -0700 (PDT)
In-Reply-To: <7vbp6vduly.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159253>

On Fri, Oct 15, 2010 at 11:16 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>>>> -static int serve(struct string_list *listen_addr, int listen_port=
, struct passwd *pass, gid_t gid)
>>>> +#ifndef NO_POSIX_GOODIES
>>>> +static struct passwd *pass;
>>>> +static gid_t gid;
>>>> +#endif
>>>> +
>>>> +static int serve(struct string_list *listen_addr, int listen_port=
)
>>>> =A0{
>>>> =A0 =A0 =A0 struct socketlist socklist =3D { NULL, 0, 0 };
>>>>
>>>
>>> This is ugly. =A0Why did you need to make the arguments file-scope =
static?
>>>
>>
>> To avoid having different signatures for the serve-function dependen=
t
>> on NO_POSIX_GOODIES.
>
> Why does the signature even have to be different between the two to b=
egin
> with? I _think_ you have gid_t over there

We don't, so this is the primary reason. But also avoiding
compilation-warnings is a secondary motivation.

> although you might not have
> "struct passwd", in which case you can just define an empty one that =
your
> alternate implementation is not going to use anyway.

We do, so this becomes a bit of a hypothetical question. But would you
seriously consider pretending to have a posix-feature less ugly than
inlining a function that is only used once?

(I'm going a little off-topic here, I hope that's OK)
I'm not too happy with some of the
pretend-really-hard-to-be-posix-magic around in the Windows-port. In
fact, I have some patches to reduce posixness in some areas, while
getting rid of some code in mingw.c. Would such patches be welcome, or
is pretend-to-be-posix the governing portability approach? In some
cases, this comes at the expense of some performance (and quite a bit
of added cludge), which is a bit contradictory to the Git design IMO.

> This is especially
> true if you are making the "drop-privileges" part a helper function, =
no?

I don't follow this part. What exactly becomes more true by having a
drop-privileges function?

Anyway, I'm pretty pleased with how this turned out after inlining
serve() into main(), what do you think about this? I've also moved the
reordering of usage-string into a new patch that makes inetd_mode and
detach incompatible (they already are, it's just not checked for or
documented).

diff --git a/Makefile b/Makefile
index 46034bf..53986b1 100644
--- a/Makefile
+++ b/Makefile
@@ -401,6 +401,7 @@ EXTRA_PROGRAMS =3D
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS +=3D $(EXTRA_PROGRAMS)

+PROGRAM_OBJS +=3D daemon.o
 PROGRAM_OBJS +=3D fast-import.o
 PROGRAM_OBJS +=3D imap-send.o
 PROGRAM_OBJS +=3D shell.o
@@ -1066,7 +1067,6 @@ ifeq ($(uname_S),Windows)
 	NO_SVN_TESTS =3D YesPlease
 	NO_PERL_MAKEMAKER =3D YesPlease
 	RUNTIME_PREFIX =3D YesPlease
-	NO_POSIX_ONLY_PROGRAMS =3D YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
 	NO_NSEC =3D YesPlease
 	USE_WIN32_MMAP =3D YesPlease
@@ -1077,6 +1077,7 @@ ifeq ($(uname_S),Windows)
 	NO_CURL =3D YesPlease
 	NO_PYTHON =3D YesPlease
 	BLK_SHA1 =3D YesPlease
+	NO_POSIX_GOODIES =3D UnfortunatelyYes
 	NATIVE_CRLF =3D YesPlease

 	CC =3D compat/vcbuild/scripts/clink.pl
@@ -1119,7 +1120,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SVN_TESTS =3D YesPlease
 	NO_PERL_MAKEMAKER =3D YesPlease
 	RUNTIME_PREFIX =3D YesPlease
-	NO_POSIX_ONLY_PROGRAMS =3D YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
 	NO_NSEC =3D YesPlease
 	USE_WIN32_MMAP =3D YesPlease
@@ -1130,6 +1130,9 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PYTHON =3D YesPlease
 	BLK_SHA1 =3D YesPlease
 	ETAGS_TARGET =3D ETAGS
+	NO_INET_PTON =3D YesPlease
+	NO_INET_NTOP =3D YesPlease
+	NO_POSIX_GOODIES =3D UnfortunatelyYes
 	COMPAT_CFLAGS +=3D -D__USE_MINGW_ACCESS -DNOGDI -Icompat
-Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS +=3D -DSTRIP_EXTENSION=3D\".exe\"
 	COMPAT_OBJS +=3D compat/mingw.o compat/fnmatch/fnmatch.o compat/winan=
si.o \
@@ -1249,9 +1252,6 @@ ifdef ZLIB_PATH
 endif
 EXTLIBS +=3D -lz

-ifndef NO_POSIX_ONLY_PROGRAMS
-	PROGRAM_OBJS +=3D daemon.o
-endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL =3D -lssl
 	ifdef OPENSSLDIR
@@ -1419,6 +1419,10 @@ ifdef NO_DEFLATE_BOUND
 	BASIC_CFLAGS +=3D -DNO_DEFLATE_BOUND
 endif

+ifdef NO_POSIX_GOODIES
+	BASIC_CFLAGS +=3D -DNO_POSIX_GOODIES
+endif
+
 ifdef BLK_SHA1
 	SHA1_HEADER =3D "block-sha1/sha1.h"
 	LIB_OBJS +=3D block-sha1/sha1.o
diff --git a/daemon.c b/daemon.c
index b7f3874..589bd04 100644
--- a/daemon.c
+++ b/daemon.c
@@ -26,7 +26,9 @@ static const char daemon_usage[] =3D
 "           [--reuseaddr] [--pid-file=3Dfile]\n"
 "           [--[enable|disable|allow-override|forbid-override]=3Dservi=
ce]\n"
 "           [--inetd | [--listen=3Dhost_or_ipaddr] [--port=3Dn]\n"
+#ifndef NO_POSIX_GOODIES
 "                      [--detach] [--user=3Duser [--group=3Dgroup]]\n"
+#endif
 "           [directory...]";

 /* List of acceptable pathname prefixes */
@@ -938,6 +940,14 @@ static void sanitize_stdfds(void)
 		close(fd);
 }

+#ifndef NO_POSIX_GOODIES
+static void drop_privileges(struct passwd *pass, gid_t gid)
+{
+	if (initgroups(pass->pw_name, gid) || setgid (gid) ||
+	     setuid(pass->pw_uid))
+		die("cannot drop privileges");
+}
+
 static void daemonize(void)
 {
 	switch (fork()) {
@@ -955,6 +965,7 @@ static void daemonize(void)
 	close(2);
 	sanitize_stdfds();
 }
+#endif

 static void store_pid(const char *path)
 {
@@ -965,33 +976,19 @@ static void store_pid(const char *path)
 		die_errno("failed to write pid file '%s'", path);
 }

-static int serve(struct string_list *listen_addr, int listen_port,
struct passwd *pass, gid_t gid)
-{
-	struct socketlist socklist =3D { NULL, 0, 0 };
-
-	socksetup(listen_addr, listen_port, &socklist);
-	if (socklist.nr =3D=3D 0)
-		die("unable to allocate any listen sockets on port %u",
-		    listen_port);
-
-	if (pass && gid &&
-	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
-	     setuid(pass->pw_uid)))
-		die("cannot drop privileges");
-
-	return service_loop(&socklist);
-}
-
 int main(int argc, char **argv)
 {
 	int listen_port =3D 0;
 	struct string_list listen_addr =3D STRING_LIST_INIT_NODUP;
+	struct socketlist socklist =3D { NULL, 0, 0 };
 	int serve_mode =3D 0, inetd_mode =3D 0;
-	const char *pid_file =3D NULL, *user_name =3D NULL, *group_name =3D N=
ULL;
+	const char *pid_file =3D NULL;
+#ifndef NO_POSIX_GOODIES
+	const char *user_name =3D NULL, *group_name =3D NULL;
 	int detach =3D 0;
 	struct passwd *pass =3D NULL;
-	struct group *group;
 	gid_t gid =3D 0;
+#endif
 	int i;

 	git_extract_argv0_path(argv[0]);
@@ -1079,6 +1076,7 @@ int main(int argc, char **argv)
 			pid_file =3D arg + 11;
 			continue;
 		}
+#ifndef NO_POSIX_GOODIES
 		if (!strcmp(arg, "--detach")) {
 			detach =3D 1;
 			log_syslog =3D 1;
@@ -1092,6 +1090,7 @@ int main(int argc, char **argv)
 			group_name =3D arg + 8;
 			continue;
 		}
+#endif
 		if (!prefixcmp(arg, "--enable=3D")) {
 			enable_service(arg + 9, 1);
 			continue;
@@ -1126,14 +1125,15 @@ int main(int argc, char **argv)
 		/* avoid splitting a message in the middle */
 		setvbuf(stderr, NULL, _IOFBF, 4096);

-	if (inetd_mode && (detach || group_name || user_name))
-		die("--detach, --user and --group are incompatible with --inetd");
-
 	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen=3D and --port=3D are incompatible with --inetd");
 	else if (listen_port =3D=3D 0)
 		listen_port =3D DEFAULT_GIT_PORT;

+#ifndef NO_POSIX_GOODIES
+	if (inetd_mode && (detach || group_name || user_name))
+		die("--detach, --user and --group are incompatible with --inetd");
+
 	if (group_name && !user_name)
 		die("--group supplied without --user");

@@ -1145,13 +1145,14 @@ int main(int argc, char **argv)
 		if (!group_name)
 			gid =3D pass->pw_gid;
 		else {
-			group =3D getgrnam(group_name);
+			struct group *group =3D getgrnam(group_name);
 			if (!group)
 				die("group not found - %s", group_name);

 			gid =3D group->gr_gid;
 		}
 	}
+#endif

 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");
@@ -1168,11 +1169,13 @@ int main(int argc, char **argv)
 	if (inetd_mode || serve_mode)
 		return execute();

+#ifndef NO_POSIX_GOODIES
 	if (detach) {
 		daemonize();
 		loginfo("Ready to rumble");
 	}
 	else
+#endif
 		sanitize_stdfds();

 	if (pid_file)
@@ -1185,5 +1188,15 @@ int main(int argc, char **argv)
 	cld_argv[argc] =3D "--serve";
 	cld_argv[argc+1] =3D NULL;

-	return serve(&listen_addr, listen_port, pass, gid);
+	socksetup(&listen_addr, listen_port, &socklist);
+	if (socklist.nr =3D=3D 0)
+		die("unable to allocate any listen sockets on port %u",
+		    listen_port);
+
+#ifndef NO_POSIX_GOODIES
+	if (pass && gid)
+		drop_privileges(pass, gid);
+#endif
+
+	return service_loop(&socklist);
 }
