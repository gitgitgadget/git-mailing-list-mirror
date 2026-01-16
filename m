Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25436BCC6
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591560; cv=none; b=TbPDYijQ1RQwg4CiSKGJvk5CbA+hxk3Bc24ZQY7ZXFC9u+wI2wjiJ/18YM5xrC/e9QsqqDbx2Y3Oqbr2++bXFYs0t/yOV1eC5HNMFOQ4e2w0N2Jk7nb+97fVxWw9n8RZOvI6c4MwPk7vUVlT5yQUv+Xm5Z4XGdnQoySsXMkDLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591560; c=relaxed/simple;
	bh=809G4fZVwG5Nx8pUMtCox8LyQmS0+wkDEYWh+E/z82g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OhPNBcZDiVrPzuKm9NYDeGarhVUx8a4oj0jAZPx3S50lcoFBjW8vaAbOIF3yAoH2pJBF+myRQmesJ48UG3elnjDuJDsdBxsuCaxOSKk+GTiZEAFUGfNlUGJeqvRRHJItAh2TvNFvmQvI9nyZWQU0FXn3vnXzJdBSPaU3IVpEl3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=TcdNo6+O; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="TcdNo6+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768591545; x=1769196345;
	i=johannes.schindelin@gmx.de;
	bh=08n4H3Uk6V3IeZB01sjvDQtyYJwGLK+X00z1cl4hf9w=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TcdNo6+OXi3a1iEzv60zor4GzD4YoBlLHyQVGQiR+NwrgYT0RacbmiBs7Op6IIGM
	 iZJSuNEekpYqbn9kkqpwmOo8nOcZci7myRgkf/w0+zc4GMQ6ZT3YQ8SY+lomcuQBe
	 oHOEH8bUn7FPKFOKFWFLVuqVgpHRCBsGvJNTJ8swyRk5PaSk07RhUXZwQPn9ptepO
	 b9icfN/89HixaAnH+dvP3Mptn84pLW7VirbKY+H4qdv/Ayh6NGgaRYhPLAfdy34DR
	 MLmHSwGkAuaSqe/xNajNdfUEm+BL8ik6zcBXP/igwmHhS0J8z2mjifMcGj04Mltfx
	 kczN9vz4nQpxQG+2Yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.21]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhnN-1w318D3SlN-00sqac; Fri, 16
 Jan 2026 20:25:44 +0100
Date: Fri, 16 Jan 2026 20:25:42 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Andreas Schwab <schwab@linux-m68k.org>, 
    Ondrej Pohorelsky <opohorel@redhat.com>
Subject: Re: [PATCH v2 2/4] sideband: introduce an "escape hatch" to allow
 control characters
In-Reply-To: <xmqqpl8avbop.fsf@gitster.g>
Message-ID: <2ff3b9a0-9c84-6e9e-d4fe-0a19adcdd215@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com> <2615abd8c5d5c55486cf5885c47e09e52fad61b8.1765981422.git.gitgitgadget@gmail.com> <xmqqy0n0y1ep.fsf@gitster.g> <9dd1aa88-badd-0cae-a2f7-21972548815c@gmx.de>
 <xmqqpl8avbop.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uHXDqLHfDHY4kcmWHRchG5g3tfvQgDdavdpxJSDkGy1jDXfTHCT
 QxRk/DphQhKTM8M8R1frDrwHldEQIFwpes5uKYaXQ9GnLydkXtdbEvCr365GrG/owxEEh4x
 0RxN8Z5Y2VX0lgmW9UcheAicH1PIKnswOsi8tQuB/aFyHaSgOCeVlk9MsW4pgnsmUT0YMp1
 X11xFvcI13IzOlvXygaeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w2xom7GftNA=;Kp4Zx/N7RV16w5TTZ8yaBxvBVaP
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 19 Dec 2025, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > Good idea! What do you think about something like this?
>=20
> It may be easier to hack up to piggyback on the http.*.variable
> infrastructure, but I do not like the smell of it very much, because
> the implementation ties it too tightly to the http transport; I
> think this should live in one layer up (transport?).
>=20
> > If this is the direction you're thinking, I'll polish it and integrate=
 it
