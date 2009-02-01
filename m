From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Sat, 31 Jan 2009 17:19:31 -0800
Message-ID: <7v7i4b2bto.fsf@gitster.siamese.dyndns.org>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
 <20090131071238.GC3033@coredump.intra.peff.net>
 <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
 <20090131215514.GB9415@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:21:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTR1d-0001GP-Vi
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbZBABTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbZBABTj
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:19:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbZBABTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:19:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DFF04957CB;
	Sat, 31 Jan 2009 20:19:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9EE7D957C9; Sat,
 31 Jan 2009 20:19:33 -0500 (EST)
In-Reply-To: <20090131215514.GB9415@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 31 Jan 2009 16:55:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6492A324-EFFE-11DD-92DE-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107959>

Jeff King <peff@peff.net> writes:

>   - without either, copy alternates from origin, but _don't_ use
>     alternates while cloning

Are you talking about a local clone optimization that does hardlink from
the source repository?

I am fairly certain that copying alternates from the source repository was
not an intended behaviour but was a consequence of lazy coding of how we
copy (or link) everything from it.  The original was literally the simple
matter of:

    find objects ! -type d -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/"

whose intention was to copy objects/?? and objects/pack/. and it wasn't
even part of the design consideration to worry about what would happen to
the alternates the source repository might have in objects/info/.
