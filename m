From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Wed, 2 Sep 2009 01:12:48 -0400
Message-ID: <20090902051248.GB12046@coredump.intra.peff.net>
References: <20090901145213.GB4194@debian.b2j>
 <200909012213.54611.j6t@kdbg.org>
 <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org>
 <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
 <20090902011513.GA3874@coredump.intra.peff.net>
 <7vmy5egefh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, bill lam <cbill.lam@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 07:14:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiiAV-0001Z5-3I
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 07:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710AbZIBFMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 01:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755708AbZIBFMu
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 01:12:50 -0400
Received: from peff.net ([208.65.91.99]:43905 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755703AbZIBFMt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 01:12:49 -0400
Received: (qmail 4711 invoked by uid 107); 2 Sep 2009 05:13:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Sep 2009 01:13:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2009 01:12:48 -0400
Content-Disposition: inline
In-Reply-To: <7vmy5egefh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127578>

On Tue, Sep 01, 2009 at 09:26:26PM -0700, Junio C Hamano wrote:

> But not everybody is used to such a set-up.  If you rely on terminal's
> scrollback buffer with mouse and a short terminal, I can see cutting and
> pasting would be an issue.  I do not have a good answer to "tig status",
> but the design principle of supporting the lowest denominator is
> important.

But I'm not sure it is about "lowest common denominator". I think it is
about different people having different preferences (as a matter of
fact, I use an 80x25 terminal most of the time, and I think I prefer the
content at the top. Perhaps it is simply habit, but I do think having it
right next to "staged for commit" items makes the most sense).

> The above suggests me that (1) we would want to have the new "unmerged"
> section next to "updated" section, (2) we would want to have it later in
> the output rather than earlier, and (3) in the traditional output, people
> are used to see unmerged paths in "changed" section, so it would be easier
> for them to transition if "unmerged" section were near "changed" section.
> 
> That makes the ideal place between updated and changed, no?

Yes, I think that is fine, and makes more sense than where we have it
now. I mainly wanted to argue against sticking it at the very bottom.

> [1] It might even make sense to omit other sections and show only
> "updated" and "unmerged" in this order when the index is unmerged, but
> that is a lot more drastic change for 1.7.0.

I think that is a really bad idea. The mental model of "git status"
(versus individual diff or ls-files commands) is to see _everything_
going on in the repo. Showing a subset breaks that model and gives a
false sense of what is actually happening.

I don't know that it would matter much most of the time anyway. If you
have unmerged entries, you probably don't have any (or many) "changed
but not updated" files, too (since you are not working on a new commit
but rather a merge, they would have to be dirty state you are carrying
permanently, but not related to the merge). If you do, you probably want
to see them to be aware of what is going on.

You probably also don't have a lot of untracked files. If you have a
few, you might want to be reminded of them to make sure they were not
something you were preparing to help with a tricky merge. And if you are
the sort of person who carries around a lot of untracked files, and for
some reason you refuse to put them in your .gitignore, then you probably
have status.untracked set to "no" already (or you should consider
setting it), as they will be bugging you in other situations, as well.

-Peff
