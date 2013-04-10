From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 16:05:48 -0400
Message-ID: <20130410200548.GC24177@sigill.intra.peff.net>
References: <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
 <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:06:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1HL-0000w2-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936067Ab3DJUFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:05:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39097 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755554Ab3DJUFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:05:55 -0400
Received: (qmail 6379 invoked by uid 107); 10 Apr 2013 20:07:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 16:07:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 16:05:48 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220745>

On Thu, Apr 11, 2013 at 01:23:57AM +0530, Ramkumar Ramachandra wrote:

> Ramkumar Ramachandra wrote:
> > git push -- master next; pushes to my current branch's
> > branch.<name>.pushremote?  Isn't that a disaster?
> 
> Actually, branch.<name>.pushremote already breaks the current design
> in a way, as Junio pointed out in a different email: a push.default
> set to anything except "current" is already nonsensical.  Why should
> "matching" branches be pushed to the remote that my current branch
> specifies?  That might well have their own branch.<name>.pushremote
> configured, which should be respected.

I'm not sure that it should be respected. "master" is short for
"refs/heads/master:refs/heads/master", and does not mean "push master to
where I have it configured to go" at all.  That may be what the user
means, but changing how "git push" works is going to create
inconsistency with other cases.

> We should fix this now.  I think the fault lies in the rather old
> design of push.default.  Do you have any suggestions as what would
> make sense here?  Ultimately, I think a git push; needs to pick
> remotes for each refspec separately.  The orthogonal design is
> definitely not right in my opinion.

Right, the example above might include multiple remotes if pushremote is
respected. Or it might not come up with an answer at all for a tag.
If you do:

  git push -- v1.2.3 master

where does v1.2.3 go? To remote.pushdefault? That seems simple and
consistent, as there is no ref-specific pushremote defined. But I'd
guess that the user probably _wanted_ it to go to
branch.master.pushremote.

> As the author of branch.<name>.pushremote, I apologize for not having
> caught this earlier.  I've been using push.default = current for a
> long time, and don't often think about the other settings.

I don't think pushremote introduced the problem. It is much older than
that, and dates back to respecting branch.*.remote at all for pushes,
even though push.default=matching (and before we had push.default, it
was always matching) does not have anything to do with the current
branch.

-Peff
