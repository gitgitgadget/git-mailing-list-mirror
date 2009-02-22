From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: How to list files that are pending for commit from a merge, 
	including hand modified files
Date: Sat, 21 Feb 2009 18:09:59 -0800
Message-ID: <e38bce640902211809u70c0de2el96a2df0238bc671@mail.gmail.com>
References: <e38bce640902211520j3f3c2787y28640b0ebcba5e27@mail.gmail.com>
	 <alpine.LFD.2.00.0902211523280.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 22 03:11:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lb3og-000195-WE
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 03:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbZBVCKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 21:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbZBVCKB
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 21:10:01 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:50263 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbZBVCKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 21:10:00 -0500
Received: by gxk22 with SMTP id 22so3970195gxk.13
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 18:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e/BGL0nJlAh+qTnq+bKYoXNOlaXUu7TL4GuxMi9bcDk=;
        b=r81h5wZ4TX9g6AVlFckXa7r1L823gTS7xJjhWjBfuvSWtYXYN9a0TlxHIBWNC9HZHQ
         v0j8u8eTwtbtWgrnfqUFdjXxdpcdPuIkOVyhnpAxd6VQoB34494P/hcigTdhDIufQ7Zs
         g3vAtntU4XtstIeJ1W0z2WLU1m4doankVJdno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cYOkz5/xQsKBKZDw75b7/SqtU2EBKf5i2S4vq4yfGIIWuWmE6EiUtq4W2tIWU3qL+1
         wDQUxo0M6f0dmfeBDF7wIbw5uOUOz31sr3Ps5xlT3AhZT1QUKql+W8INCrglibHOJFq0
         9ar8GG9FBqMem+yJ1gXvsyjefUGJ1zxgbBqBY=
Received: by 10.90.90.4 with SMTP id n4mr699997agb.65.1235268599355; Sat, 21 
	Feb 2009 18:09:59 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0902211523280.3111@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110991>

Thanks very much!  I'll have to play around with those variations a
bit to get a feel for what will work in my context.

bg

On Sat, Feb 21, 2009 at 3:29 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Sat, 21 Feb 2009, Brent Goodrick wrote:
>>
>> Is there some way in which to get a listing of the files that git-status
>> shows in its "changes to be committed" section, but not the "Untracked
>> files" section, short of postprocessing the git-status output with
>> sed/awk gymnastics?
>
> Just do variations on
>
>        git diff --name-only HEAD
>
> and the reason I say "variations on" is that depending on exactly what you
> want you may want to use slightly different diffs.
>
> For example, the command line above will list all files that are changed
> in the working tree wrt HEAD. But if you want to see only the files that
> you have actually updated in the index (ie the ones that would be
> committed without using "-a"), you should add "--cached" to the command
> line, so that it does the diff from HEAD to index, not HEAD to working
> tree.
>
> And if you want to see what files are different in the working tree from
> the index, then drop the "HEAD" part, since that's the default behavior
> for "git diff".
>
> Finally, use "--name-status" if you want to see if they are new, modified,
> or deleted - rather than just the name.
>
> And if you care about renames, and want to see them as such, use -C or -M,
> of course.
>
> So "git ls-files" is not at all what you want. That will give you
> information about the current index, but doesn't talk at all about how it
> differs from the previous commit or from the working tree. It can be
> useful for another thing, though: if you're in the middle of a merge, then
> you can ask for which files are marked as being unmerged in the index.
>
>                Linus
>
