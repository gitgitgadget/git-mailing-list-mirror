From: Junio C Hamano <gitster@pobox.com>
Subject: Re: most annoying thing in git-push
Date: Mon, 22 Jun 2009 23:08:46 -0700
Message-ID: <7vd48va3dd.fsf@alter.siamese.dyndns.org>
References: <20090622192147.GE5743@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alexey I. Froloff" <raorn@altlinux.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 08:09:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIzBs-0000XQ-3I
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 08:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586AbZFWGIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 02:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755208AbZFWGIp
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 02:08:45 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45742 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbZFWGIo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 02:08:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090623060846.JAZA17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 23 Jun 2009 02:08:46 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7J8m1c00C4aMwMQ03J8mHa; Tue, 23 Jun 2009 02:08:47 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=7-TmW6R-vUMA:10 a=bH78PYQqAAAA:8
 a=FvxYKR-ZnENwd8SW-JUA:9 a=QJcRVk9_dJd55VhcDREA:7
 a=I9tXGDDl1E5AK9Q07KHEHASVwToA:4 a=OZAj1n7jCsAA:10
X-CM-Score: 0.00
In-Reply-To: <20090622192147.GE5743@altlinux.org> (Alexey I. Froloff's message of "Mon\, 22 Jun 2009 23\:21\:47 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122077>

"Alexey I. Froloff" <raorn@altlinux.org> writes:

> Is is possible to add such functionality to git-push, so it will
> push tags that point at objects that were uploaded to the remote
> repository?

I think it is doable, because the protocol is for the receiver to first
advertise all its existing refs, which means that the sender can learn
what is missing by first enumerating the tags it has, subtracting what the
receiver has, and then computing the ones that are missing from the
receiver and are reachable from the commits it is pushing, before the
sender has to respond which refs it wants to update with what object and
then send the packfile to transfer necessary objects.  You do not need to
change the protocol, nor what the receiving side does, to implement it.
You only need to update what the push side does.

It however is entirely a different matter if it is a sensible thing to do.

Often, a fetch is made from a public distribution point, which by
definition has only branches and tags that are meant for public
consumption.  It makes sense to auto-follow tags by default.

On the other hand, a push is almost always made from a private working
repository to a public distribution point, in order to update the latter
with only refs and objects meant for public consumption.  A developer
working in such a private working repository will use tags that are not
meant for public consumption while developing, and pushing all tags that
are reachable from the commits that are being pushed out to the public
distribution point is not necessarily desirable, as it will push out many
tags that are only private to the working repository.

It certainly is not a sensible default behaviour, even though it might be
handy as an option for special cases.
