From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Possible regression in master? (submodules without a "master"
 branch)
Date: Thu, 27 Mar 2014 18:31:27 +0100
Message-ID: <5334606F.5010109@web.de>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com> <xmqqob0ref3v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 27 18:32:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTE9z-0000ci-8I
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 18:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756829AbaC0RcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 13:32:06 -0400
Received: from mout.web.de ([212.227.15.4]:63002 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755487AbaC0RcF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 13:32:05 -0400
Received: from [192.168.178.41] ([84.132.148.44]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LiUC0-1X3fxs48Mu-00cgKf; Thu, 27 Mar 2014 18:31:29
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqob0ref3v.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:6F/6rGQQEos/AEvwKwDcEjmq+HpkMdFhSVeXIkm4fX1FKYRFcuR
 bcOVZVdSwVpyfBQ1aK3mgQZ2d8cjsDQHqBX4tdHVfsw3Ex0G3m+qF+V3jcN8wgt4TmHqYjn
 eS4No2FRtacA5BZKcsTLPeuroziZu9OaNQ409MmwRfUiyhoZFRMaFsijVDRJts+Q9ctVLig
 fp49cT35cLnBfpCmXMR4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245297>

Am 27.03.2014 18:16, schrieb Junio C Hamano:
> Johan Herland <johan@herland.net> writes:
> 
>> I just found a failure to checkout a project with submodules where
>> there is no explicit submodule branch configuration, and the
>> submodules happen to not have a "master" branch:
>>
>>   git clone git://gitorious.org/qt/qt5.git qt5
>>   cd qt5
>>   git submodule init qtbase
>>   git submodule update
>>
>> In current master, the last command fails with the following output:
> 
> ... and with a bug-free system, what does it do instead?  Just clone
> 'qtbase' and make a detached-head checkout at the commit recorded in
> the superproject's tree, or something else?

After reverting 23d25e48f5ead73 on current master it clones 'qtbase'
nicely with a detached HEAD.

>>   Cloning into 'qtbase'...
>>   remote: Counting objects: 267400, done.
>>   remote: Compressing objects: 100% (61070/61070), done.
>>   remote: Total 267400 (delta 210431), reused 258876 (delta 202642)
>>   Receiving objects: 100% (267400/267400), 136.23 MiB | 6.73 MiB/s, done.
>>   Resolving deltas: 100% (210431/210431), done.
>>   Checking connectivity... done.
>>   error: pathspec 'origin/master' did not match any file(s) known to git.
>>   Unable to setup cloned submodule 'qtbase'
>>
>> Bisection points to 23d25e48f5ead73c9ce233986f90791abec9f1e8 (W.
>> Trevor King: submodule: explicit local branch creation in
>> module_clone). Looking at the patch, it seems to introduce an implicit
>> assumption on the submodule origin having a "master" branch. Is this
>> an intended change in behaviour?
> 
> If an existing set-up that was working in a sensible way is broken
> by a change that assumes something that should not be assumed, then
> that is a serious regression, I would have to say.

Yes, especially as it promised to not change this use case.
