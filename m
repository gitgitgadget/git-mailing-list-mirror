Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C7C4332D
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D971422BEA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbhAHJVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbhAHJVV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 04:21:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303DBC0612F4
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 01:20:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b2so10533758edm.3
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 01:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6/PoaPqlCX1Zg0ePHd8vlj7wenXH11ODnsYnBDQVHJk=;
        b=I1Wezcs52l21HIod+RnVqPXhVPTGczzLPaQ/wVpMkb94J2Y5aU30I8nfLb7rEHdDPb
         ojAtpOyUUiJgwa5f9ETeVkYsAreeZJxbDqwgy9G5Njm535/EnzYXEGeTemqkpOsq5ZVv
         F2dsNVLdPvbv2tNgH4tD5CT2QFtm7TvTbqNX1BLObJZ4GnVo2umjZXAiKXLb/5tQgpJv
         e+hrl7wvzzzdHXTgnLQwMH2ovb4/wS53h4uEVIBIqwuq9w6b0DuVh0++WEP2JczO/RSZ
         UZm0ZGITcpuaoL9XvNZZreTeR32Pw68TgYo9KMl09/sutcyK15nOF73in04hqXZJkW84
         nmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6/PoaPqlCX1Zg0ePHd8vlj7wenXH11ODnsYnBDQVHJk=;
        b=IUssTzblxw2oIhwlGDGL0cX8oMfUeaWauJzE0vOJqx+zh7JLqjVCKyNh7dgoJL4xaQ
         pr6g1+NCl30kONwCVlAQTWZKAu2pVO4bAzC6ksG08ZaXqQyBJUVZE3+gSSEQegM6ij1k
         uFaSF4B1ftwoWpKlF9GGdQ/zcEeJbbvzsfOxV5/CmJMAHPo5YZUICE0JBjhdhOeVszIz
         2I50qcRqxzdrcagd1suaGTdS3azjgSKWfbPmv/OGJKzwV4QQxNu2t/xsyH+LVvLs/CqY
         feCG+VewNj//3Rq0QIH58+NzE20x8DygJyrKzvHsrgX/Clw9uik06LtZq46utFOfvaQa
         Vd3w==
X-Gm-Message-State: AOAM530uCKoyfE3e6OJ3yaNUkzggG0c01IndyqvYHXTfsSvxjVKs9J+e
        OrYka1Hqg4EDd0zdVIWzYSjr+0riUg4=
X-Google-Smtp-Source: ABdhPJwnASjpwWoXYZ3f2m+FTkWIXkLvKozUUc4G8mP1Fs9po/TkHaXw+1AXJaRfzzww/bgnAaw4ZA==
X-Received: by 2002:a50:b905:: with SMTP id m5mr4486354ede.292.1610097639947;
        Fri, 08 Jan 2021 01:20:39 -0800 (PST)
Received: from szeder.dev (84-236-109-79.pool.digikabel.hu. [84.236.109.79])
        by smtp.gmail.com with ESMTPSA id i13sm3556029edu.22.2021.01.08.01.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 01:20:39 -0800 (PST)
Date:   Fri, 8 Jan 2021 10:20:36 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7800-difftool: don't accidentally match tmp dirs
Message-ID: <20210108092036.GR8396@szeder.dev>
References: <20201224092431.13354-1-szeder.dev@gmail.com>
 <xmqq35zdnu1w.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq35zdnu1w.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 06, 2021 at 10:24:27PM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > index a578b35761..fe02fe1688 100755
> > --- a/t/t7800-difftool.sh
> > +++ b/t/t7800-difftool.sh
> > @@ -439,73 +439,104 @@ run_dir_diff_test () {
> >  }
> >  
> >  run_dir_diff_test 'difftool -d' '
> > +	cat >expect <<-\EOF &&
> > +	file
> > +	file2
> > +
> > +	file
> > +	file2
> > +	sub
> > +	EOF
> >  	git difftool -d $symlinks --extcmd ls branch >output &&
> > -	grep sub output &&
> > -	grep file output
> > +	grep -v ^/ output >actual &&
> 
> This unfortunately would not catch full paths on certain platforms.
> 
> See https://github.com/git/git/runs/1660588243?check_suite_focus=true#step:7:4186
> for an example X-<.

Hrm, one has to log in to view those CI logs?  Really?! :(

Anyway, I (apparently falsely) assumed that the output these tests
look at come from Git itself, and therefore we can rely on difftool's
temporary directories being normalized UNIX-style absolute paths...
But it seems they don't actually come from Git but from 'ls', because
that's what those '--extcmd ls' options do, and I now going to assume
that 'ls' prints those absolute paths with drive letter prefixes and
whatnot on Windows.

The initial version of this patch just tightened all potentially
problematic 'grep' patterns, e.g. 'grep ^sub$ output && grep ^file$
output'.  That should work on Windows as well, shouldn't it.  Will see
whether I can dig it out from the reflogs.

