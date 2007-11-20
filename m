From: Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH] Fix "identifier redeclared" compilation error with SUN cc
Date: Tue, 20 Nov 2007 19:26:15 +0100
Message-ID: <mj+md-20071120.182204.515.nikam@ucw.cz>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org> <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de> <7vd4ua3hww.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711191847550.7957@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-2?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	raa.lkml@gmail.com, git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuYGJ-00053v-4n
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbXKTSzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbXKTSzf
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:55:35 -0500
Received: from nikam-dmz.ms.mff.cuni.cz ([195.113.20.16]:40604 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755590AbXKTSze (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:55:34 -0500
X-Greylist: delayed 1756 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2007 13:55:34 EST
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 8B7405BB0C; Tue, 20 Nov 2007 19:26:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711191847550.7957@bianca.dialin.t-online.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65565>

Hello!

>  #ifndef FLEX_ARRAY
> -#if defined(__GNUC__) && (__GNUC__ < 3)
> +#if defined(__GNUC__)
> +#if (__GNUC__ < 3)
>  #define FLEX_ARRAY 0
>  #else
>  #define FLEX_ARRAY /* empty */
>  #endif
> +#else
> +/* more cases we know we can use 0 or empty can come here */
> +#endif
> +#endif
> +
> +/* if still undefined, default to the safe, old fashioned way */
> +#ifndef FLEX_ARRAY
> +#define FLEX_ARRAY 1
>  #endif

Do we really want to use empty FLEX_ARRAY only for a new gcc? Shouldn't
we test for C99 instead (__STDC_VERSION__ >= 199901L) and only if it
isn't C99, choose between 0 and 1 depending on gccness of the compiler?

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"First they ignore you. Then they laugh at you. Then they fight you. Then you win." -- Gandhi
