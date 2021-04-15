Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ACFC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F345B61264
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhDOJFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:05:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:53136 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhDOJFl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 05:05:41 -0400
Received: (qmail 9697 invoked by uid 109); 15 Apr 2021 09:05:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 09:05:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14326 invoked by uid 111); 15 Apr 2021 09:05:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 05:05:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 05:05:17 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     rafaeloliveira.cs@gmail.com, git@vger.kernel.org,
        szeder.dev@gmail.com
Subject: Re: [PATCH 2/2] repack: avoid loosening promisor pack objects in
 partial clones
Message-ID: <YHgBze9V7kq/TkqU@coredump.intra.peff.net>
References: <20210414191403.4387-3-rafaeloliveira.cs@gmail.com>
 <20210415010454.4077355-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210415010454.4077355-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 06:04:54PM -0700, Jonathan Tan wrote:

> > @@ -576,6 +577,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
> >  		repack_promisor_objects(&po_args, &names);
> >  
> >  		if (existing_packs.nr && delete_redundant) {
> > +			for_each_string_list_item(item, &names) {
> > +				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
> > +					     packtmp_name, item->string);
> > +			}
> 
> Git style is to not have braces for single-statement loops.

It is, though given that for_each_string_list_item() is a weird macro
instead of a regular for-loop, IMHO it makes things more obvious to have
the braces.

(All the rest of your comments seemed quite good to me).

-Peff
