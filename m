From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Tue, 02 Dec 2008 13:55:22 -0800
Message-ID: <7v4p1mp7hx.fsf@gitster.siamese.dyndns.org>
References: <Message-ID:
 <cb7bb73a0811291731g7f8770f7p89e924c00d2ab004@mail.gmail.com>
 <cb7bb73a0811291731g7f8770f7p89e924c00d2ab004@mail.gmail.com>
 <1228008844-12506-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200812020253.09430.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 22:57:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7dEi-0004NR-8H
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 22:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbYLBVzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 16:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbYLBVzf
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 16:55:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbYLBVze (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 16:55:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B934F17F78;
	Tue,  2 Dec 2008 16:55:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4C0A717F77; Tue, 
 2 Dec 2008 16:55:23 -0500 (EST)
In-Reply-To: <200812020253.09430.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 2 Dec 2008 02:53:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F11AA4A8-C0BB-11DD-AA33-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102182>

Jakub Narebski <jnareb@gmail.com> writes:

> What I like about having all this, i.e. fix, futureproof and style
> correction in one single patch is the fact that fix doesn't introduce
> strange looking (gitweb_check_feature('bool_feat'))[0]... well, except
> encapsulated in a subroutine.
>
> From all possible splits of this feature into series of up to three
> patches I think I like the one with pure subroutine rename from *check*
> to *get* least...

Well, I have to say that you have a strange taste, sense of priorities,
and perhaps aversion to logical progression.  Let's explain one more
time.

The case we had at hand was that a callee has a less-than-ideal calling
convention that has caused a few bugs by callers because they did not
understand the calling convention.  You can argue it is not entirely
caller's fault that they failed to follow the calling convention, but the
fact remains that there are bugs taken as a whole.

First we fix the callers, because existing bugs get highest priority.
This is a pure bugfix patch that could even go to maintenance "bugfix
only" branch.

Then we fix the calling convention because we all know that the calling
convention was less-than-ideal.  A large part of the reason the calling
convention was confusing was because the wording "check" implied it was a
boolean function.  Logically, s/check/get/ would be a major part of fixing
that.

After calling convention is enhanced by a new function that lets callers
"check" via a boolean function, we can have them use that, which makes
them easier to read.

But remember that it is the order I wanted the patches to be presented for
review.  After people involved in review agree that the result is good, I
do not have any problem in squashing the three steps into a single patch
for things like this after the end result is verified to be good (which we
did).
