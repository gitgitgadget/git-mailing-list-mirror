Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021471B48
	for <git@vger.kernel.org>; Tue, 21 May 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300914; cv=none; b=kIk7mWfYClPx542x8r3gndS8jV6qBu9q5RYUD4qtJfT8Qk6gSpkDd34fXUKjgfHFQZR/ikEQZ9d6R7km3LIF1D/svEa13bv8VOgQTvp/H9y6lVIPWT5sT/e09BOg9vSLm1dR3uZwpP3JNzK1gVH9N/8FwJlNchVyDmXCHL6vWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300914; c=relaxed/simple;
	bh=wPHz5wFVH3ulcZAH+F3pCd6aWDPO1tGBTWzKLOkvBg4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sh/E5T+JWKvlffV72EUTEFrM97kNavU7zqLmu/8o2kBa5w1KFbH/9Y2VhNLXpyACX79QKo9YmASd1aIrdXK4F4ebaOK+d/eBvPe31LkaVRMOuHs3Gri36xZAPvqwakjpmkjFk2s6WtZtV/oUcIi+vewuSzrZqKzC90/6jnDEdr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=pJcEIOam; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="pJcEIOam"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716300894; x=1716905694; i=tboegi@web.de;
	bh=q3TdLtom0L6V56GNkzIeT/w0M99lHs85M4QKkmNfN1s=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pJcEIOamBqXmUCDHef52ZSbEj7bnRLJwV6f5hpdU+sc33+1Vh6O2gkjHYFPwHqc/
	 /SttwzDln2Fnv2dRPWCEhPMBRT6gid4amJpO1Zdpqd08PDOxsZPHy5VcRSMwLukaz
	 XjDKZYpwmTOqZiPBoNxXmGmoRszLrvsXUcmUzFmDmoH5ZyD204f84t8xHaBfDI3CQ
	 BxzllS2Ex5Hc/u3icNkqD7UAENhHyZDqR5vS605Fai7kUAH8Kc+2xdDFOcecCBTK7
	 VuckWH+AabE1tP6xxbJwUfHYY8elCmiujImN5UruBFrWiiAhp3p12hNFDte8G3Xzy
	 51zgflO7C7X78UynZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([81.231.143.213]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MRF3I-1rvClG3TSm-00NJNH; Tue, 21 May 2024 16:14:54 +0200
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	takimoto-j@kba.biglobe.ne.jp
Subject: [PATCH v3 1/1] macOS: ls-files path fails if path of workdir is NFD
Date: Tue, 21 May 2024 16:14:52 +0200
Message-ID: <20240521141452.26210-1-tboegi@web.de>
X-Mailer: git-send-email 2.41.0.394.ge43f4fd0bd
In-Reply-To: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5pCH1WwmHLfB7mXS06Ag1bCB4l/KA+x3B9L08bBNtF9xpu/YT6
 +gEQUnYAvlDvnsoyywP37pZHaq4Vkdk61HYZkZloSwTnEar9wENPa1NSbj5gQQtErrMk7I1
 tcnHu2NcTMs/oaV1S/m99uUdX/om6uSa3mpPhrjRCAC1nzCrgNs9438uz3gMK5KoZrCCISk
 EWGQFCM170y/UvNbVeMyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FbFfSCk1j6s=;p7nH5KL+vx3EYYzQagbNnpIISVh
 FYHT1LEZ4Gj5gYfUyrOOVNczZKSbRUYowgtozopoPJz7P+cKk2s60MS8y5Ii6Mv1RX5rVelTX
 uVcwPtgKqlnigDdnb4jh/TrHq22GdGum5+DzrnGvibutE2V0jY1xWyQl3JGYijh+4jT4Wn8j9
 oU0g9tEgWcKqZIDRNRM1aVeI2KgHlummTDakkT6biYZ2C8Qvr9Hph9TGpLCIrPsLp6u2JQ2LW
 XV7W5wmqxkFTqVuef/YQARXPY292ngyACJ0r0ZX5hxvmGIQR/70WjgLHRDWu+D/OiaER79kE7
 BCRIfo3crcPXIy3XTOi3lszfz6j61kXKrSTsY+RvYHo6prbdbMd0Trh94AclCVdjBxilAOLid
 7vap1OhDiUH/IECbKqm5zFTtQARhhlv5va9V0+OR4ADaWyChCgHpLNGO0QYniJAKtRRTSLq3l
 TufLt8saDm4o9G8Wm0wDrhjYh4LQNBCnC/4F8jqfKs7Nb5XD5rIk7P7P0wqQ2bV0AWkEqHVpk
 oJ7i7p5UptNltFjLnr+1Wjp9UsZYwEeDUYxVO4lDD6ULDv84aO/nurzCYswSytrpFjKPzg24+
 CPHSuEw8iRdjMJWgvI5o61rjBCJ6yBC16hn7urtnA0OHwBMYR/PVPsQdhxuqt+/PwxUnR7oqe
 9rvmdVCe1TNxyVZKugLdgEpID1dPfXmF3wfsyIiBibNPaBipCZW5XojMCMJS36o05edVYusvE
 3jcNZJ2KSN5t+9cULkclrfHqrbIedzw/Tg0SWt9HUcqNjw31wMTmk1kiBRUORJIyHfIbJYpI9
 fMo9QlY0Narre1ks1O1i6RaPXqE2heMm26C8hrWjjuiEY=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Under macOS, `git ls-files path` does not work (gives an error)
if the absolute 'path' contains characters in NFD (decomposed).
This happens when core.precomposeunicode is true, which is the
most common case. The bug report says:

$ cd somewhere          # some safe place, /tmp or ~/tmp etc.
$ mkdir $'u\xcc\x88'    # =C3=BC in NFD
$ cd =C3=BC                  # or cd $'u\xcc\x88' or cd $'\xc3\xbc'
$ git init
$ git ls-files $'/somewhere/u\xcc\x88'   # NFD
  fatal: /somewhere/=C3=BC: '/somewhere/=C3=BC' is outside repository at '=
/somewhere/=C3=BC'
$ git ls-files $'/somewhere/\xc3\xbc'    # NFC
(the same error as above)

In the 'fatal:' error message, there are three =C3=BC;
the 1st and 2nd are in NFC, the 3rd is in NFD.

Add a test case that follows the bug report, with the simplification
that the '=C3=BC' is replaced by an '=C3=A4', which is already used as NFD=
 and
NFC in t0050.

Precompose the result of getcwd(), if needed, just like all other
paths we use internally.  That way, paths comparisons are all done
in NFC and we would correctly notice that the early part of the
path given as an absolute path matches the current directory.

One possible implementation would be to re-define getcwd() similar
to opendir(), readdir() and closedir(), but since there is already a
strbuf wrapper around getcwd(), and only this wrapper is used inside
the whole codebase, equip strbuf_getcwd() with a call to the newly
created function precompose_strbuf_if_needed().

Note that precompose_strbuf_if_needed() is a function under macOS,
and is a "no-op" on all other systems.

Add a missing call to precompose_string_if_needed() to this code
in setup.c :
`work_tree =3D precompose_string_if_needed(get_git_work_tree());`

Reported-by: Jun T <takimoto-j@kba.biglobe.ne.jp>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 compat/precompose_utf8.c | 10 ++++++++++
 compat/precompose_utf8.h |  1 +
 git-compat-util.h        |  1 +
 setup.c                  |  2 +-
 strbuf.c                 |  1 +
 t/t0050-filesystem.sh    | 26 ++++++++++++++++++++++++++
 6 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 0bd5c24250..5a7c90c90d 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -94,6 +94,16 @@ const char *precompose_string_if_needed(const char *in)
 	return in;
 }

