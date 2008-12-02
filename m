From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6 (v2)] upload-pack: send the HEAD information
Date: Mon, 1 Dec 2008 20:59:25 -0500
Message-ID: <20081202015924.GA6529@coredump.intra.peff.net>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com> <1228140775-29212-2-git-send-email-gitster@pobox.com> <1228140775-29212-3-git-send-email-gitster@pobox.com> <1228140775-29212-4-git-send-email-gitster@pobox.com> <1228140775-29212-5-git-send-email-gitster@pobox.com> <1228140775-29212-6-git-send-email-gitster@pobox.com> <20081201174414.GA22185@coredump.intra.peff.net> <7vk5ajqs63.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:00:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KZB-0006GG-OK
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbYLBB72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbYLBB72
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:59:28 -0500
Received: from peff.net ([208.65.91.99]:4106 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553AbYLBB71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:59:27 -0500
Received: (qmail 7566 invoked by uid 111); 2 Dec 2008 01:59:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Dec 2008 20:59:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Dec 2008 20:59:25 -0500
Content-Disposition: inline
In-Reply-To: <7vk5ajqs63.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102100>

On Mon, Dec 01, 2008 at 05:31:16PM -0800, Junio C Hamano wrote:

> > Yuck. My two complaints are:
> >
> >   (1) this implicitly handles only the HEAD symref.
> 
> But this information *is* on the "40-hex name" line that describes the
> HEAD ;-)

Ahhh. OK. I see, I misunderstood the protocol a bit. So let me revise my
complaints. ;)

  (1) If there are multiple symrefs to report, we have to keep
      re-sending the server capabilities (I think you mentioned this in
      the subthread with Shawn).

  (2) Similar to (2) before. If we ever add a _third_ extra slot, we
      will be stuck sending the symref field each time we want to use
      that third slot (though if the client properly treats an empty
      slot the same as non-existent, this only wastes a single byte for
      the NUL).

  (3) If HEAD doesn't point to a valid object, we have no place to put
      the symref. Or is it kosher to say

        0000000000000000000000000000000000000000 HEAD\0...\0refs/heads/master

      ? I think it would be nice eventually to be able to clone a HEAD
      pointing to yet-to-be-born branch.

-Peff