> > into v3.
>=20
> In other words, it would be more like sideband.allowEscapeSequences
> that is overridden by sideband.<url>.allowEscapeSequences was what I
> had in mind.  Or even transfer.allowEscapeSequencesInSideband that
> is overridden by transfer.<url>.allowEscapeSequencesInSideband.

That was quite a bit trickier than I hoped for. But here it finally is:

=2D- snip --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] sideband: offer to configure sanitizing on a per-URL basi=
s

The main objection against sanitizing the sideband that was raised
during the review of the sideband sanitizing patches, first on the
git-security mailing list, then on the public mailing list, was that
there are some setups where server-side `pre-receive` hooks want to
error out, giving colorful messages to the users on the client side (if
they are not redirecting the output into a file, that is).

To avoid breaking such setups, the default chosen by the sideband
sanitizing patches is to pass through ANSI color sequences.

Still, there might be some use case out there where that is not enough.
Therefore the `sideband.allowControlCharacters` config setting allows
for configuring  levels of sanitizing.

As Junio Hamano pointed out, to keep users safe by default, we need to
be able to scope this to some servers because while a user may trust
their company's Git server, the same might not apply to other Git
servers.

To allow for this, let's imitate the way `http.<url>.*` offers
to scope config settings to certain URLs, by letting users
override the `sideband.allowControlCharacters` setting via
`sideband.<url>.allowControlCharacters`.

Suggested-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 Documentation/config/sideband.txt   |  4 ++
 sideband.c                          | 69 +++++++++++++++++++++--------
 sideband.h                          | 14 ++++++
 t/t5409-colorize-remote-messages.sh | 24 ++++++++++
 transport.c                         |  3 ++
 5 files changed, 96 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/sideband.txt b/Documentation/config/side=
band.txt
index 8eb7656cdd2..cc2cc463bef 100644
=2D-- a/Documentation/config/sideband.txt
+++ b/Documentation/config/sideband.txt
@@ -22,3 +22,7 @@ sideband.allowControlCharacters::
 	true::
 		Allow all control characters to be sent to the terminal.
 --
+
+sideband.<url>.*::
+	Apply the `sideband.*` option selectively to specific URLs. The
+	same URL matching logic applies as for `http.<url>.*` settings.
diff --git a/sideband.c b/sideband.c
index 725e24db0db..e856981ea55 100644
=2D-- a/sideband.c
+++ b/sideband.c
@@ -9,6 +9,7 @@
 #include "help.h"
 #include "pkt-line.h"
 #include "write-or-die.h"
