Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30B81F462
	for <e@80x24.org>; Tue,  4 Jun 2019 22:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfFDW74 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 18:59:56 -0400
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:39914 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfFDW7z (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2019 18:59:55 -0400
Received: from resomta-po-12v.sys.comcast.net ([96.114.154.236])
        by resqmta-po-08v.sys.comcast.net with ESMTP
        id YHgkhELVlFpWYYIPKhZQz0; Tue, 04 Jun 2019 22:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559689194;
        bh=3jbdPvkEhWzoDMnELw/5PW2CgIwheMabblWe7GS6Qzs=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=ib4PoHROW9SZ3TF5B6chLuGN4j/a5za7o7nkCFMnSPkc/FAUzF5KoiHVRvYvuT+d6
         e29s3HR5Q61vHFdvO++IeIzq0KpD8tSBczoo4gwy4IlY+AeNQ08XPyXJHa8v3XIfed
         KQxdlEj/fFPeIcorTy3ILUR8wUMv8I1+wVRnJcdSjJx3jIu0lzq9dzOJFPwzehS4l9
         fyzl/5YKSfdGMw0QzzaiWDc/NqBSvQLjO9G67iaNjR+NDceheDXZaMAmA7BBf2PQEo
         FLYzROslBxwJdPUQlYrPrwuf0gg1o5I2gT7xqTo8LG7+WVGN9ORepfR++GipRmCytF
         1SYyWwUrCNGnA==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:414a:968a:2dbf:4ae5])
        by resomta-po-12v.sys.comcast.net with ESMTPSA
        id YIOnhb3nUT55RYIOwhVG4c; Tue, 04 Jun 2019 22:59:52 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Tue, 4 Jun 2019 15:59:21 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190604225921.GA43275@comcast.net>
References: <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <20190528215359.GB133078@google.com>
 <20190531204821.GC4641@comcast.net>
 <20190531211041.GA19792@sigill.intra.peff.net>
 <20190601001231.GF4641@comcast.net>
 <20190603123435.GA18953@sigill.intra.peff.net>
 <20190603222247.GG4641@comcast.net>
 <20190604161332.GA29603@sigill.intra.peff.net>
 <20190604171952.GI4641@comcast.net>
 <20190604185108.GA14738@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604185108.GA14738@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 02:51:08PM -0400, Jeff King wrote:
> > The purpose of has_reserved_character is to allow for future
> > extensibility if someone decides to implement a more sophisticated DSL
> > and give meaning to these characters. That may be a long-shot, but it
> > seems worth it.
> 
> I think you'll find that -Wunused-function complains, though, if nobody
> is calling it. I wasn't sure if what you showed in the interdiff was
> meant to be final (I had to add a few other variable declarations to
> make it compile, too).

Sorry, my last interdiff was a mess because I made a mistake during git rebase
-i. It was missing a call to has_reserved_char. Below is another diff that
fixes the problems:

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 0f135602a7..6b206dc58b 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -110,28 +110,31 @@ static int has_reserved_character(
 
 	return 0;
 }
 
 static int parse_combine_subfilter(
 	struct list_objects_filter_options *filter_options,
 	struct strbuf *subspec,
 	struct strbuf *errbuf)
 {
 	size_t new_index = filter_options->sub_nr;
+	char *decoded;
+	int result;
 
 	ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 		      filter_options->sub_alloc);
 
 	decoded = url_percent_decode(subspec->buf);
 
-	result = gently_parse_list_objects_filter(
-		&filter_options->sub[new_index], decoded, errbuf);
+	result = has_reserved_character(subspec, errbuf) ||
+		gently_parse_list_objects_filter(
+			&filter_options->sub[new_index], decoded, errbuf);
 
 	free(decoded);
 	return result;
 }
 
 static int parse_combine_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
 {

> > strbuf_addstr_urlencode will either escape or not escape all rfc3986
> > reserved characters, and that set includes both : and +. The former
> > should not require escaping since it's a common character in filter
> > specs, and I would like the hand-encoded combine specs to be relatively
> > easy to type and read. The + must be escaped since it is used as part of
> > the combine:... syntax to delimit sub filters. So
> > strbuf_addstr_url_encode would have to be more customizable to make it
> > work for this context. I'd like to add a parameterizable should_escape
> > predicate (iow function pointer) which strbuf_addstr_urlencode accepts.
> > I actually think this will be more readable than the current strbuf API.
> 
> That makes some sense, and I agree that readability is a good goal. Do
> we not need to be escaping colons in other URLs? Or are the strings
> you're generating not true by-the-book URLs? I'm just wondering if we
> could take this opportunity to improve the URLs we output elsewhere,
> too.

The strings I'm generating are not URLs. Also, in http.c, we have to use : to
delimit a username and password:

	strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
	strbuf_addch(&s, ':');
	strbuf_addstr_urlencode(&s, proxy_auth.password, 1);

I think this is dictated by libcurl and is not flexible.
