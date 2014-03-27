From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Possible regression in master? (submodules without a "master"
 branch)
Date: Thu, 27 Mar 2014 18:23:17 +0100
Message-ID: <53345E85.7070205@web.de>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com> <20140327155208.GM4008@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 18:24:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTE2B-0003PS-FR
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 18:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbaC0RX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 13:23:58 -0400
Received: from mout.web.de ([212.227.15.3]:63949 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195AbaC0RXy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 13:23:54 -0400
Received: from [192.168.178.41] ([84.132.148.44]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MWB8f-1Wa2bh0cOH-00XNT0; Thu, 27 Mar 2014 18:23:28
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140327155208.GM4008@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:TT037r6SgeYy1g9wo+Ht7ZrYzD0aFOG6iCH+uGC8Bln/ihN2rX6
 eO02W1Dh1FI5Itm6FNHyYfH9EL2GZHKM+D556W5MLWW73kYbrR+yydEBmd908ZsYsjCXnvJ
 cpjLkrydjpW/3C1z8Gp0yUNzsKHVNCxosCuFPC0RhR8xyd42nHDJ3jtdIFHt83z9xyJTdqN
 OHFATvNITzW4GBLyK2F4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245296>

Am 27.03.2014 16:52, schrieb W. Trevor King:
> On Thu, Mar 27, 2014 at 03:21:49PM +0100, Johan Herland wrote:
>> I just found a failure to checkout a project with submodules where
>> there is no explicit submodule branch configuration, and the
>> submodules happen to not have a "master" branch:
> 
> The docs say [1]:
> 
>   A remote branch name for tracking updates in the upstream submodule.
>   If the option is not specified, it defaults to 'master'.

But the "branch" setting isn't configured for Qt, the .gitmodules
file contains only this:

[submodule "qtbase"]
	path = qtbase
	url = ../qtbase.git
...

> which is what we do now.  Working around that to default to the
> upstream submodule's HEAD is possible (you can just use --branch
> HEAD), but I think it's easier to just explicitly specify your
> preferred branch.

That is *not* easier, as Johan did not have to do that before.

I think your patch 23d25e48f5ead73c9ce233986f90791abec9f1e8 does
not do what the commit message promised:

    With this change, folks cloning submodules for the first time via:

      $ git submodule update ...

    will get a local branch instead of a detached HEAD, unless they are
    using the default checkout-mode updates.

And Qt uses the "default checkout-mode updates" and doesn't have
"branch" configured either. So we are facing a serious regression
here.

> Cheers,
> Trevor
> 
> [1]: submodule.<name>.branch in gitmodules(5)
>      http://git-scm.com/docs/gitmodules.html
> 
