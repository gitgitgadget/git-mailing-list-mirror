From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH] use || instead of | in logical expressions
Date: Fri, 2 Jan 2009 02:07:46 +0300
Message-ID: <20090101230746.GA17008@myhost>
References: <20090101223953.GA16680@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 00:10:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIWgX-0003Ss-72
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 00:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbZAAXHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 18:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbZAAXHw
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 18:07:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:50965 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbZAAXHw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 18:07:52 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2212554fgg.17
        for <git@vger.kernel.org>; Thu, 01 Jan 2009 15:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=KXpy0IFFo+JPcOSrmY8OvC+zXzQCY3QoObWwxjPDh70=;
        b=VxwUrz/k1XZa1ugUof+C/76GE7UtnfeV+zIRNViTwr5FjXvHJEk2VrWXSfoLdE+16Y
         Sa2ob/4jF433WnufFWPjQ/zn7AxGuPDzAGJ/JLKp2p38mc99KUoN6q1EVFMZdU2A9js1
         D6WXs1SDXpTJjQSsevAPQo9qCFF1bgmP40nX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dTiohJUG6jIKvahrJDJhKmm8RZ6G4+Fl80oso8uz1RHR07gZ816At36Fb0l9giWF6e
         +iW1EcijVWFyWNprXgLCy7kNbZVX+akmkVLsurTheSekYjgA8aQXum5H+7uNS8F3kCZE
         pMjz/BImCuRSgxhHPp64nfRg1Ixdq4oKrjB9Y=
Received: by 10.86.23.17 with SMTP id 17mr10164673fgw.0.1230851269081;
        Thu, 01 Jan 2009 15:07:49 -0800 (PST)
Received: from smtp.gmail.com ([91.78.102.214])
        by mx.google.com with ESMTPS id 3sm27800850fge.57.2009.01.01.15.07.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jan 2009 15:07:48 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Fri, 02 Jan 2009 02:07:46 +0300
Content-Disposition: inline
In-Reply-To: <20090101223953.GA16680@myhost>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104339>

On 01:39 Fri 02 Jan     , Alexander Potashev wrote:
> Bit OR ('|') is probably faster and it always works correctly (but '&'
> doesn't!), but it looks horrible here.

Sorry, I was wrong: '&' would work as well (for example in expression
'(a < 1) & (b == 5)') because logical operators can return only 0 or 1.

> 
> Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
> ---
>  builtin-apply.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 07244b0..c71afa1 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -2487,7 +2487,7 @@ static int check_patch(struct patch *patch)
>  		ok_if_exists = 0;
>  
>  	if (new_name &&
> -	    ((0 < patch->is_new) | (0 < patch->is_rename) | patch->is_copy)) {
> +	    (0 < patch->is_new || 0 < patch->is_rename || patch->is_copy)) {
>  		if (check_index &&
>  		    cache_name_pos(new_name, strlen(new_name)) >= 0 &&
>  		    !ok_if_exists)
> -- 
> 1.6.0.6
> 
