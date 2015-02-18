From: Eric Frederich <eric.frederich@gmail.com>
Subject: Re: Get a git diff without taking index into account
Date: Wed, 18 Feb 2015 14:36:39 -0500
Message-ID: <CAAoZyYNY5V=WNf9dSG1p2iQqk11CjDB9Qm=t9mv97vgjY_ZWHA@mail.gmail.com>
References: <CAAoZyYN-ohiq-Od=u-cd5FRH8=NpJNGS+zEo+NYgwAK7Kjaz_w@mail.gmail.com>
	<CAAoZyYPhiKX1F5ymdSijR7=e8CT1sqaomehBjt-NVDz_A4V4UA@mail.gmail.com>
	<CAPc5daU9km+gr-DHJzJF59mugwGeNX69H27E_DaoyBZnuzoiFw@mail.gmail.com>
	<CAAoZyYPVopmP_bv7EZS912R4bxpzNm49_q0XXZXqa52dTDDM2Q@mail.gmail.com>
	<xmqqfva341sf.fsf@gitster.dls.corp.google.com>
	<CAAoZyYOst-5cD7qtV=T3Oahja1JN1ZmeyAcELrn7xD0bMc7Mrg@mail.gmail.com>
	<20150218183251.GB6346@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:36:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOAQO-0002eF-JC
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbbBRTgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:36:40 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:55932 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbbBRTgj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:36:39 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so6165686obc.4
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 11:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hMDVwjQjq1+ecr24MBgbpGVz3j7QNx57MdGuO0urcW4=;
        b=p52mCw4QASfXKBU+cmqGhKYSvBVgG/jbhqtUpJfmQ9w5Orf2oCM/tD7iqVkO5K5ceQ
         IJMpB/EfqzWEPgKHdzrP419o5zdHje6VFR9fYSIrVrtelFN2Hi7cSGa2LBpJKh8+k4Yu
         xWVrqXRt3xKFyLW3BC/PEgL0DN2CYU+v0p94QHNHy7enDpyfrV44BMSBeZiw6qCBGGFq
         yOrfpCkdsdgApc0YqHvIGIOv1hpxsEVrPOlu/cPHKMoTLtI/Ss259I8LmYuG4FEGMaP2
         NqPko3D5Ryb6KsUIC/ZBVDqdiaIrh7AzScu87NVJKCmdM0TRo9GYNywl5jWaVkWilEjR
         XO2g==
X-Received: by 10.60.116.4 with SMTP id js4mr612714oeb.78.1424288199225; Wed,
 18 Feb 2015 11:36:39 -0800 (PST)
Received: by 10.202.12.193 with HTTP; Wed, 18 Feb 2015 11:36:39 -0800 (PST)
In-Reply-To: <20150218183251.GB6346@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264057>

Thanks Jeff.

I recognize your picture from here...
   http://git.661346.n2.nabble.com/push-race-td7569254.html
... which helped me figure out how two processes trying to update a
ref at the same time works out.

I will try using a separate GIT_INDEX_FILE for each working tree.

I'm not certain that what I'm trying to do is even a good idea.

We have a system which is the official storage of things we'll just
call "items".
These items have one or more "revisions".  These revisions can have
all sorts of relationships to other revisions.
Once a revision is released it is locked down and cannot be changed
including the revisions.

Rather than working directly with this official storage system, we
want our application to work against a concept of a "local workspace".
This is where I want to use Git.
We can map a released revision to a tree structure by getting all the
files, serializing all the attributes, relation data, etc.
That tree structure is what I would store in Git.

My options seem to be
  1) use a single Git repo to store all items in a disconnected manner
(each item has a branch disconnected (orphaned?) from the other
branches)
  2) each item gets its own Git repo
  3) use a single Git repo to store all items but have them all
together in a workspace

I'm pursuing option (1) right now and trying to see how much work it would take.
With option (2) I think that would limit my ability to send a bunch of
items from one repo to another.
Option (3) doesn't really map to the system we're trying to mimic
because releases are done at the "item revision" level, not at a
higher workspace level.

On Wed, Feb 18, 2015 at 1:32 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 18, 2015 at 01:27:50PM -0500, Eric Frederich wrote:
>
>> My immediate concern is not to fix the documentation but to get some
>> sort of status or diff.
>> I want to avoid using an index because I want to allow multiple
>> processes to do different diffs at the same time.
>
> If you only have one working tree, can't all of the processes use the
> same index (that matches the working tree) and do different diffs
> against it?
>
> If you have multiple working trees, can you use one index per working
> tree, and specify it using GIT_INDEX_FILE?
>
> If you can persist the index file for each working tree, this will be
> much faster in the long run, too (you can just refresh the index before
> each diff, which means that git does not have to actually open the files
> in most cases; we can compare their stat information to what is in the
> index, and then the index sha1 with what is in the tree).
>
> -Peff
