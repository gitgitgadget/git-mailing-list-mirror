From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Makefile: Change library order for static linking
Date: Thu, 17 Sep 2015 15:25:00 -0400
Message-ID: <CAPig+cRCF1prBKRCUdEZwiA5=VshMcYPi9Fo5bHxD2Fp8wgrfg@mail.gmail.com>
References: <1442524332-10180-1-git-send-email-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Thu Sep 17 21:25:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcent-00032X-Pu
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 21:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbbIQTZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 15:25:02 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33385 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbIQTZB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 15:25:01 -0400
Received: by vkgd64 with SMTP id d64so17273739vkg.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 12:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bUv0x9FD6VGvskP6wCwXsNrdchinFKEU7TTBbeIyaXQ=;
        b=ufuKrQG4OvxPhE3GL7ridmwtQcwEfhps6ja+mRYLd/RDEIUJWdz6wnvXJiIjSAhzp0
         GkTakKvXENvusxqAGfYX6H6MegG6+dH6rCfT8/Ph7ssG7v2NPxjc16gDhZBUihQCs2fl
         gi823HsQi15fKslaRGf1xA21U4USd3Ncm4wu8UTbMSSkVzKKyjoDxfcTK+wIMqH3pkqh
         hT8Tt1CImKI/wm1ffooewQb2r64ii40CgGdPO3wlZVSA3hx54YRrVqZ0X1qhzbZfV0IL
         xIqS42OJXJwE24yDu7qGvSRgrF+7dWbaeUc9X8XGy6fn9F6ZN51EToG6WKMo5ttqAHjM
         9Q5Q==
X-Received: by 10.31.131.141 with SMTP id f135mr907438vkd.37.1442517900567;
 Thu, 17 Sep 2015 12:25:00 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Thu, 17 Sep 2015 12:25:00 -0700 (PDT)
In-Reply-To: <1442524332-10180-1-git-send-email-repk@triplefau.lt>
X-Google-Sender-Auth: A1beteou1SUNLCowlN98s0vaeW0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278161>

On Thu, Sep 17, 2015 at 5:12 PM, Remi Pommarel <repk@triplefau.lt> wrote:
> For static linking especially library order while linking is important. For
> example libssl contains symbol from libcrypto so the farmer should be linked

I hope you meant: s/farmer/former/

> before the latter. The global link order should be libcurl then libssl then
> libcrypto then libintl and finally zlib.
>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 81ac5bb..26a483a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1030,7 +1030,6 @@ ifdef HAVE_ALLOCA_H
>  endif
>
>  IMAP_SEND_BUILDDEPS =
> -IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
>
>  ifdef NO_CURL
>         BASIC_CFLAGS += -DNO_CURL
> @@ -1087,6 +1086,7 @@ else
>                 endif
>         endif
>  endif
> +IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
>
>  ifdef ZLIB_PATH
>         BASIC_CFLAGS += -I$(ZLIB_PATH)/include
> @@ -1117,7 +1117,7 @@ ifdef NO_OPENSSL
>         LIB_4_CRYPTO =
>  else
>  ifdef NEEDS_SSL_WITH_CRYPTO
> -       LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto -lssl
> +       LIB_4_CRYPTO = $(OPENSSL_LINK) -lssl -lcrypto
>  else
>         LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
>  endif
> @@ -1972,10 +1972,10 @@ git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
>
>  git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -               $(LIBS) $(CURL_LIBCURL)
> +               $(CURL_LIBCURL) $(LIBS)
>  git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -               $(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> +               $(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
>
>  git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
> @@ -1989,7 +1989,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
>
>  $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
>         $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -               $(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> +               $(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
>
>  $(LIB_FILE): $(LIB_OBJS)
>         $(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
> --
> 2.0.1
