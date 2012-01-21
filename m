From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Finding all commits which modify a file
Date: Sat, 21 Jan 2012 17:16:52 -0600
Message-ID: <4F1B4764.3010501@gmail.com>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neal Groothuis <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Sun Jan 22 00:17:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RokBC-0008CJ-1k
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 00:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052Ab2AUXQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 18:16:57 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40289 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab2AUXQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 18:16:56 -0500
Received: by ggnb1 with SMTP id b1so885821ggn.19
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 15:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=s0KJHB8kopsgOgPPp0thr+GqZXB4LC5kKvk7tyLhqdM=;
        b=AUq+LMd9GHma+NOPrlOpG66siAf5HQqY35KdXw7RXz9SsMau5EnHmftG0ydyQFqMHE
         wlUOE/APQlN3aO4qUQZszNFfpqTTxhqhVaf0404QbWviue4GxGFIwAgRm+5QGJ8GKMN+
         7eYCVm3Qr8040wHhHhNgp2ITjzD2EyFb6bs5o=
Received: by 10.101.185.1 with SMTP id m1mr1367651anp.21.1327187816306;
        Sat, 21 Jan 2012 15:16:56 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id y58sm12983693yhi.17.2012.01.21.15.16.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Jan 2012 15:16:55 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188941>

On 1/20/2012 3:35 PM, Neal Groothuis wrote:
> Hello,
>
> I'm trying to find /all/ commits that change a file in the
> repository...and its proving to be trickier than I thought. :-)
>
> The situation that we were dealing with is this:
>
> - Person A and person B both pull from the same central repository.
>
> - Person A makes a change to file foo.txt and bar.txt, commits, and pushes
> to the central repository.
>
> - Person B makes a similar change to bar.txt and commits it.
>
> - Person B does a fetch and merge.  Since both A and B made changes to
> bar.txt, this requires conflicts to be resolved manually.
>
> - B reverts A's changes to foo.txt. (If B is coming from a different
> revision control system, this may happen due to confusion about how merges
> are handled.)
>
> - B commits the changes.
>
> - B makes more changes to bar.txt, commits them, and pushes to the central
> repository.
>
> At this point, A's changes to foo.txt have been undone.
>
> Graphically:
>
>      A1
>     /  ^
>    v    \
>    C1   B2<-B3
>    ^    /
>     \  v
>      B1
>
> B1, B2, and B3 have the same version of foo.txt as C1, A1 modifies it.
>
> Person A discovers that his changes are missing and wants to know what
> happened.
>
> git log foo.txt doesn't help; it won't even show commit A1, due to history
> simplification.
>
> git log --full-history foo.txt will show commit A1.  It still won't show
> commit B2, though, which we'd also like to show (because that's where the
> change to foo.txt got removed).
>
> I would think that git log --simplify-merges foo.txt would have done what
> I'd wanted, but it still does not show commit B2.   Based on what I'm
> reading in the man page, I would expect the simplification to go like
> this:
>
>      A1
>      | ^
>      |  \
>      |  B2<-B3
>      |  /
>      v v
>      C1
>
> (since B1 is TREESAME as C1 if we're only considering foo.txt)
>
>      A1
>      | ^
>      |  \
>      |  B2<-B3
>      |
>      v
>      C1
>
> (since C1 is an ancestor of A1)
>
> However, the actual output only includes A1, not B2.
>
>   - Can someone explain this, and/or
>   - can someone offer a command to display all commits (including merges)
> in which ANY parent is not TREESAME?
>
Does git-log --all help?

v/r,
neal
