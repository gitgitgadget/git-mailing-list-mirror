From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Tue, 25 Jun 2013 22:23:47 +0200
Message-ID: <51C9FC53.3090509@web.de>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C7A875.6020205@gmail.com> <7va9mf6txq.fsf@alter.siamese.dyndns.org> <51C9EE26.9010006@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, dpotapov@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 22:24:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrZmv-0003e0-Vd
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 22:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab3FYUY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 16:24:26 -0400
Received: from mout.web.de ([212.227.15.3]:57753 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab3FYUYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 16:24:25 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0M7Kis-1U6bUT45SQ-00x3dr; Tue, 25 Jun 2013 22:23:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51C9EE26.9010006@kdbg.org>
X-Provags-ID: V03:K0:1S2WUBZAqtZGNa5ZZtdOkRsdPuIobuFEOt+rjgVIYblinU8OClf
 c4u/1xCPs0XYY0MZM+mEjhA3SsOOWcoW5/NLQc1i2xV46bxvGl0OIi8yQO/8QaOJBQp+7nu
 Cj5LtDw9/rn5wuMF2lBWXmb+ZaUpbi+vTZ8xwJ13+2JRsC+kEc+xzEGHFX2RtWnra9Ak68C
 BAos0h9OGH1Z35yDVCIGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228987>

On 25.06.13 21:23, Johannes Sixt wrote:
> Am 25.06.2013 00:10, schrieb Junio C Hamano:
>> Mark Levedahl <mlevedahl@gmail.com> writes:
>>
>>> On 06/22/2013 03:38 PM, Ramsay Jones wrote:
>>>> Also, apart from running the git test-suite, I have the Win32
>>>> l/stat functions disabled on all of my repos. In particular, I have
>>>> core.filemode set to true. (At one point, I used to build git with
>>>> NO_TRUSTABLE_FILEMODE reset so that I wouldn't have to remember to
>>>> reset core.filemode by hand after a git-clone or git-init). I should
>>>> also note that I run MinGW git on the same laptop and, using git.git
>>>> as an example, it does not seem that much faster (if at all) than
>>>> cygwin git.
>>>
>>> After applying your patch to master, I've had the test-suite running
>>> in a VM using WinXP + current cygwin (v1.7.x) for about 8 hours, no
>>> failures so far but it could take another day to complete.
>>>
>>> I never found any real speed up using the Win32 stat/lstat functions,
>>> and the lack of Posix compatibility breaking cross-platform projects,
>>> links, etc.,  made this function a mis-feature in my opinion for
>>> years. As I found no positive benefit from the Win32 lstat, I modified
>>> git for local use years ago to set core.filemode=true when cloning /
>>> initing to avoid as many issues as possible.
>>
>> So that's two votes to use the vanilla Cygwin stat/lstat,
>> essentially reverting adbc0b6b (cygwin: Use native Win32 API for
>> stat, 2008-09-30), which was added by Dmitry and Shawn while I was
>> away.
>>
>> Let's wait and see if people give us more data points and decide.
> 
> That'll be more productive if we let the list know ;-)
> 
> Some context: This is about a patch by Ramsay that removes the
> "schizophrenic lstat" hack for Cygwin. Junio, can you please queue that
> patch in pu?
> 
> -- Hannes
>

Here some benchmarks:
Clone the linux kernel from August 2012 (which was "in house") to the windows box,
2.3 GhZ Core duo.
Run with and without core.filemode, which triggers cygwinfstricks (and is shorter to type)
Numbers are typical "hot cache", cold cache is 6..8 seconds "real"


$ git --version
git version 1.8.3.1.g6f17ca7
__________________________________

$ time git -c core.filemode=true  status -uno
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   include/linux/netfilter/xt_CONNMARK.h
#       modified:   include/linux/netfilter/xt_DSCP.h
#       modified:   include/linux/netfilter/xt_MARK.h
#       modified:   include/linux/netfilter/xt_RATEEST.h
#       modified:   include/linux/netfilter/xt_TCPMSS.h
#       modified:   include/linux/netfilter_ipv4/ipt_ECN.h
#       modified:   include/linux/netfilter_ipv4/ipt_TTL.h
#       modified:   include/linux/netfilter_ipv6/ip6t_HL.h
#       modified:   net/netfilter/xt_DSCP.c
#       modified:   net/netfilter/xt_HL.c
#       modified:   net/netfilter/xt_RATEEST.c
#       modified:   net/netfilter/xt_TCPMSS.c
#
no changes added to commit (use "git add" and/or "git commit -a")

real    0m2.313s
user    0m0.577s
sys     0m1.765s
------------------------------------------------------
tb@snoopy ~/projects/linux-2.6
$ time git -c core.filemode=false status -uno
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   include/linux/netfilter/xt_CONNMARK.h
#       modified:   include/linux/netfilter/xt_DSCP.h
#       modified:   include/linux/netfilter/xt_MARK.h
#       modified:   include/linux/netfilter/xt_RATEEST.h
#       modified:   include/linux/netfilter/xt_TCPMSS.h
#       modified:   include/linux/netfilter_ipv4/ipt_ECN.h
#       modified:   include/linux/netfilter_ipv4/ipt_TTL.h
#       modified:   include/linux/netfilter_ipv6/ip6t_HL.h
#       modified:   net/netfilter/xt_DSCP.c
#       modified:   net/netfilter/xt_HL.c
#       modified:   net/netfilter/xt_RATEEST.c
#       modified:   net/netfilter/xt_TCPMSS.c
#
no changes added to commit (use "git add" and/or "git commit -a")

real    0m1.047s
user    0m0.311s
sys     0m0.765s

/Torsten
