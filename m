From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: weird behaviour in git
Date: Thu, 26 Feb 2015 16:22:32 +0100
Message-ID: <54EF3A38.4090708@drmicha.warpmail.net>
References: <20150226141234.GP19896@danbala.tuwien.ac.at> <sfid-H20150226-155240-+046.63-1@spamfilter.osbf.lua> <54EF3179.8030104@drmicha.warpmail.net> <20150226145848.GQ19896@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Klausner <tk@giga.or.at>
X-From: git-owner@vger.kernel.org Thu Feb 26 16:22:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR0Gu-0007bM-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 16:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbbBZPWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 10:22:35 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34974 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753259AbbBZPWe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2015 10:22:34 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id C8C2320691
	for <git@vger.kernel.org>; Thu, 26 Feb 2015 10:22:32 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 26 Feb 2015 10:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=/kqNySP12YONq130m4Wlas
	E6B9k=; b=dqHmi61sRFb9f1vjRMg7uDIPwenByMFYqt08JRKH5rkWzZItZM13j0
	78QNn0MI2UWDyiH0cZLIydD0tf50sVVqJ8MavMZhYzjkDNXPatwkrbS93T5Vtmbl
	IlekeADIOnAXML4pkTp9ELs89QFgHYM0ae+O2KWXPsRfXnfchUAIQ=
X-Sasl-enc: 3P5dNgmGx1z1Adj72yHl1qpXYoPzMiVD4Og5zDffYEcf 1424964153
Received: from localhost.localdomain (unknown [188.96.114.76])
	by mail.messagingengine.com (Postfix) with ESMTPA id 14747680187;
	Thu, 26 Feb 2015 10:22:32 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150226145848.GQ19896@danbala.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264448>

Thomas Klausner venit, vidit, dixit 26.02.2015 15:58:
> On Thu, Feb 26, 2015 at 03:45:13PM +0100, Michael J Gruber wrote:
>> Thomas Klausner venit, vidit, dixit 26.02.2015 15:12:
>>> Hi!
>>>
>>> I've played around with git and found that 'git mv' does not honor
>>> what I tell it to do:
>>>
>>> wiz@yt:~> mkdir a
>>> wiz@yt:~> cd a
>>> wiz@yt:~/a> git init .
>>> Initialized empty Git repository in /home/wiz/a/.git/
>>> wiz@yt:~/a> touch a
>>> wiz@yt:~/a> git add a
>>> wiz@yt:~/a> git commit -m 'add a'
>>> [master (root-commit) 99d0ee7] add a
>>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>>  create mode 100644 a
>>> wiz@yt:~/a> git mv a b
>>> wiz@yt:~/a> touch Makefile
>>> wiz@yt:~/a> git add Makefile
>>> wiz@yt:~/a> git commit
>>>
>>>
>>> # Please enter the commit message for your changes. Lines starting
>>> # with '#' will be ignored, and an empty message aborts the commit.
>>> # On branch master
>>> # Changes to be committed:
>>> #       renamed:    a -> Makefile
>>> #       new file:   b
>>> #
>>>
>>> This is reproducible for me with "git version 2.3.0" on
>>> NetBSD-7.99.5/amd64.
>>>
>>> I guess this happens because the checksums of the files are the same
>>> and 'Makefile' is earlier when sorting, but since I explicitly told
>>> "git mv" old and new name, I think that's a bug nevertheless.
>>>  Thomas
>>>
>>
>> git tracks content, not paths.
>>
>> It does record the path at which the tracked content is, of course. But
>> it tracks the history of content, not that of paths.
>>
>> What you see in the diff above is merely one way to interpret the
>> history of the content. Saying
>>
>> renamed:  a -> b
>> new file: Makefile
>>
>> leads to the same content at the same paths (with the proper new file
>> content).
>>
>> By default, diff tries to interpret content history in terms of renames
>> and copies when possible, in order to help users. Sometimes this fails -
>> while still being correct, it confuses them ;)
> 
> Sure, that's one way to look at it, but I disagree. You give the user
> the way to tell the system the intention of which file moves where,
> but internally this information is lost and "guessed" incorrectly.
> 
> hg seems to do this correctly, the same commands with 'hg diff --git'
> at the end show:
> 
> diff --git a/Makefile b/Makefile
> new file mode 100644
> diff --git a/a b/b
> rename from a
> rename to b
> 
>  Thomas
> 

Maybe you can re-read what I wrote above, keeping in mind the first line:

git tracks content, not paths.

That explains everything, really.

Michael
