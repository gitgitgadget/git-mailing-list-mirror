From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git clone submodules recursive and reference
Date: Mon, 23 Apr 2012 23:20:06 +0200
Message-ID: <4F95C786.40901@web.de>
References: <CAFj+z055ZZc-Am+pEMgjRvHgoxKSRBjnHhABCseC45+8YswKWg@mail.gmail.com> <4F91B22A.9000507@web.de> <CAFj+z04A5v7Cz=Wbqn_TBJQG88rPSfrs4T1=22x1N+v77ZXgYA@mail.gmail.com> <4F92BA0C.4030009@web.de> <CAFj+z05G_LLLc=OqZiqKCJPpTZ21Y4W6HTJ6ZitraVZXEQ50-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Samuel Maftoul <samuel.maftoul@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 05:12:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMWAx-0001WP-Tc
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 05:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500Ab2DXDMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 23:12:18 -0400
Received: from fmmailgate06.web.de ([217.72.192.247]:60422 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab2DXDMR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 23:12:17 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate06.web.de (Postfix) with ESMTP id C4D67131E163
	for <git@vger.kernel.org>; Tue, 24 Apr 2012 02:01:03 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.174.224]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LhNWS-1RrXqp0GYq-00mYDv; Mon, 23 Apr 2012 23:20:07
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAFj+z05G_LLLc=OqZiqKCJPpTZ21Y4W6HTJ6ZitraVZXEQ50-A@mail.gmail.com>
X-Provags-ID: V02:K0:zKjQ553iEWwGjk6lDra/3pV/Y9KgMLSqqzMb7GoxCBY
 vY80+GXoHQygNuKX57koYY8scKqGkTdm5PEYRle6h9RMg9CDhs
 TEuf8jGJx6Y/YF8zrQ8OHn+75fcgYWEnsIpise/92wpi3dVM0s
 YjdQoaDp8LPyitr9wkPBlbiWxuKx588ApL1AvRX+8Ey6atckAT
 /n0E2nGDZxsjfbo/24rpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196184>

Am 23.04.2012 10:06, schrieb Samuel Maftoul:
>>> I'm sharing objects between repositories by creating a bare
>>> repository, adding the remotes for the repositories and fetch them in
>>> this bare repo.
>>
>> This sounds like a cool way to reduce the disk footprint of the
>> repos on our Jenkins server.
> 
> I'm not using --reference for reducing disk footprint, but rather for
> caching git repos and reducing the impact of slow networks !
> Why would it reduce the disk footprint ?

Because the object store of the referenced repo is reused, the cloned
.git directory takes up less space (I think that is why the man page
talks about "reducing network and local storage costs").

>>> So for me, it makes sense to pass the "--reference" to the submodules
>>> clone, if submodules remotes are added to this reference bare repo and
>>> objects are already fetched (and I'm in this case, as I use a lot of
>>> different projects that shares the same set of submodules).
>>
>> How do you fetch then, do you fetch into the referenced repo first
>> and then do a fetch in the clones afterwards to just update the refs
>> there? Or is the bare repo just a starting point for the initial
>> clone?
> 
> You need to fetch first in the bare repo, than in your clones. When
> you use --reference, the reference leaves untouched, it's your job to
> update the reference (would be nice to have options that allows to
> update the reference at the same time that the clone updates, so no
> need to connect twice to the remote repository).

I think you could also just fetch in the cloned repos, but then you'll
have to download the objects over the network for each clone and also
won't share the new objects. So I think your approach makes lots of
sense, now I'll just have to tune our Jenkins scripts a bit. ;-)
