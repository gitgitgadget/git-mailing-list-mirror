From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] cvsimport: use show-ref to support packed refs
Date: Wed, 28 Nov 2007 19:16:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281916140.27959@racer.site>
References: <20071128185504.GA11236@coredump.intra.peff.net>
 <20071128185611.GB11320@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:17:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxSPB-00061M-Qo
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 20:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbXK1TQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 14:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755699AbXK1TQq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 14:16:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:57038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755914AbXK1TQp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 14:16:45 -0500
Received: (qmail invoked by alias); 28 Nov 2007 19:16:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 28 Nov 2007 20:16:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ih1hNK3wiO1qzHIy25ClqyhCF+IBQJ8vW+v2X3h
	jqJbZAg1KvcWSj
X-X-Sender: gene099@racer.site
In-Reply-To: <20071128185611.GB11320@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66413>

Hi,

On Wed, 28 Nov 2007, Jeff King wrote:

> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index efa6a0c..b852f2f 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -527,18 +527,12 @@ sub is_sha1 {
>  	return $s =~ /^[a-f0-9]{40}$/;
>  }
>  
> -sub get_headref ($$) {
> -    my $name    = shift;
> -    my $git_dir = shift;
> -
> -    my $f = "$git_dir/$remote/$name";
> -    if (open(my $fh, $f)) {
> -	    chomp(my $r = <$fh>);
> -	    is_sha1($r) or die "Cannot get head id for $name ($r): $!";
> -	    return $r;
> -    }
> -    die "unable to open $f: $!" unless $! == POSIX::ENOENT;
> -    return undef;
> +sub get_headref ($) {
> +	my $name = shift;
> +	my $r = `git show-ref -s '$name'`;
> +	return undef unless $? == 0;
> +	chomp $r;
> +	return $r;
>  }

Where has $remote gone?

Ciao,
Dscho
