From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 01/14] msvc: Fix compilation errors in compat/win32/sys/poll.c
Date: Sat, 4 Dec 2010 22:22:23 +0100
Message-ID: <201012042222.23384.j6t@kdbg.org>
References: <4CFA8E64.6070402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	"GIT Mailing-list" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 04 22:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzYs-0001Am-GP
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 22:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878Ab0LDVWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 16:22:25 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:41419 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755779Ab0LDVWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 16:22:25 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 19EF210012;
	Sat,  4 Dec 2010 22:22:28 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7B39A19F5E9;
	Sat,  4 Dec 2010 22:22:23 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4CFA8E64.6070402@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162920>

On Samstag, 4. Dezember 2010, Ramsay Jones wrote:
> The msvc winsock2.h header file conditionally defines or declares
> poll() related symbols which cause many macro redefinition errors,
> a struct type redefinition error and syntax errors. These symbols
> are defined in support of the WSAPoll() API, new in Windows Vista,
> when the symbol _WIN32_WINNT is defined and _WIN32_WINNT >= 0x0600.
>
> In order to avoid the compilation errors, we set _WIN32_WINNT to
> 0x0502 (which would target Windows Server 2003) prior to including
> the winsock2.h header file.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  compat/win32/sys/poll.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/compat/win32/sys/poll.c b/compat/win32/sys/poll.c
> index 7e74ebe..708a6c9 100644
> --- a/compat/win32/sys/poll.c
> +++ b/compat/win32/sys/poll.c
> @@ -34,6 +34,9 @@
>
>  #if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
>  # define WIN32_NATIVE
> +# if defined (_MSC_VER)
> +#  define _WIN32_WINNT 0x0502
> +# endif
>  # include <winsock2.h>
>  # include <windows.h>
>  # include <io.h>

Don't you have to do the same in git-compat-util.h?

-- Hannes
