From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Sun, 26 Aug 2007 15:00:18 -0400
Message-ID: <9e4733910708261200m5e4c3019g490ffc29b171ef08@mail.gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	 <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
	 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
	 <alpine.LFD.0.999.0708241616390.25853@woody.linux-foundation.org>
	 <9e4733910708250844n7074cb8coa5844fa6c46b40f0@mail.gmail.com>
	 <20070826093331.GC30474@coredump.intra.peff.net>
	 <9e4733910708260934i1381e73ftb31c7de0d23f6cae@mail.gmail.com>
	 <alpine.LFD.0.999.0708260959050.25853@woody.linux-foundation.org>
	 <9e4733910708261106u3fecde67m8045ddba3aa57650@mail.gmail.com>
	 <alpine.LFD.0.999.0708261118260.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, jnareb@gmail.com,
	"Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 26 21:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPNLh-0006M9-7G
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 21:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbXHZTA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 15:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbXHZTA3
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 15:00:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:47000 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbXHZTAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 15:00:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1791208wah
        for <git@vger.kernel.org>; Sun, 26 Aug 2007 12:00:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JA4ve6IElRy1jEThqN0Z/QxSl4RlGuEk45NRvfWMYHk+KPUgKspoDQnr8TICltAno5CIpI2W3N1DvVCm2ES1OD6KN+lHwn1eO98JS//2xix/6KYFpOJjNyY+YBXyoj3N77hQN09t5gSDINJYx7hdeky0Ow5spq42lR+9TRqWuV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ahaBB4O+LL4nbpUS4+1HpsqUZXcSIhngJAqx9jIlbmWNQTT3QfEdWUj66Vt3JGmAU0pWwFdNVFCez36fD+N32W08eiPfdeZo/VpwwhuqOYPX0wisr4ks5SMP13g7FpDqm7hrdQptbjXSu4IrXDDP7V61XrN2pzrqbet0WPH6/QI=
Received: by 10.114.176.1 with SMTP id y1mr1884495wae.1188154818189;
        Sun, 26 Aug 2007 12:00:18 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 26 Aug 2007 12:00:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708261118260.25853@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56709>

On 8/26/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Doesn't kernel.org use alternates or something equivalent for serving
> > up all those nearly identical kernel trees?
>
> Absolutely. And that's the point. "git-daemon" will serve a nice
> individualized pack, even though any particular repository doesn't have
> one, but is really a combination of "the base Linus pack + extensions".

A really simple change to the git protocol would be to make the client
loop on the request. On the first request the server would see that
the client has no objects and send the "base Linus pack". The client
would then loop around and repeat the process which will trigger the
current pack building process.

Do pack files contain enough information about the heads of the object
chains for this to work? The client needs to be able to determine it's
state after receiving the pack and send the info back in the next
round.

I'm not buying the security argument. If you want something kept
hidden get it out of the public db. If I know the sha of the hidden
object can't I just add a head for it and git-deamon will happily send
it and the chain up to it to me?

-- 
Jon Smirl
jonsmirl@gmail.com
