From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 07 Feb 2011 04:51:37 +0100
Message-ID: <201102070451.37370.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102070022.51403.johan@herland.net> <vpqtyggk9i2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 07 04:51:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmI8e-0007p4-JS
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 04:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab1BGDvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 22:51:39 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51077 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab1BGDvj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 22:51:39 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG800FOHAQ25Z40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Feb 2011 04:51:38 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 428A11EF02B2_D4F6C4AB	for <git@vger.kernel.org>; Mon,
 07 Feb 2011 03:51:38 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 05AEE1EEF970_D4F6C4AF	for <git@vger.kernel.org>; Mon,
 07 Feb 2011 03:51:37 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG8005Y8AQ16000@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Feb 2011 04:51:37 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <vpqtyggk9i2.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166227>

On Monday 07 February 2011, Matthieu Moy wrote:
> Johan Herland <johan@herland.net> writes:
> >> For tags, it's clearly different. If I have origin/v1.7.4, I don't see
> >> much reason to have _also_ v1.7.4 as a local tag. And if I have only
> >> origin/v1.7.4 and push it as origin/v1.7.4, then someone pulling from
> >> it will get origin/origin/v1.7.4, and so on.
> > 
> > Wrong. If you have origin/v1.7.4, it's because v1.7.4 already exists in
> > the origin remote, so there's no point in trying to push it back. On
> > the other hand, if you have v1.7.4 locally (but not origin/v1.7.4),
> > you should (assuming this is intended to be a public tag) consider
> > pushing it to the "origin" remote, thus causing origin/v1.7.4 to
> > appear in your repo.
> 
> (I made a bad choice by repeating "origin" several times)
> 
> What happens if I pull from "remoteA" and then push to "remoteB"?

So, when you pull from "remoteA", you get 
"refs/remotes/remoteA/tags/v1.7.4", but since it is unambiguous, you can 
refer to it by "v1.7.4" instead.

When you push to "remoteB", you would say "git push remoteB tag v1.7.4", and 
it would resolve "v1.7.4" (via "refs/remotes/remoteA/tags/v1.7.4") into the 
appropriate SHA-1, and then push the "v1.7.4" tag to the remote.

You have to separate the namespace from the name itself. For instance, if I 
run "git push remoteB tag v1.7.4", it resolves "v1.7.4" into 
refs/tags/v1.7.4, but that doesn't mean that I end up with 
"refs/tags/refs/tags/v1.7.4" in the "remoteB" repo.

> Take the example of the interim maintainer cited somewhere else in
> this thread. If Shawn fetches from Junio, he'll get a junio/v1.7.4
> tag, and on my side, I do not want to end up having
> shawn/junio/v1.7.4, especially if this means that people fetching from
> me would end up with a me/shawn/junio/v1.7.4 ...

You won't end up with "shawn/junio/v1.7.4". When Shawn fetches from Junio, 
what he actually gets is "refs/remotes/junio/tags/v1.7.4" ("junio/v1.7.4" is 
a shorthand; "v1.7.4" is an even better shorthand).

Next, you should never pull from Shawn's work repo, but rather from the repo 
he has published. In that repo he will typically have pushed the "v1.7.4" 
tag (as described above). When you pull from Shawn's public repo, you will 
get the "v1.7.4" tag at "refs/remotes/shawn/tags/v1.7.4" (but "v1.7.4" is an 
unambigious shorthand).

Even if you _were_ to pull directly from Shawn's work repo, you would not 
get the "shawn/junio/v1.7.4" mess you fear, simply because when you fetch 
from a repo, the refs inside that repo's "refs/remotes" are not fetched.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
