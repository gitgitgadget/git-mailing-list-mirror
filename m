From: Eric Raible <raible@nextest.com>
Subject: Re: Should 'git status' understand a .git containing "gitdir: dir"?
Date: Thu, 30 Jun 2011 09:48:57 -0700
Message-ID: <4E0CA8F9.1080601@nextest.com>
References: <4E0C3C1D.1050406@nextest.com> <7vsjqrqpzn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 18:49:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcKQL-0003uq-5i
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 18:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261Ab1F3Qs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 12:48:59 -0400
Received: from exchange.domain1.nextest.com ([12.96.234.114]:3677 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750959Ab1F3Qs7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2011 12:48:59 -0400
Received: from [131.101.151.1] (131.101.151.1) by Exchange.DOMAIN1.nextest.com
 (131.101.21.39) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 30 Jun
 2011 09:52:23 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vsjqrqpzn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176491>

On 6/30/2011 8:49 AM, Junio C Hamano wrote:
> Eric Raible <raible@nextest.com> writes:
> 
>> The following sequence sets up a trivial repo that uses "gitdir:":
>>
>> $ git init gitdir-test
>> $ cd gitdir-test
>> $ mv .git real-git-dir
>> $ echo "gitdir: real-git-dir" > .git
>> $ git status
>>
>> Fine so far.  But git-status shows that "real-git-dir" is untracked:
>>
>> $ git status -sb
>> ## Initial commit on master
>> ?? real-git-dir/
>>
>> Which strikes one as a bit inconsistent (since other pars of git-status
>> knows to look in real-git-dir to find the index).
>>
>> Sorry - no time to investigate.
> 
> You could even have a real git dir of some completely unrelated repository
> in your working tree, it will get reported as untracked, and you would
> probably not want to track its contents, either (or you might want to if
> you are trying to be funny, I dunno).
> 
> So I do not see there is anything to investigate. What you observed looks
> perfectly expected to me, except for the "mv .git real-git-dir" bit that
> makes a situation that confuses yourself (but not git).
> .

The fact that the repo is stored in .git is an implementation detail -
and one which git-status knows about (in the normal case).

In the gidir: case one part of git status understands the details
(after all - it reads real-git-dir/index) while another part doesn't
(after all - it show the actual repo as a normal directory).

Sure, git-real-dir could be added to git-real-dir/info/exclude.
But by that logic we could insist on adding .git to .git/info/exclude.

The argument about an unrelated repo in the working tree is irrelevant -
.git wouldn't point to it, so there's nothings special about it.

But it's obviously not a big deal either way and I'm gonna drop it.
