From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 04:33:07 -0500
Message-ID: <CAMP44s2vsD2uwFoL5_79m05gtqyKLN9wHX8Yrhtn0kT4LVULxQ@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com>
	<CAMP44s3fPsGW_9aBbcsu8cJAagz8JEWV2HM=XRH3Rw4=SXdL7Q@mail.gmail.com>
	<CALkWK0nOywB5BtHnKZQ_+wsJNp82zk7-YJw_S15quqH+iU=jWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:33:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuYl-0001BM-JP
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177Ab3EPJdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:33:11 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:34856 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab3EPJdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:33:09 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so2112371lab.8
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=lkLM02/hPKAaYJU/1UkeYmrJYbiqUe0+rpDyICGlN8E=;
        b=f5IQlcCeuqfBR9zHn/rkT1zl4k3MiYgDT1xnFM0BElpFlVKFsgMUbyWMnV/EblLY7z
         qOP3UWK7MdClv6DIfyeZSNtwjWURcxLMIXXwltgYr71ZgrGO6OuGNOrWtb69wy38mzsp
         5HfhIv1iuq0ll9XfG8o6Y3iWNEKNZmrgKNGMUJB2rYLctVXu4xzPq33VJpt14+JchOXv
         QEneIHR/LpQjn5tjHXaqlqhzSwoRKeU9CqVWw1FSE5QxxvkDUrxyXIaU+2BwLkir+QKe
         +yH+3rGvAh0Lt1BMT1OFsg1IJxlHe4dtlWI/vM7xpXDh9eymfSBLcgEvBkgnHXUgCUme
         6SOA==
X-Received: by 10.152.3.167 with SMTP id d7mr7479114lad.38.1368696787503; Thu,
 16 May 2013 02:33:07 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 02:33:07 -0700 (PDT)
In-Reply-To: <CALkWK0nOywB5BtHnKZQ_+wsJNp82zk7-YJw_S15quqH+iU=jWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224523>

On Thu, May 16, 2013 at 4:20 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> And is going to change soon.
>
> Your point being?  How will this patch interact with push.default = matching?
>
>>> branch.<name>.push should probably be named
>>> branch.<name>.downstreamref and be used only for informational
>>> purposes (@{d} and git status)?
>>
>> That makes absolutely no sense.
>
> I said downstreamref, not downstreamrefspec.

That's not consistent with branch.A.merge, which is not named
branch.A.upstreamref.

>> [branch "master"]
>>           remote = origin
>>           merge = refs/heads/master
>>           pushremote = github
>>           push = refs/heads/fc/master
>>
>> [branch "fc/old-remote/hg"]
>>           remote = .
>>           merge = refs/heads/master
>>           pushremote = github
>>           push = refs/heads/fc/remote/hg
>>
>> Tell me how you express that without 'remote.branch.push'.
>
> [remote "origin"]
>     push = refs/heads/master:refs/heads/fc/master
>
> [remote "."]
>     push = refs/heads/fc/old-remote/hg:refs/heads/fc/remote/hg

Let's see:

% git checkout master
% git push

It will try to push to 'origin/fc/master' not 'github/fc/master',
which is what I intended.

% git checkout fc/old-remote/hg
% git push

It will try to push to 'fc/remote/hg' not 'github/fc/remote/hg', which
is what I intended.

> Advantage being you can do:
>
> [remote "origin"]
>     push = refs/heads/*:refs/for/*
>
> While you can't with branch.<name>.push.

But I can do 'git push origin "refs/head/*:refs/heads/for/*"', not
that I've ever had the need to do something like that, so I don't
care.

-- 
Felipe Contreras
