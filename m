Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD98A20248
	for <e@80x24.org>; Thu, 14 Mar 2019 04:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfCNEFG (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 00:05:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52029 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfCNEFG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 00:05:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id n19so1388318wmi.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 21:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pCUxAwlt6YueqD5Mi1m2hOv3V2o6fXBlK7Nr/7GTHHk=;
        b=bRDLPp3j0avJIulUrt+j/M5p8co5/W1JsaD9WNWGMBIsAz8yAbw2/q2zY9vcqIq3bD
         J6dzo/5X6J/7xG9bFgjB/E3eXU6Orx4eAtapaZgmWxhplc/QZHVpIfbRangVvaoJjWCY
         RpAe3SZrRZDLnhJRdQoxgolfy3Apw0JBzVUzIgAKhZDuOCPBJipgMpHDDhE5GW1Ng4EP
         Jyt8GAvxUXmha8V1d+FvKJDNrkvdqrdpJvJ7xjArk1aYniQB2JzbuDBBg9nU2LYXRio/
         BCCKCIuMAjZ2eChbGiiIR1Xq5+brVEQOZVL5FbtzH5x84eYR8yG/rI5NpJP8B8+pVAl5
         xicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pCUxAwlt6YueqD5Mi1m2hOv3V2o6fXBlK7Nr/7GTHHk=;
        b=fLrOOSgz6Dgj5lqltcuV2uUd4wvTB5XMd/QuY5AimVz910DEQbPdOpel4zoFjUkact
         x9K8ITgXd1zkR38oZdrqCJ+t4Aq1vjdUzOeporI5Dh0oVcq1oAk39jqjYjzL+JUT6ikK
         jjbe8CxLdrClu16Ig/83KTRGIbFadz2FHl7+X7S43UJIxIvGzrEYbtjOdvaupRT5DrOx
         Rg5K6WERAdlNvr4nIAhjV6XIPLWAe2q7KHovAmIgCUNjbO4rv4b4DPNZsw+Dk/+9eOmc
         WLXRMvl+ABAY7+op7JSOOzrIJ8j2ZvrVvPEq/VUrBHi1DDLzaB9c7qE0F5AaYsGqt+Z0
         SXpA==
X-Gm-Message-State: APjAAAWVu219DDZIu0pYPoJKjCpnvVVxsqiJP9FzZlew8yiPJMQftLT4
        3cddGvDyBCXe/UyR41roF8I=
X-Google-Smtp-Source: APXvYqycqA/wsL1UxvnoNZKSLUV4k9WSHZw1vKP1JSA+0rPoyzZ/wH9E0J5vCpA+MzIwT77eITEaSw==
X-Received: by 2002:a7b:cd03:: with SMTP id f3mr891909wmj.130.1552536304596;
        Wed, 13 Mar 2019 21:05:04 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c10sm16367420wrr.1.2019.03.13.21.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 21:05:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] get_oid(): when an object was not found, try harder
References: <pull.161.git.gitgitgadget@gmail.com>
        <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com>
        <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com>
        <20190314022245.GA1414@sigill.intra.peff.net>
        <20190314024023.GA3889@sigill.intra.peff.net>
Date:   Thu, 14 Mar 2019 13:05:03 +0900
In-Reply-To: <20190314024023.GA3889@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 13 Mar 2019 22:40:23 -0400")
Message-ID: <xmqqzhpy9k40.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure it's really worth addressing (just because I don't think
> there's a good way to do it that isn't expensive).

I do not think so, either.  Not at this layer, anyway.

If a "-x" command newly created an object whose prefix makes it
ambiguous against an existing object, we would not notice, unless we
refresh the loose object cache, that we now have two objects that
share the prefix.  And we will find an object (the older one) with
the prefix in the stale cache without hitting "oh we do not find it,
let's retry" codepath.  So to solve both sides of the coin, we'd
need invalidation either way, which obviously defeats the whole
caching concept, doesn't it?

But when we know we are running things like interactive rebase with
"-x" that (1) creates new objects while we are waiting for that
process to finish and (2) not performance critical, the loop that
drives these steps can flush any cache after seeing an external
process to return control to us.  Such an approach would still not
solve the issue a totally unrelated "repack" process creates by
mucking with the object database behind our back, but at least the
damage to the code is much better isolated ;-)




