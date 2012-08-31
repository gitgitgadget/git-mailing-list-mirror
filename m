From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] wincred: port to generic credential helper (UNTESTED)
Date: Fri, 31 Aug 2012 17:44:47 +0200
Message-ID: <CABPQNSZg=--RifuBCAbxuiQ0Pdx7B0ew=FVDPutccZkvsjTQGg@mail.gmail.com>
References: <503A680C.3090406@qo.cx> <1346018649-3002-1-git-send-email-pah@qo.cx>
 <CABPQNSZsXnf2kjcN+Qma8pApjGRF6SD5iJjB2Ow6GuGts0Z=Kg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: "Philipp A. Hartmann" <pah@qo.cx>
X-From: git-owner@vger.kernel.org Fri Aug 31 17:45:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7TPa-0004l4-TE
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 17:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab2HaPp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 11:45:28 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64072 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab2HaPp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 11:45:27 -0400
Received: by pbbrr13 with SMTP id rr13so5042803pbb.19
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=m55PKo05TQqTyiuYuj3psNIvq9B8JL0u9YWaFpInoFQ=;
        b=RrVYxZ4zSecySblEo20b9EovVGghAjwID6Xu6i7mFggy2RjG9YoyKMT+HN1Fb/Ev5h
         m9XxnqbUfeMBJfwipVYH5EJUzkPJqpIstSPjlI6+Cv6Fqx45d1WEtMzzrej57lpO08ZE
         UcIYDTzqnHNEvrHkGJreU6ico4n7iJJQw/+Kno30WzOlKEWRvsjyFvNB0hXmneVAm4Ly
         YDRmSUmFRqd3zC22wCP5ela/1ryrxoXNBNDAk9ISmmDJP9EJ1/5IJx6w4C5TvImJ+uLR
         C9SQZQxq48GUrxaqasrbnn2WPBwc30tH7R0mUCZhdQh619qnItAnyTfH/ZP81SOxQmdz
         9Q5A==
Received: by 10.66.75.104 with SMTP id b8mr15923496paw.21.1346427927315; Fri,
 31 Aug 2012 08:45:27 -0700 (PDT)
Received: by 10.66.15.234 with HTTP; Fri, 31 Aug 2012 08:44:47 -0700 (PDT)
In-Reply-To: <CABPQNSZsXnf2kjcN+Qma8pApjGRF6SD5iJjB2Ow6GuGts0Z=Kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204590>

