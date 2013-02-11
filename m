From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Mon, 11 Feb 2013 11:00:57 -0500
Message-ID: <20130211160057.GA16402@sigill.intra.peff.net>
References: <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin>
 <7vliavpc4q.fsf@alter.siamese.dyndns.org>
 <20130211071235.GL15329@elie.Belkin>
 <7v8v6vpbej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:01:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4vos-0008OA-4a
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757633Ab3BKQBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:01:01 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44288 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757086Ab3BKQBA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:01:00 -0500
Received: (qmail 23058 invoked by uid 107); 11 Feb 2013 16:02:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 11:02:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 11:00:57 -0500
Content-Disposition: inline
In-Reply-To: <7v8v6vpbej.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216037>

On Sun, Feb 10, 2013 at 11:17:24PM -0800, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Isn't that a criticism of the git-shell-commands facility in general?
> > If it is common to have a lot of users with distinct home directories
> > but all with git-shell as their login shell, then the
> > git-shell-commands should not go in their home directory to begin
> > with, no?
> 
> You can give one set of commands to some users while restricting
> others, no?

But that seems to me to argue against /etc/git/shell-disabled or
similar, which would apply to every user. Or are you proposing that the
check be:

  if -d ~/git-shell-commands; then
          : ok, interactive
  elif -x /etc/git/shell-disabled; then
          exec /etc/git/shell-disabled
  else
          echo >&2 'go away'
          exit 1
  fi

That at least means you can apply _whether_ to disable the shell
selectively for each user (by providing or not a git-shell-commands
directory), but you cannot individually select the script that runs for
that user.  But it's probably still flexible enough; you can, after all, run
arbitrary code in the shell-disabled script, so it can select which
class of user it was called on and dispatch to a sub-script.

-Peff
