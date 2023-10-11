Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D082CDB47C
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjJKTCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjJKTCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:02:16 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA793
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:02:14 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77433e7a876so11085485a.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697050933; x=1697655733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obSPdRXn2jGlu1vDv5f5Y0/9SOA+DGahdpg4DXdW9j4=;
        b=Qw2+qul3Dg2mlANri64e4IInNAI5KfOPB1+jucWQhlXwBEyV2xQ0IARxZDlbGSygR0
         ZBPf6ssvZmT5o40AE889cBu/nXqLtZaoVt26peUDbScg0OR/zZZ0fe4h0kJY2VyaWOxI
         QQyRdsAg4FRgna8en5FuhjrGMJQc1mdXxbhVbUJ3HWOech+wWZ3HfL+ikcyxolOilHkW
         sG/kGF9H0qyjkzwYMF2woQuvydP7SWYWKqqgpfHE96TFxRnLkMdC1Ms83Tdty/tmbBui
         67sTVV2fo9bs9VzUohOVa/7Vhf245mpjdteBj+I9mY4I9WnZe89mZnDCkporHh9ueKrg
         SAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050933; x=1697655733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obSPdRXn2jGlu1vDv5f5Y0/9SOA+DGahdpg4DXdW9j4=;
        b=BhwtCtFIjk3SAOK2XbpRUM2gn/ARoa5YdeV5b2tc905yAWIMMfhyFOfWemn+Xa0MNk
         VbM5P3dOj3hsLkPKS4dzq6oGmhzs9MD7WYPFW59p4MZ6MlcEoTwf7/AfOSDtRvjU8LwG
         gySMQgsiex/jMtDt66riCTewQ0/olamfnl0pr68HutdeaR6jqGnNHQjsynv0d7y7LDdj
         b13SzZFZzCK8bOuS8GvnfrE9o5Int9IWZrONbAZm2U8Wiq92Vc2ejziGAJL9TiYpIYt2
         1T+epcJJPIIKu/qmv14UlzSqRtxA68Lp5SYPAg1j2TJT3XgkmrvTpD7AWPCAn+9QK6kZ
         CfhA==
X-Gm-Message-State: AOJu0YzY7XmiAsv/Ab0C+TM4mw+pvLwOP0r6+dIYPcImCGnwjvL6SE4f
        f0lCmewGb7aMaCOr9dPSJYRV7iP3mMktcK5ZQwn7cQ==
X-Google-Smtp-Source: AGHT+IGFlWQPcU1snB6CwIHwCj/0CTnM5JnyHUmXkneIO6HmbRgKDRpQHEFZo1KMk7QcqpG5rhxmMw==
X-Received: by 2002:a05:620a:2953:b0:774:1e8a:3182 with SMTP id n19-20020a05620a295300b007741e8a3182mr24831310qkp.26.1697050933540;
        Wed, 11 Oct 2023 12:02:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k11-20020ac8478b000000b00410a9dd3d88sm5504695qtq.68.2023.10.11.12.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:02:13 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:02:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 13/20] commit-graph: detect out-of-bounds extra-edges
 pointers
Message-ID: <ZSbxM1XEy/n8/8lY@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210538.GM3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210538.GM3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:38PM -0400, Jeff King wrote:
> ---
>  commit-graph.c          | 20 ++++++++++++++------
>  commit-graph.h          |  1 +
>  t/t5318-commit-graph.sh |  8 ++++++++
>  3 files changed, 23 insertions(+), 6 deletions(-)

All looks good here, and the proposed log message is very clear and
well-written. One minor note below...
> @@ -931,14 +932,21 @@ static int fill_commit_in_graph(struct repository *r,
>  		return 1;
>  	}
>
> -	parent_data_ptr = (uint32_t*)(g->chunk_extra_edges +
> -			  st_mult(4, edge_value & GRAPH_EDGE_LAST_MASK));
> +	parent_data_pos = edge_value & GRAPH_EDGE_LAST_MASK;
>  	do {
> -		edge_value = get_be32(parent_data_ptr);
> +		if (g->chunk_extra_edges_size / sizeof(uint32_t) <= parent_data_pos) {
> +			error("commit-graph extra-edges pointer out of bounds");

It might be nice to add some extra data here, too, like which commit OID
we were trying to load, the offset we were supposed to read at, and the
size of the extra edges chunk itself.

We should probably also mark this string for translation, but both are
minor points.

Thanks,
Taylor
