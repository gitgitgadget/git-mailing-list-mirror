From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git submodule, multi-threading the update process for large number
 of registered submodules
Date: Tue, 02 Sep 2014 21:30:10 +0200
Message-ID: <54061AC2.9020705@web.de>
References: <CAK9Skq_-cidRHrbVNgJqoV3nYCxRNDO6vTifOJRUFKaWEZyzkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>
To: Jose Paredes <jose.paredes.rios@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 21:30:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOtmY-0001XX-1N
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 21:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbaIBTaP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 15:30:15 -0400
Received: from mout.web.de ([212.227.17.12]:59675 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889AbaIBTaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 15:30:14 -0400
Received: from [192.168.178.41] ([79.211.101.151]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M7KN0-1YIdT30g4s-00x6vZ; Tue, 02 Sep 2014 21:30:11
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAK9Skq_-cidRHrbVNgJqoV3nYCxRNDO6vTifOJRUFKaWEZyzkw@mail.gmail.com>
X-Provags-ID: V03:K0:IJmX/1QSofedFVU7E6MIEZSVon7wTWlSPf4flP7Jdks7UKZj2Z7
 bLNQt3yyjXjOFeHxmRNF6H2j/OHxD/HHlnBLnTuihgJ/FHLhsGwM0LAkW0eCCCFTCaRklQJ
 /zk3sVbi3TtSj6YSnVaLnTNpyR53plGEjhJlj5unZuZ7I4Wj+quzL1pYltF6E3KduHPFiyo
 6i9yvogRblTMaddka0Vhw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256342>

Hi Jos=C3=A9,

Am 02.09.2014 um 09:53 schrieb Jose Paredes:
> Is there any way to run "git submodule update" in multiple threads?
>
> The use case:
> -------------------
> "git submodule update" seems to be inefficient when running
> sequentially on a large .gitmodules file.
> Assuming a git forest with over 7K gits it takes hours to complete th=
e
> update (running on Windows+Cygwin)

Wow, over 7000 submodules under Windows? I can imagine that a
submodule update takes some time under these circumstances.

> If not supported, this feature could be a good candidate for "git
> submodule" enhancement.
> What is your opinion or advice?

Hmm, are we really sure parallel execution would be faster? I can
imagine that "git fetch" could profit a lot from fetching more than
one submodule at a time (assuming you are not fetching from the same
upstream server), but I'm not so sure about submodule update. And
things might also be rather different e.g. on Windows and Linux.

Could you do some benchmarks comparing "git submodule update" with a
script that does something like:

   (cd <submodule>; git checkout <commit recorded in superproject>)&

for each changed submodule to see if we could gain anything from
executing the update in parallel? (You should be able to extract
which submodules must be checked out to what commit by doing e.g.
"git diff --raw <start> <target> | grep ^:160000" and processing
the output a bit further).
