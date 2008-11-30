From: dhruva <dhruvakm@gmail.com>
Subject: Re: git build on msys fails (and fix)
Date: Sun, 30 Nov 2008 17:22:09 +0530
Message-ID: <e3f230850811300352n76fda756jfeec6e9fb3db5246@mail.gmail.com>
References: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 30 12:53:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6krs-0001jL-8P
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 12:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbYK3LwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 06:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbYK3LwL
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 06:52:11 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:50127 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbYK3LwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 06:52:11 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2175389wfd.4
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 03:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AdHCO2nBRFWnT5KGUPeKAxigNnYeVXiPIdLOtRrTNN4=;
        b=JrCmUnvRLddTRd9WP+JdbnekT2bL80dbfRAkCIrJiwvo2HVTPXFpzF8EE/TAg2AIBj
         8eVB7gheOravcoCKSn67+Jy7c2ou3YBGrSaTYF63KGTbma/GHjWJLwkC/N03CIAu+8Ez
         rdEj1MSEjKsOUewi8vom9VPkU+ckUxBs//MqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aXJVym2TdQ/0NwousEDHGrTfDdPl/aRv7b6tKgmxUk5rLGMI+u+vTatI0cB6PaY42s
         91nTfWK2RnSiV5b8H5q8yhUxkg4+uWcj6XmDCSvnoOSYfSegmQdA9SaYhNMkTd0ahGva
         uN91c0xmYIBd/QkzKN4J5tD1oUhzDL37Bmuik=
Received: by 10.142.226.10 with SMTP id y10mr4084528wfg.3.1228045929780;
        Sun, 30 Nov 2008 03:52:09 -0800 (PST)
Received: by 10.142.110.21 with HTTP; Sun, 30 Nov 2008 03:52:09 -0800 (PST)
In-Reply-To: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101971>

Hi,

On Sun, Nov 30, 2008 at 4:32 PM, dhruva <dhruvakm@gmail.com> wrote:
> Hello,
>  I build git on msys environment regularly. With the recent changes to
> add cache preload facility (commit ID:
> 671c9b7e315db89081cc69f83a8f405e4aca37bc) brings in dependency on
> pthreads. This is not available in the msys distribution which was
> part of the git build distro. I installed libpthread for mingw to get
> the related headers and libraries. I had to make some minor changes to
> libpthread installation. I copied the 'setjmp.h' from my other mingw
> installation and had to had edit it to remove some mingw specific
> macros.
>
> @:/e/users/dhruva/stub/repo/git/git
> [520]$ diff -u /e/tools/gnu/include/setjmp.h /mingw/include/setjmp.h
> --- /e/tools/gnu/include/setjmp.h       Sun Oct  5 04:01:15 2008
> +++ /mingw/include/setjmp.h     Sun Nov 30 16:18:00 2008
> @@ -36,7 +36,7 @@
>  * The function provided by CRTDLL which appears to do the actual work
>  * of setjmp.
>  */
> -_CRTIMP int __cdecl __MINGW_NOTHROW _setjmp (jmp_buf);
> +int __cdecl _setjmp (jmp_buf);
>
>  #define        setjmp(x)       _setjmp(x)
>
> @@ -44,7 +44,7 @@
>  * Return to the last setjmp call and act as if setjmp had returned
>  * nVal (which had better be non-zero!).
>  */
> -_CRTIMP void __cdecl __MINGW_NOTHROW longjmp (jmp_buf, int)
> __MINGW_ATTRIB_NORETURN;
> +void __cdecl longjmp (jmp_buf, int);
>
>  #ifdef __cplusplus
>  }
>
> Also,
>  had to copy a pthread library with a dfferent name to the standard name:
> $cp libpthreadGC2.a libpthread.a
>
> The build went fine and am using the new binaries.
>


I also had to define  THREADED_DELTA_SEARCH.
$ export  THREADED_DELTA_SEARCH=1
$ make

This worked for me.

-dhruva

-- 
Contents reflect my personal views only!
