Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62CEC433F7
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A84620739
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YPRnYN1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgGPM4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:56:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:50403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728822AbgGPM4i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594904179;
        bh=I/IgQf+Q11/PYyMF3E+1FPOXRxJDlt8FUvfgi5S99MU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YPRnYN1XRoxET1mmnJHCO24pnFbELmBHs0BzdaTUhDsO4jL243ocWUGwDZzsNedpw
         +EiUJVsxCi4QJA4sHTZFxBPQS+qFdZ4qDhV/su2IgyxN1xkXLdLWAGVHRBqMPDyFhn
         X29qvGz9W1plex8ciUYOQ1E288CCElneq2cmPBGE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.237.98] ([213.196.212.102]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1jwbOj2Sm2-000cfu; Thu, 16
 Jul 2020 14:56:19 +0200
Date:   Thu, 16 Jul 2020 13:29:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, j6t@kdbg.org,
        jonathantanmy@google.com, peff@peff.net,
        christian.couder@gmail.com, Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v2 2/2] hex: make hash_to_hex_algop() and friends
 thread-safe
In-Reply-To: <b47445fa1cef6d4523dd0ca336f7ee22bce89466.1593208411.git.matheus.bernardino@usp.br>
Message-ID: <nycvar.QRO.7.76.6.2007161214270.54@tvgsbejvaqbjf.bet>
References: <cover.1593208411.git.matheus.bernardino@usp.br> <b47445fa1cef6d4523dd0ca336f7ee22bce89466.1593208411.git.matheus.bernardino@usp.br>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:meuWycV8Mwg6YFCMDILRZuw/djyjqiAyfDCWs5gPuKMGPgMwGNr
 gUmkcCjEmnTqOcTBt1oxIRr+N7slKH7OI0P3XNpjsapvgUjO57/eL8UFNv5ULH6Ja0NyRlK
 8u2lT6VjW7M7MVlXEHZFus7s6AfIPpbABdPc1vDrb74TOY/D6YtfXazE6eUcpqlcD7kk46E
 7g/ZZ91oBqjBK7bJnrAfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4r8A1KIX+kg=:DtLHjbrwnpBOnPXcjbfmxe
 3/DjKj4iUyNlc1jEz2BqvUK2klvzJ4QxkjxyDnG90Y1uUYXm+xKHmDs4zClefyBsUrZ/RC9tD
 ehJGPv/4Ck8LvLWDtuKsr1evf3V5ZJItQjK+COAStZjt6tiTCKkQVy/Fmq4fvRf5ldl3eHLC9
 cZa2fWwXGOxaBbcjkkgrNLAIoTDz0a1Q/hH/EjkIuWaMVlkc4FAD/f3HSbf19f+lyek3L2baE
 ZJQq9dwU0mff/+tsSk9oBX6Vp6SgSMEchFxu+7G/GhNbH/N224sZVEQ3iN+tJC1pFpyDWp0Uv
 AgMV7KKu4WhwcmT7A6aDnnEn6oycy3Hbn+YnUk3q2VY+fEZTK+l4IxtnsO4lBaaGQb2Mn3P+1
 5zG65mVpM9gbQBH1MA3P200GvNPNZu/SsdkXCLP8duwlim9r1idQQcB+GmAc0i/S1x9Ef2SHb
 jUPXm5JxwxbCfLYbD9uaicWQrnXq8qS04Q6fjN/rz8PWM7OvzhzQynOqSjE31RHhXjUriX9OX
 PBHhW3RNn8a4nHBpmfyKVsZEHmikKIsaeba8edQlM8ojMhWIeR/B6DnDqqnAb6w+nXtt+XOX8
 VLfjDa5RDjkCAiwTyQCm9PY89LDT7NQnPeCJ1foA/x+NoA33/izDUNS00yHnuainsM4TnhyQQ
 PIUIT+UiwNASceJ5BEvRcnF4gwxveV4IOW18mDriV+YXsdJsWQ1QsO18/r3yGsraOF11HxIsy
 bAiFOqxIChxDrMRVNSqSwMHISfcmnR0kxBtFLJ85zwNCa9WD9VqnL+jlN8j/1sMS2Wauc+Ldg
 bz1MivXkap0jEvFeiKkopWHCjQPIYRgIC3eBDZdzPXejoObLSCZRSpB08UoOfcjFykbIDpUDz
 wBF1mJlnSUWnrHqb0q4D5w6zJ8q10HhH/JN1NcErurjjhoqAZXJgYcOsj/Sg2SwzxFshty2EE
 tvg+0iJZ0Ul4vuajeZGO1q+SOA1QbMBEa8JmA+YpHpX0fNByr6efJXS0g6iGaLNVyYYTab5Mu
 YgtDD8VFajuFnpHfrl892U6LlypDHU8trZXDf+uRfa2xk0Hz2D9pI8aSHERY1XI35Or3yLFPW
 SjqpFsrtaxTmeh9ZqXJznqXf6BOvILKCXM9fr9EmPQXfcM2bZ47iCD4GQEluCtfOSczXOxPa+
 JGK4KRzRPwcvRSXxkptgoqF4mxIYc01kZb4q3/DCtmbEMGuEXRjtNPQOh53Bq6wPrOfzuUnbY
 IRiweWsvGRsdZTWLBcwAajyc0rP3/gPLPriwbZg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Fri, 26 Jun 2020, Matheus Tavares wrote:

