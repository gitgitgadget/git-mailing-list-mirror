From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Mon, 10 Mar 2008 13:40:53 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803101327050.19665@iabervon.org>
References: <200803061735.47674.david-b@pacbell.net> <alpine.LNX.1.00.0803081826080.19665@iabervon.org> <alpine.LNX.1.00.0803091443440.19665@iabervon.org> <200803101018.09282.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:42:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYm0F-0004mD-QJ
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 18:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbYCJRkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 13:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbYCJRkz
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 13:40:55 -0400
Received: from iabervon.org ([66.92.72.58]:49748 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbYCJRkz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 13:40:55 -0400
Received: (qmail 14514 invoked by uid 1000); 10 Mar 2008 17:40:53 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Mar 2008 17:40:53 -0000
In-Reply-To: <200803101018.09282.david-b@pacbell.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76741>

On Mon, 10 Mar 2008, David Brownell wrote:

> On Sunday 09 March 2008, Daniel Barkalow wrote:
> > Try this. I'm not at all sure that it's doing what I want, but it passes 
> > all the current tests, and it should only affect your test case if it's 
> > actually right.
> 
> Seems to resolve that problem for me ... well timed, in terms of RC5!
> 
> But some stuff still looks a bit fishy.  See this RC4 --> RC5 pull:
> 
>   remote: Counting objects: 1329, done.
>   remote: Compressing objects: 100% (276/276), done.
>   remote: Total 908 (delta 749), reused 760 (delta 631)
>   Receiving objects: 100% (908/908), 146.35 KiB | 40 KiB/s, done.
>   Resolving deltas: 100% (749/749), completed with 287 local objects.
>   remote: Counting objects: 1330, done.
>   remote: Compressing objects: 100% (277/277), done.
>   remote: Total 909 (delta 749), reused 760 (delta 631)
>   Receiving objects: 100% (909/909), 146.63 KiB | 38 KiB/s, done.
>   Resolving deltas: 100% (749/749), completed with 287 local objects.
>   From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>    * [new tag]         v2.6.25-rc5 -> v2.6.25-rc5
>   Updating 29e8c3c..cdeeeae
>   Fast forward
>   Auto packing your repository for optimum performance. You may also
>   run "git gc" manually. See "git help gc" for more information.
>   ...
> 
> That's pretty typical:  two count/compress/receive/resolve passes,
> with almost an identical shape and size.  Every time I see that, I
> suspect that most of the second one should not be needed...

Ah, I bet it's not rereading the list of current refs when it updates 
them, and therefore only says it has the stuff that it had before. That 
would actually explain somewhat why the other bug was actually mattering.

Should be easy to fix, but I'm not sure when I'll get a chance to work on 
it.

	-Daniel
*This .sig left intentionally blank*
