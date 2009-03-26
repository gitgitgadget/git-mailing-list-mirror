From: "Etienne Vallette d'Osia" <dohzya@gmail.com>
Subject: Improve tags
Date: Thu, 26 Mar 2009 13:48:11 +0100
Message-ID: <49CB798B.4090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 13:50:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmp29-0002ru-4h
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 13:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbZCZMsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 08:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbZCZMsR
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 08:48:17 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:53526 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbZCZMsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 08:48:16 -0400
Received: by bwz17 with SMTP id 17so517297bwz.37
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=Lj1js7oWwV5mmY1ytiKL4zICd6Vdt/Xkm3HqaPu3/bI=;
        b=i3M6DHw+/yZkVriV5xixffp+hT5dS0KDH3SzTPyqPWsRwgQU/OsHr7vQ0sbeEDJPKN
         ui6VTBf+xrU8wUDanyFYI1+vxlz5jO1Hxs/2u1q2/54AcbrVLsG6rZ5qz7jDYQplpXJw
         bWNrbchm6phkrNzxhN0icgkxSBrW/Azub7kcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=KzeFVG+41TWOhV/ME+PwUYDGKFzqP3dcttSKB+qlsXdYjjp+mGs4/H82T6iNWbQ/5v
         CAcDktodRlejqM+WLg+98+S4vOgaqU4oITL5cTb7UqZsYxLONdFZ33PvFvIudYX9ndCj
         cXfVV62DhalX50XiRGEjqyqj64PhduYACM98o=
Received: by 10.103.244.19 with SMTP id w19mr368691mur.134.1238071693145;
        Thu, 26 Mar 2009 05:48:13 -0700 (PDT)
Received: from schubby.inria.fr (schubby.inria.fr [138.96.218.89])
        by mx.google.com with ESMTPS id j6sm468126mue.4.2009.03.26.05.48.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 26 Mar 2009 05:48:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114773>

Hi,

I search a way to track commits in function of their aim.

I tried to use branches (test, debugger, etc).
For example if I search the commits related to tests,
I can search all commits what are in branch test and not in branch debugger,
but it's boring (I need to exclude all other branches than test)
Moreover, if I remove a branch, it will complicate the search.

In addition, branches are a way to specify streams,
not a way to specify an aim for a commit.
(like in ruby a class is a method container, not a type)
So branch names are often like next, pu, dev, test, stupid-idea, etc.
They are totally useless for tracking aims.

The method used in every repositories I looked into
is to use the "aim: subject" form in their commit messages.
So search all commits related to a specific aim is equivalent
to grep "my-aim:" in commit messages.
The problem is that this method is not used in all commits
("aim - subject" or just "subject" are used too),
so I can't assume to find all commits with a such method...
And if a search a more generic form ("test"), I might find
useless commits that will pollute my results...

The last method I can find, is to use tags.
But, as CVS and many others do, tags are unique.
It is usefull for tagging a software version number,
but not for tracking.

So, we have branches, which are not stable,
tags, which are unique,
and commit messages, which are not normalized.

What can we do ?

In my mind, the good ways are to improve the commit message way,
or, better, to change the current tag concept.

One improvement could be to add a mechanism similar to "signed-off-by:"
message: add an option in git-commit to facilitate the creation of "tags"
and make sure these "tags" will be normalized...
example: `git commit -t test,debugger -m "add test for debugger"`
         this will create a commit and add automatically
         "test: debugger:" at begin or
         "tags: test, debugger" at end of the message
           (like the "signed-off-by: xxx" lines)
It's not really better this current solution,
but it's a first step to normalization.

There is still a big problem with this solution : this tags are immutable,
as they are stored inside the commit.

An other improvement would be to create new version of tags.
`git tag v1.6.3` would create a unique tag, and
`git tag --no-unique test` would create a simple tag.
(until we can change the default)
The -t option of git-commit is still possible,
but it will call the new git-tag.

Note: Theses tags may be treated like refs (git log fault-tolerance),
but they can't be stored in $GIT_DIR/refs directory,
as they reference a list a commits...

So, I see 2 solutions:
- Normalize the way to write tags but keep them into commit message:
  (-) There will be 2 sorts of tags: static immutable and dynamic unique
  (+) This way is totally retro-compatible
- Change the tags concept:
  (-) Need to change the tag object format (ouch)
  (+) More powerful

Maybe I have missed a better tool to do my job ?
Or there is a better improvement which is more simple ?


Best regards,


Etienne Vallette d'Osia

ps: I'm really sorry if my message is full of English errors...
