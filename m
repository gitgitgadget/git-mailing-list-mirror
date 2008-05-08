From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] compat/fopen.c: avoid clobbering the system defined fopen macro
Date: Thu, 8 May 2008 08:59:15 +0100
Message-ID: <e2b179460805080059s76b07f30wedded8b1f5b17dfa@mail.gmail.com>
References: <7vfxsudrt0.fsf@gitster.siamese.dyndns.org>
	 <4821E81A.4030600@nrlssc.navy.mil>
	 <e2b179460805080027pf9ff518xf4fcbb248ecac4bf@mail.gmail.com>
	 <4822AD19.6000609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 08 10:00:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju12u-0003OB-5D
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 10:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbYEHH7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 03:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbYEHH7S
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 03:59:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:60142 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbYEHH7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 03:59:17 -0400
Received: by rv-out-0506.google.com with SMTP id l9so826404rvb.1
        for <git@vger.kernel.org>; Thu, 08 May 2008 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Jo3mDihqX4UgqgqdCn7SmHqUjM2ucMp7SdIshApT3kY=;
        b=k0P8P/9aq+MygMLGsMDgTcs8zGXqGecaOXKCthkoOXw03xJ2jsK0XM0b9R3du2+tarqVkEwjKNjNwhsOiIs8K+uyBej7U7LjzeRzwxnPA1RB+yGTWZ7WkhYUte0BGGthqpEumYJRfvBcCB5ikk+YrG4vY40OjH2NVTlCQumtopM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=v2+Q89ZfMY2rq9sL38J/iRIPzRpngMuZZ5E0R0ho+g6sawkBhWicKDUtaVHykXk2wn3M0Wt/b7T7LK+ExcR6HwX2Ep3OWeAHnmBB0llZKUReEN3RUjMMDWzeZqLRP5KqPcxhGHe6pBIbYyOygxXwC70WzRRe3FqoZVC2xSMRwY0=
Received: by 10.140.133.16 with SMTP id g16mr1386095rvd.231.1210233555856;
        Thu, 08 May 2008 00:59:15 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Thu, 8 May 2008 00:59:15 -0700 (PDT)
In-Reply-To: <4822AD19.6000609@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81516>

2008/5/8 Johannes Sixt <j.sixt@viscovery.net>:
> Mike Ralphson schrieb:
>> I guess there may still be a case for not defining _LARGE_FILES by
>> default on AIX as all the warnings may be off-putting or mask other
>> issues. Maybe instead having a comment for those who need large
>> pack-file support? Will submit amended Makefile patch if there's
>> interest.
>
> Since with this patch we are treating fopen specially anyway, we could go
> one step further and do this, too:
> ---
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b2708f3..dad4d48 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -230,6 +230,9 @@ void *gitmemmem(const void *haystack,
>  #endif
>
>  #ifdef FREAD_READS_DIRECTORIES
> +#ifdef fopen
> +#undef fopen
> +#endif
>  #define fopen(a,b) git_fopen(a,b)
>  extern FILE *git_fopen(const char*, const char*);
>  #endif
>

Loving your work! Squashes all the related warnings, re-tested etc.
Technically, is the #ifdef / #endif actually required? Or is
#undef'ing an undefined macro not portable? I agree it aids clarity
for no cost.

Mike
