From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 20 Jan 2013 02:10:07 -0800
Message-ID: <20130120101007.GD16339@elie.Belkin>
References: <20130106120917.GC22081@elie.Belkin>
 <7vfw2enl2l.fsf@alter.siamese.dyndns.org>
 <50E9F7C2.1000603@gmail.com>
 <FBDECCA565D94DF9838DD81FE2E2543A@black>
 <7v1udxladc.fsf@alter.siamese.dyndns.org>
 <50EB8EB5.6080204@gmail.com>
 <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com>
 <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com>
 <50F303D8.20709@gmail.com>
 <50F5A435.5090408@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jan 20 11:10:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwrrL-0000KZ-1t
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 11:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab3ATKKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 05:10:15 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:44093 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3ATKKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 05:10:13 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so2281418dad.41
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 02:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+grPtG5+V9RlRzWhqcx69WLwNYe71+WB+4Dr91DBOwE=;
        b=jxkuyz+t7EdVUdRBdDAIPAg+8YCVRaIyLsesGjHcIRacKKxl2XWT9ImaZwYdTnibJh
         Z20WLHgmY35cQf5Pwmw2cj2GS42mx6XFZdEGAB1nYaqrf5oktY4SY2DO7OsDs47+p0Ja
         aGFVZ3OloN0tuMUyj4wl8yGZold6i2dRnCBxsMbEBgrH7pt/rCwWKYkIade2dCW+0bKq
         uwyyOsWoNuBpKWJ+PRuAMGpw13TPLizPrbi8YPUILGvLj7QJGKezWLtoaEwfiU8AM1IE
         iDrpBM5onZmg3qe+FEYJRsR9Cv5OXq1F8U52Biv4pP/70PQW4U8QU5HaY7IBByzizU8V
         AECw==
X-Received: by 10.66.79.74 with SMTP id h10mr38869809pax.25.1358676613408;
        Sun, 20 Jan 2013 02:10:13 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id gv9sm6540240pbc.21.2013.01.20.02.10.10
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 02:10:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50F5A435.5090408@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213999>

Ramsay Jones wrote:

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -85,12 +85,6 @@
>  #define _NETBSD_SOURCE 1
>  #define _SGI_SOURCE 1
>  
> -#ifdef WIN32 /* Both MinGW and MSVC */
> -#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
> -#include <winsock2.h>
> -#include <windows.h>
> -#endif

So, do I understand correctly that the above conditional should be
something like

 #if defined(WIN32) && !defined(__CYGWIN__)

to allow dropping the CYGWIN_V15_WIN32API setting?

"defined(WIN32)" is used throughout git to mean "win32 and not
cygwin", so if I understand correctly we would either need to do

 #if defined(WIN32) && defined(__CYGWIN__)
 # undef WIN32
 #endif

or define a new GIT_WIN32 (name is just a placeholder) macro to use
consistently in its stead.

Thanks for investigating.
Jonathan
