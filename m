From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/4] cleanup: use internal memory allocation wrapper
 functions everywhere
Date: Thu, 6 Oct 2011 18:52:43 +0200
Message-ID: <CABPQNSaQFFj0vP1+wuoL2=GyHZPRgCXLxXqD+5WX3Le_PyuH4w@mail.gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
 <1316051979-19671-1-git-send-email-drafnel@gmail.com> <1316051979-19671-3-git-send-email-drafnel@gmail.com>
 <4E71A0C7.8080602@viscovery.net> <CA+sFfMdVntk+U13UeMO=k1SCKJGhPfTpC9_i9kFOkbUJXrF-qg@mail.gmail.com>
 <CA+sFfMf73K3yv_5K633DKOsVufMV6rTjd+SSunq4sBikt4jCsg@mail.gmail.com>
 <CA+sFfMdHpvdMU==a2sUR9sZZCcgqPfGF7+dy6yi8RVoMZ+uZVA@mail.gmail.com>
 <4E8D4812.9090102@viscovery.net> <CA+sFfMf8_7ccC9kjEq=2NrehVgS=ahnQA8VibEF10VaULot7=A@mail.gmail.com>
 <CABPQNSak_jDbNQhzMoSN=NdWmyby3xJRwED54Ck5H1Y12HoGCQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"peff@peff.net" <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>,
	"bharrosh@panasas.com" <bharrosh@panasas.com>,
	"trast@student.ethz.ch" <trast@student.ethz.ch>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:53:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrCL-0000fw-0x
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104Ab1JFQxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 12:53:24 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:45208 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965093Ab1JFQxX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 12:53:23 -0400
Received: by pzk1 with SMTP id 1so7367917pzk.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 09:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=+vSPTeAGF4k6vABZvZCPJrSVaxe7bwIBzWFXgJa4s5E=;
        b=GWckyRn/HvAG5DbzIH9z410gsDASOu3bwCCV9yPlZ6U9AoJZGs6/cwDNYxPNgX+LYw
         p3AhqVxyObpJNOboRMrwAPKrtwGROVBM7WshqS7o25M9l4rROZwfwofs+XUz7EALViow
         cwcm88nhkcTjP/vyFKiRO0N7ec/fXh38bjoAM=
Received: by 10.68.36.99 with SMTP id p3mr6777317pbj.61.1317920003067; Thu, 06
 Oct 2011 09:53:23 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Thu, 6 Oct 2011 09:52:43 -0700 (PDT)
In-Reply-To: <CABPQNSak_jDbNQhzMoSN=NdWmyby3xJRwED54Ck5H1Y12HoGCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182977>

On Thu, Oct 6, 2011 at 6:50 PM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
> On Thu, Oct 6, 2011 at 6:14 PM, Brandon Casey <drafnel@gmail.com> wro=
te:
>> Ah. =A0Yes, you're right. =A0x-wrappers should not be used in syslog=
=2Ec and
>> the use of strbuf's should be replaced.
>
> Good point. The patch for this looks something like this:
>
> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> index 42b95a9..243538c 100644
> --- a/compat/win32/syslog.c
> +++ b/compat/win32/syslog.c
> @@ -1,5 +1,4 @@
> =A0#include "../../git-compat-util.h"
> -#include "../../strbuf.h"
>
> =A0static HANDLE ms_eventlog;
>
> @@ -16,13 +15,8 @@ void openlog(const char *ident, int logopt, int fa=
cility)
>
> =A0void syslog(int priority, const char *fmt, ...)
> =A0{
> - =A0 =A0 =A0 struct strbuf sb =3D STRBUF_INIT;
> - =A0 =A0 =A0 struct strbuf_expand_dict_entry dict[] =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 {"1", "% 1"},
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 {NULL, NULL}
> - =A0 =A0 =A0 };
> =A0 =A0 =A0 =A0WORD logtype;
> - =A0 =A0 =A0 char *str;
> + =A0 =A0 =A0 char *str, *pos;
> =A0 =A0 =A0 =A0int str_len;
> =A0 =A0 =A0 =A0va_list ap;
>
> @@ -39,11 +33,20 @@ void syslog(int priority, const char *fmt, ...)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0str =3D malloc(str_len + 1);
> + =A0 =A0 =A0 if (!str)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return; /* no chance to report error */
> +
> =A0 =A0 =A0 =A0va_start(ap, fmt);
> =A0 =A0 =A0 =A0vsnprintf(str, str_len + 1, fmt, ap);
> =A0 =A0 =A0 =A0va_end(ap);
> - =A0 =A0 =A0 strbuf_expand(&sb, str, strbuf_expand_dict_cb, &dict);
> - =A0 =A0 =A0 free(str);
> +
> + =A0 =A0 =A0 while ((pos =3D strstr(str, "%1")) !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 str =3D realloc(str, ++str_len + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!str)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memmove(pos + 2, pos + 1, strlen(pos));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pos[1] =3D ' ';
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0switch (priority) {
> =A0 =A0 =A0 =A0case LOG_EMERG:
> @@ -66,7 +69,5 @@ void syslog(int priority, const char *fmt, ...)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0ReportEventA(ms_eventlog, logtype, 0, 0, NULL, 1, 0,
> - =A0 =A0 =A0 =A0 =A0 (const char **)&sb.buf, NULL);
> -
> - =A0 =A0 =A0 strbuf_release(&sb);
> + =A0 =A0 =A0 =A0 =A0 (const char **)&str, NULL);
> =A0}
>

=2E..aaand this on top to avoid a leak, of course:

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 243538c..3b8e2b7 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -70,4 +70,5 @@ void syslog(int priority, const char *fmt, ...)

 	ReportEventA(ms_eventlog, logtype, 0, 0, NULL, 1, 0,
 	    (const char **)&str, NULL);
+	free(str);
 }
