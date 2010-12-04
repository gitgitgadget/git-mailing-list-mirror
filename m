From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 01/14] msvc: Fix compilation errors in compat/win32/sys/poll.c
Date: Sat, 4 Dec 2010 22:12:24 +0100
Message-ID: <AANLkTinDoeYarLQLtZ327a7Us0cvaN42NFCoYorwMsT-@mail.gmail.com>
References: <4CFA8E64.6070402@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 04 22:13:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzPh-0005L2-6T
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 22:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab0LDVMq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Dec 2010 16:12:46 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59717 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab0LDVMp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 16:12:45 -0500
Received: by fxm20 with SMTP id 20so3215482fxm.19
        for <git@vger.kernel.org>; Sat, 04 Dec 2010 13:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=e+8rUtFGES/limHUZ0KWJCBreHsIZCJuoNjEhOOkkDQ=;
        b=hC9xcyGhKVIoW1VP7F5Wb2cfbfFGm4xnSJFLWpNQEVG/WHuEKLCaqX4cZn3f8MJGgc
         Mkq8Zm/K8m44YpMZUyvUKi09jSqkf3Tb9Z65N2vMkfqNRHwxfaRUEg2wx7Z5pfpNXgEV
         o6PHUQgmxdDviIrsscMQZuLzssGr3gBumh2Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=bDBXa/y1UHSc83+2FvmPpDh3gq3Qrr53wEg4p4/tQG95+x/PtWAHIQvrUs7tH44iaJ
         00K2pf9DB9fpnuWoqQYQc8exCp+GNzTDqcG1b4Trzwhi0JNTekywIfjhCvK+twV0Epew
         DZGJSikUIFQNURkCQ38i4pmVrkS07jfKRSTXQ=
Received: by 10.223.81.70 with SMTP id w6mr1050990fak.18.1291497164094; Sat,
 04 Dec 2010 13:12:44 -0800 (PST)
Received: by 10.223.95.202 with HTTP; Sat, 4 Dec 2010 13:12:24 -0800 (PST)
In-Reply-To: <4CFA8E64.6070402@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162915>

On Sat, Dec 4, 2010 at 7:54 PM, Ramsay Jones <ramsay@ramsay1.demon.co.u=
k> wrote:
>
> The msvc winsock2.h header file conditionally defines or declares
> poll() related symbols which cause many macro redefinition errors,
> a struct type redefinition error and syntax errors. These symbols
> are defined in support of the WSAPoll() API, new in Windows Vista,
> when the symbol _WIN32_WINNT is defined and _WIN32_WINNT >=3D 0x0600.
>
> In order to avoid the compilation errors, we set _WIN32_WINNT to
> 0x0502 (which would target Windows Server 2003) prior to including
> the winsock2.h header file.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> =A0compat/win32/sys/poll.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/compat/win32/sys/poll.c b/compat/win32/sys/poll.c
> index 7e74ebe..708a6c9 100644
> --- a/compat/win32/sys/poll.c
> +++ b/compat/win32/sys/poll.c
> @@ -34,6 +34,9 @@
>
> =A0#if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
> =A0# define WIN32_NATIVE
> +# if defined (_MSC_VER)
> +# =A0define _WIN32_WINNT 0x0502
> +# endif
> =A0# include <winsock2.h>
> =A0# include <windows.h>
> =A0# include <io.h>

I have an almost identical patch in my msvc-tree, so FWIW:

Acked-by: Erik Faye-Lund <kusmabite@gmail.com>
