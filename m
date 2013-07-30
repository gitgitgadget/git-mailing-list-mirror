From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Flatten history
Date: Mon, 29 Jul 2013 21:08:19 -0700
Message-ID: <CAE1pOi0qQvPrG8te0kKVpPDx4LqSEuBHVw+-NRaxH1HT9CvqxA@mail.gmail.com>
References: <CAE1pOi0CQ1k3h3ie=s3qvkQog9foYBOnJ++uuum-Br7vzQHRSQ@mail.gmail.com>
 <CAMP44s2pXSN2HbpGLW9jrgJAypbLM3JtgD+nyK7LkNdvH4nsfQ@mail.gmail.com> <CAGyf7-FXp-a+HmoRQBrUWu2xc-UvbsZUfZz7GTce2JzwrsfMVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 06:08:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V41Er-00069c-6X
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 06:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab3G3EIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 00:08:41 -0400
Received: from mail-vb0-f54.google.com ([209.85.212.54]:54007 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab3G3EIk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 00:08:40 -0400
Received: by mail-vb0-f54.google.com with SMTP id q14so1340339vbe.27
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 21:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r8415klLUGM790cPgOGEtsm/+YkLBUY0WdIUbAOVW+U=;
        b=rBV0HjrWEvVqGyXTLCps1eTDHH9WMWmGxKWiFLfrCp5fFOtFUBqTcOqstdRauYnt7z
         7CYTzlw5P0sqv4UBOhg3kOuDizZVIkENcFPtSsA1XaDRJRT9OcA1pkEmNtIN+BHrNx+Z
         DuF97ybLHRYRoW0/Fmi5u0xB7ciyJcMuOJt75o+2j/9Ax+12kavusySO3KNuBxNw1qWs
         Jd07pn5MmyNQ8NK6YLEBTVIzRtbNe2s7Zy+3Kn26oPqCjxqobrn7u1FFNX1lUBbXiooW
         9QggXdB8BJHSUUSbS6LueitDPlCaoq0w9XK1V/xgnS32LwNh8rZJgv50Abaglr0+yNIe
         fjdA==
X-Received: by 10.58.249.236 with SMTP id yx12mr26631730vec.25.1375157319828;
 Mon, 29 Jul 2013 21:08:39 -0700 (PDT)
Received: by 10.58.229.106 with HTTP; Mon, 29 Jul 2013 21:08:19 -0700 (PDT)
In-Reply-To: <CAGyf7-FXp-a+HmoRQBrUWu2xc-UvbsZUfZz7GTce2JzwrsfMVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231349>

On 29 July 2013 20:59, Bryan Turner <bturner@atlassian.com> wrote:
> On 30 July 2013 13:50, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> On Mon, Jul 29, 2013 at 8:42 PM, Hilco Wijbenga
>> <hilco.wijbenga@gmail.com> wrote:
>>> Hi all,
>>>
>>> I have a (public) "feature" branch that has been kept up-to-date with
>>> "master" by regularly merging master back into it. I would now like to
>>> get all the changes from feature but not any of the commits.
>>> Basically, I want to replay all of feature's commits without creating
>>> those commits.
>>>
>>> I thought something like
>>>
>>> git cherry-pick -n abcd^..feature
>>>
>>> should do the trick (while on master, where abcd is the SHA-1 of the
>>> commit where feature was created) but I get conflicts.
>>>
>>> First, why the conflicts? I have done all the merges so cherry-pick
>>> should simply be able to replay them? Second, what is the correct way
>>> of doing this?
>>
>> Perhaps
>>
>> % git cherry-pick -n --no-merges --right-only --topo-order
>> --cherry-pick abcd^..feature
>>
>> --
>> Felipe Contreras
>
> Wouldn't git merge --squash do what you're looking for? It seems like
> the only way to not get conflicts trying to cherry pick is if you
> never had any conflicts while you were merging master into your
> feature branch. "Evil" merges, where you actually have to change code,
> even if it's just to resolve conflicts, don't tend to replay
> correctly.
>
> It seems like this should do it:
> % git checkout master
> Switched to branch 'master'
> % git merge --squash feature
> Squash commit -- not updating HEAD
> Automatic merge went well; stopped before committing as requested
> % git commit
>
> git merge --squash will just apply the changes without creating a
> commit. You can then make any final changes you want to and write your
> commit message for the feature.

Ah, yes "git merge --squash feature" seems to do exactly what I was
looking for. Funny, I thought I did something with rev-list last time
but this --squash is much simpler. :-) Thank you!
