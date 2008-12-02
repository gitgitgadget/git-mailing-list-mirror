From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6 (v2)] upload-pack: send the HEAD information
Date: Mon, 1 Dec 2008 21:36:43 -0500
Message-ID: <20081202023643.GA6804@coredump.intra.peff.net>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com> <1228140775-29212-2-git-send-email-gitster@pobox.com> <1228140775-29212-3-git-send-email-gitster@pobox.com> <1228140775-29212-4-git-send-email-gitster@pobox.com> <1228140775-29212-5-git-send-email-gitster@pobox.com> <1228140775-29212-6-git-send-email-gitster@pobox.com> <20081201174414.GA22185@coredump.intra.peff.net> <7vk5ajqs63.fsf@gitster.siamese.dyndns.org> <20081202015924.GA6529@coredump.intra.peff.net> <7v1vwrqpvf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:38:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7L9G-00068Y-JV
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbYLBCgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbYLBCgq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:36:46 -0500
Received: from peff.net ([208.65.91.99]:4071 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbYLBCgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:36:45 -0500
Received: (qmail 8033 invoked by uid 111); 2 Dec 2008 02:36:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Dec 2008 21:36:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Dec 2008 21:36:43 -0500
Content-Disposition: inline
In-Reply-To: <7v1vwrqpvf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102109>

On Mon, Dec 01, 2008 at 06:20:52PM -0800, Junio C Hamano wrote:

> I think sending 0{40} would break older clients, but older clients cannot
> clone from an empty repository anyway, so that should not be so bad.  I
> however do not think it is such a big thing to be able to clone void
> anyway.
> 
> You just have to train yourself to announce that your repository is
> clonable _after_ making it actually clonable.

I disagree. 99% of the time we see people complain about this, it is not
"I tried to announce my repo to people but it didn't have any commits"
but rather "why must I hack, init remote, then push, instead of init
remote, hack, push"[1].

That is, some segment of people (myself included) want to say first "I'm
starting a new project, and so I'm going to create a spot for it on my
server". Of course we can train ourselves to do it in the other order,
but it is an unnecessary complication.

-Peff

[1] Actually, it is more than just arbitrary preference. It is less
typing to do:

    ssh remote 'mkdir foo && cd foo && git init --bare'
    git clone remote:foo
    hack hack hack; commit
    git push

than

    git init
    hack hack hack; commit
    ssh remote 'mkdir foo && cd foo && git init --bare'
    git push
    git remote add -m refs/heads/master origin remote:foo
