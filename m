From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Enable transparent compression form HTTP output
Date: Sun, 26 Aug 2007 00:09:29 +0200
Message-ID: <200708260009.30092.jnareb@gmail.com>
References: <513314.51284.qm@web31813.mail.mud.yahoo.com> <200707252039.44312.jnareb@gmail.com> <20070825180350.GA1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Aug 26 00:09:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP3p9-0007Bi-RL
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 00:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbXHYWJl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 18:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbXHYWJl
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 18:09:41 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:43108 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbXHYWJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 18:09:40 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1640131mue
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 15:09:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DDKG1Q62FbiuFl5GhC3DetNLLyKlVu4NaGch2GtZisV1vuTALytcYJT51HGplgWCZoTRrQG7C0DmvavpAD3rkLHv9OWZ1VZeFv+qpEkOaXGxp3vNfA4SOoositKDzpJmDm+904x/FLu3BplyoBANOqAWshQgKPHB0kn9qYseDsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=s35Ux2SESdYqjpUwA28zS9Ey+UxYiC1Y56sc2y3+dpePiNPneotpYE2InlfzKCYT1noo81HUV4GiJASvaULXR6yNKJBMnAzgSiZpoBXuclNhKi/EVF2Lg4b8hOalU3sS8izi+GXdgQSB5qdiFV4zD6KMpKTuIDldgjvNMTtNuLY=
Received: by 10.86.93.17 with SMTP id q17mr3472305fgb.1188079778787;
        Sat, 25 Aug 2007 15:09:38 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id k29sm9535480fkk.2007.08.25.15.09.28
        (version=SSLv3 cipher=OTHER);
        Sat, 25 Aug 2007 15:09:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070825180350.GA1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56653>

On Sat, Aug 25, 2007, Petr Baudis wrote:
> On Wed, Jul 25, 2007 at 08:39:43PM CEST, Jakub Narebski wrote:

>> Check if PerlIO::gzip is available, and if it is make it possible to
> 
> It doesn't really check if the require succeeded. Either the description
> or (preferrably, but not a showstopper, IMO) the code should be
> adjusted.

It does not check if require succeeded (I could do that this way),
but instead checks if $PerlIO::gzip::VERSION is defined (if it is true).

our $enable_transparent_compression = !! $PerlIO::gzip::VERSION;
 
>> enable (via 'compression' %feature) transparent compression of HTML
>> output.  Error messages and any non-HTML output are excluded from
>> transparent compression.
>> 
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> 
> Acked-by: Petr Baudis <pasky@suse.cz>

By the way, this was more "proof of concept" than solution of an itch.
 
> I'd put it on repo.or.cz... too bad that there I value CPU much more
> than the bandwidth. ;-)
> 
> Why did you exclude non-HTML output from transparent compression? Me and
> I guess other people too sometimes download rather large chunks of raw
> data over gitweb.

Because it was easiest. We have single point of entry for HTML output
(the git_header_html subroutine), but we don't have anything similar for
non-HTML output. And we most certainly wouldn't want to enable transparent
compression for snapshots and 'blob_plain' view for compressed files,
including png, gif, jpeg, zip, mp3, ogg,...

-- 
Jakub Narebski
Poland
