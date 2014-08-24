From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Undefine strlcpy if needed.
Date: Sun, 24 Aug 2014 12:10:16 +0100
Message-ID: <53F9C818.8020607@ramsay1.demon.co.uk>
References: <1408854741-13956-1-git-send-email-tsunanet@gmail.com> <1408854930-14322-1-git-send-email-tsunanet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Benoit Sigoure <tsunanet@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 13:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLVh3-00036S-Rz
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 13:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbaHXLK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 07:10:27 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:48309 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752292AbaHXLK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 07:10:27 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 3FC8E384081;
	Sun, 24 Aug 2014 12:09:42 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id ED37438407C;
	Sun, 24 Aug 2014 12:09:41 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sun, 24 Aug 2014 12:09:41 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1408854930-14322-1-git-send-email-tsunanet@gmail.com>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255786>

On 24/08/14 05:35, Benoit Sigoure wrote:
> On OS X, strlcpy is already #define'd, which causes warnings
> in all the files that include `git-compat-util.h'.  Note that
> this only occurs when building without running ./configure.
> 
> Signed-off-by: Benoit Sigoure <tsunanet@gmail.com>
> ---
> 
> Resending with the SOB line I forgot.
> 
>  git-compat-util.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f587749..8c001e2 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -495,6 +495,9 @@ extern char *gitstrcasestr(const char *haystack, const char *needle);
>  #endif
>  
>  #ifdef NO_STRLCPY
> +#ifdef strlcpy
> +#undef strlcpy
> +#endif

If strlcpy is #defined, then presumably NO_STRLCPY should not be set, no?

>  #define strlcpy gitstrlcpy
>  extern size_t gitstrlcpy(char *, const char *, size_t);
>  #endif
> 

Hmm, which version of OS X are we talking about?

config.mak.uname contains this:

        ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
                NO_STRLCPY = YesPlease

What does ./configure put in config.mak.autogen for NO_STRLCPY?

(sorry, I don't have access to any version of OS X, so I can't
offer much help on this).

ATB,
Ramsay Jones
