Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 686581F453
	for <e@80x24.org>; Wed, 30 Jan 2019 15:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfA3Plm (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 10:41:42 -0500
Received: from mail.pdinc.us ([67.90.184.27]:37204 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfA3Plm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 10:41:42 -0500
X-Greylist: delayed 1016 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 10:41:41 EST
Received: from blackfat (five-58.pdinc.us [192.168.5.58])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id x0UFOie0023844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 30 Jan 2019 10:24:44 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us x0UFOie0023844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1548861884; bh=iH2Uk2oAkubcHlRy0/6vaffUY2uZNU4mtspy/ylCZs8=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=htC0+Fi1wEvnZoogoOYJ6wvgJRBtEfiDsFRRY1TQLzpnurHezfDAywHNey3oY41KJ
         miBFzgSoNOWPVxZ3t9ymH1EUOZNqyZjXwLF1LH1qKP81VKMjgSbvLfeD3Ktu3244Fo
         k7ERKM0zc6yRVQOHLAuFgHV92jO6f2cCZUhKR4PZA6TTQt9WOJN7pHQXynO/1ou+uE
         /tyFthwYEAJOK9mZwf9sObdiLuE22z4HYaDmE/hluLioVXupuxlLV7FCiUXjSSllMN
         fHa39m9V7BFje/7NbkguJyomRgO2dDsO5FO9TIoNaTVZjfQU1yjnPAp9A0NgF/5hlj
         AjgfHWB4Gw/Rg==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <tboegi@web.de>, <git@vger.kernel.org>, <adrigibal@gmail.com>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com> <20190130150152.23040-1-tboegi@web.de>
In-Reply-To: <20190130150152.23040-1-tboegi@web.de>
Subject: RE: [PATCH v3 1/1] Support working-tree-encoding "UTF-16LE-BOM"
Date:   Wed, 30 Jan 2019 10:24:44 -0500
Organization: PD Inc
Message-ID: <000901d4b8af$edaccf20$c9066d60$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGzHBPypQu4TMaDIA8Y5jdFC6/IqAI9vceMpfk2+AA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf =
Of
> tboegi@web.de
> Sent: Wednesday, January 30, 2019 10:02 AM
> To: git@vger.kernel.org; adrigibal@gmail.com
> Cc: Torsten B=C3=B6gershausen <tboegi@web.de>
> Subject: [PATCH v3 1/1] Support working-tree-encoding "UTF-16LE-BOM"
>=20
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>=20
> Users who want UTF-16 files in the working tree set the .gitattributes
> like this:
> test.txt working-tree-encoding=3DUTF-16
>=20
> The unicode standard itself defines 3 allowed ways how to encode =
UTF-16.
> The following 3 versions convert all back to 'g' 'i' 't' in UTF-8:
>=20
> a) UTF-16, without BOM, big endian:
> $ printf "\000g\000i\000t" | iconv -f UTF-16 -t UTF-8 | od -c
> 0000000    g   i   t
>=20
> b) UTF-16, with BOM, little endian:
> $ printf "\377\376g\000i\000t\000" | iconv -f UTF-16 -t UTF-8 | od -c
> 0000000    g   i   t
>=20
> c) UTF-16, with BOM, big endian:
> $ printf "\376\377\000g\000i\000t" | iconv -f UTF-16 -t UTF-8 | od -c
> 0000000    g   i   t
>=20
> Git uses libiconv to convert from UTF-8 in the index into ITF-16 in =
the
> working tree.
> After a checkout, the resulting file has a BOM and is encoded in =
"UTF-16",
> in the version (c) above.
> This is what iconv generates, more details follow below.
>=20
> iconv (and libiconv) can generate UTF-16, UTF-16LE or UTF-16BE:
>=20
> d) UTF-16
> $ printf 'git' | iconv -f UTF-8 -t UTF-16 | od -c
> 0000000  376 377  \0   g  \0   i  \0   t
>=20
> e) UTF-16LE
> $ printf 'git' | iconv -f UTF-8 -t UTF-16LE | od -c
> 0000000    g  \0   i  \0   t  \0
>=20
> f)  UTF-16BE
> $ printf 'git' | iconv -f UTF-8 -t UTF-16BE | od -c
> 0000000   \0   g  \0   i  \0   t
>=20
> There is no way to generate version (b) from above in a Git working =
tree,
> but that is what some applications need.
> (All fully unicode aware applications should be able to read all 3
> variants,
> but in practise we are not there yet).
>=20
> When producing UTF-16 as an output, iconv generates the big endian =
version
> with a BOM. (big endian is probably chosen for historical reasons).
>=20
> iconv can produce UTF-16 files with little endianess by using =
"UTF-16LE"
> as encoding, and that file does not have a BOM.
>=20
> Not all users (especially under Windows) are happy with this.
> Some tools are not fully unicode aware and can only handle version =
(b).
>=20
> Today there is no way to produce version (b) with iconv (or libiconv).
> Looking into the history of iconv, it seems as if version (c) will
> be used in all future iconv versions (for compatibility reasons).


