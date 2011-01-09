From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Sun, 9 Jan 2011 11:18:09 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101090847120.12031@debian>
References: <20110107104650.GA5399@pengutronix.de> <20110107194909.GB6175@sigill.intra.peff.net> <alpine.DEB.1.10.1101081449220.12031@debian> <20110108214011.GA4753@sigill.intra.peff.net> <7v1v4m8reh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 09 17:18:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbxyG-0005mr-15
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 17:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab1AIQSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jan 2011 11:18:14 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39892 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab1AIQSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jan 2011 11:18:13 -0500
Received: by vws16 with SMTP id 16so7860749vws.19
        for <git@vger.kernel.org>; Sun, 09 Jan 2011 08:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=x+udCdmxqgEG2H9gI1mwTewIOrqDT8btz36ybmH9JK0=;
        b=WH1R3JU49ok1UR5KmnfDg/XyBrCXFN645ZYPSNmI0oTi80TX6KLvQStk+4jE3rQt5V
         AizaH8DCqLTqcwwFvXI99Mi7rQlmOPVfLJKOUglCRyyRBkYdyWE0zLWbQFzj9c8RseLF
         98kDh+DV+HjcHI6j+npAT3bgu8vJ3j7KfSrhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=tvAyijzU1EVdtqfJ2l8/e7F7/2tkYby3JDN75fKvD9Pxw0lpJN6EAXnIxRxzjb2g+d
         9kNny9v1idB/gmZ/I3qcVlhPrtzbqiE+/NP+PsEyyNxwM4xRwuaKiLjrpA7WRrSfYG4R
         jEUdzhusvwA0qgcUxxBTyKp+mGwWECiQL0zJQ=
Received: by 10.220.193.11 with SMTP id ds11mr8474094vcb.209.1294589892922;
        Sun, 09 Jan 2011 08:18:12 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id d14sm6124304vcx.23.2011.01.09.08.18.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Jan 2011 08:18:11 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7v1v4m8reh.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164851>

On Sat, 8 Jan 2011, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sat, Jan 08, 2011 at 03:40:33PM -0500, Martin von Zweigbergk wrote:
> >
> >> > Yeah, we generally resolve ambiguities in favor of the tag (and that
> >> > warning comes from deep within get_sha1_basic). So the real bug here is
> >> > that it still said "Switched to branch", which is totally wrong.
> >> > 
> >> > That being said, it probably would make more sense for "git checkout" to
> >> > prefer branches to tags.
> >> 
> >> What was the rationale for generally favoring tags?
> >
> > I don't recall hearing any specific argument, but it has always been
> > that way from early on. I think it is from a vague sense of "tags are
> > more important than branch tips because they are about marking specific
> > points, not lines of development". But maybe other old-timers can say
> > more.
> >
> Aside from your "'checkout branch' is about checking out a branch"
> explanation, there are two reasons to favor branches over tags in
> "checkout" command:
> 
>  (1) You cannot disambiguate "git checkout heads/master" when you have
>      "master" tag, as this notation is used to tell the command "I want to
>      detach HEAD at that commit"; and

Interesting. I had no idea that 'git checkout heads/master' means to
detach the HEAD. Thanks.

By analogy, I guess that means that 'git rebase master heads/topic' is
supposed to rebase a detached HEAD, so I will stop trying to "fix"
that then :-)

>  (2) The command already treats an unadorned branch name specially by not
>      complaining ref/path ambiguity when you said "git checkout master"
>      and you have a file called "master" in your working tree, so users
>      already expect that an unadorned branch name is special to it.

If I understand correctly, that actually applies to tags as well.
Checking out a tag called e.g. Makefile doesn't give any warnings or
errors.


/Martin
