From: Jeff King <peff@peff.net>
Subject: Re: stash-p broken?
Date: Wed, 30 Jul 2014 20:23:21 -0400
Message-ID: <20140731002321.GD22297@peff.net>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
 <CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
 <20140729025940.GA8640@vauxhall.crustytoothpaste.net>
 <20140729092301.GA13134@peff.net>
 <xmqq61ig3xsp.fsf@gitster.dls.corp.google.com>
 <20140729174357.GA20042@peff.net>
 <xmqqwqaw2fe3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Migdol <michael-spam@migdol.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:23:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCe9h-0004Io-55
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 02:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbaGaAXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 20:23:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:43382 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751605AbaGaAXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 20:23:33 -0400
Received: (qmail 28587 invoked by uid 102); 31 Jul 2014 00:23:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jul 2014 19:23:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jul 2014 20:23:21 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwqaw2fe3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254534>

On Tue, Jul 29, 2014 at 11:23:16AM -0700, Junio C Hamano wrote:

> I see you added --simplify-combined-diffs to avoid breaking "log",
> so that is not too bad, but I am still unsure what should happen
> when the first parent and the result is the same and only the second
> parent is different (i.e. you have changes in the index and your
> working tree changes have been reverted---then you create a stash).
> Should it show as "single source diff, with all changes reverted"?
> Should it show as a normal "combined diff for a merge"?  Should it
> show as "no changes whatsoever"?

Interesting question. I think right now we would show nothing in the
combined diff, as we simply took one side. This is really showing the
weakness of the "stash is a merge" storage format. If we use it as a
storage format, and pick it apart in "git stash", that's fine. But as
soon as we start treating it like a real merge and expecting "git log"
to behave, the cracks begin to show.

Hmph. To be honest, I am starting to wonder if implying "--first-parent"
is a more sensible option for "stash list". It matches "stash show", at
least, and it is not unreasonable to simply present the changes in the
working tree by default, and ignore the index. People who are more
clueful can pick apart the commits using "git log" themselves.

-Peff
