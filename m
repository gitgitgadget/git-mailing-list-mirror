From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v7 6/9] gitweb/lib - Simple output capture by redirecting STDOUT to file
Date: Mon, 27 Dec 2010 00:03:22 +0100
Message-ID: <201012270003.23379.jnareb@gmail.com>
References: <20101222234843.7998.87068.stgit@localhost.localdomain> <20101222235705.7998.76695.stgit@localhost.localdomain> <20101224094934.GA952@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 27 00:03:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWzcn-0007Se-KK
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 00:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab0LZXDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 18:03:33 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62802 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab0LZXDc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 18:03:32 -0500
Received: by fxm20 with SMTP id 20so8816313fxm.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 15:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=m+RZjxgNVXc6j9WRj6Hhl4zWedKSUZUwTRH7amupsnw=;
        b=W02aQYM/KfnDH/4ZlIRNlMw6EtlvwswyDxAqFL7Y7gL8rj0e5M8z4LWEVl8ioo1Tan
         LxwtwPdToYOYvWaB1IbeQD62eEc2bvMCHsb0OKFPqJQ2BtsOkmx4BbMhHPPT7BvcMlBP
         DDJ82npkYxsV0BrcBKdB7jKc/5yRViOgaN9m4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OeThu9j8ZKuN4I+paDXxhf4sKDzyGBEv2e0M0bNoNbh6XAvAKfstvXi1hMENvvGyuX
         Y/8jEP9PwCasZ0bhQ+jHkJFiiElklmkLI9QdpZ9kXaW4h+FkBKa83DBZQJgA66ibasI+
         4rpcrf6LGbkNNs0ITKn/f79a6FF7qPmpHEw4g=
Received: by 10.223.114.65 with SMTP id d1mr2327901faq.36.1293404610460;
        Sun, 26 Dec 2010 15:03:30 -0800 (PST)
Received: from [192.168.1.13] (abwr69.neoplus.adsl.tpnet.pl [83.8.241.69])
        by mx.google.com with ESMTPS id l3sm1928440fan.2.2010.12.26.15.03.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 15:03:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101224094934.GA952@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164204>

On Fri, 24 Dec 2010, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > This patch was based on "gitweb: add output buffering and associated
> > functions" patch by John 'Warthog9' Hawley (J.H.) in "Gitweb caching v7"
> > series, and on code of Capture::Tiny by David Golden (Apache License 2.0).
> 
> Micronit: if the license of Capture::Tiny were relevant then we would be
> in trouble, I think.  (Apache-2.0 and GPLv2 aren't compatible licenses.)

Damn, I have thought that Apache-2.0 and GPLv2 are compatibile.  This is
the only reason that I explicitely mentioned the license (that and it is
not usual "licensed like Perl", i.e. dual Artistic Perl License / GPL 
licensed).  I should have checked that Apache and GPLv2 are compatibile.

> Luckily
> 
> [...]
> > +# taken from Capture::Tiny by David Golden, Apache License 2.0
> > +# with debugging stripped out
> > +sub _relayer {
> > +	my ($fh, $layers) = @_;
> > +
> > +	my %seen = ( unix => 1, perlio => 1); # filter these out
> > +	my @unique = grep { !$seen{$_}++ } @$layers;
> > +
> > +	binmode($fh, join(":", ":raw", @unique));
> > +}
> 
> looks trivial enough.  Maybe either avoiding mention of the license or
> clarifying that that is not intended to be the sole license for the
> stripped-down code would help?

You are right.  I have done similar thing for PerlIO::Util based capture,
though I didn't know about the 'binmode($fh, join(":", ":raw", @unique));'
trick.

So I think we would be in the clear by changing the comment to read:

  +# see also _relayer in Capture::Tiny by David Golden

or something like that.


Or we can try to change gitweb license to GPLv3 / AGPLv3, which is
compatibile (one way only) with Apache-2.0... just kidding :-)
-- 
Jakub Narebski
Poland
