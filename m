From: Junio C Hamano <junkio@cox.net>
Subject: Re: Branch relationships
Date: Sun, 14 May 2006 14:20:45 -0700
Message-ID: <7vr72w2thu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
	<200605141457.17314.Josef.Weidendorfer@gmx.de>
	<7v7j4o33wc.fsf@assigned-by-dhcp.cox.net>
	<200605142249.17508.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 23:21:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfO1C-0006RU-3C
	for gcvg-git@gmane.org; Sun, 14 May 2006 23:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWENVUr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 17:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWENVUr
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 17:20:47 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:12424 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750969AbWENVUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 17:20:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514212046.NVFE15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 17:20:46 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200605142249.17508.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sun, 14 May 2006 22:49:17 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19983>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Sunday 14 May 2006 19:36, Junio C Hamano wrote:
>> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
>> 
>> > On Saturday 13 May 2006 23:22, you wrote:
>> >>  * remotes/ information from .git/config (js/fetchconfig)
>> >> ...
>> >>    [branch "master"]
>> >> 	remote = "ko-private"
>
> I still do not understand the semantic of this line.
> Is this supposed to do "git pull ko-private" as default pull
> action and "git push ko-private" as default push?
>
> So using
>
>>   ; my private build areas on the kernel.org machines
>>    [remote "ko-private"]
>>         url = "x86-64-build.kernel.org:git"
>>         url = "i386-build.kernel.org:git"
>>         push = master:origin
>> ...
>
> specifies that "git push" should push to both URLs?

Exactly.  I would _want_ to push to both with single action when
I say "git push ko-private".  Actually I have _never_ felt need
to, but Linus wanted it first and I think it makes sense.

> This is really confusing: Is the remote "ko-private" now at
> "x86-64-build.kernel.org:git" or at "i386-build.kernel.org:git" ?

Neither.

Perhaps reading my comment on #git log from yesterday or so,
where I talk about ".git/branches is about configuration
per-local branches, and .git/remotes is about giving a
short-hand to remote repositories that are used often",
might be helpful.  

> Neverless, I missed the info "Which branch should be merged in a default
> pull after fetching the given branches from remote". I understand that
> this is not needed in your workflow, as you have no upstream.

Not with git but in other projects I do.

That is what "branch.foo.remote = this-remote" is about.  When
working on foo branch, use what is described in
remote."this-remote" section for "git pull".
remote."this-remote" would have url and one or more fetch lines,
and as usual the first fetch line would say "merge this thing".
This gives the continuity in semantics while migrating from
.git/remotes/foo to [remote "foo"] section of the config file.

>> >  [branch "ko-master"]
>> >     tracksremote = "master of ko-private"
>> >
>> > This also would specify that we are not allowed to commit on "ko-master".
>> 
>> For my workflow, it is "master of ko"; your notation expresses
>> the same constraints more explicitly by being more special
>> purpose
>
> Why is this more special purpose?

It is more special purpose than just saying "do not touch this
myself".  You are saying "do not touch this myself because it
tracks a remote".  I do not think it is necessary to state the
reason.

> Perhaps an option "when pulling into this branch from a remote, also fetch
> all branches tracked from this remote", or another one "when fetching/pulling
> into this branch, update all other branches, too".

You already have "when fetching from this remote, fetch all
these branches and store them in the tracking branches", and
that is what .git/remotes/ is about.  The [remote] section in
the configuration file has the same semantics.  What problem are
you trying to fix by doing things differently?
