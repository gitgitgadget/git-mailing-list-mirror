From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] notes: Use get_sha1_committish instead of read_ref in
 init_notes()
Date: Wed, 17 Jun 2015 18:02:46 +0900
Message-ID: <20150617090246.GC30948@glandium.org>
References: <1434503731-26414-1-git-send-email-mh@glandium.org>
 <20150617032231.GA24505@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 11:03:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z59FO-0005mf-Im
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 11:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908AbbFQJC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 05:02:58 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40213 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbbFQJC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 05:02:56 -0400
Received: from glandium by zenigata with local (Exim 4.85)
	(envelope-from <glandium@glandium.org>)
	id 1Z59F8-0008RU-NW; Wed, 17 Jun 2015 18:02:46 +0900
Content-Disposition: inline
In-Reply-To: <20150617032231.GA24505@peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271822>

On Tue, Jun 16, 2015 at 11:22:31PM -0400, Jeff King wrote:
> On Wed, Jun 17, 2015 at 10:15:31AM +0900, Mike Hommey wrote:
> 
> > init_notes() is essentially the only point of entry to the notes API.
> > It is an arbitrary restriction that all it allows as input is a strict
> > ref name, when callers may want to give an arbitrary committish.
> > 
> > This has the side effect of enabling the use of committish as notes refs
> > in commands allowing them, e.g. git log --notes=foo@{1}, although
> > I haven't checked whether that's the case for all of them.
> 
> What about expand_notes_ref? We call that on the argument to "--notes".
> I guess it is OK to expand "foo@{1}" into "refs/notes/foo@{1}", but what
> about other more arcane syntaxes, like ":/"?
> 
> In a sense that is weirdly broken already:
> 
>   $ git log --notes=:/foo >/dev/null
>   warning: notes ref refs/notes/:/foo is invalid
> 
> but I wonder if we should be making expand_notes_ref a little more
> careful as part of the same topic.

Interestingly, now that I look, there's also this:
https://github.com/git/git/blob/master/notes-cache.c#L40

that doesn't use expand_notes_ref, but it's apparently only used in
userdiff_get_textconv, and I'm not sure why.

Mike
