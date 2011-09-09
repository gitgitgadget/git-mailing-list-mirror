From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Thu, 8 Sep 2011 22:23:29 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109082123300.12564@debian>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com> <7v1uvta97o.fsf@alter.siamese.dyndns.org> <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com> <4E676F6A.3060906@drmicha.warpmail.net>
 <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com> <7vk49k48q4.fsf@alter.siamese.dyndns.org> <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com> <alpine.DEB.2.00.1109080753460.12564@debian>
 <CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 04:23:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1qko-0003p2-O6
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 04:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687Ab1IICXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 22:23:34 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60462 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548Ab1IICXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 22:23:32 -0400
Received: by vxi9 with SMTP id 9so752254vxi.19
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 19:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=ZHDVzmowYmRiSIyYxha+3Xo35sJ5Oi/SCT4OPyHbHOM=;
        b=BC3+ArPKzeD5vCLXJHoEQtfEMU99WbpZc6BYl9A8ULy+faRELSyXiwEhzlEm5pkPbj
         75z+6nAN9LCmyISC4+75kOCDSov09W62wUxQIoOAMZRy7z2fQf7FtIUGa1AUtgkf7x+D
         lJV5oYStnbFzzmaWGHSX8oZyeRsUzzXuG50hQ=
Received: by 10.52.28.204 with SMTP id d12mr1410066vdh.359.1315535011771;
        Thu, 08 Sep 2011 19:23:31 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id bd20sm3934895vdc.8.2011.09.08.19.23.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Sep 2011 19:23:31 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181024>

On Thu, 8 Sep 2011, Francis Moreau wrote:

> On Thu, Sep 8, 2011 at 3:14 PM, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
> >
> > Patches that are in both sides of v2.6.39...foo will be filtered, but
> 
> what do you mean by "both sides" ?

See the section called "SPECIFYING RANGES" in "git --help
rev-parse". It doesn't define "both sides", but what I mean by that is
"both in v2.6.39..foo and in foo..v2.6.39". I believe that section
will answer most of the other questions too.

> Yes my use of "git rebase --onto master foo~10 foo"  is equivalent to
> "git rebase master foo, the only difference is that the --onto variant
> allow me to limit the range of commits that I want to rebase. So I
> still want git rebase to do its the filtering process.

Ok, that is different. I think you used v2.6.39 instead of foo~10
previously. Assuming that v2.6.39 is the merge base of foo and master
and that foo~10 is a later commit than v2.6.39, you are right that
"git rebase --onto master foo~10 foo" could potentially filter out
patches already in foo..master, without calculating patch-ids for all
commits in master..foo for that matter. I think that would make sense
and as I said, it has been on my todo list for a long time. If
necessary, we could have a flag to disable the filtering e.g. when the
user knows that master is part of a completely separate history from
foo.


Martin
