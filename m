From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Mar 2009, #04; Sat, 14)
Date: Mon, 16 Mar 2009 19:11:03 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903161834530.19665@iabervon.org>
References: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 00:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjLz2-00041I-JJ
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 00:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762199AbZCPXLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 19:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762111AbZCPXLH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 19:11:07 -0400
Received: from iabervon.org ([66.92.72.58]:60671 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757750AbZCPXLG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 19:11:06 -0400
Received: (qmail 23708 invoked by uid 1000); 16 Mar 2009 23:11:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Mar 2009 23:11:03 -0000
In-Reply-To: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113402>

On Sat, 14 Mar 2009, Junio C Hamano wrote:

> * db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
>  - Support fetching from foreign VCSes
>  - Add specification of git-vcs helpers
>  - Add "vcs" config option in remotes
> 
> The "spec" did not seem quite well cooked yet, but in the longer term I
> think something like this to allow interoperating with other SCMs as if
> the other end is a native git repository is a very worthy goal.

I recently figured out a way to alter the transport API slightly to make 
it possible to attach foreign VCSes there. This amounts to allowing 
get_refs_list() to leave the sha1s null, and allowing fetch() to set them. 
This just requires a copy of a ref list in the clone path, and a check to 
make null (for not having a ref) not match null (for not knowing the hash 
of the ref) in the fetch logic.

I think I will end up changing the spec, mostly to allow a single 
non-trivial call to the helper to provide both the list of refs and the 
fast-import stream; this matches how the pack protocol works (except, of 
course, that the initial list doesn't have hashes, and the output goes to 
fast-import instead of unpack-objects). I'm going to rebase the series at 
some point, but I've been focused more on the more core transport and 
remote stuff now that I think I can go through that.

	-Daniel
*This .sig left intentionally blank*
