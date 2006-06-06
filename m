From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cleanup git-send-email.perl:extract_valid_email
Date: Tue, 06 Jun 2006 08:54:17 -0700
Message-ID: <7vpshmth3q.fsf@assigned-by-dhcp.cox.net>
References: <junkio@cox.net>
	<200606061542.k56Fg9Cm006226@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 17:54:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fndsz-0000gW-E5
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 17:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWFFPy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 11:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWFFPy0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 11:54:26 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58293 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751334AbWFFPyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 11:54:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606155420.TOHY15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 11:54:20 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200606061542.k56Fg9Cm006226@laptop11.inf.utfsm.cl> (Horst von
	Brand's message of "Tue, 06 Jun 2006 11:42:09 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21383>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index a7a7797..700d0c3 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -312,16 +312,18 @@ our ($message_id, $cc, %mail, $subject, 
>>  
>>  sub extract_valid_address {
>>  	my $address = shift;
>> +	my $local_part_regexp = '[^<>"\s@]+';
>> +	my $domain_regexp = '[^.<>"\s@]+\.[^<>"\s@]+';
>
> This forces a '.' in the domain, while vonbrand@localhost is perfectly
> reasonable. Plus it doesn't disallow adyacent '.'s. What about:
>
>         my $domain_regexp = '[^.<>"\s@]+(\.[^<>"\s@]+)*';
>
> (but this is probably nitpicking...)

I do not have preference either way about allowing an address
like tld-administrator@net myself, but Email::Valid->address
does not seem to allow it, and I just copied that behaviour for
consistency between two alternative implementations.

I think you meant to say:

>         my $domain_regexp = '[^.<>"\s@]+(\.[^.<>"\s@]+)*';

(i.e. exclude dot from the latter character class), but I am
inclined to do this instead:

	my $domain_regexp = '[^.<>"\s@]+(?:\.[^.<>"\s@]+)+';

(i.e. still require at least two levels).
