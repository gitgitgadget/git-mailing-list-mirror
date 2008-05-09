From: "James Sadler" <freshtonic@gmail.com>
Subject: Re: git filter-branch --subdirectory-filter
Date: Fri, 9 May 2008 17:38:12 +1000
Message-ID: <e5e204700805090038k373bbabcyfb10d8c93ec5b3a7@mail.gmail.com>
References: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com>
	 <20080509013300.GA7836@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 09:39:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuNC3-0000pK-QE
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 09:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbYEIHiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 03:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbYEIHiP
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 03:38:15 -0400
Received: from hs-out-0708.google.com ([64.233.178.251]:42945 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbYEIHiN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 03:38:13 -0400
Received: by hs-out-0708.google.com with SMTP id 4so822312hsl.5
        for <git@vger.kernel.org>; Fri, 09 May 2008 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+29BoJBp1b16ynxZGOAjLJDGTHjBS1JKYA6yWIfSLHs=;
        b=KbTIx4tVK67XhWxbbD4QJkUPJwQ97QejFAALSUtAOR1/pfT10Nfxfz9A4iaMACIx+BZ8OgqIv87CdVDJarhIdqIwySt/UHaEyt3Nb9sqjhflHaeSIXQpea5lQ0G0+nZwU8Twc7j5dlzNkAx7B2B2dRp42Qk9XISs5QxPhTGzUqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tRD0Z6hPjvKkrw/T7MRPw4rOx2hDCTrFellG0XGw7MmdHbyGGIAonGcZmr4/0Z/F3BTew619PjetLcB/1Ro17RU3vUC7kTMxUFtPT8J0FeqM7jCUzROzLer37zqwUu1BbJBrvC1SrNtEk/5ixFz3+wci0/18M/Njk38ghi4peRY=
Received: by 10.90.88.17 with SMTP id l17mr6077406agb.8.1210318692854;
        Fri, 09 May 2008 00:38:12 -0700 (PDT)
Received: by 10.90.114.9 with HTTP; Fri, 9 May 2008 00:38:12 -0700 (PDT)
In-Reply-To: <20080509013300.GA7836@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81603>

Hi Jeff,

After reading your reponse and re-reading my original email, I
realised it was totally unclear
so I have re-explained myself below.

2008/5/9 Jeff King <peff@peff.net>:
> On Fri, May 09, 2008 at 11:01:47AM +1000, James Sadler wrote:
>
>> I have a git repository that I wish to split into multiple separate
>> repositories for each logical module that it contains. Each logical
>> module is already in its own directory at the root of the repo.
>
> OK.
>
>> To extract a module into its own repo, I first copied the original
>> repo (this was a simple cp -r, as it seemed to be the simplest way as
>> git clone doesn't get all the branches)

I must have experienced a brain fart or something or missed the '-r' from
git branch...

>> and ran filter-branch with a --commit-filter to skip commits that were
>> irrelevant to th subdir.
>
> But that's part of what subdirectory-filter does, so this step is
> unnecessary.

Yes that's true, but...

Clearer explanation:

I originally tried --subdirectory-filter by itself to see if it would
do the job, but it filtered
more commits than I thought it should (some commits that touched the subdir were
missing after filter-branch was run).

I then began to question my understanding of the semantics of
subdirectory-filter.

Is it meant to:
A) Only keep commits where ALL of the changes in the commit only touch
content under $DIR?
B) Only keep commits where SOME of the changes in the commit touch
content under $DIR?

I suspected that it was behaving as A.

That's when I decided to run the commit-filter first in combination
with the tree-filter.  This would
leave me with all commits that touched the subdir but any commit that
touched multiple subdirs
would be cleaned up so it only touched the subdir I want to keep.

At this point I have a bunch of commits that only make changes to
subdir (verified using gitk), and I would
expect subdirectory-filter to keep every single commit.

However, after running it, I loose most of my commits.  Strangely, the
working tree is bit-for-bit correct
with the original version or the subdir in the old repo, but the
history leading up to it is not.

--subdirectory-filter does not seem to behave as either A or B above
but something other way.  I'm sure
it will turn out to be something silly, but I'm pulling my hair out
trying to figure this one out.

Hopefully that's a clearer explanation!

-- 
James
