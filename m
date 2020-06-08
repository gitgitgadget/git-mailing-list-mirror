Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3015C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 16:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B94206A4
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 16:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAwLvhUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgFHQqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730619AbgFHQqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 12:46:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7606C08C5C3
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 09:46:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so175793wmh.4
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e1AcqRgY5Q5ranWem2Z3SZ7SAjM/IjVSMGEJ7Yu5/vs=;
        b=sAwLvhUJy2YEtoVfzNUzdAA4oYGaEVRSMPP0qx+kpiB6SqzT+7srn7xUBpYnSQ9M8+
         S8sEQQthCOS1wO0jWBSfFhvjgmEvzDCbi3d1RWZG+hjO6MSQ0sUFMN+l7DIE3HCGeie7
         nXEjMvd/XEXMuZP6go0f9JBrMV1k5DbcdkJnMwWPr0gwpYbxCXMAj5yMooJMGx8C31gH
         8AzmU8Q/UB91dNb2zY0DnSynVzj+HnACXV9DLUd5XyTHff5dqBBVFmXAYltFwBvKRjpt
         gSI0BWl/UXh/TGvineYwGr81pH5TqXLXdopchapOwyPBZUyeY388WiGMyqr9WVDXBgI/
         7J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e1AcqRgY5Q5ranWem2Z3SZ7SAjM/IjVSMGEJ7Yu5/vs=;
        b=XhnnFqOW8wCvFmKOaskS6bTcg28JRAzg/La86TAJNxW2PIxxVsQWqmeToFrRL4VFyl
         g7Lvn6opRt/OZdvl9oYnza6sSrYUiuiMZD+yq1W+DaMr1+RvJ5tSowk663Ly7HcQqzVR
         ZKwCZoCHtiFWzzKwUsQ6QG3F6hBGOZMrXR+V/qIKqOtbz6+od3y7C++yix3fIjzCh6+I
         UF7huIxwgEK+klczxhIBDW8Q0KNAhLxjcICewJ/zkQW4wfngsFTCcoRQhpl7wQxLkcp9
         HO78IixJ8cIEt3CP2gaN7LPiApNM16e9BJUB5gXqCH+sNrZp1kRC5HA568qOqe5uXJhX
         8YQg==
X-Gm-Message-State: AOAM5336T5r8N4tIGnlYE8L+LIe4eo0OWNbiob5CPWKpfJHEWgYVJcti
        xymIw7+ntEC2pRqZmLu1fo8=
X-Google-Smtp-Source: ABdhPJzD2QMVGpJ9Qrq97VQRaid7deyykdbSuQT7XQv8ija3thXqAaJ1M32WLS+TetTGK+8ge2NqHw==
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr227538wmf.51.1591634800293;
        Mon, 08 Jun 2020 09:46:40 -0700 (PDT)
Received: from szeder.dev (94-21-146-196.pool.digikabel.hu. [94.21.146.196])
        by smtp.gmail.com with ESMTPSA id f9sm252921wre.65.2020.06.08.09.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 09:46:39 -0700 (PDT)
Date:   Mon, 8 Jun 2020 18:46:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, jnareb@gmail.com,
        git@vger.kernel.org
Subject: Re: [GSoC Patch 0/3] Move generation, graph_pos to a slab
Message-ID: <20200608164637.GE8232@szeder.dev>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <b850637d-a7ca-e8f9-5009-657096ea2975@gmail.com>
 <20200607195347.GA8232@szeder.dev>
 <20200608054827.GA2054@Abhishek-Arch>
 <20200608083615.GD8232@szeder.dev>
 <13db757a-9412-7f1e-805c-8a028c4ab2b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13db757a-9412-7f1e-805c-8a028c4ab2b1@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 08, 2020 at 09:45:12AM -0400, Derrick Stolee wrote:
