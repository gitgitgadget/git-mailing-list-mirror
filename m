From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC PATCHv2 04/10] gitweb: Use Cache::Cache compatibile (get,
 set) output caching
Date: Wed, 10 Feb 2010 02:23:43 +0100
Message-ID: <20100210012343.GS9553@machine.or.cz>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
 <1265711427-15193-5-git-send-email-jnareb@gmail.com>
 <201002100212.26157.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 02:23:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf1J2-0003VB-4z
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 02:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab0BJBXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 20:23:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:47957 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892Ab0BJBXp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 20:23:45 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id C15AB86209A; Wed, 10 Feb 2010 02:23:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201002100212.26157.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139468>

On Wed, Feb 10, 2010 at 02:12:24AM +0100, Jakub Narebski wrote:
> On Tue, 9 Feb 2010 at 11:30 +0100, Jakub Narebski wrote:
> 
> > The cache_fetch subroutine captures output (from STDOUT only, as
> > STDERR is usually logged) using either ->push_layer()/->pop_layer()
> > from PerlIO::Util submodule (if it is available), or by setting and
> > restoring *STDOUT.  Note that only the former could be tested reliably
> > to be reliable in t9503 test!
> 
> Scratch that, I have just checked that (at least for Apache + mod_cgi,
> but I don't think that it matters) the latter solution, with setting
> and restoring *STDOUT doesn't work: I would get data in cache (so it
> can be restored later), but instead of output I would get Internal Server
> Error ("The server encountered an internal error or misconfiguration and
> was unable to complete your request.") without even a hint what the
> problem was.  Sprinkling "die ...: $!" didn't help to catch this error:
> I suspect that the problem is with capturing.
> 
> So we either would have to live with non-core PerlIO::Util or (pure Perl)
> Capture::Tiny, or do the 'print -> print $out' patch...

All the magic methods seem to be troublesome, but in that case I'd
really prefer a level of indirection instead of filehandle - as is,
'print (...) -> output (...)' ins. of 'print (...) -> print $out (...)'
(or whatever). That should be really flexible and completely
futureproof, and I don't think the level of indirection would incur any
measurable overhead, would it?

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
