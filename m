Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0091F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF0W1e (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:27:34 -0400
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:50796 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726445AbfF0W1e (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jun 2019 18:27:34 -0400
Received: from resomta-ch2-15v.sys.comcast.net ([69.252.207.111])
        by resqmta-ch2-09v.sys.comcast.net with ESMTP
        id gcrLhIvfzViXOgcrdhKCeD; Thu, 27 Jun 2019 22:27:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1561674453;
        bh=+BZmbZgecYhB37HPIhpTvIcaCh//eAKXuPwNV8WSZao=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=4ZfOj4tm8T0tSmjZLEMCGMIBoZ3zIA1SracOBhd9v+VWcWIoZQLOOVhaf06O2WHwT
         46+idTEYCyeI96cMd39LGyvncSmrXpugGez9VMaxYCmo4qz9XyRXQpzap5WVkdRBC2
         5ksNJy4K+EA2Gx7xqYQt+scB+m2yUQYDGK99p+Y9yR1Fx+ozU35nbIy5+oRUw3Tdbm
         v57TTQEtDgigRQFVP1rWy5y6wanDEmgRtDklrkgstj210jtPXDb4ZY0C5NEJjG0eHT
         i4wNcr8zUwncPrE6F91Mn2Sw5XvVgcVLUIBmEruXyvmyfWYGWVQWHR/wlzDQ/sY5FT
         k9EqAG524LhXg==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:5954:f056:f8d3:3ba7])
        by resomta-ch2-15v.sys.comcast.net with ESMTPSA
        id gcrOhpDjc28YJgcrTh6vkH; Thu, 27 Jun 2019 22:27:31 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Thu, 27 Jun 2019 15:27:18 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org
Subject: Re: [PATCH v4 10/10] list-objects-filter-options: make parser void
Message-ID: <20190627222717.GE54617@comcast.net>
References: <2f7566f697be759614a04c1277194f974bdcd662.1560558910.git.matvore@google.com>
 <20190622004631.251573-1-jonathantanmy@google.com>
 <20190627212457.GD54617@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627212457.GD54617@comcast.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 02:24:57PM -0700, Matthew DeVore wrote:
> Great. I feel much better about the comments and commit messages now. I
> am about to send a roll-up (v5). Here is the interdiff which catches
> your comments and Dscho's comment about strbuf_addstr:
> 
> <snip>

Forgot to make a string localizable. Add this to the prior interdiff:

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 9e64832a5e..ba1425cb4a 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -96,23 +96,24 @@ static int gently_parse_list_objects_filter(
 }
 
 static const char *RESERVED_NON_WS = "~`!@#$^&*()[]{}\\;'\",<>?";
 
 static int has_reserved_character(
 	struct strbuf *sub_spec, struct strbuf *errbuf)
 {
 	const char *c = sub_spec->buf;
 	while (*c) {
 		if (*c <= ' ' || strchr(RESERVED_NON_WS, *c)) {
-			strbuf_addf(errbuf,
-				    "must escape char in sub-filter-spec: '%c'",
-				    *c);
+			strbuf_addf(
+				errbuf,
+				_("must escape char in sub-filter-spec: '%c'"),
+				*c);
 			return 1;
 		}
 		c++;
 	}
 
 	return 0;
 }
 
 static int parse_combine_subfilter(
 	struct list_objects_filter_options *filter_options,
