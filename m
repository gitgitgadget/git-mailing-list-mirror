From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Change git-rev-parse --show-cdup to output an absolute path
Date: Thu, 26 Apr 2007 13:57:50 +0200
Message-ID: <81b0412b0704260457p2783ee9t6d08f0a9dca3b54e@mail.gmail.com>
References: <20070425232829.GA15930@midwinter.com>
	 <81b0412b0704260120mda8a2abhe343f5c127945939@mail.gmail.com>
	 <46306A29.4010608@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 13:57:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh2bj-0006CA-OD
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 13:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030766AbXDZL5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 07:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031181AbXDZL5x
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 07:57:53 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:35529 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030766AbXDZL5v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 07:57:51 -0400
Received: by an-out-0708.google.com with SMTP id b33so192031ana
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 04:57:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rYaFKzfFtZiuVWgmFFYKXsCYtlbD0rCftvNP1VhRbaDeb4eN7LlPTB6QfSI3iCcG4PQLTXsSwqfHdC+Y/ycakjjMNPADJFXybGG02NAB8R6B3TVY4HwUPK63NDtLMt5JMEmnURA8KSQ7VUkPBlxsiski2CXE7ev4+ncex30PoGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tl6+ssW1LDTJbikK+LMofk0Ieo1mOGbA5AR+bcSgRLCOVlSnmkDumOljibvfWQwGw399ThTiik9vH857eu4S0xLooVLNShHarkSCMrzE+9h84inThXoQvJVBPMT8SvSSHUtV658kZbK5y7uzeYPLFw0fwpXjSqFRJqw1mphY3W0=
Received: by 10.100.248.18 with SMTP id v18mr1000758anh.1177588670219;
        Thu, 26 Apr 2007 04:57:50 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 26 Apr 2007 04:57:50 -0700 (PDT)
In-Reply-To: <46306A29.4010608@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45631>

On 4/26/07, Steven Grimm <koreth@midwinter.com> wrote:
> Alex Riesen wrote:
> > Your implementation will fail if cwd is longer than PATH_MAX.
> > Does not happen often, though.
>
> That limitation is already littered through the code, e.g. in setup.c
> which would already be failing in the existing implementation. Actually
> setup.c goes one better: is_inside_git_dir() hardwires a 1024-character
> limit into the code rather than using PATH_MAX. I didn't think I was
> introducing a new limit here.

It is yet another place to fix when it breaks.

> >> A typical failure case:
> >>
> >> $ git clone git://whatever.git foobar
> >> $ ln -s foobar/src/tools/misc/myapp myapp
> >> $ cd myapp
> >
> > Which is a strange thing to do. What is that for?
> > myapp is kind of outside the git repo foobar.
>
> For convenience, mostly; obviously that example was a bit contrived but
> I do have several symlinks to subdirectories of my repository and it's
> faster to type "cd ~/xyz" than "cd ~/repo/src/server/xyz" all the time.

Can't you use your shells variables or aliases (which is even faster to
type)?

> That was actually my initial approach to fixing this -- I put "cd
> `/bin/pwd`" at the top of the "cd_to_toplevel" function in
> git-sh-setup.sh. But it felt cleaner to make git-rev-parse return the
> actual correct path so it'd work for shell scripts that didn't happen to
> use git-sh-setup.sh. I'm happy to go either way, or of course to keep
> this as a local modification if folks find it too distasteful to include
> in the official source.

I'm not really objecting. It's just a bit unusual so I suspect unusual
problems coming out of it. Kind of when you try running with your
eyes closed.
