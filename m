From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git init doesn't create master branch
Date: Wed, 29 May 2013 18:50:39 +0530
Message-ID: <CALkWK0nLJn2EDy9KO+Qp3sHhxgyKQag-575srq5ztuu5LgsmyA@mail.gmail.com>
References: <51A5F8E0.8060906@intland.com> <vpqk3migdb1.fsf@anie.imag.fr>
 <CALkWK0m=m89QcnMNg9gEVeb7ZHSRd7ZMcL+y8gYuzn8YCTsSYw@mail.gmail.com> <51A5FC17.8000608@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: =?UTF-8?B?w4Frb3MsIFRhanRp?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:21:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgJh-0007DR-0E
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966069Ab3E2NVU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 09:21:20 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36493 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965613Ab3E2NVU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 09:21:20 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so24720964iet.14
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=z9OkHp07nBUZYUibqT0UoJKLXcS70Kbwh8RCsMwjHcg=;
        b=Z2dw2IY2sm53Y1SQT2wKw3dEDjTNqDAsfP7fYotD8rYzOwdkePby1ZR1y5Iyujv+2U
         kQiufD0T/sAm5+XwKpFcXaWlr9a/9MiT8IP22AgAc93vqgOXjCmB2weXZX8QBSf5lsXz
         OE+fHqnHKog8Nuk6ZK0aPJi1Wnuo6aHlXUmz68etcqaQ9pSnC/kudUVlIM4XQOesYQMH
         mkU8P/2oWSLesj2sHWdyPY6kexhG4a9a39jhuMbqdXgw8TczjEOQ1GBTTwJEc4X1n5yc
         kr7Cq3/tuCzKNdgE7IWK/C4TGHhUmAw5E6uB5VxB0I/ezg1qXmXEtind7A/785WkWIOS
         G0hQ==
X-Received: by 10.50.141.230 with SMTP id rr6mr9303398igb.89.1369833679775;
 Wed, 29 May 2013 06:21:19 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 06:20:39 -0700 (PDT)
In-Reply-To: <51A5FC17.8000608@intland.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225812>

"=C3=81kos, Tajti" wrote:
> "Cannot merge multiple branches into empty head"
>
> The command was:
>
> git pull ../dump.dmp refs/heads/*:refs/heads/*
>
> Is this a better way of doing this?

pull runs a fetch, which updated .git/FETCH_HEAD.  Now, if
=2Egit/FETCH_HEAD has just one branch (and other not-for-merge entries)=
,
there's no problem.  We just run update-ref HEAD, and get it to point
to the sole branch that was fetched.  If your fetch fetches multiple
branches, and you have a real branch (not "unborn") with
branch.<name>.merge set, we know which one of those branches to merge
in.

Now, what you have is a fetch which fetches multiple branches, and
you're trying to merge that into a non-existent HEAD (or unborn
branch).  There is ambiguity and arguably no "right" thing to do,
which is why git complains.  I'm not sure if it's possible to argue
differently and patch git-pull.sh for your usecase.

There are many possible solutions to the problem, depending on what
you want.  The simplest I can suggest is: ignore the error for that
command and run git reset --hard.
