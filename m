From: Aleksey Komarov <leeeeha@gmail.com>
Subject: Re: submodule: allow submodule directory in gitignore
Date: Mon, 19 Oct 2015 09:24:26 +0700
Message-ID: <5624545A.5090102@gmail.com>
References: <561B5372.7040508@gmail.com>
 <CANYiYbHNX+j6BPahWdGQ2qVbvBV-wd-Bi=ZjDmRfbXCsboNXpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 04:28:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo0Bo-0005mR-GS
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 04:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbbJSCYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 22:24:38 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36452 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbbJSCYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 22:24:36 -0400
Received: by lffz202 with SMTP id z202so17450668lff.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 19:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=UxJ2INu5vUCQUhUlwZm0BqVb0Aspj/hgT9WmmAXbv+Y=;
        b=cS8nYyWReloQw0aaEe37YKmgudlsCpuW5C+6W7fK/uz47hqQeQ5aFm33+CF+5LpbHT
         7zby38VqrPp8fuW6GHOXI7dkwUx0EmG9n5DXPdrVrFBQ9QvXp9pXNxPVuXZ9uxgvCuhH
         267jv+vE7SGDx30+FsyKK1Wjc2WDckbHLPVeRvtX/k2FW5J1d3PK13bCdTM/AqgbH881
         eZyJPUxzt2Vpf8fgH4KeyX8ozXuLXvb92rXdcrKpgOreqrsdrCSnVvZYv2aAHQZvLoxF
         eg8CG5jndYZKWRux76vlwwNAzbzcLkZnQI/BSwDcAune056Yig17tfZoE/l38nbzapnl
         8L1A==
X-Received: by 10.25.206.199 with SMTP id e190mr8568389lfg.39.1445221474941;
        Sun, 18 Oct 2015 19:24:34 -0700 (PDT)
Received: from [127.0.0.1] ([62.213.32.124])
        by smtp.gmail.com with ESMTPSA id r66sm4945118lfd.49.2015.10.18.19.24.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2015 19:24:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CANYiYbHNX+j6BPahWdGQ2qVbvBV-wd-Bi=ZjDmRfbXCsboNXpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279824>



On 17.10.2015 19:46, Jiang Xin wrote:
> 2015-10-12 14:30 GMT+08:00 Aleksey Komarov <leeeeha@gmail.com>:
>> Hi all!
>>
>> I'm sorry if the letter came twice. I have troubles with my post client.
>>
>> I want to organize my repository so its submodules would be located at the root
>> of repository. I'm trying to create .gitignore to ignore all files and don't
>> ignore directories at the same time:
>>
>> $ cat .gitignore
>> *
>> !*/
>>
>> Now, I'm trying to add a submodule to my repository, but fail to understand why
>> my .gitignore prevents it from being added. I use the following command to check
>> if my submodule will be ignored or not:
>>
>> $ git add --dry-run --ignore-missing c/
>>
>> I have noticed that result of this check is different when directory c/ already
>> exists and when it still doesn't by the time of the check.
>> The described behavior is illustrated by the following example:
>>
>> $ mkdir git_test
>> $ cd git_test
>> $ git init
>> Initialized empty Git repository in D:/temp/git_test/.git/
>> $ echo \* >> .gitignore
>> $ echo \!\*\/ >> .gitignore
>> $ git add --dry-run --ignore-missing c/
>> The following paths are ignored by one of your .gitignore files:
>> c/
>> Use -f if you really want to add them.
>> $ mkdir c
>> $ git add --dry-run --ignore-missing c/
>> $
>>
> 
> To check how an entry (c/) is affected by .gitignore in different cases,
> you can try this command:
> 
>     $ git check-ignore -v c/

I try it, but result is the same.

$ rmdir c
$ git check-ignore -v c/
.gitignore:1:* c/
$ mkdir c
$ git check-ignore -v c/
.gitignore:2:!*/ c/

Behavior depends on whether c/ directory exists beforehand.
