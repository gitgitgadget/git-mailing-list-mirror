From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 01/18] advice: add error_resolve_conflict() function
Date: Thu, 25 Nov 2010 23:56:57 -0600
Message-ID: <20101126055656.GB18751@burratino>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
 <20101125212050.5188.50630.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 26 06:57:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIz-0007X8-BO
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab0KZF5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:57:04 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61101 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab0KZF5D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:57:03 -0500
Received: by gyb11 with SMTP id 11so782620gyb.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 21:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GQXx3Ia3YcsKcjE6t8q59xTLCMRXE5T4i6wsbCcJ1tA=;
        b=QtrijpFGomvPk7HWdhnYzOG7oHNO+Bt7hcLgrVfs8QHexaF+Y1dh2ZPuJL01o5t9/o
         mbJJ1sgbtpR5JMQ7qlrlaOZLcnQiRpCFYAeV5JMgN6lNRb+dofFmGehzytIoI+yolxC0
         0d9P6TBsiK1xhk1mKFMbntAmHT4d4kRWgmrBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=d3PjVQoVj+5UBEeAyTbgf4cDCcet4ABuNxY20502ZRqoPxGWpqhwUO7jecHthSU/Iu
         bhJpikCKukSTKtGlMNdKphvCjcmEBdb+I358NiBnTQwzfY1EIunyS13ti1mTWNOpvNvR
         is6eAy+V6unPtPuLgwiFAAxyvxABAbspEmO6I=
Received: by 10.100.255.20 with SMTP id c20mr1285580ani.195.1290751022348;
        Thu, 25 Nov 2010 21:57:02 -0800 (PST)
Received: from burratino (adsl-68-255-101-216.dsl.chcgil.sbcglobal.net [68.255.101.216])
        by mx.google.com with ESMTPS id x39sm1692207ana.6.2010.11.25.21.56.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 21:57:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101125212050.5188.50630.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162202>

Christian Couder wrote:

> --- a/advice.c
> +++ b/advice.c
> @@ -34,6 +34,13 @@ int git_default_advice_config(const char *var, const char *value)
>  	return 0;
>  }
>  
> +const char unmerged_file_advice[] =
> +	"'%s' is not possible because you have unmerged files.\n"
> +	"Please, fix them up in the work tree, and then use 'git add/rm <file>' as\n"
> +	"appropriate to mark resolution and make a commit, or use 'git commit -a'.";
> +const char unmerged_file_no_advice[] =
> +	"'%s' is not possible because you have unmerged files.";

static?

> --- a/advice.h
> +++ b/advice.h
> @@ -13,5 +13,6 @@ extern int advice_detached_head;
>  int git_default_advice_config(const char *var, const char *value);
>  
>  extern void NORETURN die_resolve_conflict(const char *me);
> +extern int error_resolve_conflict(const char *me);

I like it.
