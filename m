From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Sat, 12 Apr 2014 07:42:12 -0400
Message-ID: <20140412114212.GB14820@sigill.intra.peff.net>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
 <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
 <20140411111750.GA28858@sigill.intra.peff.net>
 <xmqqsipjsm8c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 13:42:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYwKD-0001ax-0O
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 13:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154AbaDLLmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 07:42:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:58509 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755312AbaDLLmP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 07:42:15 -0400
Received: (qmail 26830 invoked by uid 102); 12 Apr 2014 11:42:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 12 Apr 2014 06:42:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Apr 2014 07:42:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsipjsm8c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246168>

On Fri, Apr 11, 2014 at 12:24:35PM -0700, Junio C Hamano wrote:

> > But the branch.master.push setting does not do
> > anything to "git push".
> 
> I am not sure I understand this.  I thought that the desire behind
> the branch.*.push is to allow something like:
> 
> 	... other things in the config ...
> 	[remote]
>         	pushdefault = foo
> 	[remote "foo"]
> 		url = ...
>         	push = +refs/heads/*:refs/remotes/satellite/*
>                 fetch = +refs/heads/*:refs/remotes/foo/*
> 	[branch "master"]
> 		; pushremote = foo
>         	push = refs/heads/bar
> 
> so that "git push" on 'master' will override the more generic "all
> local branches here will go to their remote-tracking hierarchy for
> this satellite" refspec.  And in that sense branch.master.push would
> do something to "git push".

Ah, I see. If I set "push.default" to "upstream", then the config I
showed before _does_ affect "git push". But I do not usually do that. I
have push.default set to "current", and sometimes override it using push
refspecs on certain repositories.

And that is why I find branch.*.push and Felipe's @{publish} useless for
my workflow. Pushes already go where I want them to, and I just want a
way to ask git to perform that config resolution for me. Whereas
Felipe's workflow is (I think) something like:

  # make a new branch...
  git checkout -b topic origin/master

  # now publish our branch, and remember our publishing point
  git push -p my-repo topic

  # and now further pushes automatically go to my-repo/topic
  git push

I can see there is some value in that override if you do things like:

  git push -p my-repo topic:some-other-name

because the "-p" means "remember this other name I gave".

I would think in such a workflow that most of your branches would end up
with publish config, though. And therefore @{publish} would become
equivalent to "where you would push". But Felipe indicated that he would
not want "branch -vv" to match where all branches would be pushed, but
rather only those that were specifically configured. So maybe I do not
understand his workflow after all.

-Peff
