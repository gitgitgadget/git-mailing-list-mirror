From: Anastas Dancha <anapsix@random.io>
Subject: Re: [PATCH] remote: allow adding remote w same name as alias
Date: Sat, 20 Dec 2014 15:57:45 -0500
Message-ID: <CAChhagCrGB1Jq=qZdQnW1EMzw=OPSHzQvXO=jVSnZ2DCEmvAaA@mail.gmail.com>
References: <20141216021900.50095.24877@random.io> <alpine.DEB.1.00.1412160944180.13845@s15462909.onlinehome-server.info>
 <CAChhagAFTxmFVvCUiKp3a369awPJtZEuVsfFMcdiqeB9ZwYnKg@mail.gmail.com>
 <alpine.DEB.1.00.1412191034560.13845@s15462909.onlinehome-server.info>
 <CAChhagA7eZ_7=g-xhAusZ1NX085KLjPDRbgJwx00F4pgOURXnQ@mail.gmail.com> <54945297.3010409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 21:58:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2R6O-0003tO-NP
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 21:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbaLTU6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2014 15:58:08 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:41662 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbaLTU6G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2014 15:58:06 -0500
Received: by mail-oi0-f42.google.com with SMTP id v63so5784236oia.1
        for <git@vger.kernel.org>; Sat, 20 Dec 2014 12:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8UtKK8CD6ElpQa6I/N1zHGyt1Js2WiI+wF4vfa0pXjE=;
        b=mBFym48+SUM+KSspTHbeuO6zn9Pg4Lxsja3p3KidD1EflWH8vK20xeropWlaCwzszn
         nN7mAVsbCUOJzA262pxmrRpe5l+QptVWMl5M7f3tyni9EFIoDO/tCmd6OT40xSXm4JxP
         fHVeVrMlsCmrz0Rb820AuUnKTGIWQmCJFSgKIG4MASrUh6HiEaRo7K6RMdHymmmskaNz
         oiSz3dspEEtgdqhY4c8tkgBwVsNB+Ncdzf3R3vPurlDB1ymjIWZtUCxRS4uNQOYhH0ga
         I60vwTxpF71IR2c4YP6n2ScGxJnzEtN0OAeKPK7YFEARp6GtJqmupN59ZsZ8+G6MTqNf
         O/jw==
X-Received: by 10.60.134.237 with SMTP id pn13mr8803402oeb.82.1419109085495;
 Sat, 20 Dec 2014 12:58:05 -0800 (PST)
Received: by 10.76.183.104 with HTTP; Sat, 20 Dec 2014 12:57:45 -0800 (PST)
In-Reply-To: <54945297.3010409@drmicha.warpmail.net>
X-Google-Sender-Auth: OlDHdz9t4W9DMextyfewVB-ma5o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261605>

On Fri, Dec 19, 2014 at 11:30 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Anastas Dancha schrieb am 19.12.2014 um 16:44:
>> Hello Johannes,
>>
>> On Fri, Dec 19, 2014 at 4:37 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> [...]
>>> There is one bit left to clarify: let me guess, you have a $HOME/.gitconfig
>>> like this:
>>>
>>>         [url "anastas@company.com"]
>>>                 insteadOf = backup
>>>                 pushInsteadOf = backup
>>>
>>> and then you want to add the "backup" remote in a Git working directory
>>> like this:
>>>
>>>         git remote add backup me@my-laptop.local
>>>
>>> but my suggested fix will still disallow this because the URL does not
>>> match the url.anastas@company.com.insteadOf?
>>>
>>> Ciao,
>>> Johannes
>>
>> Precisely that. In fact, it will not work even if you do any of these:
>>
>>     git remote add backup anastas@company.com
>>     git remote add backup anything@anyhost.com
>>     git remote add backup backup
>>
>> The original / current code and your suggested fix - both exhibit
>> similar behaviour with the use cases I've described above.
>>
>> Thanks,
>> Anastas
>>
>
> OK, I'll repeat it again: We cannot allow that.
>
> "git push" can take a url or a remote as a parameter. Which one is it if
> you have a remote and a url (alias) with the same name?
>
> Michael

I suppose it could be either. A string can be checked if there is a
remote with such name first, and if not, it could be attempted to be
used as a url.
In fact, my current workaround involves the following:

    git remote add tempname backup:product/repo.git
    git remote rename tempname backup
    git push backup

This seems to work just fine right now with no code changes.
Michael, could you explain in more detail what will break in **git
push backup** if code changes are made to eliminate the necessity of
the add/remote workaround.

Regards,
Anastas
