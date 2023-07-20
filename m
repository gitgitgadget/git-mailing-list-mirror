Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD7EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 21:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjGTVDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjGTVC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 17:02:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5772123
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:02:57 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57722942374so13397097b3.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689886977; x=1690491777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUysQ+gYgCmXjWWfkrhOLVRUxSTEtU/1WdJDdwO95F8=;
        b=dFCNWq1N0tOIItdpLMUXHkk3LwoNUhTdM789o7nIBl6ek3Bai6AGNtxsW6AyJ+9vOW
         7t+W90JfV9ZQ2kcmTtvHVj1YPP0b0J3h5uqE+TqjVoH749mfBech7qn2UYL7biNfJF3y
         uL1lR7qaXTwFaadBi/LdBBXdihjlfjqbc/K6DdHZMKnDKrHqeLHEg2z1fkehEy4L0Ful
         n/Tn2NeO84BuZxuV9AJA6PFzbuNvRdWT6cSazDCEZe4dWts4I3WpL7uyt6a0OJXYH8fR
         L0SlLHZOuN2nZu3pl2oyR65NLod9GxmeNtd9BN08ni/+FkW25h7k8sYPyQ98+Tk5Iaps
         fdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689886977; x=1690491777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUysQ+gYgCmXjWWfkrhOLVRUxSTEtU/1WdJDdwO95F8=;
        b=OImII+8uMdQvJAlHecZSW5lQE/aeUS7aDERNdAHawjz8B6lkrcKRXJs9xJ9Q0sw5pP
         6GStcXTj+t9mZMzcVO1w1QtwFDEt9C5Hf54Xo4dashitxrNbjDIyj+mu1vnZP7YuWw+H
         /lwQafdNfFpET44R+CYz+RbyYDPq5oqonzSZfjihIaCBKIJtvBL9Y9YHgiJQvd0Sa4P0
         g/j1ngS27VVUuvVoRMspnAH6xi4wI1Op03skVjEvNzCz9cvM3RuYpTwEJLBHKVYjX3pw
         Dax9sHUJb6I+RhAMurqn1Fv+T6uXBWMGElHwXqqMlG2xCcOJ70/sQ//N9N3XgPmmy1e6
         AGeA==
X-Gm-Message-State: ABy/qLZTwyGS/7b3ak7JrRvtv9/u30sfniSbLw8N69CDUg0P48iSv8AJ
        DshUPhlt46ZGbMOLEIzYF4Zuxw==
X-Google-Smtp-Source: APBJJlESw2TTCrBWkpqHADvFvhD1qC+Cv6K6PS3WAZr9oNPLeOntM7phX4qkhFFmRL+RNxBJoB7Rjw==
X-Received: by 2002:a81:dd05:0:b0:579:f5c2:b16e with SMTP id e5-20020a81dd05000000b00579f5c2b16emr160331ywn.31.1689886976336;
        Thu, 20 Jul 2023 14:02:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x145-20020a0dd597000000b0058069aecc5bsm445986ywd.98.2023.07.20.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 14:02:55 -0700 (PDT)
Date:   Thu, 20 Jul 2023 17:02:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] repo-settings: introduce
 commitgraph.changedPathsVersion
Message-ID: <ZLmg/58O9EsHi7Rn@nand.local>
References: <ZLgnJdo3o9WA5sNy@nand.local>
 <20230720204232.1328482-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720204232.1328482-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2023 at 01:42:32PM -0700, Jonathan Tan wrote:
> > > -	if (s->commit_graph_read_changed_paths) {
> > > +	if (s->commit_graph_changed_paths_version != 0) {
> > >  		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
> > >  			   &graph->chunk_bloom_indexes);
> > >  		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
> >
> > Just a small note, but writing this as
> >
> >     if (!s->commit_graph_changed_paths_version)
> >
> > would probably be more in line with our coding guidelines.
>
> Ah, yes. Changed it (without the exclamation mark).

Hah, whoops -- thanks for spotting my mistake there. :-)

Thanks,
Taylor
