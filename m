From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Why is git submodule slow under windows
Date: Fri, 18 Jul 2014 20:01:52 +0200
Message-ID: <53C96110.7020801@web.de>
References: <18956e25b6c14091a64af5a65ce5d13c@FE-MBX1009.de.bosch.com> <53C90E44.6030702@virtuell-zuhause.de> <20140718130241.GD14720@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Armbruster Joachim (BEG/EMS1)" <Joachim.Armbruster@de.bosch.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Fredrik Gustafsson <iveqy@iveqy.com>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 20:02:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8CTp-0004TH-Qg
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 20:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbaGRSB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 14:01:58 -0400
Received: from mout.web.de ([212.227.15.14]:50077 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030501AbaGRSB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 14:01:57 -0400
Received: from [192.168.178.41] ([84.132.190.188]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M0yvn-1WGf7e0eD9-00v9P6; Fri, 18 Jul 2014 20:01:53
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140718130241.GD14720@paksenarrion.iveqy.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:sN1B2h+zxQr/MG/zISSEQZYZ0xJgrzuEcAA00/EcNSv5jEoNBTb
 J4JoL80nq0u1/5VvHKtixoOV42/croeoFxSVvmaXPafX81CUGIJzgwgDf1I6plt69qFyxiV
 FT2BlSBqRW4dfaRg6JRjpeIJoGU8kVTqtIsi+aS9ZsqX4KfNIXbziVyjMMUCMT3m4Wyiu2J
 DHJfMASvCb02CruAMS9+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253833>

Am 18.07.2014 15:02, schrieb Fredrik Gustafsson:
> On Fri, Jul 18, 2014 at 02:08:36PM +0200, Thomas Braun wrote:
>> Am 18.07.2014 12:14, schrieb Armbruster Joachim (BEG/EMS1):
>>> Hello,
>>>
>>> We split a monolithic repository into ~50 submodules. The stored data
>>> has the same size. In the 1:1 comparison to the monolithic
>>> repository, the submodule handling is very slow. Under Linux
>>> everything remains fast, but windows is slow.
>>>
>>> So, why is git getting slow when it has to deal with a lot of
>>> submodules? I read something about the lack of the underlying cygwin
>>> to handle NTFS in a efficient way. Is this the root cause, or are
>>> there other causes also?
>>>
>>
>> Hi,
>>
>> I assume you are using the latetst git from https://msysgit.github.io on
>> windows.
>>
>> I would guess that submodules on windows are slow because
>> git-submodules.sh is a shell script, and bash on windows is not really
>> that fast.
> 
> My guess is that because the shell script uses fork() heavily and fork()
> is an expensive operation on Windows, that alone causes the slowddown.
> 
> I did a quick test a while back when I rewrote part of git-submodule.sh
> in lua and runned it on my repo with ~45 submodules. The speedup was
> significant and should be even bigger on windows.

Without having looked at your Lua rewrite I suspect my recursive
submodule checkout series could speed that up even more, as it
only needs to fork a "git status" followed by a "git checkout" or
"git read-tree" for each submodule. Now that my submodule test
harness and Heiko's submodule config lookup API did hit next,
this is the thing I'm currently working on.
