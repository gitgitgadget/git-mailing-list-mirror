From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: git apply won't work
Date: Thu, 12 Mar 2009 20:09:44 -0400
Message-ID: <3e8340490903121709w6c6c444o10e7c8b655246373@mail.gmail.com>
References: <a6d7dc140903121614s229ce97an2cb5737ef46c0421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Paraskevov <martin.paraskevov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 01:11:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhuzj-0002Gk-54
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 01:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbZCMAJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 20:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbZCMAJr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 20:09:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:6087 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZCMAJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 20:09:46 -0400
Received: by yw-out-2324.google.com with SMTP id 5so63322ywh.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 17:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=N+jgpKEqPQ7w+1taWTCFCR6ejlGbjxpoEfYMyDWZk/E=;
        b=MmJTx2f76MoZSiyx8WrxKgZmHs0EGbzeP/rnFTgM3/xaBNz6NqhvjMT8r9tjfpS8i9
         EOZatv+dY5V2n5DY0rwbPnwAwenILN8QBzVDc5PC1E3cWk17mmPMFhDwFqH7/tTiHTxQ
         X0pWKN53kZix0dFsQ1zpsvaz/YUrwY6vN6aWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mFinQxB+z6SUk7oGy1fv4cKWMCb28yGiczg/JNP3HF2vrNQ/iyF06WjduVl99ApNq+
         5jkJIgUXvI/ee9uS8dP5BhCrD3HicGgvAiFRnYGgw3/QawDKLJ7FhhlbU4v1lwDcMQWZ
         sLEu6bZ8g6fkdtav/ANEetLEQQ1cDdkZoDnts=
Received: by 10.220.87.4 with SMTP id u4mr438356vcl.28.1236902984467; Thu, 12 
	Mar 2009 17:09:44 -0700 (PDT)
In-Reply-To: <a6d7dc140903121614s229ce97an2cb5737ef46c0421@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113127>

On Thu, Mar 12, 2009 at 7:14 PM, Martin Paraskevov
<martin.paraskevov@gmail.com> wrote:
> Hi all,
>
> I did the following:
>
> edited
> did commit 1
> edited
> did commit 2
> edited
> did commit 3
>
> Now I want to patch the changes between 2 and 3 onto 1, i.e. have commit 3 but
> with the changes from commit 2 removed. I created a branch where I reset
> it to commit 1 and then tried to apply the diff between 3 and 2.
>
> The patch however won't patch certain files. It contains the excerpt below,
> for example, so it should be patching directory.c but it isn't. The command
> I'm running is just:
>
> % git apply filesys.patch
>
> What am I doing wrong?


It's hard to say what's going wrong when we can't see the exact
errors, git tree and patch in question, but if you just want to remove
a patch, there are easier ways to do it.

If you want to keep the old patch in the history, but reverse it, do:
  git revert commitid
This will record a new commit that reverses the changes in the
indicated one. This is the recommended way to do things if others have
based work off your branch.

If you want to completely forget about the patch in question, you can
do this using git rebase --interactive:
  git rebase --interactive commitid~
  (an editor will open; remove the patch in question from the list,
save and exit your editor)
  (fix any conflicts that come up as prompted)
This will delete it from history, but will result in commit IDs for
commits after that point changing. If anyone has based work off your
branch, then you might have a hard time merging later.
