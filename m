Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 002541F576
	for <e@80x24.org>; Tue, 23 Jan 2018 10:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeAWK0B (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 05:26:01 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:48129 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbeAWK0A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 05:26:00 -0500
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Tue, 23 Jan 2018 11:26:09 +0100
  id 00000000000000CA.000000005A670DC1.0000230F
Date:   Tue, 23 Jan 2018 11:25:58 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 5/6] convert: add 'working-tree-encoding' attribute
Message-ID: <20180123102558.GA3878@ruderich.org>
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
 <20180120152418.52859-6-lars.schneider@autodesk.com>
 <20180121142222.GA10248@ruderich.org>
 <05265803-BD74-4667-ABB5-9752E55A5015@gmail.com>
 <20180123005401.GG26357@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20180123005401.GG26357@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 07:54:01PM -0500, Jeff King wrote:
> But anyway, that was a bit of a tangent. Certainly the smaller change is
> just standardizing on sizeof(*foo), which I think most people agree on
> at this point. It might be worth putting in CodingGuidelines.

Personally I prefer sizeof(*foo) which is a well non-idiom, used
in many projects and IMHO easy to read and understand.

I've played a little with coccinelle and the following spatch
seems to catch many occurrences of sizeof(struct ..) (the first
hunk seems to expand multiple times causing conflicts in the
generated patch). Cases like a->b = xcalloc() are not matched, I
don't know enough coccinelle for that. If there's interest I
could prepare patches, but it will create quite some code churn.

Regards
Simon

@@
type T;
identifier x;
@@
- T *x = xmalloc(sizeof(T));
+ T *x = xmalloc(sizeof(*x));

@@
type T;
T *x;
@@
- x = xmalloc(sizeof(T));
+ x = xmalloc(sizeof(*x));


@@
type T;
identifier x;
expression n;
@@
- T *x = xcalloc(n, sizeof(T));
+ T *x = xcalloc(n, sizeof(*x));

@@
type T;
T *x;
expression n;
@@
- x = xcalloc(n, sizeof(T));
+ x = xcalloc(n, sizeof(*x));


@@
type T;
T x;
@@
- memset(&x, 0, sizeof(T));
+ memset(&x, 0, sizeof(x));

@@
type T;
T *x;
@@
- memset(x, 0, sizeof(T));
+ memset(x, 0, sizeof(*x));

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
