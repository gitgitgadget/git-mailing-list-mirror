From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Fri, 23 Oct 2009 18:22:37 -0700
Message-ID: <7vbpjxa8ma.fsf@alter.siamese.dyndns.org>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <alpine.LNX.2.00.0910202044150.14365@iabervon.org> <20091021031528.GB18997@atjola.homenet> <200910211005.29053.trast@student.ethz.ch> <20091023025434.GA29908@sigio.peff.net> <alpine.LNX.2.00.0910222334040.14365@iabervon.org> <20091024004917.GA8012@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 24 03:23:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1VLQ-0007zi-Qd
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 03:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbZJXBWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 21:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbZJXBWt
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 21:22:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbZJXBWt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 21:22:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2715183D5D;
	Fri, 23 Oct 2009 21:22:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z0wewCI9vIPuKGqzAazD90eUq4g=; b=fqmjhW
	As7Lk2Rz+b4+76aQjFE0h+0wBUS4H8s60/nlC9P/7bosQQZzPZRlkA1St5j/ZyME
	esXGBIC4V7zmY8em71QPtO+loa0qK0Z5HMKAAUELHziyg7Azbdwn1xgkPNmebZOL
	0CD81T7HQ+fDq88GmUjfr6A6l3vAw6I3LEsPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S5fsYywawEjoevyG5AwCqxLphKJI9HUU
	KFgWPLHbeWEtLMA2fZpUuG0nqjNbXGB8NMmXnFwUHtFef6Cld85O/XEY903tBQ8t
	wtSByZDyFlPOWiSIjlwTCRlAR9bQP2xQXa6wWCCoNCMNACg69+i6LhuftDjAQ6CR
	O/z0q6LKT40=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC2F083D59;
	Fri, 23 Oct 2009 21:22:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D1A7B83D58; Fri, 23 Oct 2009
 21:22:38 -0400 (EDT)
In-Reply-To: <20091024004917.GA8012@sigio.peff.net> (Jeff King's message of
 "Fri\, 23 Oct 2009 20\:49\:18 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCA051A2-C03B-11DE-ADAD-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131140>

Jeff King <peff@peff.net> writes:

> Yeah, I think you are right. It _should_ be variable, but right now it
> varies on something totally unrelated to what you want (how you invoked,
> and not what type of repo setup you are using). So I agree a patch to
> make it more consistent across fetch+merge versus pull would be good,
> and then we can make a configuration option to choose one or the other.

I have been looong wondering why I somehow thught that I saw a patch that makes

    $ git merge origin/topic

pretend as if you did

    $ git pull origin topic

when you have this mapping

    [remote "origin"]
        fetch = refs/heads/*:refs/remotes/origin/*

in your configuration file, since it is a very obvious thing to do...