+#include "urlmatch.h"
=20
 struct keyword_entry {
 	/*
@@ -26,13 +27,14 @@ static struct keyword_entry keywords[] =3D {
 };
=20
 static enum {
+	ALLOW_CONTROL_SEQUENCES_UNSET =3D -1,
 	ALLOW_NO_CONTROL_CHARACTERS =3D 0,
 	ALLOW_ANSI_COLOR_SEQUENCES =3D 1<<0,
 	ALLOW_ANSI_CURSOR_MOVEMENTS =3D 1<<1,
 	ALLOW_ANSI_ERASE =3D 1<<2,
 	ALLOW_DEFAULT_ANSI_SEQUENCES =3D ALLOW_ANSI_COLOR_SEQUENCES,
 	ALLOW_ALL_CONTROL_CHARACTERS =3D 1<<3,
-} allow_control_characters =3D ALLOW_DEFAULT_ANSI_SEQUENCES;
+} allow_control_characters =3D ALLOW_CONTROL_SEQUENCES_UNSET;
=20
 static inline int skip_prefix_in_csv(const char *value, const char *prefi=
x,
 				     const char **out)
@@ -44,8 +46,19 @@ static inline int skip_prefix_in_csv(const char *value,=
 const char *prefix,
 	return 1;
 }
=20
-static void parse_allow_control_characters(const char *value)
+int sideband_allow_control_characters_config(const char *var, const char =
*value)
 {
+	switch (git_parse_maybe_bool(value)) {
+	case 0:
+		allow_control_characters =3D ALLOW_NO_CONTROL_CHARACTERS;
+		return 0;
+	case 1:
+		allow_control_characters =3D ALLOW_ALL_CONTROL_CHARACTERS;
+		return 0;
+	default:
+		break;
+	}
+
 	allow_control_characters =3D ALLOW_NO_CONTROL_CHARACTERS;
 	while (*value) {
 		if (skip_prefix_in_csv(value, "default", &value))
@@ -61,9 +74,37 @@ static void parse_allow_control_characters(const char *=
value)
 		else if (skip_prefix_in_csv(value, "false", &value))
 			allow_control_characters =3D ALLOW_NO_CONTROL_CHARACTERS;
 		else
-			warning(_("unrecognized value for `sideband."
-				  "allowControlCharacters`: '%s'"), value);
+			warning(_("unrecognized value for '%s': '%s'"), var, value);
 	}
+	return 0;
+}
+
+static int sideband_config_callback(const char *var, const char *value,
+				    const struct config_context *ctx UNUSED,
+				    void *data UNUSED)
+{
+	if (!strcmp(var, "sideband.allowcontrolcharacters"))
+		return sideband_allow_control_characters_config(var, value);
+
+	return 0;
+}
+
+void sideband_apply_url_config(const char *url)
+{
+	struct urlmatch_config config =3D URLMATCH_CONFIG_INIT;
+	char *normalized_url;
+
+	if (!url)
+		BUG("must not call sideband_apply_url_config(NULL)");
+
+	config.section =3D "sideband";
+	config.collect_fn =3D sideband_config_callback;
+
+	normalized_url =3D url_normalize(url, &config.url);
+	git_config(urlmatch_config_entry, &config);
+	free(normalized_url);
+	string_list_clear(&config.vars, 1);
+	urlmatch_config_release(&config);
 }
=20
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
@@ -79,20 +120,12 @@ static int use_sideband_colors(void)
 	if (use_sideband_colors_cached >=3D 0)
 		return use_sideband_colors_cached;
=20
-	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters", &i)=
) {
-	case 0: /* Boolean value */
-		allow_control_characters =3D i ? ALLOW_ALL_CONTROL_CHARACTERS :
-			ALLOW_NO_CONTROL_CHARACTERS;
-		break;
-	case -1: /* non-Boolean value */
-		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
-					      &value))
-			; /* huh? `get_maybe_bool()` returned -1 */
-		else
-			parse_allow_control_characters(value);
-		break;
-	default:
-		break; /* not configured */
+	if (allow_control_characters =3D=3D ALLOW_CONTROL_SEQUENCES_UNSET) {
+		if (!git_config_get_value("sideband.allowcontrolcharacters", &value))
+			sideband_allow_control_characters_config("sideband.allowcontrolcharact=
ers", value);
+
+		if (allow_control_characters =3D=3D ALLOW_CONTROL_SEQUENCES_UNSET)
+			allow_control_characters =3D ALLOW_DEFAULT_ANSI_SEQUENCES;
 	}
=20
 	if (!git_config_get_string_tmp(key, &value))
diff --git a/sideband.h b/sideband.h
index 5a25331be55..d15fa4015fa 100644
=2D-- a/sideband.h
+++ b/sideband.h
@@ -30,4 +30,18 @@ int demultiplex_sideband(const char *me, int status,
=20
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int pa=
cket_max);
=20
+/*
+ * Apply sideband configuration for the given URL. This should be called
+ * when a transport is created to allow URL-specific configuration of
+ * sideband behavior (e.g., sideband.<url>.allowControlCharacters).
+ */
+void sideband_apply_url_config(const char *url);
+
+/*
+ * Parse and set the sideband allow control characters configuration.
+ * The var parameter should be the key name (without section prefix).
+ * Returns 0 if the variable was recognized and handled, non-zero otherwi=
se.
+ */
+int sideband_allow_control_characters_config(const char *var, const char =
*value);
+
 #endif
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote=
-messages.sh
index c3e4e143627..1d039cbdafb 100755
=2D-- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -167,4 +167,28 @@ test_expect_success 'control sequences in sideband al=
lowed by default' '
 	test_grep ! "\\^\\[\\[G" decoded
 '
=20
+test_expect_success 'allow all control sequences for a specific URL' '
+	write_script .git/eraser <<-\EOF &&
+	printf "error: Ohai!\\r\\033[K" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./eraser &&
+	test_commit one-more-please &&
+
+	rm -rf throw-away &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep ! "CSI \\[K" decoded &&
+	test_grep "\\^\\[\\[K" decoded &&
+
+	rm -rf throw-away &&
+	git -c "sideband.file://.allowControlCharacters=3Dtrue" \
+		clone --no-local "file://$PWD" throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep "CSI \\[K" decoded &&
+	test_grep ! "\\^\\[\\[K" decoded
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 1098bbd60e4..e19536c9c6b 100644
=2D-- a/transport.c
+++ b/transport.c
@@ -28,6 +28,7 @@
 #include "object-name.h"
 #include "color.h"
 #include "bundle-uri.h"
+#include "sideband.h"
=20
 static int transport_use_color =3D -1;
 static char transport_colors[][COLOR_MAXLEN] =3D {
@@ -1210,6 +1211,8 @@ struct transport *transport_get(struct remote *remot=
e, const char *url)
=20
 	ret->hash_algo =3D &hash_algos[GIT_HASH_SHA1];
=20
+	sideband_apply_url_config(ret->url);
+
 	return ret;
 }
=20
=2D- snap --

That should address this particular concern of yours.

> >>  - It may no longer matter but a remote repository that may send
> >>    messages as strings encoded in ISO/IEC 2022 would need to set
> >>    this, merely to make the messages human-readable.  There may be
> >>    other reasons the trusted repositories want to send "escape
> >>    sequences".
> >
> > If the remote side has no way to determine whether the client side is
> > connected to a terminal or not (which we have already established in t=
his
> > thread), it has even less chance to determine which character encoding=
 is
> > in use...
>=20
> Then I think you need to re-read brian's
>=20
>   https://lore.kernel.org/git/aS-D5lD2Kk6BHNIl@fruit.crustytoothpaste.ne=
t/

Oh, but brian described a scenario that is quite different: it is using
SSH. And there, the hook has quite literally the ability to verify that
the output goes to a terminal. It is also implicitly much more trustable
than a random HTTPS server because if you have SSH credentials to
authenticate with a server, there is already a much stronger trust
relationship here. That scenario is far away from some repository on
GitHub requiring a recursive clone that then points to some totally
untrustworthy HTTPS server hosted by the attacker.

> In any case, I do not think ISO/IEC 2022 matters as much as it used
> to back when the reencode_string_iconv() was written (which was the
> topic of another thread regarding the broken iconv on macOS wrt
> 2022).  But even if we limit ourselves to UTF-8, brian's point that
> applications do assume certain characteristics on its clients and
> implements unportable stuff.  A project targetting developers and/or
> users from certain locale may use their own hooks that assumes the
> clients understands strings in certain language in certain encoding.
>=20
> And to serve these projects better, classes like "pass colors",
> "pass cursor movements", might help than just "pass everything" vs
> "deny everything", but we probably want to try to keep it as simple
> as possible; trying to make it finer grained with extra complexity
> would only make our efforts look like whack-a-mole X-<.

Well, I only introduced that complexity because you asked for it on the
git-security mailing list. You offered concerns that an all-or-nothing
escape hatch was not fine-grained enough. It was hard enough for me to
tickle out what granularity exactly would be needed in addition to appease
the concerns, and obviously even what I did was not enough to be
accepted...

> >> It might even be a good idea to make the default setting of this
> >> variable "allow", except for the initial connections to repositories
> >> (i.e., "git clone $URL", and "git fetch/ls-remote $URL" with an
> >> explicit $URL without using a nickname recorded in our .git/config),
> >> as visiting a potentially malicious remote repository you are not
> >> familiar with may not be uncommon, and users may deserve protection
> >> over inconvenience.
> >>=20
> >> But once the user establishes a working relationship with a remote
> >> repository, would it be a lot more common to trust the contents
> >> there than be on the lookout that the repository may spew bad
> >> strings of bytes at your standard error stream, I have to wonder.
>=20
> >   tl;dr remote servers don't get more trustworthy just by successfully
> >   serving clones.
>=20
> The "successfully serving clone" has nothing to do with the reason
> why I suggested to deny by default in "clone" and anything that gets
> $URL not remote nickname.  I am roughly equating the fact that the
> user cloned *and* *then* continues to interact with the project that
> is served from that remote repository (hence using the remote
> nickname) with the willingness by the user to trust that particular
> remote repository.

Such a willingness to trust might be only because nothing bad happened
during the clone, though. In which case we made things worse that way, not
better.

Ciao,
Johannes
