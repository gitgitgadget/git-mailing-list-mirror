From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Make NO_PTHREADS the sole thread configuration variable
Date: Sat, 30 Jan 2010 20:29:28 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001302015120.1681@xanadu.home>
References: <1264814539-27209-1-git-send-email-dpmcgee@gmail.com>
 <7vwryzqyjb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 02:29:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbOdD-0006ik-PN
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 02:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab0AaB3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 20:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747Ab0AaB3a
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 20:29:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31648 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab0AaB3a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 20:29:30 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KX30075B854H541@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 30 Jan 2010 20:29:29 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vwryzqyjb.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138525>

On Sat, 30 Jan 2010, Junio C Hamano wrote:

> Dan McGee <dpmcgee@gmail.com> writes:
> 
> > When the first piece of threaded code was introduced in commit 8ecce684, it
> > came with its own THREADED_DELTA_SEARCH Makefile option. Since this time,
> > more threaded code has come into the codebase and a NO_PTHREADS option has
> > also been added. Get rid of the original option as the newer, more generic
> > option covers everything we need.
> 
> The patch is a good change but only in the "if it were like this from day
> one, things would have been much simpler" sense.  It is a breakage to
> existing users with customized THREADED_DELTA_SEARCH in their config.mak
> files, isn't it?

I think that the release of v1.7.0 is the perfect match for such a 
"breakage".  Unlike for the dashless move, I really doubt the majority 
of Git users are using a customized THREADED_DELTA_SEARCH in a 
config.mak if they do build Git themselves at all.  So very few people 
are likely to be inconvenienced, and yet the inconvenience can hardly be 
qualified as a breakage since nothing will stop working in any case.

> If we take only the part of your patch that applies to Makefile, but
> exclude the first hunk (description of THREADED_DELTA_SEARCH) and the last
> hunk (the necessary part to keep THREADED_DELTA_SEARCH working), and
> instead add something like:
> 
> 	ifndef NO_PTHREADS
>         	THREADED_DELTA_SEARCH = YesPlease
> 	endif
> 
> immediately before we include config.mak, would that be a workable
> solution to:
> 
>  (1) keep existing users happy;
> 
>  (2) remove the redundant logic to compute the default for two Make
>      variables; and
> 
>  (3) keep control over use of threading in general _and_ use of
>      threading in delta computation?

IMHO I wouldn't bother that much.  Simply mentioning in the 1.7.0 
release notes that THREADED_DELTA_SEARCH is no more should be fine.  
Like I said, the existing users who might be affected are certainly few, 
and the impact on them is rather trivial.


Nicolas
