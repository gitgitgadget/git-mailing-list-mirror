From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Should 'git reset --hard' keep a stashed backup?
Date: Mon, 17 Mar 2014 06:14:57 +0700
Message-ID: <CACsJy8CGvwEk4whaiEn5ccTyRKD4ZwUXqYVM9hTGfU7tYUdX=A@mail.gmail.com>
References: <EF7B8A31C59946F8821697F3BA129043@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 00:15:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPKHE-000068-MN
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 00:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbaCPXP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 19:15:29 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:55859 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbaCPXP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 19:15:28 -0400
Received: by mail-qa0-f46.google.com with SMTP id i13so4653763qae.33
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 16:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lSHrkMon0qnoL2dIX5f/jEr+MRFavfUsuD37IUMj0KU=;
        b=zrVnEG4+CopcBJGV1LtZF0mHe6GOVpjtxU8G7/JR1p+8w6GOKpkJVXVvxj2jNF6ZQT
         K9m6YfxUqnFcjK7ClxoSmvbbAbcJQhA9KQMH+i6A2XVh5qyaHZS6ZCbTrfiBC7+t1GWj
         ylGJz5k3YbCxCPo6OQYL16VtzpVpXTmcuke6Cp9rIEXgJ3fofYOT/d2XPTNjSIRlo+3G
         TIKN1D25N76meEBXvviFiycwQYT11mHMOH0M9/L8M2qwMo8umCHU0jCVDz78xXO+ThOj
         WW0sVNKUFjgpqKWph5YdRLaVePLWuMaRPhMeJ6YxSfFCttRyQ1g4KOOmVXJ72So/ui36
         fbvA==
X-Received: by 10.140.94.134 with SMTP id g6mr23649648qge.19.1395011727691;
 Sun, 16 Mar 2014 16:15:27 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Sun, 16 Mar 2014 16:14:57 -0700 (PDT)
In-Reply-To: <EF7B8A31C59946F8821697F3BA129043@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244216>

On Mon, Mar 17, 2014 at 5:17 AM, Philip Oakley <philipoakley@iee.org> wrote:
> A bike-shedding thought:
> Many inexperienced users do a 'git reset --hard' only to discover they have
> deleted something important and want it back. (e.g. git-users yesterday [1])
>
> One possible option is that Git could "stash" the current work-tree contents
> (git stash create) into a commit and store its commit_id in a suitable
> file/variable such as RESET_HARD_HEAD (or GIT_RESET_HARD_HEAD), similar to
> FETCH_HEAD & MERGE_HEAD, so that it would be relatively easy to recover the
> prior state.

A while back I started to implement "undo" function for "git add". I
think we could do the same here, when reset --hard is issued, store
current SHA-1 in index to an index extension, also hash overwritten
files in worktree and store it in the index extension as well. "reset
--undo" can bring it back. Experienced user can turn this off via
config variable, but it's default to on.

>
> By only storing the id in the file/env it would be overwritten on each
> usage, and the loose commits would be garbage collected eventually.

We have similar ideas, except I choose to store in the index instead.

>
> A suitable config variable would allow it to be enabled/disabled as
> appropriate to the user. (Perhaps enabled by default eventually?)

Yes. We could even bundle it to an advice.* knob. Experienced users
will usually turn the advice off (and this behavior will be gone as
the result).

> Given the prevalence of 'git reset --hard' within internet forum advice,
> would something like this be useful?  It could even be wrapped into a GSoC
> project.

We could go further to provide "git undo" interface that covers other
areas as well, easier to discover than "reset --undo", but I'm not
sure how this interface should work..
-- 
Duy
