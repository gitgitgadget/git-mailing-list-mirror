From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] builtin-help: make it possible to exclude some
 commands in list_commands()
Date: Sun, 27 Jul 2008 20:05:19 -0700
Message-ID: <7vljzmwvww.fsf@gitster.siamese.dyndns.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
 <fd19583955e9cea5b78a465d23bc127a51940048.1217207602.git.vmiklos@frugalware.org> <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217207602.git.vmiklos@frugalware.org> <9cc2813166c8b20ffb411c3a28ad86665e60033b.1217207602.git.vmiklos@frugalware.org> <7vr69ex00x.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807280442330.5526@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 05:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNJ49-0002pr-Lm
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 05:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbYG1DF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 23:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbYG1DF1
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 23:05:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbYG1DF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 23:05:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 28BBE455F0;
	Sun, 27 Jul 2008 23:05:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 69ADA455EF; Sun, 27 Jul 2008 23:05:21 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807280442330.5526@eeepc-johanness> (Johannes
 Schindelin's message of "Mon, 28 Jul 2008 04:43:53 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 062B19B4-5C52-11DD-81A3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90397>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +struct cmdnames {
>> > +	int alloc;
>> > +	int cnt;
>> > +	struct cmdname {
>> > +		size_t len;
>> > +		char name[1];
>> > +	} **names;
>> > +};
>> 
>> I thought we do this kind of thing using FLEX_ARRAY macro.  Is there any
>> reason its use is not appropriate here?
>
> I think that came up in the previous review round: the "name" member _is_ 
> NUL-terminated, but could have a ".exe" suffix.  The "len" member has the 
> length excluding ".exe".

Sorry, but I do understand what you are trying to explain.

Marking the flexible member at the end as "last_member[FLEX_ARRAY]" is
about a tiny bit of abstracting out how the exact decl syntax should look
like depending on the compiler.

For example, we have:

        struct git_attr {
                struct git_attr *next;
                unsigned h;
                int attr_nr;
                char name[FLEX_ARRAY];
        };

And h is _not_ the length of the name[] (it is a hash to help us find the
entry quickly).  Jjust like "len" is not the length of the name[] in your
structure.  In other words, marking as "last_member[FLEX_ARRAY]" does not
have anything to do with what other fields you have in the same structure.

Hmm, am I missing a bigger picture somewhere else?
