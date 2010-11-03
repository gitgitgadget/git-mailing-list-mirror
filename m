From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Wed, 3 Nov 2010 11:35:24 -0500
Message-ID: <20101103163524.GB12934@burratino>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
 <7vsjzj1v49.fsf@alter.siamese.dyndns.org>
 <201011022358.11340.johan@herland.net>
 <20101103064137.GC7606@burratino>
 <7vsjzixty5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 17:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgJS-0004sV-0M
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab0KCQfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:35:45 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52689 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab0KCQfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:35:44 -0400
Received: by vws13 with SMTP id 13so1201971vws.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/2PYXBX9qvB/qGbUrx4JJnDOBYRCOFP8E5Pd67XiOlE=;
        b=hfGitSDSjfwzgpzRiJbSM7xp+zc+5BZOz9579MREyoAnK2Lkj4NZ1N2qRuIu5KTJQh
         TjshJhsLLRLi6dtGLZZj4WK5lI/WCmwgjP+To5rM6f6hL0nER1VK0aIrnCRLlhPrlM3L
         nkDdqOscz4T/Qly/U7FiE/WjMv85srVB4Qfs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KoJTYqBqI1KsVDtdh+jK9qbLb7bCvTs4l5QxzxIgSPXbLPdeSX/prr6moOQg7S7E/B
         FbYRk5VdLDHjcoff5CubBcE/xllxEXJ56OpoOgf3Ut9YmTLEifG2b4gxwGvskvMMvUd8
         Tnv5MYf74OLgSI4LH3LaBKhHIKPq8sXY3mC5c=
Received: by 10.220.189.136 with SMTP id de8mr507957vcb.30.1288802143341;
        Wed, 03 Nov 2010 09:35:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id p32sm4574252vbl.5.2010.11.03.09.35.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:35:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjzixty5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160626>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> How about
>>
>>     refs/notes/*        refs/notes/$remote/*
>>
>> ?
>
> I was actually thinking more along the lines of "not keeping track of
> remote state at all".  We don't do that for tags either.

What would be the behavior when a remote and local notes ref have the
same name?

Tags are supposed to be universal and never change, so that doesn't
come up.  With branches and notes trees, one can impose a requirement
that the remote and local refs never have the same name (the "no
separate remotes" layout) but I think that runs into problems from
both ends:

When the remote and local notes are written by the same person, it
seems like busy work to ask that person to give different names for
the same branch at different installations.

In a distributed world where many developers might not even know
about each other's repositories, name conflicts on development
branches would seem to be inevitable.

 home> ... hack hack hack ...
 home> git notes add some-commit;	# hmm, noticed something
 home> ... hack hack hack ...

 Time to go to work...

 work> ... hack hack hack ...
 work> git notes add another-commit
 work> ... hack hack hack ...
 work> git fetch home;			# grabbing notes from home.
 work> git notes merge home/commits
 work> git push;			# publish.

Still, as long as the default can be overridden (even if only on a
per-remote basis), I wouldn't mind.  Maybe this way of using notes
would be unusual and the no-separate-remotes layout supports some
other use case better.
