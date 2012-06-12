From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 10:45:22 -0700
Message-ID: <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
References: <20120611160824.GB12773@sigill.intra.peff.net> <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net> <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net> <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net> <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net> <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, "Ted Ts'o" <tytso@mit.edu>,
	Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:45:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVA5-0008HZ-8L
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 19:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab2FLRpp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 13:45:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60716 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab2FLRpn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 13:45:43 -0400
Received: by dady13 with SMTP id y13so7172443dad.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hwMVGk9Sk09V+tvGdFQHAI4ekxfMZVDmpTniJCTwcb8=;
        b=IrVyRW9Tta4QZUeojM1q7hbbtg33f26M9txJAiK5+X8ArK5IldvS8rflzrEqODphw2
         0PhvWeJxUtobHlEiscGFpQlNDygByXMuQRn54fiNdcFy8n8iuNNqiDczYchRS5lcUA6t
         AGJQ2TViTPbZUVjv8d9m/ehoKZ/YEy9W9iz4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=hwMVGk9Sk09V+tvGdFQHAI4ekxfMZVDmpTniJCTwcb8=;
        b=g6cRq2gtATHA4xE6hcpGnZnrg1IM/YDXKobz6Ph0UXaH2IgeT3izgL2epkxLidgB+j
         F4sCG6nRznh4pt4Jo0jXaBXKpiyNNodUPtCRrO79NLIjJxgtP7i7u4y6HxWS88iE+7Bg
         9Bp+JjuE52oQxl0Zvl23FeV+ty/5H15uzBs6qWaG62hjXXdms2tb+AFPhKfrn3ikOfbv
         RCEi58TDjm7ZgcOAp0SQ6Ck8k6/5e6NGAG75MVC37/2Uzat+beTjRASC6FtShs2I7wR+
         jbTn87BfYXxolOOi5Mj2UlQBFIsyATCAWBaJZh00lOqp8mnfo31/5JaVD22XO86mFrdt
         91Gw==
Received: by 10.68.197.198 with SMTP id iw6mr40486401pbc.36.1339523142580;
 Tue, 12 Jun 2012 10:45:42 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Tue, 12 Jun 2012 10:45:22 -0700 (PDT)
In-Reply-To: <20120612173214.GA16014@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQnIgC1+spuI10qNxOYsscjyLgssEmjIgOk09X/ljv6SLjUN+ZvAOMbc42x4jiaEcbtxlFnt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199818>

On Tue, Jun 12, 2012 at 10:32 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 12, 2012 at 01:30:07PM -0400, Nicolas Pitre wrote:
>
>> > > To make it "safe", the cruft packs would have to be searchable f=
or
>> > > object retrieval, but not during object creation. =A0That nuance=
 would
>> > > affect the core code in subtle ways and I'm not sure if that wou=
ld be
>> > > worth it ... just for the safe handling of cruft.
>> >
>> > Why is that? If you do a "repack -Ad", then any referenced objects=
 will
>> > have been retrieved and put into the new all-in-one pack. At that =
point,
>> > by deleting the cruft pack, you are guaranteed to be deleting only
>> > objects that are either unreferenced, or are duplicated in another=
 pack.
>>
>> Now what if you fetch and a bunch of objects are already found in yo=
ur
>> cruft pack? =A0Right now, we search for the existence of any object =
before
>> creating them, and if the cruft packs are searchable then such objec=
ts
>> won't get uncruftified.
>
> Then those objects will remain in the cruft pack. Which is why, as I
> said, it is not generally safe to just delete a cruft pack. However,
> when you do a full repack, those objects will be copied into the new
> pack (because they are referenced). Which is why I am claiming that i=
t
> is safe to remove cruft packs at that point.

But there is a race condition with a concurrent fetch and a concurrent
repack. If that fetch needs those cruft objects, and sees them in the
cruft pack, and the repack sees the references before the fetch, the
repacker might delete things the fetch is about to reference and that
will leave you with a corrupt repository.

I think we already have this race condition with loose unreachable
objects whose mtimes are older than 2 weeks; they are removed by prune
but may have just become reachable by a concurrent fetch that doesn't
overwrite them because they already exist, and doesn't update the
mtime because they aren't writable.
