Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B25AC433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770EB20663
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 23:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pK8YTN1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgFAXUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgFAXUe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 19:20:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22E0C05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 16:20:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y7so14684041ybj.15
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bj69sOXrJpc7fsJ96qgxL3K6MdKrYYcMQQ3fPtftdpY=;
        b=pK8YTN1IAGatX4VxSpvK5Gmz4dunMbtarNd3A93o7rFb0ndKN7N4wzRdW7VEz8L4J1
         WK+cu/YYus6TZoQreaxtCQOPyTZkuWqbx+tZ1i/cmwqGQ4nd8736HvUr0twJNhIcii7H
         tOjizfq4P8cdD81jAEG/bmdyPvT+ASH3qWmC/WV4GwTuTIj5fZnTEVujQVbpp66+fODD
         aP/KI1Bob4EDyym/yS6lRnox04hD9VfKaEOWvq71t5Ka4lDudE8kX3o28Y7gDWvQuU4x
         iYBSyh+y3xbS6EK7CLeU3eOQflzh5N//yVGq7y1M2JSxUN5jzYt67NGPXu/ZUQ2Mt8Pq
         SqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bj69sOXrJpc7fsJ96qgxL3K6MdKrYYcMQQ3fPtftdpY=;
        b=Li8S6jlWfdzddrGYLCxC3DQgzD8OGQhsEUIxAiR9SWWLHIwYLVPuJDunlqSh0HuhMj
         R5aytZvdplFGb2kGBb0ZLahLzLJDIYBJu6HMuk5xeFWacCrhE3iBy5ghOpZtD4hdjxA/
         4PUpeg8XdsNLibA/Vu3hLYOEK28CZZgmTSSJgyt+nyc82N2kphvLl+tYbBrod1Mh0+GL
         FuS/AqkUGref7QtWxkG15h9Pa5N1wHr+NdghhJLtZkzHq978N+AI6l4g6/hxSkt7sV8b
         DHqZR6Yjlx6pOJX+yXSv1Md5nf540u6DsYPgFL6BEsci+L+0as7as1ol7y1/5wkaah2B
         8u3Q==
X-Gm-Message-State: AOAM530FdWBj7qWi2tGMc+AnM9jD8VuxC1C67dVkTLFRxyRdwdGvLkmK
        NZ7tKfCTjYCSkUFplmQIu5Zdy7mDdGTvpdZhW/SH
X-Google-Smtp-Source: ABdhPJwhsZ5aS/LjURkdD55s2XKfM2ph7qzeBtmQ8lyN+ehkjAXI9CDjPgA3C3aa/wIFj7N5u/aa6T42K40cqFKKNqAX
X-Received: by 2002:a25:b701:: with SMTP id t1mr17712616ybj.515.1591053633081;
 Mon, 01 Jun 2020 16:20:33 -0700 (PDT)
Date:   Mon,  1 Jun 2020 16:20:31 -0700
In-Reply-To: <xmqq367gvwgw.fsf@gitster.c.googlers.com>
Message-Id: <20200601232031.261207-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq367gvwgw.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: Re: [PATCH 8/8] upload-pack: send part of packfile response as uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >  static void create_pack_file(const struct object_array *have_obj,
> >  			     const struct object_array *want_obj,
> > -			     struct list_objects_filter_options *filter_options)
> > +			     struct list_objects_filter_options *filter_options,
> > +			     const struct string_list *uri_protocols)
> >  {
> 
> I wanted to see why you rebased on top of 'next' to see possible
> interactions with topics in-flight, and I found out that this series
> was trivial to rebase on 'master'.
> 
> The codebase however is moving in the direction to reduce the number
> of parameters this function takes, and the above change does not
> play well with the cc/upload-pack-data-2 topic that cleans up the
> code around this area.
> 
> Can you help review cc/upload-pack-data and cc/upload-pack-data-2
> topics, as you'd eventually be basing your topic on top of the
> result of merging these two clean-up topics to 'master'?  The former
> is already in 'next' after Peff's review, and after finding nothing
> glaringly wrong in it, I am not so worried about it, but the latter
> may benefit from an extra set of eyes.
> 
> Thanks.

OK - I'll take a look tomorrow.
