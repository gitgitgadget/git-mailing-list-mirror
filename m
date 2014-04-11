From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Fri, 11 Apr 2014 14:50:38 -0500
Message-ID: <5348478e1bc46_2c1f6e72ecbb@nysa.notmuch>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
 <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
 <20140411111750.GA28858@sigill.intra.peff.net>
 <xmqqsipjsm8c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 11 22:00:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYhcy-0003vQ-QC
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 22:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbaDKUAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 16:00:39 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:46558 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbaDKUAi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 16:00:38 -0400
Received: by mail-ob0-f182.google.com with SMTP id uz6so6574700obc.41
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=5ZVhWnizxC06L4LIp2aj8KdcUplPxbEr01y8AO1Rvu4=;
        b=chmL6QtvJf1bRX1houZjF+rtjiQfsLVPkpwLzjMzYMWWiDX24wiY/mH8oVqc48UX6g
         mvhMalPLdY9o8EbtMQ8BMxU5sgzRt6xoy0QQw5MCWv3AnF5X2IJ6BPn978J8oJ5sLtAC
         YLBhC4lis0h+Cf2jsl014xqb4Ohdd3AmjdUEZgmKvd8MJrazG+Pw7ciBwlETtq4+Dadh
         +ygj50+94xNnlLKx8257QZk6ox6UpLa3dQbfOV4GtRQRP76FGMx0YpzKunTN2L2rj5AH
         soNfuft++msruSRIH4SirfZ++AP+URDV1KOvgYG7nvXQ66meFutiWP6314/pRghRgaB8
         Ratg==
X-Received: by 10.60.125.195 with SMTP id ms3mr21044343oeb.3.1397246438184;
        Fri, 11 Apr 2014 13:00:38 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ii8sm13917819obb.11.2014.04.11.13.00.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 13:00:37 -0700 (PDT)
In-Reply-To: <xmqqsipjsm8c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246140>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > For instance, it looks like your @{publish} requires config like:
> >
> >   [branch "master"]
> >   pushremote = foo
> >   push = refs/heads/bar
> >
> > to operate. Setting "pushremote" affects what "git push" does; it will
> > go to the "foo" remote.
> 
> OK, and the same thing would happen if branch.*.pushremote is not
> set for any branch, but remote.pushdefault is set to 'foo', right?
> 
> > But the branch.master.push setting does not do
> > anything to "git push".
> 
> I am not sure I understand this.  I thought that the desire behind
> the branch.*.push is to allow something like:
> 
> 	... other things in the config ...
> 	[remote]
>         	pushdefault = foo
> 	[remote "foo"]
> 		url = ...
>         	push = +refs/heads/*:refs/remotes/satellite/*
>                 fetch = +refs/heads/*:refs/remotes/foo/*
> 	[branch "master"]
> 		; pushremote = foo
>         	push = refs/heads/bar
> 
> so that "git push" on 'master' will override the more generic "all
> local branches here will go to their remote-tracking hierarchy for
> this satellite" refspec.  And in that sense branch.master.push would
> do something to "git push".

In my patches the above doesn't work; branch.master.push doesn't do anything if
.pushremote isn't there.

I'm always thinking from the common user's point of view, and the common user
doesn't know what branch.master.push is, but he knows he did
`git branch -p foo/bar master` (or something like that), and
`git branch -v` would corroborate that.

So you would have something like this:

	[remote "foo"]
		url = ...
		push = +refs/heads/*:refs/remotes/satellite/*
		fetch = +refs/heads/*:refs/remotes/foo/*
	[branch "master"]
		pushremote = foo
		push = refs/heads/bar

> I personally think that kind of override adds any more values than
> it causes confusion, so I think it is OK not to support such uses of
> branch.*.push at all.  A configuration without branch.master.push
> may cause "git push" on 'master' to update refs/heads/master at the
> remote,

How? If branch.master.push is not configured, then "git push" would push
'master' to refs/remotes/satellite/master on the remote.

-- 
Felipe Contreras
