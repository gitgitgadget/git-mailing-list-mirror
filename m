From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not
 match calling host
Date: Sun, 14 Mar 2010 04:55:44 -0700
Message-ID: <7vljdvp16n.fsf@alter.siamese.dyndns.org>
References: <4B97C157.4020806@gmail.com>
 <20100311081213.GA13575@sigill.intra.peff.net>
 <20100311083148.GA13786@sigill.intra.peff.net>
 <7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
 <7vy6hxnnfx.fsf@alter.siamese.dyndns.org> <87bpesi0om.fsf_-_@jondo.cante.net>
 <7vfx433l9x.fsf@alter.siamese.dyndns.org> <87eijng4hy.fsf@jondo.cante.net>
 <7vtysjs9hi.fsf@alter.siamese.dyndns.org> <878w9vdx01.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Mar 14 12:56:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqmQJ-0008Pc-91
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 12:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758129Ab0CNLzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 07:55:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571Ab0CNLzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 07:55:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C558A2980;
	Sun, 14 Mar 2010 07:55:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YI5ORjBlvKAF0JADBE72BBWPjgY=; b=Y99seG
	6pgwsZoVOmXXcun5CEw7BRCnvofSFvahKFxEJhZpP6Eu/O3AMOlWK0CAKLzAqlkU
	afqpMiOhwe87lZKwkQWfA5MjH7pM9zw2q7q7qaTELGQVO/X1eu6G3+3jqNcQ3KIm
	q0qtYoZHCiMftcz4P0JL7DaaoD+Kp7q+RTKRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qdhgPbOrqucAYCbpwVpxhGTIlBW3+5Sn
	zykdKZbjS2E7W5uasUHdLYlcOMyhCrPNtb41OVnLQJFwSJnbNhNgANB9MFwnO5Wt
	LLubdC6YYdIlw2sj9Na0+R474jSyuW3NcAR3LhYlw55u8MCoigAnNyWw9IMQWIwZ
	w0rhgw42pmY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33BDDA297E;
	Sun, 14 Mar 2010 07:55:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A465A297D; Sun, 14 Mar
 2010 07:55:46 -0400 (EDT)
In-Reply-To: <878w9vdx01.fsf@jondo.cante.net> (Jari Aalto's message of "Sun\,
 14 Mar 2010 12\:21\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 88204C36-2F60-11DF-909B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142133>

Jari Aalto <jari.aalto@cante.net> writes:

> +sub maildomain_net
> +{
> +	my $maildomain;
> +	eval "use Net::Domain";
> +
> +	unless ($@) {
> +		eval "use Net::Domain";
> +		unless ($@) {

Sorry, but I don't understand the reason why you need to check the same
thing twice.  The original you borrowed from seems to be much cleanly
written; it essentially boils down to:

    if (eval "require Net::Domain") {
        my $domain = Net::Domain::Domainname();
        ...
    }

without need for separate "unless ($@)", nor doubly nested construct.

> +{
> +    my $mail_domain_system;		# Static variable

This, and ...


> @@ -917,6 +988,8 @@ X-Mailer: git-send-email $gitversion
>  		}
>  	}
>  
> +	my $maildomain;
> +

... this, I still don't see the point of them.

> @@ -962,9 +1040,10 @@ X-Mailer: git-send-email $gitversion
>  		}
>  
>  		if (!$smtp) {
> -			die "Unable to initialize SMTP properly. Check config. ",
> +			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
>  			    "VALUES: server=$smtp_server ",
>  			    "encryption=$smtp_encryption ",
> +			    "maildomain=$maildomain",

You said you needed a separate local variable for reporting but that
doesn't explain why you need three redundant variables.  Why can't the
code look like this?

-- >8 -- snip -- >8 --
my $mail_domain; # toplevel global

GetOptions(...,
           "smtp-domain=s" => \$mail_domain,
           ...);

sub maildomain {
	maindomain_net() || maildomain_mta() || "localhost.localdomain";
}

sub send_message {
	...
        $mail_domain ||= maildomain();
        if (ssl) {
        	$smtp ||= Net::SMTP::SSL->new(...);
	} else {
        	$smtp || Net::SMTL->new(...);
	}
	...
        if (!$smtp) {
        	die "Unable to... your maildomain is set to $mail_domain";
	}
}
-- 8< -- snap -- 8< --

That is:

 - $mail_domain can be set from the command line;
 - once set, ||= ensures that it will we used without needing to
   call maildomain();
 - the value you used unsuccessfully to obtain $smtp is reported.

which seems to be more in line with the way how existing code avoids
resetting $smtp once it gets a working one.
