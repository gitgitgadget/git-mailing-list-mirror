Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F31C2BA19
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 06:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B326620738
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 06:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMYacU3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDUGxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726123AbgDUGxE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 02:53:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2827AC061A0F
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 23:53:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x26so6330125pgc.10
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m7VwugYri/0ydSONAH1YsDHDtsI+XRLFJlSRbDAsRdY=;
        b=FMYacU3m/mtyIBL72H2sbUpQyyHIlEahIEV5QZFy/AR0eNThOIEmkMX7B9ofLMPKud
         TAMFrw05H7xznLiHecY7yljwVVEx+qSPIDuge93dVEgwy1nDkEY2w7SUN6+tL8LnE4H+
         PCieH3Ixan1cW7//IcRTnk1MkQcAXS4Bh0u/eoX5idhw+hru8LBiWjVsAGi6oN/+QV/d
         cEoBjmmwsD8WQZPRpIoEXB3heayN8sQb2l2/m0XfoySpGc8JQRy/fIuctilQfOCEFsw2
         6VEYvDVCDuO1OTHgGkDQ5qgNcuXYMj/M4DN6weAXLb6klk9zbFulwltL/HJ6ml1bLfvD
         GIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m7VwugYri/0ydSONAH1YsDHDtsI+XRLFJlSRbDAsRdY=;
        b=WFt4pNA0pX7jkuZsySVGUptoQjjCjwvCLJlHB97G5r3gvPjgXzfNRkOWOiEJuVzs3k
         4YZU9AdUbsljlEUhofZlDj2FMVThTC4JoaT/1nX7IqRGz6ANXeSIj1BDPqcX4W1BFKYS
         LiBFwSDJ32NOh7w5x2meV4RoUFNqAtQv8uF03q5oZfIBRNBGlQUmXyvBCWiuTVn7zvpb
         EgnCZxydaVSQ+eAqBZLw81jI+qQKwRV5wImBZ7zA3hCvdcGwgZqyUIlxPfWWAsQBtMNl
         DGo4TUW2QPeLzzJhZF8D20uDWJVmYQpxvMf7z3YxdM64C8+o3PZWirwgQ3e5l8dKWv77
         DlOA==
X-Gm-Message-State: AGi0PuZFsXGdldS4Xh0r26suNWIACabML/UCiCFlZjFMWuvcP5vU6lv8
        e7hZ2Y8AWW73maIOfjb/bHpMosKj
X-Google-Smtp-Source: APiQypJTIWyeXciLf3R1g80axd6ogJuVtU6QzkP2hv3XaTKIZhnlNACbin7qnoSa0vY5wcrSuGxVeQ==
X-Received: by 2002:a63:5112:: with SMTP id f18mr1589651pgb.356.1587451983635;
        Mon, 20 Apr 2020 23:53:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id g2sm1408684pjd.9.2020.04.20.23.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 23:53:03 -0700 (PDT)
Date:   Mon, 20 Apr 2020 23:53:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     git@vger.kernel.org
Subject: Re: how to (integrity) verify a whole git repo
Message-ID: <20200421065301.GH96152@google.com>
References: <acb9a2da98bce7ea3044cbf37c92163497f7e9e2.camel@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb9a2da98bce7ea3044cbf37c92163497f7e9e2.camel@scientia.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christoph,

Christoph Anton Mitterer wrote:

> How to cryptographically verify the integrity of a whole git repo (i.e.
> all it's commits/blobs/etc. in the history?

This happens automatically as part of fetch.  When you fetch, the
objects' content is transfered over the wire but not their names.  The
name of each object is a hash of its content.  Thus, whenever you
address an object by its name, you are using its verified identity.

> Assume e.g. I have the kernel sources and want to do some bisection.
> One has also retrieved Linus' and GregKH's key via some trusted path
> and assumes that SHA1 is more or less still safe enough ;-)
>
> 1) Of course there is git verify-tag and verify-commit which are signed
> with the GPPG, but these alone check, AFAIU, only the respective
> tag/commit.

Tag and commit object content include the object ids for the objects
they reference, so (assuming we are using a strong hash) their name
is enough to verify all content reachable from them.

In other words, it's a Merkle tree.

> How to check everything else? Is it enough to git fsck --full?

fsck is helpful for checking that objects are valid --- that they
don't reference any objects you don't have, that their format is
correct, and so on.  So it's good to run (or you can use the
transfer.fsckObjects setting to run fsck as part of the clone or fetch
operation).

Thanks and hope that helps,
Jonathan
