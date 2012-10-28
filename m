From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't understand the behaviour of git-diff --submodule
Date: Sun, 28 Oct 2012 09:26:27 +0100
Message-ID: <CAC9WiBim80NgUnjeRMRw9vKQD62TFJ_pxWjO6hzHW4nxcPZ67g@mail.gmail.com>
References: <CAC9WiBgzbsury2f9FyAu=Pgn31f2uCtq7AvsVWGWEwoV6KbyjA@mail.gmail.com>
	<508ADFAE.1050800@web.de>
	<CAC9WiBjiHLJggUzmmx4sPpXNNq=Kz0TOZAzmRShc1AZcPjGvig@mail.gmail.com>
	<508AED26.3090805@web.de>
	<CAC9WiBhZWJihPToMawPCxEVkTKL0e-GzUw3qneJMUx-WqSNbjw@mail.gmail.com>
	<508C6823.5060800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 09:33:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSOJZ-0000y8-LR
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 09:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab2J1I0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 04:26:30 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62754 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab2J1I01 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 04:26:27 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3830348oag.19
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 01:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Eb1wOUIVyFS6WWRqPLNNjoaUEw06AR2bHd7stQMR32A=;
        b=QC6yI8esiW7tqUPdCQQoMxQb7boVTRZLTUDxsjefjQGDEvhZTgbTSbv6y8IA99V0NQ
         1Ht0dVSBUzRW9rcUQ8vx5bx74zqM5YnwFUJ/vgjLMlaMQst82SJm96Pa8Mz96/BxhQdR
         rOksFpaOzaNiSykSYunK/MCAp8rcDf2XdfZ7jTao2dtP8OGxZNdygAX/AtZ7lEMhuwWK
         7G93RccR1EzsIAmxZEDUz28+aYHgOUmZ2WWLXH4rAL2UHhcptS8VU8VkZDxm2Y73JSV/
         O/KB5oHEMDgM1O1vgYY9uY+qa8lLTaV5ZETDF0NNr1XJtzGjv+DQ75f7bU/YMM+D9OX0
         1b4A==
Received: by 10.60.14.200 with SMTP id r8mr17464781oec.45.1351412787305; Sun,
 28 Oct 2012 01:26:27 -0700 (PDT)
Received: by 10.60.93.163 with HTTP; Sun, 28 Oct 2012 01:26:27 -0700 (PDT)
In-Reply-To: <508C6823.5060800@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208533>

On Sun, Oct 28, 2012 at 1:02 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 26.10.2012 22:43, schrieb Francis Moreau:
>> On Fri, Oct 26, 2012 at 10:05 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> [...]
>>>
>>> That is weird, "git diff --submodule" should show that too. Is there
>>> anything unusual about your setup? (The only explanation I can come
>>> up with after checking the code is that your submodule has neither a
>>> .git directory nor a gitfile or the objects directory in there doesn't
>>> contain these commits)
>>
>> Oh now you're asking, I think the submodule has been added by using
>> the --reference option of git-submodule-add.
>>
>>   $ cd configs
>>   $ cat .git
>>   gitdir: ../.git/modules/configs
>
> Thanks, I suspect the --reference option makes the difference here,
> I'll check that as soon as I find some time.

Yes that's fairly easy to reproduce:

$ mkdir super
$ cd super
$ git init
$ git submodule add --reference ~/tmp/git-submodule/public/a.git
~/tmp/git-submodule/public/a.git a
$ git commit -m "Initial creation of super project"
$ cd a
$ date >a.txt
$ git commit -a -m "add to a.txt a random change"
$ cd ..
$ git submodule summary
* a 2f8803a...a1aa4bf (1):
  > add to a.txt a random change
$ git commit -a -m "Include a's changes in super project"
$ git diff --submodule=log HEAD~1 HEAD
Submodule a 2f8803a...a1aa4bf (commits not present)

Thanks
-- 
Francis