On Thu, Aug 30, 2012 at 8:27 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Mon, Aug 27, 2012 at 12:04 AM, Philipp A. Hartmann <pah@qo.cx> wrote:
>> From: "Philipp A. Hartmann" <pah@qo.cx>
>>
>> This patch is an experiment to port the wincred helper
>> to the generic implementation.  As of know, it is
>> completely untested.
>>
>> In addition to porting the helper to the generic API,
>> this patch clears up all passwords from memory, which
>> reduces the total amount to saved lines.
>>
>> Signed-off-by: Philipp A. Hartmann <pah@qo.cx>
>> ---
>>
>> The porting was fairly easy, but due to the lack of a testing
>> platform, it is completely untested.
>>
>> Erik: Can you try to have look?
>
> Sorry for the late reply, I'm currently in bed with pneumonia.
>
> But I gave it a quick go, but as-is it's a NACK; a wall of warnings and errors.
>
> But with this patch on top, it seems to at least compile OK:
>
> ---8<---
> diff --git a/contrib/credential/helper/credential_helper.h
> b/contrib/credential/helper/credential_helper.h
> index 7e73fc6..13b611e 100644
> --- a/contrib/credential/helper/credential_helper.h
> +++ b/contrib/credential/helper/credential_helper.h
> @@ -125,6 +125,7 @@ static inline char *xstrdup(const char *str)
>         return ret;
>  }
>
> +#ifndef NO_STRNDUP
>  static inline char *xstrndup(const char *str, size_t len)
>  {
>         char *ret = strndup(str,len);
> @@ -133,5 +134,6 @@ static inline char *xstrndup(const char *str, size_t len)
>
>         return ret;
>  }
> +#endif
>
>  #endif /* CREDENTIAL_HELPER_H_INCLUDED_ */
> diff --git a/contrib/credential/wincred/Makefile
> b/contrib/credential/wincred/Makefile
> index ee7a8ef..3900322 100644
> --- a/contrib/credential/wincred/Makefile
> +++ b/contrib/credential/wincred/Makefile
> @@ -1,9 +1,10 @@
>  MAIN:=git-credential-wincred
> -all:: $(MAIN)
> +all:: $(MAIN).exe
>
>  CC = gcc
>  RM = rm -f
>  CFLAGS = -O2 -Wall
> +CPPFLAGS = -DNO_STRNDUP
>
>  -include ../../../config.mak.autogen
>  -include ../../../config.mak
> diff --git a/contrib/credential/wincred/git-credential-wincred.c
> b/contrib/credential/wincred/git-credential-wincred.c
> index 721e59f..e26ba47 100644
> --- a/contrib/credential/wincred/git-credential-wincred.c
> +++ b/contrib/credential/wincred/git-credential-wincred.c
> @@ -6,6 +6,7 @@
>  #include <stdio.h>
>  #include <io.h>
>  #include <fcntl.h>
> +#include <credential_helper.h>
>
>  /* MinGW doesn't have wincred.h, so we need to define stuff */
>
> @@ -124,9 +125,8 @@ static int prepare_credential(struct credential *c)
>                 wusername = utf8_to_utf16_dup(c->username);
>         if (c->password)
>                 wpassword = utf8_to_utf16_dup(c->password);
> -       if (c->port) {
> -               snprintf(port_buf,"%hd",c->port);
> -       }
> +       if (c->port)
> +               snprintf(port_buf, sizeof(port_buf), "%hd", c->port);
>         return EXIT_SUCCESS;
>  }
>
> @@ -170,7 +170,7 @@ static int get_credential(struct credential *c)
>
>         /* search for the first credential that matches username */
>         for (i = 0; i < num_creds; ++i)
> -               if (match_cred(creds[i])) {
> +               if (match_cred(creds[i], c)) {
>                         cred = creds[i];
>                         break;
>                 }
> ---8<---
>
> However, I haven't been able to successfully run the tests on the
> result. When I did, I got this error:
>
> ---8<---
> rm: cannot remove `t/trash directory.t0303-credential-external/stderr': Permissi
> on denied
> rm: cannot remove `t/trash directory.t0303-credential-external/stdout': Permissi
> on denied
> rm: cannot remove directory `t/trash directory.t0303-credential-external': Direc
> tory not empty
> ---8<---
>
> And I'm not currently feeling up to debugging stuck processes or whatever it is.

OK, that was due to a stuck process, and after killing it I got to
test properly. However, three tests fail now:


$ (cd t && GIT_TEST_CREDENTIAL_HELPER=wincred ./t0303-credential-external.sh)
ok 1 - helper (wincred) has no existing data
ok 2 - helper (wincred) stores password
not ok - 3 helper (wincred) can retrieve password
#
#                       check fill $HELPER <<-\EOF
#                       protocol=https
#                       host=example.com
#                       --
#                       protocol=https
#                       host=example.com
#                       username=store-user
#                       password=store-pass
#                       --
#                       EOF
#
ok 4 - helper (wincred) requires matching protocol
ok 5 - helper (wincred) requires matching host
ok 6 - helper (wincred) requires matching username
ok 7 - helper (wincred) requires matching path
ok 8 - helper (wincred) can forget host
not ok - 9 helper (wincred) can store multiple users
#
#                       check approve $HELPER <<-\EOF &&
#                       protocol=https
#                       host=example.com
#                       username=user1
#                       password=pass1
#                       EOF
#                       check approve $HELPER <<-\EOF &&
#                       protocol=https
#                       host=example.com
#                       username=user2
#                       password=pass2
#                       EOF
#                       check fill $HELPER <<-\EOF &&
#                       protocol=https
#                       host=example.com
#                       username=user1
#                       --
#                       protocol=https
#                       host=example.com
#                       username=user1
#                       password=pass1
#                       EOF
#                       check fill $HELPER <<-\EOF
#                       protocol=https
#                       host=example.com
#                       username=user2
#                       --
#                       protocol=https
#                       host=example.com
#                       username=user2
#                       password=pass2
#                       EOF
#
ok 10 - helper (wincred) can forget user
not ok - 11 helper (wincred) remembers other user
#
#                       check fill $HELPER <<-\EOF
#                       protocol=https
#                       host=example.com
#                       username=user2
#                       --
#                       protocol=https
#                       host=example.com
#                       username=user2
#                       password=pass2
#                       EOF
#
# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIMEOUT not set)
# failed 3 among 11 test(s)
1..11

So, something else is up as well.
