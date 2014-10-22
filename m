From: Bernhard Reiter <ockham@raz.or.at>
Subject: Fwd: Re: [PATCH] git-imap-send: use libcurl for implementation
Date: Wed, 22 Oct 2014 17:05:12 +0200
Message-ID: <5447C7A8.7030502@raz.or.at>
References: <543A9CAC.5030404@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 17:05:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgxTX-0000iY-2q
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 17:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbaJVPFQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Oct 2014 11:05:16 -0400
Received: from mhub.domainplanet.at ([92.43.99.117]:50274 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbaJVPFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 11:05:14 -0400
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id AE6F99D4A61;
	Wed, 22 Oct 2014 17:05:07 +0200 (CEST)
Received: from [10.0.0.58] (62-46-149-27.adsl.highway.telekom.at [62.46.149.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id EADBEBFC0B;
	Wed, 22 Oct 2014 17:05:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <543A9CAC.5030404@raz.or.at>
X-Forwarded-Message-Id: <543A9CAC.5030404@raz.or.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*ping*
Hope I didn't mess up formatting again...
Or do I need to top-post, as the original thread is too old to keep pos=
ting to it?

Bernhard

-------- Weitergeleitete Nachricht --------
Betreff: Re: [PATCH] git-imap-send: use libcurl for implementation
Datum: Sun, 12 Oct 2014 17:22:20 +0200
Von: Bernhard Reiter <ockham@raz.or.at>
An: Junio C Hamano <gitster@pobox.com>
Kopie (CC): git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>, =
Jeff King <peff@peff.net>, 434599@bugs.debian.org, Ren=E9 Scharfe <l.s.=
r@web.de>, Tony Finch <dot@dotat.at>, Tanay Abhra <tanayabh@gmail.com>,=
 Dan Albert <danalbert@google.com>, Jeremy Huddleston <jeremyhu@apple.c=
om>, David Aguilar <davvid@gmail.com>, Michael Haggerty <mhagger@alum.m=
it.edu>, Oswald Buddenhagen <ossi@kde.org>

Sorry for not getting back to this any sooner, I've been pretty busy
recently with Other Projects(tm).

Am 2014-08-27 um 19:20 schrieb Junio C Hamano:
> Bernhard Reiter <ockham@raz.or.at> writes:
>=20
>> [...] For now,
>> the old ones are wrapped in #ifdefs, and the new functions are enabl=
ed
>> by make if curl's version is >=3D 7.35.0, from which version on curl=
's
>> CURLOPT_LOGIN_OPTIONS (enabling IMAP authentication) parameter has b=
een
>> available.
>=20
> https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-ve=
rsions
> says that this was introduced as of 7.34.0, though.

Strange, I thought I recalled having seen that in
http://curl.haxx.se/libcurl/c/CURLOPT_LOGIN_OPTIONS.html but it clearly
says 7.34.0 there too. I've now changed all occurrences of 7.35.0 to
7.34.0 (and the corresponding hex value in the Makefile).

>> As I don't have access to that many IMAP servers, I haven't been abl=
e to
>> test the new code with a wide variety of parameter combinations. I d=
id
>> test both secure and insecure (imaps:// and imap://) connections and
>> values of "PLAIN" and "LOGIN" for the authMethod.
>=20
> Perhaps CC'ing those who have touched git-imap-send code over the
> years and asking for their help testing might help?

CC'ing them (going back about 2 years, which already makes the list
quite long) and the people who have taken part in the initial discussio=
n
on this feature in August. And the related Debian bug.

Please test this, folks!

>> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
>> ---
>> I rebased the patch on the pu branch, hope that was the right thing =
to do.
>=20
> Usually I would appreciate a patch for a new feature not meant for
> the maintenance tracks to be based on 'master', so that it can go to
> the next release without having to wait other changes that may
> conflict with it and that may not yet be ready.
>=20
> I will try to apply this one to 'pu', rebase it on 'master' to make
> sure the result does not depend on the other topics in flight, and
> then merge it back to 'pu'.

Okay, I'll stick to master. I've rebased on master now that the first
couple related patches are there anyway.

> [...]
>>
>> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-ima=
p-send.txt
>> index 7d991d9..9d244c4 100644
>> --- a/Documentation/git-imap-send.txt
>> +++ b/Documentation/git-imap-send.txt
>> @@ -75,7 +75,8 @@ imap.preformattedHTML::
>> =20
>>  imap.authMethod::
>>  	Specify authenticate method for authentication with IMAP server.
>> -	Current supported method is 'CRAM-MD5' only. If this is not set
>> +	If you compiled git with the NO_CURL option or if your curl versio=
n is
>> +	< 7.35.0, the only supported method is 'CRAM-MD5'. If this is not =
set
>>  	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
>=20
> Hmph, so there is no option that lets me say "I know my libcurl is
> new enough but I have some reason not to want to use the new code to
> interact with my imap server", at compile time or (more preferrably)
> at runtime?

Added a runtime option, see below.

>> diff --git a/INSTALL b/INSTALL
>> index 6ec7a24..e2770a0 100644
>> --- a/INSTALL
>> +++ b/INSTALL
>> @@ -108,18 +108,21 @@ Issues of note:
>>  	  so you might need to install additional packages other than Perl
>>  	  itself, e.g. Time::HiRes.
>> =20
>> -	- "openssl" library is used by git-imap-send to use IMAP over SSL.
>> -	  If you don't need it, use NO_OPENSSL.
>> +	- "openssl" library is used by git-imap-send to use IMAP over SSL,
>> +	  unless you're using curl >=3D 7.35.0, in which case that will be
>> +	  used. If you don't need git-imap-send, you can use NO_OPENSSL.
>=20
> The last sentence makes it unclear which of the following is true:
>=20
>  - I have sufficiently new libcurl.  I cannot say NO_OPENSSL because
>    I do need git-imap-send.
>=20
>  - I have sufficiently new libcurl, so "openssl" is not used by
>    git-imap send for me.  I can say NO_OPENSSL.
>=20
> Perhaps
>=20
>  - git-imap-send needs the OpenSSL library to talk IMAP over SSL if
>    you are using libCurl older than 7.35.0.  Otherwise you can use
>    NO_OPENSSL without losing git-imap-send.

=46ixed.

>> diff --git a/git.spec.in b/git.spec.in
>> index d61d537..9535cc3 100644
>> --- a/git.spec.in
>> +++ b/git.spec.in
>> @@ -8,7 +8,7 @@ License: 	GPL
>>  Group: 		Development/Tools
>>  URL: 		http://kernel.org/pub/software/scm/git/
>>  Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.=
tar.gz
>> -BuildRequires:	zlib-devel >=3D 1.2, openssl-devel, curl-devel, expa=
t-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
>> +BuildRequires:	zlib-devel >=3D 1.2, openssl-devel, curl-devel >=3D =
7.35.0, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0=
=2E3}
>=20
> This is very iffy.  It incompatible with the body of the patch where
> you allow older curl library and because you depend on openssl-devel
> you wouldn't lose imap-send.

Okay, removed the version requirement.

>> @@ -1391,29 +1518,13 @@ int main(int argc, char **argv)
>> [...]
>=20
> Much more nicely done.  It appears that you could already turn these
> #ifndef/#else/#endif into a runtime conditional, allowing:
>=20
>  - At compile-time, can be built with the four combinations
>=20
>    (1) USE_CURL_FOR_IMAP_SEND=3DYes    NO_OPENSSL=3DNo
>    (2) USE_CURL_FOR_IMAP_SEND=3DYes    NO_OPENSSL=3DYes
>    (3) USE_CURL_FOR_IMAP_SEND=3DNo     NO_OPENSSL=3DNo
>    (4) USE_CURL_FOR_IMAP_SEND=3DNo     NO_OPENSSL=3DYes
>=20
>  - The first two variants can support --with-curl/--without-curl and
>    choose between curl_append/append.  When run --without-curl, it
>    may lose some auth-methods and for variant (1) SSL is not
>    supported.
>=20
> or am I mis-reading the patch?

You're reading it correctly; thanks for the hint about the runtime swit=
ch.

I've now implemented it using parse_options, so the switch is called
--[no-]curl. I hope parse_options isn't overkill, but as I wanted to
keep other options -- namely verbose and quiet switches, useful for
debugging curl -- I would've had to look through all argv[] items
manually, so I figured it made sense to us an already existing API for
that instead.

Bernhard

>From 218c47580330d5ac38875c30e14dc3049d1ce3c5 Mon Sep 17 00:00:00 2001
=46rom: Bernhard Reiter <ockham@raz.or.at>
Date: Wed, 13 Aug 2014 23:41:40 +0200
Subject: [PATCH] git-imap-send: use libcurl for implementation

Use libcurl's high-level API functions to implement git-imap-send
instead of the previous low-level OpenSSL-based functions.

Since version 7.30.0, libcurl's API has been able to communicate with
IMAP servers. Using those high-level functions instead of the current
ones would reduce imap-send.c by some 1200 lines of code. For now,
the old ones are wrapped in #ifdefs, and the new functions are enabled
by make if curl's version is >=3D 7.34.0, from which version on curl's
CURLOPT_LOGIN_OPTIONS (enabling IMAP authentication) parameter has been
available. The low-level functions will still be used for tunneling
into the server for now.

As I don't have access to that many IMAP servers, I haven't been able t=
o
test the new code with a wide variety of parameter combinations. I did
test both secure and insecure (imaps:// and imap://) connections and
values of "PLAIN" and "LOGIN" for the authMethod.

Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
---
 Documentation/git-imap-send.txt |  26 +++++-
 INSTALL                         |  15 ++--
 Makefile                        |  16 +++-
 imap-send.c                     | 189 ++++++++++++++++++++++++++++++++=
+-------
 4 files changed, 204 insertions(+), 42 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-s=
end.txt
index 7d991d9..1c24e1f 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -9,7 +9,7 @@ git-imap-send - Send a collection of patches from stdin=
 to an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send'
+'git imap-send' [-v] [-q] --[no-]curl
=20
=20
 DESCRIPTION
@@ -25,6 +25,26 @@ Typical usage is something like:
=20
 git format-patch --signoff --stdout --attach origin | git imap-send
=20
+OPTIONS
+-------
+-v::
+--verbose::
+	Be verbose.
+
+-q::
+--quiet::
+	Be quiet.
+
+--curl::
+	Use libcurl to communicate with the IMAP server, unless tunneling
+	into it.  Only available if git was built with the
+	USE_CURL_FOR_IMAP_SEND option set, in which case this is the
+	default behavior.
+
+--no-curl::
+	Talk to the IMAP server using git's own IMAP routines instead of
+	using libcurl.  Only available git was built with the
+	USE_CURL_FOR_IMAP_SEND option set; implicitly assumed otherwise.
=20
 CONFIGURATION
 -------------
@@ -75,7 +95,9 @@ imap.preformattedHTML::
=20
 imap.authMethod::
 	Specify authenticate method for authentication with IMAP server.
-	Current supported method is 'CRAM-MD5' only. If this is not set
+	If git was built with the NO_CURL option, or if your curl version is
+	< 7.34.0, or if you're running git-imap-send with the --no-curl
+	option, the only supported method is 'CRAM-MD5'. If this is not set
 	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
=20
 Examples
diff --git a/INSTALL b/INSTALL
index 6ec7a24..ffb071e 100644
--- a/INSTALL
+++ b/INSTALL
@@ -108,18 +108,21 @@ Issues of note:
 	  so you might need to install additional packages other than Perl
 	  itself, e.g. Time::HiRes.
=20
-	- "openssl" library is used by git-imap-send to use IMAP over SSL.
-	  If you don't need it, use NO_OPENSSL.
+	- git-imap-send needs the OpenSSL library to talk IMAP over SSL if
+	  you are using libcurl older than 7.34.0.  Otherwise you can use
+	  NO_OPENSSL without losing git-imap-send.
=20
 	  By default, git uses OpenSSL for SHA1 but it will use its own
 	  library (inspired by Mozilla's) with either NO_OPENSSL or
 	  BLK_SHA1.  Also included is a version optimized for PowerPC
 	  (PPC_SHA1).
=20
-	- "libcurl" library is used by git-http-fetch and git-fetch.  You
-	  might also want the "curl" executable for debugging purposes.
-	  If you do not use http:// or https:// repositories, you do not
-	  have to have them (use NO_CURL).
+	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
+	  the curl version >=3D 7.34.0, for git-imap-send.  You might also
+	  want the "curl" executable for debugging purposes. If you do not
+	  use http:// or https:// repositories, and do not want to put
+	  patches into an IMAP mailbox, you do not have to have them
+	  (use NO_CURL).
=20
 	- "expat" library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional
diff --git a/Makefile b/Makefile
index f34a2d4..69b2fbf 100644
--- a/Makefile
+++ b/Makefile
@@ -992,6 +992,9 @@ ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS +=3D -DHAVE_ALLOCA_H
 endif
=20
+IMAP_SEND_BUILDDEPS =3D
+IMAP_SEND_LDFLAGS =3D $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO=
)
+
 ifdef NO_CURL
 	BASIC_CFLAGS +=3D -DNO_CURL
 	REMOTE_CURL_PRIMARY =3D
@@ -1026,6 +1029,15 @@ else
 			PROGRAM_OBJS +=3D http-push.o
 		endif
 	endif
+	curl_check :=3D $(shell (echo 072200; curl-config --vernum) 2>/dev/nu=
ll | sort -r | sed -ne 2p)
+	ifeq "$(curl_check)" "072200"
+		USE_CURL_FOR_IMAP_SEND =3D YesPlease
+	endif
+	ifdef USE_CURL_FOR_IMAP_SEND
+		BASIC_CFLAGS +=3D -DUSE_CURL_FOR_IMAP_SEND
+		IMAP_SEND_BUILDDEPS =3D http.o
+		IMAP_SEND_LDFLAGS +=3D $(CURL_LIBCURL)
+	endif
 	ifndef NO_EXPAT
 		ifdef EXPATDIR
 			BASIC_CFLAGS +=3D -I$(EXPATDIR)/include
@@ -1892,9 +1904,9 @@ endif
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS)
=20
-git-imap-send$X: imap-send.o GIT-LDFLAGS $(GITLIBS)
+git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITL=
IBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
-		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
+		$(LIBS) $(IMAP_SEND_LDFLAGS)
=20
 git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITL=
IBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
diff --git a/imap-send.c b/imap-send.c
index 70bcc7a..9cc80ae 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -26,11 +26,31 @@
 #include "credential.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+#include "parse-options.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
+#ifdef USE_CURL_FOR_IMAP_SEND
+#include "http.h"
+#endif
=20
-static const char imap_send_usage[] =3D "git imap-send < <mbox>";
+static int Verbose, Quiet;
+#ifdef USE_CURL_FOR_IMAP_SEND
+static int use_curl =3D 1; // on by default; set later by parse_option=
s
+#else
+static int use_curl =3D 0; // not available
+#endif
+
+static const char * const imap_send_usage[] =3D { "git imap-send <opti=
ons> < <mbox>", NULL };
+
+static struct option imap_send_options[] =3D {
+#ifdef USE_CURL_FOR_IMAP_SEND
+	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the I=
MAP server"),
+#endif
+	OPT__VERBOSE(&Verbose, "be verbose"),
+	OPT__QUIET(&Quiet, "be quiet"),
+	OPT_END()
+};
=20
 #undef DRV_OK
 #define DRV_OK          0
@@ -38,8 +58,6 @@ static const char imap_send_usage[] =3D "git imap-sen=
d < <mbox>";
 #define DRV_BOX_BAD     -2
 #define DRV_STORE_BAD   -3
=20
-static int Verbose, Quiet;
-
 __attribute__((format (printf, 1, 2)))
 static void imap_info(const char *, ...);
 __attribute__((format (printf, 1, 2)))
@@ -1338,22 +1356,145 @@ static void git_imap_config(void)
 	git_config_get_string("imap.authmethod", &server.auth_method);
 }
=20
-int main(int argc, char **argv)
-{
-	struct strbuf all_msgs =3D STRBUF_INIT;
+static int append_msgs_to_imap(struct imap_server_conf *server, struct=
 strbuf* all_msgs, int total) {
 	struct strbuf msg =3D STRBUF_INIT;
 	struct imap_store *ctx =3D NULL;
 	int ofs =3D 0;
 	int r;
-	int total, n =3D 0;
+	int n =3D 0;
+
+	ctx =3D imap_open_store(server, server->folder);
+	if (!ctx) {
+		fprintf(stderr, "failed to open store\n");
+		return 1;
+	}
+	ctx->name =3D server->folder;
+
+	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s"=
 : "");
+	while (1) {
+		unsigned percent =3D n * 100 / total;
+
+		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
+
+		if (!split_msg(all_msgs, &msg, &ofs))
+			break;
+		if (server->use_html)
+			wrap_in_html(&msg);
+		r =3D imap_store_msg(ctx, &msg);
+		if (r !=3D DRV_OK)
+			break;
+		n++;
+	}
+	fprintf(stderr, "\n");
+
+	imap_close_store(ctx);
+
+	return 0;
+}
+
+#ifdef USE_CURL_FOR_IMAP_SEND
+static CURL *setup_curl(struct imap_server_conf *srvc)
+{
+	CURL *curl;
+	struct strbuf path =3D STRBUF_INIT;
+	struct strbuf auth =3D STRBUF_INIT;
+
+	if (curl_global_init(CURL_GLOBAL_ALL) !=3D CURLE_OK)
+		die("curl_global_init failed");
+
+	curl =3D curl_easy_init();
+
+	if (!curl)
+		die("curl_easy_init failed");
+
+	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
+	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
+
+	strbuf_addstr(&path, server.host);
+	if (!path.len || path.buf[path.len - 1] !=3D '/')
+		strbuf_addch(&path, '/');
+	strbuf_addstr(&path, server.folder);
+
+	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
+	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
+
+	if (server.auth_method) {
+		strbuf_addstr(&auth, "AUTH=3D");
+		strbuf_addstr(&auth, server.auth_method);
+		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
+	}
+
+	if (server.use_ssl)
+		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_ALL);
+
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, server.ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, server.ssl_verify);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
+	if (Verbose)
+		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
+
+	return curl;
+}
+
+static int curl_append_msgs_to_imap(struct imap_server_conf *server, s=
truct strbuf* all_msgs, int total) {
+	int ofs =3D 0;
+	int n =3D 0;
+	struct buffer msgbuf =3D { STRBUF_INIT, 0 };
+	CURL *curl;
+	CURLcode res =3D CURLE_OK;
+
+	curl =3D setup_curl(server);
+	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
+
+	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s"=
 : "");
