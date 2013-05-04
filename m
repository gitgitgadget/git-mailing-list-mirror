From: Johan Herland <johan@herland.net>
Subject: Re: How do I modify the commit message (not the topmost one) of a git commit?
Date: Sat, 4 May 2013 09:59:23 +0200
Message-ID: <CALKQrgcN06Y0dVrAX=yNPjneZymFo2SMq_ymz52Qs+_GgMD3gg@mail.gmail.com>
References: <abcd1234abc123ab12a0000000345000020000004001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Norah Jones <nh.jones01@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 09:59:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYXNV-0000qx-A6
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 09:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab3EDH73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 03:59:29 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:52158 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab3EDH72 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 03:59:28 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UYXNO-0008uN-RJ
	for git@vger.kernel.org; Sat, 04 May 2013 09:59:26 +0200
Received: from mail-ob0-f181.google.com ([209.85.214.181])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UYXNO-000Jcq-Jg
	for git@vger.kernel.org; Sat, 04 May 2013 09:59:26 +0200
Received: by mail-ob0-f181.google.com with SMTP id ta14so2000246obb.26
        for <git@vger.kernel.org>; Sat, 04 May 2013 00:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=shf4IMHf2myvgPjBcRMtMHrNetapCwqiKYovfdZOw3c=;
        b=DDOE0j5wPV3MsRmArSlpmBqrAJGOuRcE7+tjkTTcFRCqN2weqLqOThfS5MNn+7DsP8
         bELxC/eIc/iJ/bWU8kjKwILj5xdcJh/carY5EeX/slnTU2oWZeeR9XgPKr7Uma6+LDAv
         yuRcXMMco1R8I954DRnJ4FdMlWdCmJuBIexLYgfH2KDft2iEhhxHUxyC+6ocofsrPQ8b
         Jdxe9epk7XnLY+8JDWYSsh5sDR7oUTaxlnGGvIFl//kF4cmHE4XX/+y+3fchOfDcK+y2
         6eo6L3NArYGsc0hHHwPP6lla9zgrAdXdljqbXk/PH5pZrOE4KbCTChcilrO2k2waNGJc
         AraA==
X-Received: by 10.60.47.1 with SMTP id z1mr3769453oem.134.1367654363097; Sat,
 04 May 2013 00:59:23 -0700 (PDT)
Received: by 10.182.129.110 with HTTP; Sat, 4 May 2013 00:59:23 -0700 (PDT)
In-Reply-To: <abcd1234abc123ab12a0000000345000020000004001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223358>

On Sat, May 4, 2013 at 8:31 AM, Norah Jones <nh.jones01@gmail.com> wrote:
> Hi,
>
> I did a series of commits and now I find one of my commit (not the topmost one) has an incorrect commit message. How can I change that specific one? I believe "git commit --amend" works only for the last commit.

True. Be aware that "git commit --amend" and the rebasing shown below
amounts to rewriting history, which is fine when it's your own local
history, but if you've already shared the commits you are changing,
then you're forcing your collaborators to rebase their own work on top
of your rewritten history.

That said, here's how to do a rebase to change a specific commit message:

0. Make sure you have a clean worktree. "git stash" any uncommitted changes.

1. Identify the commit you want to change, e.g. by using something
like HEAD~5 (for the 5th last commit on your current branch), or by
the 40-character commit id.

2. "git rebase -i $commit^", where $commit is the commit you
identified above, and the trailing caret "^" is important. (rebase
works on a range of commits, and you want to start the rebase based on
the parent of the commit you wish to change).

3. The rebase command will open your text editor with a list of your
commits, from the one you'd like to change, to your most recent
commit. Each commit is prefixed with the word "pick", which indicates
that rebase will replay that commit without any changes. You want to
change the commit message for the first commit in this list, so on the
first line, change the "pick" into "reword". Save and exit the editor.

4. Rebase will now start replaying the commits from your list. The
first thing that will happen, is that it will reopen your text editor
with the commit message for the commit you want to change. Edit the
commit message to your liking, and save and exit the editor.

5. Rebase will then replay all the following commits until the last
commit is done, and you're "back" where you were when you started the
rebase. Since you did nothing more than change a commit message, you
will not get any conflicts during the rebase.

6. If you stashed some uncommitted changes in step #0, you might want
to un-stash them now: "git stash pop"


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
