From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: Case rename not detected
Date: Tue, 5 May 2015 09:27:22 +0300
Message-ID: <CAGHpTBLMDaKUFVwbeqhKitYLL6Ufp7EkPRc5mjq7yN2gE=RmUg@mail.gmail.com>
References: <CAGHpTBJuRCrg5jL7Anm9kxGJEf5cUmPzDToZG0UXeT_xNMWfsg@mail.gmail.com>
	<xmqqzj5jeeek.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 08:27:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpWKG-00035B-Cs
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 08:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbbEEG1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 02:27:24 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:36611 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbbEEG1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 02:27:23 -0400
Received: by lagv1 with SMTP id v1so119662583lag.3
        for <git@vger.kernel.org>; Mon, 04 May 2015 23:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1FO8DQxQn1ofM6mm4jrUPTrEfgFKK5TuG7BrULmuUp0=;
        b=u1ijlezyA4bAHwtuNqma+FXswnQuuxw6I/IwxQQ8PMWzZhMnlqD5YC2WVcaBuJn6RY
         DGj9umzzl8unVDiYDvPyDj/jBuZKn3dy6J0/1qMa6reTUbDpMd0SRE1gMTInPFvOHICZ
         zAj7YpuAP8p3Z58ciR62zGCWbmVSXoQBj4HFb6EDfTjEcZ/EQxZw4QmUvq9tFIoHdjJ/
         eeNxjNOyB7oS5x/dpAcwGZgM2sfq4n3Wwa3PUpYDJFPpg7u3YPcNHCK3jT2QPyPm1N8u
         +OBI4vvAcwPMYG8gNPHT+QIEGo4U/T7qGJo4UiMPYoLY3Cgx1jDAWy5vuw7qLMcrU0iP
         xA8A==
X-Received: by 10.112.170.70 with SMTP id ak6mr22648338lbc.42.1430807242156;
 Mon, 04 May 2015 23:27:22 -0700 (PDT)
Received: by 10.25.78.77 with HTTP; Mon, 4 May 2015 23:27:22 -0700 (PDT)
In-Reply-To: <xmqqzj5jeeek.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268388>

Thanks for the fast response!

On Tue, May 5, 2015 at 9:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Orgad Shaneh <orgads@gmail.com> writes:
>
>> File case rename is not detected correctly on case-insensitive
>> filesystems. git mv does support it though.
>
> It is a very much deliberate design decision to keep the case
> recorded in the index on case insensitive filesystems, where people
> can screw up the case of files they obtained from the project
> without even meaning to do so, as these filesystems and tools on
> them can carelessly change cases---after all, the case doesn't
> matter to these tools, but the people who interact with your work
> result via Git do---so we trust what Git initially gave you
> (e.g. via "checkout") more than the filesystem.

Can you name tools that change file case without notifying the user?
I'm not aware of any.

>
> To effect the same as "git mv" at the end-user level, you would need
> to remove the entry from the index and re-add it.  I.e.
>
>> git init
>> echo hello > foo
>> git add foo
>> git commit -m initial
>> mv foo Foo
>> git status # No changes
>
> git rm --cached foo ;# Foo should also work here, I think
> git add Foo ;# you should not say 'foo' here

This is very involved, and the user must be aware of the rename while
committing. I usually trust git to find differences on its own,
without needing my help.

We ran into this problem with a real project, which is mostly
developed on Windows machines, but built on linux, where case matters.

One file was committed as Foo.cpp on the filesystem but as foo.cpp in
the Makefile. Then in a subsequent commit it was supposed to be
renamed foo.cpp, but it wasn't due to this bug.

- Orgad
