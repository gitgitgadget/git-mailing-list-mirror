From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] git-checkout.txt: improve detached HEAD documentation
Date: Thu, 17 Feb 2011 14:48:33 -0500
Message-ID: <AANLkTi=tp2KasvPxSsHgQp3DqEHfMX6w+re7s+UYPVJ+@mail.gmail.com>
References: <1297971966-58500-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 20:49:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq9qg-0004Jp-Ui
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 20:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387Ab1BQTtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 14:49:05 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39254 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab1BQTtE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 14:49:04 -0500
Received: by iwn9 with SMTP id 9so2842378iwn.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 11:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=+DjbyiB5jodXvoODQws1YoYYhtdpz19zJx4r/hfoix4=;
        b=rgDC8JdxElaSIQkB29yogUIGVgRKKZh1wt7+Cylo2rzs6xlhLiu4hmRhUDXHQCHzwv
         Tt9C0wef3gPHtsGVDZoqX77baROjAOM2GZgvBipfuBFC24FYJmpwTTl7ELfvEEgBZiq5
         Pc7w0u3QhXC68SKleCPC25ZLbMKyiBCp6IeHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MoGpW9GWklik67FH5z8dv0J4fwqXqHV4Gs4j1iwdHzSqpezqh2BZmy8rIjV0S67912
         IXOUxt+QRsiHMrBSKylXAEbUS/7A6nQ0kgGNHQB3+6g+vStXnFZ93BcaM0xRFS/OixoZ
         PVM5Ulwro0+JetPZ0JC2lTpDmWT/FfheJSKGE=
Received: by 10.231.38.2 with SMTP id z2mr1955346ibd.142.1297972143675; Thu,
 17 Feb 2011 11:49:03 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Thu, 17 Feb 2011 11:48:33 -0800 (PST)
In-Reply-To: <1297971966-58500-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167105>

On Thu, Feb 17, 2011 at 2:46 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> The detached HEAD state is a source of much confusion for users
> new to git. Here we try to document it better.
>
> Reworked from http://article.gmane.org/gmane.comp.version-control.git/138440

The patch may be difficult to read, so here's the man output after
applying the patch:

DETACHED HEAD
       HEAD normally refers to a named branch (e.g. "master"). Meanwhile, each
       branch refers to a specific commit-id. Let's look at a repo with three
       commits and with "master" checked out:

                      HEAD (refers to master)
                       v
           a---b---c  master (refers to c)

       When a commit is created in this state, the branch is updated to the
       new commit-id. Let's add a commit:

                          HEAD (refers to master)
                           v
           a---b---c---d  master (refers to d)

       It is sometimes useful to be able to checkout a commit that is not at
       the tip of any named branch, or even to create a new commit that is not
       referenced by a named branch. Let's look at what happens when we
       checkout commit b:

           $ git checkout master^^

              HEAD (refers to b)
               v
           a---b---c---d  master (refers to d)

       Notice that HEAD now refers directly to commit b. In git terminology,
       this is known as having a detached HEAD. It means simply that HEAD
       refers to a specific commit-id, as opposed to referring to a named
       branch. Let's add a commit while HEAD is detached:

                HEAD (refers to e)
                 v
                 e
                /
           a---b---c---d  master (refers to d)

       We have created a new commit, but it is referenced only by HEAD. We can
       of course add yet another commit in this state:

                    HEAD (refers to f)
                     v
                 e---f
                /
           a---b---c---d  master (refers to d)

       In fact, we can perform all the normal git operations. But, let's look
       at what happens when we then checkout master:

           $ git checkout master

                 e---f    HEAD (refers to master)
                /          v
           a---b---c---d  master (refers to d)

       It is important to realize that at this point nothing refers to commits
       e and f. Eventually these commits will be deleted by the routine git
       garbage collection process, unless we create a reference before that
       happens. If we have not yet moved away from commit f, any of these will
       create a reference to it:

           $ git checkout -b foo # (1)
           $ git branch foo      # (2)
           $ git tag foo         # (3)

       (1) creates a new branch "foo", which refers to f, and then updates
       HEAD to refer to "foo". In other words, we'll no longer be in detached
       HEAD state after (1).

       (2) similarly creates a new branch "foo", which refers to f, but leaves
       HEAD detached.

       (3) creates a new tag "foo", which refers to f, leaving HEAD detached.

       If we have moved away from commit f, then we must first recover its id
       (typically by using git reflog), and then we can create a reference to
       it. For example, to see the last two commits to which HEAD referred, we
       can use:

           $ git log -g -2 HEAD
