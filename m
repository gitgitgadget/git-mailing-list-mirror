From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Tue, 06 Jun 2006 12:05:42 -0400
Message-ID: <200606061605.k56G5gHo006581@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 18:06:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fne4M-0003Cy-52
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 18:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWFFQGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 12:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWFFQGK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 12:06:10 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:34200 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750939AbWFFQGJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 12:06:09 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k56G5hsN023119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Jun 2006 12:05:46 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k56G5gHo006581;
	Tue, 6 Jun 2006 12:05:42 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Tue, 06 Jun 2006 08:54:17 MST." <7vpshmth3q.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 06 Jun 2006 12:05:46 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21384>

Junio C Hamano <junkio@cox.net> wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> writes:
> 
> >> diff --git a/git-send-email.perl b/git-send-email.perl
> >> index a7a7797..700d0c3 100755
> >> --- a/git-send-email.perl
> >> +++ b/git-send-email.perl
> >> @@ -312,16 +312,18 @@ our ($message_id, $cc, %mail, $subject, 
> >>  
> >>  sub extract_valid_address {
> >>  	my $address = shift;
> >> +	my $local_part_regexp = '[^<>"\s@]+';
> >> +	my $domain_regexp = '[^.<>"\s@]+\.[^<>"\s@]+';
> >
> > This forces a '.' in the domain, while vonbrand@localhost is perfectly
> > reasonable. Plus it doesn't disallow adyacent '.'s. What about:
> >
> >         my $domain_regexp = '[^.<>"\s@]+(\.[^<>"\s@]+)*';
> >
> > (but this is probably nitpicking...)
> 
> I do not have preference either way about allowing an address
> like tld-administrator@net myself, but Email::Valid->address
> does not seem to allow it, and I just copied that behaviour for
> consistency between two alternative implementations.

Reasonable.

> I think you meant to say:
> 
> >         my $domain_regexp = '[^.<>"\s@]+(\.[^.<>"\s@]+)*';
> 
> (i.e. exclude dot from the latter character class),

Right, my bad.

>                                                     but I am
> inclined to do this instead:
> 
> 	my $domain_regexp = '[^.<>"\s@]+(?:\.[^.<>"\s@]+)+';
> 
> (i.e. still require at least two levels).

OK, but be careful as this (?:...) is an extended regexp (needs /x on
match). I'd just leave it plain (the performance impact shouldn't be
noticeable). I don't see any use except for $1, so the extra parenthesis
should be safe.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
