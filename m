Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE3BC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 14:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E9B208C7
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 14:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6WBB1ZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbgFSOYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:24:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56690 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727848AbgFSOYH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 10:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592576645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JOhi8M5zb/Kv/uadhtLcPJzdJMULo8FvLOb0MZ+nQg=;
        b=G6WBB1ZWCES2wjw5cb2bTO9bp9XdA3mlV7uKDrpwBus1YN/oFXMfppVVvYeNIRk5BrLJHq
        Z2tyhQooIDBi7N1Zh0cE5/PKnLO9wydB7ESXwZrAuZK/e/RzxLRCJRzz8iDQjN5zlPwHdn
        kTo9YENpG7MovOjWkOYkpvcXvx2zK1Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-eK6iNWKuNXiKTalhjqnRWg-1; Fri, 19 Jun 2020 10:24:00 -0400
X-MC-Unique: eK6iNWKuNXiKTalhjqnRWg-1
Received: by mail-wr1-f69.google.com with SMTP id d6so4343048wrn.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 07:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2JOhi8M5zb/Kv/uadhtLcPJzdJMULo8FvLOb0MZ+nQg=;
        b=EcyM06GjhX3Swk/CP3Se8upY4AOJlY9sNMHlyBMO8NHBQmmLeIRtkanzQVYzixZA/I
         lWwtiOC2a8KLyYEQ3fcWrEVpS13rhIZes6GKuGvWlESCTK7WsRw6sj9CT+Bd9S2iX7h4
         nwrj0zSHmbv9IN3XiHue1FjY3gS+xH6ILi0zSKeQJvgx3OnbpVWSXg1cm2Ew7EuzeHcl
         vMOmzaD8AZ1LEDAs9x73tkZItxk3j98CdLS3qwT79RS5DjEmGwAvXUAtcHIq1nDPuom6
         gSi3T2D4leNohH+MknW4lBftCkj2a6wS/yboR4MEaTjITEThljwXBU0mfSBwNfUfxB2K
         hYrA==
X-Gm-Message-State: AOAM532qdPzT3tzcORhbaWz8tXlHkNwN3DeL+sLSqlRAiySdiqOjYPf/
        4SV/UL1S6N1NuwL7aeVRO1LpWNfAfw3dNTaG9yKLcWVWEQ5tPVKuf2crTeahjfY0jAthDqw31+x
        OOm/Uu7/3OWf4
X-Received: by 2002:a5d:6751:: with SMTP id l17mr4660415wrw.179.1592576638895;
        Fri, 19 Jun 2020 07:23:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtsUV9zeW7ZYrflB8IVohQTcd3XJh7DGhy1GE3Prry4oiwHeNn1+9OxS0qxRrrWe0bitukfw==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr4660392wrw.179.1592576638637;
        Fri, 19 Jun 2020 07:23:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id x5sm1771547wmg.2.2020.06.19.07.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 07:23:58 -0700 (PDT)
Subject: Re: [PATCH v2] tests: do not use "slave branch" nomenclature
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, msuchanek@suse.de,
        Till Maas <tmaas@redhat.com>
References: <20200619093210.31289-1-pbonzini@redhat.com>
 <20200619130058.GA5027@danh.dev>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7611e0f-3d62-fc92-7f35-5abcc11f2fd8@redhat.com>
Date:   Fri, 19 Jun 2020 16:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200619130058.GA5027@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/06/20 15:00, Đoàn Trần Công Danh wrote:
> I think common terminology in Git's test is this kind of branch is side.
> In this inaccurate comparison:
> 
> 	git grep -E '(branch|checkout|switch).* side '
> 	git grep -E '(branch|checkout|switch).* feature'

Side branch is the name that git uses for "parents other than the first
one in a merge commit", for example

	Verify that the tip commit of the side branch being merged is
	signed with a valid key

Feature branch is what you call branches in a workflow that does feature
development in a dedicated branch instead of the master branch.  In
addition to the two that you point out, there are other occurrences of
"feature branch".  For example in t5520-push.sh:

# add a feature branch, keep-merge, that is merged into master, so the
# test can try preserving the merge commit (or not) with various
# --rebase flags/pull.rebase settings.

and that has some resemblance with the format-patch test.  (However,
t5520-push.sh doesn't call its branch "feature"

So I think both terms are acceptable.  Certainly "feature branch" is
used a lot by git users (and was suggested in the v1 review) even though
it's not as prevalent in the source code.

Paolo

