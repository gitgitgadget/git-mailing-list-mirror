From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git should not use a default user.email config value
Date: Fri, 9 Aug 2013 16:19:28 -0700
Message-ID: <20130809231928.GY14690@google.com>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 01:19:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7vy6-0004DH-3J
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 01:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031511Ab3HIXTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 19:19:32 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:36301 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031447Ab3HIXTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 19:19:32 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so4981986pbb.38
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 16:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5/rAoDz6TLRGQf+p0lQqheAAEILU7s8K/A3V+d8VhFY=;
        b=FPo3aBV4UArxAlykSeKsVecPPLBfDrhvAHBl+9hQOXmvkyoAyOdgQu6zsQKmYR+RbJ
         o9UefXa77PmNDHcdM34IhrNfqkYtKlIp42HhzKrOZRa8LO18DFwj8uLmqIkO1k50HKGL
         SX2kTddWZxjMcatwPXEOyh/4I1HB8rHtuR/BtCvNcJQMpCtwL6KyIpCIeJqr2DNHTxJ4
         5wUitF0KorsM9L2pP/xyg/o0ld9DcrGQ0UF08TrgsAup4pUl2BI7wBTAMtpXw8Ujkstg
         Hs2OTStwIRNn/z/FzyrVl8qBjWdmD9SSUaM20rwMt14xZFyNkt+8kwETrd0lcHCr5f+B
         axSA==
X-Received: by 10.67.23.36 with SMTP id hx4mr13975835pad.54.1376090371457;
        Fri, 09 Aug 2013 16:19:31 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bt1sm22368963pbb.2.2013.08.09.16.19.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 16:19:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130809223758.GB7160@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232053>

Jeff King wrote:

> Yeah, there are basically three levels of ident:
>
>   1. The user told us explicitly (e.g., $EMAIL, user.email). Trust it.
>
>   2. We guessed and it looks reasonable (e.g., hostname is FQDN). Warn
>      but use it.
>
>   3. It looks obviously bogus (e.g., we do not have a domain name).
>      Reject it.
>
> We can move some cases from (2) down to (3), like when we use
> gethostname rather than /etc/mailname.  But we risk breaking people's
> existing setups. I don't think we know how many people rely on the
> implicit hostname selection and would be affected. I don't know if there
> is a good way to find out short of changing it and seeing who screams.

Yes.  The result from a reverse DNS lookup is almost never the right
mailname.

 * Small installations tend to use a smarthost.
 * Large installations tend to use more than one machine, and only
   one machine's name gets the MX record.
 
So except for cases where someone doesn't actually care about the
recorded author and just has a script making commits (such users
already suffer from the ".(none)" heuristic), I don't think this would
hurt anyone.

> We can put a deprecation warning in the release notes, but people tend
> to ignore those.

Not so much a deprecation warning as an "Here is one of the more
noticeable changes in this release" announcement.

I'm pretty sure a deprecation warning would not help here.  Either
people are affected and we say "WARNING: You were doing something
perfectly reasonable, but now we discourage it", or, more likely,
people are not affected.  Announcing a change too loudly to users not
affected by it has a very bad side effect of training them not to pay
much attention to release notes.

[...]
> Another option could to add an option to control the strictness.

I suspect a new config item for this is a bad idea, given how simple
it is to choose a good default for everyone.

Thanks,
Jonathan