> @@ -136,12 +137,49 @@ char *oid_to_hex_r(char *buffer, const struct obje=
ct_id *oid)
>  	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
>  }
>
> +struct hexbuf_array {
> +	int idx;
> +	char bufs[4][GIT_MAX_HEXSZ + 1];
> +};
> +
> +#ifdef HAVE_THREADS
> +static pthread_key_t hexbuf_array_key;
> +static pthread_once_t hexbuf_array_once =3D PTHREAD_ONCE_INIT;
> +
> +static void init_hexbuf_array_key(void)
> +{
> +	if (pthread_key_create(&hexbuf_array_key, free))
> +		die(_("failed to initialize threads' key for hash to hex conversion")=
);
> +}
> +
> +#else
> +static struct hexbuf_array default_hexbuf_array;
> +#endif
> +
>  char *hash_to_hex_algop(const unsigned char *hash, const struct git_has=
h_algo *algop)
>  {
> -	static int bufno;
> -	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
> -	bufno =3D (bufno + 1) % ARRAY_SIZE(hexbuffer);
> -	return hash_to_hex_algop_r(hexbuffer[bufno], hash, algop);
> +	struct hexbuf_array *ha;
> +
> +#ifdef HAVE_THREADS
> +	void *value;
> +
> +	if (pthread_once(&hexbuf_array_once, init_hexbuf_array_key))
> +		die(_("failed to initialize threads' key for hash to hex conversion")=
);
> +
> +	value =3D pthread_getspecific(hexbuf_array_key);
> +	if (value) {
> +		ha =3D (struct hexbuf_array *) value;
> +	} else {
> +		ha =3D xmalloc(sizeof(*ha));

I just realized (while trying to debug something independent) that this
leaves `ha->idx` uninitialized. So you will need at least this patch to
fix a bug that currently haunts `seen`'s CI builds (you can use
`--valgrind`, like I did, to identify the problem):

=2D- snip --
diff --git a/hex.c b/hex.c
index 4f2f163d5e7..365ba94ab11 100644
=2D-- a/hex.c
+++ b/hex.c
@@ -171,6 +171,7 @@ char *hash_to_hex_algop(const unsigned char *hash, con=
st struct git_hash_algo *a
 		ha =3D (struct hexbuf_array *) value;
 	} else {
 		ha =3D xmalloc(sizeof(*ha));
+		ha->idx =3D 0;
 		if (pthread_setspecific(hexbuf_array_key, (void *)ha))
 			die(_("failed to set thread buffer for hash to hex conversion"));
 	}
=2D- snap --

But as I mentioned before, I would be much more in favor of abandoning
this thread-local idea (because it is _still_ fragile, as the same thread
could try to make use of more than four hex values in the same `printf()`,
for example) and instead using Coccinelle to convert all those
`oid_to_hex()` calls to `oid_to_hex_r()` calls.

Now, I am _far_ from knowing what I'm doing with Coccinelle, but I think
this here semantic patch should get you going:

=2D- snipsnap --
@@
expression E;
@@
  {
++   char hex[GIT_MAX_HEXSZ + 1];
     ...
-    oid_to_hex(E)
+    oid_to_hex_r(hex, E)
     ...
  }

@@
expression E1, E2;
@@
  {
++   char hex1[GIT_MAX_HEXSZ + 1], hex2[GIT_MAX_HEXSZ + 1];
     ...
-    oid_to_hex(E1)
+    oid_to_hex_r(hex1, E1)
     ...
-    oid_to_hex(E2)
+    oid_to_hex_r(hex2, E2)
     ...
  }
