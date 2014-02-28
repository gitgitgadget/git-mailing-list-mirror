From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Fri, 28 Feb 2014 14:44:54 +0100
Message-ID: <CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
References: <cover.1393257006.git.kirr@mns.spb.ru> <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Feb 28 14:45:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJNl1-0002Ly-Tz
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 14:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbaB1Npi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 08:45:38 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:53936 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbaB1Npf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 08:45:35 -0500
Received: by mail-ie0-f179.google.com with SMTP id to1so3394695ieb.38
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 05:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=PjjoX+0dSBy2zoRjMycWYk7cd0KcvI1+ssigHyi8y90=;
        b=Ta2pixDV+ecK48azJPnAiOiFqNu0Sxamn6zHWRH434K9GbYR0Xb7nWB8OACzUTZtKl
         EdcgF+0cVQvYBeOQVx8a8J/rC7QWodFD8cgkjUMhPR5JHxD4izhkVZ/Zg9qujULajemM
         XQn14e0AmdrA4flQ79Lwe314AGoZRytcTxXc7YuxFQQqDyMyIvmIC6ZauPTa3hIddzAy
         yQPPPOeZfd1xKIzKRuFdP5O+/PdaRqABJFQ7hluaL4yXug+bD3eziBEI/UcFm8iZwFC9
         EMNZhXoGcYzejbY9g21a8F+1sh1axnNzgEKuFzv5gNG2tmxanX6a2XLct88bM3Qi/EiS
         iPWw==
X-Received: by 10.50.55.40 with SMTP id o8mr4058637igp.42.1393595135103; Fri,
 28 Feb 2014 05:45:35 -0800 (PST)
Received: by 10.64.166.135 with HTTP; Fri, 28 Feb 2014 05:44:54 -0800 (PST)
In-Reply-To: <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242956>

On Mon, Feb 24, 2014 at 5:21 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> diff --git a/Makefile b/Makefile
> index dddaf4f..0334806 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -316,6 +321,7 @@ endif
>  ifeq ($(uname_S),Windows)
>         GIT_VERSION := $(GIT_VERSION).MSVC
>         pathsep = ;
> +       HAVE_ALLOCA_H = YesPlease
>         NO_PREAD = YesPlease
>         NEEDS_CRYPTO_WITH_SSL = YesPlease
>         NO_LIBGEN_H = YesPlease

In MSVC, alloca is defined in in malloc.h, not alloca.h:

http://msdn.microsoft.com/en-us/library/wb1s57t5.aspx

In fact, it has no alloca.h at all. But we don't have malloca.h in
mingw either, so creating a compat/win32/alloca.h that includes
malloc.h is probably sufficient.
