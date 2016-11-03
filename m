Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DA2206FB
	for <e@80x24.org>; Thu,  3 Nov 2016 00:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbcKCAli (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 20:41:38 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33651 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbcKCAlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 20:41:37 -0400
Received: by mail-oi0-f51.google.com with SMTP id 128so50078336oih.0
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 17:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bburky.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U3/mQDaRoRn11WKtYcXHOniSkEu9UQOUkaLTpcv5bgg=;
        b=CyyQj7w1wm3rUaoZDv884X+Bo7D7q5L5cQGxtT8lG7WVPDbW+lISo8n884l9DNxP9u
         X37RUJjnPzjKeuGSxCQTq7bS14qda+tVBe5mo80LTAG5T2/d65nJJLPDn+PSuttZD6CU
         HdJEJIbc8SvT1unplHNzHuEVL30C6JQIBGde4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U3/mQDaRoRn11WKtYcXHOniSkEu9UQOUkaLTpcv5bgg=;
        b=UKqsSO1pdtDpoKB25qcK2ufKJ2XW8MnNBSkIdjkeR6nidlvF35tIE02YUMXKGan5U3
         UCRktnAQz9F0eMbB5UzvE+mcPH1Ta/TzixLKOA/yQWt61Qa/9Vyx993dA9xyLS5pDhDq
         6qSK/1tANnDUv980ymM1F8zbK5CBIzKsvZbtrI8e7Xj1XZSqAs8mobqK+E4UYpThAas3
         J9fOqh8yFs1jR04FObq+TbFNNc/LcTYTmtrtn6OMwJOl8tzqnsOjHBYlBhSWuRxHzAUm
         CtcwmlsHik2NmFSF0XQ0PPBLLFg9si8t8xd/+QU4WF7FR38Dwwdt0wXh/JxHZ14BKxka
         g9YA==
X-Gm-Message-State: ABUngveF061UpVwE+d6RIWYZpofJRcOcHFFbZyYhRTRgFm343pidkPDsDnmFqq+5XLajCCCwSBVA3CLohB4yvw==
X-Received: by 10.157.48.3 with SMTP id d3mr4568169otc.204.1478133696595; Wed,
 02 Nov 2016 17:41:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.186.132 with HTTP; Wed, 2 Nov 2016 17:41:16 -0700 (PDT)
In-Reply-To: <20161103002225.GA13369@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com> <20161103002225.GA13369@google.com>
From:   Blake Burkhart <bburky@bburky.com>
Date:   Wed, 2 Nov 2016 19:41:16 -0500
Message-ID: <CAP3OtXjrwqxPHGxdc7P_Dv+S9sWgtqE61jzQ8rVByphYC5D47g@mail.gmail.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for CCing me.

I haven't looked at this implementation in detail, but it would be
good to move this configuration into the config system because I think
we can more easily provide a default safe configuration.

It would be nice to use this to introduce a default list of
whitelisted protocols that even applies to `git clone`. I strongly
think we need to find a way to have git-remote-ext disabled by
default. This could be a way to do it.

On Wed, Nov 2, 2016 at 7:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> That reminds me: external tools also set GIT_ALLOW_PROTOCOL when the
> user hasn't set it explicitly, like git-submodule.sh does.  E.g.
> repo <https://gerrit.googlesource.com/git-repo/+/466b8c4e/git_command.py#171>,
> mercurial <https://www.mercurial-scm.org/repo/hg/file/b032a7b676c6/mercurial/subrepo.py#l1404>.
> Other external tools consume GIT_ALLOW_PROTOCOL, like 'go get'
> <https://go.googlesource.com/go/+/55620a0e/src/cmd/go/vcs.go#64>.
> Can we make it more convenient for them to support this configuration
> too?

Most of these are my fault too. I encouraged git-repo and mercurial to
use GIT_ALLOW_PROTOCOL to avoid security issues from git-remote-ext.

-- 
Blake Burkhart
