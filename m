From: Jeffrey Middleton <jefromi@gmail.com>
Subject: Re: git update --prune issue
Date: Tue, 27 Oct 2009 11:39:14 -0500
Message-ID: <4389ce950910270939u10fff402l6e9a5333913d7a74@mail.gmail.com>
References: <4389ce950910261508p7eca354el77bad07305a80952@mail.gmail.com> 
	<4AE6B28F.9010407@drmicha.warpmail.net> <4389ce950910270807o69d51155xb083f34bb31e1dae@mail.gmail.com> 
	<20091027162936.GA8130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 17:39:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2p5I-0002mq-1H
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 17:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbZJ0Qjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 12:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756016AbZJ0Qjd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 12:39:33 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:54483 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915AbZJ0Qjc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 12:39:32 -0400
Received: by gv-out-0910.google.com with SMTP id r4so86637gve.37
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=SWXXFO4UeJOA362xeX1ZlyVfzCb9i1FhOkWLYgOhYM8=;
        b=XBlNGJw7gsNcHPqynalq7QnRBYtsjJJzXFQljvKLSknaVT1lMhyKfP43ptwHgZYCtj
         7kH5KlvJ3ZGAnkkIhHrLvX93Nz2Fo9Rn2q8xjrQ3MKI73VOZ0WJA6Tgaq/1FZAcmJQKj
         0+DUeAk9TvD4Pti5K2jSOKNQRGEocOJco6JAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XWOnBYDHA8rUyi6u5Kyeo6TV9t5cZB4DzDQwQvtsy54p4GXFlkvc/uCJ+trFtS9hUx
         QPxFFPME6MQHhDfPTLgmWhZ/cEn7K9TAfUIGjc05f2p2SXBHBN7npds2+sjhjMCGr24k
         Gw/bQuFCy6JD2otfr30pMXk8iUwhh1RB0sL/A=
Received: by 10.216.87.136 with SMTP id y8mr1241294wee.70.1256661574739; Tue, 
	27 Oct 2009 09:39:34 -0700 (PDT)
In-Reply-To: <20091027162936.GA8130@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131356>

On Tue, Oct 27, 2009 at 11:29 AM, Jeff King <peff@peff.net> wrote:
> The "pruned" line basically means that we are deleting that ref, and
> then we complain immediately about that very ref (which is probably
> pointing to the null sha1 or something at this point). We tend to cache
> packed refs, so that may be the cause.

Actually, it force updated two refs, created one, and deleted one, and
then immediately complained about the force-updated refs - but only
after moving on into the next remote update.  My best guess would
still be that as you suggest there's an out of date cache - it gets
updated within the "update steph" part, but when it moves on to
"update kevin" it doesn't have all the new information.

> So either we need to invalidate that ref from the cache when it gets
> deleted, or perhaps we are already invalidating it and we need to be
> respecting that invalidation in other parts of the code. I'll take a
> look.
>
> -Peff
>
