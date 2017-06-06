Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F179B20D09
	for <e@80x24.org>; Tue,  6 Jun 2017 19:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbdFFTBO (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 15:01:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:35547 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdFFTBN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 15:01:13 -0400
Received: (qmail 22390 invoked by uid 109); 6 Jun 2017 19:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 19:01:12 +0000
Received: (qmail 26831 invoked by uid 111); 6 Jun 2017 19:01:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jun 2017 15:01:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jun 2017 15:01:11 -0400
Date:   Tue, 6 Jun 2017 15:01:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>
Subject: [PATCH] sha1dc: ignore indent-with-non-tab whitespace violations
Message-ID: <20170606190111.xm4nzvjhbpsw3qbg@sigill.intra.peff.net>
References: <20170606124323.GD25777@dinwoodie.org>
 <20170606151231.25172-1-avarab@gmail.com>
 <CAGZ79kaaRsUBAxRKLPxjuk=oRrw2zBdoHWd9iNDmTbY9MpqN-w@mail.gmail.com>
 <CACBZZX485+W99mRspDTf09LjP-C26PaAi+vNSBkW_aVyXAsQJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX485+W99mRspDTf09LjP-C26PaAi+vNSBkW_aVyXAsQJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 06, 2017 at 08:51:35PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Jun 6, 2017 at 8:23 PM, Stefan Beller <sbeller@google.com> wrote:
> > On Tue, Jun 6, 2017 at 8:12 AM, Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
> >> This updates sha1dc fixing the issue on Cygwin introduced in 2.13.1,
> >> and hopefully not regressing elsewhere. Liam, it would be much
> >> appreciated if you could test this on SPARC.
> >>
> >> As before the "sha1dc: update from upstream" patch is what should
> >> fast-track to master/maint and be in 2.13.2, the other two are the
> >> cooking submodule use, that's all unchanged aside from of course the
> >> submodule pointing to the same upstream commit as the code import
> >> itself does.
> >>
> >> Junio: There's a whitespace change to sha1.h that am warns about, but
> >> which it applies anyway that you didn't apply from my previous
> >> patch. I think it probably makes sense to just take upstream's
> >> whitespace shenanigans as-is instead of seeing that diff every time we
> >> update. I guess we could also send them a pull request...
> >
> > I would suggest the pull request.
> 
> Looking at this again it's not a bug, just upstream choosing to indent
> a comment with spaces, not a bug.
> 
> So it makes sense to just apply as-is so we don't have that diff with
> them / different sha1s on the files etc.

Agreed. Maybe we'd also want this patch:

-- >8 --
Subject: sha1dc: ignore indent-with-non-tab whitespace violations

The upstream sha1dc code indents some lines with spaces.
While this doesn't match Git's coding guidelines, it's better
to leave this imported code untouched than to try to make it
match our style. However, we can use .gitattributes to tell
"diff --check" and "git am" not to bother us about it.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1dc/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 sha1dc/.gitattributes

diff --git a/sha1dc/.gitattributes b/sha1dc/.gitattributes
new file mode 100644
index 000000000..da53f4054
--- /dev/null
+++ b/sha1dc/.gitattributes
@@ -0,0 +1 @@
+* whitespace=-indent-with-non-tab
-- 
2.13.1.664.g1b5a21ec3

