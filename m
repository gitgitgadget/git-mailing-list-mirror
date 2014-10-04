From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Submodules and GIT_ALTERNATE_OBJECT_DIRECTORIES
Date: Sat, 04 Oct 2014 20:03:51 +0200
Message-ID: <54303687.5020006@web.de>
References: <878ul19r5y.fsf@steelpick.2x.cz> <542E85B5.3020101@web.de> <87tx3l4ban.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Vokac Michal <michal.vokac@comap.cz>
To: Michal Sojka <sojkam1@fel.cvut.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 04 20:04:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaTgY-00083Z-Ig
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 20:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbaJDSD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2014 14:03:58 -0400
Received: from mout.web.de ([212.227.17.12]:63830 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbaJDSD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2014 14:03:57 -0400
Received: from [192.168.178.41] ([79.211.125.194]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MKJ7S-1Xc7Zt0WZC-001fV5; Sat, 04 Oct 2014 20:03:55
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <87tx3l4ban.fsf@steelpick.2x.cz>
X-Provags-ID: V03:K0:XqmeWFLMjNHc2xqtgT7/DkU9NS+S9sdn94s7X8923Tr2ufW4iOf
 vmvMdU0lV1WfFE3PZ2h+FNdt+b14EqrGjlVD/97Exbj+xK92X0c/kZemMsMdfgYZl86Vbb5
 5vRq3XoFXACbd482DNSXKqlXGpyhTnFjlzscwg1PbAkZHQF48KPCflzbMkwk9C/CUFAB7To
 Tc9wBmnwhFEJN5VJLbPNw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257890>

Am 03.10.2014 um 13:56 schrieb Michal Sojka:
> On Fri, Oct 03 2014, Jens Lehmann wrote:
>> Am 30.09.2014 um 15:25 schrieb Michal Sojka:
>>> I'd like to shorten the time needed by our continuous integration (CI)
>>> tool to clone the source repositories. Currently the full clone takes
>>> about 10 minutes (even from local server). Our main repository has
>>> several submodules so the CI tool runs "git submodule update --init". My
>>> idea was to use GIT_ALTERNATE_OBJECT_DIRECTORIES to cache objects from
>>> several submodule repositories locally. However, this does not work
>>> because GIT_ALTERNATE_OBJECT_DIRECTORIES is considered local to the
>>> super-project and is not propagated to the "git clone" for submodules
>>> (git-submodule.sh calls clear_local_git_env).
>>   >
>>> My question is why is GIT_ALTERNATE_OBJECT_DIRECTORIES considered local
>>> to the repository? If I could modify the command-line I would use the
>>> "git submodule update" with the --reference option, which is propagated
>>> to clones of all submodules. Letting GIT_ALTERNATE_OBJECT_DIRECTORIES
>>> propagate to the submodules should have the same effect as --reference
>>> option. So why it is not propagated?
>>
>> Because then it would /always/ propagate? So while that would have the
>> same effect as using the --reference option, not using the --reference
>> option would behave differently, no?
>
> That's a good reason, thanks. Fortunately, I found a way how to add
> --reference to the submodule update command issued by the CI tool
> (Bamboo). Instead of calling git directly, the CI tool calls my "git"
> script, which modifies the command line in case of "submodule update"
> and then calls the real git.

Good to hear that! In the CI tool we use at $dayjob (Jenkins) we do
not use the automatic submodule update provided by the Git plugin
but call submodule update in the shell execution before building it.
