From: Junio C Hamano <gitster@pobox.com>
Subject: John (zzz) Doe <john.doe@xz> (Comment)
Date: Sun, 18 Jan 2009 10:50:12 -0800
Message-ID: <7vmydoxxcr.fsf_-_@gitster.siamese.dyndns.org>
References: <7vmydu3yy7.fsf@gitster.siamese.dyndns.org>
 <20090115194926.GA6899@roro3.zxlink>
 <7vd4eos3rp.fsf@gitster.siamese.dyndns.org>
 <20090116080807.GA10792@landau.phys.spbu.ru>
 <7vd4enacf2.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901161253411.3586@pacific.mpi-cbg.de>
 <20090118145429.GA27522@roro3.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Sun Jan 18 19:51:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOckL-0002hf-Ka
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 19:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbZARSuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 13:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZARSuU
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 13:50:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbZARSuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 13:50:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 81C9B91651;
	Sun, 18 Jan 2009 13:50:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8181391650; Sun,
 18 Jan 2009 13:50:14 -0500 (EST)
In-Reply-To: <20090118145429.GA27522@roro3.zxlink> (Kirill Smelkov's message
 of "Sun, 18 Jan 2009 17:54:29 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D9EC981E-E590-11DD-88C5-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106257>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> On Fri, Jan 16, 2009 at 12:54:28PM +0100, Johannes Schindelin wrote:
> ...
>> > 	From: A U Thor (MonikeR) <a.u@thor.xz>
>> 
>> It is Philippe Bruhat (BooK), who sometimes forgets the closing 
>> parenthesis, and who is listed in .mailmap without the moniker.

It was not "forgets", but is an artifact that older mailinfo removed
parenthesis incorrectly (see below).

> So now I don't understand what to do.
>
> From one hand RFC822 says '(...)' is a comment, and from the other hand,
> we have a use case where one guy wants this to stay.
> ...
> commit 49bebfbe18dac296e5e246884bd98c1f90be9676
> Author: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> Date:   Tue Jan 13 01:21:04 2009 +0300
>
>     mailinfo: more smarter removal of rfc822 comments from 'From'
>     
>     As described in RFC822 (3.4.3 COMMENTS, and  A.1.4.), comments, as e.g.
>     
>         John (zzz) Doe <john.doe@xz> (Comment)
>     
>     should "NOT [be] included in the destination mailbox"

The above quote from the RFC is irrelevant.  Note that it is only about
how you extract the e-mail address, discarding everything else.

What mailinfo wants to do is to separate the human-readable name and the
e-mail address, and we want to use _both_ results from it.

We separate a few example From: lines like this:

	Kirill Smelkov <kirr@smelkov.xz>
==>	AUTHOR_EMAIL="kirr@smelkov.xz" AUTHOR_NAME="Kirill Smelkov"

	kirr@smelkov.xz (Kirill Smelkov)
==>	AUTHOR_EMAIL="kirr@smelkov.xz" AUTHOR_NAME="Kirill Smelkov"

Traditionally, the way people spelled their name on From: line has been
either one of the above form.  Typically comment form (i.e. the second
one) adds the name at the end, while "Name <addr>" form has the name at
the front.  But I do not think RFC requires that, primarily because it is
all about discarding non-address part to find the e-mail address aka
"destination mailbox".  It does not specify how humans should interpret
the human readable name and the comment.

Now, why is the name not AUTHOR_NAME="(Kirill Smelkov)" in the latter
form?

It is just common sense transformation.  Otherwise it looks simply ugly,
and it is obvious that the parentheses is not part of the name of the
person who used "kirr@smelkov.xz (Kirill Smelkov)" on his From: line.

So we can separate "John (zzz) Doe <john.doe@xz> (Comment)" into:

	AUTHOR_EMAIL=john.doe@xz
        AUTHOR_NAME="John (zzz) Doe (Comment)"

and leave it like so, I think.
