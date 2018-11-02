Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1321F453
	for <e@80x24.org>; Fri,  2 Nov 2018 20:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbeKCFYY (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 01:24:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:38612 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725957AbeKCFYY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 01:24:24 -0400
Received: (qmail 32187 invoked by uid 109); 2 Nov 2018 20:15:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 20:15:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7976 invoked by uid 111); 2 Nov 2018 20:15:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 16:15:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 16:15:49 -0400
Date:   Fri, 2 Nov 2018 16:15:49 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 3/9] diff: avoid generating unused hunk header lines
Message-ID: <20181102201549.GA17228@sigill.intra.peff.net>
References: <20181102063156.GA30252@sigill.intra.peff.net>
 <20181102063606.GC31216@sigill.intra.peff.net>
 <CAGZ79kZb7kMhkE=EWRtR8tpkQCY3v8rWugHvq24TFGHpBxmygw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZb7kMhkE=EWRtR8tpkQCY3v8rWugHvq24TFGHpBxmygw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 02, 2018 at 12:50:05PM -0700, Stefan Beller wrote:

> > +/*
> > + * Can be used as a no-op hunk_fn for xdi_diff_outf(), since a NULL
> > + * one just sends the hunk line to the line_fn callback).
> > + */
> > +void discard_hunk_line(void *, long, long, long, long, const char *, long);
> 
> Recently we had the discussion on style and naming things.
> On the one hand I don't know what these 4 different longs do,
> so I'd wish for some descriptive variable names in here.
> On the other hand the docs explain clearly why I don't need
> to care (a no-op ignores all of the parameters, no need
> to take care of their order)

Right, I actually did have the same thought while writing it. And ended
up following that line of reasoning (since it's just a placeholder, it
doesn't matter).  But I'm not opposed to putting in the names.

> So to revive that discussion, I would strongly prefer
> to have *some* names there, for the sake of a
> simply described coding style without many exceptions
> (especially those exceptions that rely on judgement).

Fair enough.

Squashable patch is below; it goes on 34c829621e (diff: avoid generating
unused hunk header lines, 2018-11-02).

Junio, let me know if you'd prefer a re-send of the series, but it
doesn't look necessary otherwise (so far).

> Apart from that, I read the whole series, and found
> it a pleasant read.

Thanks!

diff --git a/xdiff-interface.h b/xdiff-interface.h
index 7b0ccbdd1d..8af245eed9 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -39,7 +39,9 @@ extern int git_xmerge_style;
  * Can be used as a no-op hunk_fn for xdi_diff_outf(), since a NULL
  * one just sends the hunk line to the line_fn callback).
  */
-void discard_hunk_line(void *, long, long, long, long, const char *, long);
+void discard_hunk_line(void *priv,
+		       long ob, long on, long nb, long nn,
+		       const char *func, long funclen);
 
 /*
  * Compare the strings l1 with l2 which are of size s1 and s2 respectively.

-Peff
