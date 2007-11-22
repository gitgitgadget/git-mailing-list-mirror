From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Authenticate only once in git-send-email
Date: Thu, 22 Nov 2007 00:48:53 -0800
Message-ID: <7vwssa7jii.fsf@gitster.siamese.dyndns.org>
References: <1195648505-21653-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 09:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv7kL-0003ak-UW
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 09:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbXKVIs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 03:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbXKVIs7
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 03:48:59 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36491 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbXKVIs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 03:48:58 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 558472EF;
	Thu, 22 Nov 2007 03:49:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D1E2F95534;
	Thu, 22 Nov 2007 03:49:16 -0500 (EST)
In-Reply-To: <1195648505-21653-1-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Wed, 21 Nov 2007 13:35:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65757>

Wincent Colaiuta <win@wincent.com> writes:

> This commit teaches git-send-email to authenticate once and only once at
> the beginning of the series.

Ok.  What does $smtp->auth() return?  Presumably a true value,
but I do not find it the best coding style to hide a call made
primarily for its effects not for its return value behind a
conditional assignment to a boolean.  Eek.

>  		if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
> -			$smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
> +			$auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
>  		}

Perhaps something along the lines of...

>  		if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
> 			$smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
> +			undef $smtp_authpass;
>  		}

... or using a separate boolean variable "my $auth_happened"
may be more appropriate.

But I am just saying this; I do not care _too_ deeply about it.
Will apply as-is.
 
