From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 01/10] test-chmtime: Fix exit code on Windows
Date: Wed, 20 Nov 2013 15:00:06 +0100
Message-ID: <CABPQNSYP-LzX9Truv4UmQrmYpo5fWbk1aYKpKKVaGL8POanWiQ@mail.gmail.com>
References: <cover.1370636706.git.j6t@kdbg.org> <cover.1370076477.git.j6t@kdbg.org>
 <ba3c59d26cfb23a8c71c66ef1d49c4dca55fc556.1370636706.git.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Nov 20 15:00:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj8Kq-0002rn-7O
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 15:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab3KTOAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 09:00:47 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36827 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab3KTOAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 09:00:47 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so4361856ieb.31
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 06:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=VenYRdr0TSoWv93w7FgaiQHTTBycCJizC2Asnvnk+oo=;
        b=xBnLrC6j+/zgjMMguznTkfszByiQfVEXvCUwIh5EyyiEBDQePC79QdSV8XLXgHZgVn
         /WmT0BKm2TL/H2LTZEuscWauxSj8nPgoevHQ4U+0V5uOHO/TR5uQzawtoxTe+VSyQnWW
         IL5qsrWJXWrUFEgw72oHKAWUvCu19j5fnqFMnMhxbJRq1D++ZWZ9v46jDW6mk1iiiRyB
         l6OFx2XWPF8KfksixvtuQ2tIuErt7CLh8hUHCLmXyXMrpL5QJAIAHznTRYy36NQgOmMr
         X8E9+Pgkq9qDt6QILjih2534/GWFv0Mlj3XU0Ecxm2heIXARTroYTAvstBhzjTyjC9Zq
         wefQ==
X-Received: by 10.43.55.68 with SMTP id vx4mr471502icb.65.1384956046503; Wed,
 20 Nov 2013 06:00:46 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Wed, 20 Nov 2013 06:00:06 -0800 (PST)
In-Reply-To: <ba3c59d26cfb23a8c71c66ef1d49c4dca55fc556.1370636706.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238080>

On Fri, Jun 7, 2013 at 10:53 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> MinGW's bash does not recognize an exit code -1 as failure. See also
> 47e3de0e (MinGW: truncate exit()'s argument to lowest 8 bits) and 2488df84
> (builtin run_command: do not exit with -1). Exit code 1 is good enough.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  test-chmtime.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/test-chmtime.c b/test-chmtime.c
> index 02b42ba..2e601a8 100644
> --- a/test-chmtime.c
> +++ b/test-chmtime.c
> @@ -84,7 +84,7 @@ int main(int argc, const char *argv[])
>                 if (stat(argv[i], &sb) < 0) {
>                         fprintf(stderr, "Failed to stat %s: %s\n",
>                                 argv[i], strerror(errno));
> -                       return -1;
> +                       return 1;
>                 }
>
>  #ifdef WIN32
> @@ -92,7 +92,7 @@ int main(int argc, const char *argv[])
>                                 chmod(argv[i], sb.st_mode | S_IWUSR)) {
>                         fprintf(stderr, "Could not make user-writable %s: %s",
>                                 argv[i], strerror(errno));
> -                       return -1;
> +                       return 1;
>                 }
>  #endif
>
> @@ -107,7 +107,7 @@ int main(int argc, const char *argv[])
>                 if (utb.modtime != sb.st_mtime && utime(argv[i], &utb) < 0) {
>                         fprintf(stderr, "Failed to modify time on %s: %s\n",
>                                 argv[i], strerror(errno));
> -                       return -1;
> +                       return 1;
>                 }
>         }
>
> @@ -115,5 +115,5 @@ int main(int argc, const char *argv[])
>
>  usage:
>         fprintf(stderr, "usage: %s %s\n", argv[0], usage_str);
> -       return -1;
> +       return 1;
>  }
> --
> 1.8.3.rc1.32.g8b61cbb
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hmmm. Perhaps we should do something like this?

diff --git a/compat/mingw.h b/compat/mingw.h
index 1f9ab5f..cbee8bd 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -462,7 +462,7 @@ static int mingw_main(c,v); \
 int main(c,v) \
 { \
  mingw_startup(); \
- return mingw_main(__argc, __argv); \
+ return mingw_main(__argc, __argv) & 0xff; \
 } \
 static int mingw_main(c,v)
