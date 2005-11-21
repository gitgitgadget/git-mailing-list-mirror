From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 1/2] Use remote information in .git/config
Date: Mon, 21 Nov 2005 21:24:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511212109440.4213@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511211452470.13775@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4q65sst3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 21:25:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeIDZ-0000MS-Ny
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 21:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVKUUYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 15:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVKUUYq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 15:24:46 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:43419 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751027AbVKUUYq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 15:24:46 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E79B6140512; Mon, 21 Nov 2005 21:24:44 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C4D58B529A; Mon, 21 Nov 2005 21:24:44 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9D36BB371C; Mon, 21 Nov 2005 21:24:44 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 808DC140512; Mon, 21 Nov 2005 21:24:44 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q65sst3.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12477>

Hi,

On Mon, 21 Nov 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Note that there is only one pair per "pull" line, to allow for spaces
> > (urgh!) in the branch names.
> 
> I think "allow for spaces" nonsense can be removed by now.  I
> did it initially that way before making the ref name validation
> tighter with check-ref-format.  And if I understand what you
> wrote about multivalues correctly, your intent is that "orders
> do not matter"; with pull refspecs, orders do matter, so it
> probably is a good idea to allow only a single line.

Okay. (I also wondered how git-config-set could be used to replace the 
first pair, which is what gets merged when pulling).

> Personally I do not mind moving remotes/branches information
> there, except that I suspect the git-config-set interface makes
> it cumbersome to (1) find out what remotes I defined (i.e. an
> equivalent of "ls .git/remotes") and (2) remove a single remote
> when I do not want it anymore (--unset-all would remove the keys
> but would leave the empty section).

(1) git-var -l | grep '^remote\.'

(2) I would add --remove-section for that. (Though I'll wait to implement 
that until I know if people want it.)

> I am unsure if putting everything in .git/config file is the
> right approach, though.  What will we put there next?  ls-files
> ignore patterns?  grafts?  alternates?  We should be able to
> even get rid of .git/refs directory hierarchy and replace that
> with something like this:
> 
> 	[refs]
>         	head = ABCD1234ABCD1234ABCD1234ABCD1234ABCD1234	for master
>         	head = ABCD1234ABCD1234ABCD1234ABCD1234ABCD1234	for pu
> 		tag = ABCD1234ABCD1234ABCD1234ABCD1234ABCD1234 for v1.0rc1
> 	...
> 
> Where will we stop, and why?

Ahh! I have a clear picture of what *I* would put into it: all interesting 
static data about that particular repository which I would not like to 
version.

For that matter, .gitignore would stay where it is, though I'd also like 
to version grafts, i.e. move the location from .git/info/grafts to 
.gitgrafts (which would effectively end another thread on this list).

I would not like to version refs, evidently, or alternates. But the refs 
would not be static (they *want* to change often), while the alterates 
would be.

But I will not be a bugger about it. If things stay where they are 
(including .git/remotes), I will not be sad. There was just this crazy 
idea in my head (not the tip of the development branch, but the object my 
eyes are in), and I wanted to discuss it with you guys, just in case...

Ciao,
Dscho
