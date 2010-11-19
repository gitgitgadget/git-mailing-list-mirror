From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Normalise directory names when pushing to some WebDAV servers
Date: Fri, 19 Nov 2010 12:02:38 +0800
Message-ID: <AANLkTikM8mNv+GiVyDWEJxsf0o3FYaaJj+jdYyiuXnov@mail.gmail.com>
References: <1290125163-31065-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
X-From: git-owner@vger.kernel.org Fri Nov 19 05:07:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJIFx-0008Hg-Ke
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 05:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324Ab0KSECk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 23:02:40 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45448 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab0KSECj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Nov 2010 23:02:39 -0500
Received: by ewy5 with SMTP id 5so262236ewy.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 20:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EbOcyS3L0J8O531hYOjSlXxlNnTBzNAzGFPif1Y5WJ8=;
        b=B+asChsZsaSXx8uyP4HsvFsAfkvBg4Rtb76EVCo75a5yMtRY5Sl8WwerDDoyaMJbr1
         ALN3NzxfhAK/QnAIGA9oWbOruHyih6d0rXo3YV/3kAkH/Wh/0wl0tu5vMVhGfm/qrJAY
         IwGlvYKNdQG1e5UGLqpxMB+Xs9LyCJuI8bEKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lpdPGDzj1R//AHJnm7Yj429iWHt3Dl63nRov0vRsaFtkEb/MB/Ox9r5r9C/h/7B4hs
         URTbDTi4ziGXqp4tXXtGop4YbjpJfVzBgMUXOWLujKNT84XkAH2nIYg1pnF6CnXFUgqE
         NklLGwUb1PQxfhwUQlxgcYwyI3BySBKtBb7iw=
Received: by 10.213.13.3 with SMTP id z3mr1226183ebz.28.1290139358140; Thu, 18
 Nov 2010 20:02:38 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Thu, 18 Nov 2010 20:02:38 -0800 (PST)
In-Reply-To: <1290125163-31065-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161723>

On Fri, Nov 19, 2010 at 8:06 AM, Gabriel Corona
<gabriel.corona@enst-bretagne.fr> wrote:
> =A0http-push.c | =A0 13 +++++++++++++
> =A01 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index c9bcd11..aeb37ab 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1083,6 +1083,18 @@ static void process_ls_ref(struct remote_ls_ct=
x *ls)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0one_remote_ref(ls->dentry_name);
> =A0}
>
> +static void normalize_dirname(char** name) {
> + =A0 =A0 =A0 char* res;
> + =A0 =A0 =A0 int len =3D strlen(*name);
> + =A0 =A0 =A0 if((*name)[len-1]=3D=3D'/') return;
> + =A0 =A0 =A0 res =3D malloc(len+2);
> + =A0 =A0 =A0 strcpy(res, *name);
> + =A0 =A0 =A0 res[len]=3D'/';
> + =A0 =A0 =A0 res[len+1]=3D'\0';
> + =A0 =A0 =A0 free(*name);
> + =A0 =A0 =A0 *name =3D res;
> +}
> +
> =A0static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_clos=
ed)
> =A0{
> =A0 =A0 =A0 =A0struct remote_ls_ctx *ls =3D (struct remote_ls_ctx *)c=
tx->userData;
> @@ -1090,6 +1102,7 @@ static void handle_remote_ls_ctx(struct xml_ctx=
 *ctx, int tag_closed)
> =A0 =A0 =A0 =A0if (tag_closed) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!strcmp(ctx->name, DAV_PROPFIND_RE=
SP) && ls->dentry_name) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ls->dentry_flags &=
 IS_DIR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 normali=
ze_dirname(&ls->dentry_name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ls=
->flags & PROCESS_DIRS) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ls->userFunc(ls);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> --

Hmm, we already have the logic to do this in end_url_with_slash(). It
works on strbufs though. How about this?

-->8--

diff --git a/http-push.c b/http-push.c
index c9bcd11..645c2b5 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1086,10 +1086,15 @@ static void process_ls_ref(struct remote_ls_ctx=
 *ls)
 static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 {
        struct remote_ls_ctx *ls =3D (struct remote_ls_ctx *)ctx->userD=
ata;
+       struct strbuf buf =3D STRBUF_INIT;

        if (tag_closed) {
                if (!strcmp(ctx->name, DAV_PROPFIND_RESP) && ls->dentry=
_name) {
                        if (ls->dentry_flags & IS_DIR) {
+                               end_url_with_slash(&buf, ls->dentry_nam=
e);
+                               free(ls->dentry_name);
+                               ls->dentry_name =3D strbuf_detach(&buf,=
 NULL);
+
                                if (ls->flags & PROCESS_DIRS) {
                                        ls->userFunc(ls);
                                }

--=20
Cheers,
Ray Chuan
