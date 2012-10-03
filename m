From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 13:52:52 +0200
Message-ID: <CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
	<CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
	<vpqvcer4xvo.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 03 13:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJNVg-0001gl-Cy
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 13:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab2JCLwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 07:52:54 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46152 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab2JCLwx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 07:52:53 -0400
Received: by vcbfo13 with SMTP id fo13so8121158vcb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M+IpdXj6dVGi5Wi6J65tuLyR2sNnBxYf+1Zn6onZkWs=;
        b=A7cuSeNl6q/UEVK9JbPZUA8q1SDlL76hixHjJ5AyQKiLcTp+IrfjByAi8i5ELfUPMU
         pK7M8levf0BGaO0ttU+/w8+DXTHMHOWbIqCGNAFIX0X+oTrdI9r5si6GolXWWEQPgWY5
         j3COQIwczP2FpbwcE4RLLySFfT5vOnUH7lvnJG41qO+sALHNNdqUrMuo93OZ2YpQQBzt
         1mTc54qR16ethsLNZ7HZ0gRh7fcjpFbRm+EImPC5gBH4NZ5HmQT+DDEqzgx6KVscO3yg
         imlksdB6GP4jTrmIeKOxGKQzyM6ksD1sY71ZhCehnICKjv/JlGMx3rU6bwEdp7P29mLv
         K1IA==
Received: by 10.220.226.7 with SMTP id iu7mr947768vcb.64.1349265172779; Wed,
 03 Oct 2012 04:52:52 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 04:52:52 -0700 (PDT)
In-Reply-To: <vpqvcer4xvo.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206882>

Hi

>>> You still didn't tell us where the problem was.

I thought I did, but here it is: I have private and a public
repositories. In the private ones the developers keep both the sources
and the binaries. In the public ones they keep only the sources. They
do not want the binaries there because binaries are very large and
requite much time to be pushed. Besides that, they are not even needed
because they must be rebuilt anyway.
To push the sources only they keep in the private repositories an
orphan branch in which commits are done taking the relevant commits in
the (say) master branch and removing the binaries from the index.
Pushing directly the master branch would push also the binaries even
if they were removed from its index (the  history gets pushed): thence
the need for an orphan branch. Scripts have been provided to do this
easily and safely. Now, it could happen that a developer does not have
(yet) binaries, but want to push all the same. The script has to take
care for this special case, in which no binaries are removed, but a
commit on the orphan branch is done all the same. And here is the
problem since git commit does not produce a brand new, different &
unique commit all the times, making then the orphan branch point to
the master one, i.e. becoming a non-orphan one.

> I ended up with a branch "master" and a branch "new-branch", both
> pointing to the same commit. The new branch _is_ created.
>

Exactly, it is created, but it is not an orphan ... or more precisely,
it is sometimes, depending on how fast you are to enter the second
commit command. This time-dependent behaviour is what I am talking
about.

-Angelo
