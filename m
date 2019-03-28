Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C354920248
	for <e@80x24.org>; Thu, 28 Mar 2019 02:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfC1Cyg (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 22:54:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:38518 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727568AbfC1Cyg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 22:54:36 -0400
Received: (qmail 13728 invoked by uid 109); 28 Mar 2019 02:54:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Mar 2019 02:54:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2296 invoked by uid 111); 28 Mar 2019 02:55:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Mar 2019 22:55:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2019 22:54:34 -0400
Date:   Wed, 27 Mar 2019 22:54:34 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190328025434.GA10032@sigill.intra.peff.net>
References: <20190317194431.GY31362@pobox.com>
 <CAN0heSrajiswzpm+au_5nmZMZG9406iZa-CK9p5CaHLTuxm8nw@mail.gmail.com>
 <20190320181715.GJ31362@pobox.com>
 <CAN0heSpJvsPm_qq63VumokmyOG6N=6fwMZRqf_9CzoCeHsdiyQ@mail.gmail.com>
 <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
 <20190325150633.GC19929@sigill.intra.peff.net>
 <20190325190041.GM4047@pobox.com>
 <20190327010603.GR4047@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190327010603.GR4047@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 09:06:03PM -0400, Todd Zullinger wrote:

> > I updated to asciidoctor-2.0.1 this morning to test, in case
> > it was one of the issues fixed since the 2.0.0 release.
> > Alas, we're the first to hit it and report it.
> 
> Dan Allen fixed this upstream and released 2.0.2 today.
> It's very good to know that asciidoctor upstream is
> incredibly responsive.  If anyone runs into Dan at a
> conference, please buy him a beer. ;)

Cool. I've interacted a few times with the asciidoctor project due to
our use on git-scm.com, and have always found them pleasant and
responsive.

> There's still the matter of 2.0 dropping docbook45.  I'll
> try to get around to testing 1.5.x releases with docbook5 to
> see if they work reasonably well.  If not, we can add a
> version check and set ASCIIDOC_DOCBOOK appropriately.

With the hacky patch below, I was able to doc-diff the v1.5.8 versus
v2.0.2 output. It looks like there are quite a few cosmetic whitespace
changes. Some probably intentional (extra blank between terms and
paragraphs in a definition list) and some probably not (extra whitespace
before start of content in a bulleted list).

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 3355be4798..4c2dccf516 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -17,9 +17,11 @@ f			force rebuild; do not rely on cached results
 c,clean			cleanup temporary working files
 from-asciidoc		use asciidoc with the 'from'-commit
 from-asciidoctor	use asciidoctor with the 'from'-commit
+from-asciidoctor2	use asciidoctor2 with the 'from'-commit
 asciidoc		use asciidoc with both commits
 to-asciidoc		use asciidoc with the 'to'-commit
 to-asciidoctor		use asciidoctor with the 'to'-commit
+to-asciidoctor2		use asciidoctor with the 'to'-commit
 asciidoctor		use asciidoctor with both commits
 cut-header-footer	cut away header and footer
 "
@@ -55,6 +57,10 @@ do
 	--asciidoc)
 		from_program=-asciidoc
 		to_program=-asciidoc ;;
+	--from-asciidoctor2)
+		from_program=-asciidoctor2 ;;
+	--to-asciidoctor2)
+		to_program=-asciidoctor2 ;;
 	--cut-header-footer)
 		cut_header_footer=-cut-header-footer ;;
 	--)
@@ -112,6 +118,13 @@ construct_makemanflags () {
 	elif test "$1" = "-asciidoctor"
 	then
 		echo USE_ASCIIDOCTOR=YesPlease
+	elif test "$1" = "-asciidoctor2"
+	then
+		echo USE_ASCIIDOCTOR=YesPlease
+		echo ASCIIDOC_DOCBOOK=docbook5
+		echo XMLTO_EXTRA=--skip-validation
+		# not really portable :)
+		echo ASCIIDOCTOR=/tmp/run-asciidoctor-2
 	fi
 }
 
@@ -182,6 +195,6 @@ render_tree () {
 	fi
 }
 
-render_tree $from_oid $from_dir $from_makemanflags &&
-render_tree $to_oid $to_dir $to_makemanflags &&
+render_tree $from_oid $from_dir "$from_makemanflags" &&
+render_tree $to_oid $to_dir "$to_makemanflags" &&
 git -C $tmp/rendered diff --no-index "$@" $from_dir $to_dir
