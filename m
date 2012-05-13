From: Dmitry Risenberg <dmitry.risenberg@gmail.com>
Subject: Re: cherry-pick is slow
Date: Sun, 13 May 2012 19:39:49 +0400
Message-ID: <CAPZ_ugbV6hB+8z8UsQKdHhxGuHbLzC5WK19mK7M8k2tMz+mtXw@mail.gmail.com>
References: <CAPZ_ugYojqTaWi0atr2ApOu9xmcwy4y8FduNC+TDhgWgSxXNPQ@mail.gmail.com>
	<CAPc5daW6eBLUf55_Qk+4bA6Y16TehfOUGc1xFzhib9vm=8O2Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster-vger@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 13 17:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STatn-0004KI-SO
	for gcvg-git-2@plane.gmane.org; Sun, 13 May 2012 17:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507Ab2EMPjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 11:39:51 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43589 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab2EMPju (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2012 11:39:50 -0400
Received: by obbtb18 with SMTP id tb18so6121428obb.19
        for <git@vger.kernel.org>; Sun, 13 May 2012 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=69nlDq45u+jaNM6gD4n8fhFLShijmWaa7a+kSl8AEe0=;
        b=jZNkrI4/6cl+Rqop1lzDNjTGPVBnJKsDE3BHNzS8XZwQszhX9NIVJXPgFAZwocdX97
         Vgg/0+EWhLcMC5b+kj1B7iUR+rO8lvkTBg5YJskKaDM0toqAJQlYQ7M1Evj7oYfhIxFs
         Tg1Xr0CA2mOTn5MuIHjyZNpLywOoxpbVJuji5oiBIi44Rt5xNeUFa1CX9984VWsSwwPO
         CjsN4Yat1PsUKV78mslAz/kv304V7n9w+jYvfnLRtqcbZiGKRy1CxruzDwWmAiuYIA9V
         jp3rKNwHEOajEqqlNM/XgLeyw9ECDQhaSjdZpt0rinESnz9iGy8ZqHgGM0N0KvIBb4mh
         ZLZg==
Received: by 10.60.10.231 with SMTP id l7mr7466552oeb.4.1336923590049; Sun, 13
 May 2012 08:39:50 -0700 (PDT)
Received: by 10.60.79.193 with HTTP; Sun, 13 May 2012 08:39:49 -0700 (PDT)
In-Reply-To: <CAPc5daW6eBLUf55_Qk+4bA6Y16TehfOUGc1xFzhib9vm=8O2Yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197748>

2012/5/13 Junio C Hamano <gitster-vger@pobox.com>:
> On Sat, May 12, 2012 at 3:39 PM, Dmitry Risenberg
> <dmitry.risenberg@gmail.com> wrote:
>>
>> Hello.
>>
>> I have a very big git repository (the .git directory is about 5.3 Gb),
>> which is a copy of an svn repository fetched via git-svn. In fact
>> there are a few repositories ("working copies") that share the same
>> .git directory (via symlinks), in which I have different svn branches
>> checked out. Now I want to merge a commit from one svn branch to
>> another via git cherry-pick. The commit contains diff in only one
>> file. So I do
>>
>> git cherry-pick <commit>
>>
>> And the operation takes tens of seconds to finish. In "top" output I
>> see that git process uses almost no CPU, but has hundreds of page
>> faults, so I assume that it is reading a lot of files from disk.
>
> Wild guess: poorly (or worse yet, never) packed repository?

You were absolutely right.
I set "gc.auto = 0" during the initial checkout of svn and forgot to
turn it on afterwards. After running "git gc", my repo became two
times smaller, and git operations are now running much faster.

However, cherry-picking is still not as fast as I expected it to be -
cherry-picking a single-file commit takes about 14-15 seconds, fully
using one CPU core. Anything else I can improve?

-- 
Dmitry Risenberg
