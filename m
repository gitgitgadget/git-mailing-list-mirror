From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH na/strtoimax] Compatibility: declare strtoimax() under
 NO_STRTOUMAX
Date: Sat, 05 Nov 2011 17:34:27 +0100
Message-ID: <4EB56593.6090402@kdbg.org>
References: <4EB5583E.2030306@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nick Alcock <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Sat Nov 05 17:34:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMjCU-0006VJ-Oj
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 17:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046Ab1KEQea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 12:34:30 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:9559 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752497Ab1KEQea (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 12:34:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2BC8B13004A;
	Sat,  5 Nov 2011 17:34:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0857519F3E9;
	Sat,  5 Nov 2011 17:34:28 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <4EB5583E.2030306@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184865>

Am 05.11.2011 16:37, schrieb Johannes Sixt:
> Commit f696543d (Add strtoimax() compatibility function) introduced an
> implementation of the function, but forgot to add a declaration.

On second thought, I'm puzzled: Without this patch and without noticing
the warning that strtoimax() was not declared, I had built with
NO_STRTOUMAX on MinGW before, and the build succeeded. This means that
even though MinGW's headers are not C99, we must have pulled in function
strtoimax() from somewhere. I'll investigate later this weekend.

Anyway, this patch does not just add a declaration for the function, but
also redirects strtoimax to gitstrtoimax, which is a bit more than the
commit message claims. Without this patch, topic na/strtoimax should not
build on a non-C99 environment. Can you verify this claim?

-- Hannes

> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  git-compat-util.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index feb6f8e..4efef46 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -354,6 +354,8 @@ extern size_t gitstrlcpy(char *, const char *, size_t);
>  #ifdef NO_STRTOUMAX
>  #define strtoumax gitstrtoumax
>  extern uintmax_t gitstrtoumax(const char *, char **, int);
> +#define strtoimax gitstrtoimax
> +extern intmax_t gitstrtoimax(const char *, char **, int);
>  #endif
>  
>  #ifdef NO_STRTOK_R
