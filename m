From: SungHyun Nam <goweol@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH
Date: Thu, 17 Jul 2008 09:32:42 +0900
Message-ID: <487E932A.5080502@gmail.com>
References: <g5jj21$bsp$1@ger.gmane.org> <bd6139dc0807160347n2ebcd64fy7a15fe94bfabe580@mail.gmail.com> <7vr69tu91e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, namsh@posdata.co.kr, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 02:34:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJHRa-0000Ta-7w
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 02:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665AbYGQAc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 20:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbYGQAc7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 20:32:59 -0400
Received: from main.gmane.org ([80.91.229.2]:39417 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbYGQAc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 20:32:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJHQR-0004M4-G7
	for git@vger.kernel.org; Thu, 17 Jul 2008 00:32:51 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 00:32:51 +0000
Received: from goweol by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 00:32:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7vr69tu91e.fsf@gitster.siamese.dyndns.org>
X-Stationery: 0.4.10
X-Stationery: 0.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88792>

Junio C Hamano wrote:
> "Sverre Rabbelier" <alturin@gmail.com> writes:
> 
>> On Wed, Jul 16, 2008 at 3:31 AM, SungHyun Nam <goweol@gmail.com> wrote:
>>> Signed-off-by: SungHyun Nam <goweol@gmail.com>
>>> ---
>>>  t/Makefile |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/t/Makefile b/t/Makefile
>>> index a778865..0d65ced 100644
>>> --- a/t/Makefile
>>> +++ b/t/Makefile
>>> @@ -26,7 +26,7 @@ clean:
>>>        $(RM) -r 'trash directory' test-results
>>>
>>>  aggregate-results:
>>> -       ./aggregate-results.sh test-results/t*-*
>>> +       '$(SHELL_PATH_SQ)' ./aggregate-results.sh test-results/t*-*
>>>
>>>  # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
>>>  full-svn-test:
>>> --
>>> 1.5.6.3.350.g6c11a
>> It is not clear to me what this patch does, there is no justification
>> in the commit msg either. Instead you say what is being done, which we
>> can see from the commit diff. Please clarify?
> 
> It wants to make sure that the shell specified from the toplevel Makefile
> (or from make command line) is used to run the aggregation script.  It is
> often necessary when platform /bin/sh is not quite POSIX (e.g. the script
> in question uses arithmetic expansion "$(( $var1 + $var2 ))").
> 
> Just saying "Use specified shell to run shell scripts" on the title line
> would be sufficient, but I wonder if this is the only remaining place...

For the 'make test', yes, it's the only remaining place to me.
Well, I skip the cvs/svn/.. tests which I never use.
And I need this patch for the Solaris.


And I also need to run a script function below between 'make all'
and 'make test/install'. I hope GIT does this. Of course, GIT's
Makefile would use SHELL_PATH and PERL_PATH.

git_fix_interpreter()
{
     p="/usr/local/bin/perl"
     if test -x "$p"
     then
         for f in $(find . -name '*.perl')
         do
             e=$(dirname $f)/$(basename $f .perl)
             [ -f "$e" -a -x "$e" ] \
                 && "$p" -pi -e 
's@^#!/usr/(bin/perl.*)$@#!/usr/local/\1@g' "$e"
         done
     fi
     if test -x /bin/bash
     then
         for f in $(find . -name '*.sh')
         do
             e=$(dirname $f)/$(basename $f .sh)
             [ -f "$e" -a -x "$e" ] \
                 && "$p" -pi -e 's@^#!/bin/sh(.*)$@#!/bin/bash\1@g' "$e"
         done
     fi
}
