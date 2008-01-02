From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Retroactively change email signature?
Date: Wed, 2 Jan 2008 13:24:49 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801021316080.3010@woody.linux-foundation.org>
References: <9b3e2dc20801021237v4d5d236fn3d2643502b9bb78f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Sinclair <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 22:25:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAB60-0006HG-CE
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 22:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbYABVZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 16:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbYABVZB
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 16:25:01 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38051 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758045AbYABVY6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2008 16:24:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m02LOoms006775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Jan 2008 13:24:51 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m02LOntt005918;
	Wed, 2 Jan 2008 13:24:49 -0800
In-Reply-To: <9b3e2dc20801021237v4d5d236fn3d2643502b9bb78f@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69492>



On Wed, 2 Jan 2008, Stephen Sinclair wrote:
> 
> Is it possible to retroactively change the author and email of several
> commits?  Perhaps some sort of search-and-replace for the commit
> metadata?  Even for older commits, I'd like to change the email
> addresses to my current address.

See

	man git-filter-branch

and the "--env-filter" flag (and "--msg-filter" if you also want to change 
things like Sign-off's etc in the message text itself)

BUT! See also the big bold-face warning: using "filter-branch" will not 
change old commits, it will create a series of *new* commits that bear a 
striking resemblance to the old ones, but are not the same. So you'll have 
a totally new history.

That matters for things like
 - if you've already publicised the old history, you need to tell people 
   that they should fetch things anew
 - if you refer to the commit SHA1's elsewhere (like in commit messages 
   that revert previous commits), those SHA1's are still "valid", but they 
   refer to the *old* history, not the new history you created.

(I don't think git-filter-branch even exposes any easy way to remap the 
"revert commit xyz" messages in the message format. It's not technically 
hard to use a --msg-filter for it, but it seems a big bother).

		Linus
