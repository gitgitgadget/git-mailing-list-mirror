From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Trouble merging renamed but identical files - CONFLICT (rename/rename)
Date: Sun, 29 Jun 2014 11:28:09 -0400
Message-ID: <CABURp0oy6LcZD1k7wx=JEg=iU0Z=SeWdNv3ZQHxSYpZWr=7+Dg@mail.gmail.com>
References: <B901ECBC8F944F039AFD6B53929FF18C@black> <CABURp0rFCxxpiQhRYXmN5eBnKhyyOeuFSTj0V1tGZJSNea5iEA@mail.gmail.com>
 <073A89A2555A4CD6AB28AF42078575ED@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Sun Jun 29 17:28:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1H1y-0001Lu-Sf
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 17:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbaF2P2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 11:28:31 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:64094 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbaF2P2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 11:28:30 -0400
Received: by mail-ve0-f176.google.com with SMTP id db12so7196845veb.35
        for <git@vger.kernel.org>; Sun, 29 Jun 2014 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=to0r3rf5mPzoAozIpWq67B4PIH09nmhv+aFRTWB8reU=;
        b=d999IwAqXDzff0yce+1P1ox3LGyZ2uHjiVAqVXhfU+G2FqdgWf2sFYp6AJ+Mm7h3sh
         76RMIVRUOPMj09vZa2SacyeDnqhXkLaNuGxnzxzJrIQ/E3yojfTHfrrH9A5vJAKlyYMk
         yfIhvUSDi0X/idzlM+VLGFUzDvdUBkX4Hk45ZMLDo7CSF6zm69CaSg3L0jnrhUxGa0Nz
         qIxzkJ0UQBDrKA2ancUNBf/+AU/Td8u/QeM5ikCnHV7VSn0P5pE+fbnPhwx1Ka4M8Zfu
         sqcbwVwwiS7mkOtUN1bh0lh2fmwwO+TauL40r9PVX0m7mhUQ5TJ+veeFc5aToqoTRXqo
         5PJw==
X-Received: by 10.52.163.208 with SMTP id yk16mr27178963vdb.36.1404055709154;
 Sun, 29 Jun 2014 08:28:29 -0700 (PDT)
Received: by 10.58.67.168 with HTTP; Sun, 29 Jun 2014 08:28:09 -0700 (PDT)
In-Reply-To: <073A89A2555A4CD6AB28AF42078575ED@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252643>

On Fri, Jun 27, 2014 at 6:39 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>> On Fri, Jun 27, 2014 at 4:47 PM, Jason Pyeron
>> <jpyeron@pdinc.us> wrote:
>> > There are two identical files from the same original
>> parent, but both were
>> > renamed in their own branches. One branch moved the file to
>> a new folder, the
>> > other renamed the file in the same folder.
>>
>> You have not stated what you think the issue is.  You have only stated
>> the setup.
>
> Thanks, I could have said it better.
>
> I think that git should understand that I have moved a file in path only (the
> tree object containing the file's entry change, but not the entry it self) and
> that the branch from which I want to merge back (with common ancestry) has
> renamed the file in the same path ( the tree object is unchanged, but the entry
> is) such that the object is re-parented and renamed in that path.

I think Git's perspective is that you have moved the file in both
contexts. The name of the file includes the path and filename.  The
fact is that you renamed the file in both branches.  If you had
renamed the file in only one branch, Git would have had a better
chance of figuring out the "right" thing to do.  Git tries not to do
something potentially dangerous without getting your involvement.

That said, Git's rename handling is stupid sometimes and could stand
to be improved.

> How can this be done in git or if it cannot what are the chalenges to patching
> git for this issue.

I do not know a better thing for git to do here.  I can imagine cases
where either choice is the wrong one.  If git silently makes the
choice and continues, say, during a rebase, you might not notice until
things have horribly awry.


>> ...
>> Maybe you meant to move the renamed file to the same folder where it
>> exists in the merge target.  I do not get a conflict when I do that.
>
> Are you saying I should git mv src/TrueCrypt.sln CipherShed.sln ?
>
> Then it will be in the wrong path as intended.
>
>>
>>    git reset --hard b60070f4d0879e277f44d174a163bbb292325fea
>>    git mv src/TrueCrypt.sln CipherShed.sln
>>    git commit -m 'renamed to be congruent with a0c84ff'
>>    git merge a0c84ff28f356bcb8b872a9c65a2e9bff97b3f68
>>
>> No conflict (on that file, anyway).
>
> Agreed, but not the desired end state.

Git's magic still has limits.

Phil
