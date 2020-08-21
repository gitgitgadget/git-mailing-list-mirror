Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A5C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 04:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5E1206FA
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 04:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgz90+zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgHUENq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 00:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUENm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 00:13:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB442C061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 21:13:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o5so400950pgb.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 21:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kmHUTv3UBx2BKqGhxZgQkznXzAxMFlkCesCqhVjDPV8=;
        b=Mgz90+zLuhFDu7SPgi6zjvAvx67g86RbICeQAz6xyt9iKUuESVXmrbOT6SGEWfjPtW
         V79sCbCe1NxZEWMsdfVa0veuzjN5R0WnlHmY8KG2Mzc4BIClb9892JzQ3ww/5a3agmDT
         5zoSWKwThk5n2H+5XyqMZzDdbZs7NFoIMvvnl2E8Idoeov5CDGxod+GmPEvaxJqIreV/
         QlY1nx7IyncFhcLQ74ZjyGwIf+lrbJtsK3k0rlAT4tS7+io5ItKEfasDralHT9YHE2sf
         JozW7zgEV1J2/VpYLtyVoeAKbM4fddVaAX5bq56bxr081tWkjb38/yc/bPyILfLR+XnY
         4hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=kmHUTv3UBx2BKqGhxZgQkznXzAxMFlkCesCqhVjDPV8=;
        b=EX0tPiLobj5EhRlUU57Q2KzIjX6Wt6x0cSjq5g/8HnGhiXENJ0xCWMwN4IGCovBAEI
         2iUxByJ/gVHbs+BxKqftMcwmCLC7hJ1XIoG7/q2D/16nw1XXWhT8lndv5mzaXoGcDGe8
         /LbKV/EOUzvadSd7eGbXfEfhQE61E9p3UHYLS+vFatq3kfCN65QI5/s3Q4bBVve5kgVE
         Dg8pq3FyLrelC35bi2pDVWcUj1A5Us8ZioZgatrNLQfYEPvCNzJRqBZ1M5K3tKnMetzx
         irYWQumdlRnST+4frjUlZ8hCXBihKyTYcuS5LAJE8OFMUAjt5SIUHGi/y8u4NiCIGsti
         3Brg==
X-Gm-Message-State: AOAM532KdLkzM8PbSy5BHVCVMzg2ZHi6pkbHpo4ipwm7Clzxd+H1SXsh
        n+RybDIuxVF6C0Z84tAwTElxxT3JzI9VLg==
X-Google-Smtp-Source: ABdhPJzya0C7xy4xHjZospHoNFQvaJAAoCPvzaqZpi85r+XM+nJZdsB1UdUc/VXHciRV4l65uBkcSQ==
X-Received: by 2002:a63:54b:: with SMTP id 72mr946887pgf.201.1597983221682;
        Thu, 20 Aug 2020 21:13:41 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:6:a48e:78e9:cb65:6f6e:796c])
        by smtp.gmail.com with ESMTPSA id s1sm609328pgh.47.2020.08.20.21.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 21:13:41 -0700 (PDT)
Date:   Fri, 21 Aug 2020 09:41:24 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, me@ttaylorr.com, stolee@gmail.com
Subject: Re: [PATCH v3 03/11] commit-graph: consolidate fill_commit_graph_info
Message-ID: <20200821041124.GA39355@Abhishek-Arch>
Reply-To: 857dtuo71v.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <18d5864f81e89585cc94cd12eca166a9d8b929a5.1597509583.git.gitgitgadget@gmail.com>
 <857dtuo71v.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <857dtuo71v.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 19, 2020 at 07:54:20PM +0200, Jakub Narębski wrote:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > Both fill_commit_graph_info() and fill_commit_in_graph() parse
> > information present in commit data chunk. Let's simplify the
> > implementation by calling fill_commit_graph_info() within
> > fill_commit_in_graph().
> >
> > The test 'generate tar with future mtime' creates a commit with commit
> > time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
> > generation number (within CDAT chunk) and has undefined behavior.
> >
> > The test used to pass
> 
> Could you please tell us how does this test starts to fail without the
> change to the test described there?  What is the error message, etc.?
> 

Here's what I revised the commit message to:

commit-graph: consolidate fill_commit_graph_info

Both fill_commit_graph_info() and fill_commit_in_graph() parse
information present in commit data chunk. Let's simplify the
implementation by calling fill_commit_graph_info() within
fill_commit_in_graph().

The test 'generate tar with future mtime' creates a commit with commit
time of (2 ^ 36 + 1) seconds since EPOCH. The CDAT chunk provides
34-bits for storing commiter date, thus committer time overflows into
generation number (within CDAT chunk) and has undefined behavior.

The test used to pass as fill_commit_graph_info() would not set struct
member `date` of struct commit and loads committer date from the object
database, generating a tar file with the expected mtime.

However, with corrected commit date, we will load the committer date
from CDAT chunk (truncated to lower 34-bits) to populate the generation
number. Thus, fill_commit_graph_info() sets date and generates tar file
with the truncated mtime and the test fails.

Let's fix the test by setting a timestamp of (2 ^ 34 - 1) seconds, which
will not be truncated.

> >                       as fill_commit_in_graph() guarantees the values of
>                            ^^^^^^^^^^^^^^^^^^^^^^
> 
> s/fill_commit_in_graph()/fill_commit_graph_info()/
> 
> ...
> 
> Ah, after the change fill_commit_graph_info() changes its behavior, not
> fill_commit_in_graph() as said in the commit message. Before this commit
> it used to only load graph position and generation number, and did not
> load the timestamp. The function fill_commit_graph_info() is used in
> turn by public-facing load_commit_graph_info():
> 

That's exactly it. I should have elaborated better in the commit
message. Thanks for the through investigation.

>   /*
>    * It is possible that we loaded commit contents from the commit buffer,
>    * but we also want to ensure the commit-graph content is correctly
>    * checked and filled. Fill the graph_pos and generation members of
>    * the given commit.
>    */
>   void load_commit_graph_info(struct repository *r, struct commit *item);
> 
> ...
> 
> Looks good to me.
> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
