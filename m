From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 13:52:18 -0700
Message-ID: <4FA04D02.6090702@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue May 01 22:52:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPK45-0008Sp-Vd
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 22:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab2EAUwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 16:52:21 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:23146 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab2EAUwU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 16:52:20 -0400
X-IronPort-AV: E=Sophos;i="4.75,513,1330934400"; 
   d="scan'208";a="13248636"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 01 May 2012 13:52:19 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q41KqIgO001665;
	Tue, 1 May 2012 13:52:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <86havzoi8h.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196743>

On 5/1/12 11:42 , Randal L. Schwartz wrote:
>>>>>> "Rich" == Rich Pixley<rich.pixley@palm.com>  writes:
>
> Rich>  What I'm talking about is the situation where a branch can have multiple,
> Rich>  childless commits.  I've switched to calling these "tips" for this
> Rich>  discussion.
>
> But in git, a branch *is* what you're calling a "tip".

And therein lies the problem.

> What do you find lacking about git branches, in terms of sharing?

A number of situations.  But the short answer is that git completely 
lacks the ability to cope with potential collisions in the repository - 
even collisions that can be handled completely automatically, even when 
the collision can be handled completely in the repository graph, (as 
distinct from lexical or file content resolutions).

I want to be able to fetch changes to the branch I currently have 
checked out.  Git blocks this because it doesn't know how to cope with 
the working directory in that situation.  Merging is straightforward. 
Even updating, (checkout), is fairly straightforward.  But the 
insistence on a single tip means that if I commit directly to a non-tip 
commit, git doesn't know what to do with the branch pointer.  If it 
leaves it at my commit, then the other changes are essentially orphaned. 
  If it leaves it at the other changes, then my commit is essentially 
orphaned.  While it's probably possible to force git to do this anyway, 
including orphaning one set of changes, doing so is of limited value 
since the git interface makes the assumption that branches have a single 
tip anyway.

Pushing is blocked in git.  Git simply refuses some push requests which 
have obvious and fairly straightforward semantics.  There are ways in 
git to accomplish the more general task of information exchange by 
reversing the initiation request, (pulling), by partitioning the data 
into branches, etc.  But the straightforward, intuitive request to push 
is, in git, frequently blocked for no particular reason.  (Pushes are 
analogous to the previous situation of fetching to my current branch.)

You and I want to share a branch and we each have local, unattended 
cache/mirror repositories that we would like to use to pass data between 
us.  This doesn't work in git because the first time you and I make 
simultaneous changes, whether they collide or not, the unattended 
repositories become wedged.  They each refuse to talk to the other until 
someone manually unwedges them.

I want that if you and say, Sitaram commit conflicting changes to a 
shared branch, it's easy for me to recognize that the conflict exist and 
easy for me to resolve that conflict in my own repository.  I want the 
source code control system to keep track of those things, show them to 
me/us, and to track and show my resolution to you.  This stuff should 
all be automatic.  It shouldn't require explicit testing, manual 
pulling, nor explicit discussion between the three of us.  It shouldn't 
prohibit that either, but it shouldn't require it.

These are all fairly common situations today.  And it wouldn't be so bad 
if nothing else solved these problems either.  But we've had source code 
control solutions that solved all of these issues for over a decade now. 
  Going backwards to git seems like a pain in that context.

--rich
