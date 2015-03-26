From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] git submodule purge
Date: Thu, 26 Mar 2015 22:48:22 +0100
Message-ID: <55147EA6.2000703@web.de>
References: <20150316134407.GA31794@pks-tp.elego.de> <20150316200353.GB5186@google.com> <20150317075636.GA354@pks-pc> <5510866B.40501@web.de> <20150325090631.GA370@pks-pc.localdomain> <551310EF.8050700@web.de> <20150326133052.GA382@pks-pc.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Thu Mar 26 22:48:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbFde-0002F5-Sg
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 22:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbbCZVs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 17:48:27 -0400
Received: from mout.web.de ([212.227.17.11]:50565 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900AbbCZVs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 17:48:26 -0400
Received: from [192.168.178.41] ([79.211.108.130]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M2uj4-1ZRYm11JZ8-00shh9; Thu, 26 Mar 2015 22:48:23
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150326133052.GA382@pks-pc.localdomain>
X-Provags-ID: V03:K0:THhsXvTurzXULXMwrVmnk/FAmbiadj0i4ILGaSvmiQfB109fs5+
 Z5/YkYdFLI8yJZsTyIcwYjVuabK4qNmCW5Mvwr9gKtI6BBz65zL1cQWW48lTzXhE1K3nLEm
 4HlVqD8GrspHroV0Y+yJREwns56CWheTb2GVn3TdimajaMXT9wSfvUGT83PTlHMTbBUeRfI
 yuEkTy+2ktl8KX/bOWMlA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266354>

Am 26.03.2015 um 14:30 schrieb Patrick Steinhardt:
> On Wed, Mar 25, 2015 at 08:47:59PM +0100, Jens Lehmann wrote:
>> Am 25.03.2015 um 10:06 schrieb Patrick Steinhardt:
>>> Optionally I could
>>> implement `git gc --purge-submodule=<submodule-name>` as a second
>>> way to access the feature so that we have a way of purging them
>>> without using the submodules-interface. I doubt though that this
>>> will provide much of a benefit as the user still has to be aware
>>> that he is working with submodules as he has to provide the
>>> `--purge-submodule` option, so there is not much to be gained by
>>> this.
>>
>> Hmm, I still believe cleaning up a submodule repo which is already
>> deinited makes sense. Using 'rm -rf .git/modules/<submodulename>'
>> will work just fine, but is missing any safeguards. The deinit
>> command takes submodule paths, not submodule names. So it looks
>> to me like 'git gc --purge-submodule=<submodule-name>' would make
>> sense here (and this command should check that the submodule has
>> already been deinited and fail otherwise telling the user so).
>
> Ah, okay. I thought your intention was to provide `git gc
> --purge-sm` _instead_ of `git sm deinit --purge`. Guess it makes
> sense to have both available for the different use cases
> (explicitly removing a submodule vs removing unreferenced ones).

Yup. And I wonder if `--purge` should be the default for deinit
if no unpushed commits will be lost ... but let's hear what
others think about this one.

> I guess one could even provide another option
> `--purge-submodules` in addition to `--purge-sm=<smname>` that
> will remove all deinitialized submodules without local commits.
> Maybe its desirable to have a `--dry-run` flag as well that would
> print which repositories would be deleted by `--purge-sms`.

Hmm, thinking about that some more maybe we might wanna simplify
this a bit. Adding a `--prune-submodules` option to gc which will
remove all deinitialized submodules repos that don't have any
unpushed commits should be sufficient to do the housekeeping. If
people demand to be able to prune specific submodules later we
could still add a `--prune-submodule=<name>`, but I suspect we
might not need that.
