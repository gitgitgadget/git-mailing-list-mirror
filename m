From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Fri, 02 Apr 2010 09:56:44 -0500
Message-ID: <RWfCNK1AsUFfin9YdRY1QqUtD-ISnv9hImfDeE0DFlh3_fRWdvEF2w@cipher.nrlssc.navy.mil>
References: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com> <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil> <u2ld2d39d861004020707m7577182et40b4cd6b93bae830@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Apr 02 16:58:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxiJA-0003Fm-9p
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 16:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab0DBO5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 10:57:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50622 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab0DBO47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 10:56:59 -0400
Received: by mail.nrlssc.navy.mil id o32Euiou004946; Fri, 2 Apr 2010 09:56:44 -0500
In-Reply-To: <u2ld2d39d861004020707m7577182et40b4cd6b93bae830@mail.gmail.com>
X-OriginalArrivalTime: 02 Apr 2010 14:56:44.0575 (UTC) FILETIME=[B60BDAF0:01CAD274]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143818>

On 04/02/2010 09:07 AM, Tor Arntsen wrote:
> On Wed, Mar 31, 2010 at 18:29, Brandon Casey
> <brandon.casey.ctr@nrlssc.navy.mil> wrote:
>> On 03/30/2010 01:22 PM, Tor Arntsen wrote:
>>> This patch to Makefile makes git build for me on Tru64/OSF1 V5.1 with
>>> the native compiler.
> [..]
>>> +ifeq ($(uname_S),OSF1)
>>> +     # Tested with V5.1 w/libcurl and zlib-1.1.4-5 in /usr/local/
>>> +     CC = cc
>>> +     CFLAGS = -O2 -g3
>> I wonder if the native compiler will be the most common compiler
>> used on this platform?  I tend to lean towards configuring the
>> Makefile for gcc, unless gcc is not available for a platform. The
>> user can set CC and CFLAGS in config.mak and on the make command
>> line if they desire something different.
>>
>> This isn't an objection by me, I'm just mentioning it to bring
>> attention to the issue in case others think it is worthy for
>> git to have a stated policy one way or the other.
> 
> I'm not certain. I do in fact have gcc (3.3) installed on this Tru64
> box, but it doesn't seem to be part of the original 'freeware' CD that
> used to come with Tru64. Besides, the freeware CD was first removed as
> physical CD, and later (two or three years ago, apparently) pulled by
> HP from the online download which was used by their 'tachometer'
> ('apt-get'-like) freeware tool. Tru64 V51B (which seems to be the
> latest, there's no 5.2 as I originally thought) is still available for
> download, and so is the native compiler. As far as I can tell it's
> incredibly difficult to find precompiled freeware/oss packages for
> Tru64 anymore.

So the native compiler is a free download?  Then yeah, it sounds like
configuring the Makefile for the native compiler is the right thing
to do.

>> Also, I wonder if it suffers from the same trap handling that
>> ksh has on SunOS.
> [..]
> I tested that snippet you provided, and it exits with 0 on Tru64 (I
> also verified that indeed it doesn't on Solaris 10).

Ok, good.  Solaris's ksh is the only one I've found that handles it
wrong.

Here's another snippet which will show whether $? has the correct
value inside a trap on EXIT:

   (atrap () { exit $?; }
    trap atrap EXIT
    exit 1) && echo 'FAILURE' || echo 'SUCCESS'

If that prints 'FAILURE', then you will need the patch that I have in
order to run the test suite.  ksh from IRIX 6.5 and Solaris both fail.

-brandon
