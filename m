From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] send-email: die if CA path doesn't exist
Date: Fri, 20 Nov 2015 19:46:51 +0000
Message-ID: <20151120194651.GC21488@serenity.lan>
References: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
 <20151120111848.GC11198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 20:47:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzreF-0000JT-Cr
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 20:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163246AbbKTTrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 14:47:02 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:52424 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162654AbbKTTrB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 14:47:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 1A0DFCDA55D;
	Fri, 20 Nov 2015 19:47:00 +0000 (GMT)
X-Quarantine-ID: <OQ+AjVnb32-A>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OQ+AjVnb32-A; Fri, 20 Nov 2015 19:46:59 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 866F2CDA510;
	Fri, 20 Nov 2015 19:46:53 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20151120111848.GC11198@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281528>

On Fri, Nov 20, 2015 at 06:18:48AM -0500, Jeff King wrote:
> On Tue, Nov 17, 2015 at 10:12:07PM +0000, John Keeping wrote:
> 
> > If the CA path isn't found it's most likely to indicate a
> > misconfiguration, in which case accepting any certificate is unlikely to
> > be the correct thing to do.
> 
> Yeah, this seems like a crazy default for security-sensitive code.
> 
> I suspect some people will see breakage from applying this (because
> their systems are broken and they did not know it), but that is a good
> thing.
> 
> For people who know their systems are broken and want to proceed anyway,
> what is the appropriate work-around? Obviously it involves disabling
> peer verification, but would we want to include instructions for doing
> so (either in the error message, or perhaps mentioning it in the commit
> message)?

The documentation already says:

	Set it to an empty string to disable certificate verification.

It's a bit lost in the middle of a paragraph but I think that is the
best place for the detail of how to disable verification.

Having revisted the patch, I do think the message might be a bit terse,
but I can't think of a reasonably concise way to point at the
--smtp-ssl-cert-path argument as being the culprit.

Maybe we shouldn't worry too much about that, but should instead put the
invalid path into the error message:

	die "CA path \"$smtp_ssl_cert_path\" does not exist.";