> On 6/8/2020 4:36 AM, SZEDER Gábor wrote:
> > On Mon, Jun 08, 2020 at 11:18:27AM +0530, Abhishek Kumar wrote:
> >> On Sun, Jun 07, 2020 at 09:53:47PM +0200, SZEDER Gábor wrote:
> >>> On Thu, Jun 04, 2020 at 10:22:27AM -0400, Derrick Stolee wrote:
> >>>> On 6/4/2020 3:27 AM, Abhishek Kumar wrote:
> >>>>> The struct commit is used in many contexts. However, members generation
> >>>>> and graph_pos are only used for commit-graph related operations and
> >>>>> otherwise waste memory.
> >>>>>
> >>>>> This wastage would have been more pronounced as transistion to
> >>>>> generation number v2, which uses 64-bit generation number instead of
> >>>>> current 32-bits.
> >>>>
> >>>> Thanks! This is an important step, and will already improve
> >>>> performance in subtle ways.
> >>>
> >>> While the reduced memory footprint of each commit object might improve
> >>> performance, accessing graph position and generation numbers in a
> >>> commit-slab is more expensive than direct field accesses in 'struct
> >>> commit' instances.  Consequently, these patches increase the runtime
> >>> of 'git merge-base --is-ancestor HEAD~50000 HEAD' in the linux
> >>> repository from 0.630s to 0.940s.
> >>>
> >>
> >> Thank you for checking performance. Performance penalty was something we
> >> had discussed here [1]. 
> >>
> >> Caching the commit slab results in local variables helped wonderfully in v2 [2].
> >> For example, the runtime of 'git merge-base --is-ancestor HEAD~50000 HEAD'
> >> in the linux repository increased from 0.762 to 0.767s. Since this is a
> >> change of <1%, it is *no longer* a performance regression in my opinion.
> > 
> > Interesting, I measured 0.870s with v2, still a notable increase from
> > 0.630s.
> 
> This is an interesting point. The --is-ancestor is critical to the
> performance issue (as measured on my machine).
> 
> For "git merge-base HEAD~50000 HEAD" on the Linux repo, I get
> 
> v2.27.0:
> real    0m0.515s
> user    0m0.467s
> sys     0m0.048s
> 
> v2 series:
> real    0m0.534s
> user    0m0.481s
> sys     0m0.053s

I, too, see similarly small differences in this case.

> With "--is-ancestor" I see the following:
> 
> v2.27.0:
> real    0m0.591s
> user    0m0.539s
> sys     0m0.052s
> 
> v2 series:
> real    0m0.773s
> user    0m0.733s
> sys     0m0.040s
> 
> The --is-ancestor option [1] says
> 
>     Check if the first <commit> is an ancestor of the second
>     <commit>, and exit with status 0 if true, or with status
>     1 if not. Errors are signaled by a non-zero status that
>     is not 1.
> 
> [1] https://git-scm.com/docs/git-merge-base#Documentation/git-merge-base.txt---is-ancestor
> 
> This _should_ be faster than "git branch --contains HEAD~50000",
> but it is much much slower:
> 
> $ time git branch --contains HEAD~50000
> real    0m0.068s
> user    0m0.061s
> sys     0m0.008s
> 
> So, there is definitely something going on that slows the
> "--is-ancestor" path in this case. But, the solution is not
> to halt the current patch (which likely has memory footprint
> benefits when dealing with a lot of tree and blob objects)
> and instead fix the underlying algorithm.

Other, more common cases are affected as well, notably the simple 'git
rev-list --topo-order':

  performance: 1.226479734 s: git command: /home/szeder/src/git/BUILDS/v2.27.0/bin/git rev-list --topo-order HEAD
  max RSS: 162400k
  
  performance: 1.741309536 s: git command: /home/szeder/src/git/git rev-list --topo-order HEAD
  max RSS: 169556k

Is the supposed memory footprint reduction that large to justify this
runtime increase?

> Let's add that to the list of things to do.

And to the commit messages.

> >>>  create mode 100644 contrib/coccinelle/generation.cocci
> >>>  create mode 100644 contrib/coccinelle/graph_pos.cocci
> >>
> >> I appreciate the Coccinelle scripts to help identify
> >> automatic fixes for other topics in-flight. However,
> >> I wonder if they would be better placed inside the
> >> existing commit.cocci file?
> >
> > We add Coccinelle scripts to avoid undesirable code patterns entering
> > our code base.  That, however, is not the case here: this is a
> > one-time conversion, and at the end of this series 'struct commit'
> > won't have a 'generation' field anymore, so once it's merged the
> > compiler will catch any new 'commit->generation' accesses.  Therefore
> > I don't think that these Coccinelle scripts should be added at all.
> 
> I disagree. We _also_ add Coccinelle scripts when doing one-time
> refactors to avoid logical merge conflicts with other topics in
> flight. If someone else is working on a parallel topic that adds
> references to graph_pos or generation member, then the scripts provide
> an easy way for the maintainer to update those references in the merge
> commit. Alternatively, the contributor could rebase on top of this
> series and run the scripts themselves to fix their patches before
> submission.
> 
> For example, this was done carefully in the sha->object_id
> conversion using contrib/coccinelle/object_id.cocci.

'object_id.cocci' is not about sha->object_id conversions, but about
avoiding undesirable code patterns, e.g. we prefer oideq() over
!oidcmp(), and the compiler, of course, can't help to catch that.
Coccinelle scripts used for actual sha->object_id transformations were
not added to 'object_id.cocci', but were recorded only in the commit
messages for reference, see e.g.  9b56149996 (merge-recursive: convert
struct merge_file_info to object_id, 2016-06-24) and a couple of its
ancestors.

