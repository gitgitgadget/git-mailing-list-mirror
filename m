From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: commit --amend --author   error
Date: Thu, 15 Jan 2015 15:21:01 +0100
Message-ID: <54B7CCCD.1070708@drmicha.warpmail.net>
References: <54B4D428.2050300@irisgermanica.com> <54B50062.3090209@drmicha.warpmail.net> <20150114120943.GA30383@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Gunnar Wagner <gunnar.wagner@irisgermanica.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:21:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBlIN-0001Wh-U4
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 15:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbbAOOVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 09:21:05 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43080 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751900AbbAOOVE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 09:21:04 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 68945213F8
	for <git@vger.kernel.org>; Thu, 15 Jan 2015 09:21:03 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 15 Jan 2015 09:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ufxns0CwuAsDAj8Epl487P
	5axow=; b=Ed8Ou+MdqsVaFzcwwAY0VdNRWb//vt4+g1z0b0hSPeJrDASmWSulAm
	/AQO41zCSVt8LH+eECrv91B+hMx+bEybQpQFpZShJO2Dms2pswUYtEXmzzK5VWKB
	FfSzC/2RKVC8Sfn1uUIHaMsRAWQ0/EBlP9oAg4KYLkaCInAvn5SKQ=
X-Sasl-enc: 4bXbJl7EIxj+eR8Oj6pJLeqdqj/+rRDZ7DHzwuchcrEg 1421331663
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C7862C00012;
	Thu, 15 Jan 2015 09:21:02 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20150114120943.GA30383@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262479>

Jeff King schrieb am 14.01.2015 um 13:09:
> On Tue, Jan 13, 2015 at 12:24:18PM +0100, Michael J Gruber wrote:
> 
>> Gunnar Wagner schrieb am 13.01.2015 um 09:15:
>>> I got APGL licensed code from someone else and want to post it on my 
>>> github (without taking credit for the work)
>>>
>>> tried   git commit --amend --author="Author name, www.website.com" but 
>>> got an error message which said something like "original author not found"
>>> Can it be that the --amen --author only work if the author is on github 
>>> himself?
>>>
>>
>> This has nothing to do with github.
>>
>> The author has be in the form "authorname <authoremail>". The important
>> parts for the format are the <>.
> 
> Yes, but the error message is a hint that there is something else going
> on. When there are no angle brackets, some DWIM magic kicks in: git
> tries to find a matching author by walking the project history from
> HEAD. So you can do (in git.git):
> 
>   $ git commit --allow-empty -m foo --author=gruber
>   [detached HEAD 73ef08b] foo
>    Author: Michael J Gruber <git@drmicha.warpmail.net>

(git commit --allow-almost-empty in the case of that author, hum)

> Of course that does not work if you do not already have commits from the
> person in your repository:
> 
>   $ git commit --allow-empty -m foo --author=foobar
>   fatal: No existing author found with 'foobar'
> 
> -Peff

That is the full explanation, yes:

Neither can "Author name, www.website.com" be parsed as a complete valid
"name <email>"
nor can it be matched as part of an existing "name <email>" in the repo.

The OP clearly tried to do the first and got an error message about the
second. Maybe we can do better here?

Michael
