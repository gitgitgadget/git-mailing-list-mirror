Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D1EC433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 23:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9596120829
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 23:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGfwG5hQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgFCXGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgFCXGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 19:06:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E185C08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 16:06:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s88so244337pjb.5
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wflxk0x/Wdp6RAQIvg+pqX8IxKAYrpM+sfKl7rqq69w=;
        b=KGfwG5hQOVgaA6UFTy9GfG0wq1F0TvwPGXuhjBPdDCr/A73HIGYn/HseP7ii6dZFAz
         s2qRblYq6dVhQeXxPi/ZorqJE+8ZOjBOWa63z/SKebzK9GSnhp4BTT0aBExkdEQtDatR
         RJST5gokUPLrKxlLgxkPNHSejZ1MkeGnxWUE8tgOJC7uEnU2wIV2OjOGJW8yfRi/6Pvz
         ywP8REfR4PCs0tGUJe+DJSHwCeo5B5n6oz2U0z0KOn7TWntLocP41af0pAybr66neDEo
         kC1Cykvvb2OuSgN6lJtQvSuW/mI5Rdi45MY07dnqCYVicvutnFMChPTWdwf4gVFc9/io
         jyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wflxk0x/Wdp6RAQIvg+pqX8IxKAYrpM+sfKl7rqq69w=;
        b=ewDqBOwZdD4ENPFa1+ziIcquehyMyUFwqudH9ZRLk8gEYcI4UiFBHG8+Eck5Lqfd+/
         x6olDD78uELrt2pnm11Mf18IbDIe7kySYXT7V94i9ctVK0EuoUKmXOYBVLnf7zWmmXcq
         iw2PSnHVChwC7A4bmcpeczsN8binQpl9piKzqVFmaX3q+RQppAN7Uf+20WOtyRTIMkxp
         MsUU6h91+wDAn+nIRyDq6wAVOrrJPeqzeAkG7lQvo06K6DVaA1TxFzUQYZrPBooRpLXG
         ryjLMnAwerhzObH/46Npso/6bSjRlXv51kTXhCA6557Ign2ZPlzzJkMzSdIzxMov8uVD
         nZCg==
X-Gm-Message-State: AOAM533aVaEHcdbl24WK6Vuco2EA9XW8E2WMgQ+wWx/pYuY/RSKP9t5G
        Ijb9PqaAfq0gyDp+nGTA0zM=
X-Google-Smtp-Source: ABdhPJwD4R8ewdzLDARDF++l8s3nVsfezRZmYnQ0Z5Nqnjgm9C7UYl2LQRWdSeKnrnV96kayYb9jNw==
X-Received: by 2002:a17:90a:bb81:: with SMTP id v1mr2349814pjr.168.1591225575890;
        Wed, 03 Jun 2020 16:06:15 -0700 (PDT)
Received: from gmail.com (119.81.105.34.bc.googleusercontent.com. [34.105.81.119])
        by smtp.gmail.com with ESMTPSA id c9sm2715278pfp.100.2020.06.03.16.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:06:15 -0700 (PDT)
Date:   Wed, 3 Jun 2020 16:06:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        newren@gmail.com, Jay Conrod <jayconrod@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <20200603230611.GA1925@gmail.com>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
 <20200603034213.GB253041@google.com>
 <20200603045248.GA20266@syl.local>
 <20200603051631.GA20678@syl.local>
 <20200603205151.GC253041@google.com>
 <20200603221453.GA36237@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603221453.GA36237@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> On Wed, Jun 03, 2020 at 01:51:51PM -0700, Jonathan Nieder wrote:

>> --- i/commit-graph.c
>> +++ w/commit-graph.c
>> @@ -149,7 +149,8 @@ static int commit_graph_compatible(struct repository *r)
>>  	}
>>
>>  	prepare_commit_graft(r);
>> -	if (r->parsed_objects && r->parsed_objects->grafts_nr)
>> +	if (r->parsed_objects &&
>> +	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent))
>
> This is a little tricky. Why would we set substituted_parent without
> also incrementing grafts_nr? That seems like the real bug here: if we
> incremented grafts_nr, then we would return a non-zero value from
> 'commit_graph_compatible' and rightly stop even without this sticky-bit.
> 
> I don't quite understand this myself. If it's an oversight, it's a
> remarkably long-lived one. Do you have a better sense of this?

The idea here is to check for two different things:

 1. Do we have grafts (either from a grafts file or from a shallow
    file)?  If so, this repository is not commit graph compatible
    because we could encounter one of them.

 2. Have cached parsed objects taken any history modifications into
    account?  If so, this in-memory state is not commit graph
    compatible because we could encounter one of them.

The check (1) might seem sufficient if the set of grafts is constant
for the lifetime of a git process.  But since 37b9dcabfc (shallow.c:
use '{commit,rollback}_shallow_file', 2020-04-22), it is not constant
for the process lifetime, so we need the check (2) as well.

We might want a similar check for replace refs as well some day, but
not today (there is not a way to remove entries from replace_map
during the life of a process).

I can try sending a proper patch with commit message and tests
tomorrow morning (or if someone else takes care of it, that's fine,
too).  Thanks, both, for your help --- it was nice seeing a clear
explanation of the cause already figured out and explained when I woke
up.

Regards,
Jonathan
