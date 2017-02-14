Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91551FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 19:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbdBNTSk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 14:18:40 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34015 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753437AbdBNTSi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 14:18:38 -0500
Received: by mail-ot0-f196.google.com with SMTP id 73so18557645otj.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 11:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+TpJnSjQkwmO0/kVN+VGByr4wIrqI1JbIHuUwBMzRkk=;
        b=QspAk8coGWXR2Ab1agogwrnui4Bm0wYELl2B80Mbn+XvfYON0oTaxL9+8GMJLZElA7
         lKM3mUZxFNBnkFe9RrOH61D3OA6Zknw6xJYyGB+Xyajj1RPiT6er6i/Czf+YoIyhwYnQ
         lB5dtBFk4piZYaw6YsArv//iccsypfgjVPVue28MGYxcv7LX0wIVQ253tojzcnpq8RDo
         bDtk//rSLcPdoZOLQmnSBG679gvZZ0ctaJmlAlNPAdFlPspQZnw/WIY3m6IKIcc5o7+q
         oC0q2VyKB7rPmPm47RgKcS4efERNV6LpjEk8OZ+JfXmI4O5uJtCHCkmSWfzYyCXOTheQ
         pkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+TpJnSjQkwmO0/kVN+VGByr4wIrqI1JbIHuUwBMzRkk=;
        b=k4oXyrN484oF6+mR2dGuoUzlD5XrSAY5gm2h9Sf8S+PYeNun2bOUqXh0Y1yn1kJ0gJ
         NNGuKk3yxuyWz+KRJ+tVWAAMrDh12eky9TAzseTKZ07hd9sYudZNXvfzH5+fU0vdx6o3
         suS80nRq0gHUErJzp78Btv1/cO+ZlsRjZ8AXJVn9SBauLJKYuXl2kNFWQ9y3SBwAQnl7
         obWLUumhSyrB9DfYhUHLkiueEIWkfSger/lNncKPvTK8XetxUDfjUDuNdsE6BiwByviX
         odPsHpZQweZ/ZGyEEXToH3l2v3BgrDKbc96TPR6yAkVcv0MxzXaQOi+MZvswBtzkQgvw
         wOuA==
X-Gm-Message-State: AMke39l4UsBFUslPbgZZMfFr2GbSwPZcnwba8M6QZhKzZ4+jXm0pKg4q+YgYgmtArZdvJw==
X-Received: by 10.99.105.66 with SMTP id e63mr34334018pgc.104.1487099917823;
        Tue, 14 Feb 2017 11:18:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id z70sm2794373pff.26.2017.02.14.11.18.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 11:18:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 5/7] grep: fix "--" rev/pathspec disambiguation
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
        <20170214060555.yzh6hhi2t7pkeqvi@sigill.intra.peff.net>
Date:   Tue, 14 Feb 2017 11:18:36 -0800
In-Reply-To: <20170214060555.yzh6hhi2t7pkeqvi@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 14 Feb 2017 01:05:55 -0500")
Message-ID: <xmqqpoik8ttf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we see "git grep pattern rev -- file" then we apply the
> usual rev/pathspec disambiguation rules: any "rev" before
> the "--" must be a revision, and we do not need to apply the
> verify_non_filename() check.
>
> But there are two bugs here:
>
>   1. We keep a seen_dashdash flag to handle this case, but
>      we set it in the same left-to-right pass over the
>      arguments in which we parse "rev".
>
>      So when we see "rev", we do not yet know that there is
>      a "--", and we mistakenly complain if there is a
>      matching file.
>
>      We can fix this by making a preliminary pass over the
>      arguments to find the "--", and only then checking the rev
>      arguments.
>
>   2. If we can't resolve "rev" but there isn't a dashdash,
>      that's OK. We treat it like a path, and complain later
>      if it doesn't exist.
>
>      But if there _is_ a dashdash, then we know it must be a
>      rev, and should treat it as such, complaining if it
>      does not resolve. The current code instead ignores it
>      and tries to treat it like a path.
>
> This patch fixes both bugs, and tries to comment the parsing
> flow a bit better.

Good.  Thanks.
