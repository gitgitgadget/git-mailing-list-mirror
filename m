From: Dimitar Bonev <dsbonev@gmail.com>
Subject: Re: Add porcelain command to revert a single staged file to its HEAD
 state while preserving its staged state
Date: Tue, 7 May 2013 23:39:19 +0300
Message-ID: <CADeMBopOQP099WwoQwq8bbNbaE55foUzRri4CcHPnJa2L-baFQ@mail.gmail.com>
References: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
	<87obcryvcw.fsf@hexa.v.cablecom.net>
	<7va9oawmbp.fsf@alter.siamese.dyndns.org>
	<7v61yywm49.fsf@alter.siamese.dyndns.org>
	<CADeMBopBvCmb4cz8p8vf-jXaOhfzP3GZKF94Efgsh-NOBs+d3Q@mail.gmail.com>
	<7vbo8otb29.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 22:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZofV-00054y-8u
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 22:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759308Ab3EGUjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 16:39:21 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:50794 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757618Ab3EGUjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 16:39:20 -0400
Received: by mail-pb0-f47.google.com with SMTP id uo1so679481pbc.20
        for <git@vger.kernel.org>; Tue, 07 May 2013 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6yM1IfrbRqJPMWZRkSHwddLa8/EnvJQ9pQqet1fxIgQ=;
        b=pYPoWu1pq/sC+RcB7T/B7zUfXNKzC7rYzBaa5kega45mR74Y1J4zP1YAvDeSkPpj3Q
         nzmXhJ8qc8/y2uJM0uwRgs3SbE1UFVATWZ1+VnzNbOo6wHn+FaKrGmJNb/pdKDOuJVUi
         CmYDdcxDY3mCaVH3Pi1QQTBNJPjvjY35zh5zxi58BBhKKmcMRGU3PyhWcwPhT12sF/c0
         B7Pq8EH35GpYC/k8Cx5xU5Yt7xeVhaCbESqb5utaobofdBsxCVpELi0qrFieDwBj+7Ue
         U88lAYZKBKMRslaGPzPy/ZpHG/sU3OY0Lp23ms4XigaxNz3Y1LnCTdtHZ33/pLTpQ+O9
         u28g==
X-Received: by 10.66.8.69 with SMTP id p5mr4720264paa.57.1367959160061; Tue,
 07 May 2013 13:39:20 -0700 (PDT)
Received: by 10.70.78.37 with HTTP; Tue, 7 May 2013 13:39:19 -0700 (PDT)
In-Reply-To: <7vbo8otb29.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223601>

Junio C Hamano <gitster@pobox.com> wrote:
> Dimitar Bonev <dsbonev@gmail.com> writes:
>
> [administrivia: please do not drop people out of Cc list]
>
> That invites another question: if it is very well related, why isn't
> it an option to start from the state you have in the working tree
> (i.e. doing nothing), or in the index (i.e. "git checkout
> controller")?
>
> But the answer does not matter that much in the end.
>

It isn't an option to start from the staged state, because the staged
implementation modified code that is present in the HEAD state. So the
new implementation that I have in my mind requires to add its own kind
of modifications which are incompatible with the staged
implementation. It is much easier to start from HEAD state when both
implementations require modifying 10% HEAD code and adding 90% new
code. If I start from staged state I have to drop 90% new code and to
figure out if the 10% modified state can work without the 90% dropped
code. At the same time I know HEAD state is stable working code. There
is no doubt that I have to start from HEAD state of the controller
file for the described MVC example

>
> I think the story is essentially the same.  Let's say you did
>
>     git diff HEAD controller | git apply -R
>     edit controller
>
> to get rid of the changes in the working tree, further worked on the
> controller part, and came up with a different implementation.  Then
> you would presumably do
>
>     git add controller
>
> but at that point you would lose the "maybe OK" version you had in
> the index.  What if you think the version in the working tree might
> end up being better than "maybe OK" but can still be improved
> further?  You never "git add" until the working tree version gets
> into truly a better shape?
>

Yes, I 'git add' only what is to become part of the next commit so at
least it has to be stable code (that passes some smoke tests or
something similar).

> What happens fairly often is that you end up having more than _one_
> versions that are both better than the version from the HEAD but
> cannot immediately say one is clearly better than the others in all
> counts, and at some point, you would need more than one intermediate
> states (while the index can have only one), to keep these competing
> versions. The next thing you would want to do is to take a deep
> breath and pick better parts from these good versions to come up
> with the single final version. Keeping one good version in the index
> does not let you do so.
>

My case was not like that but if it was I would have made a commit to
preserve the old implementation while working on the new one.

>
> I think people should learn to take the biggest advantage of using a
> distributed source control system, which is that commits do not have
> to be "finished work", until you choose to declare they are done and
> push them out for others to see.
>
> Fear of commitment is a disease we do not have to suffer once we
> graduated centralized systems ;-).

I used the wrong words - I meant 'stable state' instead of 'finished
work'. If every commit was finished work then all my branches would
have contain one specific commit. My branches are built from more than
one commit and every commit adds a subfeature and the commit should be
stable in sense that it should run without throwing exceptions - like
trying to load some file that would be created in a future commit. One
should be able to checkout a random commit and be able to run,
inspect, write tests against, add new subfeature on top of that
commit.
