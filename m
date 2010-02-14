From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Die if there are parsing errors in config file
Date: Sun, 14 Feb 2010 13:17:13 -0800
Message-ID: <7v8wava55y.fsf@alter.siamese.dyndns.org>
References: <20100207093744.29846.6468.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 22:17:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NglqJ-0001i3-Vm
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 22:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab0BNVRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 16:17:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab0BNVRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 16:17:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B6A989AA75;
	Sun, 14 Feb 2010 16:17:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=phCubagnwr59kvDpf+UUCVT+tYY=; b=lzDYZa
	xYMht0URqmO9LTMHdBt5VyWxHERuy73x3mX5LfcMPlPha/VTkQBiiuDugmgsJ2Z4
	5eg/fpg4cufpMKIAezwQBi3VRV1GS7yTPmJ6ks6qEqkttWzz3z/tpNvrSVK07fvR
	8Q80swQsjkI8Nets4YFTsDap39M0inRtDJRug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mye/1cytlJWZbR0tup3NG3MlvdW4HKI6
	HZB6A2q0uBEmuzSXrwyMkDyO2aTwTh3yeD1ZYvV/tCKUJQryD5KXh49SMfsYJtmS
	nLQwXbE8PRsEiQaa9xyjShQoU1pkxXOI3WDsUOYCHhNa3pYY2cVQ8XY6jSU/L+5i
	DYW8zz0yEUM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 94F659AA74;
	Sun, 14 Feb 2010 16:17:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E519C9AA73; Sun, 14 Feb
 2010 16:17:14 -0500 (EST)
In-Reply-To: <20100207093744.29846.6468.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Sun\, 07 Feb 2010 10\:40\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 546C76D4-19AE-11DF-8BF8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139937>

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1f6978a..a5bc359 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -556,6 +556,8 @@ if (-e $GITWEB_CONFIG) {
>  	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
>  	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
>  }
> +# die if there are errors parsing config file
> +die $@ if $@;

I cannot figure out $@ from which command this if statement modifier is
checking when none of GITWEB_CONFIG or GITWEB_CONFIG_SYSTEM candidates is
present.  Neither of the "do" executes in such a case.  Do you end up
checking the result from the very first eval that checks if Time::HiRes
can be "require"d successfully?
