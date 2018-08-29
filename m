Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A0F1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeH3CgP (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:36:15 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55226 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeH3CgN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:36:13 -0400
Received: by mail-wm0-f47.google.com with SMTP id c14-v6so32460wmb.4
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 15:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=T1bx0QU2a/WFhAzFZoTSTDxgOnjgf+bzKeQ6dSWFG6o=;
        b=gpTMu/3rEaiWnqO7327xyvcyf6eK3Ae7LKHUp2E9ai5LeRaFsaUTC4pQmfYLyNgYhh
         jVbV0iA/FhwkN+IFtfRTRIyuaBjYpU+Hhotp8WzDJbfLfo/gipnz6Z4LD9yOUJfn1G/P
         48Apeh5t2cUiOvsgZnEXE9oLGB1FeCAL3ggNp1ZdAAE84wXr3PbpdFMgLogcxyYaVAK7
         Qvio5HvFvxlEZfYNlWrctAEburIz+wxli0mlu2An6FlwLBOVywWNtkNrrLAokm006cs8
         hNKtf+b30zlRbrXNrHUemtoCdUWbq3GgKDzQQOBCkvjKkAfFldTYqSC+TFuLqWrUZ6np
         KnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=T1bx0QU2a/WFhAzFZoTSTDxgOnjgf+bzKeQ6dSWFG6o=;
        b=bQUXfmeKslDk3lwx71j766dg5aTnMkeoD7f8unstvQWq5G9IIB56rm2NkPU9J75BjH
         lnG9yPM9rPam5W9qxqvkbKSINaRVEP3OCG18jRNuCRZvtHPjl8G+giRHOyj+Ci577zpy
         5oQaWFB8qYlqMMsyiKupOj14WSaVJrrQqohwZqiANL5VM5MVUHKl0GJfXHRpgOvp+CWV
         89vLvJlXba508e/09k9tjrzdRZ5KFtIw1DnETP8LCjS3pWuGnLLwheGRK7IEI9N9MbOw
         +FKKOWrhQRlMt0sQ+CguvT4PJbWyJ6PFkqVunjGFiWJlqQzP//h5pttqiQWyr9oBBlSB
         SFQA==
X-Gm-Message-State: APzg51AEBUVJ8pkHTw/cAOVyI9Y5MZUap1RWVdxf29BE6mOrp/J+EE26
        TFSCrn5MjvfXsIaygZ/vjyuI8GAT
X-Google-Smtp-Source: ANB0VdbUWa6nmX6IID/4/2OV09VTF0+AYdsanwI/57jIrxhdu43cS/2sSaL81zp1Dn5wKyqz/afjJw==
X-Received: by 2002:a1c:4887:: with SMTP id v129-v6mr15120wma.129.1535582229580;
        Wed, 29 Aug 2018 15:37:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o14-v6sm15701wmd.35.2018.08.29.15.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 15:37:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     git@vger.kernel.org, rpeterso@redhat.com
Subject: Re: [RFC] revision: Don't let ^<rev> cancel out the default <rev>
Date:   Wed, 29 Aug 2018 14:03:34 -0700
References: <20180829200553.19379-1-agruenba@redhat.com>
Message-ID: <xmqqin3s94vf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Gruenbacher <agruenba@redhat.com> writes:

> Some commands like 'log' default to HEAD if no other revisions are
> specified on the command line or otherwise.  Unfortunately, excludes
> (^<rev>) cancel out that default, so when a command only excludes
> revisions (e.g., 'git log ^origin/master'), the command will not produce
> any result.
>
> If all the specified revisions are excludes, it seems more useful to
> stick with the default revision instead.
>
> This makes writing wrappers that exclude certain revisions much easier:
> for example, a simple alias l='git log ^origin/master' will show the
> revisions between origin/master and HEAD by default, and 'l foo' will
> show the revisions between origin/master and foo, as you would usually
> expect.

That is a _huge_ departure from the behaviour established for the
past 10 years, but it would certainly be more useful.

As long as we can prove that that a command line with only negative
revs is absolutely useless, the backward incompatibility may be OK
to swallow, especially for commands like "git log" that implicitly
use "--default HEAD", as they are meant for human consumption, and
not for scripts.

I am not offhand 100% sure that a rev list with only negative revs
is totally useless, though.
