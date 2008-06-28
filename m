From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] Add strbuf_vaddf(), use it in strbuf_addf(), and
 add strbuf_initf()
Date: Fri, 27 Jun 2008 19:00:53 -0700
Message-ID: <7vk5gal3my.fsf@gitster.siamese.dyndns.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org> <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org> <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org> <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org> <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org> <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org> <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org> <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org> <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org> <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@fruga
 lware.org> <cover.1214581610.git.vmiklos@frugalware.org> <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jun 28 04:02:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCPlZ-0002v0-R2
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 04:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbYF1CBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 22:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYF1CBP
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 22:01:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbYF1CBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 22:01:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D5E81000C;
	Fri, 27 Jun 2008 22:01:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5392A10007; Fri, 27 Jun 2008 22:01:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 13648772-44B6-11DD-87F4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86690>

Do you really think these two patches belong to the series, I seriously
have to wonder?

The series uses strbuf_initf() from 7 call sites to save a few lines per
each call site, and for that you have a 140-line patch to strbuf.c (in
aggregate between this one and the "Oops, I need to support this, too" one
after this).

This new code that is not essential to the series need to be carefully
vetted to avoid risks of potentially affecting existing 70+ users of
strbuf_addf(), which used to use (hopefully more trustworthy) vsnprintf()
from the system, but now uses the new and unproven strbuf_vaddf() that
has "Only supports %<these>" disclaimer at the top.

I am not saying the strbuf_vaddf() patch is not worth considering.  It
might help platforms without a working vsnprintf().  But its merit needs
to be defended separately, and I do not want "merge in C" series to be
taken hostage by it.

Other than that, I did not see anything obviously wrong in the diff
between the previous round and this series.

Thanks.
