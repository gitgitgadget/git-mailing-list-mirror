Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA70C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 13:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJKNYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJKNYV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 09:24:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7FBC0E
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:24:17 -0700 (PDT)
Received: (qmail 32331 invoked by uid 109); 11 Oct 2022 13:24:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 13:24:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22354 invoked by uid 111); 11 Oct 2022 13:24:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Oct 2022 09:24:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Oct 2022 09:24:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 3/7] shortlog: extract `--group` fragment for translation
Message-ID: <Y0Vuf2quUoypZyws@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <c3f50465cba4430b2014a76c5e473b906db50059.1665448437.git.me@ttaylorr.com>
 <221011.867d16pr0n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221011.867d16pr0n.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2022 at 12:55:10PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >  	case SHORTLOG_GROUP_TRAILER:
> > -		die(_("using --group=trailer with stdin is not supported"));
> > +		die(_("using %s with stdin is not supported"), "--group=trailer");
> >  	default:
> >  		BUG("unhandled shortlog group");
> >  	}
> 
> Rather than add another translation that you can use in 2x places here
> (with 4/7) instead do:
> 
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 7a1e1fe7c0e..59aef24f637 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -132,7 +132,8 @@ static void read_from_stdin(struct shortlog *log)
>  		match = committer_match;
>  		break;
>  	case SHORTLOG_GROUP_TRAILER:
> -		die(_("using --group=trailer with stdin is not supported"));
> +		die(_("options '%s' and '%s' cannot be used together"),
> +		    "--group=<trailer>", "--stdin");
>  	default:
>  		BUG("unhandled shortlog group");
>  	}

It's not usually --stdin, though. Generally you'd just not provide any
revisions to traverse, and it defaults to stdin. So "with stdin" is IMHO
a more accurate message, as it covers all of the cases.

-Peff
