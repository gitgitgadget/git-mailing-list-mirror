From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: Re: Suggestion on hashing
Date: Sat, 03 Dec 2011 13:21:54 -0800
Message-ID: <1322947314.1763.41.camel@yos>
References: <1322813319.4340.109.camel@yos>
	 <20111202175444.GB24093@sigill.intra.peff.net>
	 <1322877021.1729.118.camel@yos>
	 <20111203150842.GA4442@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 03 22:23:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWx3D-0005Dr-AB
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 22:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab1LCVWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 16:22:01 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65023 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321Ab1LCVWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2011 16:22:00 -0500
Received: by iage36 with SMTP id e36so6154073iag.19
        for <git@vger.kernel.org>; Sat, 03 Dec 2011 13:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=kUh7MLx8FBLOwz1oxCsG5cWxJy2xobs6U7VlzbnDGrA=;
        b=Dh9at8+2uwNEqI39BxlIwZWIDjWkyq4OapwoV1W3V7yXGsjI8X9GsEZSOFfLgh+q0u
         TMMzaw62G859FxUHqwyMYoJOCZ2d0gIA8ok53pHEu6HSvvEfiOhW+FeFlVA1ZGY98pp4
         UR3Kk8rhnzpNQyM6Cls6yPBuAvpymNiNJsLjw=
Received: by 10.50.169.97 with SMTP id ad1mr4189341igc.35.1322947320210;
        Sat, 03 Dec 2011 13:22:00 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id eb23sm53087395ibb.2.2011.12.03.13.21.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Dec 2011 13:21:57 -0800 (PST)
In-Reply-To: <20111203150842.GA4442@sigill.intra.peff.net>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186261>

On Sat, 2011-12-03 at 10:08 -0500, Jeff King wrote:

> > 
> > Suppose I make the digest pluggable, something I intended to do
> > eventually anyway?  Then you just use the existing SHA-1 as an
> > object identifier and the new digest in a signature chain?  What I
> > did was essentially to compute the new digest (using a CRC as the
> > trivial case) whenever an object's SHA-1 hash is computed, plus
> > using the new digest for low-cost collision checks.
> 
> If you make the digest stronger (or pluggable) and include it in the
> actual objects themselves, then you have a start on (2).
> 
> I'd drop all of the digest-exchange bits from the protocol, as the
> actual signatures are the real, trustable verification. I don't think
> you can drop the external storage of the digests, which is one of the
> ugliest bits. You'll be asking for the digests all the time to create
> new commit objects, so you need to have it at hand without rehashing.

The digest-exchange bits, including the tests and response to errors,
is only 222 lines of new code, so its really a minor part.  The rest
takes care of what you referred to as "one of the ugliest bits," so
I think it is useful to have available - you can then try various ways
of improving the authentication of commit objects without having to do
a lot of initial work.

I can make those changes - probably over the next couple of weeks or
so (have some other non-related things to take care of) and then send
a new set of patches.

> 
> And I wouldn't get my hopes up that this will go into git any time soon.
> At this point, we're really guessing about how broken SHA-1 will be in
> the future, and how much we are going to want to care.
> 
> Just my two cents.

Thanks for the discussion.  I might add that it is not just a question
of how broken SHA-1 is.  If an IT department is considering adopting Git
as the company's revision control system and authentication is important
to the company, an IT manager may not accept SHA-1 for authentication
purposes because NIST claims SHA-1 is not adequate for authentication in
general and explaining to upper management why NIST's statement is not
applicable given the way SHA-1 is used in Git is much harder than
saying, "Git follows the current best practices regarding
authentication."  That statement is a simple check-list item one can
show upper management in comparing alternatives.

Such issues (making technical choices for non-technical reasons) have
come up before - I once worked on a high-speed (for the time) networking
project and our manager mentioned that transferring medical records such
as X-ray pictures was one application - they do not accept lossy data
compression because, even if it is completely adequate, in a malpractice
suit, the plaintiff's lawyer would say, "And they purposely threw away
data critical to my client's health," which would sound pretty damning
to a typical jury.  The legal risk outweighed the cost of the additional
bandwidth.
