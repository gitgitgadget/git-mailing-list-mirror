From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v2 3/3] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 16:08:06 -0500
Message-ID: <53582bb6ceb64_24448772ecaf@nysa.notmuch>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
 <1398282160-26151-4-git-send-email-felipe.contreras@gmail.com>
 <xmqqsip3yemg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ilya Bobyr <ilya.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:18:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4Yu-0002k2-Qv
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758061AbaDWVSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:18:33 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:43337 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758018AbaDWVSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:18:32 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so1644848obc.22
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=FSlOitZUXwBryAfq4ou+/04uSDz3dZ4oI9IL8pEKJ1k=;
        b=bfMef+g9YiUpCJm0AK1KUX6FIuf6GOW1rN6n/sNkKEvgagJBYRyTgMk9ZNzyZtv/uM
         fsqMP0xIditb/SjpC+6jGbBL499u6eS5QXLWEssEDonPMXo1/AKRxshv+/PqrHTxuDjp
         XKh9fNeog3cZipDtH3k//v3zKiJh2dbX996ee4kO4KZAnoOKVSW1MSiqM/dBw3v3HQ+R
         Tj3Vjd2d1XvOEEDu3RbWZxNLhD8jvGA6jIlZypaJerv4PHKAJDA7BQCQCpmNlifeFnPk
         ksU3EuM75NbWIdCQhbpS5NKgC83KLnW8GZFwTaw/Sd0ZF0fpycmnQSWjEj9TyuWY0G43
         35GQ==
X-Received: by 10.60.61.66 with SMTP id n2mr44021991oer.11.1398287912108;
        Wed, 23 Apr 2014 14:18:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ut8sm4096797obc.22.2014.04.23.14.18.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 14:18:30 -0700 (PDT)
In-Reply-To: <xmqqsip3yemg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246899>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > This hook is invoked before a branch is updated, either when a branch is
> > created or updated with 'git branch', or when it's rebased with 'git
> > rebase'.  It receives three parameters; the name of the branch, the
> > SHA-1 of the latest commit, and the SHA-1 of the first commit of the
> > branch.
> >
> > When a branch is created the first and last commits of the branch are
> > the same, however when a branch is rebased they are not. If the SHA-1 of
> > the first commit of the branch is not available (e.g. git reset) a null
> > SHA-1 (40 zeroes) would be passed.
> >
> > The hook exit status can be used to deny the branch update.
> >
> > It can be used to verify the validity of branch names, and also to keep
> > track of the origin point of a branch, which is otherwise not possible
> > to find out [1].
> 
> Please call it pre-update-branch at least,

I will do so when I see a good argument for it.

> unless you want to make sure that time spent on others in the discussion
> thread for the previous round becomes wasted.

Unless you want to make sure the time *I* spent in the discussion is wasted.

I'm still waiting for replies to my last arguments.

> > +update-branch
> > +~~~~~~~~~~~~~
> > +
> > +This hook is invoked before a branch is updated, either when a branch is
> > +created or updated with 'git branch', or when it's rebased with 'git rebase'.
> 
> Does "git checkout -B aBranch" count?

Yes.

> Does "git reset $there" count?

Yes.

> I guess "git commit" or "git merge" on a branch to advance its tip
> in a usual way would not count (and I can think of good reasons why
> they should not count), but it is only a weak "guess".  The above
> two lines does not give readers enough hint to determine if "branch
> and rebase will be the only two and no other command will ever
> trigger" or "branch and rebase are only examples---for others, guess
> on your own" (and if the latter, enough clue to use in guessing).
> I cannot guess if "git fetch $there $that:refs/heads/master" should
> trigger the hook, for example.
> 
> To put it another way.
> 
> How does one, who is adding a new command that causes a branch tip
> to be updated, to decide if it should trigger this hook?  What are
> the common things among commands that can update branch tips that
> this hook gets called that are missing from commands that update
> branch tips that this hook does not get called?

I guess the guideline should be: if the branch is clearly moving forward the
hook is not called, if the branch is manually changed in any way, it should.

This omits non-porcelain commands, such as update-ref. I don't think those
should trigger the hook.

-- 
Felipe Contreras
