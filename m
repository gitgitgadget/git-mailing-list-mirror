From: Jeff King <peff@peff.net>
Subject: Re: Re: [PATCH] Docs: git checkout --orphan: `root commit' and
 `branch head'
Date: Tue, 27 Sep 2011 17:42:13 -0400
Message-ID: <20110927214213.GC5176@sigill.intra.peff.net>
References: <1316960136073-6829212.post@n2.nabble.com>
 <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
 <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org>
 <4E823359.7080602@nextest.com>
 <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Raible <raible@nextest.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 23:42:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8fPx-0003re-1J
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 23:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab1I0VmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 17:42:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45512
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786Ab1I0VmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 17:42:15 -0400
Received: (qmail 28756 invoked by uid 107); 27 Sep 2011 21:47:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Sep 2011 17:47:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2011 17:42:13 -0400
Content-Disposition: inline
In-Reply-To: <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182268>

On Tue, Sep 27, 2011 at 10:31:17PM +0100, Philip Oakley wrote:

> >Not this person.
> >
> >I like the idea but I'd rather see:
> >
> >git commit --no-parent
> >
> >"parent" at least appears in gitk and therefore newcomers will prob
> >have a better chance of understanding the intent w/out needing to
> >otherwise unnecessary terminology.
> >--
> I think this feels and sounds sensible.  And better located within
> the 'commit' command, rather than 'checkout --orphan' which was more
> obscure (and difficult to find).

Keep in mind that making it part of commit is potentially much more
dangerous. With "checkout --orphan", you are making a _new_ branch that
has no parents. Committing on it will make a disconnected history, but
your original branch is still there.

With "git commit --no-parent", you are disconnecting history on the
_current_ branch. Which means you are throwing away the old history
completely. I.e., it is about as dangerous as "git branch -d", which we
usually protect with a "force" flag[1].

So at the very least, the documentation for the new option would need to
make the consequences very clear, and that one should run it on a newly
created branch if they don't want to throw away the old history.

-Peff

[1] Actually, it's similarly dangerous to "git reset", which doesn't
    have a force flag. But then, "git reset" is frequently brought up as
    the most dangerous and confusing command by new git users.
