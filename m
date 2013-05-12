From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 3/3] cache.h: eliminate SHA-1 deprecation warnings on
 OS X 10.8
Date: Sun, 12 May 2013 13:57:45 -0700
Message-ID: <CAJDDKr5QbrY6dFLbdZc2P5fTdLx+MPrSE+r1AAJMU4g=nrV9BA@mail.gmail.com>
References: <1368260548-52612-1-git-send-email-davvid@gmail.com>
	<1368260548-52612-2-git-send-email-davvid@gmail.com>
	<1368260548-52612-3-git-send-email-davvid@gmail.com>
	<CAPig+cSw5-S7MDhG+5WdnLd+7PDUrSJcZJ-caXGM8JmYU6YWHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 12 22:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbdL6-0004zi-DO
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 22:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab3ELU5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 May 2013 16:57:47 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:42532 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab3ELU5q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 May 2013 16:57:46 -0400
Received: by mail-wg0-f49.google.com with SMTP id j13so5890416wgh.16
        for <git@vger.kernel.org>; Sun, 12 May 2013 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=OoaSjLbZg/Dt9FFNc/2iagoRWdEB2yXYrA6XmDzBEVA=;
        b=B5pEYcpo5aQGjV/gnyIDnyVv9LDHU3fpfdNUvT5P7Qtpo8snNZZQ1FE6UO21JYqcOf
         OgCl7pZVMZGU+vJDDR7TK+tppInnVpG4CFI3K3dLlBFL0dZrYfatEs9DgNoOMsFC7KHR
         3Iamgm3olxXjEZQSuNTKxDkDYTEwPl3XWCsJTGp1b/OYMx84j3uMZbVpdLkN4652aOTt
         PeynUnbrD/PeVU/EiOSk4/3/7wqSd7mmKFZMZUIEs6GYKZ/me5xmPHroJGhTKGWADlhG
         gGM5ECHbzgMQZN2/eyuiiQf8x7HEi6jSNgQ9ZtG5HUzYZRzpYJw+y2VtfItfyRrzEHf0
         KEIA==
X-Received: by 10.194.10.129 with SMTP id i1mr27077347wjb.21.1368392265343;
 Sun, 12 May 2013 13:57:45 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Sun, 12 May 2013 13:57:45 -0700 (PDT)
In-Reply-To: <CAPig+cSw5-S7MDhG+5WdnLd+7PDUrSJcZJ-caXGM8JmYU6YWHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224061>

On Sun, May 12, 2013 at 11:37 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> On Sat, May 11, 2013 at 4:22 AM, David Aguilar <davvid@gmail.com> wro=
te:
>> Mac OS X Mountain Lion prints warnings when building git:
>>
>>         warning: 'SHA1_Init' is deprecated
>>         (declared at /usr/include/openssl/sha.h:121)
>>
>> Silence the warnings by using the Common Digest SHA-1
>> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
>>
>> Add a COMMON_DIGEST_SHA1 knob to the Makefile to allow
>> choosing this implementation and define it by default on Darwin.
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> Unchanged since last time; rebased to 3/3.
>
> Ignore my earlier response. I had not seen your revised patches. With
> this patch series, the SHA1_Foo() warnings are indeed resolved,
> however, there are still a bunch of remaining deprecation warnings
> regarding ERR_error_string, SSL_get_error, X509_get_ext_d2i, and so
> forth.

Yup, warnings still remain, but only in imap-send.c.  All the SHA1
ones are gone.  Those were particularly bothersome since they affected
several files.

I haven't dug to deeply into how to fix these.  In case anyone has any
pointers, the warnings look like this:

