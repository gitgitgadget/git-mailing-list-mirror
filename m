From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/4] cleanup: use internal memory allocation wrapper
 functions everywhere
Date: Thu, 6 Oct 2011 18:50:59 +0200
Message-ID: <CABPQNSak_jDbNQhzMoSN=NdWmyby3xJRwED54Ck5H1Y12HoGCQ@mail.gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
 <1316051979-19671-1-git-send-email-drafnel@gmail.com> <1316051979-19671-3-git-send-email-drafnel@gmail.com>
 <4E71A0C7.8080602@viscovery.net> <CA+sFfMdVntk+U13UeMO=k1SCKJGhPfTpC9_i9kFOkbUJXrF-qg@mail.gmail.com>
 <CA+sFfMf73K3yv_5K633DKOsVufMV6rTjd+SSunq4sBikt4jCsg@mail.gmail.com>
 <CA+sFfMdHpvdMU==a2sUR9sZZCcgqPfGF7+dy6yi8RVoMZ+uZVA@mail.gmail.com>
 <4E8D4812.9090102@viscovery.net> <CA+sFfMf8_7ccC9kjEq=2NrehVgS=ahnQA8VibEF10VaULot7=A@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 06 18:51:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrAg-00008o-Uq
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119Ab1JFQvm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 12:51:42 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48649 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935224Ab1JFQvl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 12:51:41 -0400
Received: by qadb15 with SMTP id b15so2139638qad.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=q2/Oq39ZFFA0hCVyZQVo0C/KuXiAwQWQYuA1J/gr2s8=;
        b=M8Rj8gDfy1uFDOaC254r+PnfHoJCcL4jBQz/f5xojwIL5ZJuCuV+aT9om3vlhx57Ff
         0zRCRDJBaD5V3NHVWg3x5C2sROeyADKfwhIAzv+Jh9Ytk15ptFw6jhHGh++/mZbe9z2a
         brovchAyHOtLhHNel/WfZcsrjm++xxL1/b3Xo=
Received: by 10.68.33.163 with SMTP id s3mr7079600pbi.10.1317919900374; Thu,
 06 Oct 2011 09:51:40 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Thu, 6 Oct 2011 09:50:59 -0700 (PDT)
In-Reply-To: <CA+sFfMf8_7ccC9kjEq=2NrehVgS=ahnQA8VibEF10VaULot7=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182976>

On Thu, Oct 6, 2011 at 6:14 PM, Brandon Casey <drafnel@gmail.com> wrote=
:
> [removed Alexey Shumkin from cc]
>
> On Thu, Oct 6, 2011 at 1:17 AM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
>> Am 10/6/2011 4:00, schrieb Brandon Casey:
>>> [resend without html bits added by "gmail offline"]
>>> On Wed, Oct 5, 2011 at 7:53 PM, Brandon Casey <drafnel@gmail.com> w=
rote:
>>>> On Thursday, September 15, 2011, Brandon Casey wrote:
>>>>>
>>>>> On Thu, Sep 15, 2011 at 1:52 AM, Johannes Sixt <j.sixt@viscovery.=
net>
>>>>>> There is a danger that the high-level die() routine (which is us=
ed by
>>>>>> the
>>>>>> x-wrappers) uses one of the low-level compat/ routines. IOW, in =
the case
>>>>>> of errors, recursion might occur. Therefore, I would prefer that=
 the
>>>>>> compat/ routines do their own error reporting (preferably via re=
turn
>>>>>> values and errno).
>>>>>
>>>>> Thanks. =A0Will do.
>>>>
>>>> Hi Johannes,
>>>> I have taken a closer look at the possibility of recursion with re=
spect to
>>>> die() and the functions in compat/. =A0It appears the risk is only=
 related to
>>>> vsnprintf/snprintf at the moment. =A0So as long as we avoid callin=
g xmalloc et
>>>> al from within snprintf.c, I think we should be safe from recursio=
n.
>>>> I'm inclined to keep the additions to mingw.c and win32/syslog.c s=
ince they
>>>> both already use the x-wrappers or strbuf, even though they could =
easily be
>>>> worked around. =A0The other file that was touched is compat/qsort,=
 which
>>>> returns void and doesn't have a good alternative error handling pa=
th. =A0So,
>>>> I'm inclined to keep that one too.
>>
>> I'm fine with keeping the change to mingw.c (getaddrinfo related) an=
d
>> qsort: both are unlikely to be called from die().
>>
>> But syslog() *is* called from die() in git-daemon, and it would be b=
etter
>> to back out the other offenders instead of adding to them.
>
> Ah. =A0Yes, you're right. =A0x-wrappers should not be used in syslog.=
c and
> the use of strbuf's should be replaced.

Good point. The patch for this looks something like this:

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 42b95a9..243538c 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -1,5 +1,4 @@
 #include "../../git-compat-util.h"
-#include "../../strbuf.h"

 static HANDLE ms_eventlog;

@@ -16,13 +15,8 @@ void openlog(const char *ident, int logopt, int faci=
lity)

 void syslog(int priority, const char *fmt, ...)
 {
-	struct strbuf sb =3D STRBUF_INIT;
-	struct strbuf_expand_dict_entry dict[] =3D {
-		{"1", "% 1"},
-		{NULL, NULL}
-	};
 	WORD logtype;
-	char *str;
+	char *str, *pos;
 	int str_len;
 	va_list ap;

@@ -39,11 +33,20 @@ void syslog(int priority, const char *fmt, ...)
 	}

 	str =3D malloc(str_len + 1);
+	if (!str)
+		return; /* no chance to report error */
+
 	va_start(ap, fmt);
 	vsnprintf(str, str_len + 1, fmt, ap);
 	va_end(ap);
-	strbuf_expand(&sb, str, strbuf_expand_dict_cb, &dict);
-	free(str);
+
+	while ((pos =3D strstr(str, "%1")) !=3D NULL) {
+		str =3D realloc(str, ++str_len + 1);
+		if (!str)
+			return;
+		memmove(pos + 2, pos + 1, strlen(pos));
+		pos[1] =3D ' ';
+	}

 	switch (priority) {
 	case LOG_EMERG:
@@ -66,7 +69,5 @@ void syslog(int priority, const char *fmt, ...)
 	}

 	ReportEventA(ms_eventlog, logtype, 0, 0, NULL, 1, 0,
-	    (const char **)&sb.buf, NULL);
-
-	strbuf_release(&sb);
+	    (const char **)&str, NULL);
 }
