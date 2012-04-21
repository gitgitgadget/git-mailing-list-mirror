From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git clone submodules recursive and reference
Date: Sat, 21 Apr 2012 15:45:48 +0200
Message-ID: <4F92BA0C.4030009@web.de>
References: <CAFj+z055ZZc-Am+pEMgjRvHgoxKSRBjnHhABCseC45+8YswKWg@mail.gmail.com> <4F91B22A.9000507@web.de> <CAFj+z04A5v7Cz=Wbqn_TBJQG88rPSfrs4T1=22x1N+v77ZXgYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Samuel Maftoul <samuel.maftoul@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 15:46:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLadS-0004jM-1b
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 15:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab2DUNpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 09:45:53 -0400
Received: from fmmailgate07.web.de ([217.72.192.248]:49192 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab2DUNpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 09:45:52 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate07.web.de (Postfix) with ESMTP id 6660211F8E01
	for <git@vger.kernel.org>; Sat, 21 Apr 2012 15:45:51 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.156.147]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MbQbk-1SeMVH07k4-00Inhx; Sat, 21 Apr 2012 15:45:51
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAFj+z04A5v7Cz=Wbqn_TBJQG88rPSfrs4T1=22x1N+v77ZXgYA@mail.gmail.com>
X-Provags-ID: V02:K0:hNyzpne51x+aPceTGFFnQJSKOcHVSw+Vu1C3E8z/1bv
 wQR1bIMpenVc38pm6a+2ysG9nW2y1E1Uc99NiYjTrFUZ4BVYLD
 qfEB40QbCtnliP9nffeoMDirwQROt0LsCmo7jJ792OU9EpTfO4
 hJ6SxyyD9nSjn5BG6ZwlFLfPoT5ObivJ4hGi59mZMuwrQBYhn+
 3wJrleQFrzYffgQJp9GoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196050>

Am 20.04.2012 21:26, schrieb Samuel Maftoul:
>> Hmm, to me it looks like passing the --reference option to the clone
>> run in the submodules doesn't make much sense, as that would make
>> all submodules and the superproject use the same alternates. And as
>> far as I know sharing objects between different repositories is not
>> supported.

I take that back, I was thinking about the idea to store the objects
of all submodules in the superproject's object store and then access
them via alternates which was discussed some time ago. That won't
work out of the box because the submodule commits would be dangling
in the superprojects repo.

> I'm sharing objects between repositories by creating a bare
> repository, adding the remotes for the repositories and fetch them in
> this bare repo.

This sounds like a cool way to reduce the disk footprint of the
repos on our Jenkins server.

> So for me, it makes sense to pass the "--reference" to the submodules
> clone, if submodules remotes are added to this reference bare repo and
> objects are already fetched (and I'm in this case, as I use a lot of
> different projects that shares the same set of submodules).

How do you fetch then, do you fetch into the referenced repo first
and then do a fetch in the clones afterwards to just update the refs
there? Or is the bare repo just a starting point for the initial
clone?

>>> How can I force the clones for submodules to be executed with the
>>> --reference option ?
>>
>> You'd have to use "git clone" without the --recursive option and
>> then do a "git submodule update --init --reference ...".
> 
> Yes, this should make it, but I would have been more happy with a
> single command !

Hmm, me thinks we'd have to add a new option for that, and I'm not
sure it is worth it.
