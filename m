From: fREW <frioux@gmail.com>
Subject: Re: Deleted files can't be checked back out?
Date: Sun, 25 May 2008 18:37:27 -0500
Message-ID: <fb3648c60805251637p70bc76fdm1947da6b9bf34ca1@mail.gmail.com>
References: <fb3648c60805222128v1a425c60kc8e44f3a2fb41d54@mail.gmail.com>
	 <20080523062821.GA24411@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Chris Frey" <cdfrey@foursquare.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 01:38:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0PnA-000591-Gt
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 01:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbYEYXh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 19:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbYEYXh2
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 19:37:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:41613 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYEYXh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 19:37:28 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2038039rvb.1
        for <git@vger.kernel.org>; Sun, 25 May 2008 16:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/0R9wUuHffHUlWC+SK+K4L90mT3BIfg1aofyQsCB3UI=;
        b=SBzyeLDTjNARl8KtHR6q2bk9WSQxuxIrjNlU+J5Mb8nG9x+qF7K54MnVxX9zl0gLkRUE/lq3EBG7/bBxeaxFGqDIyx49/MqhkiI8d+DDWcbB98ARmfEVndHimGxKogb2Wex4dSxFxs8GAWtaXeGzAHecjvmzZleVM9Ouc5oL9Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k5dUbL0ffa/l0Uwywt9rXhyUr5jNCvCeKHHX+lWWNV0MksY4XkmyXHY9mntgMsP0QbVMBVr6kaRhTZebq8xBkzurLPRA3Mc1bwfzDBbPqrH5OrCcLxvvSBMB49JrcTtTv57CC0yG+4yvqUGjTh3JKODrzTKvSwsakP9UcHWMm6M=
Received: by 10.140.193.15 with SMTP id q15mr1868491rvf.191.1211758647718;
        Sun, 25 May 2008 16:37:27 -0700 (PDT)
Received: by 10.141.48.1 with HTTP; Sun, 25 May 2008 16:37:27 -0700 (PDT)
In-Reply-To: <20080523062821.GA24411@foursquare.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82883>

Just FYI, git revert was exactly what I needed.  If you want to undo
any commit at all git revert is your friend.

Thanks!

-fREW

On 5/23/08, Chris Frey <cdfrey@foursquare.net> wrote:
> On Thu, May 22, 2008 at 11:28:57PM -0500, fREW wrote:
>> I recently deleted a bunch of files and checked the change into git,
>> and then changed my mind and wanted the files back.  I did a
>> git-checkout <file> and got each file back individually.  Then I did
>
> I believe you want to undo the change you made (deleting files), not
> just view an old version of the file, which is what checkout does.
>
> You can either add it back yourself, or you can undo the last commit, using
> git-reset.
>
> Here's an example of what you could have done before making further
> changes that you wanted to push:
>
> 	git rm file
> 	git commit
> 	git log			# view your change
> 	git reset --hard HEAD^	# go back to the HEAD before your change
>
> Think of the chain of commits as a long linked list of changes.  A branch
> head is just a pointer to the top of that linked list.  git-reset allows
> you to point that HEAD to anywhere in the list, even after going back
> in history.  The commits are still there, even if HEAD doesn't explicitly
> point to them.
>
> For example, say git log shows commit 1a2b3c4 as HEAD, with commit 7abc983
> as its parent.  You can move the HEAD back and forth, like this:
>
> 	git reset --hard 7abc983
> 	git log			# commit 1a2b3c4 is gone!
> 	git reset --hard 1a2b3c4
> 	git log			# now it's back!
>
> But in your case, you now have a list of commits that is missing files:
>
>         A -> B -> C
>              |    |
>              |    (made changes here)
>              |
>              (deleted files here)
>
> So in this case you likely want to revert commit B, while keeping commit C.
>
> 	git log			# get the commit SHA1, let's say it's 04bcb93
> 	git revert 04bcb93
>
>
> Take a look at "Git from the bottom up"
> 	http://www.newartisans.com/blog_files/git.from.bottom.up.php
>
> - Chris
>
>
