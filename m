From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Mon, 13 Oct 2008 10:12:29 +0200
Message-ID: <vpqtzbggbgy.fsf@bauges.imag.fr>
References: <20081005214114.GA21875@coredump.intra.peff.net>
	<20081005214336.GC21925@coredump.intra.peff.net>
	<48EB7D74.40302@viscovery.net>
	<20081007153543.GA26531@coredump.intra.peff.net>
	<7vabdaidwj.fsf@gitster.siamese.dyndns.org>
	<20081013012311.GE3768@coredump.intra.peff.net>
	<7vk5cddtzh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 10:23:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpIi2-0005xg-PF
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 10:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbYJMIWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 04:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755513AbYJMIWJ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 04:22:09 -0400
Received: from imag.imag.fr ([129.88.30.1]:43034 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754710AbYJMIWG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 04:22:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m9D8Cuup009718
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 13 Oct 2008 10:12:57 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KpIXW-00073R-34; Mon, 13 Oct 2008 10:12:30 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KpIXW-0003tP-0S; Mon, 13 Oct 2008 10:12:30 +0200
In-Reply-To: <7vk5cddtzh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 12 Oct 2008 21\:00\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 13 Oct 2008 10:12:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98094>

Junio C Hamano <gitster@pobox.com> writes:

> The textconv filter is primarily for humans to be able to view the diff,
> as far as I understand it, but what would this facility do to the patch
> exchange workflow?  There needs either one or both of the following:
>
>  - A command line option to Porcelains to override textconv so that an
>    applicable binary diff can be obtained upon request (or format-patch
>    always disables textconv); and/or

To me (and others in this thread AIUI), the textconv should only
replace the (frustrating) "binary files differ" in porcelain.

>  - You teach git-apply to use a reverse transformation of textconv, so
>    that it does, upon reception of a textconv diff:
>
>    (1) pass existing preimage through textconv;
>    (2) apply the patch;
>    (3) convert the result back to binary.

I can imagine corner-case scenarios where this would be applicable and
somehow usefull (like: modifying _only_ the EXIF tags on one end, and
expect to be able to view and apply the tags modification on the other
end), but I don't think that's something important to worry about. As
other said, it would be really hard to set up for users, with little
benefits.

One possibility that would be simpler to set up would be to include
both the binary diff and the textconved diff in format-patch, and have
"git apply" just verify that the textconv actually matches the binary
diff after applying it. But that reduces the security issue without
really solving it: one could very well send a binary patch that
changes both the image and the exiftags, and claim it only changes the
tags.

In short: agreed with Peff ;-).

-- 
Matthieu