+void precompose_strbuf_if_needed(struct strbuf *sb)
+{
+	char *buf_prec =3D (char *)precompose_string_if_needed(sb->buf);
+	if (buf_prec !=3D sb->buf) {
+		size_t buf_prec_len =3D strlen(buf_prec);
+		free(strbuf_detach(sb, NULL));
+		strbuf_attach(sb, buf_prec, buf_prec_len, buf_prec_len + 1);
+	}
+}
+
 const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix)
 {
 	int i =3D 0;
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index fea06cf28a..7c3cfcadb0 100644
=2D-- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -30,6 +30,7 @@ typedef struct {

 const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix);
 const char *precompose_string_if_needed(const char *in);
+void precompose_strbuf_if_needed(struct strbuf *sb);
 void probe_utf8_pathname_composition(void);

 PREC_DIR *precompose_utf8_opendir(const char *dirname);
diff --git a/git-compat-util.h b/git-compat-util.h
index 3e7a59b5ff..8b63108f16 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -331,6 +331,7 @@ static inline const char *precompose_string_if_needed(=
const char *in)
 	return in;
 }

+#define precompose_strbuf_if_needed(a)
 #define probe_utf8_pathname_composition()
 #endif

diff --git a/setup.c b/setup.c
index 2e607632db..61f61496ec 100644
=2D-- a/setup.c
+++ b/setup.c
@@ -48,7 +48,7 @@ static int abspath_part_inside_repo(char *path)
 	size_t wtlen;
 	char *path0;
 	int off;
-	const char *work_tree =3D get_git_work_tree();
+	const char *work_tree =3D precompose_string_if_needed(get_git_work_tree(=
));
 	struct strbuf realpath =3D STRBUF_INIT;

 	if (!work_tree)
diff --git a/strbuf.c b/strbuf.c
index 4c9ac6dc5e..b05581d8e7 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -569,6 +569,7 @@ int strbuf_getcwd(struct strbuf *sb)
 		strbuf_grow(sb, guessed_len);
 		if (getcwd(sb->buf, sb->alloc)) {
 			strbuf_setlen(sb, strlen(sb->buf));
+			precompose_strbuf_if_needed(sb);
 			return 0;
 		}

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 325eb1c3cd..5a9ee5be92 100755
=2D-- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -156,4 +156,30 @@ test_expect_success CASE_INSENSITIVE_FS 'checkout wit=
h no pathspec and a case in
 	)
 '

+test_expect_success 'git ls-files under NFD' '
+	(
+		mkdir -p "somewhere/$aumlcdiar" &&
+		mypwd=3D$PWD &&
+		cd "somewhere/$aumlcdiar" &&
+		git init &&
+		git --literal-pathspecs ls-files "$mypwd/somewhere/$aumlcdiar" 2>err &&
+		>expected &&
+		test_cmp expected err
+	)
+'
+
+# Re-do the same test. Note: global core.precomposeunicode is changed
+test_expect_success 'git ls-files under NFD. global precompose false' '
+	test_when_finished "git config --global --unset core.precomposeunicode" =
&&
+	(
+		mypwd=3D$PWD &&
+		cd "somewhere/$aumlcdiar" &&
+		git config --global core.precomposeunicode false &&
+		git config core.precomposeunicode true &&
+		git --literal-pathspecs ls-files "$mypwd/somewhere/$aumlcdiar" 2>err &&
+		>expected &&
+		test_cmp expected err
+	)
+'
+
 test_done
=2D-
2.41.0.394.ge43f4fd0bd

