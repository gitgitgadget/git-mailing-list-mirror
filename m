From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Makefile: Remove excess backslashes from sed
Date: Fri, 9 Apr 2010 10:44:38 -0400
Message-ID: <6D2E98A1-3266-4799-8982-1C54A65CEB3A@silverinsanity.com>
References: <1270824107-26604-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 17:00:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Fgn-0008Cj-G1
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 17:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab0DIOxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 10:53:40 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38095 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab0DIOxj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 10:53:39 -0400
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2010 10:53:39 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 76C921FFC058; Fri,  9 Apr 2010 14:44:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.113] (unknown [64.134.102.129])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id E014C1FFC056;
	Fri,  9 Apr 2010 14:44:35 +0000 (UTC)
In-Reply-To: <1270824107-26604-1-git-send-email-brian@gernhardtsoftware.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144438>

This is the same patch as before.  I forgot --dry-run while testing git-send-email.  My apologies.

On Apr 9, 2010, at 10:41 AM, Brian Gernhardt wrote:

> The sed script that was intended to add lines altering the sys.path
> had extra backslashes in them.  Instead resulting in
> 
>  import sys;  import os;  sys.path.insert( ... )
> 
> It output
> 
>  import sys; \ import os; \ sys.path.insert( ... )
> 
> Unfortunately this caused python (2.6.1 on OS X 10.6.3) to error
> 
>  SyntaxError: unexpected character after line continuation character
> 
> Removing two of the backslashes solves this problem.
> 
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
> Makefile |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f0fe351..b9eb1ca 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1632,8 +1632,8 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
> 	sed -e '1{' \
> 	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
> 	    -e '}' \
> -	    -e 's|^import sys.*|&; \\\
> -	           import os; \\\
> +	    -e 's|^import sys.*|&; \
> +	           import os; \
> 	           sys.path.insert(0, os.getenv("GITPYTHONLIB",\
> 	                                        "@@INSTLIBDIR@@"));|' \
> 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
> -- 
> 1.7.1.rc0.243.g2ce66
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
