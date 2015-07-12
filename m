From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/16] worktree: make branch creation distinct from
 worktree population
Date: Sun, 12 Jul 2015 15:20:16 -0400
Message-ID: <20150712192016.GA4410@flurp.local>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
 <1436573146-3893-11-git-send-email-sunshine@sunshineco.com>
 <CACsJy8A8QkeFa3FyCkv8dp-J52NGGaN-AV3oG7W8tNtYqDO-cw@mail.gmail.com>
 <CAPig+cSiPeJskyanLAv71LuFoqPirUJ2FL0B0BsoT8BEVrE3LA@mail.gmail.com>
 <CACsJy8A8CeyeYZnMpbdWW-etohp3TWzGrro1khzD=8skydm6Cg@mail.gmail.com>
 <CAPig+cT-1juGLZK+F1Cy+MDE8+_bPqnX6fgfpoMnd2Qypu3oZQ@mail.gmail.com>
 <CAPig+cQcE0CkNCY6rbzRfjptesawPjeqGx9+rtVhCOADJzcU2Q@mail.gmail.com>
 <CAPig+cRV8oNw2Jp0mkn=CLTJERG+=O2pvewcjqF=xZ+dMgPnHA@mail.gmail.com>
 <CACsJy8BTTdWrCZNz=y686pgju5X8-2mPrNNQ-+z4ByeKD6O5Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 21:20:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEMni-0005zn-9C
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 21:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbbGLTUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 15:20:30 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33374 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbGLTU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 15:20:29 -0400
Received: by iggp10 with SMTP id p10so63396095igg.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SqZx8Nmhk8LdGSz36zNVjcVT9qhKzklZuEb+qpWHuXk=;
        b=ImHgwF0FhHOVGjqCdD/I9JhbklNTcqaFOxKlXpW8a2aFiRnrz/ZRNnQPbSMDGbYXst
         3z6WHCBqFL/NhjcyEp+ukOCsewuA/iCzzhn8yU8Fp5u29/xOwKu3s92VJBnbE8mhFnQj
         1DvQIsRgZIG3PijipHNmf0sIJSeV3SN8gazXUxSCI+YtUWNXfHmPV2q8Oc5/w0YD8OEi
         ejlgGEp1WQPiLNf8uC5CjkrW+L2uYrWaYo5JyrG7zPLQCQruozRt0/s4ENHMn5qQTbAY
         XENCWlGRg6IrO/kk8TnFRPtoTAUXkJJWINLvD/UhNBGkrO8wN6tequGH1KjnioJDBWMr
         7DVA==
X-Received: by 10.50.147.10 with SMTP id tg10mr8159298igb.36.1436728828976;
        Sun, 12 Jul 2015 12:20:28 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id q16sm4136254igr.12.2015.07.12.12.20.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 12:20:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8BTTdWrCZNz=y686pgju5X8-2mPrNNQ-+z4ByeKD6O5Uw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273901>

On Sun, Jul 12, 2015 at 04:54:02PM +0700, Duy Nguyen wrote:
> On Sun, Jul 12, 2015 at 10:27 AM, Eric Sunshine <sunshine@sunshineco.com> wrot> > In this case, it's easy enough to side-step the issue since there's no
> > need to call ref_exists() if the new branch was created successfully
> > (since we know it exists). The logic would effectively become this:
> >
> >     branch = ...
> >     if (create_new_branch) {
> >         exec "git branch newbranch branch"
> >         exec "git symbolic-ref HEAD newbranch"
> >     } else if (ref_exists(branch) && !detach)
> >         exec "git symbolic-ref HEAD branch"
> >     else
> >         exec "git update-ref HEAD $(git rev-parse branch)"
> >     exec "git reset --hard"
> 
> Yeah.. Another option we can take is deal with this at run-command.c
> level (and outside this series) because this could affect everywhere:
> by default, invalidate all cache after running any git commands. The
> caller can pass options to keep some cache intact if they know the
> command won't touch it.
> 
> If ref_exists() is the only thing we use, right now it does not use
> cache so we should be safe. If the new ref backend introduces a cache,
> they would need to examine all callers anyway, including this one. The
> cache in refs.c seems to be for for_each_ref.. only, which we don't
> call here.

In case I don't need to re-roll the series for some other reason, here's
a squash-in making the above adjustment to patch 12/16, which Junio can
pick up if he wants to:

---- 8< ----
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] fixup! worktree: detect branch symref/detach and error conditions locally

Current logic is effectively:

    branch = ...
    if (create_new_branch) {
        run "git branch newbranch branch"
        branch = newbranch
    }
    if (!detach && ref_exists(branch)) {
        if (!force)
            die_if_already_checked_out(branch)
        run "git symbolic-ref HEAD branch"
    } else
        run "git update-ref HEAD $(git rev-parse branch)"
    run "git reset --hard"

The ref_exists() call following 'run "git branch newbranch branch"'
works fine since ref_exists() hits the filesystem directly to answer the
question rather than relying upon potentially stale cached information.
However, this is potentially fragile if someone some day implements
caching. Moreover, with pluggable backends on the horizon, we may not
be able to rely upon ref_exists() in this process accurately reflecting
changes made by a subprocess.

If new branch creation was successful, then we know it's a branch, and
don't need to ask ref_exists() about it, thus we don't need to worry
about ref_exists() possibly returning an answer based upon stale
information, nor do we have to check if the new branch is already
checked out elsewhere. Therefore, rework the logic slightly to become
effectively:

    branch = ...
    if (create_new_branch) {
        run "git branch newbranch branch"
        run "git symbolic-ref HEAD newbranch"
    } else if (!detach && ref_exists(branch)) {
        if (!force)
            die_if_already_checked_out(branch)
        run "git symbolic-ref HEAD branch"
    } else
        run "git update-ref HEAD $(git rev-parse branch)"
    run "git reset --hard"

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 51c57bc..39f87a4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -195,8 +195,10 @@ static int add_worktree(const char *path, const char *refname,
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
-	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
-	    ref_exists(symref.buf)) {
+	if (opts->force_new_branch)
+		;
+	else if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
+		 ref_exists(symref.buf)) {
 		if (!opts->force)
 			die_if_checked_out(symref.buf);
 	} else {
-- 
2.5.0.rc1.387.g8463c8d
