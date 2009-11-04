From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 09/13] Honour the refspec when updating refs after
 import
Date: Wed, 4 Nov 2009 16:20:11 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911041601170.14365@iabervon.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com> <1257364098-1685-10-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:20:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nHG-0001nX-7l
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbZKDVUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 16:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758176AbZKDVUH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:20:07 -0500
Received: from iabervon.org ([66.92.72.58]:45839 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758175AbZKDVUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 16:20:06 -0500
Received: (qmail 32509 invoked by uid 1000); 4 Nov 2009 21:20:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 21:20:11 -0000
In-Reply-To: <1257364098-1685-10-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132149>

On Wed, 4 Nov 2009, Sverre Rabbelier wrote:

> This way the helper can write to 'refs/remotes/origin/*' instead of
> writing to 'refs/heads/*'.
> 
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
> 
>   Daniel, does this look good to you?
> 
>   Let's assume the following:
>   * list: only HEAD is a symref (to refs/heads/<branch>), all other
>           refs are '? refs/heads/<branch>'.
>   * import: the helper creates branches under refs/remotes/<alias>/*
>             (since the refspec code is not yet in that would allow
>              it to create them under refs/<vcs>/<alias>/*)
>
>   Now when updating the refs we do the following:
>   transport-helper.c:145 "read_ref(posn->name, posn->old_sha1);"
> 
>   The value of posn->name looks like "refs/heads/<branch>". So what
>   does this lookup do? It tries to lookup the new value of the ref
>   _where it will be created_, this fails of course, since the ref
>   currently only exists as "refs/remotes/origin/<branch>". So, we
>   should instead be doing a lookup using posn->peer_ref->name, and
>   not do a lookup at all if it posn->peer_ref is not set (which
>   should not occur as we are passed only wanted peer refs).

That's not true for "git pull <url> <branch>"; we do want the remote ref, 
but it doesn't have a local peer. I think going straight to the refspec 
command is the right answer.

	-Daniel
*This .sig left intentionally blank*
