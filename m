From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 17:01:50 +0530
Message-ID: <CALkWK0nBUHHkqOQannMu5Kjs00Fro8KBbiocfsT4Uf74jO9FgA@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
 <1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com>
 <CAMP44s3fPsGW_9aBbcsu8cJAagz8JEWV2HM=XRH3Rw4=SXdL7Q@mail.gmail.com>
 <CALkWK0nOywB5BtHnKZQ_+wsJNp82zk7-YJw_S15quqH+iU=jWg@mail.gmail.com>
 <CAMP44s2vsD2uwFoL5_79m05gtqyKLN9wHX8Yrhtn0kT4LVULxQ@mail.gmail.com>
 <CALkWK0m+_AbCd305dU5p5bxwuPPCBKJH7a3e6rHgxxnySMz0pQ@mail.gmail.com> <CAMP44s1eB+bvg7vnG5S3SBACHTrkpCqJNX-Q2tzEVdvzFWvkcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 13:32:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcwQF-000335-Ve
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 13:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab3EPLcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 07:32:32 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:41883 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab3EPLcb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 07:32:31 -0400
Received: by mail-ia0-f171.google.com with SMTP id k10so1814136iag.16
        for <git@vger.kernel.org>; Thu, 16 May 2013 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=pC6jX0RftIyd4qboHPEnorKD3vOcMdt+HwwIlOdWJag=;
        b=lmCaZWXifl0laLDNYjnFAR0AM9Z9rc4tjeWh4tBcgPQYze7QOx81P5VO4ed5n/GlpI
         EqijQRPRJykA5UMqhhr2j2g1mQdW9tFTM4NEhBlJQzCuJBO0MjwnKNYprmCf+z+AZ7j3
         8klJS3KuytbvtRmW3Z8CsWfwP+KK8eDb0w2orLQWII9XhvSmL2X3SPh1/N92zBOHavK6
         DrseqOpAfolNEoYEFGhaXKx5o7PRNeB4zWpYZOrUoXceQ4Z8MJi4aBFY6Zj9NnXF3upv
         /tAxNx0lEDlCLTrRiPsK5bB9Ci4MbJYyRrSWWwWQj7VQ8vU/YtZE+96g/AiCSk90vREJ
         mssw==
X-Received: by 10.50.3.38 with SMTP id 6mr8950286igz.44.1368703950943; Thu, 16
 May 2013 04:32:30 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 04:31:50 -0700 (PDT)
In-Reply-To: <CAMP44s1eB+bvg7vnG5S3SBACHTrkpCqJNX-Q2tzEVdvzFWvkcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224555>

Felipe Contreras wrote:
> Would I be able to do:
>
> % git branch --set-upstream-to origin/master --set-downstream-to
> github/fc/master
>
> ?
>
> Would I see these branches when I do 'git branch -vv'?
> Would I be able to do 'git push next@{downstream}'?

Hm, losing this functionality in the name of generality would
certainly be very undesirable.

> That is orthogonal to 'branch.A.push' the same way 'remote.B.fetch' is
> orthogonal to 'branch.A.merge'.

Not at all (which is what I've been trying to say).
remote.<name>.fetch is operated on by fetch, while branch.<name>.merge
is operated on by merge; they are really orthogonal.  What happens if
both branch.<name>.push and remote.<name>.push are set?  What will
push do?

Perhaps we should get both, and get branch.<name>.push to override
remote.<name>.push.  The issue being @{d} will not work if
remote.<name>.push is set.  Then again, since we're targeting Gerrit
users here, I don't really think it's an issue: refs/for/master is not
really a "downstream branch"; it's a pseudo-ref that Gerrit handles
internally.
