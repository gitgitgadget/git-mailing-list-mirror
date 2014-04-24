From: Jeff King <peff@peff.net>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 15:15:32 -0400
Message-ID: <20140424191531.GA7815@sigill.intra.peff.net>
References: <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
 <20140424154717.GB7531@thunk.org>
 <CALbm-Ea4oAQ+JsYu6Zo06ONMbtp8AhgFqDC485BRKsM36EVQXw@mail.gmail.com>
 <20140424180204.GL15516@google.com>
 <53595759dce2a_3241f112ec9b@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 21:15:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdP7U-0003og-J4
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 21:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbaDXTPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 15:15:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:37741 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751083AbaDXTPe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 15:15:34 -0400
Received: (qmail 2864 invoked by uid 102); 24 Apr 2014 19:15:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Apr 2014 14:15:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Apr 2014 15:15:32 -0400
Content-Disposition: inline
In-Reply-To: <53595759dce2a_3241f112ec9b@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246999>

On Thu, Apr 24, 2014 at 01:26:33PM -0500, Felipe Contreras wrote:

> Jonathan Nieder wrote:
> > Stefan Beller wrote:
> > 
> > > I may have missunderstood.
> > >
> > > So today you cannot commit if you don't provide an email address
> > > (usually the first time you try to commit, git asks to "git config
> > > --global author.email=<you@mail.here>"), if I remember correctly, so
> > > there is definitely a valid (i.e. user approved) email address.
> > 
> > Not true.  But you do get a big wall of text when you make your
> > first commit without an EMAIL envvar or configured [user] section,
> > including
> 
> Only if you don't have a fully qualified hostname.

No, we alway warn if the values weren't explicitly provided:

  $ git config --global --unset user.email
  $ git commit --allow-empty -m foo
  [master 1e987ba] foo
   Committer: Jeff King <peff@sigill.intra.peff.net>
  Your name and email address were configured automatically based
  on your username and hostname. Please check that they are accurate.
  You can suppress this message by setting them explicitly:
  
      git config --global user.name "Your Name"
      git config --global user.email you@example.com
  
  After doing this, you may fix the identity used for this commit with:
  
      git commit --amend --reset-author

but we will consider several sources explicit, like
$GIT_COMMITTER_EMAIL, $EMAIL, and of course user.email:

  $ EMAIL=whatever@example.com git commit --allow-empty -m foo
  [master e75f17a] foo

We die when the values are implicitly derived from the system _and_ they
look bogus:

  $ sudo rm /etc/mailname
  $ sudo hostname bogus
  $ git commit --allow-empty -m foo

  *** Please tell me who you are.
  
  Run
  
    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"
  
  to set your account's default identity.
  Omit --global to set the identity only in this repository.
  
  fatal: unable to auto-detect email address (got 'peff@bogus.(none)')

-Peff
