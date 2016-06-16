Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F201FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 20:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbcFPUzy (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 16:55:54 -0400
Received: from kitenet.net ([66.228.36.95]:45632 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238AbcFPUzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 16:55:54 -0400
Received: by kitenet.net (Postfix, from userid 1000)
	id 525E01C5B6; Thu, 16 Jun 2016 16:55:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466110553; bh=Y/PWFE/2XOC0Q4a7BQgeDm6f4fe2N1wPruBDET/gQlE=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=k5r4LUjJAfHWfze0uUptl8f7rekgwnWwjmGa/Bnlnbwt6+ESq7lc0tPCGWVtPeVy2
	 oD7mHm+z/jYlLorqdKY17xSheY2zjObWKVecqBWP35qisEFrjzF3IoIVUFuAgqMEO4
	 dDUl5Zt59EWKnHxzHk5C4hXgyfnPo43V/s7Z6FNQ=
Date:	Thu, 16 Jun 2016 16:55:53 -0400
From:	Joey Hess <id@joeyh.name>
To:	git@vger.kernel.org
Subject: Re: [PATCH 4/4] use smudge-to-file in git checkout etc
Message-ID: <20160616205553.GA23176@kitenet.net>
References: <20160616203259.5886-1-joeyh@joeyh.name>
 <20160616203259.5886-5-joeyh@joeyh.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160616203259.5886-5-joeyh@joeyh.name>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess wrote:
> +		int smudge_to_file = can_smudge_to_file(ce->name);
>  		if (ce_mode_s_ifmt == S_IFREG &&
> +		    ! smudge_to_file &&
>  		    convert_to_working_tree(ce->name, new, size, &buf)) {
>  			free(new);
>  			new = strbuf_detach(&buf, &newsize);
> @@ -189,13 +193,29 @@ static int write_entry(struct cache_entry *ce,

> +		if (! can_smudge_to_file(ce->name)) {
> +		}
> +		else {
> +			close(fd);
> +			convert_to_working_tree_filter_to_file(ce->name, path, new, size);

Oops, I had meant to avoid using smudge-to-file when
e_mode_s_ifmt != S_IFREG, and forgot it in this patch, so it does the
wrong thing for symlinks.

I'll send an updated patch set fixing this after any other review.

-- 
see shy jo
