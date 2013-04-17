From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule deinit: clarify work tree removal message
Date: Wed, 17 Apr 2013 22:30:30 +0200
Message-ID: <516F0666.5080308@web.de>
References: <5112C6F6.4030607@web.de> <CABURp0pC2FELxM5aUwxuTqS1roZm+fwkCQA+BoXjrd0+yQMmbg@mail.gmail.com> <7v1ubk8u6o.fsf@alter.siamese.dyndns.org> <51477EFF.2010505@web.de> <7v7gl4mabf.fsf@alter.siamese.dyndns.org> <5159D9A8.30901@web.de> <CABURp0rkeYc7K0COhc1+96Q2Ox2TaNRpMSmQYOiwBpgPJbsafA@mail.gmail.com> <7vppxthh44.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 22:31:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USZ0U-0002NH-NK
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 22:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936442Ab3DQUa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 16:30:56 -0400
Received: from mout.web.de ([212.227.17.12]:61043 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936438Ab3DQUay (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 16:30:54 -0400
Received: from [192.168.178.41] ([91.3.145.117]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MEEa4-1UM1YE2GGe-00G3HY; Wed, 17 Apr 2013 22:30:31
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vppxthh44.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:Ml0tqTwSLbMEpXValOdSLshOSx+3Fr8tz7+zGRkq69V
 QJT7ZkQ/e8vksjFnB1bl+YcoE+h0aurnuAZ7LyY+bOfa8gkxXQ
 +cFoHXezyXUG2I1ZOzwqpjuzBGFlw8jimnfVTd9xGUsyuckmkx
 McEEwunhq3UpU9Ge5RHF5VsUcc9VnvN1p6iJ3np/y66qPkYn9o
 VrmzvuS+ZVaxeux1rCzbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221570>

Am 17.04.2013 07:16, schrieb Junio C Hamano:
> Phil Hord <phil.hord@gmail.com> writes:
> 
>> On Mon, Apr 1, 2013 at 3:02 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Okay, so here is the patch for that. If someone could point out
>>> a portable and efficient way to check if a directory is already
>>> empty I would be happy to use that to silence the "Cleaned
>>> directory" message currently printed also when deinit is run on
>>> an already empty directory.
>>
>>    isemptydir() {
>>         test -d "$(find $1 -maxdepth 0 -empty)"
>>    }
> 
> Hrm, -maxdepth and -empty are not even in POSIX.  Folks on GNU
> platforms and BSDs (I checked NetBSD 6 and OpenBSD 5.2) should be
> fine, but it makes other platforms unhappy.

Ok, that is not acceptable.

> What is this check used for?  To avoid running "rmdir" on non-empty
> ones?  Saying "cleaning foo/" (or "cleaned foo/") when foo/ is
> already empty is not a crime; not omitting an empty one may actually
> be a better behaviour from the point of view of repeatability and
> uniformity.

It's no big issue, but 'init' issues the "Submodule ... registered
for path ..." message only once and is quiet on subsequent calls,
'deinit' does the same with "Submodule ... unregistered for path
...", only the "Cleared directory ..." message appears each time
'deinit' is called, which makes it stand out. I do not believe
this little inconsistency is important enough to write a helper in
C (to have a portable way to see if the directory has already been
cleared), but this simple additional "if" looked easy enough. That
should have made me suspicious ;-)
