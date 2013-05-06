From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Fwd: Uninit'ed submodules
Date: Mon, 06 May 2013 21:16:33 +0200
Message-ID: <51880191.2070809@web.de>
References: <CAFOYHZCfL2uqnUkb=7kSdpudKvYrfMo9saJ8eNsj5mYDQgHVuA@mail.gmail.com> <CAFOYHZDKTYFNRHUwdas7kZKs8UbdrY=hAA0SVqbz48NjWsHKww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 21:16:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQts-0007gY-B3
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab3EFTQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:16:36 -0400
Received: from mout.web.de ([212.227.17.12]:59911 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312Ab3EFTQf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:16:35 -0400
Received: from [192.168.178.41] ([91.3.169.59]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0M5g0a-1UKGWf2rw8-00xrKK; Mon, 06 May 2013 21:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CAFOYHZDKTYFNRHUwdas7kZKs8UbdrY=hAA0SVqbz48NjWsHKww@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:XDJNzPxYvmuxHwrK+sgwIWR9kmLPf+q2U+zR50TgQn6
 ls6GWrLFe0NOhikWP2S8lzIPxcgbndN5mjRX3noee3NKeJ4zFX
 6HVxlwBJZdOGxyKT0DzjF54gNCTzJhzjkT3nUk6zY/HPh3/6nO
 yyKI5SCdB5MLjUJvUBy8CtEepAv1YTRIv27VcxLYOcUDATB8bc
 89JCLPs0ycwnXqlYdySRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223488>

Am 06.05.2013 02:19, schrieb Chris Packham:
> This did get me thinking. Why does an uninitialized submodule need to
> have an empty directory? If it didn't the maintainer in question
> probably would have realized that he needed to run "git submodule
> update --init" when his "cd submodule" command failed.
> 
> I'm guessing there is a good reason for the empty directory - perhaps
> so that git can notice the fact that it exists in the worktree but is
> out of date?  If it does need to have some presence in the worktree
> why not as a file? That way the cd command would still fail (albeit
> with a different error) providing the necessary indication to the
> user. The submodule update --init could then change from file -> dir
> when it actually gets populated.

Hmm, to me an empty directory is the natural representation of an
unpopulated submodule, but I see why that made it hard for your
maintainer to notice the fact that the submodule was uninitialized.
I suspect changing an unpopulated submodule to be represented by a
file will surprise quite some users (some of which will probably
come up with perfectly valid use cases such a change will break).

What about the following: Today's Git completely ignores empty
submodule directories, but I think that when the recursive checkout
support is there, the "submodule.autoupdate" flag - which I believe
should control that behavior - could also make those empty submodule
directories show up in "git status" as being unpopulated (after all
they are configured to be updated automatically, so not having them
populated is something Git should show). Would something like this
have helped here?

Until then I can only propose to establish a best practice of using
"git clone --recurse-submodules" in these situations to avoid the
problem you described.
