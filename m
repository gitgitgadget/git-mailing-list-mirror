From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Use parseopts in builtin-fetch
Date: Mon, 5 Nov 2007 12:41:04 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711051215260.7357@iabervon.org>
References: <Pine.LNX.4.64.0711042233590.7357@iabervon.org>
 <20071105085513.GB25574@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 18:41:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip5ww-0004B9-KS
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 18:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbXKERlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 12:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbXKERlG
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 12:41:06 -0500
Received: from iabervon.org ([66.92.72.58]:36979 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbXKERlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 12:41:05 -0500
Received: (qmail 16063 invoked by uid 1000); 5 Nov 2007 17:41:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2007 17:41:04 -0000
In-Reply-To: <20071105085513.GB25574@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63530>

On Mon, 5 Nov 2007, Pierre Habouzit wrote:

> On Mon, Nov 05, 2007 at 03:35:34AM +0000, Daniel Barkalow wrote:
> > I mostly did this and the next one for practice with the API. I'm 
> > impressed that "git fetch -vv" is even handled correctly without anything 
> > special.
> 
>   About that: OPTION_BOOLEAN increments the associated variable, to
> support this case specifically.
> 
>   The last thing that really miss in parse-options is a way to recurse
> into a sub-array of struct option, to be able to port the generic diff
> and revision arguments.
> 
>   Though, there is a difficulty here that I've not yet found how to
> circumvent tastefully: right now options take an absolute pointer to
> _the_ variable that will be filled with values. I need to be able to
> relocate such a structure for sub-arrays for quite obvious reasons, and
> that is quite hard to achieve without hazardous APIs. I currently lean
> in the direction of simply memdup-ing the array and do fix-ups on
> *values pointers. Though how to do that in a graceful way is not obvious
> to me yet :)

I'm not entirely clear as to why the "diff options" to an arbitrary 
command can't configure variables in the diff engine. The tricky thing 
would be supporting a single command that has two sets of the same 
options (if git log could show the same stuff in two different ways at the 
same time, for example).

But, in any case, it should be possible for an OPT_* macro to take a 
struct type and a member name, do the offsetof and store that, and the 
inclusion macro would take the absolute pointer to the struct.

Next time I get a chance, I'll see if I can come up with something 
suitable.

	-Daniel
*This .sig left intentionally blank*
