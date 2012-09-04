From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v2] Support for setitimer() on platforms lacking it
Date: Tue, 4 Sep 2012 12:45:34 +0200
Message-ID: <002401cd8a8a$6a43ca80$3ecb5f80$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 12:45:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8qdj-000586-K4
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 12:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab2IDKpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 06:45:44 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:57431 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab2IDKpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 06:45:44 -0400
Received: from DualCore (dsdf-4d0a1636.pool.mediaWays.net [77.10.22.54])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LtBsd-1TbXLO3YZ1-012FDJ; Tue, 04 Sep 2012 12:45:38 +0200
References: 
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2KhC5jCGW/VYkxTQaUbSOYXNPpcQABOy3A
Content-Language: de
X-Provags-ID: V02:K0:N6qDuTPmwgKiudXZQuLlu03Jph5h/tKRJ8QJHBCJovJ
 sv9Bih4UYQidL/H0q/wtg6XX8iyHvK8Gha0oe7VXWWkXyJJu5u
 5Y2If2Qcyk6ZGaWQ/LUckvugSRB5djTzwyGiZWsYKCpYM8UYqm
 /5dSKJ5HSKCZfznjwhVayZcHjHW+w3ckDC7yhdcqTjfnNhlK6I
 Y3PDdNE6mgeC30irGjotoMkucUAx9FdLrKOsumo1+9l1l53gFP
 vP7+ttJtuLSKhNYMV61KhPGJlMjOE0tgD0jiYF4FsiNsblti2R
 NpyK5R0orJTuixZV53rn7wfxA/d/R0F2q6AYaHEdqDqj4HBCb6
 rGXji9KULBN737mc3OzEXyTHJ2HGOaNwpgiZQP3J2lVR6nhA57
 Tlj+5sS/Y9FMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204734>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Tuesday, September 04, 2012 12:31 PM
> To: 'Junio C Hamano'
> Cc: 'git@vger.kernel.org'
> Subject: RE: [PATCH v2] Support for setitimer() on platforms lacking it
> 
> 
> Poor man's getitimer(), simply based on alarm().
> 
> Currently needed on HP NonStop ("#ifdef __TANDEM"),
> which does provide "struct itimerval", but no setitimer().
> Alarm times are rounded up to the next full second.
> 
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
> Revert/remove my previous 2 patches for this first (from 'pu').

Actually: https://github.com/git/git/commit/55c96a1325

>  git-compat-util.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 18089f0..55b9421 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h@@ -163,6 +163,10 @@
>  #define probe_utf8_pathname_composition(a,b)
>  #endif
> 
> +#ifdef NO_SETITIMER /* poor man's setitimer() */
> +#define setitimer(w,v,o) alarm((v)->it_value.tv_sec+((v)->it_value.tv_usec>0))
> +#endif
> +
>  #ifdef MKDIR_WO_TRAILING_SLASH
>  #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
>  extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
> --
> 1.7.12

Bye, Jojo
