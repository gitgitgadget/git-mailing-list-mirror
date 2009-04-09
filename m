From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Thu, 09 Apr 2009 12:28:34 -0700
Message-ID: <7vskkh1va5.fsf@gitster.siamese.dyndns.org>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
 <20090409081443.GB17221@coredump.intra.peff.net>
 <alpine.LFD.2.00.0904091342170.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Michael Witten <mfwitten@gmail.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 09 21:30:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrzxC-0007kn-8v
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 21:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935148AbZDIT2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 15:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934873AbZDIT2q
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 15:28:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934073AbZDIT2q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 15:28:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 76359A9AB8;
	Thu,  9 Apr 2009 15:28:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 72B3CA9AB3; Thu,
  9 Apr 2009 15:28:36 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0904091342170.6741@xanadu.home> (Nicolas
 Pitre's message of "Thu, 09 Apr 2009 13:48:23 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A33BD6A4-253C-11DE-9AC4-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116200>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 9 Apr 2009, Jeff King wrote:
>
>> On Wed, Apr 08, 2009 at 09:25:25AM -0500, Michael Witten wrote:
>> 
>> > Firstly, I presume that someone is electing to use this option, so it is
>> > almost by definition not annoying for that person.
>> 
>> Sure, obviously only people who enable it will be affected. I was
>> thinking of it more in terms of group economics: how many people _will_
>> enable it, because they think the payoff outweighs the annoyance.
>
> My ISP doesn't allow me to send more than 20 emails at once.

Hmm, I first thought you meant 20 emails in a single smtp session, but it
appears that we create a new instance of Net::SMTP for each piece of email
so it really sounds like it is time based (N pieces of e-mail within M
minutes).

Perhaps --pause=N,M to say "Pause N seconds for every M messages", where
Michael's --delay=N is just a shorthand for --pause=N,1 is what you want?
That is, reset the counter to 0 at the beginning, increment it after
sending each message, and when the counter is M and if you have more to
send, you wait for N seconds and reset the counter to 0.  Then when you
have a series smaller than 20 you won't have to suffer from any artificial
delay.
