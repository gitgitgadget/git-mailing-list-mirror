Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9184C11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A169D2467B
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="oK29LsTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgBTSth (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:49:37 -0500
Received: from mout.web.de ([212.227.15.14]:41997 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbgBTSth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 13:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582224560;
        bh=J0d3owwcw0vHqLx8qH0cp71nBRq0ZDiFWkrx7BhyAZE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oK29LsTtgfIUp1ciV2A+6WXboQTZE92Vsn7PT2zXUnDuJ8tDloi9bNJOPevJ6bZlu
         2zIGKfXSjQzpeIQ+rN8Hi2PXo1E4vHYA1TyEy4NtfX12qTubyNQsk+2k/newPdm1LR
         xLRGxbfMbsxQFiDnTbL/vKur6AlANZckNqbJyc1I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvf5Q-1jWAIV3Ceq-017Uh0; Thu, 20
 Feb 2020 19:49:19 +0100
Subject: Re: [GSoC][RFC][PATCH 1/2] STRBUF_INIT_CONST: a new way to initialize
 strbuf
To:     Johannes Sixt <j6t@kdbg.org>, Robear Selwans <rwagih.rw@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
References: <20200218041805.10939-1-robear.selwans@outlook.com>
 <20200218041805.10939-2-robear.selwans@outlook.com>
 <467c035f-c7cd-01e1-e64c-2c915610de01@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <113d4221-d7bd-cf0c-ebfc-1fc08442c303@web.de>
Date:   Thu, 20 Feb 2020 19:49:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <467c035f-c7cd-01e1-e64c-2c915610de01@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LyJolI3raar9FDFuB5R6mq5dvHVfoiCirGGPlFm0nUOhMa7EBbo
 MmVFRoIJTuIzZWrQR5s4sEPoSgMvEtdgLi42RatZS2TW90rYF0Bb/hbs9GG/kiTDZomO51Z
 dpiOkPdBOydwUVWu4h4raOwhhs2SBWoSlfoiJ5D37LmMldydejTeGDFGWOBGMOhNkOvCjxL
 UGCyjJUCyElq2lulRMm+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KSHkLnSeK14=:br/kWg9vyHOvIbHsJj204n
 dOKZeiJDq4t91EDnv7+zr3kj5UPVLN1KUeAH0pfsKzcV4RlqkFPS8DH0aObyDqW5Kg6nafZo+
 l8n1P5Av9Kk/gwYy/DH6/oqL9UYDNt7BFfXmDd9KQB7DaihVciouW4mjke6Ffe7Rk8f6ig6uT
 bIFP+l4FkgzZR1Ycuj0Obpr5dQIQBEld8hrMOd+ftk83oIPEQtXSE10V/EL4Yc49Slw59xbpJ
 c9KOsfTwWMylmUyV+3qxONBiJ9CTxy/P18ZJOqgV9spW9lRWZCbY2EjszVPXEq5s8Bl8HvO77
 aNDbCfbTNg5qygaCVSOoH2wLNIeLPd56OB4XHGhZx9FRIqyGOJf0AJ8rhRTPUW1OcpSUAXysD
 OFWnmprUSWYcrMGad0h7Xlm65jZH3OrC0Xh2RwrVtHqTwIDxJZX9PvdtR7HljtIjgtsUimbjT
 j/K3xVpSO+Rpm6KPrJC0S2FlZi/Lp/7A1JJW1/Z1LJNB/VycuTJPIAnIEFCsJe1AypaO+ipBe
 aZYoxeAwoXcKqKyX1QRLnQOTkM5PUnXvuKKjewErVgZTUFr/h3/W9bRCygRTPpBZH7AFyY7Yq
 pfWFVvy9QvJpJ3huwzLL77GrcY+YfoRubk8e3sVmWLyB+ZgIY0Sd8bZL3U4YtAA3e6h4R0hOq
 KgziMCFicq8iqQ2/HkVScuhomFzrIM8eX2qRhFL3xtvS+Y7cti6fqQYa3GvALnR51wA9ffCE6
 zb93VjZBcWA1z9N56dtGMKfPAhTdfiL2HoKqpZnEPGcSHeuS1I7ZxEO8SxJDKtUPs4lgNJN82
 yP/L9xqxZVR5EZ0oeR+drhkS6DpSin2FJ4Lo5EZmfkabvloZ8Gpf0VSSgqAXmIR3w0Bj2J4EO
 ITvzCCXf0PghlrOUXCPZm+p+txrpi9DDW6C4LkdCQYccmtL+A35fVy4XkP+D3PPswkUPCa3rC
 K0D1B2y8/Y173Sdm0w8VfJaWQJkHsYAEtoYXeTzSP6rT3IIETcvb7gj28IeujwUsKUB5S8IyQ
 Ob7Jamm36J7Wxfhy2VvCYndr3j9X3Ei5sT3XF4sEJr2ARCEsXYB4EKwxJLnNUXddNFZKwaEfD
 V/pQaTt9SNPtCQT5n32IayIAFH5oyvGN0MHoOXAOia3PjWMi16RNkDxEkn19U2H80HIbVFcyi
 xAtRHNTsPG8I40IDTAs2dhrJWA4LuljXdupdaenWSslcgJhu4kk9qRr5fNTBMhuXzwEjhFaEg
 qkKkkbgkcYBBUe6Ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.02.20 um 09:13 schrieb Johannes Sixt:
> Am 18.02.20 um 05:18 schrieb Robear Selwans:
>> A new function `STRBUF_INIT_CONST(const_str)` was added to allow for a
>> quick initialization of strbuf.
>>
>> Details:
>> Using `STRBUF_INIT_CONST(str)` creates a new struct of type `strbuf` an=
d
>> initializes its `buf`, `len` and `alloc` as `str`, `strlen(str)` and
>> `0`, respectively.
>>
>> Use Case:
>> This is meant to be used to initialize strbufs with constant values and
>> thus, only allocating memory when needed.
>>
>> Usage Example:
>> ```
>> strbuf env_var =3D STRBUF_INIT_CONST("dev");
>> ```
>>
>> This was added according to the issue opened at [https://github.com/git=
gitgadget/git/issues/398]
>
> I am not a friend of this change at all. Why do so many functions and
> strbuf instances have to pay a price (check for immutable string) for a
> feature that they are not using?
>
> As the macro is just intended for convenience, I suggest to implement it
> using strbuf_addstr() under the hood. That is much less code churn, and
> the price is paid only by the strbufs that actually use the feature.

I was also wondering what the benefits of this change might be.  Saving
one line and thus increasing convenience slightly doesn't justify all
this added complexity.  Saving an allocation in the following sequence
might be worthwhile:

	struct strbuf sb =3D STRBUF_INIT;
	strbuf_addstr(&sb, "foo");
	/* Use sb without modifying it. */
	strbuf_release(&sb); /* or leak it */

I found two examples of this pattern in the code, one in range-diff.c in
the function show_range_diff(), and below is a patch for getting rid of
the second one.  Are there other reasons why we'd want that feature?
Could you perhaps include a patch that makes use of it in this series,
to highlight its benefits?

=2D- >8 --
Subject: [PATCH] commit-graph: use progress title directly

merge_commit_graphs() copies the (translated) progress message into a
strbuf and passes the copy to start_delayed_progress() at each loop
iteration.  The latter function takes a string pointer, so let's avoid
the detour and hand the string to it directly.  That's shorter, simpler
and slightly more efficient.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 commit-graph.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 656dd647d5..f013a84e29 100644
=2D-- a/commit-graph.c
+++ b/commit-graph.c
@@ -1657,19 +1657,15 @@ static void merge_commit_graphs(struct write_commi=
t_graph_context *ctx)
 {
 	struct commit_graph *g =3D ctx->r->objects->commit_graph;
 	uint32_t current_graph_number =3D ctx->num_commit_graphs_before;
-	struct strbuf progress_title =3D STRBUF_INIT;

 	while (g && current_graph_number >=3D ctx->num_commit_graphs_after) {
 		current_graph_number--;

-		if (ctx->report_progress) {
-			strbuf_addstr(&progress_title, _("Merging commit-graph"));
-			ctx->progress =3D start_delayed_progress(progress_title.buf, 0);
-		}
+		if (ctx->report_progress)
+			ctx->progress =3D start_delayed_progress(_("Merging commit-graph"), 0)=
;

 		merge_commit_graph(ctx, g);
 		stop_progress(&ctx->progress);
-		strbuf_release(&progress_title);

 		g =3D g->base_graph;
 	}
=2D-
2.25.1
