From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: --follow is ignored when used with --reverse
Date: Tue, 2 Jul 2013 11:38:42 +0200
Message-ID: <20130702093842.GA4353@blizzard>
References: <20130524012324.295dec77@hugo.daonet.home>
 <20130702091936.GA9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alois Mahdal <Alois.Mahdal.1-ndmail@zxcvb.cz>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jul 02 11:38:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utx2y-0007Em-MM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 11:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057Ab3GBJit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 05:38:49 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:26319 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab3GBJis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 05:38:48 -0400
Received: from localhost (p57B425AB.dip0.t-ipconnect.de [87.180.37.171]);
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 1396cd7f;
	TLS version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO;
	Tue, 2 Jul 2013 11:38:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130702091936.GA9161@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229386>

On Tue, Jul 02, 2013 at 10:19:36AM +0100, John Keeping wrote:
> On Fri, May 24, 2013 at 01:23:24AM +0200, Alois Mahdal wrote:
> > Hello!
> > 
> > This [has been reported][1] to this list about half a year ago
> > but with no response so I'm  not even sure if it's been
> > acknowledged as bug.
> > 
> >   [1]: http://marc.info/?l=git&m=135215709307126&q=raw
> > 
> > When I use `git log --follow file` all is OK, but once I add
> > `--reverse` to it, it no longer follows the file beyond renames.
> > 
> > This makes it hard to query for when the file was really added,
> > which I was trying to achieve with
> > 
> >     $ git -1 --reverse --follow several_times_renamed_file
> 
> In my testing it actually seems to be worse than that.  In git.git:
> 
>     $ git log --oneline builtin/clone.c | wc -l
>     99
>     $ git log --oneline --reverse builtin/clone.c | wc -l
>     99
>     $ git log --oneline --follow builtin/clone.c | wc -l
>     125
>     $ git log --oneline --follow --reverse builtin/clone.c | wc -l
>     3

I just wanted to point out that it works fine when specifying the *original*
file name (which kind of makes sense given that everything is done in reverse
order):

    $ git init >/dev/null
    $ echo foo >a && git add a && git commit -m first
    [master (root-commit) 3631134] first
     1 file changed, 1 insertion(+)
     create mode 100644 a
    $ echo bar >b && git add b && git commit -m second
    [master 7772184] second
     1 file changed, 1 insertion(+)
     create mode 100644 b
    $ git mv b c && git commit -m third
    [master 0275097] third
     1 file changed, 0 insertions(+), 0 deletions(-)
     rename b => c (100%)
    $ git log --oneline --follow --reverse -- c
    0275097 third
    $ git log --oneline --follow --reverse -- b
    7772184 second
    0275097 third

However, that also doesn't seem to work for builtin/clone.c:

    $ git log --oneline --follow --reverse -- builtin-clone.c | wc -l
    65

> 
> So the combination of --reverse and --follow appears to have lost the
> majority of the commits!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
