From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Making git history strictly time safe
Date: Thu, 17 May 2012 11:50:11 +1000
Message-ID: <CAH5451m33+4Y6sRzeji-Zvh2meN12ZxHKQMGRZ0Zwid8uGOyBw@mail.gmail.com>
References: <2EDEF5ABBE208442B7547C8D36B9D8840C4A03@nawespscez09v.nadsuswe.nads.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600" 
	<brian.p.jones4.ctr@navy.mil>
X-From: git-owner@vger.kernel.org Thu May 17 03:50:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUprS-0000v3-KO
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 03:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760815Ab2EQBue convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 21:50:34 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:54718 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760019Ab2EQBud convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 21:50:33 -0400
Received: by weyu7 with SMTP id u7so851437wey.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7DghVQuvTYIQ282iX4mAXtij0kDxBDv+VWdkmn+4aOE=;
        b=slmkOvadHQMEBt9pgxG2pFlFqackCqCfdlKjPE93IkWfxbmYUKSt2dlxKrU+lOQvMg
         PQTgy2Brugw/afhXJ2IVp1AWxXGzMTj1T+FZYLvNlJoIswGbYt8XomTj+lgmWVGD0whh
         FxKW8gztp046gie0nJEoULMtlkvSCR1TukM+unwOp9dkSbueaXDDIL5nz6NSTmCSFom3
         Waixjfjqw0C67CTnGM0jEfUQvpD560IY/zWIqjKOEojRXPH/xuXDdL3oHhQJOuW1e6Pb
         jM7m53+URVLJegwTSyNk/vSFFWQyCh39mi7Q/iEF7JssLOFhU/owhY3ZYLUOf321MnIu
         WfjA==
Received: by 10.216.150.225 with SMTP id z75mr3457279wej.77.1337219432015;
 Wed, 16 May 2012 18:50:32 -0700 (PDT)
Received: by 10.223.86.80 with HTTP; Wed, 16 May 2012 18:50:11 -0700 (PDT)
In-Reply-To: <2EDEF5ABBE208442B7547C8D36B9D8840C4A03@nawespscez09v.nadsuswe.nads.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197909>

Brian,

The first thing to know is that given a unique identifier for a
commit, it's sha-1, it is guaranteed that the history of that commit
will never change. Perhaps more accurately, the history is encoded
with the commit contents as part of the sha-1, so it is as secure as
sha-1.

What can change are references to commits - branches, the HEAD
reference, tags etc. Someone could take the contents of each commit,
and use them to create a new history that is slightly altered, but
this would be recorded as a different commit object, with a different
sha-1. At this point they could point a reference, such as a branch,
at this new commit object, and try to convince everyone that the
history hasn't changed. Git will viciously warn everyone when they try
to update this reference, requiring a force update to continue.

My understanding is that the config options you show are enough to
stop a remote user from updating a reference that changes history in
the way I mentioned. If they did update a reference like this, the
previous history would still exist, it would just not be referenced by
the branch name etc.

Regards,

Andrew Ardill


On 17 May 2012 08:47, Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600
<brian.p.jones4.ctr@navy.mil> wrote:
> I am working towards git adoption on a project. One of the concerns i=
s the fear that git history is not guaranteed to be time safe. How can =
I configure a git repository so users cannot push or pull changes into =
it that change it's history? This includes keeping users who work direc=
tly in the repository from doing a rebase.
>
> I've found...
> http://stackoverflow.com/questions/2085871/strategy-for-preventing-or=
-catching-git-history-rewrite
>
> Which recommends setting...
>
> =C2=A0git config --system receive.denyNonFastforwards true
> =C2=A0git config --system receive.denyDeletes true
>
> ...Is this enough to guarantee time safe history?
>
> Notes:
> 1. Only certain process-central repositories would need time safe his=
tory.
> 2. Developers can change their history provided it does not impact an=
yone else. I don't care about this case (yet).
>
> Brian P. Jones
> Senior Software Engineer
> Configuration Management
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
