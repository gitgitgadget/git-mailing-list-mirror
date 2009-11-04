From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 11:50:26 +0100
Message-ID: <40aa078e0911040250k55fa1920g6eee5657c6e35345@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
	 <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 11:50:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5dRm-00047u-Qd
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 11:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342AbZKDKu1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 05:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbZKDKuZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 05:50:25 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34726 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335AbZKDKuW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 05:50:22 -0500
Received: by bwz27 with SMTP id 27so8690242bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 02:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wGXvayEymDY5ievvoEfz2aGjKhfFR02e+QOnjez4ZcQ=;
        b=AiKuT1XmCP6PM5AltT9F2u1PgK9qFEow9AJyRlAjJD419s3nWIRR8vWVp/Tg7bQGqw
         /L31Ea2XtgjdxieQFkmVXy31N5x/dPa0zsgQNFT0rjX2W2KZtO1sCVhLpQ0VUS1z2mrU
         6gLYzLmSiVBGJbRu0ChDFJGG32XNhhHoUxIPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=W1BPivCeNR5Zw+Z9jcBdlO3vMfoAGxH0ik7ow8rbaeyptP8NaqHN2W/Icopqz7B3AW
         uVMyiLtjksbdrEg8SXNZj9EnRFXOXjo8gNgylfAhbnVqqGnnhvaYlyXE+/6unFy8g8wR
         tv9YAlxa1VKXyDl6cWMot+VmEs5XIEzZZ95U4=
Received: by 10.204.156.3 with SMTP id u3mr1228263bkw.179.1257331826427; Wed, 
	04 Nov 2009 02:50:26 -0800 (PST)
In-Reply-To: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132071>

On Wed, Nov 4, 2009 at 11:37 AM, Andrzej K. Haczewski
<ahaczewski@gmail.com> wrote:
> +/*
> + * Properly defines thread routine for Windows and POSIX
> + */
> +#ifndef NO_PTHREADS
> +# ifndef _WIN32
> +# =A0define THREAD_FUNC(f, a) void *f(void *a)
> +# =A0define THREAD_RETURN(x) return (x)
> +# else
> +# =A0define THREAD_FUNC(f, a) DWORD __stdcall f(LPVOID a)
> +# =A0define THREAD_RETURN(x) return (DWORD)(x);
> +# endif
> +#endif
> +

Seeing how THREAD_RETURN is only called with NULL-parameter, perhaps
it would be better to do this?

+/*
+ * Properly defines thread routine for Windows and POSIX
+ */
+#ifndef NO_PTHREADS
+# ifndef _WIN32
+#  define THREAD_FUNC(f, a) void *f(void *a)
+#  define THREAD_RETURN() return NULL;
+# else
+#  define THREAD_FUNC(f, a) DWORD __stdcall f(LPVOID a)
+#  define THREAD_RETURN() return 0;
+# endif
+#endif
> +

--=20
Erik "kusma" Faye-Lund