+	while (1) {
+		unsigned percent =3D n * 100 / total;
+
+		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
+
+		int prev_len =3D msgbuf.buf.len;
+		if (!split_msg(all_msgs, &msgbuf.buf, &ofs))
+			break;
+		if (server->use_html)
+			wrap_in_html(&msgbuf.buf);
+		lf_to_crlf(&msgbuf.buf);
+
+		curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE, (curl_off_t)(msgbuf=
=2Ebuf.len-prev_len));
+
+		res =3D curl_easy_perform(curl);
+
+		if(res !=3D CURLE_OK) {
+			fprintf(stderr, "curl_easy_perform() failed: %s\n",
+					curl_easy_strerror(res));
+			break;
+		}
+
+		n++;
+	}
+	fprintf(stderr, "\n");
+
+	curl_easy_cleanup(curl);
+	curl_global_cleanup();
+
+	return 0;
+}
+#endif
+
+int main(int argc, char **argv)
+{
+	struct strbuf all_msgs =3D STRBUF_INIT;
+	int total;
 	int nongit_ok;
=20
 	git_extract_argv0_path(argv[0]);
=20
-	git_setup_gettext();
+	argc =3D parse_options(argc, (const char **)argv, "", imap_send_optio=
ns, imap_send_usage, 0);
=20
-	if (argc !=3D 1)
-		usage(imap_send_usage);
+	git_setup_gettext();
=20
 	setup_git_directory_gently(&nongit_ok);
 	git_imap_config();
@@ -1391,29 +1532,13 @@ int main(int argc, char **argv)
 	}
=20
 	/* write it to the imap server */
-	ctx =3D imap_open_store(&server, server.folder);
-	if (!ctx) {
-		fprintf(stderr, "failed to open store\n");
-		return 1;
-	}
=20
-	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s"=
 : "");
-	while (1) {
-		unsigned percent =3D n * 100 / total;
+	if (server.tunnel)
+		return append_msgs_to_imap(&server, &all_msgs, total);
=20
-		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
-		if (!split_msg(&all_msgs, &msg, &ofs))
-			break;
-		if (server.use_html)
-			wrap_in_html(&msg);
-		r =3D imap_store_msg(ctx, &msg);
-		if (r !=3D DRV_OK)
-			break;
-		n++;
+	if (use_curl) {
+		return curl_append_msgs_to_imap(&server, &all_msgs, total);
+	} else {
+		return append_msgs_to_imap(&server, &all_msgs, total);
 	}
-	fprintf(stderr, "\n");
-
-	imap_close_store(ctx);
-
-	return 0;
 }
--=20
2.1.2.375.g218c475
