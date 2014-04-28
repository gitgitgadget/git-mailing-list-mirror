From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 08:45:43 +0200 (CEST)
Message-ID: <20140428.084543.1615507400056684596.chriscool@tuxfamily.org>
References: <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	<535D6EB1.9080208@game-point.net>
	<CALKQrgdFLc=k9i1+N2458amLMGQa99q55A=N785VfMRwfOH6Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: admin@game-point.net, git@vger.kernel.org
To: johan@herland.net
X-From: git-owner@vger.kernel.org Mon Apr 28 08:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WefKM-0001pf-Uz
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 08:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbaD1GqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 02:46:06 -0400
Received: from [194.158.98.45] ([194.158.98.45]:51983 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751502AbaD1GqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 02:46:05 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id E873B6C;
	Mon, 28 Apr 2014 08:45:43 +0200 (CEST)
In-Reply-To: <CALKQrgdFLc=k9i1+N2458amLMGQa99q55A=N785VfMRwfOH6Rg@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247240>

From: Johan Herland <johan@herland.net>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 01:39:26 +0200

> On Sun, Apr 27, 2014 at 10:55 PM, Jeremy Morton <admin@game-point.net> wrote:
>> On 27/04/2014 20:33, Johan Herland wrote:
>>> On Sun, Apr 27, 2014 at 7:38 PM, Jeremy Morton<admin@game-point.net>
>>> wrote:
>>>> On 27/04/2014 10:09, Johan Herland wrote:
>>>> As far as I can tell from that discussion, the general opposition to
>>>> encoding the branch name as a structural part of the commit object is
>>>> that,
>>>> for some people's workflows, it would be unhelpful and/or misleading.
>>>> Well
>>>> fair enough then - why don't we make it a setting that is off by default,
>>>> and can easily be switched on?  That way the people for whom tagging the
>>>> branch name would be useful have a very easy way to switch it on.
>>>
>>> Therefore, the most pragmatic and constructive thing to do at this
>>> point, is IMHO to work within the confines of the existing commit
>>> object structure. I actually believe using commit message trailers
>>> like "Made-on-branch: frotz" in addition to some helpful
>>> infrastructure (hooks, templates, git-interpret-trailers, etc.) should
>>> get you pretty much exactly what you want. And if this feature turns
>>> out to be extremely useful for a lot of users, we can certainly
>>> consider changing the commit object format in the future.
>>
>> OK, fair enough.  So I guess what I'd like to see, then, is good built-in
>> functionality in Git for these commit message trailers, so that they are
>> very easy to turn on.  I'd like to be able to tell co-developers to add a
>> one-liner to their git config file rather than some post-commit script.
> 
> I think this is what the interpret-trailers effort is about.
> Unfortunately I have not followed it closely enough to say if your use
> case is already covered by Christian's (CCed) work. Christian: With
> your current patch series, is it possible for Jeremy to configure
> interpret-trailers to automatically append a "Made-on-branch:
> <current_branch>" trailer whenever he creates a commit?

Yes, it's possible. Yesterday, I sent the following patch:

[RFC/PATCH 2/2] trailer: add examples to the documentation

and it shows a commit-msg hook to do something like that:

$ cat >.git/hooks/commit-msg <<EOF
#!/bin/sh
git interpret-trailers --trim-empty --trailer "git-version: \$(git describe)" "\$1" > "\$1.new"
mv "\$1.new" "\$1"
EOF
$ chmod +x .git/hooks/commit-msg

I think you just need to use the following if you want the branch
instead of the git version:

git interpret-trailers --trim-empty --trailer "git-branch: \$(git name-rev --name-only HEAD)" "\$1" > "\$1.new"

It could even be simpler if there was an option (which has already
been discussed) that made it possible to modify the file in
place. This way one would not need the 'mv "\$1.new" "\$1"' command.

Best,
Christian.
