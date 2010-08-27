From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Does changing filename case breaks git's rename heuristic?
Date: Fri, 27 Aug 2010 17:46:36 +0200
Message-ID: <4C77DDDC.8070407@drmicha.warpmail.net>
References: <AANLkTinxvj85Jzb-ykK0=MmRHkz8aQzmVxexC8H+Xgno@mail.gmail.com> <4C777090.2000107@drmicha.warpmail.net> <AANLkTikN_PbNNH2f4zWuk1FH+LgpKzkoZ6mYOdT9ANBj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dan Loewenherz <dloewenherz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 17:46:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op18c-0002t4-LL
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 17:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab0H0Pqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 11:46:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40631 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603Ab0H0Pqg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 11:46:36 -0400
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9DBCA436;
	Fri, 27 Aug 2010 11:46:35 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 27 Aug 2010 11:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=h1UsVp5ngiA9RTEiwE8S3rV3LgQ=; b=ehxf2bGp69rqgnlin7dwF4v+Yd/JYrIFCRwcCMjLcL5dRECjK5TNEckHvAM0S64lZbAutu2LsnxiFTJw95xjMoV5U2p370UkZB2ggP2bfDRF4YYX9i1CAacl+GHBY/Xm/UsKBXc+1I15h7zw3T2GeD1gbRij6AlLXGB0V90+mxs=
X-Sasl-enc: sbQwojJuoTbw2ZVm6DdHXAvxKPnqcSBvP7u7BjiYqvFy 1282923995
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 22FED409906;
	Fri, 27 Aug 2010 11:46:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <AANLkTikN_PbNNH2f4zWuk1FH+LgpKzkoZ6mYOdT9ANBj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154602>

Dan Loewenherz venit, vidit, dixit 27.08.2010 16:52:
> On Fri, Aug 27, 2010 at 1:00 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Dan Loewenherz venit, vidit, dixit 27.08.2010 06:57:
>>> Hi all,
>>>
>>> I may be mistaking a design decision as a bug, but I wanted to throw
>>> this out to the list to make sure. I think that re-enacting it will be
>>> the best way to explain it.
>>>
>>> $ mkdir test
>>> $ cd test
>>> $ git init
>>> $ cat > readme
>>> This is a test file.
>>> ^D
>>> $ git commit -am "first commit"
>>> [master (root-commit) fae0d05] first commit
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> ? You have not added any file, so git won't commit anything (not even
>> with -a). The above can't be a complete transcription. I assume you've
>> added readme with the content above.
> 
> Yep, that was my mistake. I left out 'git add readme'.
> 
>>
>>>
>>> For personal reasons, I now want readme to be uppercase.
>>>
>>> $ mv readme README
>>
>> Here's where using "git mv" would have been the easier choice, followed
>> by commit.
> 
> I agree. The instance where this actually occurred was that I had
> received an updated binary file to put into my repository. icon.png ->
> Icon.png. I suppose I could've run 'git mv' but I didn't realize what
> would happen if I didn't!
> 
>>
>>> $ cat > README
>>> This is the revised README.
>>
>> Renaming and changing the content completely in one step will always
>> trip up git's rename detection. You should rename, commit, change,
>> commit, unless the change affects a small portion of the file only.
> 
> Agreed.
> 
>>
>>> $ git status -sb
>>> ## master
>>>  M readme
>>
>> Again, this can't be a complete transcript. The above would lead to
>>
>>  D readme
>> ?? README
> 
> This is where I didn't botch up the transcript, and where I was
> actually surprised at what was going on. I'll insert a full one at the
> bottom of this email that can actually be run to get the same results.
> 
>>
>>> $ git add README
>>> $ git status -sb
>>> ## master
>>>  M readme
>>>
>>> At this point, I'm thinking that git is confused. Even though I've
>>
>> Are you possibly using a case-challenged file system? Is this maybe on a
>> Mac with HFS or Win with NTFS?
> 
> I'm using a Mac with a journaled filesystem and Git version 1.7.2.1.

The journalling is no problem, but HFS is. I'm no Macxpert but if I
remember correctly, then under HFS "readme" and "README" are the same
file, i.e. HFS only remembers how you want it spelled. People will
correct me where I'm wrong.

Your test script should produce the expected result if you use, say,
"readme" and "RAEDME" , i.e. names which differ by more than just case.

Cheers,
Michael

> Transcript
[snipped]
