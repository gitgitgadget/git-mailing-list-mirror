From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Wed, 23 Jun 2010 16:08:20 -0500
Message-ID: <20100623210820.GA24242@burratino>
References: <4C226520.5080009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 23 23:11:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORXE4-0004G4-OA
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 23:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab0FWVId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 17:08:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44986 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0FWVIc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 17:08:32 -0400
Received: by iwn41 with SMTP id 41so68425iwn.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SqVJO3Mc5EY7KIh6/Tpvo60QrtolM/lVATCzvT62Z7g=;
        b=RYbjTJ6mX5G5g52/EXF9kM6IKwc+aWp1VqK4ljBTsyM7vR3qS2/+cPVkKUNjXVfe1B
         dHzRlZOtwsc0Q9raRxqaELnvzp+RnEimz3KXRt0HlO1OmRrNZv2q3Jb2H4PPPFRpmUV6
         0SDWAwhXbVVpZwUE2kdqQ9jVCJGybSWJYHKuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DTxmfevj4YGKkkIW1Fsxu5K7O71gQ3OnQ+GFnEfalTxZD59S6oO4tjkRRJWJhaKvmz
         aeihChdcy3lUVESpep5zcLdtWLPagI21XFhUgmv4cF249/sVrik27gPlfy6cdS6NI1ro
         f3Sa0bR5gmwc1Pez8EZbmWK5S9MA6h1JA/+mY=
Received: by 10.231.184.73 with SMTP id cj9mr9868770ibb.1.1277327312154;
        Wed, 23 Jun 2010 14:08:32 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm14210748ibg.9.2010.06.23.14.08.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 14:08:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C226520.5080009@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149549>

Hi Ramsay,

Ramsay Jones wrote:

>     LINK : warning LNK4044: unrecognized option '/Zi'; ignored
> 
> In order to suppress the warning, we refrain from passing the
> $(ALL_CFLAGS) macro to the linker.
> 
> Note that, should it be necessary in the future, an option
> intended for both the (front-end) compiler and the linker can
> be included in both CFLAGS and LDFLAGS.

I think traditionally CPPFLAGS is meant to be used for the purpose
you are describing (see [1] for example).

I realize that the Makefile does not currently use the terms this way:
making it consistent would require

 . s/BASIC_CFLAGS/BASIC_CPPFLAGS/, except that the

	BASIC_CFLAGS += -Kthread

   settings should probably stay as-is

 . Windows BASIC_CFLAGS would probably need to be split:

	BASIC_CFLAGS = -nologo
	BASIC_CPPFLAGS = -I. -I../zlib ... -DWIN32 ...

 . s/COMPAT_CFLAGS/COMPAT_CPPFLAGS

What do you think?
Jonathan

[1] http://www.gnu.org/software/autoconf/manual/html_node/Preset-Output-Variables.html#index-CFLAGS-80
