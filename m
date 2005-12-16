From: eschvoca <eschvoca@gmail.com>
Subject: Re: make install bug?
Date: Fri, 16 Dec 2005 10:06:44 -0500
Message-ID: <2b05065b0512160706o1a6a3fa5kcc34a108f5149a8f@mail.gmail.com>
References: <2b05065b0512120735v26c8343aged48165f3ccc5892@mail.gmail.com>
	 <7vzmn6i4kf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 16:09:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnHAY-000348-F7
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 16:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVLPPGs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 10:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVLPPGs
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 10:06:48 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:36493 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932317AbVLPPGr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 10:06:47 -0500
Received: by wproxy.gmail.com with SMTP id i13so14557wra
        for <git@vger.kernel.org>; Fri, 16 Dec 2005 07:06:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MvN7WBcr1H9XEZCdvG0QcsvlL3/rNabSP49BkAhqz5BrhTfADYe98zZ395aAjsQoE9gra8Y0jrFBGKtiMFaSjhh/+Th+Mtz+ZGZxI82JLGIO9s9mk+YoQ0hwuBmjXEuLedF3e9KajjSrOpR76IG72EioNUxVHTOiVAwInICYZwU=
Received: by 10.64.204.3 with SMTP id b3mr2171186qbg;
        Fri, 16 Dec 2005 07:06:44 -0800 (PST)
Received: by 10.65.38.9 with HTTP; Fri, 16 Dec 2005 07:06:44 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmn6i4kf.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13736>

You are right, CDPATH is the problem.  I am no longer exporting CDPATH.

e

On 12/12/05, Junio C Hamano <junkio@cox.net> wrote:
> eschvoca <eschvoca@gmail.com> writes:
>
> > I can fix the problem by changing templates/Makefile to the following:
> >
> > install: all
> >     $(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(template_dir))
> >     (cd blt && $(TAR) cf - . > /tmp/a.tar) | \
> >     (cd $(call shellquote,$(DESTDIR)$(template_dir)) && $(TAR) xf /tmp/a.tar)
>
> Here is my guess.  Could you try, from your interactive shell:
>
>         $ (unset CDPATH; make install)
>
> first without the above "fix" (your "fixed" pipe does not make
> any sense --- what are the data passed between pipe upstream and
> downstream?)?
>
> If that makes the problem go away, then your environment is
> broken --- my guess is that you are exporting CDPATH to
> non-interactive scripts.  Don't do that.
>
> I once googled for "CDPATH" and saw many "guide to unix" type
> webpages talk about "CDPATH environment variable"; they are the
> real culprit to cause this confusion in peoples' .bash_profile.
> CDPATH might be a nice variable for interactive shells, but is a
> horrible one if made environment.
>
>
