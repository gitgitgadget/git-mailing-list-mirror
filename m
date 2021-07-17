Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DEAC636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F745613DA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhGQCHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 22:07:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:52566 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhGQCHn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 22:07:43 -0400
Received: (qmail 22570 invoked by uid 109); 17 Jul 2021 02:04:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jul 2021 02:04:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16375 invoked by uid 111); 17 Jul 2021 02:04:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 22:04:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 22:04:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 06/11] refs API: pass the "lock OID" to reflog
 "prepare"
Message-ID: <YPI6v9BffiXc2TUj@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <patch-06.11-e93465f4137-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-06.11-e93465f4137-20210716T140631Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 04:13:02PM +0200, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 09541d1c804..9f9e6bceb03 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -351,7 +351,7 @@ static int is_head(const char *refname)
>  }
>  
>  static void reflog_expiry_prepare(const char *refname,
> -				  const struct object_id *oid,
> +				  struct object_id *locked_oid,
>  				  void *cb_data)
>  {

>  	struct expire_reflog_policy_cb *cb = cb_data;
> @@ -361,7 +361,7 @@ static void reflog_expiry_prepare(const char *refname,
>  		cb->unreachable_expire_kind = UE_HEAD;
>  	} else {
>  		cb->tip_commit = lookup_commit_reference_gently(the_repository,
> -								oid, 1);
> +								locked_oid, 1);
>  		if (!cb->tip_commit)
>  			cb->unreachable_expire_kind = UE_ALWAYS;
>  		else

This drops "const" from the parameter (also below). I guess this is part
of the preparation for making these functions do the locking. I'll read
on...

-Peff
