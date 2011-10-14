From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Fri, 14 Oct 2011 16:20:26 -0500
Message-ID: <20111014212026.GF16371@elie.hsd1.il.comcast.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014192741.GA13029@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 23:20:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REpBI-00028N-V1
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 23:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531Ab1JNVUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 17:20:37 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36546 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab1JNVUg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 17:20:36 -0400
Received: by gyb13 with SMTP id 13so1540892gyb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8+AOTfh1ecfCtf6qfj6uODbtVtPpheWcqClODpmGDiQ=;
        b=FzWuF08ypco7qVjILkvPdJpTwTnJPUSlcsGRuZtaiIAnIdCdDa//ZXwczdCyvpc/wj
         H/8skAcss61Fm53hLqaYAaOfRo6n8MPi4wYxiSXzI+v2NeH7yKPabK4esRzgCJpENWpS
         OOVqCRBUBNVhsUWfuSxG4G1ov7lhHWa65KKSo=
Received: by 10.146.232.8 with SMTP id e8mr2211134yah.39.1318627235759;
        Fri, 14 Oct 2011 14:20:35 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j26sm12854507ann.7.2011.10.14.14.20.34
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 14:20:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111014192741.GA13029@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183615>

Jeff King wrote:

> I'm tempted to suggest this on top:
>
> -- >8 --
> Subject: [PATCH] daemon: turn on informative errors by default

Very good idea, as long as we are cautious about making sure admins
know about the change before it comes (for example using release
notes).

[...]
> Git is foremost an open system, and our defaults should
> reflect that.

I think this is a lousy justification. :)

Sure, certain prominent users of git (like kernel.org) would probably
not want to set --no-informative-errors.  And you and I might prefer
that _nobody_ set --no-informative-errors.  But this does not mean the
design of Git has anything to do with that, and I am afraid of the
direction it would take us in if we start pretending it does.

The git daemon is primarily a functional, secure, admin-friendly and
client-friendly program whose defaults should make admins happy where
possible.  Luckily all that is consistent with --informative-errors.
In most use cases (i.e., not weird military security kinds of things),
although --informative-errors without --base-path could have negative
security impact as Andreas has explained before, --informative-errors
with --base-path is harmless as far as I can tell.

I am tempted to propose making --base-path mandatory when there is not
at least one path_ok argument, so in the unusual case, people would
have to explicitly say they want to serve repositories rooted at /.

Just my two cents,
Jonathan
