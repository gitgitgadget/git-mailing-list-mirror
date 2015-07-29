From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Log messages beginning # and git rebase -i
Date: Wed, 29 Jul 2015 14:17:02 +0200
Message-ID: <vpq8u9zjgzl.fsf@anie.imag.fr>
References: <loom.20150727T133256-715@post.gmane.org>
	<CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
	<loom.20150728T115023-269@post.gmane.org>
	<vpqsi88qp6q.fsf@anie.imag.fr>
	<xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com>
	<vpq3808p40o.fsf@anie.imag.fr>
	<CACsJy8ABsHBA1TubB+6fypT0LGQF_O+CmHPqL+C7nMVjjWy38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Ed Avis <eda@waniasset.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 14:17:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKQIM-0002Oe-Ae
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 14:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbbG2MRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 08:17:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38051 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbbG2MRI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 08:17:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TCH00l028614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 14:17:01 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TCH2TP017128;
	Wed, 29 Jul 2015 14:17:02 +0200
In-Reply-To: <CACsJy8ABsHBA1TubB+6fypT0LGQF_O+CmHPqL+C7nMVjjWy38w@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 29 Jul 2015 17:47:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 Jul 2015 14:17:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TCH00l028614
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438777021.69279@hH26vXSH65mP5HgaMFcm/A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274893>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jul 29, 2015 at 12:48 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> If the user wants whatever she types in the resulting commit
>>> literally, there is the "--cleanup=<choice>" option, no?
>>
>> $ GIT_EDITOR=touch git commit --cleanup=verbatim
>> [detached HEAD 1b136a7] # Please enter the commit message for your changes. Lines starting # with '#' will be kept; you may remove them yourself if you want
>> to. # An empty message aborts the commit. # HEAD detached from 5e70007 # Changes to be committed: #     modified:   foo.txt # # Changes not staged for commit
>> : #     modified:   foo.txt # # Untracked files: #      last-synchro.txt #
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> You really don't want that in day-to-day use.
>
> How about --cleanup=scissors?

I can read this in two different ways:

1) Keeping git as-is and suggest users to use --cleanup=scissors

   This has the same problem as --cleanup=verbatim: it doesn't work as-is
   since Git doesn't insert the scissors. You can hack around it by
   adding them by yourself when you need it, but it's really not
   convenient. You have to anticipate that you're going to require a #
   and call commit with --cleanup=scissors, add the scissors. And repeat
   it if you need to "commit --amend".

2) Modify Git to add scissors by default, and use --cleanup=scissors by
   default.
 
   This is actually more or less what SVN does: it inserts a line
   "--This line, and those below, will be ignored--", and the equivalent
   of what Git adds as comments in the template is inserted below this
   line.

I don't think option 1) is good. The fact that we have the --cleanup=
option shouldn't serve as an excuse to do nothing. I'd be fine with
option 2), but I find it much more intrusive than to allow a simple
backslash-escaping as I suggest.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
