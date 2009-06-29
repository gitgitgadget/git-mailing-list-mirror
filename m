From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] builtin-mailinfo.c: Trim only first pair of square brackets in subject
Date: Mon, 29 Jun 2009 14:26:45 -0700 (PDT)
Message-ID: <m3ljnawx3h.fsf@localhost.localdomain>
References: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
	<1246310220-16909-1-git-send-email-rleigh@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roger Leigh <rleigh@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 29 23:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLONM-0000y0-O9
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 23:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZF2V0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 17:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbZF2V0o
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 17:26:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:29010 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbZF2V0o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 17:26:44 -0400
Received: by fg-out-1718.google.com with SMTP id e21so993854fga.17
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 14:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=WsXE/KihZp8P2q40snNSEZwTqFSCv+GmOtwL9AiSmC4=;
        b=VQ88trpGef8PndpPgacxOB+y7GJwuSAsyxusLuFNVygiglbvFr8eOCu/zaGpN77qLW
         3FNA07pa51yKiCQ0xnhCzmdA5sa9RJK1wrWVxxc8THD5myVoImzzkpB7c5EM7ktDz7Jm
         ACzavmaViwSMfUi9H6V184SH55GVUKQicKrlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mjq8kRZwAnRUrteedoW8Ge4q1oISZx1OhlXbMiX0wH0TzBjiJELvpK/X5k+y8Gn3JR
         Pz9gVTdsJmwEdueUvyxGP8jsALRWa9/XcvpnH7R+z7wou5Fz0p9vjQbwgK8sY1dtjCl7
         OfwlnRqVNU4kdo8jE+T/15ruuqt3soZ6F04NQ=
Received: by 10.86.51.20 with SMTP id y20mr1945327fgy.72.1246310806464;
        Mon, 29 Jun 2009 14:26:46 -0700 (PDT)
Received: from localhost.localdomain (abvw77.neoplus.adsl.tpnet.pl [83.8.220.77])
        by mx.google.com with ESMTPS id d4sm7942479fga.8.2009.06.29.14.26.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 14:26:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5TLQLxG015801;
	Mon, 29 Jun 2009 23:26:31 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5TLQAsC015796;
	Mon, 29 Jun 2009 23:26:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1246310220-16909-1-git-send-email-rleigh@debian.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122459>

Roger Leigh <rleigh@debian.org> writes:

> Use a regular expression to match text after "Re:" or any text in the
> first pair of square brackets such as "[PATCH n/m]".  This replaces
> the complex hairy string munging with a simple single  pattern match.

[...]
> +	/* Strip off 'Re:' and/or the first text in square brackets, such as
> +	   '[PATCH]' at the start of the mail Subject. */
> +	status = regcomp(&regex,
> +			 "^([Rr]e:)?([^]]*\\[[^]]+\\])(.*)$",
> +			 REG_EXTENDED);

Sidenote: it probably didn't worked before either, but there are some
broken mail readers in the wold (*cough* MS Outlook *cough*), that
misinterpret RFCs and use translated form of "Re:" e.g. "Odp:" (Polish),
or not strip "Re:" when replying resulting in string of "Re: Re: Re: ...",
or use capitalized form of "Re:", i.e. "RE:", or use yet another form 
e.g. compact form of repeated "Re: Re: Re: ..." in form of "Re(3):".

But I guess it didn't worked before either.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
