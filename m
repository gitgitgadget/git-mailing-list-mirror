From: cte <cestreich@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 14:44:42 -0700
Message-ID: <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
	 <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
	 <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Jul 31 23:45:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfy1-0001eg-2x
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945AbYGaVop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 17:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754761AbYGaVop
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:44:45 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:21517 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880AbYGaVoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 17:44:44 -0400
Received: by yw-out-2324.google.com with SMTP id 9so460286ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 14:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7ry+JFLsl2+uoizaX4E6MTm3ynrTP35cIDjCSYYJa7w=;
        b=J4P2kamTMk6F7xOcG96Um+zDWDQ25z5UFdA67mEaZPh8+p9OWlvUyGRNwavHHMDAYy
         dvklPV7hsZpQnfsbaUypJoOcj3tiI4/qeboDx05SLNRVrz2riXnAPt5PzwRoltfQ1qWC
         igsWyvyDa+kIeayzw7zwbJX7hcRwE2+ytkF6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sNZzrpmyjI2l9zBL3ktgF/3bjKN2hns2bA/5Hiazd8f1JjG6bHD+zCP84ovTWGhMFD
         Hr/7CeEslvJF6MVZUHepg12v+dOpwkLhMesGbCGEF7qu8gFqaE8UZ9AMkfaXtUHAgWG7
         jSlWBIVGgg6XChWIhhDrupSQxnBjvxk7l8E4Q=
Received: by 10.150.124.2 with SMTP id w2mr1971599ybc.170.1217540682467;
        Thu, 31 Jul 2008 14:44:42 -0700 (PDT)
Received: by 10.151.78.17 with HTTP; Thu, 31 Jul 2008 14:44:42 -0700 (PDT)
In-Reply-To: <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90999>

On Thu, Jul 31, 2008 at 11:27 AM, Sverre Rabbelier <alturin@gmail.com> wrote:
> On Thu, Jul 31, 2008 at 13:10, cte <cestreich@gmail.com> wrote:
>> I'm not worried about the interfaces changing; the gui is tied to a
>> particular version of git, and I will update the code that calls into
>> libgit I pull new changes from the mainline into my local clone.
>
> You should be ;). Unless you are planning to learn a lot of C very
> fast, you should be worried about the interfaces changing. That is, if
> you want your GUI to be able to stay up to date with the current git
> version.

That is the plan.

>> who's to say that the output of the various commands won't change
>> formats with future releases of git?
>
> Junio is to say. Plumbing output format is git's API.

Using output from the command line utilities as an API has its own set
of problems. For instance, check out some of the difficulties that
gitk and qgit have had to deal with:
http://kerneltrap.org/mailarchive/git/2007/11/2/379067. Digging into
the git internals and reusing its core functions will always be more
powerful and flexible than parsing command line output. Of course, it
is not always easy; git wasn't written to be easily compiled into a
library and reused (graceful error handling and memory management are
problematic). But I think the right thing to do is to work towards
making the awesome git internals easier to use for other developers so
great tools can continue to be built on top of git.

>> There is no correct solution if
>> you are worried about forward compatibility, unless a well defined API
>> is created (which would be sweet btw, but is probably not a priority).
>
> There is, use the plumbing, forward compatibility is 95% assured. With
> the exception of major releases, for which any plumbing
> output/behavior changes will be announced in the changelog, usually
> including an explanation on how to change your code to match.

95% assured != correct, IMO :)

> In short, use the forc-... errr, plumbing ;).
>
> --
> Cheers,
>
> Sverre Rabbelier
>
