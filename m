From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Wed, 18 Nov 2015 13:32:36 +0100
Message-ID: <CACsJy8Ah2PgO8CunCvWiKB7RfqMfovWa1a7ro5scHFK+AEAXpg@mail.gmail.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net> <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <20151113233807.GD16173@sigill.intra.peff.net> <20151113234116.GA18234@sigill.intra.peff.net>
 <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
 <564A279C.6000802@web.de> <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
 <CACsJy8D-TRJ---4BYrEZeEkd9_5-xgGp4U0nB9YHNtV3zgxrbg@mail.gmail.com> <20151117214347.GB27862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 13:33:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz1vF-00068o-NQ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 13:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbbKRMdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 07:33:09 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34424 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbKRMdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 07:33:08 -0500
Received: by lffu14 with SMTP id u14so25301647lff.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 04:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=57rQIHWMswgDN7l4o6NQhF4xgbaxeJdVyx6nX77J4Wg=;
        b=oKTz98DNi8ij9k4ssg6p1nAZO5NOJkW5n50WIq53mTDKI3GnxNFgbvpdEWYdU1vf22
         F142Ol24+WdWB26FnbWGbWA7THQwt/901xun3cb2h23koiwvuYQp98o6JavDimQp/lmI
         FeJvaAvBh8lGUaJz47/PSRV+IxK9jyO98H8szK78bQesdwONN7v8k98e5UyOO7frDa9D
         VTBycEocJsx9FqBVB5Tzmn5iuqcMI3natx6C9m75vlnnO4TCUZnH4byAb9dEPfrfQcSj
         X1tj7p4WadxJ8lKjs22iphLscgDWR1QnneeyGM9RmqCh7Zm6LpQHv0/ioFocKisd9LkB
         3H+g==
X-Received: by 10.25.43.149 with SMTP id r143mr569892lfr.45.1447849986043;
 Wed, 18 Nov 2015 04:33:06 -0800 (PST)
Received: by 10.112.255.229 with HTTP; Wed, 18 Nov 2015 04:32:36 -0800 (PST)
In-Reply-To: <20151117214347.GB27862@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281448>

On Tue, Nov 17, 2015 at 10:43 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 17, 2015 at 09:17:43PM +0100, Duy Nguyen wrote:
>
>> On Mon, Nov 16, 2015 at 8:25 PM, Stefan Beller <sbeller@google.com> wrote:
>> > Instead of having to search all branches for the requested sha1, we could have
>> > some sort of data structure to make it not an O(n) operation (n being
>> > all objects
>> > in the repo).
>> >
>> > Maybe I overestimate the work which needs to be done, because the server has
>> > bitmaps nowadays.
>>
>> Quote from [1]
>>
>> > If we take the kernel history in rev-list and pick two commits that
>> > are roughly ~10,000 commits apart from one another, JGit can compute
>> > the rev-list --objects between these two commits in about 120
>> > milliseconds (git-core should be faster, or at least comparable).
>>
>> I think we should be fine (note that --objects is a lot heavier than
>> commit walking). Though.. I just tried it on git.git. 10k commits
>> (without --objects) take about 200ms with C Git..
>
> A lot of this depends on the endpoints. We can't store bitmaps for every
> commit, so we often have to fall back to traversing from the commit,
> collecting reachable objects until we hit a commit that does have
> bitmaps.
>
> I think the for the purposes of upload-pack and reachability, it might
> be fine to just walk commits, which as you note is much cheaper. The C
> git bitmap code does not currently have a way to say "I only care about
> commits, do not bother filling in the trees and blobs when you have to
> do a fallback traversal". But it would not be hard to add, I think.

Yeah I think that was the 10k commits in Shawn's mail: the number of
commits we may have to walk until we hit a reachability bitmap. It
looks like C Git will create a bitmap every 5k commits, not 10k,
though, if I read the code correctly. The point is reachability test
with the presence of pack bitmaps is not O(n) anymore. Which is
probably good enough for now.
-- 
Duy
