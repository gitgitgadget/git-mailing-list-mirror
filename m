From: Jeff King <peff@peff.net>
Subject: Re: git commit -v does not removes the patch
Date: Wed, 12 Nov 2008 03:16:09 -0500
Message-ID: <20081112081609.GA3720@coredump.intra.peff.net>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com> <20081110181023.GA22753@coredump.intra.peff.net> <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com> <7vej1j40x5.fsf@gitster.siamese.dyndns.org> <20081111000706.GA26223@coredump.intra.peff.net> <adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com> <20081111102914.GA30330@coredump.intra.peff.net> <7v4p2e2nkg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 09:17:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Aul-0006dp-61
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 09:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbYKLIQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 03:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbYKLIQM
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 03:16:12 -0500
Received: from peff.net ([208.65.91.99]:2427 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbYKLIQM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 03:16:12 -0500
Received: (qmail 17589 invoked by uid 111); 12 Nov 2008 08:16:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 03:16:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 03:16:09 -0500
Content-Disposition: inline
In-Reply-To: <7v4p2e2nkg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100721>

On Tue, Nov 11, 2008 at 09:13:18AM -0800, Junio C Hamano wrote:

> We may want to change this.  We can say "# Everything under this line is
> deleted." at the beginning of the "#" block we produce in the commit log
> message editor, replacing the "Lines starting with '#' will be ignored, "
> we currently have.  When reading back the editor result, make "git commit
> -v" scan for the "# Everything ..." line.  We remove it and everything
> that follows, but we do not touch anything above that line (including the
> ones that begin with "diff" or "#") except the usual trailing whitespace
> removal.  That way, people can leave a sample shell session with root
> prompt, and sample diff, in their message.
>
> If we do not see "# Everything ..." when we read it back, we can do what
> we currently do as a fallback.

I am little hesitant to do this, because I think people have scripted
minorly around the template format (at the very least, for syntax
highlighting). I think some people may have pre-written templates, as
well, though I guess your "If we do not see..." paragraph is meant to
address that. Though that brings some confusion itself, because now the
parsing rules for what is kept change if I delete that line.

Here's a patch series that at least improves the situation by turning
off the diff-stripping if we never put in a diff in the first place.
That way only people who actually _use_ "-v" will have to pay for it.
It has the fix I sent to Santi earlier, as well as some related
cleanups.

    1/5: define empty tree sha1 as a macro
    2/5: wt-status: refactor initial commit printing
    3/5: status: show "-v" diff even for initial commit
    4/5: commit: loosen pattern for matching "-v" diff
    5/5: commit: only strip diff from message in verbose mode

-Peff