imap-send.c: In function =E2=80=98ssl_socket_perror=E2=80=99:
imap-send.c:185: warning: =E2=80=98ERR_error_string=E2=80=99 is depreca=
ted (declared
at /usr/include/openssl/err.h:279)
imap-send.c:185: warning: =E2=80=98ERR_get_error=E2=80=99 is deprecated=
 (declared at
/usr/include/openssl/err.h:266)
imap-send.c: In function =E2=80=98socket_perror=E2=80=99:
imap-send.c:193: warning: =E2=80=98SSL_get_error=E2=80=99 is deprecated=
 (declared at
/usr/include/openssl/ssl.h:1501)
imap-send.c: In function =E2=80=98verify_hostname=E2=80=99:
imap-send.c:245: warning: =E2=80=98X509_get_ext_d2i=E2=80=99 is depreca=
ted (declared
at /usr/include/openssl/x509.h:1151)
imap-send.c:246: warning: =E2=80=98sk_num=E2=80=99 is deprecated (decla=
red at
/usr/include/openssl/stack.h:81)
imap-send.c:248: warning: =E2=80=98sk_value=E2=80=99 is deprecated (dec=
lared at
/usr/include/openssl/stack.h:82)
imap-send.c:254: warning: =E2=80=98sk_pop_free=E2=80=99 is deprecated (=
declared at
/usr/include/openssl/stack.h:89)
imap-send.c:260: warning: =E2=80=98X509_get_subject_name=E2=80=99 is de=
precated
(declared at /usr/include/openssl/x509.h:1013)
imap-send.c:262: warning: =E2=80=98X509_NAME_get_text_by_NID=E2=80=99 i=
s deprecated
(declared at /usr/include/openssl/x509.h:1099)
imap-send.c: In function =E2=80=98ssl_socket_connect=E2=80=99:
imap-send.c:281: warning: =E2=80=98SSL_library_init=E2=80=99 is depreca=
ted (declared
at /usr/include/openssl/ssl.h:1553)
imap-send.c:282: warning: =E2=80=98SSL_load_error_strings=E2=80=99 is d=
eprecated
(declared at /usr/include/openssl/ssl.h:1416)
imap-send.c:285: warning: =E2=80=98TLSv1_method=E2=80=99 is deprecated =
(declared at
/usr/include/openssl/ssl.h:1519)
imap-send.c:287: warning: =E2=80=98SSLv23_method=E2=80=99 is deprecated=
 (declared at
/usr/include/openssl/ssl.h:1515)
imap-send.c:294: warning: =E2=80=98SSL_CTX_new=E2=80=99 is deprecated (=
declared at
/usr/include/openssl/ssl.h:1346)
imap-send.c:297: warning: =E2=80=98SSL_CTX_set_verify=E2=80=99 is depre=
cated (declared
at /usr/include/openssl/ssl.h:1459)
imap-send.c:299: warning: =E2=80=98SSL_CTX_set_default_verify_paths=E2=80=
=99 is
deprecated (declared at /usr/include/openssl/ssl.h:1570)
imap-send.c:303: warning: =E2=80=98SSL_new=E2=80=99 is deprecated (decl=
ared at
/usr/include/openssl/ssl.h:1481)
imap-send.c:308: warning: =E2=80=98SSL_set_rfd=E2=80=99 is deprecated (=
declared at
/usr/include/openssl/ssl.h:1371)
imap-send.c:312: warning: =E2=80=98SSL_set_wfd=E2=80=99 is deprecated (=
declared at
/usr/include/openssl/ssl.h:1372)
imap-send.c:323: warning: =E2=80=98SSL_ctrl=E2=80=99 is deprecated (dec=
lared at
/usr/include/openssl/ssl.h:1496)
imap-send.c:328: warning: =E2=80=98SSL_connect=E2=80=99 is deprecated (=
declared at
/usr/include/openssl/ssl.h:1492)
imap-send.c:336: warning: =E2=80=98SSL_get_peer_certificate=E2=80=99 is=
 deprecated
(declared at /usr/include/openssl/ssl.h:1450)
imap-send.c: In function =E2=80=98socket_read=E2=80=99:
imap-send.c:352: warning: =E2=80=98SSL_read=E2=80=99 is deprecated (dec=
lared at
/usr/include/openssl/ssl.h:1493)
imap-send.c: In function =E2=80=98socket_write=E2=80=99:
imap-send.c:370: warning: =E2=80=98SSL_write=E2=80=99 is deprecated (de=
clared at
/usr/include/openssl/ssl.h:1495)
imap-send.c: In function =E2=80=98socket_shutdown=E2=80=99:
imap-send.c:387: warning: =E2=80=98SSL_shutdown=E2=80=99 is deprecated =
(declared at
/usr/include/openssl/ssl.h:1532)
imap-send.c:388: warning: =E2=80=98SSL_free=E2=80=99 is deprecated (dec=
lared at
/usr/include/openssl/ssl.h:1490)
imap-send.c: In function =E2=80=98cram=E2=80=99:
imap-send.c:906: warning: =E2=80=98EVP_DecodeBlock=E2=80=99 is deprecat=
ed (declared at
/usr/include/openssl/evp.h:634)
imap-send.c:913: warning: statement with no effect
imap-send.c:927: warning: =E2=80=98EVP_EncodeBlock=E2=80=99 is deprecat=
ed (declared at
/usr/include/openssl/evp.h:627)

Cheers,
--
David
