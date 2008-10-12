From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Sat, 11 Oct 2008 22:24:44 -0700
Message-ID: <7vabdaidwj.fsf@gitster.siamese.dyndns.org>
References: <20081005214114.GA21875@coredump.intra.peff.net>
 <20081005214336.GC21925@coredump.intra.peff.net>
 <48EB7D74.40302@viscovery.net>
 <20081007153543.GA26531@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 12 07:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KotTq-0007kB-SI
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 07:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbYJLFY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 01:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbYJLFYz
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 01:24:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbYJLFYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 01:24:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E06656D27E;
	Sun, 12 Oct 2008 01:24:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CF7C86D27D; Sun, 12 Oct 2008 01:24:46 -0400 (EDT)
In-Reply-To: <20081007153543.GA26531@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 7 Oct 2008 11:35:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 19BA41AA-981E-11DD-87A1-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98001>

Jeff King <peff@peff.net> writes:

> Let's say I have a subdirectory of files, some of which are binary. But
> for those that _aren't_ binary, I want to use a particular funcname
> pattern. So I do this:
>
>   echo '* diff=foo' >subdir/.gitattributes
>   git config diff.foo.funcname some-regex
> ...
> In practice, this doesn't happen much, because funcname tends to follow
> the file extension, as does binary-ness.

I find this a highly contrived example.  Is this ever be useful in
practice?

>> The reason why I'd like to understand the issue is because I like the
>> diff.foo.textconv that you introduce in patch 4/4, but I dislike that I
>> have to set diff.foo.binary to false in order to use the textconv. So, why
>> is this .binary needed?
>
> I think this .binary is something we can and should get rid of; as it
> stands now, you always end up having to set it along with .textconv. I
> have considered two ways:

The logic behind the original behaviour was that the file ought to be
"diff-able" if you are setting up funcname pattern because the funcname
pattern only makes sense if you are doing the textual diff.  In other
words, "should we do textual diff?" and "what funcname pattern should we
use?" are _not_ orthogonal, as wanting to configure the latter does imply
that you do want to see the change in the textual diff format.

For the same rationale, if you have .textconv, I think it is natural for
us to say that you do want to see the change in the textual diff format.
So I'd agree that you can get rid of this .binary business by saying that
having .textconv marks it diffable (IOW, I think your first alternative
makes more sense).
