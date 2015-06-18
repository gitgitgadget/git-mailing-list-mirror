From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Visualizing merge conflicts after the fact (using kdiff3)
Date: Thu, 18 Jun 2015 14:26:20 +0200
Message-ID: <5582B8EC.1060205@drmicha.warpmail.net>
References: <557F791D.3080003@nextest.com> <87b840d8c73fd7e4e7597e2fd835c703@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 14:26:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Ytn-0007e3-BZ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 14:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbbFRM0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 08:26:24 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54580 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752992AbbFRM0W (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2015 08:26:22 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 9A2BF20995
	for <git@vger.kernel.org>; Thu, 18 Jun 2015 08:26:21 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 18 Jun 2015 08:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=ajPh/Lrc5i2cPZMMutzrxpEty/I=; b=LbjK4i
	eWeHF89EEWhrxCR+FSmX6RQUWwMEOsFdV6NxMl3UHeeQ0bG/aujJSvnub22VqxYq
	MLAb2wJf7907qrFCDqsLP3iIwZBNQP3r3WcDQApBKnbb1a8+e7Qso1j2TuuYGuVY
	O56ZDz2lEIRoWWGUg4w1rFMJom5Pj+/F1WFUE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ajPh/Lrc5i2cPZM
	MutzrxpEty/I=; b=VuQJxHt85mkNTyUjWzL3+WTQolGW5V5SNWKpCQkyFL5H9yT
	fLqRg7eAZ4TaU6U3iXh9d8vypQgTiypw/3qZJp1U53pB6rUQRaFpusVHFspSAklx
	3PeL0s43kw2DHwAcSqzaeapYo2oPuZo3PM/OjNFFinYp5F/oZifmo25iPDuA=
X-Sasl-enc: 6FCxk3duEjwjL29DoMRfT2+AQZBfuON/xbZGi0qu5Ami 1434630381
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F2C5D680130;
	Thu, 18 Jun 2015 08:26:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <87b840d8c73fd7e4e7597e2fd835c703@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272003>

Johannes Schindelin venit, vidit, dixit 16.06.2015 11:43:
> Hi Eric,
> 
> On 2015-06-16 03:17, Eric Raible wrote:
>> I'm running 1.9.5.msysgit.1, but this is a general git question...
>>
>> Upon returning from a vacation, I was looking at what people had been
>> up to, and discovered on merge in which a colleague had resolved a merge
>> incorrectly.  It turns out that he has pushed *many* merges over the past
>> year which had conflicts in my code, and now I don't trust any of them.
>>
>> So naturally I want to check each of them for correctness.
>>
>> I know about "git log -p -cc SHA -- path", but it really doesn't
>> show just the conflicts so there's just too much noise in that output.
>>
>> I use kdiff3 to resolve conflicts, so I'm looking for a way to
>> visualize these already-resolved conflicts with that tool.
>> As I said, there are many merges, so the prospect of checking
>> out each sha, doing the merge, and then comparing the results
>> is completely untenable.
>>
>> Can anyone help?  Surely other people have wanted to review how
>> conflicts were resolved w/out looking at the noise of unconflicted
>> changes, right?
> 
> If I was walking in your shoes, I would essentially recreate the merge conflicts and then use "git diff <merge-commit>" with the resolved merge in your current history.
> 
> Something like this:
> 
> ```bash
> mergecommit=$1
> 
> # probably should verify that the working directory is clean, yadda yadda
> 
> # recreate merge conflicts on an unnamed branch (Git speak: detached HEAD)
> git checkout $mergecommit^
> git merge $mergecommit^2 ||
> die "This merge did not have any problem!"
> 
> # compare to the actual resolution as per the merge commit
> git diff $mergecommit
> ```

This type of request comes up often (for a reason). I'm wondering
whether we could support it more systematically, either by exposing the
steps above as a command, or by storing the unresolved merge somewhere
(leveraging stash or rerere).

> To list all the merge commits in the current branch, I would use the command-line:
> 
> ```bash
> git rev-list --author="My Colleague" --parents HEAD |
> sed -n 's/ .* .*//p'
> ```
> 
> (i.e. listing all the commits with their parents, then filtering just the ones having more than one parent, which would include octopus merges if your history has them.)

:)

"--merges" (aka "--min-parents=2") is your friend here.

> 
> Hopefully this gives you good ideas how to proceed.
> 
> Ciao,
> Johannes
> 

Michael
