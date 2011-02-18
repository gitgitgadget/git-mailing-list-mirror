From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Move libgit.a sources into a libgit/ subdirectory
Date: Thu, 17 Feb 2011 23:58:49 -0600
Message-ID: <20110218055849.GK15643@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <20110218023126.GB23435@elie>
 <AANLkTikFLkXKKhZoDGAgh+i8H2fv+QNEVj7vEVABxee2@mail.gmail.com>
 <20110218041358.GB15643@elie>
 <20110218041840.GB12348@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 06:59:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqJMp-0007Ib-O9
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 06:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640Ab1BRF6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 00:58:55 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34400 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab1BRF6y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 00:58:54 -0500
Received: by iwn9 with SMTP id 9so3296863iwn.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 21:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+U7OTqtoo4DBjm3n7ObzDwiEHYBVHI/+xwavgZYansI=;
        b=rA3gWl46pv4bWgnZzIOqYdP+uZ7vlyfnDHwDol+QxEHeZTZX3hNTrzO8P16gmt24Yz
         M43/ugbhXazC8FnSeP7FP1UvZuFOboEnFPEYrfoX/Rzp++2DU7zIHV7mbtlWpLjUQr4U
         Fd2IXD63NgCHd2QnVQnqPiS1qYK0kr3tdM69k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=M+qgSTbJhLzaaF8L6j2InWZvm2uTVvWovbj0vRv4jfDzZBqOjxnvKuhzHRGh74UZJB
         h8YiLaLLT3JCNkVdzXwIco6G4evA5O6ZXbwmRvsics69Xd5upAjidf1HxczgmlrYYpTh
         f3T5tE7pPewEB05CGn8r/YIHOKJ4O3F5afJxo=
Received: by 10.42.7.209 with SMTP id f17mr442546icf.67.1298008733814;
        Thu, 17 Feb 2011 21:58:53 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.sbcglobal.net [69.209.72.148])
        by mx.google.com with ESMTPS id u9sm1402451ibe.14.2011.02.17.21.58.52
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 21:58:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110218041840.GB12348@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167175>

Jeff King wrote:

> I wonder if there should perhaps be lib/, with all of the libgit.a
> sources in it, and then lib/block-sha1, lib/ppc, lib/compat, etc. Those
> things do end up inside libgit.a, don't they?

Hmph.  Let's see:

 - our xdiff changes ought to move upstream so other projects can
   use them.  That is, xdiff ought to be installable as a shared
   library.  So maybe that can stay out of libgit/.

 - block-sha1/ and ppc/ are just alternatives to openssl sha1, which
   can be installed as a system library.  Maybe keeping block-sha1
   out of libgit/ would provide an incentive to make block-sha1 usable
   as a system library for other projects to try out, too.

 - most of compat/ is needed if Windows and old Unixen are to be able
   to build libgit/.  So it probably should be part of libgit.

 - compat/bswap.h is needed for libgit.

 - compat/strlcpy.c is part of libbsd, so if such dependencies are ok
   it could stay out.

I really didn't want too many extra levels of hierarchy, so except for
bswap.h I think this is okay for until libgit grows a Makefile.  I
might be overlooking some glibc-only functions, though.
