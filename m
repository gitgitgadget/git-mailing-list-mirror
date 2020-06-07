Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBD6C433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A294D2074B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/G0GZmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgFGTx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGTx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 15:53:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402C2C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 12:53:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l12so12141728ejn.10
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nvRt3CnnJlzCHYHzxVLS4ufOtE4mcr3LU5Pbvqc+yv8=;
        b=U/G0GZmzRWURmIgk+zZKmYLJ0zYH7CTjbk8WRwxoplZ3x9YhdVcDc6vYfsK5iSxhHb
         tP8peTVFdJroMMROgdPTNcQT/vbDvcsXUt+KZYPz8FGl+U5RUOsP/5EOiAzBOB63WbC5
         L+9BZ3CaH5Wnli2+vDKu4AMfEPJUqi20WwuR82jVRXzzkliUTD3jGvD91MIV+40jLQ/f
         K8qRa/h8r4cAZrwHdVWka4X7OdELYLyxZOSY2Afk+zkVbH1wxa+SIg2KSNT/uCPsje0g
         vhRFAvhMdLWZNMQJ5eLLer9ThQ3VP1uOufRY5+D1wBStZsFG6R4HrePgBFJOGRyDEV+/
         jnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nvRt3CnnJlzCHYHzxVLS4ufOtE4mcr3LU5Pbvqc+yv8=;
        b=r4kiamBFDPWesumBX4n2jLXbrpjf2urB7DwIv4qI6tqSB/SZTf4fnWXu7q/FFqam1/
         h0YsUfctXrVQqwEqNIsnhSEdWs9BUNTnEz+96lAtbNuKlk0GLRiw6KqpfsEfFD+4+GDI
         /PCcqcGRbxaK+dhQAf8FIirfeFneQqnRob8+HqWKjxq4K/P1JOZiIohZJVWu2dffNDy9
         TDWbe2xip+DTBBozFvgD3tfuNkwg3ZMli0p5N4cdRlF08fEi2Cg9q04AgBT8WoV8/FRs
         GpBDO/ApPT+s0Rdd3OJocCNqKrlMpmJV3Pzt3sqVvGLg13QDWa2R3ZdmCoNSV93ttw0A
         BOOA==
X-Gm-Message-State: AOAM531vxpWRRAfUc/cb4RpUyWYmnyfltGFjyNTgdl6kpVTkrt/n4Ebs
        qtZWM4mWiB7YOKOvTYmYuIdbTPDu
X-Google-Smtp-Source: ABdhPJxdSN3SI4b8Mm3gyp1KaYp+jwIi2c15eSv3GJv/zzkSgI1zYKvnX2kvbpb03e5D2bbG5vUZWA==
X-Received: by 2002:a17:906:1496:: with SMTP id x22mr17447325ejc.161.1591559634735;
        Sun, 07 Jun 2020 12:53:54 -0700 (PDT)
Received: from szeder.dev (78-131-14-185.pool.digikabel.hu. [78.131.14.185])
        by smtp.gmail.com with ESMTPSA id i21sm8869017ejd.51.2020.06.07.12.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 12:53:54 -0700 (PDT)
Date:   Sun, 7 Jun 2020 21:53:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        jnareb@gmail.com
Subject: Re: [GSoC Patch 0/3] Move generation, graph_pos to a slab
Message-ID: <20200607195347.GA8232@szeder.dev>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <b850637d-a7ca-e8f9-5009-657096ea2975@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b850637d-a7ca-e8f9-5009-657096ea2975@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 04, 2020 at 10:22:27AM -0400, Derrick Stolee wrote:
> On 6/4/2020 3:27 AM, Abhishek Kumar wrote:
> > The struct commit is used in many contexts. However, members generation
> > and graph_pos are only used for commit-graph related operations and
> > otherwise waste memory.
> > 
> > This wastage would have been more pronounced as transistion to
> > generation number v2, which uses 64-bit generation number instead of
> > current 32-bits.
> 
> Thanks! This is an important step, and will already improve
> performance in subtle ways.

While the reduced memory footprint of each commit object might improve
performance, accessing graph position and generation numbers in a
commit-slab is more expensive than direct field accesses in 'struct
commit' instances.  Consequently, these patches increase the runtime
of 'git merge-base --is-ancestor HEAD~50000 HEAD' in the linux
repository from 0.630s to 0.940s.


> >  create mode 100644 contrib/coccinelle/generation.cocci
> >  create mode 100644 contrib/coccinelle/graph_pos.cocci
> 
> I appreciate the Coccinelle scripts to help identify
> automatic fixes for other topics in-flight. However,
> I wonder if they would be better placed inside the
> existing commit.cocci file?

We add Coccinelle scripts to avoid undesirable code patterns entering
our code base.  That, however, is not the case here: this is a
one-time conversion, and at the end of this series 'struct commit'
won't have a 'generation' field anymore, so once it's merged the
compiler will catch any new 'commit->generation' accesses.  Therefore
I don't think that these Coccinelle scripts should be added at all.

