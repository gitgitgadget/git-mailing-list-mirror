Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7B820401
	for <e@80x24.org>; Sat, 24 Jun 2017 14:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdFXOMU (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 10:12:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:51886 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751055AbdFXOMT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 10:12:19 -0400
Received: (qmail 6887 invoked by uid 109); 24 Jun 2017 14:12:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 14:12:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23981 invoked by uid 111); 24 Jun 2017 14:12:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 10:12:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 10:12:17 -0400
Date:   Sat, 24 Jun 2017 10:12:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] sha1_name: cache readdir(3) results in
 find_short_object_filename()
Message-ID: <20170624141217.oj3nnzycn6bsilzo@sigill.intra.peff.net>
References: <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
 <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net>
 <xmqqd1a0vb2t.fsf@gitster.mtv.corp.google.com>
 <d06fb033-294e-f364-3dde-394624e83cd6@web.de>
 <20170622231041.2zdjypviwmndjnsb@sigill.intra.peff.net>
 <97a8def3-d2ed-9212-4d87-8767de6f2695@web.de>
 <20170624122057.ndmlsa7e7dksejg3@sigill.intra.peff.net>
 <03dc365d-41f7-dbe7-3c22-bdeee77a817c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03dc365d-41f7-dbe7-3c22-bdeee77a817c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 04:09:39PM +0200, René Scharfe wrote:

> Am 24.06.2017 um 14:20 schrieb Jeff King:
> > On Sat, Jun 24, 2017 at 02:12:30PM +0200, René Scharfe wrote:
> > 
> >>> That's redundant with "subdir_nr". Should we push that logic down into
> >>> the function, and basically do:
> >>>
> >>>     if (subdir_nr < 0 || subdir_nr > 256)
> >>> 	BUG("object subdir number out of range");
> >>
> >> Hmm.  I don't expect many more callers, so do we really need this safety
> >> check?  It's cheap compared to the readdir(3) call, of course.
> > 
> > To me it's as much about documenting the assumptions as it is about
> > catching buggy callers. I'd be OK with a comment, too.
> 
> I didn't catch the off-by-one error above in the first reading.  Did you
> add it intentionally? ;-)  In any case, I'm convinced now that we need
> such a check, but with hexadecimal notation to avoid such mistakes.

Err...yeah, it was totally intentional. ;)

I agree writing it in hex is better.

> -- >8 --
> Subject: [PATCH] sha1_file: guard against invalid loose subdirectory numbers
> 
> Loose object subdirectories have hexadecimal names based on the first
> byte of the hash of contained objects, thus their numerical
> representation can range from 0 (0x00) to 255 (0xff).  Change the type
> of the corresponding variable in for_each_file_in_obj_subdir() and
> associated callback functions to unsigned int and add a range check.
> 
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

This looks great. Thanks.

-Peff