Reading the RFC 2781 section 3.3:
=20
   Text in the "UTF-16BE" charset MUST be serialized with the octets
   which make up a single 16-bit UTF-16 value in big-endian order.
   Systems labelling UTF-16BE text MUST NOT prepend a BOM to the text.

   Text in the "UTF-16LE" charset MUST be serialized with the octets
   which make up a single 16-bit UTF-16 value in little-endian order.
   Systems labelling UTF-16LE text MUST NOT prepend a BOM to the text.

I opened a bug with libiconv... =
https://savannah.gnu.org/bugs/index.php?55609

>=20
> Solve this dilemma and introduce a Git-specific "UTF-16LE-BOM".
> libiconv can not handle the encoding, so Git pick it up, handles the =
BOM
> and uses libiconv to convert the rest of the stream.
> (UTF-16BE-BOM is added for consistency)
>=20
> Rported-by: Adri=C3=A1n Gimeno Balaguer <adrigibal@gmail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>=20
> Changes since v2:
>   Update the commit message (s/possible/allowed/)
>   Update the documentation, as suggested by Junio:
>   ...wonder if the following,
>      instead of the above hunk, would work better..
>   Yes, it does.
>=20
> Documentation/gitattributes.txt  |  4 ++-
>  compat/precompose_utf8.c         |  2 +-
>  t/t0028-working-tree-encoding.sh | 12 ++++++++-
>  utf8.c                           | 42 =
++++++++++++++++++++++++--------
>  utf8.h                           |  2 +-
>  5 files changed, 48 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/gitattributes.txt
> b/Documentation/gitattributes.txt
> index b8392fc330..a2310fb920 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -344,7 +344,9 @@ automatic line ending conversion based on your
> platform.
>=20
>  Use the following attributes if your '*.ps1' files are UTF-16 little
>  endian encoded without BOM and you want Git to use Windows line =
endings
> -in the working directory. Please note, it is highly recommended to
> +in the working directory (use `UTF-16-LE-BOM` instead of `UTF-16LE` =
if
> +you want UTF-16 little endian with BOM).
> +Please note, it is highly recommended to
>  explicitly define the line endings with `eol` if the `working-tree-
> encoding`
>  attribute is used to avoid ambiguity.
>=20
> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index de61c15d34..136250fbf6 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -79,7 +79,7 @@ void precompose_argv(int argc, const char **argv)
>  		size_t namelen;
>  		oldarg =3D argv[i];
>  		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
> -			newarg =3D reencode_string_iconv(oldarg, namelen,
> ic_precompose, NULL);
> +			newarg =3D reencode_string_iconv(oldarg, namelen,
> ic_precompose, 0, NULL);
>  			if (newarg)
>  				argv[i] =3D newarg;
>  		}
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-
> encoding.sh
> index 7e87b5a200..e58ecbfc44 100755
> --- a/t/t0028-working-tree-encoding.sh
> +++ b/t/t0028-working-tree-encoding.sh
> @@ -11,9 +11,12 @@ test_expect_success 'setup test files' '
>=20
>  	text=3D"hallo there!\ncan you read me?" &&
>  	echo "*.utf16 text working-tree-encoding=3Dutf-16" >.gitattributes =
&&
> +	echo "*.utf16lebom text working-tree-encoding=3DUTF-16LE-BOM"
> >>.gitattributes &&
>  	printf "$text" >test.utf8.raw &&
>  	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
>  	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
> +	printf "\377\376"                         >test.utf16lebom.raw &&
> +	printf "$text" | iconv -f UTF-8 -t UTF-32LE >>test.utf16lebom.raw &&
>=20
>  	# Line ending tests
>  	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
> @@ -32,7 +35,8 @@ test_expect_success 'setup test files' '
>  	# Add only UTF-16 file, we will add the UTF-32 file later
>  	cp test.utf16.raw test.utf16 &&
>  	cp test.utf32.raw test.utf32 &&
> -	git add .gitattributes test.utf16 &&
> +	cp test.utf16lebom.raw test.utf16lebom &&
> +	git add .gitattributes test.utf16 test.utf16lebom &&
>  	git commit -m initial
>  '
>=20
> @@ -51,6 +55,12 @@ test_expect_success 're-encode to UTF-16 on =
checkout' '
>  	test_cmp_bin test.utf16.raw test.utf16
>  '
>=20
> +test_expect_success 're-encode to UTF-16-LE-BOM on checkout' '
> +	rm test.utf16lebom &&
> +	git checkout test.utf16lebom &&
> +	test_cmp_bin test.utf16lebom.raw test.utf16lebom
> +'
> +
>  test_expect_success 'check $GIT_DIR/info/attributes support' '
>  	test_when_finished "rm -f test.utf32.git" &&
>  	test_when_finished "git reset --hard HEAD" &&
> diff --git a/utf8.c b/utf8.c
> index eb78587504..83824dc2f4 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -4,6 +4,11 @@
>=20
>  /* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ =
*/
>=20
> +static const char utf16_be_bom[] =3D {'\xFE', '\xFF'};
> +static const char utf16_le_bom[] =3D {'\xFF', '\xFE'};
> +static const char utf32_be_bom[] =3D {'\0', '\0', '\xFE', '\xFF'};
> +static const char utf32_le_bom[] =3D {'\xFF', '\xFE', '\0', '\0'};
> +
>  struct interval {
>  	ucs_char_t first;
>  	ucs_char_t last;
> @@ -470,16 +475,17 @@ int utf8_fprintf(FILE *stream, const char =
*format,
> ...)
>  #else
>  	typedef char * iconv_ibp;
>  #endif
> -char *reencode_string_iconv(const char *in, size_t insz, iconv_t =
conv,
> size_t *outsz_p)
> +char *reencode_string_iconv(const char *in, size_t insz, iconv_t =
conv,
> +			    size_t bom_len, size_t *outsz_p)
>  {
>  	size_t outsz, outalloc;
>  	char *out, *outpos;
>  	iconv_ibp cp;
>=20
>  	outsz =3D insz;
> -	outalloc =3D st_add(outsz, 1); /* for terminating NUL */
> +	outalloc =3D st_add(outsz, 1 + bom_len); /* for terminating NUL */
>  	out =3D xmalloc(outalloc);
> -	outpos =3D out;
> +	outpos =3D out + bom_len;
>  	cp =3D (iconv_ibp)in;
>=20
>  	while (1) {
> @@ -540,10 +546,30 @@ char *reencode_string_len(const char *in, size_t
> insz,
>  {
>  	iconv_t conv;
>  	char *out;
> +	const char *bom_str =3D NULL;
> +	size_t bom_len =3D 0;
>=20
>  	if (!in_encoding)
>  		return NULL;
>=20
> +	/* UTF-16LE-BOM is the same as UTF-16 for reading */
> +	if (same_utf_encoding("UTF-16LE-BOM", in_encoding))
> +		in_encoding =3D "UTF-16";
> +
> +	/*
> +	 * For writing, UTF-16 iconv typically creates "UTF-16BE-BOM"
> +	 * Some users under Windows want the little endian version
> +	 */
> +	if (same_utf_encoding("UTF-16LE-BOM", out_encoding)) {
> +		bom_str =3D utf16_le_bom;
> +		bom_len =3D sizeof(utf16_le_bom);
> +		out_encoding =3D "UTF-16LE";
> +	} else if (same_utf_encoding("UTF-16BE-BOM", out_encoding)) {
> +		bom_str =3D utf16_be_bom;
> +		bom_len =3D sizeof(utf16_be_bom);
> +		out_encoding =3D "UTF-16BE";
> +	}
> +
>  	conv =3D iconv_open(out_encoding, in_encoding);
>  	if (conv =3D=3D (iconv_t) -1) {
>  		in_encoding =3D fallback_encoding(in_encoding);
> @@ -553,9 +579,10 @@ char *reencode_string_len(const char *in, size_t
> insz,
>  		if (conv =3D=3D (iconv_t) -1)
>  			return NULL;
>  	}
> -
> -	out =3D reencode_string_iconv(in, insz, conv, outsz);
> +	out =3D reencode_string_iconv(in, insz, conv, bom_len, outsz);
>  	iconv_close(conv);
> +	if (out && bom_str && bom_len)
> +		memcpy(out, bom_str, bom_len);
>  	return out;
>  }
>  #endif
> @@ -566,11 +593,6 @@ static int has_bom_prefix(const char *data, =
size_t
> len,
>  	return data && bom && (len >=3D bom_len) && !memcmp(data, bom,
> bom_len);
>  }
>=20
> -static const char utf16_be_bom[] =3D {'\xFE', '\xFF'};
> -static const char utf16_le_bom[] =3D {'\xFF', '\xFE'};
> -static const char utf32_be_bom[] =3D {'\0', '\0', '\xFE', '\xFF'};
> -static const char utf32_le_bom[] =3D {'\xFF', '\xFE', '\0', '\0'};
> -
>  int has_prohibited_utf_bom(const char *enc, const char *data, size_t =
len)
>  {
>  	return (
> diff --git a/utf8.h b/utf8.h
> index edea55e093..84efbfcb1f 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -27,7 +27,7 @@ void strbuf_utf8_replace(struct strbuf *sb, int pos, =
int
> width,
>=20
>  #ifndef NO_ICONV
>  char *reencode_string_iconv(const char *in, size_t insz,
> -			    iconv_t conv, size_t *outsz);
> +			    iconv_t conv, size_t bom_len, size_t *outsz);
>  char *reencode_string_len(const char *in, size_t insz,
>  			  const char *out_encoding,
>  			  const char *in_encoding,
> --
> 2.20.1.2.gb21ebb671
>=20


