Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA7C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FF561152
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhGMVDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:03:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:48244 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhGMVDE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 17:03:04 -0400
Received: (qmail 11828 invoked by uid 109); 13 Jul 2021 21:00:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 21:00:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14001 invoked by uid 111); 13 Jul 2021 21:00:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 17:00:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 17:00:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] tests: migrate to "test-tool pkt-line"
Message-ID: <YO3+3F5fRONVtqTI@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
 <xmqqpmvn2rkm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpmvn2rkm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 01:41:13PM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > This series is marked for "will merge to next" already, but not there
> > yet. A trivial v2 whitespace fix in case Junio's in time to pick it
> > up.
> >
> > See v1 at https://lore.kernel.org/git/cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com/
> >
> > Ævar Arnfjörð Bjarmason (5):
> >   serve tests: add missing "extra delim" test
> >   serve tests: use test_cmp in "protocol violations" test
> >   tests: replace [de]packetize() shell+perl test-tool pkt-line
> >   tests: replace remaining packetize() with "test-tool pkt-line"
> >   test-lib-functions.sh: remove unused [de]packetize() functions
> >
> >  t/helper/test-pkt-line.c               | 12 +++++
> >  t/t5410-receive-pack-alternates.sh     | 42 +++++++++++++-----
> >  t/t5411/once-0010-report-status-v1.sh  | 12 ++---
> >  t/t5500-fetch-pack.sh                  | 15 ++++---
> >  t/t5530-upload-pack-error.sh           | 24 +++++-----
> >  t/t5562-http-backend-content-length.sh | 16 ++++---
> >  t/t5570-git-daemon.sh                  | 22 ++++++----
> >  t/t5704-protocol-violations.sh         | 61 ++++++++++++++++++--------
> >  t/test-lib-functions.sh                | 42 ------------------
> >  9 files changed, 135 insertions(+), 111 deletions(-)
> >
> > Range-diff against v1:
> > 1:  fcb53980597 = 1:  67aa8141153 serve tests: add missing "extra delim" test
> > 2:  c3544fb53cd = 2:  64dfd14865c serve tests: use test_cmp in "protocol violations" test
> > 3:  c1015fa6ab0 = 3:  c33f344ab20 tests: replace [de]packetize() shell+perl test-tool pkt-line
> > 4:  ab23513b48b ! 4:  a44e1790f2a tests: replace remaining packetize() with "test-tool pkt-line"
> >     @@ t/helper/test-pkt-line.c: static void pack(int argc, const char **argv)
> >       
> >      +static void pack_raw_stdin(void)
> >      +{
> >     -+
> >      +	struct strbuf sb = STRBUF_INIT;
> >      +	strbuf_read(&sb, 0, 0);
> >      +	if (strbuf_read(&sb, 0, 0) < 0)
> > 5:  2d22b83971a = 5:  cc91d15ef70 test-lib-functions.sh: remove unused [de]packetize() functions
> 
> Well, if you care that much, I'd prefer to also see an blank line
> between the end of decl and the first statement.

I was offline last week and hadn't had a chance to look until today. I
did find a few things. Mostly style nits that could potentially be
ignored, but two small "correctness" things that somehow manage to not
cause any test failures. :)

-Peff
