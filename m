From: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
Subject: Re: [PATCH] git-completion: add stashes for gitk
Date: Fri, 13 Mar 2015 18:25:48 +0100
Message-ID: <CANAO8VEUu9erxMLU523vQhg1hyfwVASH-Ng6YGKTN0RiB+H9FQ@mail.gmail.com>
References: <1426120961-2273-1-git-send-email-sveinung84@users.sourceforge.net>
	<xmqq1tku3x3c.fsf@gitster.dls.corp.google.com>
	<xmqqioe62h5g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 18:25:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWTLO-0001i4-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 18:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbbCMRZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 13:25:50 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:45328 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbCMRZt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 13:25:49 -0400
Received: by igjz20 with SMTP id z20so1892875igj.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1ZzwPmJu3Sh4Kjfmwzuh7TsO7CCu4YzQR5pGbMujnSw=;
        b=TLCSdDMM+ets8yNpjDtj5vItzElLKwCFEdFZtMOuwdsdSoKBQH8MIhJDpWIrkwUPo+
         aAMrGEinX7pordvQ0aaiaQCmGKecM52LLd7lFDtoTkYUVDjjtgDgTfFH2X3UOzLs6Ktd
         JLqneP2/R20KiDOZElzothWgz3THSXwU7MKdBmLRxOE6AxtujlHT/qZQQ5eQ3jk7Vbz4
         SMskKuByJU1CAqXwNGpNaSajMSecL8C1bz6gjmG8HMkVANOI4x5KU/K07tPRyIYYxwHS
         fys6tOCEmQWmodhHnluMvhTY3oL1la/7IBfIQDw7etJQR9twX5uZNvndrr6qTJi4J6RL
         CAEA==
X-Received: by 10.107.37.132 with SMTP id l126mr86625089iol.42.1426267548348;
 Fri, 13 Mar 2015 10:25:48 -0700 (PDT)
Received: by 10.36.1.205 with HTTP; Fri, 13 Mar 2015 10:25:48 -0700 (PDT)
In-Reply-To: <xmqqioe62h5g.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: QEPCZS_41ZnE2L3TTXGFjFFDzyE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265416>

Thank you for the review.

I now understand that the commit message should have provided way more
context about my use case.

I used Bazaar almost exclusively until about a year ago. Git's ability
to put stuff in the index without committing and the power of "git
rebase" covers many of the use cases I would have used shelves
("stashes") for in Bazaar. But a stash is still, as far as I know Git,
the best solution in some cases.

A Bazaar shelve ("stash") has a stable number. (Applying a shelve from
the middle of the list won't cause a renumbering) A git stash will
change its number when a new stash is added. (On the positive side
this allows stash@{2.hours.ago}) The renumbering makes it more
difficult to keep track of what is there. I therefore have more need
of a quick way to get an overview of the stashes in git than in
bazaar. You idea of using a stash's message to refer to it would solve
this.

In Bazaar I can quickly get an overview of the shelves ("stashes") by
typing "bzr qshelve" and clicking on the "View shelved changes" tab.
Its has a list of my shelves including their number and message at the
top. Under it the diff of the currently selected shelve is displayed.
This makes it fast to get an overview of the shelves.

The objective the patch tries to achieve is to speed up getting an
overview of stashed changes in gitk. A big stash in "git stash list
-p" can force a user to read it slowly or risk skipping the next
stash. By typing "gitk stash@{<TAB>" all stashes are listed. The user
can then know if there are more stashes that haven't been viewed yet
and stop reading a stash when he knows what the current stash is. (If
I understand things right "gitk stash@{.}" would have the problem of
burying old stashed under the commits above it)

> A bigger question is why this change is made to gitk completion.  If
> this completion were useful for "gitk", wouoldn't it be equally
> useful for "git log"?
I must admit that I didn't know that "git log" could display the
content of a stashed change. After trying "git log -p -m stash@{0}" I
would say that adding stashes for "git log" would be slightly less
useful. "gitk stash@{0}" allows me to look at the stashed change and
find out what it contains. "git log -p" (note: no "-m" since the user
don't know that a stash is a merge commit) won't let me do that.
Another reason is that "git stash show -p stash@{0}" already is
autocompleted for those that wish to view their stash diff on the
command line)

> If there were a way for users to say "The one I made to stash away
> that change" from the command line (I do not mean "git stash list |
> grep 'that change'"), it would be good.
Great idea.

-- 
Helsing
Sveinung

"The Lord requires of his saints confession of sins during their whole
lives, and that without ceasing, and promises pardon. How presumptuous,
then, to exempt them from sin, or when they have stumbled, to exclude them
altogether from grace?" (sitat John Calvin)
