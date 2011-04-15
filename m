From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Symbolic 'references' in Git?
Date: Fri, 15 Apr 2011 10:27:14 +0200
Message-ID: <4DA80162.1070703@drmicha.warpmail.net>
References: <BANLkTinV8niLibzOQRVraYqwB0hKW1=r1w@mail.gmail.com>	<201104141524.15212.wjl@icecavern.net> <BANLkTik5tD5UOrDkpL8ahEgwFjT+suHACQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Wesley J. Landaker" <wjl@icecavern.net>, git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 10:27:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAeNV-000199-GK
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 10:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab1DOI1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 04:27:40 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60005 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751788Ab1DOI1R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 04:27:17 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3300F21AB6;
	Fri, 15 Apr 2011 04:27:16 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 15 Apr 2011 04:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ypysi1qquZkpUvzdUASQqePXJdo=; b=FLH06MIDIua3czviu4Z8tnztST51LjP4Y7Cxr+arOxp7bogZ/DlKSKeHmo9jxItwWauWzMR32rqRjZv1g8qfB/4JytB/WSBBcj8/st0HGwvSTyQd/7DgjL6EsoOFLs8iXLJ7+EBPsWOPqa+cdL9/Kss6wO2psYZNtjc5nSCp5QA=
X-Sasl-enc: JSLR6edwE1B+dtB7glPSLL4HHuW8fHI5sLSi5LLDFbMn 1302856035
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8F905401A66;
	Fri, 15 Apr 2011 04:27:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <BANLkTik5tD5UOrDkpL8ahEgwFjT+suHACQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171593>

Chris Patti venit, vidit, dixit 14.04.2011 23:31:
> On Thu, Apr 14, 2011 at 5:24 PM, Wesley J. Landaker <wjl@icecavern.net> wrote:
>> On Thursday, April 14, 2011 14:30:59 Chris Patti wrote:
>>> We want a way to have our Bamboo configuration utilize a symbol to
>>> refer to 'latest release' 'latest patch' etc. in Git, rather than
>>> having to go in and change the actual branch name every time we ship a
>>> release and create a new one.
>>>
>>> We thought about using something like:
>>>
>>> git symbolic-ref -m'new next-release branch build for Bamboo'
>>> next-release release-3.15
>>>
>>> However, this symbolic ref is only local to one repository, and we
>>> want it to be global across all of Bamboo.
>>>
>>> Rather than resorting to manually copying the symbolic ref file
>>> around, from repo to repo, is there any way to make such a symbolic
>>> 'variable' global?
>>
>> Why not just use a tag or a branch ?
>>
>> git tag -F next-release release-3.15
>>
>>  OR
>>
>> git branch -D next-release
>> git branch next-release release-3.15
>>
>> (I personally think branches are nicer for this since tags are "supposed" to
>> be immutable.)
>>
> 
> 
> Won't either of those things create a 'next-release' that's frozen in
> time where the release-3.15 branch is *right now*?
> 
> This is for a CI system (Bamboo) so we need next-release to act as if
> we were using release-3.15 itself.

Maybe add a refspec

refs/heads/release-3.15:refs/heads/release

which ensures that you push that branch out under two names? When you
(integrator/release manager) switch to a different release branch you
just need to change your config (and probably push -f).

Michael
