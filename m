From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 07/13] transport-helper: change import semantics
Date: Sun, 29 Aug 2010 15:29:18 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1008291521350.14365@iabervon.org>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com> <1283053540-27042-8-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 21:29:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpnZO-0002cv-Tb
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 21:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959Ab0H2T3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 15:29:30 -0400
Received: from iabervon.org ([66.92.72.58]:52252 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591Ab0H2T33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 15:29:29 -0400
Received: (qmail 3021 invoked by uid 1000); 29 Aug 2010 19:29:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Aug 2010 19:29:18 -0000
In-Reply-To: <1283053540-27042-8-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154704>

On Sat, 28 Aug 2010, Sverre Rabbelier wrote:

> Currently the helper must somehow guess how many import statements to
> read before it starts outputting its fast-export stream. This is
> because the remote helper infrastructure runs fast-import only once,
> so the helper is forced to output one stream for all import commands
> it will receive. The only reason this worked in the past was because
> only one ref was imported at a time.

I think your reasons for this change could be worked around, but the 
protocol is cleaner with your change, which is justification enough, given 
that it shouldn't be too big a deal to change. This also lets the helper 
consider all of the refs it is expected to update before producing the 
stream, which may simplify the stream (particularly if the history has 
merges involving branches that may or may not be imported are aren't 
listed first).

> Change the semantics of the import statement such that it matches
> that of the list statement. That is, 'import\n' is followed by a list
> of refs that should be exported, followed by '\n'.
> ---
> 
>   This changes the protcol a bit, but I don't think we have many
>   users of the 'import' command yet, and if we do I would assume
>   they're paying attention to development in the remote helper space.

I don't think "import" has gotten to the point where people could really 
use it in helpers not packaged with git, anyway, so I agree.

	-Daniel
*This .sig left intentionally blank*
