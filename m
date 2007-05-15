From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add an option to git-ls-tree to display also the size of object
Date: Wed, 16 May 2007 01:19:10 +0200
Message-ID: <200705160119.10802.jnareb@gmail.com>
References: <11792246701367-git-send-email-jnareb@gmail.com> <7vy7jpj4lr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 01:19:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho6Ih-00027p-Q5
	for gcvg-git@gmane.org; Wed, 16 May 2007 01:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbXEOXTP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 19:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756431AbXEOXTP
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 19:19:15 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:51111 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880AbXEOXTP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 19:19:15 -0400
Received: by ik-out-1112.google.com with SMTP id b35so1460319ika
        for <git@vger.kernel.org>; Tue, 15 May 2007 16:19:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QDDCXOWjj9unQteMoMdLDYzXg3/s6F02/kcRXY4U4CzTdTapuOXD8wWaNNd2dcEBJz73vBWVTC67+FKq/NUSnTCAaYYDLZdnzhTEw9x2Cija7DQyLQ+G63dSQ7NqDX+93XDYs2gig92Y+uIt2Vjyi0rhzSKcFacqmVsYkFuRWt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bTVW0MLGIJTvB2TCs02CLGJ+r7+MDJaVfy+4Hni9N9q9GyoaapohCsoBtzjkzcVe89sVs9YBhOHsEuTopBj/ByuRrjfn2/Eftuqgbu+ALXfrv1LKeLqw4tKeW8R8CpAftju7KTXMIuU/koFvhPti+bvnOQZqAhvIcwp+abPbZ4w=
Received: by 10.65.222.11 with SMTP id z11mr2111116qbq.1179271153107;
        Tue, 15 May 2007 16:19:13 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id d12sm1241431qbc.2007.05.15.16.19.10;
        Tue, 15 May 2007 16:19:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy7jpj4lr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47384>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Add -l/--long/--size option to git-ls-tree command, which displays
> > object size of an entry after object id (left-justified with minimum
> > width of 7 characters).
> 
> Not a NAK at all (but not an ACK either yet), but just asking
> questions on some design considerations.

I guess I should use [PATCH/RFC] for this patch...

> * Do these options do different things?  If not, why have more
>   than one (or two, --long and its shorthand -l)?

The idea was to have output similar (if possible by git-ls-tree
machinery) to 'ls -l' output, hence -l/--long, but actually it is
about --size.

> * Why pad to 7 places?  Do we have a similar padding elsewhere?
>   Will this ever used by non-scripts?  How does this padding
>   affect parsers other than Perl that read this information?

Padding is added here to make output more human-readable. And I guess
padding of 7 places is default for 'ls -l'.

But certainly padding is not needed.

> * Does it make sense to show size information when giving a tree
>   entry?  I realize not having it in the output would make the
>   job of the script reading the output a bit harder, but if this
>   output is meant also for human consumption I think it would
>   not be so interesting and raise a confusion factor.

Giving tree size information is similar to 'ls -l giving size of
directory, and not total size taken by its contents. That would be
better left for git-ls-tree `--du' option :-)

>   Also I suspect that having to show the size of a tree object,
>   expressed in terms of the canonical representation, might
>   force packv4 aware ls-tree to convert its traversal efficient
>   representation to the canonical one only to get its size.

It still will be accessible, but perhaps it would be less efficient
with v4 pack. It is I think acceptable that -l needs more CPU (and I/O) 
time...

-- 
Jakub Narebski
Poland
