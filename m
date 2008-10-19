From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-opt: migrate builtin-checkout-index.
Date: Sun, 19 Oct 2008 13:59:05 -0700
Message-ID: <7v4p387146.fsf@gitster.siamese.dyndns.org>
References: <1224441040-5071-1-git-send-email-vmiklos@frugalware.org>
 <7vabd073bg.fsf@gitster.siamese.dyndns.org>
 <20081019201934.GO16610@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:45:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrfO7-0001nq-Pf
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 23:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbYJSU7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 16:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbYJSU7T
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 16:59:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbYJSU7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 16:59:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52D6671F2B;
	Sun, 19 Oct 2008 16:59:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0304571F2A; Sun, 19 Oct 2008 16:59:12 -0400 (EDT)
In-Reply-To: <20081019201934.GO16610@artemis.corp> (Pierre Habouzit's message
 of "Sun, 19 Oct 2008 22:19:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CB05A87A-9E20-11DD-90F6-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98637>

Pierre Habouzit <madcoder@debian.org> writes:

> On Sun, Oct 19, 2008 at 08:11:31PM +0000, Junio C Hamano wrote:
>> Miklos Vajna <vmiklos@frugalware.org> writes:
>
>> >> Right, I fixed this in option_parse_z(). --no-z should set
>> >> line_termination to \n instead of 1.
>> >
>> > Originally in option_parse_z() I had
>> >
>> >         line_termination = unset;
>> >
>> > which is in fact right, because (as Pierre pointed out) unset for short
>> > options are always false, but I changed it to
>> >
>> >         line_termination = 0;
>> >
>> > to make it more readable.
>> 
>> I think Pierre's comment is short-sighted.  Think of what would happen
>> when somebody adds "--nul" as a longer equivalent to "-z", since it is
>> extremely easy to do things like that with the use of parse-opt API?
>
> Err I was only pointing out that --no-z would no nothing, I actually
> didn't really read the argument :)  I didn't say having --null was a bad
> idea,...

It is a good practice to anticipate potential future breakages, assess the
cost to avoid them, avoid the ones that can be avoided with minimum cost
(and document the others you know will be broken).  That's the key to
produce maintainable piece of code.  The change necessary to Miklos's
original code to do this is quite simple (i.e. flip between '\0' and
'\n'), and I didn't see any room for argument like "short option won't let
you say --no-z".  That's where my comment about "short-sighted"-ness comes
from.
