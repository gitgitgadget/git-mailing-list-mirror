Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961491F403
	for <e@80x24.org>; Tue, 12 Jun 2018 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933795AbeFLTJW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 15:09:22 -0400
Received: from mail134-31.atl141.mandrillapp.com ([198.2.134.31]:50585 "EHLO
        mail134-31.atl141.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933414AbeFLTJS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jun 2018 15:09:18 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jun 2018 15:09:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=TpVns2lc23y6dbmidM53qrAZwDcUXSFoBQliRcT0JUw=;
 b=Dn1wwSgDz7XQv6tZHG/5Uc+uq/HdoM72RAKGsPZ7Z+CsC04b/eOSprhhXfB4nGceO97up004L0OF
   hWjv4rBjWjg0sb7rQ+qambkEiO+cN+eR67CblgqIym03Jon29woPMnynIMKhiCINr8jAJ4WVODRs
   Afx2YWAtkdNm41xg/xs=
Received: from pmta03.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail134-31.atl141.mandrillapp.com id h40d5s1sau80 for <git@vger.kernel.org>; Tue, 12 Jun 2018 18:54:17 +0000 (envelope-from <bounce-md_31050260.5b2016d9.v1-895a8966288f4001a9d7029e2456f10f@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1528829657; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=TpVns2lc23y6dbmidM53qrAZwDcUXSFoBQliRcT0JUw=; 
 b=gZER+507x1p8IHN6nKb1sTcPg99Xwa9ZJqHe070+OZS+dRmOKJxN0STQ9TL+Sk53KtJuFS
 qkF3WT9gl24VJoLpyHWbEooA5033ax89wOXq1TM/inU6Bp2q/fz+ImFv/SlicMXFpsGKvsvk
 M2I+4Vfa4kTrUomVUgZawJNsjZhW4=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH v2] fetch-pack: don't try to fetch peel values with --all
Received: from [87.98.221.171] by mandrillapp.com id 895a8966288f4001a9d7029e2456f10f; Tue, 12 Jun 2018 18:54:17 +0000
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Message-Id: <20180612185413.GA21856@deco.navytux.spb.ru>
References: <20180610143231.7131-1-kirr@nexedi.com> <20180611042016.GA31642@sigill.intra.peff.net> <20180611044710.GB31642@sigill.intra.peff.net> <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com> <20180611055357.GA16430@sigill.intra.peff.net> <20180611094255.GA15563@deco.navytux.spb.ru> <20180612094849.GB26123@sigill.intra.peff.net>
In-Reply-To: <20180612094849.GB26123@sigill.intra.peff.net>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.895a8966288f4001a9d7029e2456f10f
X-Mandrill-User: md_31050260
Date:   Tue, 12 Jun 2018 18:54:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 05:48:49AM -0400, Jeff King wrote:
> On Mon, Jun 11, 2018 at 09:43:02AM +0000, Kirill Smelkov wrote:
> 
> > > Looking deeper, we do not need these trees and blobs at all. The problem
> > > is really just a tag that peels to an object that is not otherwise a ref
> > > tip, regardless of its type.
> > 
> > Thanks for feedback and for coming up with the fix. Sure, I'm ok with
> > moving the test into your patch. However, even if a test becomes
> > different - narrowing down root of _current_ problem, I suggest to also
> > keep explicitly testing tag-to-blob and tag-to-tree (and if we really
> > also want tag-to-commit and tag-to-tag) behaviour. Reason is: if we skip
> > those now, they can potentially break in the future.
> 
> Yeah, I have no problem testing these cases separately. There's no bug
> with them now, but it is a slightly uncommon case. My suggestion would
> be to submit a patch that goes on top of mine that covers these cases.

Ok, I will try to do it.


> > I would also suggest to fix upload-pack, as it is just not consistent to
> > reject sending objects that were advertised, and so can strike again
> > some way in the future. After all git.git's fetch-pack is not the only
> > git client that should be possible to interact with git.git's
> > upload-pack on remote side, right?
> 
> No, it's not the only client. At the same time, I am on the fence over
> whether upload-pack's behavior is wrong or not. It depends what you take
> a peeled advertisement line to mean. Does it mean: this object has been
> advertised and clients should be able to fetch it? Or does it mean: by
> the way, you may be interested to know the peeled value of this tag in
> case you want to do tag-following?
> 
> So far I think it has only meant the latter. I could see an argument for
> the former, but any client depending on that would never have worked,
> AFAICT. We could _make_ it work, but how would a client know which
> server version it's talking to (and therefore whether it is safe to make
> the request?). I think you'd have to add a capability to negotiate.

I see. I don't know the details of the exchange, just it was surprising
for outside observer that fetching what was advertised is rejected. For
the reference there is no strong need for me for this to work anymore
(please see below).


> > I'm not sure, but I would say that `fetch-pack --all` from an empty
> > repository should not fail and should just give empty output as fetch
> > does.
> 
> Yeah, that seems reasonable to me. The die() that catches this dates
> back to 2005-era, and we later taught the "fetch" porcelain to handle
> this. I don't _think_ anybody would be upset that the plumbing learned
> to treat this as a noop. It's probably a one-liner change in
> fetch_pack() to return early instead of dying.

Ok, I will try to send related testcase, and it is indeed easy to find
- the fix itself.


> > For the reference all the cases presented here are real - they appear in
> > our repositories on lab.nexedi.com for which I maintain the backup, and
> > I've noticed them in the process of switching git-backup from using
> > fetch to fetch-pack here:
> > 
> > https://lab.nexedi.com/kirr/git-backup/blob/0ab7bbb6/git-backup.go#L436
> 
> I applaud you using the porcelain for your scripts, but I suspect that
> fetch-pack by itself is not at all well-used or well-tested these days
> (certainly this --all bug has been around for almost 6 years and is not
> very hard to trigger in practice).

I see; thanks for the warning.


> If an extra connection isn't a problem, you might be better off with
> "git ls-remote", and then picking through the results for refs of
> interest, and then "git fetch-pack" to actually get the pack. That's how
> git-fetch worked when it was a shell script (e.g., see c3a200120d, the
> last shell version).

Yes, this is what I ended up doing:

https://lab.nexedi.com/kirr/git-backup/commit/899103bf

but for another reason - to avoid repeating for every fetched repository
slow (in case of my "big" destination backup repository) quickfetch()
checking in every spawned `git fetch`: git-backup can build index of
objects we already have ourselves only once at startup, and then in
fetch, after checking lsremote output, consult that index, and if we see
we already have everything for an advertised reference - just avoid
giving it to fetch-pack to process. It turns out for many pulled
repositories there is usually no references changed at all and this way
fetch-pack can be skipped completely:

https://lab.nexedi.com/kirr/git-backup/commit/3efed898

> It may also be sane to just use "git fetch", which I'd say is _fairly_
> safe to script. Of course I have no problem if you want to fix all of
> the corner cases in fetch-pack. Just giving you fair warning. :)

Thanks again for the warning. I'm happy the switch to fetch plumbing
happenned on my side, and so far it is working well. Like I said above I
cannot use `git fetch` as is, because quickfetch() overhead for my case
became dominant and very slow, taking ~ 30 seconds of the time just to
check whether we have everything from one fetched repository, which, if
there are 100x or 1000x of such, adds up to hours.

If ls-remote has to be used anyway switching to plumbing seems natural.
Let's see if I hit any more corner place or not - I will be keeping your
warning in mind.

Thanks again,
Kirill
