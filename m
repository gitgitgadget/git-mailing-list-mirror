Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7D320357
	for <e@80x24.org>; Mon, 17 Jul 2017 23:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdGQXYi (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 19:24:38 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32998 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbdGQXYi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 19:24:38 -0400
Received: by mail-pf0-f171.google.com with SMTP id e26so2155329pfd.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jFgr0zvD95Z2nGpqgcI1McRnkAMsZZaliCO/DDFNEY=;
        b=m6OA+GQt4p/cBArjDm/vMcHessu3+5SX1Rtpo6X3q0JELt+5qhg3Xq1RC33gL4FAMl
         UOENDsc/cIopDJ5cjzgypUw+I/KYXnKI6LLveak69aeHypHrfMX5v5xreAKADMqQtLSl
         e3N2JmuOmN3n8FNoFDkN1GINnFJch/TKtR9lUss5XpDeFVDdVUM25eG45AwssQlillaN
         hNggBJvodDkOljVyzAp+xUKMNbaYtce4zk7l9IGvTR3f0anHO7kmD8j7GruyBisOE2cx
         PqSCGIYKNMbt0CXLCB8r74Pn0nO9xXeJ8KDwdoP9s45RhGLVRtJhiuNaQLcSjjtf49KX
         4TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jFgr0zvD95Z2nGpqgcI1McRnkAMsZZaliCO/DDFNEY=;
        b=H6ldJxV2GUFTZ9QMsCq8xttgoGYTyA5Yg61CNlLilKH+w25F/aD+rZi8ad0oU/PFw+
         YzSXxwcqiOddOVitkDbai3ELSHX7paFsyOrOWsu7i5vnkne+etqhd/Uhya6FYCMaElbk
         jUfUoMh27BE/Pvx7koWGUHT5WZtLfVjIHp4JSfGUE+S3WXwc4a3lPKDA50FPEi21IHWI
         a1Sp0keL7M5Cn4xjehWNHzHAR36T9dTWd11JdodfOHQ88z4nTYibpmrNIE2jVjtbsBVs
         ieyUYV6CfMHSFzStIhEs8Oq51dmQ0wCgAfj46KciFYI+Y+3p9rem/azavUiozNx6Uk4z
         9n2A==
X-Gm-Message-State: AIVw1134V4bmtV9X2pCIzsZuPGBRIZwHOMPV945vTSAoebWUCCd5zPXk
        Z0ZdG4gSmgma9UPq1qtz2g==
X-Received: by 10.98.13.219 with SMTP id 88mr21755510pfn.191.1500333877313;
        Mon, 17 Jul 2017 16:24:37 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:4537:6747:cb98:8004])
        by smtp.gmail.com with ESMTPSA id t17sm527070pge.55.2017.07.17.16.24.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 16:24:36 -0700 (PDT)
Date:   Mon, 17 Jul 2017 16:24:31 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: Re: [PATCH v2 1/1] sha1_file: Add support for downloading blobs on
 demand
Message-ID: <20170717162431.1e11737d@twelve2.svl.corp.google.com>
In-Reply-To: <d3f1f884-7b8a-885f-47cb-eca2b8ef0ecf@gmail.com>
References: <20170714132651.170708-1-benpeart@microsoft.com>
        <20170714132651.170708-2-benpeart@microsoft.com>
        <20170717110602.6fac89ea@twelve2.svl.corp.google.com>
        <d3f1f884-7b8a-885f-47cb-eca2b8ef0ecf@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 17 Jul 2017 16:09:17 -0400
Ben Peart <peartben@gmail.com> wrote:

> > Is this change meant to ensure that Git code that operates on loose
> > objects directly (bypassing storage-agnostic functions such as
> > sha1_object_info_extended() and has_sha1_file()) still work? If yes,
> > this patch appears incomplete (for example, read_loose_object() needs to
> > be changed too), and this seems like a difficult task - in my patch set
> > [1], I ended up deciding to create a separate type of storage and
> > instead looked at the code that operates on *packed* objects directly
> > (because there were fewer such methods) to ensure that they would work
> > correctly in the presence of a separate type of storage.
> > 
> 
> Yes, with this set of patches, we've been running successfully on 
> completely sparse clones (no commits, trees, or blobs) for several 
> months.  read_loose_object() is only called by fsck when it is 
> enumerating existing loose objects so does not need to be updated.

Ah, that's good to know. I think such an analysis (of the other
loose-related functions) in the commit message would be useful, like I
did for the packed-related functions [1].

[1] https://public-inbox.org/git/34efd9e9936fdab331655f5a33a098a72dc134f4.1499800530.git.jonathantanmy@google.com/

> We have a few thousand developers making ~100K commits per week so in 
> our particular usage, I'm fairly confident it works correctly.  That 
> said, it is possible there is some code path I've missed. :)

I think that code paths like the history-searching ones ("git log -S",
for example) should still work offline if possible - one of my ideas is
to have these commands take a size threshold parameter so that we do not
need to fetch large blobs during the invocation. (Hence my preference
for size information to be already available to the repo.)

Aside from that, does fsck of a partial repo work? Ability to fsck seems
quite important (or, at least, useful). I tried updating fsck to support
omitting commits and trees (in addition to blobs), and it seems
relatively involved (although I didn't look into it deeply yet).

(Also, that investigation also made me realize that, in my patch set, I
didn't handle the case where a tag references a blob - fsck doesn't work
when the blob is missing, even if it is promised. That's something for
me to look into.)
