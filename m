From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] completion: suggest sequencer commands for revert
Date: Fri, 29 May 2015 19:13:39 -0400
Message-ID: <CALkWK0m9Fj_3AnJcENL-kAFSbYjW4fKpN76Tftrt672hQj4qww@mail.gmail.com>
References: <1432547975.4644.5.camel@virtuell-zuhause.de> <xmqq1thzcgde.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 30 01:14:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyTTt-00065f-JB
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 01:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757042AbbE2XOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 19:14:21 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:36848 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244AbbE2XOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 19:14:20 -0400
Received: by yhan67 with SMTP id n67so1721653yha.3
        for <git@vger.kernel.org>; Fri, 29 May 2015 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6I4sKCnTRwHSjZX3uYtSfb1sFKr5sDD/md+jHvbqVpY=;
        b=b4ebXZeyh9OaqjWdEIW0fzCxE806neqfeJuOThPJ+r9RIZcvuB7H6JMTQHXQBgo+OL
         tF+B3hiGBWgcjiWYlK0ngLatogkwONH5UyB9OY9cE/HCgzMmIcymgV/giInVCIjaxgmC
         jDOFkkO3eBk6iT2JUT8icyvMiEcnWR+JKLpIba1e2EzLP+3Bve3HNBMgExuP/vwavPFT
         C9ckxsmVNsR9rQBvpIqKBmzGkM2JXa04VdV4Hz+SeRQ0uZsVR9pQL8i2wAcT6E2fc0H5
         8C16nZT9zo4snqsZw/C59NDS3iC1JYjj/nof5Uia4Bnfgw9kxAuGrBgZsGVA2S8wDv7L
         zAyg==
X-Received: by 10.170.43.11 with SMTP id 11mr12421203ykl.119.1432941259378;
 Fri, 29 May 2015 16:14:19 -0700 (PDT)
Received: by 10.129.55.129 with HTTP; Fri, 29 May 2015 16:13:39 -0700 (PDT)
In-Reply-To: <xmqq1thzcgde.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270278>

Junio C Hamano wrote:
>
> >  contrib/completion/git-completion.bash | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index bfc74e9..3c00acd 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -2282,6 +2282,11 @@ _git_reset ()
> >
> >  _git_revert ()
> >  {
> > +     local dir="$(__gitdir)"
> > +     if [ -f "$dir"/REVERT_HEAD ]; then
> > +             __gitcomp "--continue --quit --abort"
> > +             return
> > +     fi
> >       case "$cur" in
> >       --*)
> >               __gitcomp "--edit --mainline --no-edit --no-commit --signoff"

This corresponds exactly to what we do for git-cherry-pick:

local dir="$(__gitdir)"
if [ -f "$dir"/CHERRY_PICK_HEAD ]; then
__gitcomp "--continue --quit --abort"
return
fi

Perhaps _git_revert() and _git_cherry_pick() should call into the same
function with different arguments.

This looks fine though.
