From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up git-cherry
Date: Sat, 7 Jun 2008 16:50:59 -0700
Message-ID: <7f9d599f0806071650p6d650b7dwfd69c753850f3e25@mail.gmail.com>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>
	 <alpine.DEB.1.00.0806020649110.13507@racer.site.net>
	 <20080602064218.GA15144@sigill.intra.peff.net>
	 <7f9d599f0806020735g30722893mb8efed41a6544ab5@mail.gmail.com>
	 <alpine.DEB.1.00.0806021635220.13507@racer.site.net>
	 <7f9d599f0806020849g567461b2kecd65dbd35d3dc3b@mail.gmail.com>
	 <alpine.DEB.1.00.0806021717130.13507@racer.site.net>
	 <7f9d599f0806020926j7ac9fb12jefa5a14fe5708226@mail.gmail.com>
	 <alpine.DEB.1.00.0806021913340.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 08 01:52:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K58Cu-0000KC-FQ
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 01:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbYFGXvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 19:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754527AbYFGXvB
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 19:51:01 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:36624 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbYFGXvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 19:51:00 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2046755rvb.1
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=qhmspwPvGKiXkoipP8O8/E03C9EKJ08wdeMrMyq2b10=;
        b=s8gZEStXsylN033+d0+iWNzI1TcpuLhObXgixLUgX78WvPjHCdDr0FFxtx2TRXNjnN
         OlAvXLh1MZD9VIdwXAZ/lgCmYD6m98DqeMZo7+awGc2wCBTsqKfqTcdXfeLSUK/ZCY0V
         PDiIMPuNoz9G3guVB4NNyRHS/ZuEPqD0TnvKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=oKL2P5XvuevDF5ByULIpYbYzRZVu2K0p0P4DWY42qZ7Kt6724nQRvKMCnYr4y+FMZ1
         WpdN7gc2kyp0Y5QrWHHgRRYBCNcxU8WJlOYjvAEFukcggxUpNMwH3k4v6byGWPrKlRTt
         FnvzK7+8T9d9SmqiJT3W7Lyf5hDbx6Zy8aDMw=
Received: by 10.141.113.6 with SMTP id q6mr1063890rvm.135.1212882659875;
        Sat, 07 Jun 2008 16:50:59 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Sat, 7 Jun 2008 16:50:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806021913340.13507@racer.site.net>
Content-Disposition: inline
X-Google-Sender-Auth: 0bc0e04821fcbfef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84232>

On Mon, Jun 2, 2008 at 11:15 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 2 Jun 2008, Geoffrey Irving wrote:
>
>> On Mon, Jun 2, 2008 at 9:18 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > On Mon, 2 Jun 2008, Geoffrey Irving wrote:
>> >
>> >> On Mon, Jun 2, 2008 at 8:37 AM, Johannes Schindelin
>> >> <Johannes.Schindelin@gmx.de> wrote:
>> >>
>> >> > Another issue that just hit me: this cache is append-only, so if it
>> >> > grows too large, you have no other option than to scratch and
>> >> > recreate it. Maybe this needs porcelain support, too?  (git gc?)
>> >>
>> >> If so, the correct operation is to go through the hash and remove
>> >> entries that refer to commits that no longer exist.  I can add this
>> >> if you want.  Hopefully somewhere along the way git-gc constructs an
>> >> easy to traverse list of extant commits, and this will be
>> >> straightforward.
>> >
>> > I don't know... if you have created a cached patch-id for every commit
>> > (by mistake, for example) and do not need it anymore, it might make
>> > git-cherry substantially faster to just scrap the cache.
>>
>> Well, ideally hash maps are O(1), but it could be a difference between a
>> "compare 40 bytes" constant and a "read a 4k block into memory"
>> constant, so in practice yes.  Scrapping it entirely will also make the
>> implementation much simpler.
>>
>> It seems a little sad to wipe all that effort each time, but
>> regenerating the cache is likely to be less expensive than a git-gc, so
>> it shouldn't change any amortized complexities.
>
> Well, how about only scrapping the cache if it is older than, say, 2
> weeks, and is larger than, say, 200kB?  That should help.

That heuristic is insufficient, since it doesn't do anything in the
normal case where a new entry appears every few days (e.g., when
syncing between two branches with cherry-pick).

I don't know what the best alternative is, so I left garbage
collection out of the patch I just submitted.  We can add it once we
decide what to do.  I'm not sure it's a serious problem: if you
"accidentally" added entries for all commits in the git tree, the file
is still under 1M.

Geoffrey
