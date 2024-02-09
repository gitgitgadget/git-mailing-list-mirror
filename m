Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270ACA66
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511024; cv=none; b=CrA2jeQeEhcyXUxFQC1X9oj/+mv+klLRNbdC37kqPD5TVFsIFdUhyTRnZb+waiNgkkgGG8IAIEoWi9IBmlv2mWofg61GZv6Yzuw/hrz6Vn+difFXwKsUK5zrUt4NlCHgkSYCKV/ikg+HQInx4uEgrbgc9dqSEh9GUfx0J8Ofonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511024; c=relaxed/simple;
	bh=fM0GTAsgMbg4fQ7aGF72rrfpV0dIpdySiFKqjnEl9gg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=opJC9zGnrdhSYAvikMUjI/YKNyFhvtYsOvZuvLk2NaHdoXRrFf5UUMs1wGrUMR/rd/hOP3DCRoX/EtnZhxNlvaWf7FYvCmBYA3HbjTggQXBF/lB0knrYHdfAsQCzqjoHhuNEYyak2M9XsWJ3uTx7QCOBjJ8JoGwLI3Zw59tco18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=hktkhEYj; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="hktkhEYj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707511001; x=1708115801; i=l.s.r@web.de;
	bh=fM0GTAsgMbg4fQ7aGF72rrfpV0dIpdySiFKqjnEl9gg=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=hktkhEYjHy9jOF2iTiVJXO2F5HwGVv94H0i4PcS420Sy0FrfEG+WrlnS2aeVwKod
	 sC/oQDBZK7vqf5rH+x/c7AoAZjLHGgOpj0Tx8eVdu6ont7q5M41q34KY04087cK/y
	 er0gsG9UIdVAbaTbRo+PHFtYar2GnnAABWILHeKpYPoBQTAZPqJ+rRzeS9I3H9oTg
	 5ZluvFHj8aqsy2BeI0Bu1djQG6iDewlz/TZxrhA0Vhe7KizemTMWSlMZAekVicutn
	 Osn2rsKZp9sSRU3P2I65ffLbCt4Zecx2kE5ZyajdZvkGdxtm6xv1GSRuxMyjOzKgf
	 JaZVA466FXfY4QIKVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.17.81]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrPV-1rL9is2bBb-00MsVA; Fri, 09
 Feb 2024 21:36:41 +0100
Message-ID: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de>
Date: Fri, 9 Feb 2024 21:36:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>, Jeff King <peff@peff.net>,
 Kyle Lippincott <spectral@google.com>, John Cai <johncai86@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] receive-pack: use find_commit_header() in
 check_cert_push_options()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rbjvgsWTxCk5BzuevGjz0+OHxiftrDNsWtxQZxEmRyYEZ6bnXFD
 8Bn/1ipexNU0TpY1/OxCo09IIDkkme2i327D+tKG8dwy80o06DOp1ldPvwUL7oQVwc8X3+q
 BCfgWsUf8AkzaAdOR2w0iSmXdTm2TJGuCd5tN4Gc6IOOouLTtIO0KYY5hlIIWygTQJYmDt9
 Af0XWQ0sHfMGxKI6cgnRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EpnHZpVT+Eg=;3KEZT4Wdi+v7qxXX4A1SgRFkyKI
 C6zbCbOx9qGeWemd5OdrT98Mv3FgymyIOjfpnsZ/nVqczWP/50Id/z+CmuUZKJtB9+EDWjsnE
 lpUVGpNpRhEzjNpCcEoVAYtdcUyqTkMVmxA0hsm5MhRjV7qn/myrw2TL2v5U2nuwqwWcEBD/b
 L/JT9fB7buXV7SwsEKPq/2n6p7boQB9p+XOcaPFme3DPHX2jrQw5zaNMFWyWFzJn0n1A6oaiK
 EZrJGduj6YLfDLVLbp1bT7e4FDeRbgymkjL6UwfrX/VZq6k6YlTcKhyF/eUKZUBrMnezM13Gw
 SXAWpYCrxC+rKm28Z/UR2RBZ0xZKzoZEanOvOcA+eWeihjrL3Xy9LvcEWNJd+1TrjSz6tyIVr
 oTzIxzR+fmydgZC+8Eh5WAe6943w8w9qvMd2OIQ53lNaJqAnX60KnXnq0mdcV5+lpItY2tmLw
 z3mP5DWhuDatpQuD8F1Q/j+/oNVH3DtQSwMaeKakmHyqnYhpT41z1FzAN6uhAN/w4eIuG9I0r
 akL4KKowDiIoMyrfUVhnlScrEkuL8wVRL2C2qsYFWqbL67CM2lt+10jnx/CH88qGZN5lohUtp
 HH4fvPElxV8R6xpmgTmyOTWBrIPosFYFGFbNWwJlqkOG1bkBIoHRGY66arWgtdwk3l9ffaVKW
 ilj00fZHHnK3UpfFMdaeWuXcHGy22SQ6HFgexluVrQzNxjpZnxgXjvD6JBu4n7i8TIU7yHCN0
 OARhx/PHUceXLU33bmuMr2LyLttqGq3Bg56PPs/VuwyY+LkO1kHfIv3WNa5KP78QyJkgvAOyX
 M6+Zrrbg+BSs09uKed5xmMNTuAzK+aPiaEd+p4t63jps8=

Use the public function find_commit_header() instead of find_header() to
simplify the code.  This is possible and safe because we're operating on
a strbuf, which is always NUL-terminated, so there is no risk of running
over the end of the buffer.  It cannot contain NUL within the buffer, as
it is built using strbuf_addstr(), only.

The string comparison becomes more complicated because we need to check
for NUL explicitly after comparing the length-limited option, but on the
flip side we don't need to clean up allocations or track the remaining
buffer length.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/receive-pack.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e36b1d619f..8ebb3a872f 100644
=2D-- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -718,35 +718,29 @@ static const char *check_nonce(const char *buf, size=
_t len)
 static int check_cert_push_options(const struct string_list *push_options=
)
 {
 	const char *buf =3D push_cert.buf;
-	int len =3D push_cert.len;

-	char *option;
-	const char *next_line;
+	const char *option;
+	size_t optionlen;
 	int options_seen =3D 0;

 	int retval =3D 1;

-	if (!len)
+	if (!*buf)
 		return 1;

-	while ((option =3D find_header(buf, len, "push-option", &next_line))) {
-		len -=3D (next_line - buf);
-		buf =3D next_line;
+	while ((option =3D find_commit_header(buf, "push-option", &optionlen))) =
{
+		buf =3D option + optionlen + 1;
 		options_seen++;
 		if (options_seen > push_options->nr
-		    || strcmp(option,
-			      push_options->items[options_seen - 1].string)) {
-			retval =3D 0;
-			goto leave;
-		}
-		free(option);
+		    || strncmp(push_options->items[options_seen - 1].string,
+			       option, optionlen)
+		    || push_options->items[options_seen - 1].string[optionlen])
+			return 0;
 	}

 	if (options_seen !=3D push_options->nr)
 		retval =3D 0;

-leave:
-	free(option);
 	return retval;
 }

=2D-
2.43.0
