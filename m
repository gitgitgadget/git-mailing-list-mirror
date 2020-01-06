Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA928C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C8A207FF
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgAFVRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:17:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:58226 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726683AbgAFVRc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 16:17:32 -0500
Received: (qmail 3178 invoked by uid 109); 6 Jan 2020 21:17:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Jan 2020 21:17:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25141 invoked by uid 111); 6 Jan 2020 21:23:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2020 16:23:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Jan 2020 16:17:30 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2] sha1-file: remove OBJECT_INFO_SKIP_CACHED
Message-ID: <20200106211730.GB980197@coredump.intra.peff.net>
References: <20191230211027.37002-1-jonathantanmy@google.com>
 <20200102201630.180969-1-jonathantanmy@google.com>
 <20200104001331.GA130883@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200104001331.GA130883@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 03, 2020 at 04:13:31PM -0800, Jonathan Nieder wrote:

> To follow up on Junio's hint in his review: callers can inject
> additional cached objects by using pretend_object_file.  Junio
> described how this would make sense as a mechanism for building
> the virtual ancestor object, but we don't do that.  In fact, the
> only caller is fake_working_tree_commit in "git blame", a read-only
> code path. *phew*
> 
> -- >8 --
> Subject: sha1-file: document how to use pretend_object_file
> [...]
> +/*
> + * Add an object file to the in-memory object store, without writing it
> + * to disk.
> + *
> + * Callers are responsible for calling write_object_file to record the
> + * object in persistent storage before writing any other new objects
> + * that reference it.
> + */
>  int pretend_object_file(void *, unsigned long, enum object_type,
>  			struct object_id *oid);
>  

I think this is an improvement over the status quo, but it's still a
potential trap for code which happens to run in the same process (see my
other email in the thread).

Should the message perhaps be even more scary?

-Peff
