From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git pull --rebase differs in behavior from git fetch +
 git rebase
Date: Fri, 27 Aug 2010 20:06:46 -0600
Message-ID: <4C786F36.3060107@workspacewhiz.com>
References: <4C772A01.5030207@workspacewhiz.com>	<alpine.DEB.2.00.1008270124450.20874@narbuckle.genericorp.net>	<4C77DE60.6020809@workspacewhiz.com>	<AANLkTimEO==c7Pzi99VfvDp7S9HN=V2j6t0kk--w1kb9@mail.gmail.com>	<4C783C66.3000008@workspacewhiz.com> <AANLkTimBv3EVWaEnateD95sUi_LkmNw8RKJZYrW4dUFy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dave Olszewski <cxreg@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 04:06:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpAom-0007sS-Nf
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 04:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab0H1CGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 22:06:48 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:54895 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab0H1CGr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 22:06:47 -0400
Received: (qmail 16597 invoked by uid 399); 27 Aug 2010 20:06:46 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 27 Aug 2010 20:06:46 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <AANLkTimBv3EVWaEnateD95sUi_LkmNw8RKJZYrW4dUFy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154628>

  ----- Original Message -----
From: Elijah Newren
Date: 8/27/2010 5:40 PM
> On Fri, Aug 27, 2010 at 4:29 PM, Joshua Jensen
> <jjensen@workspacewhiz.com>  wrote:
>> It reports to me 'git-rebase --onto XXXX XXXX'.
>>
>> And it reports nothing to do.
>>
>> XXXX is properly the origin/master in this case.
>>
>> git rebase origin/master           works.
>> git rebase --onto origin/master origin/master       does not work.
>>
>> Thoughts?
> It's too bad you can't make this repository public; I thought rebase
> should behave the same for those two commands.  We could certainly
> just modify git-pull.sh to avoid using the --onto flag when
> oldremoteref is not defined (and perhaps that makes sense independent
> of anything else), but I'm curious now about rebase.
>
> Can you insert an echo statement right before where git-rebase calls
> format-patch to see what arguments it is passing in those two cases?
> For me it's around line 568; insert an echo statement so that it looks
> like:
>   if test -z "$do_merge"
>   then
>          echo git format-patch -k --stdout --full-index --ignore-if-in-upstream \
>                 --no-renames $root_flag "$revisions"
>          git format-patch -k --stdout --full-index --ignore-if-in-upstream \
>                  --no-renames $root_flag "$revisions" |
>          git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG"&&
> Make that change, and then run it with both your rebase commands and
> see what you get.
>
> For me, in both cases, I get:
>    git format-patch ... --no-renames origin/master..HEAD
> (except sha1sums of what origin/master and HEAD were rather than that
> literal text), which means the same patches are being applied in both
> cases for me.
Okay, there is _not_ a problem with the patch in 1.7.2.2 for the 
"broken" repository I have in front of me right now, but I wish I hadn't 
trashed the other broken repository someone else had.  :(

Before running a successful 'git rebase origin/master' on the broken 
repository, I made a copy of it.  That person then committed and pushed 
the rebased commit.  _I did not know that._

I copied the broken repository into two locations, testrebase and 
testpullrebase.

In the testrebase repository, I ran 'git rebase origin/master'.  I did 
not fetch, so the repository was in the same state as the original 
broken copy.

In the testpullrebase repository, I ran 'git pull --rebase'.  It fetched 
the latest commits (which included the person's pushed rebase commit), 
and I saw it supposedly didn't rebase the commit.  However, it did the 
RIGHT thing, because the commit already exists in the repository.

Sorry for causing an issue, but I definitely appreciate the fix already 
being available.

Josh
