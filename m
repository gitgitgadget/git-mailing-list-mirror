From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [WIP PATCH] Add skeleton remote helper for SVN
Date: Mon, 10 May 2010 20:00:42 +0800
Message-ID: <AANLkTilzn2GLbxz3vLD4SoNIrYDU9_YzFfPI5Wv_WFs2@mail.gmail.com>
References: <1273491574-31870-1-git-send-email-artagnon@gmail.com>
	 <1273491574-31870-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 14:00:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBRfG-0001iC-NM
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 14:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab0EJMAp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 08:00:45 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:62718 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab0EJMAo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 08:00:44 -0400
Received: by gxk9 with SMTP id 9so2656587gxk.8
        for <git@vger.kernel.org>; Mon, 10 May 2010 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5ck1YmHf0u/wt9Ab9IWMKY45/UOSqIu0efyPUTsB+fs=;
        b=i5+jljxxKejjgQs22mm1c8mwzXFzfhKM7HnNEC5iboku/B/rW7eicgTNHvRJIRI5zD
         bWgbWlc8mju/3RKwsEpwP8blcxUnl6MWHS2qhnQpv3t5J4+jwU3rrR+fFg+m35FQcAeB
         jPQ9v0gJ5fg9ApnJhpnCDzI5nYG0TchTacH/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C+fDyxJOJBb+RZ78du3qVaVKAME/ZyrEy4JXMr00RtKi44kqzu5xqenpZ405RTWAjB
         Uo6ubmJwI3wa/TGTuc9USVIROqz5jaNKjlvbLzGOOxpgB3IPZ6naDN8LrVgzdwW8iYnH
         8aaXFtf/tu+h3d75COzgQXatamFGbixrQ5I7w=
Received: by 10.231.173.85 with SMTP id o21mr1426909ibz.89.1273492842128; Mon, 
	10 May 2010 05:00:42 -0700 (PDT)
Received: by 10.231.13.194 with HTTP; Mon, 10 May 2010 05:00:42 -0700 (PDT)
In-Reply-To: <1273491574-31870-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146805>

Hi,

On Mon, May 10, 2010 at 7:39 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> diff --git a/Makefile b/Makefile
> index 4f7224a..06b969f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1658,7 +1658,7 @@ git.o git.spec \
>
> =A0TEST_OBJS :=3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
> =A0GIT_OBJS :=3D $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_O=
BJS) \
> - =A0 =A0 =A0 git.o http.o http-walker.o remote-curl.o
> + =A0 =A0 =A0 git.o http.o http-walker.o remote-curl.o remote-svn.o
> =A0XDIFF_OBJS =3D xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdif=
f/xemit.o \
> =A0 =A0 =A0 =A0xdiff/xmerge.o xdiff/xpatience.o
> =A0OBJECTS :=3D $(GIT_OBJS) $(XDIFF_OBJS)

Johnathan (Cc'ed) had a recent patch
(<20100509035728.GA8198@progeny.tock>) that changed this area, and I
think it would be good to build on top of that.

> [snip]
> diff --git a/remote-svn.c b/remote-svn.c
> new file mode 100644
> index 0000000..dafbd6a
> --- /dev/null
> +++ b/remote-svn.c
> @@ -0,0 +1,202 @@
> [snip]
> +static int set_option(const char *name, const char *value)
> +{
> + =A0 =A0 =A0 if (!strcmp(name, "verbosity")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *end;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int v =3D strtol(value, &end, 10);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value =3D=3D end || *end)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 options.verbosity =3D v;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 else if (!strcmp(name, "progress")) {

We usually put the brace on the same line as the "else":

    if (...) {
      /* stuff */
    } else if (...) {
      /* stuff */
    }

(of course, tabs should be used - gmail doesn't allow me to do it here.=
)

> [snip]
> +static int export_handler(int nr_spec, char **specs)
> +{
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 // TODO: The real exporting
> + =A0 =A0 =A0 =A0// TODO: Write an importer for SVN

Here and elsewhere - no C++-style comments please.

> [snip]
> +static void parse_import(struct strbuf *buf)
> +{
> + =A0 =A0 =A0 char **specs =3D NULL;
> + =A0 =A0 =A0 int alloc_spec =3D 0, nr_spec =3D 0, i;
> +
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!prefixcmp(buf->buf, "import ")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ALLOC_GROW(specs, nr_sp=
ec + 1, alloc_spec);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 specs[nr_spec++] =3D xs=
trdup(buf->buf + 5);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("remote helper does=
 not support %s", buf->buf);

See note on else-brace style.

--=20
Cheers,
Ray Chuan
