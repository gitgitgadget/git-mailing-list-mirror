From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for 
 further processing
Date: Sun, 22 Jun 2008 18:45:11 -0700
Message-ID: <7vod5skjq0.fsf@gitster.siamese.dyndns.org>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com>
 <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com>
 <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org>
 <20080618033010.GA19657@sigill.intra.peff.net>
 <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
 <20080622170733.GA16252@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Bohrer <shawn.bohrer@gmail.com>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 03:46:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAb8U-0003tf-0q
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 03:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbYFWBp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 21:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYFWBp3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 21:45:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbYFWBp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 21:45:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3AF041F5C5;
	Sun, 22 Jun 2008 21:45:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 78E4E1F5C2; Sun, 22 Jun 2008 21:45:18 -0400 (EDT)
In-Reply-To: <20080622170733.GA16252@artemis.madism.org> (Pierre Habouzit's
 message of "Sun, 22 Jun 2008 19:07:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B8A1A42-40C6-11DD-A556-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85824>

Pierre Habouzit <madcoder@debian.org> writes:

> On Wed, Jun 18, 2008 at 05:13:02AM +0000, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > I think the only right way to accomplish this is to convert the revision
>> > and diff parameters into a parseopt-understandable format.
>> 
>> Not necessarily.  You could structure individual option parsers like how
>> diff option parsers are done.  You iterate over argv[], feed diff option
>> parser the current index into argv[] and ask if it is an option diff
>> understands, have diff eat the option (and possibly its parameter) to
>> advance the index, or allow diff option to say "I do not understand this",
>> and then handle it yourself or hand it to other parsers.
>
> If you do that, you need to relocate pars option structures,...
> ... Note that "recursing"
> is not really trivial, because with flags aggregation and stuff like
> that, things that look like an option can also be a value in the context
> of an other option parser.

Note that I was just saying "not necessarily" in response to "the only
right way" to point out it is not the _only_ way.

Parse-options has been done in a tablish way and it would involve cost to
modify it in a way I outlined (even if such a rewrite would make chaining
different set of option parsers easier, as each parser needs to handle
only what it knows about and handling aggregation and stuff would become
trivial).  I do not know if it is worth the cost, and I am not married to
the option parser structure that diff and revision part uses.
