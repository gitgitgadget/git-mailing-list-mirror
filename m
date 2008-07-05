From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH/RFC] Fix some warnings (on cygwin) to allow -Werror
Date: Sat, 05 Jul 2008 21:56:44 +0100
Message-ID: <486FE00C.7020207@ramsay1.demon.co.uk>
References: <486CF5A9.5060104@ramsay1.demon.co.uk> <E4D3A379-9EB2-49D1-AD42-CFFC453A2B08@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 00:37:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFGNR-0008CQ-4g
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 00:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbYGEWgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 18:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbYGEWgJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 18:36:09 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:4044 "EHLO
	anchor-post-35.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752133AbYGEWgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jul 2008 18:36:09 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.67)
	id 1KFGDr-0005a8-Hz; Sat, 05 Jul 2008 22:27:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <E4D3A379-9EB2-49D1-AD42-CFFC453A2B08@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87473>

Steffen Prohaska wrote:
> On Jul 3, 2008, at 5:52 PM, Ramsay Jones wrote:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>
>> Despite the subject line, this should be useful on any system for
>> which uint32_t is defined to be unsigned long rather than
>> unsigned int. (and where the return type of htonl() is similarly
>> defined).
> 
> For MINGW, we fixed these warnings in the compat layer, see cd800eecc2:
> 
> diff --git a/compat/mingw.h b/compat/mingw.h
> index a87cc96..6bc049a 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -186,6 +186,10 @@ pid_t mingw_spawnvpe(const char *cmd, const char  
> **argv, char **env);
>   void mingw_execvp(const char *cmd, char *const *argv);
>   #define execvp mingw_execvp
> 
> +static inline unsigned int git_ntohl(unsigned int x)
> +{ return (unsigned int)ntohl(x); }
> +#define ntohl git_ntohl
> +
>   sig_handler_t mingw_signal(int sig, sig_handler_t handler);
>   #define signal mingw_signal
> 

Yes, I had something similar at one point (but not in compat).
However, not all of these warnings are solved by the above.
For example, the changes to builtin-fast-export.c, builtin-pack-objects.c,
and pack-check.c do not involve ntohl() at all. (some hunks in other
files do not involve ntohl() either).

When the PRIu32 macro idea was suggested (I think it was Simon 'corecode' Schubert
who first mentioned it), I thought it would look so ugly, no one would
agree to such a patch...  Having implemented it, well I guess it's not
quite as bad as I feared ;-) YMMV!

ATB,

Ramsay Jones
