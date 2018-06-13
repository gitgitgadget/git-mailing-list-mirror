Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B19481F517
	for <e@80x24.org>; Wed, 13 Jun 2018 13:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935405AbeFMNKz (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 09:10:55 -0400
Received: from mail134-31.atl141.mandrillapp.com ([198.2.134.31]:60818 "EHLO
        mail134-31.atl141.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935346AbeFMNKy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Jun 2018 09:10:54 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2018 09:10:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=Kqxe3WHuO2yJVWNQNrK5PQRIEE+px87njGbzOadn8cw=;
 b=gzuVdcMgU+2sf8OY/OFG/hA+Ux2Ncnr+tejbm2OS3Kx41ZNEQuzO35FneU4N1pOuAG7jxBWmO9Hc
   iOorP3wHWGVi9mxkGW4IXbB7RjDgAsbfJsS4s8mDqSreOTDH7UJk9al9nigVPj6CvgDEbJvYD458
   qyh8TS/cs1tqXgcyVFc=
Received: from pmta03.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail134-31.atl141.mandrillapp.com id h44bts1sau8q for <git@vger.kernel.org>; Wed, 13 Jun 2018 12:55:53 +0000 (envelope-from <bounce-md_31050260.5b211459.v1-b0615f2a5af84dec968c22b4db62509b@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1528894553; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=Kqxe3WHuO2yJVWNQNrK5PQRIEE+px87njGbzOadn8cw=; 
 b=i7F0JSW5907szUgTsmHilk7y7vnciystm7nqScUzW01ETBma58O8QXZkF7nd4qtISBRjmj
 jOUK+nDpXIA+jegSi67mEamoNEtAPeQG7FkIBkxKgAiVlQ01Q7028ERMmPHmfdql3rQYVCaJ
 xXYuxBxf5P5WfW+WsBXAFJeuge3Bc=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH] fetch-pack: demonstrate --all failure when remote is empty
Received: from [87.98.221.171] by mandrillapp.com id b0615f2a5af84dec968c22b4db62509b; Wed, 13 Jun 2018 12:55:53 +0000
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git List <git@vger.kernel.org>
Message-Id: <20180613125549.4mshuymvdpwh44qk@deco.navytux.spb.ru>
References: <20180610143231.7131-1-kirr@nexedi.com> <20180611042016.GA31642@sigill.intra.peff.net> <20180611044710.GB31642@sigill.intra.peff.net> <CAPig+cT73d0rYoSbt7oHVG4MYHVvjKidP0ogRwV+9F73jcjZEA@mail.gmail.com> <20180611055357.GA16430@sigill.intra.peff.net> <20180611094255.GA15563@deco.navytux.spb.ru> <20180612094849.GB26123@sigill.intra.peff.net> <20180612185413.GA21856@deco.navytux.spb.ru>
In-Reply-To: <20180612185413.GA21856@deco.navytux.spb.ru>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.b0615f2a5af84dec968c22b4db62509b
X-Mandrill-User: md_31050260
Date:   Wed, 13 Jun 2018 12:55:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

( Junio, please pick up the patch provided in the end )

On Tue, Jun 12, 2018 at 06:54:17PM +0000, Kirill Smelkov wrote:
> On Tue, Jun 12, 2018 at 05:48:49AM -0400, Jeff King wrote:
> > On Mon, Jun 11, 2018 at 09:43:02AM +0000, Kirill Smelkov wrote:
[...]

> > > I'm not sure, but I would say that `fetch-pack --all` from an empty
> > > repository should not fail and should just give empty output as fetch
> > > does.
> > 
> > Yeah, that seems reasonable to me. The die() that catches this dates
> > back to 2005-era, and we later taught the "fetch" porcelain to handle
> > this. I don't _think_ anybody would be upset that the plumbing learned
> > to treat this as a noop. It's probably a one-liner change in
> > fetch_pack() to return early instead of dying.
> 
> Ok, I will try to send related testcase, and it is indeed easy to find
> - the fix itself.

I started doing it in full with the following

--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1581,6 +1581,8 @@ struct ref *fetch_pack(struct fetch_pack_args *args,

        if (!ref) {
                packet_flush(fd[1]);
+               if (nr_sought == 0)	// XXX or better args->fetch_all
+                       return NULL; /* nothing to fetch */
                die(_("no matching remote head"));
        }
        prepare_shallow_info(&si, shallow);


but then came to the fact that !ref fetch_pack() return is analyzed in 2
places:

- in builtin/fetch-pack.c itself:

        ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
                 &shallow, pack_lockfile_ptr, protocol_v0);

	...

        ret = !ref;

- and in transport.c in fetch_refs_via_pack():

        case protocol_v1:
        case protocol_v0:
                refs = fetch_pack(&args, data->fd, data->conn,
                                  refs_tmp ? refs_tmp : transport->remote_refs,
                                  dest, to_fetch, nr_heads, &data->shallow,
                                  &transport->pack_lockfile, data->version);
                break;

	...

        if (refs == NULL)
                ret = -1;


As I don't know git codebase well-enough I don't see offhand how to
distinguish empty result from a real error when something was requested
and not fetched. If it would be only builtin/fetch-pack I could start to
play ugly games with analyzing too in the calling site args.fetch_all
and nr_though and if at that level we also know we requested nothing,
don't treat !refs as an error.

However with transport.c being there too, since I'm no longer using
`fetch-pack --all`, now it is best for me to not delve into this story
and just stop with attached patch.

Thanks,
Kirill

---- 8< ----
From 76d80ffcfd4574715545c62413d64d40af063d09 Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@nexedi.com>
Date: Wed, 13 Jun 2018 15:46:00 +0300
Subject: [PATCH] fetch-pack: demonstrate --all failure when remote is empty

Currently `fetch-pack --all` from an empty repository gives:

	fatal: no matching remote head

However it would be logical for this fetch operation to succeed with
empty result. Add test showing the failure.

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>

---
 t/t5500-fetch-pack.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 82aee1c2d8..2234bad411 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -528,6 +528,14 @@ test_expect_success 'test --all with tag to non-tip' '
 	)
 '
 
+test_expect_failure 'test --all wrt empty.git' '
+	git init --bare empty.git &&
+	(
+		cd client &&
+		git fetch-pack --all ../empty.git
+	)
+'
+
 test_expect_success 'shallow fetch with tags does not break the repository' '
 	mkdir repo1 &&
 	(
-- 
2.18.0.rc1.253.gf85a566b11.dirty
