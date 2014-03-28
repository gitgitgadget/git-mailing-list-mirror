From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git commit vs. ignore-submodules
Date: Fri, 28 Mar 2014 17:47:08 +0100
Message-ID: <5335A78C.60401@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>
To: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 17:47:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTZw7-0001PR-PC
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 17:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbaC1QrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 12:47:15 -0400
Received: from mout.web.de ([212.227.15.4]:61807 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbaC1QrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 12:47:14 -0400
Received: from [192.168.178.41] ([84.132.146.169]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LgHKO-1WoJlc3kXM-00neNS; Fri, 28 Mar 2014 17:47:13
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:JqksI/WhgkXf50n4TAQe2ZX630NDk+OPjtquMVZco7lrg0izZSi
 dlezSOQn1kyh4nQdWA//0vKdrm59q8JBaH1CRIUgJ0wdgUMKkYLR4+HkclXSzfhvnCk0z44
 Vg732CEJsNIKIUHhKk3D3p0+kMWYtlnUKzunl9kaZ893p+8R8RNtM+G7oI8elbNcjx/AQP2
 x0lMIE39YAMrF6ao0brlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245393>

Am 28.03.2014 00:36, schrieb Ronald Weiss:
> Hello.
> 
> As this is my first post to this list, let me first thank all the
> people involved in Git development - it's really a great tool.

Welcome and thanks for the feedback!

> Now to the point. Since Git 1.8 (I think), git commit command honours
> the submodules' ignore settings, configured either in .gitmodules, or
> in .git/config. That's very nice and certainly correct for "git commit
> -a", but it's less clear if one explicitely stages an updated
> submodule using git add. Git commit will ignore it anyway, if
> ignore=all is configured in .gitmodules. Maybe that's correct too, I'm
> not sure about that, but it's inconvenient in our use case, especially
> combined with the lack of --ignore-submodule parameter to git commit,
> as git status and git diff have.
> 
> We use submodules in such a way that normally we don't ever want to
> see changes in them in output of git diff and git status. So we set
> ignore=all in .gitmodules for each submodule. But occasionally, we
> need to add a new submodule, and sometimes also commit changed
> submodule. This got harder with Git 1.8, we have to "git config
> submodule.<name>.ignore none" before the commit, and "git config
> --unset ..." after.
> 
> I'd like to at least add an --ignore-submodules parameter to git
> commit. I though about posting a patch, but as I looked into the
> commit source file, I didn't see any straightforward way to implement
> it. I don't have enough free time for a deeper analysis of the
> sources, I'm sorry.
> 
> So please, let me first know, whether you could possibly accept such
> patch, and if so, then I'd really appreciate some hints on how to do
> it.

Such a patch would be very much appreciated. You might want to look
into other commands that already have the --ignore-submodules option
to get an idea how to do that. cmd_status() in builtin/commit.c
should be a good starting point.

> And also, I'd like to know git folks' opinion on whether it's OK that
> git commit with ignore=all in .gitmodules ignores submodules even when
> they are explicitely staged with git add.

No, they should be visible in status and commit when the user chose
to add them. I see if I can hack something up (as I've been bitten
myself by that recently ;-).
