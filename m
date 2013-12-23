From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/POC 3/7] setup.c: add split-repo support to .git files
Date: Mon, 23 Dec 2013 10:38:31 +0700
Message-ID: <CACsJy8AWCRLqnQK5SV4yPRjU-3JX9BwgbrRvpBtJngdjad6Eew@mail.gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1386771333-32574-4-git-send-email-pclouds@gmail.com> <xmqqiousr4bg.fsf@gitster.dls.corp.google.com>
 <20131213204348.GX2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 23 04:39:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuwMJ-0003kr-3d
	for gcvg-git-2@plane.gmane.org; Mon, 23 Dec 2013 04:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705Ab3LWDjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 22:39:04 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:64746 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756617Ab3LWDjD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 22:39:03 -0500
Received: by mail-qc0-f173.google.com with SMTP id m20so4438821qcx.18
        for <git@vger.kernel.org>; Sun, 22 Dec 2013 19:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vrru095PdP9UG8RRoQXZ9i06PQoznWlb01AeyrGxIs4=;
        b=CZgA0sSWc1v7Au/ZghslcFA1+RNxOuK8k8rbfbV6Z+KXEGqghS9aWKmp3YSUT1NdSr
         1TIx1daViSs76or3ITy0HVbaueBEpe1dHAN17hiw93zV8N4x+byypVhesi1uhvVFVKgC
         V0G/VHuAKTJas3QB8RFeUUksadiMO5GZpfWRCm1WUtCQsRwJnlV9SqZ2QF+kAa23Jxm0
         W9FYw3dcV9kmL187Glth5sgvbzhzk2SfjpeakzExAoiHsKlXR9y+a5KdIZMtSFc71HAJ
         mwJUmHSxcSdQdBlGZbDdmz3UisyMJ3S0bTb5oAhjbc5Tiz1Asc1d0tRMrLMOq+OBGlNM
         lBGA==
X-Received: by 10.49.12.102 with SMTP id x6mr38291279qeb.5.1387769941562; Sun,
 22 Dec 2013 19:39:01 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 22 Dec 2013 19:38:31 -0800 (PST)
In-Reply-To: <20131213204348.GX2311@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239650>

On Sat, Dec 14, 2013 at 3:43 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Problems:
>
>  * What if I move my worktree with "mv"?  Then I still need the
>    corresponding $GIT_SUPER_DIR/repos/<id> directory, and nobody told
>    the GIT_SUPER_DIR about it.
>
>  * What if my worktree is on removable media (think "network
>    filesystem") and has just been temporarily unmounted instead of
>    deleted?
>
> So maybe it would be nicer to:
>
>   i. When the worktree is on the same filesystem, keep a *hard link* to
>      some file in the worktree (e.g., the .git file).  If the link count
>      goes down, it is safe to remove the $GIT_SUPER_DIR/repos/<id>
>      directory.

Link count goes down to 1 if I move the worktree to a different
filesystem and it's not safe to remove $GIT_SUPER_DIR/repos/<id> in
this case, I think.

>  ii. When the worktree is on another filesystem, always keep
>      $GIT_SUPER_DIR/repos/<id> unless the user decides to manually
>      remove it.  Provide documentation or a command to list basic
>      information about $GIT_SUPER_DIR/repos directories (path to
>      worktree, what branch they're on, etc).
>
> (i) doesn't require any futureproofing.  As soon as someone wants it,
> they can implement the check and fall back to (ii) for worktrees
> without the magic hard link.
>
> (ii) would benefit from recording the working tree directory as a
> possibly unreliable, human-friendly reminder.
-- 
Duy
