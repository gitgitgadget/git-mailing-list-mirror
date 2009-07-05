From: Stefan Bucur <stefan.bucur@gmail.com>
Subject: Re: Wrong file diff for merge conflict
Date: Mon, 6 Jul 2009 01:23:44 +0300
Message-ID: <8cdebd3f0907051523q73494603ka8a50b19b1238a@mail.gmail.com>
References: <loom.20090704T072854-229@post.gmane.org> <alpine.LFD.2.01.0907051113240.3210@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 06 00:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNa87-0006Sl-17
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 00:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbZGEWYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbZGEWYD
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 18:24:03 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:49945 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbZGEWYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 18:24:01 -0400
Received: by fxm18 with SMTP id 18so3532328fxm.37
        for <git@vger.kernel.org>; Sun, 05 Jul 2009 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OvratJl7YYcwZOmA0D7ylF9TBQyO5aQ7cAvTFgwGZYw=;
        b=Lgr21C3H68x8nqRGCRJno0W/tiJyR+H1aYYozcNFVGZLkp8k8b4a071UMoT5SaY8JS
         Vh5OLvdsqXqdCWXpgdlt1LbYhIo2wBVLFOwY0ceZ+2J40/zjQxHzhxi7BHP8hFE3jHzp
         DC20+fYn8SVwSjlBghVLalGWaS7e7BfZPhXK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YsezHwnSN+JwxjQ/PvwvBv0niK1jjvMR7i0Kx6hvBjQIo9VFzAEIMXqoo9lGKdqyD7
         OKLYf6Td4VRSbC5c3Jn9a0CBM5TqB9zK5dOVSkBV3EXVXL7WFZFuqFUwYxvgXAywRPjK
         uXrOHE/moV72+cOnywl43fq7E4cyBZDtOatYI=
Received: by 10.223.106.135 with SMTP id x7mr1686597fao.48.1246832644070; Sun, 
	05 Jul 2009 15:24:04 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0907051113240.3210@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122763>

On Sun, Jul 5, 2009 at 9:43 PM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
>
>
> On Sat, 4 Jul 2009, Stefan Bucur wrote:
>>
>> http://pastebin.ca/1483228
>>
>> The problem is with the last diff in the file, where the left portion is empty,
>> and the right portion contains code which already was marked as merged (common),
>> right before the start of the diff. Therefore, the mark at line 127 should
>> really have been before line 114.
>>
>> Is this a bug or I am missing something?
>
> I suspect (but without the origin files/history I can't verify) that what
> happens is that the "successfully merged" code was seen as a fully new
> snippet of code (probably due to getting re-indented?), and the other part
> of that action on that branch was the removal of the old code.
>
> That _removal_ is then shown as a conflict against the other branch, which
> presumably didn't re-indent things (of course, it could be exactly the
> other way around too), and so now you end up having the "conflict" being
> seen as "one branch removes this code (empty conflict part), the other one
> presumably changed it some way".
>
> Is that what you wanted? Obviously not. To you, the conflict makes no
> sense. You're a human, who tries to understand what wen't wrong, and to
> you, the end result of the conflict resolution makes no sense.


Thank you for your suggestions for a better and more efficient merging
experience, as I'm sure they will help me from now on. However, I
think I did not make myself clear: I was not arguing the fact that the
merge result was suboptimal, but the fact that _the generated conflict
file is semantically wrong_. So, to reiterate, we have this git
generated file:

http://pastebin.ca/1483228

Basically, if one would take the common (successfully merged) parts
and keep the "left" parts in the conflict sections, one would obtain
the first branch version of the file (with minor modifications).
Similarly, if one would opt to keep only the "right" parts in the
conflict section, one would obtain the version found in the second
branch before merge.

However, this is _not_ true in my case. If you take the last conflict
section in the file, if you would keep the left part, you would obtain
the correct left branch file, while if you keep the right part, you
would obtain duplicate code (the common code right before + the
disputed part). And that's why I think this is wrong behavior.

Moreover, now I was able to trigger the bug in a way that leads to
_data loss_. You can find here [1] an archive with a simple git
repository with two branches, "a" and "b", right after a merge between
the two, in a conflict state. The conflict file contains code which is
missing data in one of the two diff sides:

http://pastebin.ca/1485051

You can notice, in the first conflict section, that the right brace of
the inner structure is present in the left part, while it is missing
in the right part (feel free to reset the merge and do it again to see
it for yourself). If you would blindly select the right part for
conflict resolution, you would get erroneous code.

Do you still think it is not a bug?

Thank you,
Stefan Bucur


[1] http://terminus.zytor.com/~stefanb/git/testrepo.tgz
