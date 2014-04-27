From: Jeremy Morton <admin@game-point.net>
Subject: Re: Recording the current branch on each commit?
Date: Sun, 27 Apr 2014 18:38:13 +0100
Message-ID: <535D4085.4040707@game-point.net>
References: <535C47BF.2070805@game-point.net> <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeT1r-0000qX-J8
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 19:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbaD0RiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 13:38:10 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:42236 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbaD0RiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 13:38:09 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 1907D18A09AC;
	Sun, 27 Apr 2014 12:45:58 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247209>

On 27/04/2014 10:09, Johan Herland wrote:
> On Sun, Apr 27, 2014 at 1:56 AM, Jeremy Morton<admin@game-point.net>  wrote:
>> Currently, git records a checksum, author, commit date/time, and commit
>> message with every commit (as get be seen from 'git log').  I think it would
>> be useful if, along with the Author and Date, git recorded the name of the
>> current branch on each commit.
>
> This has been discussed multiple times in the past. One example here:
> http://thread.gmane.org/gmane.comp.version-control.git/229422
>
> I believe the current conclusion (if any) is that encoding such
> information as a _structural_ part of the commit object is not useful.
> See the old thread(s) for the actual pro/con arguments.

As far as I can tell from that discussion, the general opposition to 
encoding the branch name as a structural part of the commit object is 
that, for some people's workflows, it would be unhelpful and/or 
misleading.  Well fair enough then - why don't we make it a setting that 
is off by default, and can easily be switched on?  That way the people 
for whom tagging the branch name would be useful have a very easy way to 
switch it on.  I know that for the workflows I personally have used in 
the past, such tagging would be very useful.  Quite often I have been 
looking through the Git log and wondered what feature a commit was "part 
of", because I have feature branches.  Just knowing that branch name 
would be really useful, but the branch has since been deleted... and in 
the case of a ff-merge (which I thought was recommended in Git if 
possible), the branch name is completely gone.

> That said, you are of course free to add this information to your own
> commit messages, by appending something like "Made-on-branch: frotz".
> In a company setting, you can even create a commit message template or
> (prepare-)commit-msg hook to have this line created automatically for
> you and your co-workers. You could even append such information
> retroactively to existing commits with "git notes". There is also the
> current interpret-trailers effort by Christian Couder [1] that should
> be useful in creating and managing such lines.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/245874

Well I guess that's another way of doing it.  So, why aren't Author and 
Date trailers?  They don't seem any more fundamental to me than branch 
name.  I mean the only checkin information you really *need* is the 
checksum, and commit's parents.  The Author and Date are just extra 
pieces of information you might find useful sometimes, right?  A bit 
like some people might find branch checkin name useful sometimes...?

>> The branch name can provide useful
>> contextual information.  For instance, let's say I'm developing a suite of
>> games.  If the commit message says "Added basic options dialog", it might be
>> useful to see that the branch name is "pacman-minigame" indicating that the
>> commit pertains to the options dialog in the Pacman minigame.
>
> In that partcular case, ISTM that the context ("pacman-minigame")
> would actually be better preserved elsewhere. E.g. the commits touch
> files in a particular "minigames/pacman" subdir, or you prefix the
> context in the commit message ("pacman-minigame: Added basic options
> dialog"). Also, such a "topic" branch is often tied to a specific

Again, this is a pain because you have to remember to manually tag every 
commit message with "pacman-minigame", and it takes up precious space in 
the (already short) commit message.

> issue in some bug/issue tracker, and it would in any case be natural
> to mention the bug/issue ID in the commit message, at which point the
> tracker can provide more context and discussion.

I think it would only be natural to mention the bug# in the final commit 
that actually fixes the bug or implements the feature, not the checkins 
leading up to that.  And, it's still not *guaranteed* that the coder 
will remember to put the bug# in even that commit message.

>> Basically,
>> I'm saying that well-named branches can and do carry useful contextual
>> information that oughtn't to be thrown away.  Currently, when you delete
>> that branch, you lose the branch name altogether.
>
> Some would argue that branches are not always well-named... But

But when they are, why should that info be thrown away?  When they're 
not well-named, they can be ignored (or the branch name recording 
feature can be turned off!)

> anyway, if the branch ends up getting merged to the mainline, the
> merge commit defaults to a message like "Merge branch
> 'pacman-minigame'".

Only if it's a non-ff merge, which results in less tidy commit trees, 
and hence is often recommended against.  Whatsmore, tracking down which 
branch a commit pertains to is still rather difficult using this 
approach.  You can go back through the history and find "Merge branch 
'pacman-minigame'", but how do you know which commit was the *start* of 
that branch, if they are not tagged with the branch name?

-- 
Best regards,
Jeremy Morton (Jez)
