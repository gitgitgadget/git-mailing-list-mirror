From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 18:38:47 +0530
Message-ID: <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
 <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com> <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 14:09:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjqUG-00057A-6U
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 14:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586Ab3KVNJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 08:09:28 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:60373 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab3KVNJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 08:09:28 -0500
Received: by mail-ie0-f170.google.com with SMTP id qd12so2041848ieb.29
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nuG80qIvhy6lMJbOWm1QR0zGiUtT7u1n9/sIqyr9Mj0=;
        b=DkU+3E8f+p24OnAkt3g16QaL6bXfx0T2kk+Fw8nNGJaP9wUo1b7pmZbDrjSrX6XukF
         sidsQJad1kZUXql6Sn0utcCtyXZ3RGjaSx7MuJmNg0hmUWCt2POJjFU5oUev1lH8zj5O
         6aEWIQcNBzC/Ps1yL3xihgpPOrcehNWwmOl58IdiqZDHr8c/m832+jcw2kwbxKeEGt8F
         KKd+Td6MSKObQZnbvg5x6R/lUsWrbsFvoWKhwj7LYQ/JsCRaQhXBbWLmgtRnS+eMeYMQ
         xBrxR3bM58epBdJJgE2eolMma6SoOhD8Wg+r/3Ej9SVSwuuRAgdRd/3QLkWXWKAETZNg
         726Q==
X-Received: by 10.50.61.205 with SMTP id s13mr2324575igr.29.1385125767681;
 Fri, 22 Nov 2013 05:09:27 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Fri, 22 Nov 2013 05:08:47 -0800 (PST)
In-Reply-To: <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238184>

Sergey Sharybin wrote:
> On Fri, Nov 22, 2013 at 5:16 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>>
>> [+CC: Jens, the goto-guy for submodules]
>>
>> Sergey Sharybin wrote:
>> > Namely, `git ls-files -m` will show addons as modified, regardless
>> > ignore=all configuration. In the same time `git diff-index --name-only
>> > HEAD --` will show no changes at all.
>>
>> This happens because diff-index handles submodules explicitly (see
>> diff-lib.c), while ls-files doesn't (see builtin/ls-files.c). My
>> opinion is that this is a bug, and git ls-files needs to be taught to
>> handle submodules properly.
>
> Shall i fire report somewhere or it's being handled by the folks
> reading this ML?

Bugs are reported and tackled on the list.

>> > This leads to issues with Arcanist (which is a Phabricator's tool) who
>> > considers addons as uncommited changes and either complains on this or
>> > just adds this to commits.
>>
>> Does Arcanist use `git ls-files -m` to check?
>
> Yes, Arcanist uses `git ls-files -m` to check whether there're local
> modifications. We might also contact phab developers asking to change
> it to `git diff --name-only HEAD --`.  Is there a preferable way to
> get list of modified files and are this command intended to output the
> same results?

I just checked it out: it uses `git ls-files -m` to get the list of
unstaged changes; `git diff --name-only HEAD --` will list staged
changes as well.
