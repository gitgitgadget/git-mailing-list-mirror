From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] branch: add support for --dry-run option
Date: Thu, 22 Jan 2015 11:17:08 +0100
Message-ID: <54C0CE24.9040908@drmicha.warpmail.net>
References: <1421480159-4848-1-git-send-email-kuleshovmail@gmail.com> <54BD12C3.5050802@drmicha.warpmail.net> <20150122013723.GA3795@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Scott Schmit <i.grok@comcast.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 11:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEEpB-0000AI-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 11:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbbAVKRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 05:17:13 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:32964 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793AbbAVKRK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 05:17:10 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id CB51520856
	for <git@vger.kernel.org>; Thu, 22 Jan 2015 05:17:09 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 22 Jan 2015 05:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Wh9w+Hu1toroXNlt7pgS6X
	t6F7g=; b=awUzk5ovkxOVt7BZDerM7/8qoi/CzCn0MOeZPVhJhM8z0GQ902D0OG
	OhH36dY/L4wKzTOPF/PpTfGoToWt4NIBpFfHtwAEmVtd0dO0LyCAILYyCjoAY4Vo
	15M2GcQH8pCC5e1lnyhpCk+1dOZkTYn738NxNl/szjdOH0Yf5f0MI=
X-Sasl-enc: 4NKz1hPGyY4UNLWthXkwsNZ6jH39zkYM2RSAAeAmpwq9 1421921829
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DD391680192;
	Thu, 22 Jan 2015 05:17:08 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150122013723.GA3795@odin.ulthar.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262814>

Scott Schmit schrieb am 22.01.2015 um 02:37:
> On Mon, Jan 19, 2015 at 03:20:51PM +0100, Michael J Gruber wrote:
>> Alexander Kuleshov schrieb am 17.01.2015 um 08:35:
>>> This patch adds support -d/--dry-run option for branch(es) deletion.
>>> If -d/--dry-run option passed to git branch -d branch..., branch(es)
>>> will not be removed, instead just print list of branches that are
>>> to be removed.
>>>
>>> For example:
>>>
>>>     $ git branch
>>>     a
>>>     b
>>>     c
>>>     * master
>>>
>>>     $ git branch -d -n a b c
>>>     delete branch 'a' (261c0d1)
>>>     delete branch 'b' (261c0d1)
>>>     delete branch 'c' (261c0d1)
>>
>> Is there a case where deleting "a b c" would not delete "a b c"?
> 
> Sure:
> $ cd /tmp/
> $ git init foo
> Initialized empty Git repository in /tmp/foo/.git/
> $ cd foo/
> $ touch .gitignore
> $ git add .gitignore 
> $ git commit -m init
> [master (root-commit) fde5138] init
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 .gitignore
> $ git checkout -b a
> Switched to a new branch 'a'
> $ git branch -d a
> error: Cannot delete the branch 'a' which you are currently on.
> $ touch file
> $ git add file
> $ git commit -m 'add file'
> [a e2c2ece] add file
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 file
> $ git checkout -b b master
> Switched to a new branch 'b'
> $ git branch -d a
> error: The branch 'a' is not fully merged.
> If you are sure you want to delete it, run 'git branch -D a'.

Yes, and that is something that should go into the commit message. "Why
do you want to add --dry-run? Because -d deletes only fully merged
branches."

It should have been there in the 1st place, rather than forcing us to
ask the question that always needs to answered for a patch: What is the
intention? What is it good for?

In this case, we have other means to accomplish the same (--list -v),
and they are more natural if you want get information about the state of
the branches ("list verbose") than doing "delete dry-run".

Michael
