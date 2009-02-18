From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: PUSH_HEAD, was Re: FETCH_HEAD question
Date: Tue, 17 Feb 2009 19:29:35 -0500
Message-ID: <76718490902171629x78b5057aw5e00ba22bfb8b8b0@mail.gmail.com>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
	 <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>
	 <7vr61x8ra4.fsf@gitster.siamese.dyndns.org>
	 <76718490902162341y2f122427i470c77d3915ff554@mail.gmail.com>
	 <7vy6w5795h.fsf@gitster.siamese.dyndns.org>
	 <76718490902170914p6258b77ak81318f13757f0dfd@mail.gmail.com>
	 <alpine.DEB.1.00.0902171821190.6185@intel-tinevez-2-302>
	 <76718490902170934u5e2c17ffl7599ddeb5ee59812@mail.gmail.com>
	 <alpine.DEB.1.00.0902172357450.10279@pacific.mpi-cbg.de>
	 <7vab8k39ze.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 01:31:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZaLE-0001Ua-Gm
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 01:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbZBRA3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 19:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbZBRA3h
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 19:29:37 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:62904 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbZBRA3g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 19:29:36 -0500
Received: by rv-out-0506.google.com with SMTP id g9so1762818rvb.5
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 16:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZUduutwxghy2H1teuXMwMwPSoRpekMXfpFRNtfzZbXk=;
        b=lNoDz/Y+PRSU8OwFr6izRmWOihXi5JKlbAu+LpDn1wDkBHN2mXWcR/qKg8SzlLBjJQ
         mIYnUwbIV252YJjl1UX7X50pz/n24cK3YSNpVHzK1PNDa347N0SEoiycU65sLq44GV8w
         lXFnYQh/zM4hwgITMCNP0XPX78RHVvDCM1p/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qXhxhvriEposOACtxb3lM3UvCqPsYPsnqDrkLry3Zw3N3A3sJY6SanFRFMbW6E9opY
         0Yo4yYS5afx/YuJzur5M7SQNkmrsyRptyogS4wcXtIfBpQYe0VBLFByn54YLIqydQKgH
         MDHR7FxzPjaY9AkPyR0Pim1w5BpcJBKRsZVOc=
Received: by 10.140.171.18 with SMTP id t18mr3582193rve.10.1234916975206; Tue, 
	17 Feb 2009 16:29:35 -0800 (PST)
In-Reply-To: <7vab8k39ze.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110486>

On Tue, Feb 17, 2009 at 6:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Having said that, there need to be clear and sane semantics defined to
> tell which push should go to PUSH_HEAD file and which should directly go
> to the underlying ref.  It is probably the easiest to explain if all
> pushes to local refs are redirected to PUSH_HEAD when the repository is
> non-bare, but it means a non-bare repository cannot be used as the central
> shared repository for everybody to meet and swap with push-pull.  We could
> only redirect push to the checked-out branch to PUSH_HEAD, but then that
> would introduce an inconsistency between checked-out branches and others
> from fetchers' point of view; pushes to some branches are observable from
> the outside while pushes to one special branch (the checked-out one) are
> not.

This is along the lines of what I was thinking. However, I have also
been thinking of an alternative. It would go something like this:

$ git init --hybrid

This would basically setup a repository that is a combination of bare
and non-bare and would act like having a pair or repositories. i.e.
Given,

$ mkdir project
$ cd project
$ git init
$ touch file && git add file && git commit -m initial
$ git clone --bare file://$(pwd) ../project-public.git
$ git remote add public ../project-public.git
$ git config branch.master.remote public
$ git config branch.master.merge refs/heads/master

I don't mean to suggest that git init --hybrid would literally create
two repositories. Rather, it would create a single repo that acts like
the above two. You'd "git push" to publish a branch and "git pull" to
integrate any pushed-in changes. refs/heads in such a repo would never
receive outside changes directly, nor would changes to refs/heads be
externally visible until published via push.

This would typically be used in the mothership/satellite scenario,
where the mothership repo is setup with --hybrid and the satellite is
just a normal clone.

But maybe this is a lot of work w/little reward.

j.
