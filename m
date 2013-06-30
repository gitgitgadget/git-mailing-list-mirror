From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] submodule: add 'exec' option to submodule update
Date: Sun, 30 Jun 2013 17:30:14 +0200
Message-ID: <51D04F06.9000400@web.de>
References: <1372413190-32732-1-git-send-email-judge.packham@gmail.com> <20130628104243.GD27497@paksenarrion.iveqy.com> <51CEA4B2.1090008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	stefan.naewe@atlas-elektronik.com, Heiko Voigt <hvoigt@hvoigt.net>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 17:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtJaI-0007Jh-Jx
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 17:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab3F3PaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 11:30:20 -0400
Received: from mout.web.de ([212.227.17.11]:59924 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab3F3PaT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 11:30:19 -0400
Received: from [192.168.178.41] ([91.3.153.176]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Mg7Zl-1UYdOs0XFl-00NUvu; Sun, 30 Jun 2013 17:30:15
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51CEA4B2.1090008@gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:hVsIr/388VdbZZO+466W4Mwzf4PQC9Y+dJr3GnmKFIcuViplaW/
 wZ/nLb5gTgWpD5pQkk3bkoCjguhgksFZgSVLBKznfQBLKYPiYgnCKGtGaVw5BiTSrV0pjY3
 ppuuED67KItKSPeTp0f4zKuT/nNVqbmi/GdUEbuzdSwnIaWsiGnC1b97H04vb+gpXLdWRHs
 EfNgon6LGYw2MeYsdHHDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229279>

Am 29.06.2013 11:11, schrieb Chris Packham:
> On 28/06/13 22:42, Fredrik Gustafsson wrote:
>> technically it looks fine to me (except for the lack of tests) but I'm
>> not sure I follow the use case.
>>
>> In your case, you want to run a script to determinate if that certain
>> submodule should use merge or rebase depending on "whatever". And this
>> can't be done with git submodule foreach because you want to know the
>> sha1 to update to. Have I understood you correctly?
> 
> Correct. We tend to have submodules that are just normal detached heads
> which we don't usually touch and others that are actively developed
> where we would use submodule.x.update=rebase (I personally do) but some
> developers want to use stgit on those repositories.
> 
> Another approach could be to do a 'git pull --no-recurse-submodule' then
> use 'git submodule foreach script-that-does-the-rebase'. The benefit of
> the patch I sent is that it can be setup using the config variables[1]
> and updated the normal way along with the detached HEADs and those using
> plain git branches.

Wouldn't a "stgit submodule update" (which would do the Right Thing for
submodules initialized with stgit by maybe just using the pull & foreach
logic you described) be a better UI for solving your problem?

> There may be other use-cases for integration with other tools as well
> (e.g. something that updates a review tool when commits get rebased).
> 
> --
> [1] I'm not crazy about the name of submodule.*.update.command but I
> couldn't think of a better one.

Hmm, if we go that route, why not do the same we do for aliases? If
the submodule.*.update setting is prefixed with a '!', we just execute
the shell command following. This would give everyone the freedom to
do arbitrary stuff if the current none, checkout, merge & rebase won't
do the trick without having to add another config option.
