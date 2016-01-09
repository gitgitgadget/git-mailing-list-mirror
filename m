From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: for-each-ref output order change in 2.7.0
Date: Sat, 9 Jan 2016 22:51:03 +0530
Message-ID: <CAOLa=ZT7n8qCoS81iijf9vswWV+S8n7=4kmbKP0EAMnOenXwSg@mail.gmail.com>
References: <CAGyf7-FSP3Z7HO=LpoQck8q9sSj3fGYCx1=gNa6fXEkovxAxHw@mail.gmail.com>
 <1674931730.811704.1452354002885.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jan 09 18:21:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHxD1-0003k6-Jw
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 18:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbcAIRVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 12:21:37 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34052 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbcAIRVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 12:21:33 -0500
Received: by mail-vk0-f42.google.com with SMTP id a123so175760440vkh.1
        for <git@vger.kernel.org>; Sat, 09 Jan 2016 09:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PrG++CWJyjHOMgE6eHIuCFlU4PKe8rjxkvQTKuTaDA8=;
        b=VjBF+bvQAp6B+I+FnhY1YsOU8vOQSKp7eRBenOjJWd6A0IaIvTP8ZAecha2Oh7zfZR
         xk9rnO0tWcU7FSZjbjD8Rdd+gN+Q7wjBHx5w5OGIkSoJiyWNUyfZ5PfNoOlB70K2Poee
         5OeafcxgMEb8L0z2IZM1sh63YgB6r0PZ1O5MUMUZTtiZwdB55L+Dx0/vgNPG5jX0/e9N
         yZ7a4OKG5JiFt7mmEJSabZ11iwAbzIdeprjsPp43Kr65Zz9S+JOVfEeK0FzE+i/1Bq/l
         BriEfE96B1+IhuD/Ub1eaX4de2Vc/YhVRvr8dFD0fGLNpKeGaKz16vRHKiH45sozQbbh
         K+1w==
X-Received: by 10.31.159.136 with SMTP id i130mr51989128vke.144.1452360092764;
 Sat, 09 Jan 2016 09:21:32 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Sat, 9 Jan 2016 09:21:03 -0800 (PST)
In-Reply-To: <1674931730.811704.1452354002885.JavaMail.zimbra@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283604>

Hello,

On Sat, Jan 9, 2016 at 9:10 PM, Matthieu Moy
<matthieu.moy@grenoble-inp.fr> wrote:
> Hi,
>
> Cc-ing Karthik to draw his attention on the message.
>

Thanks, I didn't really notice it.

> ----- Original Message -----
>> In one of our tests, we have a set of branches whose names are all
>> special characters (%, @, etc). Most of them branches have identical
>> tip commits and just have different names. In 2.7.0, when ordering by
>> -committerdate, the branches are now returned in a different order. I
>> don't think this is a bug, based on the commit it bisects to, but I'm
>> wondering if someone can confirm.
>>
>> 2.6.5 and prior (tested all the way back to 1.7.6, so this was
>> consistent for a long time):
>>
>> refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
>> refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
>> refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
>> refs/heads/@#$% -> Tue Jan 3 17:00:51 2012 +1100
>> refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
>>
>> 2.7.0:
>>
>> refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
>> refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
>> refs/heads/@#$% -> Tue Jan 3 17:00:51 2012 +1100
>> refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
>> refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
>>
>> I've bisected this back to:
>>
>> bturner@ubuntu:~/Development/oss/git/git$ git bisect bad
>> 9e468334b41c1d1fc715de177ef1f61a36c1cf01 is the first bad commit
>> commit 9e468334b41c1d1fc715de177ef1f61a36c1cf01
>> Author: Karthik Nayak <karthik.188@gmail.com>
>> Date:   Fri Oct 30 14:15:28 2015 +0530
>>
>>     ref-filter: fallback on alphabetical comparison
>>
>> The message for that commit indicates that sorting numerics (which I
>> assume is the implementation for committerdate) now falls back on
>> alphabetical for identical values, suggesting this order change is
>> actually intentional and correct.
>
> And also that the previous order was arbitrary (just letting the sort
> algorithm chose which one to put first in case of equality on the main
> sorting criterion), so the fact that it was stable previously is more
> or less just luck. Now it should be stable.
>
>> Is that right?
>>

Yup, absolutely.

>> (Note: The alphabetical-ness of the branch names is reversed, which
>> seems logical given my original sort was -committerdate. A
>> --sort=refname looks like this.
>>
>> refs/heads/!@#$% -> Tue Jan 3 17:00:51 2012 +1100
>> refs/heads/!@#% -> Tue Jan 3 17:04:06 2012 +1100
>> refs/heads/% -> Tue Jan 3 17:00:51 2012 +1100
>> refs/heads/@#$% - >Tue Jan 3 17:00:51 2012 +1100
>> refs/heads/@#% -> Tue Jan 3 17:00:51 2012 +1100
>>
>> That's probably more correct too.)
>>
>> Best regards,
>> Bryan Turner

This is correct as per the patch, But I'm wondering if this is desired.
I.E when sorting in reverse order should the fallback (alphabetical sort)
also be in reverse order?

-- 
Regards,
Karthik Nayak
