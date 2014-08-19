From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Relative submodule URLs
Date: Tue, 19 Aug 2014 21:30:10 +0200
Message-ID: <20140819193010.GA64203@book.hvoigt.net>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
 <20140818205505.GA20185@google.com>
 <20140819102421.GA5012@book.hvoigt.net>
 <CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
 <xmqqiolowi1f.fsf@gitster.dls.corp.google.com>
 <CAHd499B9Wa=Y6P+OD8Ea-6dA4yZSkGZZSR9CwZAM45evDL_Qiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:30:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJp6y-0006Uo-NI
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 21:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbaHSTaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 15:30:24 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:33271 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbaHSTaY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 15:30:24 -0400
Received: from [77.21.76.69] (helo=book.hvoigt.net)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1XJp6p-00077H-JA; Tue, 19 Aug 2014 21:30:19 +0200
Content-Disposition: inline
In-Reply-To: <CAHd499B9Wa=Y6P+OD8Ea-6dA4yZSkGZZSR9CwZAM45evDL_Qiw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255513>

On Tue, Aug 19, 2014 at 11:50:08AM -0500, Robert Dailey wrote:
> Maybe I'm misunderstanding something here and you can help me out.
> 
> All the reading I've done (mostly github) says that 'upstream' points
> to the authoritative repository that you forked from but do not have
> permissions to write to. 'origin' points to the place you push your
> changes for pull requests (the fork).
> 
> Basically the workflow I use is:
> 
> - Use 'upstream' to PULL changes (latest code is obtained from the
> authoritative repository)
> - Use 'origin' to push your branches. Since I never modify the
> branches that exist in 'upstream' on my 'origin' (I do everything
> through separate personal branches).
> 
> That means if I have a branch off of 'master' named 'topic', I will
> track 'upstream/master' and get latest with 'git pull'. When I'm ready
> for a pull request, I do 'git push origin' (I use push.default =
> simple).
> 
> According to my understanding, relative submodules work here. But not
> everyone on my team uses this workflow. Sometimes they track
> "origin/topic" (if we use my example again). Won't the submodule try
> to find itself on the fork now?

Well the remote for the submodule is currently only calculated once,
when you do the initial

	git submodule update --init

that clones the submodule. Afterwards the fixed url is configured under
the name 'origin' in the submodule like in a normal git repository that
you have freshly cloned. Which remote is used for cloning depends on the
configured remote for the current branch or 'origin'.

When you do a fetch or push with --recurse-submodules it only executes a
'git fetch' or 'git push' without any specific remote. For fetch the
same commandline options (but only the options) are passed on.

Here it might make sense to guess the remote in the submodule somehow
and not do what fetch without remotes would do.

For the triangular workflow not much work has been done in regards to
submodule support.

But since a submodule behaves like a normal git repository maybe there
is not much work needed and we can just point to the workflow without
submodules most times. We still have to figure that out properly.

Cheers Heiko
