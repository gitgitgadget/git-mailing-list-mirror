From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Sat, 12 Apr 2014 10:05:15 -0500
Message-ID: <5349562bb7ae4_c9914c7308f9@nysa.notmuch>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
 <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
 <20140411111750.GA28858@sigill.intra.peff.net>
 <xmqqsipjsm8c.fsf@gitster.dls.corp.google.com>
 <20140412114212.GB14820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 17:15:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYzeT-0008J9-Qw
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 17:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbaDLPPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 11:15:19 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:55805 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbaDLPPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 11:15:18 -0400
Received: by mail-ob0-f182.google.com with SMTP id uz6so7420718obc.13
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=WkwefKM0eIClBVqtJw9gNGCdX8U4gL7hb8qcUJpk5xk=;
        b=TrXNRizLFsiWZshYi7ZzACXQhr1sw3rtwXGqQMEfpRDPdvkljd8eZuph1DoYPdeUgu
         eNlxbI05bD8Jv8gmXtskO6Xx1prxdMHY7kQGTAoqSKf7cZg8DLPtgc7oPVicFcSDjvz8
         oLYCg/+JRNB24xhr0mwEgFHwrq7fcILGVrPD8LQG3X9nomEa3k4P2Ubna3+2MeovUMN3
         dDotyxAgrF1C8e8hTClpVciSn1YwsD8nhhAhy+7oEavaI1Xe4sgpQpY6xfSzqjWS20zC
         EJQqOUvO2y88LOd07LovK4DuAkPReQUL8t7xNo3k4S3m9GXTAvihPkKxcyf7i28a9HOW
         iiVg==
X-Received: by 10.182.79.227 with SMTP id m3mr31216obx.74.1397315717712;
        Sat, 12 Apr 2014 08:15:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm46061677oej.5.2014.04.12.08.15.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 08:15:16 -0700 (PDT)
In-Reply-To: <20140412114212.GB14820@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246174>

Jeff King wrote:
> On Fri, Apr 11, 2014 at 12:24:35PM -0700, Junio C Hamano wrote:
> 
> > > But the branch.master.push setting does not do
> > > anything to "git push".
> > 
> > I am not sure I understand this.  I thought that the desire behind
> > the branch.*.push is to allow something like:
> > 
> > 	... other things in the config ...
> > 	[remote]
> >         	pushdefault = foo
> > 	[remote "foo"]
> > 		url = ...
> >         	push = +refs/heads/*:refs/remotes/satellite/*
> >                 fetch = +refs/heads/*:refs/remotes/foo/*
> > 	[branch "master"]
> > 		; pushremote = foo
> >         	push = refs/heads/bar
> > 
> > so that "git push" on 'master' will override the more generic "all
> > local branches here will go to their remote-tracking hierarchy for
> > this satellite" refspec.  And in that sense branch.master.push would
> > do something to "git push".
> 
> Ah, I see. If I set "push.default" to "upstream", then the config I
> showed before _does_ affect "git push". But I do not usually do that. I
> have push.default set to "current", and sometimes override it using push
> refspecs on certain repositories.
> 
> And that is why I find branch.*.push and Felipe's @{publish} useless for
> my workflow. Pushes already go where I want them to, and I just want a
> way to ask git to perform that config resolution for me. Whereas
> Felipe's workflow is (I think) something like:
> 
>   # make a new branch...
>   git checkout -b topic origin/master
> 
>   # now publish our branch, and remember our publishing point
>   git push -p my-repo topic
> 
>   # and now further pushes automatically go to my-repo/topic
>   git push
> 
> I can see there is some value in that override if you do things like:
> 
>   git push -p my-repo topic:some-other-name
> 
> because the "-p" means "remember this other name I gave".
> 
> I would think in such a workflow that most of your branches would end up with
> publish config, though. And therefore @{publish} would become equivalent to
> "where you would push".

> But Felipe indicated that he would not want "branch -vv" to match where all
> branches would be pushed, but rather only those that were specifically
> configured. So maybe I do not understand his workflow after all.

It's a pretty typical triangular workflow, with a touch of fork maintainership.

Here are some types of branches I have:

* master [origin/master, gh/master] Git 1.9.1

My main master branch, I use it as a base point for many other branches. I
don't use origin/master because that's a moving target.

* dev/remote/hg-extra [master] remote-hg: store extra hg information in notes

A development branch. I don't publish those, therefore no @{publish}.

* fc/publish [fc/branch/nice-verbose, gh/fc/publish] sha1_name: add support for @{publish} marks

A branch that is all good. I publish those, and use them for git-fc (my fork).
I think they should be in Git's core, but haven't been merged for some reason
or another.

Notice that the upstream branch is another local branch, not master. Strictly
speaking it's not an "upstream" branch, but I want 'git rebase' to use that as
the base point. Another @{base} concept might be more appropriate, but those
patches are a different story.

* up/publish [master] sha1_name: add support for @{publish} marks

A branch that should be sent upstream. I don't publish those.

Notice up/publish is different from fc/publish because the later depends on
another fc/* branch, which wasn't accepted upstream.

* fc/master [gh/fc/master] prompt: fix missing file errors in zsh

My main branch, used for git-fc. I merge Git's master, and cherry-pick various
fixes, so it has always the latest and greatest stuff.

Notice that 'gh/fc/master' is the publish branch, there is no upstream.

* pu [] Merge branch 'travis-ci' into pu

Similar to Junio's pu, I use `git reintegrate` to generate this branch using
'master' as the baseline, and merging all the fc/* branches. The result should
be identical to fc/master, if not, we are missing something from upstream, or
there's something missing in the fc/* branches.

It's not published, and has no upstream.


As you can see; some branches are published, others are not. The ones that are
not published don't have a @{publish}, and `git branch -v` doesn't show them.
Why is that hard to understand?

-- 
Felipe Contreras
