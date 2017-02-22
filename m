Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721052023D
	for <e@80x24.org>; Wed, 22 Feb 2017 20:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbdBVUES (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 15:04:18 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35404 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754606AbdBVUEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 15:04:16 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so190392pfx.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 12:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fjYWnGyV+ykMjaRwId6rJ8d1wvduaPJYQNWKDmD/Ry8=;
        b=gjLF0rft7rvLvfKnpdC3kk21GIDjc7JAS83fK/x9gZHgF9rpYHyMrGb9UfEGDh7sP8
         4OwuRGPPEm8vT3RVJ9qHpp+h3UkeqcYMV3tqJjkzrQFnqaWGUBOlwHr37sPDjYVqoTSW
         BHr1XJjjRbPt25wa/DTP2FZsBWRl8pIjNBrGDIYmxgf5VKtr5ZqofUT0KTUb247uE19P
         /5GN4zxQOiu/E9QKQvKit7AWSQL5U27yzqFeUEAdTcow0ZjW2awbky6UTn8R+YY8YkEU
         Q81B4Eb4Dm7/7pSsQzckwvRf2iQlWXAn3n3IXLpaAOBwjmif8bCsklZVuWjFUqLK53TR
         KgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fjYWnGyV+ykMjaRwId6rJ8d1wvduaPJYQNWKDmD/Ry8=;
        b=Jd+aUBnLhCEwttKL/fHwx+xKZXEAEcniqDaivwp0L6POex6NEDMRf0WMbpW9XLZrrF
         C1xqsBXYyVbMJcd5SEIDLtiRIW4tz8RQ9IRpXiKhZa+kd2tkhf4gn8J2LVw+6q819qvj
         hOgLLdKh0D+s6c1PYlnLFSjjG26hTe6wqbnsw8CjYGUS/4a4OOobyF0bkks8YNZW+6NJ
         Evw/G6yiV2pqH5T5SKiQml8s89vp2B9MBlAr5YIAnn0WD/9aVwXlal2IvI/gZG9phs40
         tMfBsx/WGtVBJ/UOPt/Z7ZOAqH1qoXQBOJpgKWAvMahyyiLbxMJC6+4dA+3zuK3CHTu3
         0kbg==
X-Gm-Message-State: AMke39kzi7ZTkJMaBNDEkg1Aap/fwVxir+CZJTIgt0x9123Q11ta/p0RHL4DyQHoSGkoGQ==
X-Received: by 10.84.148.134 with SMTP id k6mr50219118pla.142.1487793856078;
        Wed, 22 Feb 2017 12:04:16 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id p14sm5214578pfl.75.2017.02.22.12.04.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 12:04:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 03/19] builtin/diff-tree: convert to struct object_id
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
        <20170221234737.894681-4-sandals@crustytoothpaste.net>
        <xmqqy3wyawlu.fsf@gitster.mtv.corp.google.com>
        <20170222191641.o2rtt2ymtb4h2yqe@sigill.intra.peff.net>
Date:   Wed, 22 Feb 2017 12:04:03 -0800
In-Reply-To: <20170222191641.o2rtt2ymtb4h2yqe@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 22 Feb 2017 14:16:42 -0500")
Message-ID: <xmqqtw7mat70.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 22, 2017 at 10:50:21AM -0800, Junio C Hamano wrote:
>
>> What the function does appears somewhat iffy in the modern world.
>> We are relying on the fact that while Git is operating in this mode
>> of reading a tuple of commits per line and doing log-tree, that Git
>> itself will not do the history traversal (instead, another instance
>> of Git that feeds us via our standard input is walking the history)
>> for this piece of code to work correctly.  
>> 
>> Of course, the "diff-tree --stdin" command was meant to sit on the
>> downstream of "rev-list --parents", so the assumption the code makes
>> (i.e. the parents field of the in-core commit objects do not have to
>> be usable for history traversal) may be reasonable, but still...
>
> I'm not sure it's that weird. "diff-tree" is about diffing, not
> traversal. The only reason it touches commit->parents at all (and
> doesn't just kick off a diff between the arguments it gets) is that it's
> been stuck with pretty-printing the commits, which might ask to show the
> parents.

Yeah, I understand all that as 45392a648d ("git-diff-tree --stdin:
show all parents.", 2006-02-05) was mostly mine.  It's just I sense
that the recent trend is to take whatever existing code and see if
they are reusable in other contexts, and this is one of the things
that people might want to libify, but cannot be as-is.
