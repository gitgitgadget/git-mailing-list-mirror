From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFH] lifetime rule for url parameter to transport_get()?
Date: Tue, 23 Aug 2011 13:04:09 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1108231252520.2056@iabervon.org>
References: <7vipppt175.fsf@alter.siamese.dyndns.org> <7vsjosrs0w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 19:17:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvuay-0007mN-0O
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 19:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab1HWRQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 13:16:55 -0400
Received: from iabervon.org ([66.92.72.58]:53457 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab1HWRQx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 13:16:53 -0400
Received: (qmail 26189 invoked by uid 1000); 23 Aug 2011 17:04:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Aug 2011 17:04:09 -0000
In-Reply-To: <7vsjosrs0w.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179953>

On Tue, 23 Aug 2011, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Does anybody remember why we use a copied string of "ref_git_copy" in
> > builtin/clone.c::setup_reference()?
> >
> > 	ref_git = real_path(option_reference);
> > 	...
> > 	ref_git_copy = xstrdup(ref_git);
> 
> It didn't have anything to do with transport/remote layer.
> 
> This codepath uses real_path() and optionally mkpath(), both of which
> returns a short-lived static buffer to return its findings, and long-term
> users are expected to copy it away.

Yeah, that fits with my expectation, given the lack of a comment and the 
fact that you were asking about clone and not also fetch.

At least originally, the remote and transport data was expected to live 
until the process exits, since it's a small, bounded number of small 
objects. If I'd included functions to free the structures, I'd have had 
them free the strings they were passed.

	-Daniel
*This .sig left intentionally blank*
