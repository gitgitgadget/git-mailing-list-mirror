From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 15:14:50 -0800
Message-ID: <7vocx7i6xh.fsf@gitster.siamese.dyndns.org>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com>
 <20090212084811.GA14261@piper.oerlikon.madduck.net>
 <20090212092558.GB21074@skywalker>
 <20090212125621.GB5397@sigill.intra.peff.net>
 <7veiy3l689.fsf@gitster.siamese.dyndns.org>
 <20090212214106.GC26573@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org,
	pasky@suse.cz
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXknL-0006pT-V6
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759062AbZBLXPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755632AbZBLXPE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:15:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35375 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756773AbZBLXPC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:15:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F17CD99ACB;
	Thu, 12 Feb 2009 18:15:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BE1BA99AC7; Thu,
 12 Feb 2009 18:14:52 -0500 (EST)
In-Reply-To: <20090212214106.GC26573@piper.oerlikon.madduck.net> (martin f.
 krafft's message of "Thu, 12 Feb 2009 22:41:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F8ED54F0-F95A-11DD-8520-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109679>

martin f krafft <madduck@debian.org> writes:

> TopGit would need to make
> a proper branch, merge the bases into it, merge that branch into the
> topic branch, and the probably delete the branch pointer, as it's no
> longer needed and would only pollute the refs/heads/* namespace.

So it happens purely inside TopGit and the end user never sees a state
that HEAD points outside refs/heads/, right?

Why can't the base flipping operation you descibed be done on detached
HEAD?  Perhaps with a shell variable or two that hold commit object names
you need to keep track of while it is doing is work?

> Point being: I understand the reason behind the restriction, and
> I wouldn't mind if it were default, but maybe there could be
> a controlled way to circumvent it for cases like the one described
> above, where it is safe to assume that the user^W^W the tool "knows"
> what it is doing.

Sure, the tool would know what it is doing, I wouldn't doubt that.

But the end users don't.  If TopGit dies (or killed) during the base
flipping operation, doesn't the end user left in a funny state (granted, a
detached HEAD is also a funny state, but it is already a known funny state
they are familiar with.  HEAD that is a symref but points outside
refs/heads/ is a lot funnier).

You did not actually answer a larger question.  What other undocumented
features/restrictions does the code depend on, that tightening them to
help normal git users inadvertently may cause breakages similar to this
one in TopGit?
