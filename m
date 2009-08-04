From: Junio C Hamano <gitster@pobox.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Tue, 04 Aug 2009 13:41:06 -0700
Message-ID: <7vljlzjorh.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0908032326440.3270@localhost.localdomain>
 <20090804080147.15201.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@linux-foundation.org, git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 22:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYQrK-0007UN-3N
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 22:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbZHDUlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 16:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932856AbZHDUlO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 16:41:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932774AbZHDUlL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 16:41:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9ED4620415;
	Tue,  4 Aug 2009 16:41:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E941C2040F; Tue, 
 4 Aug 2009 16:41:07 -0400 (EDT)
In-Reply-To: <20090804080147.15201.qmail@science.horizon.com> (George
 Spelvin's message of "4 Aug 2009 04\:01\:47 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 25488F74-8137-11DE-9DDB-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124806>

"George Spelvin" <linux@horizon.com> writes:

> The one question I have is that currently perl is not a critical
> compile-time dependency; it's needed for some extra stuff, but AFAIK you
> can get most of git working without it.  Whether to add that dependency
> or what is a Junio question.

I am actually feel a lot more uneasy to apply a patch signed of by
somebody who calls himself George Spelvin, though.

Three classes of people compile git from the source:

 * People who want to be on the bleeding edge and compile git for
   themselves, even though they are on mainstream platforms where they
   could choose distro-packaged one;

 * People who produce binary packages for distribution.

 * People who are on minority platforms and have no other way to get git
   than compiling for themselves;

We do not have to worry about the first two groups of people.  It won't
be too involved for them to install Perl on their system; after all they
are already coping with asciidoc and xmlto ;-)

We can continue shipping mozilla one to help the last group.

In the Makefile, we say:

    # Define NO_OPENSSL environment variable if you do not have OpenSSL.
    # This also implies MOZILLA_SHA1.

and with your change, we would start implying STANDALONE_OPENSSL_SHA1
instead.  But if MOZILLA_SHA1 was given explicitly, we could use that.

If they really really really want the extra performance out of statically
linked OpenSSL derivative, they could prepare a preprocessed assmebly on
some other machine and use it as the last resort if they do not have/want
Perl.  The situation is exactly the same as the documentation set.  They
are using HTML/man prepared on another machine (namely, mine) as the last
resort if they do not have/want AsciiDoc toolchain.
