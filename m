From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] pack-protocol.txt: Add warning about protocol
 inaccuracies
Date: Wed, 1 Jul 2015 12:39:49 -0700
Message-ID: <20150701193949.GC4865@google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-2-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:40:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANrT-0004un-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbbGATjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:39:53 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35770 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbbGATjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:39:52 -0400
Received: by iecuq6 with SMTP id uq6so41895634iec.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=k+g6OVQT3moeNVvzm064Fq6Xc15AXMRttYkdhSxlVrw=;
        b=H3WnYnkoX6XnyWmnxL0r7CI2vSnsOuEJjPz8PIEAA+cDLIfNAW6Rg+U3/vawEOfRdF
         V2C8IQbPvKmd0gHYtgPUtn3aEv+t+iZChJtc+iHhwxt6b1m6vY5eoq0cowMi7nli7Bd4
         TJC9eZLQclSQ+sHFkq9C5ng16dvUn5jV3e+VsOUR3VMcE0untLayKAhsUN49WwSCR/iM
         dVbx0ZuJ5mOdRahxeBo64djHHLc8XO5El0ndpPXiQaaY21nxtjmdlXnv5zy0THlZyk7g
         OuCdaOi3bEUCKLmw3q4wYBRDd7d16vAiZd8J1qdM6qkr3l48kCO7Msj/7i/rSuIQBgTe
         f29g==
X-Received: by 10.107.8.7 with SMTP id 7mr31758442ioi.15.1435779591870;
        Wed, 01 Jul 2015 12:39:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:a535:cddc:d86b:41ef])
        by smtp.gmail.com with ESMTPSA id h2sm3016740igv.2.2015.07.01.12.39.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 12:39:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435774099-21260-2-git-send-email-dborowitz@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273191>

Hi,

Dave Borowitz wrote:

> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -14,6 +14,17 @@ data.  The protocol functions to have a server tell a client what is
>  currently on the server, then for the two to negotiate the smallest amount
>  of data to send in order to fully update one or the other.
>  
> +Notes to Implementors
> +---------------------
> +
> +WARNING: This document is a work in progress. Some of the protocol
> +specifications below may be incomplete or inaccurate. When in doubt,
> +refer to the C code.

If we include this warning, can it also say to contact
git@vger.kernel.org for inaccuracies?

Otherwise it is easy to misread as "Some of this document may be
inaccurate, and we're working on fixing that.  Don't bug me --- I
already know about the problems --- just be patient!"

I would rather that it would say something like

	Caveat
	------
	This document contains some inaccuracies.  Do not forget to also
	check against the C code, and please contact git@vger.kernel.org
	if you run into any unclear or inaccurate passages in this spec.

> +
> +One particular example is that many of the LFs referenced in the
> +specifications are optional, but may (yet) not be marked as such. If not
> +explicitly marked one way or the other, double-check with the C code.

The 'Reference Discovery' section says:

	Server SHOULD terminate each non-flush line using LF ("\n") terminator;
	client MUST NOT complain if there is no terminator.

Unfortunately that's not explained in a section with broader scope.

Isn't that actually the rule everywhere except for in push certs?
The documentation will be easier to use if it says so instead of
asking implementers to check the source of all implementations
(since interoperability with only one isn't enough).

Thanks,
Jonathan
