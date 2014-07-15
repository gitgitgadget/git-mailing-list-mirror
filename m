From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Tue, 15 Jul 2014 09:15:53 +0700
Message-ID: <CACsJy8BvQYyXWB7YfoonfEeqi9gStEZHqKC_JNAhxZbLJas54w@mail.gmail.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
 <1405140276-32162-4-git-send-email-dturner@twitter.com> <CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
 <xmqqr41oylyo.fsf@gitster.dls.corp.google.com> <53C41456.2000006@ramsay1.demon.co.uk>
 <xmqqvbqzygkm.fsf@gitster.dls.corp.google.com> <53C42453.1090109@ramsay1.demon.co.uk>
 <xmqq8unvy4bf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 04:16:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6sI9-00072x-2M
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 04:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862AbaGOCQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 22:16:26 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33322 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbaGOCQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 22:16:24 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so1456288qgf.20
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 19:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yUNLprivP/aLB1TZGed4MpOXPFGrHl9rl+UCDv1DprE=;
        b=GG12xiTAUztqiuE2XgdXWD+EPHLejPMF4T509tcDS5vVZs4oEJZE6n43XXHei2+nEi
         vn9Hewqw1YsoxQxhpUpcNwuq5RQlCycBZzDSS4poNlmIXX7LQzkKhlvBQmn/DKwyf1Mz
         ST+arJ9PhfWOy2jEwbt0k+gFNTTOtHF7r+TygteiYDTOGlH/N4RcD2RZDaKtFX+hNKW0
         n9h7ZJr+zW3wSNDxfjgnk73oRiSM3sRTqozlh5hYApTJWjWxeOseZnjyFUkmrL12aDr/
         pTDXmTcLpgTkGLiUdUM1dAIyTsxZHnBtk+yCWpxlHkr0a+8xKXIdTqxKcyEU4CwlTNLo
         cCUw==
X-Received: by 10.224.5.193 with SMTP id 1mr27596196qaw.89.1405390583945; Mon,
 14 Jul 2014 19:16:23 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 14 Jul 2014 19:15:53 -0700 (PDT)
In-Reply-To: <xmqq8unvy4bf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253547>

On Tue, Jul 15, 2014 at 5:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> On 14/07/14 18:51, Junio C Hamano wrote:
>>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>>
>>>> that the merge commit 7608c87e fails. Looking at the details of the
>>>> merge resolution, made me think of Duy's split index work.
>>>
>>> Yes, there is a deliberately dropped hunk from dt/cache-tree-repair
>>> in that merge, because the topic relied on being able to say "here
>>> is the file descriptor, write the index to it", which no longer is
>>> available with the split-index topic.
>>
>> Ah, OK. Sounds like everything is under control then.
>
> Wasn't, but now I think it is ;-)
>
> David, could you please double check the conflict resolution at
> 882426ea (Merge branch 'dt/cache-tree-repair' into jch, 2014-07-14),
> at about the middle between master..pu?  By eyeballing
>
>     git diff 882426ea^ 882426ea
>
> we should see what your series would have done if it were based on
> top of the nd/split-index topic.  The most iffy is the first hunk of
> change to builtin/commit.c, which is more or less my rewrite of what
> you did on top of 'master'.

It makes me wonder if a cleaner way of rebuilding cache-treei in this
case is from git-add--interactive.perl, or by simply spawn "git
update-index --rebuild-cache-tree" after running
git-add--interactive.perl.
-- 
Duy
