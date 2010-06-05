From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with 
	gettext
Date: Sat, 5 Jun 2010 14:10:21 +0000
Message-ID: <AANLkTim3PcoLrYb46Bh3tK7Ir3v-K0EQ0czPaD5DIIOK@mail.gmail.com>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
	<1275704035-6552-2-git-send-email-avarab@gmail.com>
	<20100605030059.GB2019@progeny.tock>
	<AANLkTilSJ_1STKGvat0llqYVZRI8_tQriE-hIBJPEldn@mail.gmail.com>
	<20100605033849.GB2252@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 16:10:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKu59-0000n1-1Q
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 16:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933399Ab0FEOKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 10:10:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56202 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933319Ab0FEOKW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 10:10:22 -0400
Received: by iwn37 with SMTP id 37so1980436iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y6tU/VMcuK7xM6XMpDycy2Eu+XIrpkbMrTCDHXIIGB4=;
        b=GcTfi4HEHmLi/H75l7/oWhZcUJp9qrwdzPkaO0AMo/HFIi8mHi85Y5Ib+AEgHy9HR8
         yW60nzzFJ/gQJaasuQqskw6OKbFsKauUVgohzPp2V5z+N1UE21zE+6GuOOcxKwafgdv8
         qRY+E/Ltm4CbwIRMTBb6SOlm/UFPMeeyvBkYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=thH/eHTo9drrjkcLXjedjjq8oaz5GvjWIkSHSHKQ9TU2bM/iwcmSZiB/Q4Z74sa/le
         o/+ecwhx7vnxeNaBtI1LMFt4scVCeD0MOG1aBSphn8iNcB+THbLH4aUgHvo3yGIFeNSt
         zyhGFm0GuX3yn4rgsv07WEGbE93Ipdbw6yKTA=
Received: by 10.231.178.132 with SMTP id bm4mr14804941ibb.62.1275747021930; 
	Sat, 05 Jun 2010 07:10:21 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 5 Jun 2010 07:10:21 -0700 (PDT)
In-Reply-To: <20100605033849.GB2252@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148473>

On Sat, Jun 5, 2010 at 03:38, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sat, Jun 5, 2010 at 03:01, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
>>> =C2=A0#ifdef NO_GETTEXT
>>> =C2=A0static inline void git_setup_gettext(void) {}
>>> =C2=A0#endif
>>>
>>> and
>>>
>>> =C2=A0ifndef NO_GETTEXT
>>> =C2=A0LIB_OBJS +=3D gettext.o
>>> =C2=A0endif
>>
>> Sure, but that would be putting code in a header file, which is
>> usually taboo. It looks like there's some prior art on that though.
>> Like strbuf.h.
>>
>> I don't care either way, what do you think?
>
> This is what =E2=80=98inline=E2=80=99 is for. =C2=A0I think using it =
for stubs like this
> is perfectly acceptable and improves readability.

Great. I've fixed this in my local copy. Now I don't compile gettext.c
when NO_GETTEXT is set, and it'll be defined as static inline in the
header file.

It'll become part of the next patch. Here's the diff:

diff --git a/Makefile b/Makefile
index 3040000..e21f7f0 100644
--- a/Makefile
+++ b/Makefile
@@ -578,7 +578,9 @@ LIB_OBJS +=3D entry.o
 LIB_OBJS +=3D environment.o
 LIB_OBJS +=3D exec_cmd.o
 LIB_OBJS +=3D fsck.o
+ifndef NO_GETTEXT
 LIB_OBJS +=3D gettext.o
+endif
 LIB_OBJS +=3D graph.o
 LIB_OBJS +=3D grep.o
 LIB_OBJS +=3D hash.o
diff --git a/gettext.c b/gettext.c
index 22cdcc1..4825799 100644
--- a/gettext.c
+++ b/gettext.c
@@ -1,11 +1,8 @@
-#ifdef NO_GETTEXT
-void git_setup_gettext(void) {}
-#else
 #include "exec_cmd.h"
 #include <libintl.h>
 #include <stdlib.h>

-void git_setup_gettext(void) {
+inline void git_setup_gettext(void) {
 	char *podir;
 	char *envdir =3D getenv("GIT_TEXTDOMAINDIR");

@@ -22,4 +19,3 @@ void git_setup_gettext(void) {
 	(void)setlocale(LC_CTYPE, "");
 	(void)textdomain("git");
 }
-#endif
diff --git a/gettext.h b/gettext.h
index a99da6a..8d44808 100644
--- a/gettext.h
+++ b/gettext.h
@@ -1,7 +1,11 @@
 #ifndef GETTEXT_H
 #define GETTEXT_H

-void git_setup_gettext(void);
+#ifdef NO_GETTEXT
+static inline void git_setup_gettext(void) {}
+#else
+inline void git_setup_gettext(void);
+#endif

 #ifdef NO_GETTEXT
 #define _(s) (s)
