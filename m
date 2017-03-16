Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4987620323
	for <e@80x24.org>; Thu, 16 Mar 2017 15:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754467AbdCPPLN (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 11:11:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:45136 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbdCPOcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 10:32:46 -0400
Received: (qmail 5012 invoked by uid 109); 16 Mar 2017 14:31:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 14:31:55 +0000
Received: (qmail 24998 invoked by uid 111); 16 Mar 2017 14:32:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 10:32:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 10:31:52 -0400
Date:   Thu, 16 Mar 2017 10:31:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] sha1_file.c: make pack-name helper globally
 accessible
Message-ID: <20170316143152.gdeaprlsercvwmiw@sigill.intra.peff.net>
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
 <20170316142706.kt56a43phiuhhra7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316142706.kt56a43phiuhhra7@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 10:27:06AM -0400, Jeff King wrote:

> -/*
> - * Return the name of the pack or index file with the specified sha1
> - * in its filename.  *base and *name are scratch space that must be
> - * provided by the caller.  which should be "pack" or "idx".
> - */
> -static char *sha1_get_pack_name(const unsigned char *sha1,
> -				struct strbuf *buf,
> -				const char *which)
> + char *odb_pack_name(struct strbuf *buf,
> +		     const unsigned char *sha1,
> +		     const char *ext)
>  {
>  	strbuf_reset(buf);
>  	strbuf_addf(buf, "%s/pack/pack-%s.%s", get_object_directory(),
> -		    sha1_to_hex(sha1), which);
> +		    sha1_to_hex(sha1), ext);
>  	return buf->buf;
>  }

Incidentally, this entire function could be implemented as:

  return git_path_buf(buf, "objects/pack/pack-%s.%s",
                      sha1_to_hex(sha1), ext);

as the git_path() functions are smart enough to replace "objects/" with
the true object directory when necessary. I don't know if people find
that more or less readable. Since it's buried in a helper function, I
doubt it matters much either way. The git_path functions do also do some
path normalization, which might be of value.

-Peff
